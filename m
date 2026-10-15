Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB45BCC6B3D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKSh-00033V-1R; Thu, 15 Oct 2026 08:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKSZ-00031X-Ew
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:21:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKSV-0005KY-Eu
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZKOYC/lQ7Latj9cIvjvvB3GgFXd31lG/RDxcK2Y5XQ=;
 b=iWLnELBhSjlDnbvP/rDWjpmT+nBXAeALZnq1I38VL4OTl/b9MPZ5xN4QQD04hI7g1393B7
 dBLkQOmoF176kJsH49hJC4B9POWYrNIxGejMNRRuMM9I9/6c0uyuL+AEIwNAWak7gzsNtU
 k5MY2Y+gI1YlYS8iAg0d5HDMOfVj4vg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-GeBEtQP3N2iVb-GdUnJ4SQ-1; Thu,
 15 Oct 2026 12:21:15 +0000
X-MC-Unique: GeBEtQP3N2iVb-GdUnJ4SQ-1
X-Mimecast-MFC-AGG-ID: GeBEtQP3N2iVb-GdUnJ4SQ_1792066874
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65AE7195606E; Thu, 15 Oct 2026 12:21:14 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D613518004D2; Thu, 15 Oct 2026 12:21:12 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pankaj Kumar <pshit@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Subject: [PULL 8/8] vfio/migration: Don't reset a device on a declined stop
 transition
Date: Thu, 15 Oct 2026 14:20:55 +0200
Message-ID: <20261015122055.888209-9-clg@redhat.com>
In-Reply-To: <20261015122055.888209-1-clg@redhat.com>
References: <20261015122055.888209-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

From: Pankaj Kumar <pshit@nvidia.com>

QEMU resets a VFIO device whenever a migration state transition it requests
fails. This is done by vfio_migration_set_state_or_reset(), which passes
VFIO_DEVICE_STATE_ERROR as the recover state, forcing an immediate
VFIO_DEVICE_RESET.

However, a device may legitimately decline a state transition, e.g. a vGPU
that refuses to stop while a profiling/debug session is active in the guest.
Such a device is still healthy and running the guest, so resetting it destroys
a perfectly good VM.

Instead of resetting on a declined stop, recover the device to its current
state. The current device state is always a valid, already-reached state, so
recovering to it is effectively a no-op transition that cannot itself fail and
trigger a reset.

Introduce a helper, vfio_migration_set_state_or_recover(), that selects the
recover state based on the transition direction, and route the vmstate change
and save-completion paths through it:

 - vfio_vmstate_change() and vfio_vmstate_change_prepare() recover to the
   current device state for the stop direction. The resume direction keeps
   ERROR as the recover state, since a device that cannot resume is genuinely
   broken.

 - vfio_save_complete_precopy() recovers to the current device state rather
   than STOP. If it runs after an earlier stop was declined (the device still
   in a running state), the stop-copy attempt is then rolled back instead of
   resetting the device.

The existing vfio_migration_set_state_or_reset() is retained for the paths
that must still reset on failure (save cleanup and the migration-failed
notifier).

This lets vendor drivers decline a stop as a matter of policy without losing
the guest, and lets such drivers drop their own workarounds that swallowed the
spurious reset.

Signed-off-by: Pankaj Kumar <pshit@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261013044520.2439021-1-pshit@nvidia.com
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 73c49d8c24f21803de7c8615da63abecfd76b882..69d50cebdd5f1636a1f8b03967b6b01e7979e532 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -246,6 +246,25 @@ vfio_migration_set_state_or_reset(VFIODevice *vbasedev,
                                     VFIO_DEVICE_STATE_ERROR, errp);
 }
 
+/*
+ * On a stop-direction transition failure, recover the device to its current
+ * state instead of resetting it: the current state is valid and already
+ * reached, so recovering to it is effectively a no-op that cannot itself fail.
+ * On a resume-direction (running) failure, the device is genuinely broken, so
+ * reset it by using ERROR as the recover state.
+ */
+static int
+vfio_migration_set_state_or_recover(VFIODevice *vbasedev,
+                                    enum vfio_device_mig_state new_state,
+                                    bool running, Error **errp)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    enum vfio_device_mig_state recover_state =
+        running ? VFIO_DEVICE_STATE_ERROR : migration->device_state;
+
+    return vfio_migration_set_state(vbasedev, new_state, recover_state, errp);
+}
+
 static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
                             uint64_t data_size)
 {
@@ -771,9 +790,16 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
 
     trace_vfio_save_complete_precopy_start(vbasedev->name);
 
-    /* We reach here with device state STOP or STOP_COPY only */
-    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
-                                   VFIO_DEVICE_STATE_STOP, &local_err);
+    /*
+     * We normally reach here with the device in STOP or STOP_COPY. However, if
+     * an earlier stop transition was declined by the device, it may still be in
+     * a running state. Recover to the current device state rather than STOP, so
+     * a device that declines the stop-copy transition is rolled back to its
+     * current state instead of being reset out from under the guest.
+     */
+    ret = vfio_migration_set_state_or_recover(vbasedev,
+                                              VFIO_DEVICE_STATE_STOP_COPY,
+                                              false, &local_err);
     if (ret) {
         error_report_err(local_err);
         return ret;
@@ -1009,7 +1035,8 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
         vfio_final_precopy_reinit_check(vbasedev);
     }
 
-    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
+    ret = vfio_migration_set_state_or_recover(vbasedev, new_state, running,
+                                              &local_err);
     if (ret) {
         /*
          * Migration should be aborted in this case, but vm_state_notify()
@@ -1040,7 +1067,8 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
                 VFIO_DEVICE_STATE_STOP;
     }
 
-    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
+    ret = vfio_migration_set_state_or_recover(vbasedev, new_state, running,
+                                              &local_err);
     if (ret) {
         /*
          * Migration should be aborted in this case, but vm_state_notify()
-- 
2.56.0


