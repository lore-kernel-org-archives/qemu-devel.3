Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70698C54E49
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 05:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjv1U-00086j-Qq; Tue, 12 Mar 2024 01:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjv1S-00086U-U2
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 01:49:59 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjv1Q-0007yJ-DS
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 01:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710222596; x=1741758596;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=poBSj/TwH45qU4orRVv9VqC5G11e9zHu2p+rfihjyoI=;
 b=ffGNwfyttzhfuHBqcfm0hzMPhnFOYsZ4R7tguYVK2ejcfOeD3s5f9HKU
 SQ/pFOk9t4SNAnxWC2Asf6Yg8+39L5bzaPtDQcLQe4vTE9xruVmNSk6I0
 sG1GWkOtKkDxIBsJQf5eHve2WEUWjd38FJlIZYVRgSt7VoHyjrtIZ9tSV
 yKer9z92FFuQytKGqvgUKm+39j+3fpAAcd+SD+LMdJIm/AKL5blTxgote
 ADSG7Z1SFQy6fqwK9aE+fvfV8jGYEpHo0UKQlML55FJA3Z0oFcQXd8M0Y
 WziIXDSPmRU+BxkPfAZmRJ8K5Y2stA8AMLJWh5ByJmDiz5uDq+nTObVde Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4769769"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="4769769"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2024 22:49:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; d="scan'208";a="42415161"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 11 Mar 2024 22:49:52 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] error: Move ERRP_GUARD() to the beginning of the function
Date: Tue, 12 Mar 2024 14:03:37 +0800
Message-Id: <20240312060337.3240965-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.17;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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
---
 * Inspired by Markus' original cleanup and copied his commit message.
---
 block.c                    | 2 +-
 block/qapi.c               | 6 +++---
 hw/s390x/s390-virtio-ccw.c | 2 +-
 migration/options.c        | 2 +-
 migration/postcopy-ram.c   | 4 ++--
 net/vhost-vdpa.c           | 3 +--
 6 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index 1ed9214f66ed..8a43a83c11ca 100644
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
index 9e806fa230d8..31183d493341 100644
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
index 62804cc2281d..4b6aab8eef98 100644
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
index 40eb9309401c..80f49a6a8562 100644
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
index 0273dc6a94ac..eccff499cb20 100644
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
index e6bdb4562dde..a80d8d974f4a 100644
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
2.34.1


