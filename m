Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEDECCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7DTf-0007Mf-Uf; Fri, 10 Oct 2025 09:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1v7DTO-0007Gh-U4
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:47:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1v7DT7-00016i-GN
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760104041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JhwJ3xxDq0FwCWHwA59nSocZf4UkeXk2PhKws6hVfr0=;
 b=UJR8YlbIX8zNxM6uF4juedcNDaThBASGwQPhv7wpySBhiEn6jJ4a24XLXAqAZNQNbNvmLE
 xz8yZGOtvN8spO0Z1DlZUJ9a9i5RsSW6dbLQbZMXfxYIpiUjBVcE48nrNsmPepFJUpBfL7
 1eBFroRWnvtKEb6jaSFPrdQ3ooX7yNc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-BSINzLjePOKumvQDM5QiMg-1; Fri,
 10 Oct 2025 09:47:18 -0400
X-MC-Unique: BSINzLjePOKumvQDM5QiMg-1
X-Mimecast-MFC-AGG-ID: BSINzLjePOKumvQDM5QiMg_1760104038
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0508719560BB
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 13:47:18 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.164])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4BB7E1800452; Fri, 10 Oct 2025 13:47:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] hw/virtio: qmp: refactor the FEATURE_ENTRY() macro
Date: Fri, 10 Oct 2025 15:47:04 +0200
Message-ID: <745e4b9ff93b27b4464d039d2ca24a9020f2c32f.1760103753.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

The description of all the features entry starts with the feature name,
which is also an explicit argument of the FEATURE_ENTRY() macro.

Rework such macro to add the stringified name into the description
automatically, and update accordingly all the macro use cases.

This makes the code tidy and help avoiding related errors in future
usage of such macro.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 hw/virtio/virtio-qmp.c | 340 ++++++++++++++++++-----------------------
 1 file changed, 145 insertions(+), 195 deletions(-)

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index b338344c6c..ee236919bc 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -36,115 +36,98 @@
 #include CONFIG_DEVICES
 
 #define FEATURE_ENTRY(name, desc) (qmp_virtio_feature_map_t) \
