Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402E5EF99FF
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 04:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr7MR-000092-BG; Fri, 13 Feb 2026 23:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vr7MP-00008Z-IG; Fri, 13 Feb 2026 23:34:25 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vr7MM-0002x2-89; Fri, 13 Feb 2026 23:34:25 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61E4XfFf021785
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 14 Feb 2026 13:33:53 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=sd3849txVWpf4agTIrXwJOdVo2SNRDihL4uhG/9jcOY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1771043633; v=1;
 b=i0g4utVv8C50Dlr8fI8zHSJTDKOWSdQoiaXOXqfYUXgGR+k1TS1vKLJRbdXDaC+k
 uTDrnRCTVYH7rIPTjoTRu2JOdZaoi41FLk2sE6s1DRu9Urx3biCF1+bcWLtbeyeL
 IcvBfsKm0rnZD+mpNQKyFwpZrOkuAX7IX6VxoOnSyf0g9ITa5fW1rsBK3xOd3cC2
 kOi4EBMh2cjtlbiHMp3k05HSMJxyT++g16YncJeyntwrmMEsSL5jdmCoBaYHt6zZ
 OCBokgWwSt2X1Q5EqardE6afZJX3BzEQGUwIsAHx6L4FI0OGjF+dADKLUUcDHqlH
 lpmy2DTmBzDv7PXKkSgKWA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 14 Feb 2026 13:33:36 +0900
Subject: [PATCH] virtio-gpu-virgl: Add virtio-gpu-virgl-hostmem-region type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260214-region-v1-1-229f00ae1f38@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAB/7j2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDI0MT3aLUdKASXTNLg0RDc/NkAxNzUyWg4oKi1LTMCrBB0bG1tQAW5WF
 hWAAAAA==
X-Change-ID: 20260214-region-690a177c0475
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Joelle van Dyne <j@getutm.app>, Michael Tokarev <mjt@tls.msk.ru>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-67ece
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Commit e27194e087ae ("virtio-gpu-virgl: correct parent for blob memory
region") made the name member of MemoryRegion unset, causing a NULL
pointer dereference[1]:
> Thread 2 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> (gdb) bt
> #0  0x00007ffff56565e2 in __strcmp_evex () at /lib64/libc.so.6
> #1  0x0000555555841bdb in find_fd (head=0x5555572337d0 <cpr_state>,
> name=0x0, id=0) at ../migration/cpr.c:68
> #2  cpr_delete_fd (name=name@entry=0x0, id=id@entry=0) at
> ../migration/cpr.c:77
> #3  0x000055555582290a in qemu_ram_free (block=0x7ff7e93aa7f0) at
> ../system/physmem.c:2615
> #4  0x000055555581ae02 in memory_region_finalize (obj=<optimized out>)
> at ../system/memory.c:1816
> #5  0x0000555555a70ab9 in object_deinit (obj=<optimized out>,
> type=<optimized out>) at ../qom/object.c:715
> #6  object_finalize (data=0x7ff7e936eff0) at ../qom/object.c:729
> #7  object_unref (objptr=0x7ff7e936eff0) at ../qom/object.c:1232
> #8  0x0000555555814fae in memory_region_unref (mr=<optimized out>) at
> ../system/memory.c:1848
> #9  flatview_destroy (view=0x555559ed6c40) at ../system/memory.c:301
> #10 0x0000555555bfc122 in call_rcu_thread (opaque=<optimized out>) at
> ../util/rcu.c:324
> #11 0x0000555555bf17a7 in qemu_thread_start (args=0x555557b99520) at
> ../util/qemu-thread-posix.c:393
> #12 0x00007ffff556f464 in start_thread () at /lib64/libc.so.6
> #13 0x00007ffff55f25ac in __clone3 () at /lib64/libc.so.6

The intention of the aforementioned commit is to prevent a MemoryRegion
from parenting itself while its references is counted indendependently
of the device. To achieve the same goal, add a type of QOM objects that
count references and parent MemoryRegions.

[1] https://lore.kernel.org/qemu-devel/4eb93d7a-1fa9-4b3c-8ad7-a2eb64f025a0@collabora.com/

Cc: qemu-stable@nongnu.org
Fixes: e27194e087ae ("virtio-gpu-virgl: correct parent for blob memory region")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu-virgl.c | 54 +++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index ecf8494f3676..0f754829fb71 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -52,11 +52,17 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
 
 #if VIRGL_VERSION_MAJOR >= 1
 struct virtio_gpu_virgl_hostmem_region {
+    Object parent_obj;
     MemoryRegion mr;
     struct VirtIOGPU *g;
     bool finish_unmapping;
 };
 
+#define TYPE_VIRTIO_GPU_VIRGL_HOSTMEM_REGION "virtio-gpu-virgl-hostmem-region"
+
+OBJECT_DECLARE_SIMPLE_TYPE(virtio_gpu_virgl_hostmem_region,
+                           VIRTIO_GPU_VIRGL_HOSTMEM_REGION)
+
 static struct virtio_gpu_virgl_hostmem_region *
 to_hostmem_region(MemoryRegion *mr)
 {
@@ -70,14 +76,22 @@ static void virtio_gpu_virgl_resume_cmdq_bh(void *opaque)
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
+    if (!vmr->g) {
+        return;
+    }
+
     vmr->finish_unmapping = true;
 
     b = VIRTIO_GPU_BASE(vmr->g);
@@ -92,11 +106,26 @@ static void virtio_gpu_virgl_hostmem_region_free(void *obj)
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
@@ -117,21 +146,16 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
     }
 
     vmr = g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
+    name = g_strdup_printf("blob[%" PRIu32 "]", res->base.resource_id);
+    object_initialize_child(OBJECT(g), name, vmr,
+                            TYPE_VIRTIO_GPU_VIRGL_HOSTMEM_REGION);
     vmr->g = g;
 
     mr = &vmr->mr;
-    memory_region_init_ram_ptr(mr, OBJECT(mr), NULL, size, data);
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
 
     trace_virtio_gpu_cmd_res_map_blob(res->base.resource_id, vmr, mr);
@@ -163,7 +187,7 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
      * 1. Begin async unmapping with memory_region_del_subregion()
      *    and suspend/block cmd processing.
      * 2. Wait for res->mr to be freed and cmd processing resumed
-     *    asynchronously by virtio_gpu_virgl_hostmem_region_free().
+     *    asynchronously by virtio_gpu_virgl_hostmem_region_finalize().
      * 3. Finish the unmapping with final virgl_renderer_resource_unmap().
      */
     if (vmr->finish_unmapping) {
@@ -186,7 +210,7 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
         /* memory region owns self res->mr object and frees it by itself */
         memory_region_set_enabled(mr, false);
         memory_region_del_subregion(&b->hostmem, mr);
-        object_unref(OBJECT(mr));
+        object_unparent(OBJECT(vmr));
     }
 
     return 0;

---
base-commit: ece408818d27f745ef1b05fb3cc99a1e7a5bf580
change-id: 20260214-region-690a177c0475

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


