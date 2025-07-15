Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8ACC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 16:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubiyC-0006Fu-6V; Tue, 15 Jul 2025 12:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubieu-000777-H6
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:37:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubies-0003lC-Bu
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752597453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y9Eb4jmQL/CVQhW73EPjMP8leZzdguYizDLV8dnGxc4=;
 b=gd75Ftm7S3p31JvDk0NyrHlIQopP1UWhpfDLBELD9qfdmCEqc7Vmautzf2dTuuQiGGXc0G
 0LUfQYLhu868mw3jgztt9rn8RtB+XHxcYswHhIgqh77QV2AOn7lXcySZxjFjmb2qMwMIq+
 jiuB3rWtA5416HeDMoVoPTbFYkybbUM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-wIf7w5FZPcuAp6lDmhKscQ-1; Tue,
 15 Jul 2025 12:37:32 -0400
X-MC-Unique: wIf7w5FZPcuAp6lDmhKscQ-1
X-Mimecast-MFC-AGG-ID: wIf7w5FZPcuAp6lDmhKscQ_1752597451
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E891B18002A8; Tue, 15 Jul 2025 16:37:30 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.160])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A384C3000198; Tue, 15 Jul 2025 16:37:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 7/7] vfio/migration: Max in-flight VFIO device state buffers
 size limit
Date: Tue, 15 Jul 2025 18:37:03 +0200
Message-ID: <20250715163703.243975-8-clg@redhat.com>
In-Reply-To: <20250715163703.243975-1-clg@redhat.com>
References: <20250715163703.243975-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Allow capping the maximum total size of in-flight VFIO device state buffers
queued at the destination, otherwise a malicious QEMU source could
theoretically cause the target QEMU to allocate unlimited amounts of memory
for buffers-in-flight.

Since this is not expected to be a realistic threat in most of VFIO live
migration use cases and the right value depends on the particular setup
disable this limit by default by setting it to UINT64_MAX.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/qemu-devel/4f7cad490988288f58e36b162d7a888ed7e7fd17.1752589295.git.maciej.szmigiero@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/devel/migration/vfio.rst | 13 +++++++++++++
 include/hw/vfio/vfio-device.h |  1 +
 hw/vfio/migration-multifd.c   | 21 +++++++++++++++++++--
 hw/vfio/pci.c                 |  9 +++++++++
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
index dae3a988307fedf00f83926b96fd3d2b9a1c56f7..0790e5031d8f81b257228f124020586c951647bc 100644
--- a/docs/devel/migration/vfio.rst
+++ b/docs/devel/migration/vfio.rst
@@ -248,6 +248,19 @@ The multifd VFIO device state transfer is controlled by
 AUTO, which means that VFIO device state transfer via multifd channels is
 attempted in configurations that otherwise support it.
 
