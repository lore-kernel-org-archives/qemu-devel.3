Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4F7C9832A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA82R-0006iL-O3; Fri, 25 Sep 2026 11:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82Q-0006i5-Ue
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:39 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82P-0004cK-4i
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:38 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C5D471F44E;
 Fri, 25 Sep 2026 15:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yS5g+M/ArDhr1b73HQeW3DJeLuz8kjkGkzHV5VYgDKA=;
 b=d1KRisbTKwbepLKQg5dm1dLo+Nn3MRZkKBCQW1sfpJd98oNYN+PKCwY+wd28cP/m6e3r6L
 rh6EiE9UlsEn6spITmxf+7cd9STucYIu+ooHozE8uAYrwmIWo09YFMllHzHMwLaETKwi3Q
 w6l+NL4fU1GNjVynABLLe1X1BgkX0uY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yS5g+M/ArDhr1b73HQeW3DJeLuz8kjkGkzHV5VYgDKA=;
 b=4/8hiFrvnOypwBWUY+rndmry8zrIsN/Jx07OFH+SUVJYsWubohfEozn7Z2bMmaX7I4kWPX
 VhxIy8UwJ9KPMxDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yS5g+M/ArDhr1b73HQeW3DJeLuz8kjkGkzHV5VYgDKA=;
 b=BFlzmU5ZnVqJfcRt16Ho/l+JCzV7mXFosNfBG3OH6md7eQ7wI3dhuAGeZi3l9cRU1Xz1sr
 j1ti3wfDnKb/ugTlIFpaeVqZ0lH0hNhPB8ku9xW75gFefOUKwqhj21u/kvc4KqvAjXQePm
 DRtSReMn1L4if+v15kyYPzx0xOLlVg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350827;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yS5g+M/ArDhr1b73HQeW3DJeLuz8kjkGkzHV5VYgDKA=;
 b=Vm8kaIicn64cJARbR5XYzfqHPE9v6AVkXJ/OalKi0zsiyVVV68R5k8ajVS1N+TiHpM3ghS
 xDJLZ42zHevMauDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B7C713310;
 Fri, 25 Sep 2026 15:40:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xxRgCd2VtmqjOwAAD6G6ig:T10
 (envelope-from <farosas@suse.de>); Fri, 25 Sep 2026 15:40:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PULL 09/19] migration/rdma: Drain writes at RAM round boundaries
Date: Fri, 25 Sep 2026 12:40:00 -0300
Message-ID: <20260925154010.599247-10-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925154010.599247-1-farosas@suse.de>
References: <20260925154010.599247-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,bytedance.com:email,ionos.com:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

From: Yanfei Xu <yanfei.xu@bytedance.com>

rdma_registration_stop() runs after every ram_save_iterate() call, which
can stop before a complete RAM scan because of rate limiting.  Draining
there ties the completion barrier to a SaveVM section rather than the
point where the scan wraps and a newer page version can be sent.

Register an RDMA RAM round notifier that drains all outstanding writes.
Keep posting the buffered tail in rdma_registration_stop() so it remains
ordered before REGISTER_FINISHED.

Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/rdma.c | 58 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 35d918ec83..7d220acef8 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2636,21 +2636,16 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
     return done;
 }
 
-/*
- * Block until all the outstanding chunks have been delivered by the hardware.
- */
-static int qemu_rdma_drain_cq(RDMAContext *rdma)
+/* Block until all outstanding writes have been delivered by the hardware. */
+static int qemu_rdma_drain_cq(RDMAContext *rdma, Error **errp)
 {
-    Error *err = NULL;
-
-    if (qemu_rdma_write_flush(rdma, &err) < 0) {
-        error_report_err(err);
+    if (qemu_rdma_write_flush(rdma, errp) < 0) {
         return -1;
     }
 
     while (rdma->nb_sent) {
         if (qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL) < 0) {
-            error_report("rdma migration: complete polling error!");
+            error_setg(errp, "rdma migration: completion polling error");
             return -1;
         }
     }
@@ -2658,6 +2653,38 @@ static int qemu_rdma_drain_cq(RDMAContext *rdma)
     return 0;
 }
 
+static int rdma_ram_round_notify(NotifierWithReturn *n G_GNUC_UNUSED,
+                                 void *data, Error **errp)
+{
+    RAMRoundNotifyData *round_data = data;
+    QEMUFile *f;
+    QIOChannelRDMA *rioc;
+    RDMAContext *rdma;
+
+    if (!migrate_rdma()) {
+        return 0;
+    }
+
+    f = round_data->file;
+    RCU_READ_LOCK_GUARD();
+    rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
+    rdma = qatomic_rcu_read(&rioc->rdmaout);
+    if (!rdma) {
+        error_setg(errp, "RDMA output context is not set");
+        return -1;
+    }
+
+    if (rdma_errored(rdma)) {
+        error_setg(errp, "RDMA is in an error state");
+        return -1;
+    }
+
+    return qemu_rdma_drain_cq(rdma, errp);
+}
+
+static NotifierWithReturn rdma_ram_round_notifier = {
+    .notify = rdma_ram_round_notify,
+};
 
 static int qio_channel_rdma_set_blocking(QIOChannel *ioc,
                                          bool blocking,
@@ -3558,7 +3585,8 @@ int rdma_registration_start(QEMUFile *f, uint64_t flags)
 
 /*
  * Inform dest that dynamic registrations are done for now.
- * First, flush writes, if any.
+ * Post any buffered write before sending the control marker. Outstanding
+ * writes are drained at the RAM scan round boundary.
  */
 int rdma_registration_stop(QEMUFile *f, uint64_t flags)
 {
@@ -3584,9 +3612,10 @@ int rdma_registration_stop(QEMUFile *f, uint64_t flags)
     }
 
     qemu_fflush(f);
-    ret = qemu_rdma_drain_cq(rdma);
+    ret = qemu_rdma_write_flush(rdma, &err);
 
     if (ret < 0) {
+        error_report_err(err);
         goto err;
     }
 
@@ -3720,6 +3749,13 @@ static void qio_channel_rdma_register_types(void)
 
 type_init(qio_channel_rdma_register_types);
 
+static void rdma_register_migration_notifiers(void)
+{
+    ram_round_add_notifier(&rdma_ram_round_notifier);
+}
+
+migration_init(rdma_register_migration_notifiers);
+
 static QIOChannel *rdma_new_input(RDMAContext *rdma)
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
-- 
2.53.0