-    { .virtio_bit = name, .feature_desc = desc }
+    { .virtio_bit = name, .feature_desc = #name": "desc }
 
 /* Virtio transport features mapping */
 static const qmp_virtio_feature_map_t virtio_transport_map[] = {
     /* Virtio device transport features */
 #ifndef VIRTIO_CONFIG_NO_LEGACY
     FEATURE_ENTRY(VIRTIO_F_NOTIFY_ON_EMPTY, \
-            "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. "
-            "descs. on VQ"),
+            "Notify when device runs out of avail. descs. on VQ"),
     FEATURE_ENTRY(VIRTIO_F_ANY_LAYOUT, \
-            "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts"),
+            "Device accepts arbitrary desc. layouts"),
 #endif /* !VIRTIO_CONFIG_NO_LEGACY */
     FEATURE_ENTRY(VIRTIO_F_VERSION_1, \
-            "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"),
+            "Device compliant for v1 spec (legacy)"),
     FEATURE_ENTRY(VIRTIO_F_IOMMU_PLATFORM, \
-            "VIRTIO_F_IOMMU_PLATFORM: Device can be used on IOMMU platform"),
+            "Device can be used on IOMMU platform"),
     FEATURE_ENTRY(VIRTIO_F_RING_PACKED, \
-            "VIRTIO_F_RING_PACKED: Device supports packed VQ layout"),
+            "Device supports packed VQ layout"),
     FEATURE_ENTRY(VIRTIO_F_IN_ORDER, \
-            "VIRTIO_F_IN_ORDER: Device uses buffers in same order as made "
-            "available by driver"),
+            "Device uses buffers in same order as made available by driver"),
     FEATURE_ENTRY(VIRTIO_F_ORDER_PLATFORM, \
-            "VIRTIO_F_ORDER_PLATFORM: Memory accesses ordered by platform"),
+            "Memory accesses ordered by platform"),
     FEATURE_ENTRY(VIRTIO_F_SR_IOV, \
-            "VIRTIO_F_SR_IOV: Device supports single root I/O virtualization"),
+            "Device supports single root I/O virtualization"),
     FEATURE_ENTRY(VIRTIO_F_RING_RESET, \
-            "VIRTIO_F_RING_RESET: Driver can reset a queue individually"),
+            "Driver can reset a queue individually"),
     /* Virtio ring transport features */
     FEATURE_ENTRY(VIRTIO_RING_F_INDIRECT_DESC, \
-            "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported"),
+            "Indirect descriptors supported"),
     FEATURE_ENTRY(VIRTIO_RING_F_EVENT_IDX, \
-            "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled"),
+            "Used & avail. event fields enabled"),
     { -1, "" }
 };
 
 /* Vhost-user protocol features mapping */
 static const qmp_virtio_feature_map_t vhost_user_protocol_map[] = {
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_MQ, \
-            "VHOST_USER_PROTOCOL_F_MQ: Multiqueue protocol supported"),
+            "Multiqueue protocol supported"),
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_LOG_SHMFD, \
-            "VHOST_USER_PROTOCOL_F_LOG_SHMFD: Shared log memory fd supported"),
+            "Shared log memory fd supported"),
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_RARP, \
-            "VHOST_USER_PROTOCOL_F_RARP: Vhost-user back-end RARP broadcasting "
-            "supported"),
+            "Vhost-user back-end RARP broadcasting supported"),
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_REPLY_ACK, \
-            "VHOST_USER_PROTOCOL_F_REPLY_ACK: Requested operation status ack. "
-            "supported"),
+            "Requested operation status ack. supported"),
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_NET_MTU, \
-            "VHOST_USER_PROTOCOL_F_NET_MTU: Expose host MTU to guest supported"),
+            "Expose host MTU to guest supported"),
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_BACKEND_REQ, \
-            "VHOST_USER_PROTOCOL_F_BACKEND_REQ: Socket fd for back-end initiated "
-            "requests supported"),
+            "Socket fd for back-end initiated requests supported"),
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_CROSS_ENDIAN, \
-            "VHOST_USER_PROTOCOL_F_CROSS_ENDIAN: Endianness of VQs for legacy "
-            "devices supported"),
+            "Endianness of VQs for legacy devices supported"),
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_CRYPTO_SESSION, \
-            "VHOST_USER_PROTOCOL_F_CRYPTO_SESSION: Session creation for crypto "
-            "operations supported"),
+            "Session creation for crypto operations supported"),
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_PAGEFAULT, \
-            "VHOST_USER_PROTOCOL_F_PAGEFAULT: Request servicing on userfaultfd "
-            "for accessed pages supported"),
+            "Request servicing on userfaultfd for accessed pages supported"),
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_CONFIG, \
-            "VHOST_USER_PROTOCOL_F_CONFIG: Vhost-user messaging for virtio "
-            "device configuration space supported"),
+            "Vhost-user messaging for virtio device configuration space "
+            "supported"),
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD, \
-            "VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD: Backend fd communication "
-            "channel supported"),
+            "Backend fd communication channel supported"),
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_HOST_NOTIFIER, \
-            "VHOST_USER_PROTOCOL_F_HOST_NOTIFIER: Host notifiers for specified "
-            "VQs supported"),
+            "Host notifiers for specified VQs supported"),
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD, \
-            "VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD: Shared inflight I/O buffers "
-            "supported"),
+            "Shared inflight I/O buffers supported"),
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_RESET_DEVICE, \
-            "VHOST_USER_PROTOCOL_F_RESET_DEVICE: Disabling all rings and "
-            "resetting internal device state supported"),
-    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS, \
-            "VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS: In-band messaging "
+            "Disabling all rings and resetting internal device state "
             "supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS, \
+            "In-band messaging supported"),
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS, \
-            "VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS: Configuration for "
-            "memory slots supported"),
+            "Configuration for memory slots supported"),
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_STATUS, \
-            "VHOST_USER_PROTOCOL_F_STATUS: Querying and notifying back-end "
-            "device status supported"),
+            "Querying and notifying back-end device status supported"),
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_SHARED_OBJECT, \
-            "VHOST_USER_PROTOCOL_F_SHARED_OBJECT: Backend shared object "
-            "supported"),
+            "Backend shared object supported"),
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_DEVICE_STATE, \
-            "VHOST_USER_PROTOCOL_F_DEVICE_STATE: Backend device state transfer "
-            "supported"),
+            "Backend device state transfer supported"),
     { -1, "" }
 };
 
 /* virtio device configuration statuses */
 static const qmp_virtio_feature_map_t virtio_config_status_map[] = {
     FEATURE_ENTRY(VIRTIO_CONFIG_S_DRIVER_OK, \
-            "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"),
+            "Driver setup and ready"),
     FEATURE_ENTRY(VIRTIO_CONFIG_S_FEATURES_OK, \
-            "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete"),
+            "Feature negotiation complete"),
     FEATURE_ENTRY(VIRTIO_CONFIG_S_DRIVER, \
-            "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device"),
+            "Guest OS compatible with device"),
     FEATURE_ENTRY(VIRTIO_CONFIG_S_NEEDS_RESET, \
-            "VIRTIO_CONFIG_S_NEEDS_RESET: Irrecoverable error, device needs "
-            "reset"),
+            "Irrecoverable error, device needs reset"),
     FEATURE_ENTRY(VIRTIO_CONFIG_S_FAILED, \
-            "VIRTIO_CONFIG_S_FAILED: Error in guest, device failed"),
+            "Error in guest, device failed"),
     FEATURE_ENTRY(VIRTIO_CONFIG_S_ACKNOWLEDGE, \
-            "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found"),
+            "Valid virtio device found"),
     { -1, "" }
 };
 
