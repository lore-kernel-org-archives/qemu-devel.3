Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3B7D3000A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1n21-0005kJ-GD; Fri, 18 Oct 2024 09:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t1n1x-0005iM-Td
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:28:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t1n1v-0007Pp-TY
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729258114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QQRxXRqdTuUACav3jzy7aDxOljOguqE9mvLS15D3YOc=;
 b=CWYSdxtqYpp9SpUqr8PDAsQEgD5xun13R/KTYi8Y9lK4/U7em+kaIjtaY4LEsytr0PzwTP
 v+9f3k5sni83DRp5W+j+3JIMG4sNmKIScRsCDVL8ix17PO0nw3TxL0WwxHZ6iHn5PT8+Vy
 9DAFC3NHuryMozFHSkuCDACqraYvCr0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-4EgQKPWtPeGSi1oIjC4gIw-1; Fri,
 18 Oct 2024 09:28:31 -0400
X-MC-Unique: 4EgQKPWtPeGSi1oIjC4gIw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DF2A19560BA; Fri, 18 Oct 2024 13:28:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.150])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D386119560A3; Fri, 18 Oct 2024 13:28:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5512621E688F; Fri, 18 Oct 2024 15:28:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/9] block: Adjust check_block_size() signature
Date: Fri, 18 Oct 2024 15:28:20 +0200
Message-ID: <20241018132824.3379780-6-armbru@redhat.com>
In-Reply-To: <20241018132824.3379780-1-armbru@redhat.com>
References: <20241018132824.3379780-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Parameter @id is no longer used, drop.  Return a bool to indicate
success / failure, as recommended by qapi/error.h.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20241010150144.986655-4-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 util/block-helpers.h                 |  3 +--
 block/export/vduse-blk.c             |  7 ++-----
 block/export/vhost-user-blk-server.c |  6 +-----
 hw/core/qdev-properties-system.c     |  6 +-----
 util/block-helpers.c                 | 10 ++++++----
 5 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/util/block-helpers.h b/util/block-helpers.h
index b53295a529..838b0825f6 100644
--- a/util/block-helpers.h
+++ b/util/block-helpers.h
@@ -13,7 +13,6 @@
 #define MAX_BLOCK_SIZE          (2 * MiB)
 #define MAX_BLOCK_SIZE_STR      "2 MiB"
 
-void check_block_size(const char *id, const char *name, int64_t value,
-                      Error **errp);
+bool check_block_size(const char *name, int64_t value, Error **errp);
 
 #endif /* BLOCK_HELPERS_H */
diff --git a/block/export/vduse-blk.c b/block/export/vduse-blk.c
index 172f73cef4..bd852e538d 100644
--- a/block/export/vduse-blk.c
+++ b/block/export/vduse-blk.c
@@ -273,7 +273,6 @@ static int vduse_blk_exp_create(BlockExport *exp, BlockExportOptions *opts,
     uint64_t logical_block_size = VIRTIO_BLK_SECTOR_SIZE;
     uint16_t num_queues = VDUSE_DEFAULT_NUM_QUEUE;
     uint16_t queue_size = VDUSE_DEFAULT_QUEUE_SIZE;
-    Error *local_err = NULL;
     struct virtio_blk_config config = { 0 };
     uint64_t features;
     int i, ret;
@@ -297,10 +296,8 @@ static int vduse_blk_exp_create(BlockExport *exp, BlockExportOptions *opts,
 
     if (vblk_opts->has_logical_block_size) {
         logical_block_size = vblk_opts->logical_block_size;
-        check_block_size(exp->id, "logical-block-size", logical_block_size,
-                         &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (!check_block_size("logical-block-size", logical_block_size,
+                              errp)) {
             return -EINVAL;
         }
     }
diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
index 50c358e8cd..d9d2014d9b 100644
--- a/block/export/vhost-user-blk-server.c
+++ b/block/export/vhost-user-blk-server.c
@@ -319,7 +319,6 @@ static int vu_blk_exp_create(BlockExport *exp, BlockExportOptions *opts,
 {
     VuBlkExport *vexp = container_of(exp, VuBlkExport, export);
     BlockExportOptionsVhostUserBlk *vu_opts = &opts->u.vhost_user_blk;
-    Error *local_err = NULL;
     uint64_t logical_block_size;
     uint16_t num_queues = VHOST_USER_BLK_NUM_QUEUES_DEFAULT;
 
@@ -330,10 +329,7 @@ static int vu_blk_exp_create(BlockExport *exp, BlockExportOptions *opts,
     } else {
         logical_block_size = VIRTIO_BLK_SECTOR_SIZE;
     }
-    check_block_size(exp->id, "logical-block-size", logical_block_size,
-                     &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!check_block_size("logical-block-size", logical_block_size, errp)) {
         return -EINVAL;
     }
 
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 60bcd821de..35deef05f3 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -588,18 +588,14 @@ const PropertyInfo qdev_prop_losttickpolicy = {
 static void set_blocksize(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
-    DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     uint32_t *ptr = object_field_prop_ptr(obj, prop);
     uint64_t value;
-    Error *local_err = NULL;
 
     if (!visit_type_size(v, name, &value, errp)) {
         return;
     }
-    check_block_size(dev->id ? : "", name, value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!check_block_size(name, value, errp)) {
         return;
     }
     *ptr = value;
diff --git a/util/block-helpers.c b/util/block-helpers.c
index fb5de348e2..052b4e1476 100644
--- a/util/block-helpers.c
+++ b/util/block-helpers.c
@@ -14,7 +14,6 @@
 
 /**
  * check_block_size:
- * @id: The unique ID of the object
  * @name: The name of the property being validated
  * @value: The block size in bytes
  * @errp: A pointer to an area to store an error
@@ -23,13 +22,14 @@
  * 1. At least MIN_BLOCK_SIZE
  * 2. No larger than MAX_BLOCK_SIZE
  * 3. A power of 2
+ *
+ * Returns: true on success, false on failure
  */
-void check_block_size(const char *id, const char *name, int64_t value,
-                      Error **errp)
+bool check_block_size(const char *name, int64_t value, Error **errp)
 {
     if (!value) {
         /* unset */
-        return;
+        return true;
     }
 
     if (value < MIN_BLOCK_SIZE || value > MAX_BLOCK_SIZE
@@ -38,5 +38,7 @@ void check_block_size(const char *id, const char *name, int64_t value,
                    "parameter %s must be a power of 2 between %" PRId64
                    " and %" PRId64,
                    name, MIN_BLOCK_SIZE, MAX_BLOCK_SIZE);
+        return false;
     }
+    return true;
 }
-- 
2.46.0


