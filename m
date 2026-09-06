Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA371C79F99
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 08:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x38eA-0002bl-5h; Sun, 06 Sep 2026 04:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38e8-0002bM-Tu
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:54:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38e7-0000or-31
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788684878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eACu3XVhakesEFnMk7YDIWx08rU69DJZpdOJmnuy/Nc=;
 b=iQjuYLEDdlbSonpTA+vkv7OiBQkYbClAU9wDijaZgrRAoKxEBHHshtrNChVVdu2LMxrfpA
 Jl2g9AWzLjdD0gEyGX1JL/tcq9nUA6+Eu+YuW1oiMXjAudZM4GoOrjpVaw/R+7In0TGWPo
 guxKWiG+C9chov0I4uLVdrEjvw0OcAQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-ObLBghIPPm2Z3Ni1N0PZFA-1; Sun,
 06 Sep 2026 04:54:25 -0400
X-MC-Unique: ObLBghIPPm2Z3Ni1N0PZFA-1
X-Mimecast-MFC-AGG-ID: ObLBghIPPm2Z3Ni1N0PZFA_1788684862
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBE7B1955DC9; Sun,  6 Sep 2026 08:54:22 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D188E1800598; Sun,  6 Sep 2026 08:54:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 06 Sep 2026 12:53:40 +0400
Subject: [PATCH 8/9] igvm: make IgvmMemoryRegion a QOM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260906-nohmp-next-v1-8-2b21e63974f3@redhat.com>
References: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
In-Reply-To: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Gerd Hoffman <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>, 
 Zhuoying Cai <zycai@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
 qemu-s390x@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6365;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=U38GR/ghKbLAYVNdtkRcH421VnYU0/FYIBBHHUs5IuY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnSoZ8W2H9SCIVECiVjSbfaZcLMOFZ6F7sVlRm
 bd2+Wvgh9CJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap0qGQAKCRDa6OEJdZac
 5RbOD/9IAnkl+lykvEZzYCL1K47f3QG2MMehmraMOQRvSjQihz6xRvT9MaGD0hg/1B3JLqr/Q9n
 +OyuUDNMOGe7PbopvKBFruwMN+6ImDw0Wo/ds+YBqGITFKbrZO+wDNSsd4gXWvFZvbRIXC16Lke
 S9fL6gJNddpt2IghuvoAvvQ9nxaiCerN8bg4MJZkirnNLFW83ziN7E3WrwNRNNpjSPTkxpLdtFN
 any+yerqxG0H2vrYyEzBERBNCPEE9xWfmy1qiYiaLKqe2lbG3Mm7BwePjRgEnQPZRdPFzZ3+6sZ
 TyR2DFEpe9/FvTMMeXmgOC25ohKGZgucAaD7hXXciqd0FMUqMWszXkQULVjpH2E7svgPMMFOBlj
 D1TqaTMI1yKgYd9PSZZcgahAkhTfC4aX/PHVLdfxPKH+bLcEXR1q4EYBJslOQawujXY0J/bYQXP
 uDF30eiPSI8itJIEwy6XvQLblRmF1EFyQCw1FWaegqUm8i4xaKDpj7vswUPlWBc9u4RjDCDeFXS
 0PuR71Qhj5thOKWcmVV16Nwy5K3NB9iakVdyIpyUkiXgJwHPZXWSYmt0i6/PceSfS6C1cotLu9X
 knwM8BChjCGtrbAdRVFszD9XFtXAA9cjab/fiRSYZBvJlxQcYQMQ+puYv7NdqpvUxJdxcL6KzxP
 +qs9DrXcM1KArcA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

Make IgvmMemoryRegion a QOM object, embedding MemoryRegion, and use it
as the region owner. The IGVM list and memory subsystem can now hold
references independently, and QOM frees after the last reference is
dropped, fixing leaks reported by ASAN while running tests.

- object_unparent() is no longer needed, children are automatically unref
- switch to memory_region_init_ram_flags_nomigrate() as other helpers
  expect a DEVICE

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 backends/igvm.c                | 97 +++++++++++++++++++++++++-----------------
 include/system/igvm-internal.h |  9 ++--
 2 files changed, 64 insertions(+), 42 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 784a56504e77..6cd192f2f5ff 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -35,6 +35,12 @@
 #define IGVM_VHT_OPTIONAL_BIT (1U << 31)
 #endif
 