@@ -152,43 +135,41 @@ static const qmp_virtio_feature_map_t virtio_config_status_map[] = {
 #ifdef CONFIG_VIRTIO_BLK
 static const qmp_virtio_feature_map_t virtio_blk_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_BLK_F_SIZE_MAX, \
-            "VIRTIO_BLK_F_SIZE_MAX: Max segment size is size_max"),
+            "Max segment size is size_max"),
     FEATURE_ENTRY(VIRTIO_BLK_F_SEG_MAX, \
-            "VIRTIO_BLK_F_SEG_MAX: Max segments in a request is seg_max"),
+            "Max segments in a request is seg_max"),
     FEATURE_ENTRY(VIRTIO_BLK_F_GEOMETRY, \
-            "VIRTIO_BLK_F_GEOMETRY: Legacy geometry available"),
+            "Legacy geometry available"),
     FEATURE_ENTRY(VIRTIO_BLK_F_RO, \
-            "VIRTIO_BLK_F_RO: Device is read-only"),
+            "Device is read-only"),
     FEATURE_ENTRY(VIRTIO_BLK_F_BLK_SIZE, \
-            "VIRTIO_BLK_F_BLK_SIZE: Block size of disk available"),
+            "Block size of disk available"),
     FEATURE_ENTRY(VIRTIO_BLK_F_TOPOLOGY, \
-            "VIRTIO_BLK_F_TOPOLOGY: Topology information available"),
+            "Topology information available"),
     FEATURE_ENTRY(VIRTIO_BLK_F_MQ, \
-            "VIRTIO_BLK_F_MQ: Multiqueue supported"),
+            "Multiqueue supported"),
     FEATURE_ENTRY(VIRTIO_BLK_F_DISCARD, \
-            "VIRTIO_BLK_F_DISCARD: Discard command supported"),
+            "Discard command supported"),
     FEATURE_ENTRY(VIRTIO_BLK_F_WRITE_ZEROES, \
-            "VIRTIO_BLK_F_WRITE_ZEROES: Write zeroes command supported"),
+            "Write zeroes command supported"),
     FEATURE_ENTRY(VIRTIO_BLK_F_SECURE_ERASE, \
-            "VIRTIO_BLK_F_SECURE_ERASE: Secure erase supported"),
+            "Secure erase supported"),
     FEATURE_ENTRY(VIRTIO_BLK_F_ZONED, \
-            "VIRTIO_BLK_F_ZONED: Zoned block devices"),
+            "Zoned block devices"),
 #ifndef VIRTIO_BLK_NO_LEGACY
     FEATURE_ENTRY(VIRTIO_BLK_F_BARRIER, \
-            "VIRTIO_BLK_F_BARRIER: Request barriers supported"),
+            "Request barriers supported"),
     FEATURE_ENTRY(VIRTIO_BLK_F_SCSI, \
-            "VIRTIO_BLK_F_SCSI: SCSI packet commands supported"),
+            "SCSI packet commands supported"),
     FEATURE_ENTRY(VIRTIO_BLK_F_FLUSH, \
-            "VIRTIO_BLK_F_FLUSH: Flush command supported"),
+            "Flush command supported"),
     FEATURE_ENTRY(VIRTIO_BLK_F_CONFIG_WCE, \
-            "VIRTIO_BLK_F_CONFIG_WCE: Cache writeback and writethrough modes "
-            "supported"),
+            "Cache writeback and writethrough modes supported"),
 #endif /* !VIRTIO_BLK_NO_LEGACY */
     FEATURE_ENTRY(VHOST_F_LOG_ALL, \
-            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
+            "Logging write descriptors supported"),
     FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
