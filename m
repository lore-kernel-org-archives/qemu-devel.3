Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF67606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=El8VbrgM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJR6z-0004ZC-FH; Wed, 21 Oct 2026 03:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJR6q-0004Uy-NM
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJR6o-00040E-Q2
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792569098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/1fjiWygkRwux1lBwCGtl1AUmo2UCIH9Jml6qaPzOWQ=;
 b=El8VbrgMfZgx0nbV+WbppWsOnkzcwH+g3TA3z1wL/CPkEmOHxGqNP4qgCDMWhpOjX3Dapc
 4ZcLDVkTD/zHgqzxYEItfl4Fiv6+14e8CXFNm1fByoEKxOWwqalQgIJJUP88m9VwqK6CQn
 o/ojCPWIk4RXrHH4rLxlr7jlP1Y3HLQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-DnuOtDtqNgORIwumhtiG0Q-1; Wed,
 21 Oct 2026 07:51:34 +0000
X-MC-Unique: DnuOtDtqNgORIwumhtiG0Q-1
X-Mimecast-MFC-AGG-ID: DnuOtDtqNgORIwumhtiG0Q_1792569092
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A9AF18004D2; Wed, 21 Oct 2026 07:51:32 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 527761956087; Wed, 21 Oct 2026 07:51:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Oct 2026 11:51:08 +0400
Subject: [PATCH v2 5/9] igvm: make IgvmMemoryRegion a QOM
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261021-nohmp-next-v2-5-85471fca83db@redhat.com>
References: <20261021-nohmp-next-v2-0-85471fca83db@redhat.com>
In-Reply-To: <20261021-nohmp-next-v2-0-85471fca83db@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6350;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=U7m8WDF/BAK2Wf3yksj4Ah1D/30tnscuRyK47dRWL0M=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2G7sE/NDYU0dPsL5ZmSwgzvYHLtsaqJ5dmJ4i
 YVhI027KruJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCathu7AAKCRDa6OEJdZac
 5Vd/D/wI83FAMNZzitfee4XKFjd2MuZ+E2e0GaAE1uttvlOUUjqgPLi4p4EjM/uIS3yMEI/V7ZN
 jLy0lsnQRN0RLyIONJsoyOzOBJYu4cVwJw2WL2EgdYF4Ch+fCuA7pb3F+/te5ca33vc6j6ecqpT
 9Jkp1mgn9aTrXzl4YxeqDzRxSPvCjVjDP3bj0t1KhRu5SZ+xv45jKVhfpLY5ixhcgIV/e1Ka4wR
 X3YDk6RuiDtIhHJateny+ainTkS+DY71jvCgrAcixWthKDnhws3xa/d0jMTzsC1bfe4mhyQzLRr
 CUFsNDDNUEsfaWqQSp78N4gHSuQRfglNAHeE4HO/QONZn3qwOF5duZY6Hc5JC4kIXwyqdPhGbEl
 wTWn3xdaqZl5TGN8BFyVWngMlZ3f1mC5ZUGx0CaHyc0Pvh3D/7QdTjp6jbVfWKE4BfbkdjYlA+I
 A33WwCyOPg4qwiy12QkMf0I6ndufa2dlb/7u0JXdjATQ4BNYmvvApqlffRTkqszyYmLuQW0v054
 tDRYPFUFB1wq3kmysNDybY64mIzhW1q8NrWztOnr6XdBc6I/NMxlabFq1XV+Z3BMPWDUy+/Wn3a
 qavvR1jCu4iqmXUFAd0fyrOUp2ecmhKTEIqOc/lLlvno3RV2be6Ahd3dkYkW/mmeaMDKTg5SryL
 fQGXa/egj7lA1tg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 7aa76441d0d0..e659fea25517 100644
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
@@ -253,10 +259,13 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
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
@@ -279,36 +288,29 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
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
-            if (!memory_region_init_ram_guest_memfd_private(
-                    imr->mr, NULL, region_name, size, errp)) {
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
+        flags = RAM_GUEST_MEMFD_PRIVATE;
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
@@ -1161,14 +1163,33 @@ void qigvm_cleanup_memory(IgvmCfg *cfg)
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
index b3b64cb58444..c2ceb57ffa65 100644
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
2.56.0.116.g6de20f6092dc


