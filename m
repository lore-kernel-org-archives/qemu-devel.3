Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC2BC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 17:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teznf-0006Dw-Tz; Mon, 03 Feb 2025 11:59:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1teznf-0006Dg-4T
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:59:55 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1teznd-0001Od-IW
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:59:54 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CFD781F381;
 Mon,  3 Feb 2025 16:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738601991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7fBhyOPw+uV+tDm35m3Dodwm2GOVrzdUMocvY919AmQ=;
 b=hXmTMvRyd87zkpwvv5UV5Vu/LFzmrFgGw42mKDguszhWk8ffZ6QzJzV6UA5tK44Wz5drRG
 +w/0QpXB0zWvXs4QuBxcivLBjLY9DPJL13NTcecLHxuC1Fvi35tAKx9GXc4mnk45YOQqeW
 GdyeVmt4CyfvP7c5AAUEhxEE6Gt1Yrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738601991;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7fBhyOPw+uV+tDm35m3Dodwm2GOVrzdUMocvY919AmQ=;
 b=UsFXYXz8rdGE5CkpbbyE8MS2YommWyT5mA8I3jayTIrs7/ryvwJ2ijOcu1B8cTBv1HdPWe
 s9tpnH5pW+arqcDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738601991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7fBhyOPw+uV+tDm35m3Dodwm2GOVrzdUMocvY919AmQ=;
 b=hXmTMvRyd87zkpwvv5UV5Vu/LFzmrFgGw42mKDguszhWk8ffZ6QzJzV6UA5tK44Wz5drRG
 +w/0QpXB0zWvXs4QuBxcivLBjLY9DPJL13NTcecLHxuC1Fvi35tAKx9GXc4mnk45YOQqeW
 GdyeVmt4CyfvP7c5AAUEhxEE6Gt1Yrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738601991;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7fBhyOPw+uV+tDm35m3Dodwm2GOVrzdUMocvY919AmQ=;
 b=UsFXYXz8rdGE5CkpbbyE8MS2YommWyT5mA8I3jayTIrs7/ryvwJ2ijOcu1B8cTBv1HdPWe
 s9tpnH5pW+arqcDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29E5D13A78;
 Mon,  3 Feb 2025 16:59:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mDNJNgX2oGfDdgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 03 Feb 2025 16:59:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 5/6] tests/qtest: Make qtest_has_accel() generic
Date: Mon,  3 Feb 2025 13:59:37 -0300
Message-Id: <20250203165938.14320-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250203165938.14320-1-farosas@suse.de>
References: <20250203165938.14320-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since commit b14a0b7469f ("accel: Use QOM classes for accel types")
accelerators are registered as QOM objects. Use QOM as a generic
API to query for available accelerators. This is in particular
useful to query hardware accelerators such HFV, Xen or WHPX which
otherwise have their definitions poisoned in "exec/poison.h".

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250130103728.536-3-philmd@linaro.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index f416cf8a59..fe8606ba6a 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -30,6 +30,7 @@
 
 #include "libqtest.h"
 #include "libqmp.h"
+#include "qemu/accel.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/sockets.h"
@@ -1063,13 +1064,10 @@ static bool qtest_qom_has_concrete_type(const char *parent_typename,
 
 bool qtest_has_accel(const char *accel_name)
 {
-    if (g_str_equal(accel_name, "tcg")) {
-#if defined(CONFIG_TCG)
-        return true;
-#else
-        return false;
-#endif
-    } else if (g_str_equal(accel_name, "kvm")) {
+    static QList *list;
+    g_autofree char *accel_type = NULL;
+
+    if (g_str_equal(accel_name, "kvm")) {
         int i;
         const char *arch = qtest_get_arch();
         const char *targets[] = { CONFIG_KVM_TARGETS };
@@ -1081,11 +1079,12 @@ bool qtest_has_accel(const char *accel_name)
                 }
             }
         }
-    } else {
-        /* not implemented */
-        g_assert_not_reached();
+        return false;
     }
-    return false;
+
+    accel_type = g_strconcat(accel_name, ACCEL_CLASS_SUFFIX, NULL);
+
+    return qtest_qom_has_concrete_type("accel", accel_type, &list);
 }
 
 bool qtest_get_irq(QTestState *s, int num)
-- 
2.35.3