-            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
-            "negotiation supported"),
+            "Vhost-user protocol features negotiation supported"),
     { -1, "" }
 };
 #endif
@@ -197,11 +178,11 @@ static const qmp_virtio_feature_map_t virtio_blk_feature_map[] = {
 #ifdef CONFIG_VIRTIO_SERIAL
 static const qmp_virtio_feature_map_t virtio_serial_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_CONSOLE_F_SIZE, \
-            "VIRTIO_CONSOLE_F_SIZE: Host providing console size"),
+            "Host providing console size"),
     FEATURE_ENTRY(VIRTIO_CONSOLE_F_MULTIPORT, \
-            "VIRTIO_CONSOLE_F_MULTIPORT: Multiple ports for device supported"),
+            "Multiple ports for device supported"),
     FEATURE_ENTRY(VIRTIO_CONSOLE_F_EMERG_WRITE, \
-            "VIRTIO_CONSOLE_F_EMERG_WRITE: Emergency write supported"),
+            "Emergency write supported"),
     { -1, "" }
 };
 #endif
@@ -210,21 +191,19 @@ static const qmp_virtio_feature_map_t virtio_serial_feature_map[] = {
 #ifdef CONFIG_VIRTIO_GPU
 static const qmp_virtio_feature_map_t virtio_gpu_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_GPU_F_VIRGL, \
-            "VIRTIO_GPU_F_VIRGL: Virgl 3D mode supported"),
+            "Virgl 3D mode supported"),
     FEATURE_ENTRY(VIRTIO_GPU_F_EDID, \
-            "VIRTIO_GPU_F_EDID: EDID metadata supported"),
+            "EDID metadata supported"),
     FEATURE_ENTRY(VIRTIO_GPU_F_RESOURCE_UUID, \
-            "VIRTIO_GPU_F_RESOURCE_UUID: Resource UUID assigning supported"),
+            "Resource UUID assigning supported"),
     FEATURE_ENTRY(VIRTIO_GPU_F_RESOURCE_BLOB, \
-            "VIRTIO_GPU_F_RESOURCE_BLOB: Size-based blob resources supported"),
+            "Size-based blob resources supported"),
     FEATURE_ENTRY(VIRTIO_GPU_F_CONTEXT_INIT, \
-            "VIRTIO_GPU_F_CONTEXT_INIT: Context types and synchronization "
-            "timelines supported"),
+            "Context types and synchronization timelines supported"),
     FEATURE_ENTRY(VHOST_F_LOG_ALL, \
-            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
+            "Logging write descriptors supported"),
     FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
-            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
-            "negotiation supported"),
+            "Vhost-user protocol features negotiation supported"),
     { -1, "" }
 };
 #endif
@@ -233,10 +212,9 @@ static const qmp_virtio_feature_map_t virtio_gpu_feature_map[] = {
 #ifdef CONFIG_VIRTIO_INPUT
 static const qmp_virtio_feature_map_t virtio_input_feature_map[] = {
     FEATURE_ENTRY(VHOST_F_LOG_ALL, \
-            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
+            "Logging write descriptors supported"),
     FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
-            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
-            "negotiation supported"),
+            "Vhost-user protocol features negotiation supported"),
     { -1, "" }
 };
 #endif
