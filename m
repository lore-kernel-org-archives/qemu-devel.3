Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05807CC6B3C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ7s-0000u4-Qz; Thu, 15 Oct 2026 06:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ7V-0000a0-Md
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:55:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ7T-0008Hg-Ef
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792061730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nk8gDfehU7yoEPbANvagEtZ5Xv355XUw0eD1fSeorHw=;
 b=cWRuT9V/Wz9LjiSCWkdmjjlLhWJJRjNlyd7/HIAXwNBnj3/FhmvaTvb8eD/cTpMqO4ySoB
 +kG/fILO5GJ2E5lDBLX+bpUIZPEjPmzSoNw0pSNmmq4AwoY5QW1bie1NkEntYe8YQR6Jc5
 MY5mdzrRg1nuusbnMZSwXe5RQrEeTJY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-2BRefZIeP4qe6istWzGZ3Q-1; Thu, 15 Oct 2026 10:55:28 +0000
X-MC-Unique: 2BRefZIeP4qe6istWzGZ3Q-1
X-Mimecast-MFC-AGG-ID: 2BRefZIeP4qe6istWzGZ3Q_1792061728
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48af4a0bd0fso2933037f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792061727; x=1792666527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nk8gDfehU7yoEPbANvagEtZ5Xv355XUw0eD1fSeorHw=;
 b=HX0uNenG5H1g/vpJwjt0cz8zQrFHxCKsh2mq4b5M55/Z7qhekZcR95lS668jyYN7Rf
 ENQV4DI+ywUS2XtfyUwt1+HLcrxYjcFR2fmzXY7dhohep+d3VBR6n0TG569tZv8SEVSJ
 BEGCUx6I2u8F8JQZz/s6JhFzZNPXCfttkPz1lEwUGtsE9XiznW+SEzoqf2hYVWtRFLIw
 /6GOaF9ImhaIxk+YFmAZs4lU90EM/3Z30qgfUzeKAjvEpWTPdsalCfH8sL6cKjProLpw
 9QpSiCTom83K7euqf8wvsYXkCc9OmaaTbbtNoLbAzSEw5Ct0v8UddIXBNG027JDQ856K
 NqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061727; x=1792666527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nk8gDfehU7yoEPbANvagEtZ5Xv355XUw0eD1fSeorHw=;
 b=z6OPl4YOTXpAuFYK70DVvPLRe/WFICM2e9NGNBm5QQVtfEOxoc4s4EoU5zwfhbhxn3
 m/O1s37SWvsEAg4VaRAfngjbZCV97+lkixndwE6gEDThYLQmB1oW/NBAz4R1FotEwaaE
 0BlIs/0c78th/cTAMR3aU8QzcsHSmGWTg8VvIGrFfd5zSLj6gTMn9DWd3ZnhAF7Dw1Rx
 JUJ3YISMz4xnyPkByRgfn8JaFMxtS7SZJ+P0xKc2bCzwow0lPwyWmOLYrcpl1WZp4k2G
 XRfRHPZuCPWpHM8WpF3O8MZan09lPG7kO6Durh56Q1wILbGNAQnBR2U1sHwNRAml4a/8
 pF8Q==
X-Gm-Message-State: AFq9FYKp00cETKiDVM1CoyRbr/2aBIbaaZgEcWXuNy+YJQ1cmSegf7FU
 e+aG3/m4UMmZubHZK8S7PuoaOvK6An/IhdklfjG2Bg9eAdzJ2X3okFH1YQ+L3Ku4V/jLp7ObHdN
 OL1S1AeYeUvKwLJYqrW+cOc/CEl9GJrqS/xvr2Xy42pmy7AEO2NI5nd+V7do45NKtEMWJvZzWZe
 AWgpz9LpIT5qRJpu7S5ynyRvc/CWPNuYr/dfhXJJVv
X-Gm-Gg: AYBFou03Cr+qsbCEJV1GoaXKctSwignnUZ4JSw/UB/ovHbxkQ0/X//BEpPYRkCH3hqb
 aUVZVQOUdZ5kzlL8ZkaNL3K8Q261n7ng4vWbrOoblFyeeXPtQHgo5DkYzWbWGmKpbDajQ1NH4P8
 fww7E3jPjpYwt2uHgrC9G6GUIAyl/8ByPJ+zpOcsw/JVdxDc1vaFzmHz03/yPrtsWAm4698vwaB
 /adjdPH1kfts3Pvrxh1WiyTSCcrBElrvZcJSImxygmKLDGUKb9QYjOKMWcTxh2aOooqFlYeLC1i
 Rc23Fd7yBqGtiPvie84UWio7W1o2ltnQNjKfh0ZraoESf5el+vwt1ynaKCveae/C3pD1OMqNHvZ
 PVsC6XKrPV6kpfeoE7eNAtjOFzPk+H1WPyd7gNHz6yi5wgam1KkC95cCmF6GGlW7yKSok2nO+XG
 cpUVCl
X-Received: by 2002:a05:6000:2303:b0:48d:f102:aba9 with SMTP id
 ffacd0b85a97d-48df102adb2mr7139596f8f.52.1792061727504; 
 Thu, 15 Oct 2026 03:55:27 -0700 (PDT)
X-Received: by 2002:a05:6000:2303:b0:48d:f102:aba9 with SMTP id
 ffacd0b85a97d-48df102adb2mr7139407f8f.52.1792061725565; 
 Thu, 15 Oct 2026 03:55:25 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de09693c7sm22481519f8f.4.2026.10.15.03.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:55:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 11/13] scsi: clean up persistent reservation state after
 migration
Date: Thu, 15 Oct 2026 12:53:45 +0200
Message-ID: <20261015105347.827029-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015105347.827029-1-pbonzini@redhat.com>
References: <20261015105347.827029-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

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
Reviewed-by: Eric Blake <eblake@redhat.com>
Link: https://lore.kernel.org/r/20261013181752.1299456-8-stefanha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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


