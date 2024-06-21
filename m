Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB86BC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKiTv-0003tn-UI; Fri, 21 Jun 2024 13:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTt-0003gk-Az
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:55:25 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTq-0003d1-Qz
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:55:24 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9DB2621B37;
 Fri, 21 Jun 2024 17:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=em0feHkBfRn3xT6Jmq/15z88Iy4x3quX1jEyjvPUW1A=;
 b=IAJeIIm9d97q5ABOBeRFa6L3iyQ4eLsNACfc2eRgRnzG2Jxj0mYbHvoFa5TYFKMbXXSClO
 J/2WBt7Z9D3gNybJBTMa+79T/RnoUtuWQX3eRTaMRDAXUnxAIwG/b2sTfdscZWB2PzTMfL
 3LOb42eIfQlqUwoVTBo23iUpV5x3NEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992521;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=em0feHkBfRn3xT6Jmq/15z88Iy4x3quX1jEyjvPUW1A=;
 b=+udtzZgfKCSLmg9m0+tgNIWwxouPAhtXsvLv2KMJQNAWmbZODGIXaCNrie+6OuShHJ094g
 HetJMqSwcEEgRhBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=em0feHkBfRn3xT6Jmq/15z88Iy4x3quX1jEyjvPUW1A=;
 b=IAJeIIm9d97q5ABOBeRFa6L3iyQ4eLsNACfc2eRgRnzG2Jxj0mYbHvoFa5TYFKMbXXSClO
 J/2WBt7Z9D3gNybJBTMa+79T/RnoUtuWQX3eRTaMRDAXUnxAIwG/b2sTfdscZWB2PzTMfL
 3LOb42eIfQlqUwoVTBo23iUpV5x3NEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992521;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=em0feHkBfRn3xT6Jmq/15z88Iy4x3quX1jEyjvPUW1A=;
 b=+udtzZgfKCSLmg9m0+tgNIWwxouPAhtXsvLv2KMJQNAWmbZODGIXaCNrie+6OuShHJ094g
 HetJMqSwcEEgRhBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 723A513AAA;
 Fri, 21 Jun 2024 17:55:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CP8hDoi+dWZNawAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Jun 2024 17:55:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 25/28] tests/migration-tests: migration_event_wait()
Date: Fri, 21 Jun 2024 14:54:31 -0300
Message-Id: <20240621175434.31180-26-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240621175434.31180-1-farosas@suse.de>
References: <20240621175434.31180-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

From: Peter Xu <peterx@redhat.com>

Introduce a small helper to wait for a migration event, generalized from
the incoming migration path.  Make the helper easier to use by allowing it
to keep waiting until the expected event is received.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 31 ++++++++++++++++++++++---------
 tests/qtest/migration-helpers.h |  2 ++
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 2ca4425d71..84f49db85e 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -249,7 +249,7 @@ void migrate_set_capability(QTestState *who, const char *capability,
 void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
 {
     va_list ap;
-    QDict *args, *rsp, *data;
+    QDict *args, *rsp;
 
     va_start(ap, fmt);
     args = qdict_from_vjsonf_nofail(fmt, ap);
@@ -272,14 +272,7 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
     g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
 
-    rsp = qtest_qmp_eventwait_ref(to, "MIGRATION");
-    g_assert(qdict_haskey(rsp, "data"));
-
-    data = qdict_get_qdict(rsp, "data");
-    g_assert(qdict_haskey(data, "status"));
-    g_assert_cmpstr(qdict_get_str(data, "status"), ==, "setup");
-
-    qobject_unref(rsp);
+    migration_event_wait(to, "setup");
 }
 
 /*
@@ -518,3 +511,23 @@ bool probe_o_direct_support(const char *tmpfs)
     return true;
 }
 #endif
+
+/*
+ * Wait for a "MIGRATION" event.  This is what Libvirt uses to track
+ * migration status changes.
+ */
+void migration_event_wait(QTestState *s, const char *target)
+{
+    QDict *response, *data;
+    const char *status;
+    bool found;
+
+    do {
+        response = qtest_qmp_eventwait_ref(s, "MIGRATION");
+        data = qdict_get_qdict(response, "data");
+        g_assert(data);
+        status = qdict_get_str(data, "status");
+        found = (strcmp(status, target) == 0);
+        qobject_unref(response);
+    } while (!found);
+}
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 50095fca4a..72dba369fb 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -63,4 +63,6 @@ static inline bool probe_o_direct_support(const char *tmpfs)
 }
 #endif
 void migration_test_add(const char *path, void (*fn)(void));
+void migration_event_wait(QTestState *s, const char *target);
+
 #endif /* MIGRATION_HELPERS_H */
-- 
2.35.3