@@ -245,100 +223,88 @@ static const qmp_virtio_feature_map_t virtio_input_feature_map[] = {
 #ifdef CONFIG_VIRTIO_NET
 static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_NET_F_CSUM, \
-            "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum "
-            "supported"),
+            "Device handling packets with partial checksum supported"),
     FEATURE_ENTRY(VIRTIO_NET_F_GUEST_CSUM, \
-            "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial "
-            "checksum supported"),
+            "Driver handling packets with partial checksum supported"),
     FEATURE_ENTRY(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
-            "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading "
-            "reconfig. supported"),
+            "Control channel offloading reconfig. supported"),
     FEATURE_ENTRY(VIRTIO_NET_F_MTU, \
-            "VIRTIO_NET_F_MTU: Device max MTU reporting supported"),
+            "Device max MTU reporting supported"),
     FEATURE_ENTRY(VIRTIO_NET_F_MAC, \
-            "VIRTIO_NET_F_MAC: Device has given MAC address"),
+            "Device has given MAC address"),
     FEATURE_ENTRY(VIRTIO_NET_F_GUEST_TSO4, \
-            "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4"),
+            "Driver can receive TSOv4"),
     FEATURE_ENTRY(VIRTIO_NET_F_GUEST_TSO6, \
-            "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6"),
+            "Driver can receive TSOv6"),
     FEATURE_ENTRY(VIRTIO_NET_F_GUEST_ECN, \
-            "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN"),
+            "Driver can receive TSO with ECN"),
     FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UFO, \
-            "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO"),
+            "Driver can receive UFO"),
     FEATURE_ENTRY(VIRTIO_NET_F_HOST_TSO4, \
-            "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4"),
+            "Device can receive TSOv4"),
     FEATURE_ENTRY(VIRTIO_NET_F_HOST_TSO6, \
-            "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6"),
+            "Device can receive TSOv6"),
     FEATURE_ENTRY(VIRTIO_NET_F_HOST_ECN, \
-            "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN"),
+            "Device can receive TSO with ECN"),
     FEATURE_ENTRY(VIRTIO_NET_F_HOST_UFO, \
-            "VIRTIO_NET_F_HOST_UFO: Device can receive UFO"),
+            "Device can receive UFO"),
     FEATURE_ENTRY(VIRTIO_NET_F_MRG_RXBUF, \
-            "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers"),
+            "Driver can merge receive buffers"),
     FEATURE_ENTRY(VIRTIO_NET_F_STATUS, \
-            "VIRTIO_NET_F_STATUS: Configuration status field available"),
+            "Configuration status field available"),
     FEATURE_ENTRY(VIRTIO_NET_F_CTRL_VQ, \
-            "VIRTIO_NET_F_CTRL_VQ: Control channel available"),
+            "Control channel available"),
     FEATURE_ENTRY(VIRTIO_NET_F_CTRL_RX, \
-            "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported"),
+            "Control channel RX mode supported"),
     FEATURE_ENTRY(VIRTIO_NET_F_CTRL_VLAN, \
-            "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported"),
+            "Control channel VLAN filtering supported"),
     FEATURE_ENTRY(VIRTIO_NET_F_CTRL_RX_EXTRA, \
-            "VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control supported"),
+            "Extra RX mode control supported"),
     FEATURE_ENTRY(VIRTIO_NET_F_GUEST_ANNOUNCE, \
-            "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets "
-            "supported"),
+            "Driver sending gratuitous packets supported"),
     FEATURE_ENTRY(VIRTIO_NET_F_MQ, \
-            "VIRTIO_NET_F_MQ: Multiqueue with automatic receive steering "
-            "supported"),
+            "Multiqueue with automatic receive steering supported"),
     FEATURE_ENTRY(VIRTIO_NET_F_CTRL_MAC_ADDR, \
-            "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control "
-            "channel"),
+            "MAC address set through control channel"),
     FEATURE_ENTRY(VIRTIO_NET_F_NOTF_COAL, \
-            "VIRTIO_NET_F_NOTF_COAL: Device supports coalescing notifications"),
+            "Device supports coalescing notifications"),
     FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO4, \
-            "VIRTIO_NET_F_GUEST_USO4: Driver can receive USOv4"),
+            "Driver can receive USOv4"),
     FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO6, \
