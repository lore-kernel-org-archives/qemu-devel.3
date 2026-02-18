Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF879E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 14:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsi6K-0003th-5n; Wed, 18 Feb 2026 09:00:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vsi6I-0003st-3E
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 09:00:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vsi6G-00079l-7N
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 09:00:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771423218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kjq1qNsV8IoikIyePU3huwdiu2PqhFN9lIM3uwRFHic=;
 b=gVsUFRtc9aF3HeO69Kj1tXtkWU0r83fy247H5Wtjdy/DDvn+udMyb3fqATxxfP8JX7fHE0
 13+f8TH3eUjU1KavvBliiuF2MZY6t+jWyzyECQ4Ru6Pw2EGPI8Hy8LNTCSo90wKhZBv8i6
 xqAXruegd4ZKqKRn5H9XQ5tZCnQiNjU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-GPXzvr9-N7aErrRSTsMlQw-1; Wed,
 18 Feb 2026 09:00:11 -0500
X-MC-Unique: GPXzvr9-N7aErrRSTsMlQw-1
X-Mimecast-MFC-AGG-ID: GPXzvr9-N7aErrRSTsMlQw_1771423210
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D1E51955BC4; Wed, 18 Feb 2026 14:00:10 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.251])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AAF761956095; Wed, 18 Feb 2026 14:00:08 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Avihai Horon <avihaih@nvidia.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 1/5] vfio/migration: Send VFIO_MIGRATION event before
 PRE_COPY_P2P transition
Date: Wed, 18 Feb 2026 14:59:59 +0100
Message-ID: <20260218140003.1554502-2-clg@redhat.com>
In-Reply-To: <20260218140003.1554502-1-clg@redhat.com>
References: <20260218140003.1554502-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Avihai Horon <avihaih@nvidia.com>

The VFIO_MIGRATION event notifies users when a VFIO device transitions
to a new state.

One use case for this event is to prevent timeouts for RDMA connections
to the migrated device. In this case, an external management application
(not libvirt) consumes the events and disables the RDMA timeout
mechanism when receiving the event for PRE_COPY_P2P state, which
indicates that the device is non-responsive.

This is essential because RDMA connections typically have very low
timeouts (tens of milliseconds), which can be far below migration
downtime.

However, under heavy resource utilization, the device transition to
PRE_COPY_P2P can take hundreds of milliseconds to complete. Since the
VFIO_MIGRATION event is currently sent only after the transition
completes, it arrives too late, after RDMA connections have already
timed out.

To address this, send an additional "prepare" event immediately before
initiating the PRE_COPY_P2P transition. This guarantees timely event
delivery regardless of how long the actual state transition takes.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260202173406.13979-1-avihaih@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 qapi/vfio.json      | 13 +++++++++++--
 hw/vfio/migration.c | 26 +++++++++++++++++++-------
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/qapi/vfio.json b/qapi/vfio.json
index a1a9c5b673d8e2f9a1a7e5cc7ad518639320e976..17b604687128c7a0a4b53441d108b78b6bd0343b 100644
--- a/qapi/vfio.json
+++ b/qapi/vfio.json
@@ -11,7 +11,13 @@
 ##
 # @QapiVfioMigrationState:
 #
-# An enumeration of the VFIO device migration states.
+# An enumeration of the VFIO device migration states.  In addition to
+# the regular states, there are prepare states (with 'prepare' suffix)
+# which indicate that the device is just about to transition to the
+# corresponding state.  Note that seeing a prepare state for state X
+# doesn't guarantee that the next state will be X, as the state
+# transition can fail and the device may transition to a different
+# state instead.
 #
 # @stop: The device is stopped.
 #
@@ -32,11 +38,14 @@
 #     tracking its internal state and its internal state is available
 #     for reading.
 #
+# @pre-copy-p2p-prepare: The device is just about to move to
+#     pre-copy-p2p state.  (since 11.0)
+#
 # Since: 9.1
 ##
 { 'enum': 'QapiVfioMigrationState',
   'data': [ 'stop', 'running', 'stop-copy', 'resuming', 'running-p2p',
-            'pre-copy', 'pre-copy-p2p' ] }
+            'pre-copy', 'pre-copy-p2p', 'pre-copy-p2p-prepare' ] }
 
 ##
 # @VFIO_MIGRATION:
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index b4695030c7295f318faf1d12ac48ba951aa943c7..4bd8e24699cc584924e82197b61ed558cb0399ec 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -68,7 +68,7 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
 }
 
 static QapiVfioMigrationState
-mig_state_to_qapi_state(enum vfio_device_mig_state state)
+mig_state_to_qapi_state(enum vfio_device_mig_state state, bool prepare)
 {
     switch (state) {
     case VFIO_DEVICE_STATE_STOP:
@@ -84,15 +84,17 @@ mig_state_to_qapi_state(enum vfio_device_mig_state state)
     case VFIO_DEVICE_STATE_PRE_COPY:
         return QAPI_VFIO_MIGRATION_STATE_PRE_COPY;
     case VFIO_DEVICE_STATE_PRE_COPY_P2P:
-        return QAPI_VFIO_MIGRATION_STATE_PRE_COPY_P2P;
+        return prepare ? QAPI_VFIO_MIGRATION_STATE_PRE_COPY_P2P_PREPARE :
+                         QAPI_VFIO_MIGRATION_STATE_PRE_COPY_P2P;
     default:
         g_assert_not_reached();
     }
 }
 
-static void vfio_migration_send_event(VFIODevice *vbasedev)
+static void vfio_migration_send_event(VFIODevice *vbasedev,
+                                      enum vfio_device_mig_state state,
+                                      bool prepare)
 {
-    VFIOMigration *migration = vbasedev->migration;
     DeviceState *dev = vbasedev->dev;
     g_autofree char *qom_path = NULL;
     Object *obj;
@@ -106,8 +108,8 @@ static void vfio_migration_send_event(VFIODevice *vbasedev)
     g_assert(obj);
     qom_path = object_get_canonical_path(obj);
 
-    qapi_event_send_vfio_migration(
-        dev->id, qom_path, mig_state_to_qapi_state(migration->device_state));
+    qapi_event_send_vfio_migration(dev->id, qom_path,
+                                   mig_state_to_qapi_state(state, prepare));
 }
 
 static void vfio_migration_set_device_state(VFIODevice *vbasedev,
@@ -119,7 +121,7 @@ static void vfio_migration_set_device_state(VFIODevice *vbasedev,
                                           mig_state_to_str(state));
 
     migration->device_state = state;
-    vfio_migration_send_event(vbasedev);
+    vfio_migration_send_event(vbasedev, state, false);
 }
 
 int vfio_migration_set_state(VFIODevice *vbasedev,
@@ -146,6 +148,16 @@ int vfio_migration_set_state(VFIODevice *vbasedev,
         return 0;
     }
 
+    /*
+     * Send a prepare event before initiating the PRE_COPY_P2P transition to
+     * ensure timely event delivery regardless of how long the state transition
+     * takes.
+     */
+    if (new_state == VFIO_DEVICE_STATE_PRE_COPY_P2P) {
+        vfio_migration_send_event(vbasedev, VFIO_DEVICE_STATE_PRE_COPY_P2P,
+                                  true);
+    }
+
     feature->argsz = sizeof(buf);
     feature->flags =
         VFIO_DEVICE_FEATURE_SET | VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE;
-- 
2.53.0


