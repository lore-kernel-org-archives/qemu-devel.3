Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980FEC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEUr-0005FK-Ss; Fri, 11 Jul 2025 10:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaET8-0001N1-WA
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:19 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaET0-0006e3-7B
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:12 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C3EE3211A0;
 Fri, 11 Jul 2025 14:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VRaYifWhkJOcWBKaUF8iE1A2dKiwWY17wzieTwSmTFA=;
 b=AWXYLsX0ahCWYGNpNRMGrvYsiXeH7Kn2NLogsLc3Tmdlk6RoubCBkGTIV1sYcd/1fVNTpy
 U2lMHJQvEHd0JiAi7CrERxYprxWlu7C5rJrsjjVno6VdSFH1HKFhsXZ5EQIaNf1D8Aa4PQ
 QbxotNBSFsu3np6mZQhRQVQTtaMZ5HE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VRaYifWhkJOcWBKaUF8iE1A2dKiwWY17wzieTwSmTFA=;
 b=ZblZV7MSJ6ofZt9MEsBx+Yoh41iK/0G/D21gWUjuJthed2XucuQSj/GDhWrP3ksgbIt48i
 ZyQKHbkC7xB34YCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AWXYLsX0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZblZV7MS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VRaYifWhkJOcWBKaUF8iE1A2dKiwWY17wzieTwSmTFA=;
 b=AWXYLsX0ahCWYGNpNRMGrvYsiXeH7Kn2NLogsLc3Tmdlk6RoubCBkGTIV1sYcd/1fVNTpy
 U2lMHJQvEHd0JiAi7CrERxYprxWlu7C5rJrsjjVno6VdSFH1HKFhsXZ5EQIaNf1D8Aa4PQ
 QbxotNBSFsu3np6mZQhRQVQTtaMZ5HE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VRaYifWhkJOcWBKaUF8iE1A2dKiwWY17wzieTwSmTFA=;
 b=ZblZV7MSJ6ofZt9MEsBx+Yoh41iK/0G/D21gWUjuJthed2XucuQSj/GDhWrP3ksgbIt48i
 ZyQKHbkC7xB34YCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 696B41388B;
 Fri, 11 Jul 2025 14:10:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YDbiCWkbcWg7TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Jul 2025 14:10:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 07/26] migration: qemu_savevm_complete*() helpers
Date: Fri, 11 Jul 2025 11:10:12 -0300
Message-Id: <20250711141031.423-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250711141031.423-1-farosas@suse.de>
References: <20250711141031.423-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: C3EE3211A0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Since we use the same save_complete() hook for both precopy and postcopy,
add a set of helpers to invoke the hook() to dedup the code.

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250613140801.474264-8-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/savevm.c | 78 ++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 454e914b56..c4fd5f5a5b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1484,6 +1484,38 @@ bool should_send_vmdesc(void)
     return !machine->suppress_vmdesc;
 }
 
+static bool qemu_savevm_complete_exists(SaveStateEntry *se)
+{
+    return se->ops && se->ops->save_complete;
+}
+
+/*
+ * Invoke the ->save_complete() if necessary.
+ * Returns: 0 if skip the current SE or succeeded, <0 if error happened.
+ */
+static int qemu_savevm_complete(SaveStateEntry *se, QEMUFile *f)
+{
+    int ret;
+
+    if (se->ops->is_active) {
+        if (!se->ops->is_active(se->opaque)) {
+            return 0;
+        }
+    }
+
+    trace_savevm_section_start(se->idstr, se->section_id);
+    save_section_header(f, se, QEMU_VM_SECTION_END);
+    ret = se->ops->save_complete(f, se->opaque);
+    trace_savevm_section_end(se->idstr, se->section_id, ret);
+    save_section_footer(f, se);
+
+    if (ret < 0) {
+        qemu_file_set_error(f, ret);
+    }
+
+    return ret;
+}
+
 /*
  * Complete saving any postcopy-able devices.
  *
@@ -1493,27 +1525,13 @@ bool should_send_vmdesc(void)
 void qemu_savevm_state_complete_postcopy(QEMUFile *f)
 {
     SaveStateEntry *se;
-    int ret;
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (!se->ops || !se->ops->save_complete) {
+        if (!qemu_savevm_complete_exists(se)) {
             continue;
         }
-        if (se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
-                continue;
-            }
-        }
-        trace_savevm_section_start(se->idstr, se->section_id);
-        /* Section type */
-        qemu_put_byte(f, QEMU_VM_SECTION_END);
-        qemu_put_be32(f, se->section_id);
 
-        ret = se->ops->save_complete(f, se->opaque);
-        trace_savevm_section_end(se->idstr, se->section_id, ret);
-        save_section_footer(f, se);
-        if (ret < 0) {
-            qemu_file_set_error(f, ret);
+        if (qemu_savevm_complete(se, f) < 0) {
             return;
         }
     }
@@ -1559,7 +1577,6 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
 {
     int64_t start_ts_each, end_ts_each;
     SaveStateEntry *se;
-    int ret;
     bool multifd_device_state = multifd_device_state_supported();
 
     if (multifd_device_state) {
@@ -1580,32 +1597,25 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
     }
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (!se->ops ||
-            (in_postcopy && se->ops->has_postcopy &&
-             se->ops->has_postcopy(se->opaque)) ||
-            !se->ops->save_complete) {
+        if (!qemu_savevm_complete_exists(se)) {
             continue;
         }
 
-        if (se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
-                continue;
-            }
+        if (in_postcopy && se->ops->has_postcopy &&
+            se->ops->has_postcopy(se->opaque)) {
+            /*
+             * If postcopy will start soon, and if the SE supports
+             * postcopy, then we can skip the SE for the postcopy phase.
+             */
+            continue;
         }
 
         start_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
-        trace_savevm_section_start(se->idstr, se->section_id);
-
-        save_section_header(f, se, QEMU_VM_SECTION_END);
-
-        ret = se->ops->save_complete(f, se->opaque);
-        trace_savevm_section_end(se->idstr, se->section_id, ret);
-        save_section_footer(f, se);
-        if (ret < 0) {
-            qemu_file_set_error(f, ret);
+        if (qemu_savevm_complete(se, f) < 0) {
             goto ret_fail_abort_threads;
         }
         end_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
+
         trace_vmstate_downtime_save("iterable", se->idstr, se->instance_id,
                                     end_ts_each - start_ts_each);
     }
-- 
2.35.3