-            "VIRTIO_NET_F_GUEST_USO4: Driver can receive USOv6"),
+            "Driver can receive USOv6"),
     FEATURE_ENTRY(VIRTIO_NET_F_HOST_USO, \
-            "VIRTIO_NET_F_HOST_USO: Device can receive USO"),
+            "Device can receive USO"),
     FEATURE_ENTRY(VIRTIO_NET_F_HASH_REPORT, \
-            "VIRTIO_NET_F_HASH_REPORT: Hash reporting supported"),
+            "Hash reporting supported"),
     FEATURE_ENTRY(VIRTIO_NET_F_RSS, \
-            "VIRTIO_NET_F_RSS: RSS RX steering supported"),
+            "RSS RX steering supported"),
     FEATURE_ENTRY(VIRTIO_NET_F_RSC_EXT, \
-            "VIRTIO_NET_F_RSC_EXT: Extended coalescing info supported"),
+            "Extended coalescing info supported"),
     FEATURE_ENTRY(VIRTIO_NET_F_STANDBY, \
-            "VIRTIO_NET_F_STANDBY: Device acting as standby for primary "
-            "device with same MAC addr. supported"),
+            "Device acting as standby for primary device with same MAC addr. "
+            "supported"),
     FEATURE_ENTRY(VIRTIO_NET_F_SPEED_DUPLEX, \
-            "VIRTIO_NET_F_SPEED_DUPLEX: Device set linkspeed and duplex"),
+            "Device set linkspeed and duplex"),
 #ifndef VIRTIO_NET_NO_LEGACY
     FEATURE_ENTRY(VIRTIO_NET_F_GSO, \
-            "VIRTIO_NET_F_GSO: Handling GSO-type packets supported"),
+            "Handling GSO-type packets supported"),
 #endif /* !VIRTIO_NET_NO_LEGACY */
     FEATURE_ENTRY(VHOST_NET_F_VIRTIO_NET_HDR, \
-            "VHOST_NET_F_VIRTIO_NET_HDR: Virtio-net headers for RX and TX "
-            "packets supported"),
+            "Virtio-net headers for RX and TX packets supported"),
     FEATURE_ENTRY(VHOST_F_LOG_ALL, \
-            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
+            "Logging write descriptors supported"),
     FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
-            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
-            "negotiation supported"),
+            "Vhost-user protocol features negotiation supported"),
     FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO, \
-            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "
-            "UDP tunnel packets"),
+            "Driver can receive GSO over UDP tunnel packets"),
     FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM, \
-            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "
-            "UDP tunnel packets requiring checksum offload for the outer "
-            "header"),
+            "Driver can receive GSO over UDP tunnel packets requiring "
+            "checksum offload for the outer header"),
     FEATURE_ENTRY(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO, \
-            "VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO: Device can receive GSO over "
-            "UDP tunnel packets"),
+            "Device can receive GSO over UDP tunnel packets"),
     FEATURE_ENTRY(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM, \
-            "VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM: Device can receive GSO over "
-            "UDP tunnel packets requiring checksum offload for the outer "
-            "header"),
+            "Device can receive GSO over UDP tunnel packets requiring "
+            "checksum offload for the outer header"),
     { -1, "" }
 };
 #endif
@@ -347,21 +313,17 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
 #ifdef CONFIG_VIRTIO_SCSI
 static const qmp_virtio_feature_map_t virtio_scsi_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_SCSI_F_INOUT, \
-            "VIRTIO_SCSI_F_INOUT: Requests including read and writable data "
-            "buffers supported"),
+            "Requests including read and writable data buffers supported"),
     FEATURE_ENTRY(VIRTIO_SCSI_F_HOTPLUG, \
-            "VIRTIO_SCSI_F_HOTPLUG: Reporting and handling hot-plug events "
-            "supported"),
+            "Reporting and handling hot-plug events supported"),
     FEATURE_ENTRY(VIRTIO_SCSI_F_CHANGE, \
-            "VIRTIO_SCSI_F_CHANGE: Reporting and handling LUN changes "
-            "supported"),
+            "Reporting and handling LUN changes supported"),
     FEATURE_ENTRY(VIRTIO_SCSI_F_T10_PI, \
-            "VIRTIO_SCSI_F_T10_PI: T10 info included in request header"),
+            "T10 info included in request header"),
     FEATURE_ENTRY(VHOST_F_LOG_ALL, \
-            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
+            "Logging write descriptors supported"),
     FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
-            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
-            "negotiation supported"),
+            "Vhost-user protocol features negotiation supported"),
     { -1, "" }
 };
 #endif