+struct IgvmMemoryRegion {
+    Object parent_obj;
+    MemoryRegion mr;
+    QTAILQ_ENTRY(IgvmMemoryRegion) next;
+};
+
 /*
  * Bit 31 of the variable header type indicates that the header is
  * optional and can be safely ignored by a loader that does not
@@ -221,10 +227,13 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
                                   int region_identifier, Error **errp)
 {
     ERRP_GUARD();
-    IgvmMemoryRegion *imr = NULL;
+    g_autoptr(IgvmMemoryRegion) imr = NULL;
     Int128 gpa_region_size;
+    g_autofree char *region_name = NULL;
+    uint32_t flags = 0;
     MemoryRegionSection mrs =
         memory_region_find(get_system_memory(), addr, size);
+
     if (mrs.mr) {
         if (!memory_region_is_ram(mrs.mr)) {
             memory_region_unref(mrs.mr);
@@ -247,36 +256,29 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
             return NULL;
         }
         return qemu_map_ram_ptr(mrs.mr->ram_block, mrs.offset_within_region);
-    } else {
-        /*
-         * The region_identifier is the is the index of the IGVM directive that
-         * contains the page with the lowest GPA in the region. This will
-         * generate a unique region name.
-         */
-        g_autofree char *region_name =
-            g_strdup_printf("igvm.%X", region_identifier);
-        imr = g_new0(IgvmMemoryRegion, 1);
-        imr->mr = g_new0(MemoryRegion, 1);
-        if (ctx->machine_state->cgs &&
-            ctx->machine_state->cgs->require_guest_memfd) {
-            if (!memory_region_init_ram_guest_memfd(imr->mr, NULL,
-                                                    region_name, size, errp)) {
-                g_free(imr->mr);
-                g_free(imr);
-                return NULL;
-            }
-        } else {
-            if (!memory_region_init_ram(imr->mr, NULL, region_name, size,
-                                        errp)) {
-                g_free(imr->mr);
-                g_free(imr);
-                return NULL;
-            }
-        }
-        memory_region_add_subregion(get_system_memory(), addr, imr->mr);
-        QTAILQ_INSERT_TAIL(&ctx->cfg->memory_regions, imr, next);
-        return memory_region_get_ram_ptr(imr->mr);
     }
+
+    /*
+     * The region_identifier is the is the index of the IGVM directive that
+     * contains the page with the lowest GPA in the region. This will
+     * generate a unique region name.
+     */
+    region_name = g_strdup_printf("igvm.%X", region_identifier);
+    imr = IGVM_MEMORY_REGION(object_new(TYPE_IGVM_MEMORY_REGION));
+    if (ctx->machine_state->cgs &&
+        ctx->machine_state->cgs->require_guest_memfd) {
+        flags = RAM_GUEST_MEMFD;
+    }
+    if (!memory_region_init_ram_flags_nomigrate(&imr->mr, OBJECT(imr),
+                                                region_name, size,
+                                                flags, errp)) {
+        return NULL;
+    }
+    vmstate_register_ram_global(&imr->mr);
+    memory_region_add_subregion(get_system_memory(), addr, &imr->mr);
+    object_ref(imr); /* for the list */
+    QTAILQ_INSERT_TAIL(&ctx->cfg->memory_regions, imr, next);
+    return memory_region_get_ram_ptr(&imr->mr);
 }
 
 static int qigvm_type_to_cgs_type(IgvmPageDataType memory_type, bool unmeasured,
@@ -1118,14 +1120,33 @@ void qigvm_cleanup_memory(IgvmCfg *cfg)
 {
     IgvmMemoryRegion *imr, *tmp;
 
-    QTAILQ_FOREACH_SAFE(imr, &cfg->memory_regions, next, tmp)
-    {
-        trace_qigvm_cleanup_memory(imr->mr->name);
-        memory_region_del_subregion(get_system_memory(), imr->mr);
-        vmstate_unregister_ram(imr->mr, NULL);
+    QTAILQ_FOREACH_SAFE(imr, &cfg->memory_regions, next, tmp) {
+        trace_qigvm_cleanup_memory(imr->mr.name);
         QTAILQ_REMOVE(&cfg->memory_regions, imr, next);
-        /* this triggers MemoryRegion cleanup */
-        object_unparent(OBJECT(imr->mr));
-        g_free(imr);
+        object_unref(OBJECT(imr));
     }
 }
+
+static void qigvm_memory_region_finalize(Object *obj)
+{
+    IgvmMemoryRegion *imr = IGVM_MEMORY_REGION(obj);
+
+    if (imr->mr.container) {
+        memory_region_del_subregion(imr->mr.container, &imr->mr);
+    }
+    vmstate_unregister_ram(&imr->mr, NULL);
+}
+
+static const TypeInfo qigvm_memory_region_info = {
+    .name = TYPE_IGVM_MEMORY_REGION,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(IgvmMemoryRegion),
+    .instance_finalize = qigvm_memory_region_finalize,
+};
+
+static void qigvm_register_types(void)
+{
+    type_register_static(&qigvm_memory_region_info);
+}
+
+type_init(qigvm_register_types);
diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 9e9fa1d9afdb..625d2f9a9f83 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -18,10 +18,11 @@
 #include "system/confidential-guest-support.h"
 #include <igvm/igvm.h>
 
-typedef struct IgvmMemoryRegion {
-    QTAILQ_ENTRY(IgvmMemoryRegion) next;
-    MemoryRegion *mr;
-} IgvmMemoryRegion;
+typedef struct IgvmMemoryRegion IgvmMemoryRegion;
+
+#define TYPE_IGVM_MEMORY_REGION "igvm-memory-region"
+
+OBJECT_DECLARE_SIMPLE_TYPE(IgvmMemoryRegion, IGVM_MEMORY_REGION)
 
 struct IgvmCfg {
     Object parent_obj;

-- 
2.55.0.543.g5ebe2ebe4ea8


