Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92431C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzJu-0002Ay-4o; Tue, 07 Jul 2026 02:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzJp-0001pc-NA
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:30:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzJn-0007At-Dm
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783405806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=llDNiwH7hZoMhlkvQSWhEOq7f9CVRFUm0UL7PJOc8Ro=;
 b=Nyae5wJ3Xw+ziPbPi4jDO9IB+4Whebjed331Hh+0dFKZ0trnmXe46DUcJZPNm4/VuSNjmA
 Qr+1IRnYswIFUON+/bil+ATyfiyWQUaLymG/4AXcrBWQEs5LUD5l3oCpyxZTs7ZIn8o5UP
 s4lxQ3B+EmE+Maw+wll1V9U89ekUskE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-RiYWf6NIMia722pHe2S6pA-1; Tue,
 07 Jul 2026 02:30:03 -0400
X-MC-Unique: RiYWf6NIMia722pHe2S6pA-1
X-Mimecast-MFC-AGG-ID: RiYWf6NIMia722pHe2S6pA_1783405802
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 786621954B1D; Tue,  7 Jul 2026 06:30:02 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E14E8180067C; Tue,  7 Jul 2026 06:30:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 18/27] vfio/migration: Check VFIO_PRECOPY_INFO_REINIT during
 switchover
Date: Tue,  7 Jul 2026 08:29:11 +0200
Message-ID: <20260707062920.317302-19-clg@redhat.com>
In-Reply-To: <20260707062920.317302-1-clg@redhat.com>
References: <20260707062920.317302-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

From: Avihai Horon <avihaih@nvidia.com>

VFIO_REPCOPY_INFO_REINIT is checked only during precopy, before the
switchover decision. However, the switchover decision and guest stop are
not atomic, so a VFIO device may want to set VFIO_PRECOPY_INFO_REINIT
and request another switchover ACK in the gap after switchover decision
has been made but before the guest is stopped. This would be missed and
may increase downtime.

Solve this by checking if VFIO_PRECOPY_INFO_REINIT was set during that
gap, and request a new switchover-ack in the final save_state_pending
call. Query precopy info after vCPUs are stopped but before
transitioning from PRE_COPY state, when its valid to call the ioctl.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20260706085211.13905-14-avihaih@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 1e172dd10bfc3561741aa90bf1e237cd6847eb63..73c49d8c24f21803de7c8615da63abecfd76b882 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -685,6 +685,9 @@ static void vfio_state_pending(void *opaque, MigPendingData *pending,
      * The final pending query runs during switchover downtime. VFIO does not
      * need a fresh device pending-data query then to get the latest dirty
      * data, so avoid the extra work and report the cached counters below.
+     * On the other hand, precopy sync is needed to check if switchover ACK was
+     * requested, but that's already done during guest stop when device is in
+     * PRE_COPY state.
      */
     if (exact && !final) {
         vfio_state_pending_sync(vbasedev);
@@ -964,6 +967,26 @@ static const SaveVMHandlers savevm_vfio_handlers = {
 
 /* ---------------------------------------------------------------------- */
 
+static void vfio_final_precopy_reinit_check(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    int ret;
+
+    if (!migration->precopy_info_v2_used || !migrate_switchover_ack() ||
+        migrate_switchover_ack_legacy()) {
+        return;
+    }
+
+    ret = vfio_query_precopy_size(migration);
+    if (ret) {
+        error_report("%s: Final precopy reinit check failed (err: %d)",
+                     vbasedev->name, ret);
+        /* If query failed, assume reinit and request switchover-ack */
+        migration->request_switchover_ack = true;
+        migration->initial_data_sent = false;
+    }
+}
+
 static void vfio_vmstate_change_prepare(void *opaque, bool running,
                                         RunState state)
 {
@@ -977,6 +1000,15 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
                     VFIO_DEVICE_STATE_PRE_COPY_P2P :
                     VFIO_DEVICE_STATE_RUNNING_P2P;
 
+    if (migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
+        /*
+         * Now that vCPUs are stopped, check if new init_bytes are available
+         * since switchover decision, to be reported in the final
+         * save_query_pending.
+         */
+        vfio_final_precopy_reinit_check(vbasedev);
+    }
+
     ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
     if (ret) {
         /*
-- 
2.54.0