@@ -370,10 +332,9 @@ static const qmp_virtio_feature_map_t virtio_scsi_feature_map[] = {
 #ifdef CONFIG_VHOST_USER_FS
 static const qmp_virtio_feature_map_t virtio_fs_feature_map[] = {
     FEATURE_ENTRY(VHOST_F_LOG_ALL, \
-            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
+            "Logging write descriptors supported"),
     FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
-            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
-            "negotiation supported"),
+            "Vhost-user protocol features negotiation supported"),
     { -1, "" }
 };
 #endif
@@ -382,12 +343,11 @@ static const qmp_virtio_feature_map_t virtio_fs_feature_map[] = {
 #ifdef CONFIG_VIRTIO_I2C_ADAPTER
 static const qmp_virtio_feature_map_t virtio_i2c_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_I2C_F_ZERO_LENGTH_REQUEST, \
-            "VIRTIO_I2C_F_ZERO_LEGNTH_REQUEST: Zero length requests supported"),
+            "Zero length requests supported"),
     FEATURE_ENTRY(VHOST_F_LOG_ALL, \
-            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
+            "Logging write descriptors supported"),
     FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
-            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
-            "negotiation supported"),
+            "Vhost-user protocol features negotiation supported"),
     { -1, "" }
 };
 #endif
@@ -396,12 +356,11 @@ static const qmp_virtio_feature_map_t virtio_i2c_feature_map[] = {
 #ifdef CONFIG_VHOST_VSOCK
 static const qmp_virtio_feature_map_t virtio_vsock_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_VSOCK_F_SEQPACKET, \
-            "VIRTIO_VSOCK_F_SEQPACKET: SOCK_SEQPACKET supported"),
+            "SOCK_SEQPACKET supported"),
     FEATURE_ENTRY(VHOST_F_LOG_ALL, \
-            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
+            "Logging write descriptors supported"),
     FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
-            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
-            "negotiation supported"),
+            "Vhost-user protocol features negotiation supported"),
     { -1, "" }
 };
 #endif
@@ -410,18 +369,17 @@ static const qmp_virtio_feature_map_t virtio_vsock_feature_map[] = {
 #ifdef CONFIG_VIRTIO_BALLOON
 static const qmp_virtio_feature_map_t virtio_balloon_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_BALLOON_F_MUST_TELL_HOST, \
-            "VIRTIO_BALLOON_F_MUST_TELL_HOST: Tell host before reclaiming "
-            "pages"),
+            "Tell host before reclaiming pages"),
     FEATURE_ENTRY(VIRTIO_BALLOON_F_STATS_VQ, \
-            "VIRTIO_BALLOON_F_STATS_VQ: Guest memory stats VQ available"),
+            "Guest memory stats VQ available"),
     FEATURE_ENTRY(VIRTIO_BALLOON_F_DEFLATE_ON_OOM, \
-            "VIRTIO_BALLOON_F_DEFLATE_ON_OOM: Deflate balloon when guest OOM"),
+            "Deflate balloon when guest OOM"),
     FEATURE_ENTRY(VIRTIO_BALLOON_F_FREE_PAGE_HINT, \
-            "VIRTIO_BALLOON_F_FREE_PAGE_HINT: VQ reporting free pages enabled"),
+            "VQ reporting free pages enabled"),
     FEATURE_ENTRY(VIRTIO_BALLOON_F_PAGE_POISON, \
-            "VIRTIO_BALLOON_F_PAGE_POISON: Guest page poisoning enabled"),
+            "Guest page poisoning enabled"),
     FEATURE_ENTRY(VIRTIO_BALLOON_F_REPORTING, \
-            "VIRTIO_BALLOON_F_REPORTING: Page reporting VQ enabled"),
+            "Page reporting VQ enabled"),
     { -1, "" }
 };
 #endif
