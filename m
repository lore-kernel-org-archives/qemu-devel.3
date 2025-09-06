Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B404CA1016
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 02:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuiwe-0006Mc-SA; Fri, 05 Sep 2025 22:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uuiwZ-0006EU-Cy; Fri, 05 Sep 2025 22:46:23 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uuiwN-0006H0-6x; Fri, 05 Sep 2025 22:46:23 -0400
Received: from [10.40.4.92] (93-51-222-138.ip268.fastwebnet.it [93.51.222.138])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5862dKwb051529
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 6 Sep 2025 11:39:48 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=8qvt6Xu9ZZwiZL7zcLR0bMvNJ+rN/ITG3u8ee6Er6qU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1757126398; v=1;
 b=YCEUaVuhQsiQYCaK8ArTMToJrhX8n+kR1sWtWFKtUfQWEJrrRr9+INac8gT/xYuk
 bFbr7QDUG3sQLiUYSkJK6JY0E1pX80lJjOsrIO8DpVGowpbtcC3+fAmFm5nuMV/Q
 XpN5dsRNgRnlOyJIJEUYvkDxIZmn8dNgFtZ4Fivev+MBuDBGtG+EdJ8v7coNWw79
 +52MYKF+2wxrDr9s4IlLh83GuneCkv16aTjkc1Zu6SuHJSBaqAn48OrgTtm+sucb
 4iF2a5Kuf82+CLOIbtW/+XJZ9bwoxRLIk41lbyPh4y6tR9K4qCD6uh4VXeG5D855
 uf370mIxWYy2MFtfrPn0zw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 06 Sep 2025 04:39:05 +0200
Subject: [PATCH v2 2/3] virtio-gpu-virgl: Add
 virtio-gpu-virgl-hostmem-region type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-mr-v2-2-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
References: <20250906-mr-v2-0-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250906-mr-v2-0-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

virtio-gpu-virgl used to set Object::free() of memory regions, but
memory regions are going to have its own implementation of the
function.

Add the virtio-gpu-virgl-hostmem-region type, which contains a
memory region and performs what Object::free() did during finalization.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu-virgl.c | 51 ++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 94ddc01f91c6..f5cba8a7fa66 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -52,11 +52,18 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
 
 #if VIRGL_VERSION_MAJOR >= 1
 struct virtio_gpu_virgl_hostmem_region {
+    Object parent_obj;
     MemoryRegion mr;
     struct VirtIOGPU *g;
     bool finish_unmapping;
 };
 
+#define TYPE_VIRTIO_GPU_VIRGL_HOSTMEM_REGION "virtio-gpu-virgl-hostmem-region"
+
+DECLARE_INSTANCE_CHECKER(struct virtio_gpu_virgl_hostmem_region,
+                         VIRTIO_GPU_VIRGL_HOSTMEM_REGION,
+                         TYPE_VIRTIO_GPU_VIRGL_HOSTMEM_REGION)
+
 static struct virtio_gpu_virgl_hostmem_region *
 to_hostmem_region(MemoryRegion *mr)
 {
@@ -70,14 +77,18 @@ static void virtio_gpu_virgl_resume_cmdq_bh(void *opaque)
     virtio_gpu_process_cmdq(g);
 }
 
-static void virtio_gpu_virgl_hostmem_region_free(void *obj)
+/*
+ * MR could outlive the resource if MR's reference is held outside of
+ * virtio-gpu. In order to prevent unmapping resource while MR is alive,
+ * and thus, making the data pointer invalid, we will block virtio-gpu
+ * command processing until MR is fully unreferenced and freed.
+ */
+static void virtio_gpu_virgl_hostmem_region_finalize(Object *obj)
 {
-    MemoryRegion *mr = MEMORY_REGION(obj);
-    struct virtio_gpu_virgl_hostmem_region *vmr;
+    struct virtio_gpu_virgl_hostmem_region *vmr = VIRTIO_GPU_VIRGL_HOSTMEM_REGION(obj);
     VirtIOGPUBase *b;
     VirtIOGPUGL *gl;
 
-    vmr = to_hostmem_region(mr);
     vmr->finish_unmapping = true;
 
     b = VIRTIO_GPU_BASE(vmr->g);
@@ -92,11 +103,26 @@ static void virtio_gpu_virgl_hostmem_region_free(void *obj)
     qemu_bh_schedule(gl->cmdq_resume_bh);
 }
 
+static const TypeInfo virtio_gpu_virgl_hostmem_region_info = {
+    .parent = TYPE_OBJECT,
+    .name = TYPE_VIRTIO_GPU_VIRGL_HOSTMEM_REGION,
+    .instance_size = sizeof(struct virtio_gpu_virgl_hostmem_region),
+    .instance_finalize = virtio_gpu_virgl_hostmem_region_finalize
+};
+
+static void virtio_gpu_virgl_types(void)
+{
+    type_register_static(&virtio_gpu_virgl_hostmem_region_info);
+}
+
+type_init(virtio_gpu_virgl_types)
+
 static int
 virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
                                    struct virtio_gpu_virgl_resource *res,
                                    uint64_t offset)
 {
+    g_autofree char *name = NULL;
     struct virtio_gpu_virgl_hostmem_region *vmr;
     VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
     MemoryRegion *mr;
@@ -117,21 +143,16 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
     }
 
     vmr = g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
+    name = g_strdup_printf("blob[%" PRIu32 "]", res->base.resource_id);
+    object_initialize_child(OBJECT(g), name, vmr,
+                            TYPE_VIRTIO_GPU_VIRGL_HOSTMEM_REGION);
     vmr->g = g;
 
     mr = &vmr->mr;
-    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
+    memory_region_init_ram_ptr(mr, OBJECT(vmr), "mr", size, data);
     memory_region_add_subregion(&b->hostmem, offset, mr);
     memory_region_set_enabled(mr, true);
 
-    /*
-     * MR could outlive the resource if MR's reference is held outside of
-     * virtio-gpu. In order to prevent unmapping resource while MR is alive,
-     * and thus, making the data pointer invalid, we will block virtio-gpu
-     * command processing until MR is fully unreferenced and freed.
-     */
-    OBJECT(mr)->free = virtio_gpu_virgl_hostmem_region_free;
-
     res->mr = mr;
 
     return 0;
@@ -159,7 +180,7 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
      * 1. Begin async unmapping with memory_region_del_subregion()
      *    and suspend/block cmd processing.
      * 2. Wait for res->mr to be freed and cmd processing resumed
-     *    asynchronously by virtio_gpu_virgl_hostmem_region_free().
+     *    asynchronously by virtio_gpu_virgl_hostmem_region_finalize().
      * 3. Finish the unmapping with final virgl_renderer_resource_unmap().
      */
     if (vmr->finish_unmapping) {
@@ -182,7 +203,7 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
         /* memory region owns self res->mr object and frees it by itself */
         memory_region_set_enabled(mr, false);
         memory_region_del_subregion(&b->hostmem, mr);
-        object_unparent(OBJECT(mr));
+        object_unparent(OBJECT(vmr));
     }
 
     return 0;

-- 
2.51.0