+Since the target QEMU needs to load device state buffers in-order it needs to
+queue incoming buffers until they can be loaded into the device.
+This means that a malicious QEMU source could theoretically cause the target
+QEMU to allocate unlimited amounts of memory for such buffers-in-flight.
+
+The "x-migration-max-queued-buffers-size" property allows capping the total size
+of these VFIO device state buffers queued at the destination.
+
+Because a malicious QEMU source causing OOM on the target is not expected to be
+a realistic threat in most of VFIO live migration use cases and the right value
+depends on the particular setup by default this queued buffers size limit is
+disabled by setting it to UINT64_MAX.
+
 Some host platforms (like ARM64) require that VFIO device config is loaded only
 after all iterables were loaded, during non-iterables loading phase.
 Such interlocking is controlled by "x-migration-load-config-after-iter" VFIO
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index dac3fdce1539b19937870c0e38027e0a6b6ed1a9..6e4d5ccdac6eaae32fb2d3a59b9c7c85e13e156a 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -68,6 +68,7 @@ typedef struct VFIODevice {
     OnOffAuto enable_migration;
     OnOffAuto migration_multifd_transfer;
     OnOffAuto migration_load_config_after_iter;
+    uint64_t migration_max_queued_buffers_size;
     bool migration_events;
     bool use_region_fds;
     VFIODeviceOps *ops;
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index e539befaa925ac739e3bc87ddb2abbb3d50f7cf5..d522671b8d620ca7a1ebdc0c0a90ba48e9bd741e 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -72,6 +72,7 @@ typedef struct VFIOMultifd {
     QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
     uint32_t load_buf_idx;
     uint32_t load_buf_idx_last;
+    size_t load_buf_queued_pending_buffers_size;
 } VFIOMultifd;
 
 static void vfio_state_buffer_clear(gpointer data)
@@ -128,6 +129,7 @@ static bool vfio_load_state_buffer_insert(VFIODevice *vbasedev,
     VFIOMigration *migration = vbasedev->migration;
     VFIOMultifd *multifd = migration->multifd;
     VFIOStateBuffer *lb;
+    size_t data_size = packet_total_size - sizeof(*packet);
 
     vfio_state_buffers_assert_init(&multifd->load_bufs);
     if (packet->idx >= vfio_state_buffers_size_get(&multifd->load_bufs)) {
@@ -143,8 +145,19 @@ static bool vfio_load_state_buffer_insert(VFIODevice *vbasedev,
 
     assert(packet->idx >= multifd->load_buf_idx);
 
-    lb->data = g_memdup2(&packet->data, packet_total_size - sizeof(*packet));
-    lb->len = packet_total_size - sizeof(*packet);
+    multifd->load_buf_queued_pending_buffers_size += data_size;
+    if (multifd->load_buf_queued_pending_buffers_size >
+        vbasedev->migration_max_queued_buffers_size) {
+        error_setg(errp,
+                   "%s: queuing state buffer %" PRIu32
+                   " would exceed the size max of %" PRIu64,
+                   vbasedev->name, packet->idx,
+                   vbasedev->migration_max_queued_buffers_size);
+        return false;
+    }
+
+    lb->data = g_memdup2(&packet->data, data_size);
+    lb->len = data_size;
     lb->is_present = true;
 
     return true;
@@ -328,6 +341,9 @@ static bool vfio_load_state_buffer_write(VFIODevice *vbasedev,
         assert(wr_ret <= buf_len);
         buf_len -= wr_ret;
         buf_cur += wr_ret;
+
+        assert(multifd->load_buf_queued_pending_buffers_size >= wr_ret);
+        multifd->load_buf_queued_pending_buffers_size -= wr_ret;
     }
 
     trace_vfio_load_state_device_buffer_load_end(vbasedev->name,
@@ -497,6 +513,7 @@ static VFIOMultifd *vfio_multifd_new(void)
 
     multifd->load_buf_idx = 0;
     multifd->load_buf_idx_last = UINT32_MAX;
+    multifd->load_buf_queued_pending_buffers_size = 0;
     qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
 
     multifd->load_bufs_iter_done = false;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 09acad002a47fd333d426cee2dcc9cacbbcb2e2f..be05002b9819fafa45cf2fb4d2a0acdc475c558c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3645,6 +3645,8 @@ static const Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("x-migration-load-config-after-iter", VFIOPCIDevice,
                             vbasedev.migration_load_config_after_iter,
                             ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_SIZE("x-migration-max-queued-buffers-size", VFIOPCIDevice,
+                     vbasedev.migration_max_queued_buffers_size, UINT64_MAX),
     DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
                      vbasedev.migration_events, false),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
@@ -3828,6 +3830,13 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
                                           "non-iterables loading phase) when "
                                           "doing live migration of device state "
                                           "via multifd channels");
+    object_class_property_set_description(klass, /* 10.1 */
+                                          "x-migration-max-queued-buffers-size",
+                                          "Maximum size of in-flight VFIO "
+                                          "device state buffers queued at the "
+                                          "destination when doing live "
+                                          "migration of device state via "
+                                          "multifd channels");
 }
 
 static const TypeInfo vfio_pci_dev_info = {
-- 
2.50.1