@@ -430,7 +388,7 @@ static const qmp_virtio_feature_map_t virtio_balloon_feature_map[] = {
 #ifdef CONFIG_VIRTIO_CRYPTO
 static const qmp_virtio_feature_map_t virtio_crypto_feature_map[] = {
     FEATURE_ENTRY(VHOST_F_LOG_ALL, \
-            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
+            "Logging write descriptors supported"),
     { -1, "" }
 };
 #endif
@@ -439,23 +397,19 @@ static const qmp_virtio_feature_map_t virtio_crypto_feature_map[] = {
 #ifdef CONFIG_VIRTIO_IOMMU
 static const qmp_virtio_feature_map_t virtio_iommu_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_IOMMU_F_INPUT_RANGE, \
-            "VIRTIO_IOMMU_F_INPUT_RANGE: Range of available virtual addrs. "
-            "available"),
+            "Range of available virtual addrs. available"),
     FEATURE_ENTRY(VIRTIO_IOMMU_F_DOMAIN_RANGE, \
-            "VIRTIO_IOMMU_F_DOMAIN_RANGE: Number of supported domains "
-            "available"),
+            "Number of supported domains available"),
     FEATURE_ENTRY(VIRTIO_IOMMU_F_MAP_UNMAP, \
-            "VIRTIO_IOMMU_F_MAP_UNMAP: Map and unmap requests available"),
+            "Map and unmap requests available"),
     FEATURE_ENTRY(VIRTIO_IOMMU_F_BYPASS, \
-            "VIRTIO_IOMMU_F_BYPASS: Endpoints not attached to domains are in "
-            "bypass mode"),
+            "Endpoints not attached to domains are in bypass mode"),
     FEATURE_ENTRY(VIRTIO_IOMMU_F_PROBE, \
-            "VIRTIO_IOMMU_F_PROBE: Probe requests available"),
+            "Probe requests available"),
     FEATURE_ENTRY(VIRTIO_IOMMU_F_MMIO, \
-            "VIRTIO_IOMMU_F_MMIO: VIRTIO_IOMMU_MAP_F_MMIO flag available"),
+            "VIRTIO_IOMMU_MAP_F_MMIO flag available"),
     FEATURE_ENTRY(VIRTIO_IOMMU_F_BYPASS_CONFIG, \
-            "VIRTIO_IOMMU_F_BYPASS_CONFIG: Bypass field of IOMMU config "
-            "available"),
+            "Bypass field of IOMMU config available"),
     { -1, "" }
 };
 #endif
@@ -465,14 +419,12 @@ static const qmp_virtio_feature_map_t virtio_iommu_feature_map[] = {
 static const qmp_virtio_feature_map_t virtio_mem_feature_map[] = {
 #ifndef CONFIG_ACPI
     FEATURE_ENTRY(VIRTIO_MEM_F_ACPI_PXM, \
-            "VIRTIO_MEM_F_ACPI_PXM: node_id is an ACPI PXM and is valid"),
+            "node_id is an ACPI PXM and is valid"),
 #endif /* !CONFIG_ACPI */
     FEATURE_ENTRY(VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE, \
-            "VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE: Unplugged memory cannot be "
-            "accessed"),
+            "Unplugged memory cannot be accessed"),
     FEATURE_ENTRY(VIRTIO_MEM_F_PERSISTENT_SUSPEND, \
-            "VIRTIO_MEM_F_PERSISTENT_SUSPND: Plugged memory will remain "
-            "plugged when suspending+resuming"),
+            "Plugged memory will remain plugged when suspending+resuming"),
     { -1, "" }
 };
 #endif
@@ -481,10 +433,9 @@ static const qmp_virtio_feature_map_t virtio_mem_feature_map[] = {
 #ifdef CONFIG_VIRTIO_RNG
 static const qmp_virtio_feature_map_t virtio_rng_feature_map[] = {
     FEATURE_ENTRY(VHOST_F_LOG_ALL, \
-            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
+            "Logging write descriptors supported"),
     FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
-            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
-            "negotiation supported"),
+            "Vhost-user protocol features negotiation supported"),
     { -1, "" }
 };
 #endif
@@ -493,10 +444,9 @@ static const qmp_virtio_feature_map_t virtio_rng_feature_map[] = {
 #ifdef CONFIG_VHOST_USER_GPIO
 static const qmp_virtio_feature_map_t virtio_gpio_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_GPIO_F_IRQ, \
-            "VIRTIO_GPIO_F_IRQ: Device supports interrupts on GPIO lines"),
+            "Device supports interrupts on GPIO lines"),
     FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
-            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
-            "negotiation supported"),
+            "Vhost-user protocol features negotiation supported"),
     { -1, "" }
 };
 #endif
-- 
2.51.0


