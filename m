Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04692CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGh5Y-0007Ci-N1; Tue, 13 Oct 2026 14:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xGh4r-0006xz-As
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 14:18:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xGh4m-00015M-Bp
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 14:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791915490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cy1sHM4DN9NkFwXyyz8pwoaPUezGhyNbcW8POsu24oY=;
 b=QlQ/9N7X/+d/3UpYHyBXidepL3Prj+GdRKaEMnGuxDJqJfLTB2bd1X154P4RqmYZyyEsy0
 jI37e8J9aAOq2pyjN9jYV8+S7Dgi8r1ZBo/Jg7cQK+04MwOuNEzZcPwJmto6EAN42t0Z7r
 oMbUuUgADWlp6DpIkUi1Il5yWYq8PmM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-zbeQCWICNX2BZzwFaIoQdA-1; Tue,
 13 Oct 2026 18:18:07 +0000
X-MC-Unique: zbeQCWICNX2BZzwFaIoQdA-1
X-Mimecast-MFC-AGG-ID: zbeQCWICNX2BZzwFaIoQdA_1791915486
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D5281955EB9; Tue, 13 Oct 2026 18:18:06 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B5807180057E; Tue, 13 Oct 2026 18:18:05 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 akalenyu@redhat.com, Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 <qemu-block@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 7/8] scsi: clean up persistent reservation state after
 migration
Date: Tue, 13 Oct 2026 14:17:51 -0400
Message-ID: <20261013181752.1299456-8-stefanha@redhat.com>
In-Reply-To: <20261013181752.1299456-1-stefanha@redhat.com>
References: <20261013181752.1299456-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Live migration of persistent reservations is designed to work without
coordination between the source and destination. The destination uses
the PREEMPT command to atomically take over the reservation or
unregister keys belonging to the source. This approach avoids race
conditions where other nodes in the cluster might acquire the
reservation and it minimizes communication during the downtime window.

While this works at the SCSI level, this approach is incomplete when
using multipathd. Multipathd tracks registered keys and automatically
registers them again when paths come up. It is unaware that the
destination has preempted the reservation and therefore it will still
attempt to register the key on the source host.

Use the new PR_HELPER_CLEANUP command to communicate with multipathd on
the source after migration completes successfully. The effect is similar
to REGISTER AND IGNORE EXISTING KEY, except it also discards
multipathd's state so that the source will no longer attempt to register
the key.

PR_HELPER_CLEANUP is a QEMU-internal command that is rejected by
scsi_req_new(), so note that this command is not exposed to guests
although direct blk_aio_ioctl(SG_IO) calls can make use of it.

Buglink: https://redhat.atlassian.net/browse/RHEL-274966
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/scsi/scsi.h |  1 +
 hw/scsi/scsi-disk.c    | 21 ++++++++++++++++++++-
 hw/scsi/scsi-generic.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 3eab339b0d2..a2f6f0be7fc 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -256,6 +256,7 @@ SCSIDevice *scsi_device_get(SCSIBus *bus, int channel, int target, int lun);
 /* scsi-generic.c. */
 extern const SCSIReqOps scsi_generic_req_ops;
 bool scsi_generic_pr_state_preempt(SCSIDevice *s, Error **errp);
+bool scsi_generic_pr_state_cleanup(SCSIDevice *s, Error **errp);
 
 /* scsi-disk.c */
 #define SCSI_DISK_QUIRK_MODE_PAGE_APPLE_VENDOR             0
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 3d88e57eded..6341089ddf2 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2773,13 +2773,32 @@ static void scsi_block_migration_failed(SCSIDiskState *s)
     }
 }
 
+/*
+ * Unregister keys on the source after migration since the destination has
+ * preempted and taken over. This cleanup is not necessary at the SCSI level
+ * but multipathd tracks registered keys and must be informed that this host no
+ * longer wishes to be registered.
+ */
+static void scsi_block_migration_done(SCSIDiskState *s)
+{
+    SCSIDevice *d = &s->qdev;
+    Error *local_err = NULL;
+
+    if (!scsi_generic_pr_state_cleanup(d, &local_err)) {
+        error_prepend(&local_err, "scsi-block migration done: ");
+        warn_report_err(local_err);
+    }
+}
+
 static int scsi_block_migration_notifier(NotifierWithReturn *notifier,
                                          MigrationEvent *e, Error **errp)
 {
     SCSIDiskState *s =
         container_of(notifier, SCSIDiskState, migration_notifier);
 
-    if (e->type == MIG_EVENT_FAILED) {
+    if (e->type == MIG_EVENT_DONE) {
+        scsi_block_migration_done(s);
+    } else if (e->type == MIG_EVENT_FAILED) {
         scsi_block_migration_failed(s);
     }
     return 0;
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 153a5275567..e41e973aa92 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -652,6 +652,35 @@ bool scsi_generic_pr_state_preempt(SCSIDevice *s, Error **errp)
     return true;
 }
 
+/* Clean up keys on source after migration */
+bool scsi_generic_pr_state_cleanup(SCSIDevice *s, Error **errp)
+{
+    SCSIPRState *pr_state = &s->pr_state;
+    uint8_t cmd[10] = {
+        PR_HELPER_CLEANUP, /* OPCODE */
+    };
+    int ret;
+
+    WITH_QEMU_LOCK_GUARD(&pr_state->mutex) {
+        if (pr_state->key == 0) {
+            return true; /* nothing to do */
+        }
+    }
+
+    ret = scsi_SG_IO(s->conf.blk, SG_DXFER_TO_DEV, cmd, sizeof(cmd), NULL, 0,
+                     s->io_timeout, errp);
+    if (ret < 0) {
+        error_prepend(errp, "pr-helper CLEANUP failed: ");
+        return false;
+    }
+
+    WITH_QEMU_LOCK_GUARD(&pr_state->mutex) {
+        pr_state->key = 0;
+        pr_state->resv_type = 0;
+    }
+    return true;
+}
+
 static void scsi_read_complete(void * opaque, int ret)
 {
     SCSIGenericReq *r = (SCSIGenericReq *)opaque;
-- 
2.56.0


