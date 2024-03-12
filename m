Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8A8C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1VQ-00050j-WD; Tue, 12 Mar 2024 08:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1V2-0004MN-43
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:44:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1Uy-0000WA-FC
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710247491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2IQbN6P+BTrU+9HKX0IdXd/CCW4IHYIIvjA++wy0/jo=;
 b=G1bM0rTY9em/J4W4+lGRPmnoz+7WaOvc6Voxx25WtBxAqvcLutEAOs8bq5RlcJwqa2jcN7
 auL6V5S04b3+yjufbEgYJjvwQmm+rHXMxAIHudhjz7BwspdMz6N/Gw/sydwsOFmMxMhGUN
 tKe1Fdn/e4qrkhlhGIxCBbDWW2+YekE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-k7HMIa_8P7SE_pcfkDFijg-1; Tue,
 12 Mar 2024 08:44:48 -0400
X-MC-Unique: k7HMIa_8P7SE_pcfkDFijg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20FE01C41A0D;
 Tue, 12 Mar 2024 12:44:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E3E1492BC4;
 Tue, 12 Mar 2024 12:44:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 33/55] error: Move ERRP_GUARD() to the beginning of the function
Date: Tue, 12 Mar 2024 13:43:17 +0100
Message-ID: <20240312124339.761630-34-thuth@redhat.com>
In-Reply-To: <20240312124339.761630-1-thuth@redhat.com>
References: <20240312124339.761630-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Since the commit 05e385d2a9 ("error: Move ERRP_GUARD() to the beginning
of the function"), there are new codes that don't put ERRP_GUARD() at
the beginning of the functions.

As stated in the commit 05e385d2a9: "include/qapi/error.h advises to put
ERRP_GUARD() right at the beginning of the function, because only then
can it guard the whole function.", so clean up the few spots
disregarding the advice.

Inspired-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240312060337.3240965-1-zhao1.liu@linux.intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 block.c                    | 2 +-
 block/qapi.c               | 6 +++---
 hw/s390x/s390-virtio-ccw.c | 2 +-
 migration/options.c        | 2 +-
 migration/postcopy-ram.c   | 4 ++--
 net/vhost-vdpa.c           | 3 +--
 6 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index cf66c767a0..468cf5e67d 100644
--- a/block.c
+++ b/block.c
@@ -534,9 +534,9 @@ typedef struct CreateCo {
 int coroutine_fn bdrv_co_create(BlockDriver *drv, const char *filename,
                                 QemuOpts *opts, Error **errp)
 {
+    ERRP_GUARD();
     int ret;
     GLOBAL_STATE_CODE();
-    ERRP_GUARD();
 
     if (!drv->bdrv_co_create_opts) {
         error_setg(errp, "Driver '%s' does not support image creation",
diff --git a/block/qapi.c b/block/qapi.c
index 9e806fa230..31183d4933 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -46,11 +46,11 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
                                         bool flat,
                                         Error **errp)
 {
+    ERRP_GUARD();
     ImageInfo **p_image_info;
     ImageInfo *backing_info;
     BlockDriverState *backing;
     BlockDeviceInfo *info;
-    ERRP_GUARD();
 
     if (!bs->drv) {
         error_setg(errp, "Block device %s is ejected", bs->node_name);
@@ -330,8 +330,8 @@ void bdrv_query_image_info(BlockDriverState *bs,
                            bool skip_implicit_filters,
                            Error **errp)
 {
-    ImageInfo *info;
     ERRP_GUARD();
+    ImageInfo *info;
 
     info = g_new0(ImageInfo, 1);
     bdrv_do_query_node_info(bs, qapi_ImageInfo_base(info), errp);
@@ -382,10 +382,10 @@ void bdrv_query_block_graph_info(BlockDriverState *bs,
                                  BlockGraphInfo **p_info,
                                  Error **errp)
 {
+    ERRP_GUARD();
     BlockGraphInfo *info;
     BlockChildInfoList **children_list_tail;
     BdrvChild *c;
-    ERRP_GUARD();
 
     info = g_new0(BlockGraphInfo, 1);
     bdrv_do_query_node_info(bs, qapi_BlockGraphInfo_base(info), errp);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 62804cc228..4b6aab8eef 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -312,9 +312,9 @@ static void ccw_init(MachineState *machine)
 static void s390_cpu_plug(HotplugHandler *hotplug_dev,
                         DeviceState *dev, Error **errp)
 {
+    ERRP_GUARD();
     MachineState *ms = MACHINE(hotplug_dev);
     S390CPU *cpu = S390_CPU(dev);
-    ERRP_GUARD();
 
     g_assert(!ms->possible_cpus->cpus[cpu->env.core_id].cpu);
     ms->possible_cpus->cpus[cpu->env.core_id].cpu = OBJECT(dev);
diff --git a/migration/options.c b/migration/options.c
index caff0a271d..cf253266db 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -478,9 +478,9 @@ static bool migrate_incoming_started(void)
  */
 bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
 {
+    ERRP_GUARD();
     MigrationIncomingState *mis = migration_incoming_get_current();
 
-    ERRP_GUARD();
 #ifndef CONFIG_LIVE_BLOCK_MIGRATION
     if (new_caps[MIGRATION_CAPABILITY_BLOCK]) {
         error_setg(errp, "QEMU compiled without old-style (blk/-b, inc/-i) "
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 0273dc6a94..eccff499cb 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -283,10 +283,10 @@ static bool request_ufd_features(int ufd, uint64_t features)
 static bool ufd_check_and_apply(int ufd, MigrationIncomingState *mis,
                                 Error **errp)
 {
+    ERRP_GUARD();
     uint64_t asked_features = 0;
     static uint64_t supported_features;
 
-    ERRP_GUARD();
     /*
      * it's not possible to
      * request UFFD_API twice per one fd
@@ -371,6 +371,7 @@ static int test_ramblock_postcopiable(RAMBlock *rb, Error **errp)
  */
 bool postcopy_ram_supported_by_host(MigrationIncomingState *mis, Error **errp)
 {
+    ERRP_GUARD();
     long pagesize = qemu_real_host_page_size();
     int ufd = -1;
     bool ret = false; /* Error unless we change it */
@@ -380,7 +381,6 @@ bool postcopy_ram_supported_by_host(MigrationIncomingState *mis, Error **errp)
     uint64_t feature_mask;
     RAMBlock *block;
 
-    ERRP_GUARD();
     if (qemu_target_page_size() > pagesize) {
         error_setg(errp, "Target page size bigger than host page size");
         goto out;
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index d81baecbc1..ef9fc543b1 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1557,14 +1557,13 @@ static const VhostShadowVirtqueueOps vhost_vdpa_net_svq_ops = {
 static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t features,
                                           int cvq_index, Error **errp)
 {
+    ERRP_GUARD();
     uint64_t backend_features;
     int64_t cvq_group;
     uint8_t status = VIRTIO_CONFIG_S_ACKNOWLEDGE |
                      VIRTIO_CONFIG_S_DRIVER;
     int r;
 
-    ERRP_GUARD();
-
     r = ioctl(device_fd, VHOST_GET_BACKEND_FEATURES, &backend_features);
     if (unlikely(r < 0)) {
         error_setg_errno(errp, errno, "Cannot get vdpa backend_features");
-- 
2.44.0


