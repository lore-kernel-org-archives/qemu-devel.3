Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E6FE909D4
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNjL-00019i-7Q; Tue, 17 Feb 2026 11:15:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNjJ-00019Y-7g
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:17 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNjH-00037s-CD
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:16 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9A4A83E725;
 Tue, 17 Feb 2026 16:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tt6xtbA2n5hWWtncehHc/xG3dXOV3D/lx4LNtYgrSGg=;
 b=yfaYFCiTWWiEuIJ2K/fLCQY8nnG53jMvH8BHHS6IbdBmLibHq5/ppJdvhcO7cIVpTopwwl
 bAVLSIrcoPCzbg55+inn4xsc2XD5KDjlbImVMCn9rb+UAIezoLhBp9AY9hncydFU5k4S/7
 4dO8y6vfQ+IXW0YUousjb81Oe61Y1bY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344899;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tt6xtbA2n5hWWtncehHc/xG3dXOV3D/lx4LNtYgrSGg=;
 b=GBD+PKgsMwqDHBX6xHGmwK0W8BWegj7Nee3jUl+QxigtVqQrRVA7SidcKcKQBTSEZ3eRYw
 35lEh7BeFmF32VDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yfaYFCiT;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GBD+PKgs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tt6xtbA2n5hWWtncehHc/xG3dXOV3D/lx4LNtYgrSGg=;
 b=yfaYFCiTWWiEuIJ2K/fLCQY8nnG53jMvH8BHHS6IbdBmLibHq5/ppJdvhcO7cIVpTopwwl
 bAVLSIrcoPCzbg55+inn4xsc2XD5KDjlbImVMCn9rb+UAIezoLhBp9AY9hncydFU5k4S/7
 4dO8y6vfQ+IXW0YUousjb81Oe61Y1bY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344899;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tt6xtbA2n5hWWtncehHc/xG3dXOV3D/lx4LNtYgrSGg=;
 b=GBD+PKgsMwqDHBX6xHGmwK0W8BWegj7Nee3jUl+QxigtVqQrRVA7SidcKcKQBTSEZ3eRYw
 35lEh7BeFmF32VDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 615E13EA66;
 Tue, 17 Feb 2026 16:14:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GOnbCQKUlGmHTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 16:14:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 07/32] migration: Introduce qemu_savevm_send_* helpers
Date: Tue, 17 Feb 2026 13:14:18 -0300
Message-ID: <20260217161443.12738-8-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217161443.12738-1-farosas@suse.de>
References: <20260217161443.12738-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[redhat.com,web.de]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; FREEMAIL_ENVRCPT(0.00)[web.de]
X-Rspamd-Queue-Id: 9A4A83E725
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Split qemu_savevm_state_header() into two parts.   This paves way for a
reuse elsewhere.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
Tested-by: Lukas Straub <lukasstraub2@web.de>
Link: https://lore.kernel.org/qemu-devel/20260127185254.3954634-2-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/savevm.c | 62 +++++++++++++++++++++++++++-------------------
 migration/savevm.h |  1 +
 2 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 3dc812a7bb..e26656cca3 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1282,38 +1282,48 @@ void qemu_savevm_non_migratable_list(strList **reasons)
     }
 }
 
-void qemu_savevm_state_header(QEMUFile *f)
+void qemu_savevm_send_header(QEMUFile *f)
 {
-    MigrationState *s = migrate_get_current();
-    JSONWriter *vmdesc = s->vmdesc;
-    Error *local_err = NULL;
-
     trace_savevm_state_header();
     qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
     qemu_put_be32(f, QEMU_VM_FILE_VERSION);
+}
 
+static void qemu_savevm_send_configuration(MigrationState *s, QEMUFile *f)
+{
+    JSONWriter *vmdesc = s->vmdesc;
+    Error *local_err = NULL;
+
+    qemu_put_byte(f, QEMU_VM_CONFIGURATION);
+
+    if (vmdesc) {
+        /*
+         * This starts the main json object and is paired with the
+         * json_writer_end_object in
+         * qemu_savevm_state_complete_precopy_non_iterable
+         */
+        json_writer_start_object(vmdesc, NULL);
+        json_writer_start_object(vmdesc, "configuration");
+    }
+
+    vmstate_save_state(f, &vmstate_configuration, &savevm_state,
+                       vmdesc, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+    }
+
+    if (vmdesc) {
+        json_writer_end_object(vmdesc);
+    }
+}
+
+void qemu_savevm_state_header(QEMUFile *f)
+{
+    MigrationState *s = migrate_get_current();
+
+    qemu_savevm_send_header(f);
     if (s->send_configuration) {
-        qemu_put_byte(f, QEMU_VM_CONFIGURATION);
-
-        if (vmdesc) {
-            /*
-             * This starts the main json object and is paired with the
-             * json_writer_end_object in
-             * qemu_savevm_state_complete_precopy_non_iterable
-             */
-            json_writer_start_object(vmdesc, NULL);
-            json_writer_start_object(vmdesc, "configuration");
-        }
-
-        vmstate_save_state(f, &vmstate_configuration, &savevm_state,
-                           vmdesc, &local_err);
-        if (local_err) {
-            error_report_err(local_err);
-        }
-
-        if (vmdesc) {
-            json_writer_end_object(vmdesc);
-        }
+        qemu_savevm_send_configuration(s, f);
     }
 }
 
diff --git a/migration/savevm.h b/migration/savevm.h
index 125a2507b7..5d815af742 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -37,6 +37,7 @@ int qemu_savevm_state_prepare(Error **errp);
 int qemu_savevm_state_setup(QEMUFile *f, Error **errp);
 bool qemu_savevm_state_guest_unplug_pending(void);
 int qemu_savevm_state_resume_prepare(MigrationState *s);
+void qemu_savevm_send_header(QEMUFile *f);
 void qemu_savevm_state_header(QEMUFile *f);
 int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
 void qemu_savevm_state_cleanup(void);
-- 
2.51.0


