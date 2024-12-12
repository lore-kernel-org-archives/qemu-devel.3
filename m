Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D622EE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkpI-0003sW-Rb; Thu, 12 Dec 2024 10:10:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpG-0003pw-HL
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:02 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpE-0002z4-Je
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:02 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7A87221137;
 Thu, 12 Dec 2024 15:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZyY8AA8dfYgg8xgEH5Ccjm5JgvsAKqt9DjcNW2EPL/g=;
 b=1xpeuBMSJLec34SUTyRKGzJkvbIS9jIpcC5UknIIrt07MzmohNnrMed5ag37FSLqQwnwd6
 7IF8TTdZjOvSgLwwu7vdQsqy9ESb6ihIYj6zfV82pRjk6J2aekDZ+DYoOC2sP5VUx9bl8B
 8AK+0jkYhEQMXOtfmtlCzXk53niDMvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016199;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZyY8AA8dfYgg8xgEH5Ccjm5JgvsAKqt9DjcNW2EPL/g=;
 b=UEM8APgO/nARzWzYZfM7CwyERLdt15YGly79N5sQUzS9zwNwC48L0NYfUQXVJ7XPUKkPe6
 Eanb9lPmzGqV7hBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZyY8AA8dfYgg8xgEH5Ccjm5JgvsAKqt9DjcNW2EPL/g=;
 b=1xpeuBMSJLec34SUTyRKGzJkvbIS9jIpcC5UknIIrt07MzmohNnrMed5ag37FSLqQwnwd6
 7IF8TTdZjOvSgLwwu7vdQsqy9ESb6ihIYj6zfV82pRjk6J2aekDZ+DYoOC2sP5VUx9bl8B
 8AK+0jkYhEQMXOtfmtlCzXk53niDMvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016199;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZyY8AA8dfYgg8xgEH5Ccjm5JgvsAKqt9DjcNW2EPL/g=;
 b=UEM8APgO/nARzWzYZfM7CwyERLdt15YGly79N5sQUzS9zwNwC48L0NYfUQXVJ7XPUKkPe6
 Eanb9lPmzGqV7hBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8663C13508;
 Thu, 12 Dec 2024 15:09:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QAcPE8b8WmcTfQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Dec 2024 15:09:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 04/22] tests/qtest: Use qtest_system_reset_nowait() where
 appropriate
Date: Thu, 12 Dec 2024 12:09:31 -0300
Message-Id: <20241212150949.16806-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241212150949.16806-1-farosas@suse.de>
References: <20241212150949.16806-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,linaro.org:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

In the device and drive plug/unplug tests we want to trigger
a system reset and then see if we get the appropriate
DEVICE_DELETED event. Use qtest_system_reset_nowait() here.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/device-plug-test.c | 11 +----------
 tests/qtest/drive_del-test.c   |  7 +------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/tests/qtest/device-plug-test.c b/tests/qtest/device-plug-test.c
index c6f33153eb..127a7f9efe 100644
--- a/tests/qtest/device-plug-test.c
+++ b/tests/qtest/device-plug-test.c
@@ -15,15 +15,6 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 
-static void system_reset(QTestState *qtest)
-{
-    QDict *resp;
-
-    resp = qtest_qmp(qtest, "{'execute': 'system_reset'}");
-    g_assert(qdict_haskey(resp, "return"));
-    qobject_unref(resp);
-}
-
 static void wait_device_deleted_event(QTestState *qtest, const char *id)
 {
     QDict *resp, *data;
@@ -58,7 +49,7 @@ static void process_device_remove(QTestState *qtest, const char *id)
      * handled, removing the device.
      */
     qtest_qmp_device_del_send(qtest, id);
-    system_reset(qtest);
+    qtest_system_reset_nowait(qtest);
     wait_device_deleted_event(qtest, id);
 }
 
diff --git a/tests/qtest/drive_del-test.c b/tests/qtest/drive_del-test.c
index 7b67a4bbee..99f6fc2de1 100644
--- a/tests/qtest/drive_del-test.c
+++ b/tests/qtest/drive_del-test.c
@@ -154,15 +154,10 @@ static void device_add(QTestState *qts)
 
 static void device_del(QTestState *qts, bool and_reset)
 {
-    QDict *response;
-
     qtest_qmp_device_del_send(qts, "dev0");
 
     if (and_reset) {
-        response = qtest_qmp(qts, "{'execute': 'system_reset' }");
-        g_assert(response);
-        g_assert(qdict_haskey(response, "return"));
-        qobject_unref(response);
+        qtest_system_reset_nowait(qts);
     }
 
     qtest_qmp_eventwait(qts, "DEVICE_DELETED");
-- 
2.35.3


