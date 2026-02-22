Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F64C6369F
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuASo-0000W1-6N; Sun, 22 Feb 2026 09:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASX-0008FI-4R
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASV-0006rb-Bl
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ahaZpslv1Klb2Dj4IC7LSc778IKY0QywKL9M3ZpD++s=;
 b=F6s24df6HTCOwsOikt8vISB5k0QO+kg4/rHTbBKN7RxjYeaJpcjAx5LchbhRUz+/u37hLK
 CxgvIEdAa1+Dm8HOnWSExukAM3BhyIWBCTIsqRFYjBPv95/AS5Q0r6SwEYxzTr66ronRKr
 xRVBZB/gmRJWaKo9Eybr5CZ85uvpJeg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-UEbQxlxdOMKJneEst-aG2Q-1; Sun, 22 Feb 2026 09:29:16 -0500
X-MC-Unique: UEbQxlxdOMKJneEst-aG2Q-1
X-Mimecast-MFC-AGG-ID: UEbQxlxdOMKJneEst-aG2Q_1771770556
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837b7903f3so44706335e9.2
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770555; x=1772375355; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ahaZpslv1Klb2Dj4IC7LSc778IKY0QywKL9M3ZpD++s=;
 b=ONqPIDNnKAm7cRac56toGv327MaIMhBu4fRsn3HfWcEFg5xugKBBMfI84PHVRiTvcs
 N6dhR3MEtaZVnrO40rARGFYfKywsIRD8R+ax8DwycLh4l30Rm8kigcDxZsisrHfPEXzS
 4wDZUVN/Q7hhwHXbXjBKIU71lAOGdlKh6RALaPrUTKwQ8ynRnX+j0S73Pjqla2Bn7BUk
 Y9IwxpCJsWTIRbW6EZlzykQbUaTQFNXWnaYqnHJ+tP69EMnmw6VfeSDwoNdozxjMeXP1
 2feKFRe6fKS1GW4JM9NzKT2jrHTDaYqbdKGUfiZaGRbWMqpEYlNFPt9VTQ4hgKZlUxWo
 QKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770555; x=1772375355;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ahaZpslv1Klb2Dj4IC7LSc778IKY0QywKL9M3ZpD++s=;
 b=CrddvO9JBrdbLy8UKnbkOS0pQPxCSuJr+VyenKwhB9MypOqmoOvGFdHP+MwP4mhoky
 9Nu9aZY5ZwJwXDj3a+TJDI54lOfIZNo0dtFYDfWoFqvsgdKKjGwxONBGYW/tpZ1/aXNY
 yZpo7eU5lrMBLumcix3OVY0wBjrcO3FX4vQFqwT/KEBatu9GKIe9wvmlRXtxWFnMgOQk
 2nVXwuruUih68EERSJucPBQa/Y4Z2nP1ge66nHIx0ygUxXI9Cik9Wb3A0njE8v+UsJoe
 gn6UrH/yOUh9PaMsWjAbUhDR/jkhikvbIA6baBfm8ppjIMaLxXPv6T/18crn1oR2iJ7+
 NSNg==
X-Gm-Message-State: AOJu0Yyvqxvce39Td5X4svYOdLOG88VO8h1wlVX3Lq6OtGHnNn0KFjhj
 /IaF7EXxns+wuwUFBEMAwmvnNU1LbfmS2Lyi8Isk2ZXhITyxYRgTHyvoLwPICj+CYTvYYQCdsW6
 1WVTUHTEJc6eCfi9KUEsh/UHrE0LITIw/RgvPlpHwCnjQwCiwi9iVqR7CyL11YS+i0oVmBRr3OF
 FkEVHT+9+8xJeHx5QbfJbe9SMlUAW1RRuWgg==
X-Gm-Gg: AZuq6aJ9HIs0qs3RTaK4Gu1YfHt/iIxXzyDUq/0YOb6wJeSMNsyO95DPg/ijnlBZl/j
 VY/d9SlkEL+Q0rClWDysWVDuC0CEUN7dyhmfS3FyzLzCU3gJlDGvjjLVfFBjsgaowT2OURviyAS
 kXoW6Qtzd4P0ih2ffiAI6tyE0z8cGkz1e24+WxYd5llAtk12+HsZJ9/Ce9kJp2e50qdr8M5YaK5
 zAMcOxGjnI5VRRdAqJk5H8to5STP8nOZp2NHECRi/OiIgUuC6Bpr3I5o2xYyAKvYjjo6PtjShlm
 LELjzaXtdjlx6mdz6+8Z0k5d3rEkuEYUYi7s9KYD00UtpOTANtLxc3VHCd2Pj91cM8j58FbbFyr
 G2ejMbQnrU3tIdqAlYV13+r2nWdsnmF8EdRU9b8l2W2RYdA==
X-Received: by 2002:a05:6000:26cd:b0:430:f6bc:2f8a with SMTP id
 ffacd0b85a97d-4396f17b527mr10479572f8f.47.1771770555325; 
 Sun, 22 Feb 2026 06:29:15 -0800 (PST)
X-Received: by 2002:a05:6000:26cd:b0:430:f6bc:2f8a with SMTP id
 ffacd0b85a97d-4396f17b527mr10479524f8f.47.1771770554708; 
 Sun, 22 Feb 2026 06:29:14 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970c00485sm13842080f8f.9.2026.02.22.06.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:29:14 -0800 (PST)
Date: Sun, 22 Feb 2026 09:29:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-stable@nongnu.org,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Joelle van Dyne <j@getutm.app>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 24/33] virtio-gpu-virgl: Add virtio-gpu-virgl-hostmem-region
 type
Message-ID: <b2a279094c3b86667969cc645f7fb1087e08dd19.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

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
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Tested-by: Joelle van Dyne <j@getutm.app>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260214-region-v1-1-229f00ae1f38@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu-virgl.c | 54 +++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index ecf8494f36..0f754829fb 100644
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
-- 
MST


