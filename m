Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3951EE909D0
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNk2-00020y-ON; Tue, 17 Feb 2026 11:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNk1-0001pv-DT
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:16:01 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNjy-0003D0-T8
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:16:01 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B6BF33E6C2;
 Tue, 17 Feb 2026 16:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RvjkXicWg7mcQymLhYRs9gixGffnoQaRnIA4ig3ETSo=;
 b=NKfTG4isU4LCcCmE3weNC+a7mcbPf8BXZn2QH2P579g1s1OP3GIPMH4K/XW8QT2hniUcP3
 vnVYz9IjJzBwNAJKAqPD26GoE7wXz7dkORqEf6AEFsWtFZWx4FNSQfSmxYCJupvHWo3iNB
 Oa2nMcdkyBj87/sA51MvoliBBb56wN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RvjkXicWg7mcQymLhYRs9gixGffnoQaRnIA4ig3ETSo=;
 b=86RscKz5J+ZKXV99bPmzVLPiD1tiOJGMXkMpfMiK1XWlqxTythKWTFgiE6qT/usl4Dk64g
 b05ClKSDte1ouGAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NKfTG4is;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=86RscKz5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RvjkXicWg7mcQymLhYRs9gixGffnoQaRnIA4ig3ETSo=;
 b=NKfTG4isU4LCcCmE3weNC+a7mcbPf8BXZn2QH2P579g1s1OP3GIPMH4K/XW8QT2hniUcP3
 vnVYz9IjJzBwNAJKAqPD26GoE7wXz7dkORqEf6AEFsWtFZWx4FNSQfSmxYCJupvHWo3iNB
 Oa2nMcdkyBj87/sA51MvoliBBb56wN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RvjkXicWg7mcQymLhYRs9gixGffnoQaRnIA4ig3ETSo=;
 b=86RscKz5J+ZKXV99bPmzVLPiD1tiOJGMXkMpfMiK1XWlqxTythKWTFgiE6qT/usl4Dk64g
 b05ClKSDte1ouGAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DB023EA66;
 Tue, 17 Feb 2026 16:15:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6AfDEBqUlGmHTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 16:15:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 21/32] migration: Provide helper for save vm description
Date: Tue, 17 Feb 2026 13:14:32 -0300
Message-ID: <20260217161443.12738-22-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217161443.12738-1-farosas@suse.de>
References: <20260217161443.12738-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,web.de]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 R_RATELIMIT(0.00)[to_ip_from(RLi3368pnyb3ujpcs6u1hud8b3)];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCPT_COUNT_THREE(0.00)[3]; FREEMAIL_ENVRCPT(0.00)[web.de]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B6BF33E6C2
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

Provide two smaller helpers to dump the vm desc.  Preparing to move it out
and generalize device state dump.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>
Link: https://lore.kernel.org/qemu-devel/20260127185254.3954634-16-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/savevm.c | 35 +++++++++++++++++++++++------------
 migration/savevm.h |  1 +
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index a787691352..41560b97a4 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1669,13 +1669,34 @@ ret_fail_abort_threads:
     return -1;
 }
 
+static void qemu_savevm_state_vm_desc(MigrationState *s, QEMUFile *f)
+{
+    JSONWriter *vmdesc = s->vmdesc;
+    int vmdesc_len;
+
+    if (vmdesc) {
+        json_writer_end_array(vmdesc);
+        json_writer_end_object(vmdesc);
+        vmdesc_len = strlen(json_writer_get(vmdesc));
+
+        qemu_put_byte(f, QEMU_VM_VMDESCRIPTION);
+        qemu_put_be32(f, vmdesc_len);
+        qemu_put_buffer(f, (uint8_t *)json_writer_get(vmdesc), vmdesc_len);
+    }
+}
+
+void qemu_savevm_state_end_precopy(MigrationState *s, QEMUFile *f)
+{
+    qemu_savevm_state_end(f);
+    qemu_savevm_state_vm_desc(s, f);
+}
+
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
                                                     bool in_postcopy)
 {
     MigrationState *ms = migrate_get_current();
     int64_t start_ts_each, end_ts_each;
     JSONWriter *vmdesc = ms->vmdesc;
-    int vmdesc_len;
     SaveStateEntry *se;
     Error *local_err = NULL;
     int ret;
@@ -1705,17 +1726,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
 
     if (!in_postcopy) {
         /* Postcopy stream will still be going */
-        qemu_savevm_state_end(f);
-
-        if (vmdesc) {
-            json_writer_end_array(vmdesc);
-            json_writer_end_object(vmdesc);
-            vmdesc_len = strlen(json_writer_get(vmdesc));
-
-            qemu_put_byte(f, QEMU_VM_VMDESCRIPTION);
-            qemu_put_be32(f, vmdesc_len);
-            qemu_put_buffer(f, (uint8_t *)json_writer_get(vmdesc), vmdesc_len);
-        }
+        qemu_savevm_state_end_precopy(ms, f);
     }
 
     trace_vmstate_downtime_checkpoint("src-non-iterable-saved");
diff --git a/migration/savevm.h b/migration/savevm.h
index d0596d1d62..f957f851ef 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -50,6 +50,7 @@ void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
 bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
 void qemu_savevm_state_end(QEMUFile *f);
+void qemu_savevm_state_end_precopy(MigrationState *s, QEMUFile *f);
 void qemu_savevm_send_ping(QEMUFile *f, uint32_t value);
 void qemu_savevm_send_open_return_path(QEMUFile *f);
 int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len);
-- 
2.51.0


