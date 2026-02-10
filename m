Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA72DEA8105
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 12:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpmif-00005z-0Y; Tue, 10 Feb 2026 07:19:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpmgq-0005Bn-PU; Tue, 10 Feb 2026 07:18:01 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpmgo-00016v-R1; Tue, 10 Feb 2026 07:18:00 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3B889187DC1;
 Tue, 10 Feb 2026 15:14:47 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id CC891360CE6;
 Tue, 10 Feb 2026 15:15:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Joelle van Dyne <j@getutm.app>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.4 89/95] virtio-gpu-virgl: correct parent for blob
 memory region
Date: Tue, 10 Feb 2026 15:15:11 +0300
Message-ID: <20260210121526.68598-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.4-20260210151454@cover.tls.msk.ru>
References: <qemu-stable-10.1.4-20260210151454@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Joelle van Dyne <j@getutm.app>

When `owner` == `mr`, `object_unparent` will crash:

object_unparent(mr) ->
object_property_del_child(mr, mr) ->
object_finalize_child_property(mr, name, mr) ->
object_unref(mr) ->
object_finalize(mr) ->
object_property_del_all(mr) ->
object_finalize_child_property(mr, name, mr) ->
object_unref(mr) ->
fail on g_assert(obj->ref > 0)

However, passing a different `owner` to `memory_region_init` does not
work. `memory_region_ref` has an optimization where it takes a ref
only on the owner. That means when flatviews are created, it does not
take a ref on the region and you can get a UAF from `flatview_destroy`
called from RCU.

The correct fix therefore is to use `NULL` as the name which will set
the `owner` but not the `parent` (which is still NULL). This allows us
to use `memory_region_ref` on itself while not having to rely on unparent
for cleanup.

Signed-off-by: Joelle van Dyne <j@getutm.app>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260103214400.71694-1-j@getutm.app>
(cherry picked from commit e27194e087aede62dbe3d2805c6f1aa30d3465df)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 94ddc01f91..ca34704acb 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -120,7 +120,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
     vmr->g = g;
 
     mr = &vmr->mr;
-    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
+    memory_region_init_ram_ptr(mr, OBJECT(mr), NULL, size, data);
     memory_region_add_subregion(&b->hostmem, offset, mr);
     memory_region_set_enabled(mr, true);
 
@@ -182,7 +182,7 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
         /* memory region owns self res->mr object and frees it by itself */
         memory_region_set_enabled(mr, false);
         memory_region_del_subregion(&b->hostmem, mr);
-        object_unparent(OBJECT(mr));
+        object_unref(OBJECT(mr));
     }
 
     return 0;
-- 
2.47.3


