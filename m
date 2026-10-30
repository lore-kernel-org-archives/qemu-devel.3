Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3238606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GZpPXpna
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMtvx-0007KF-1B; Fri, 30 Oct 2026 17:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMtvv-0007Jv-0m
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 17:14:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMtvt-0007pX-8L
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 17:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793394880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sHiTsjVfRaBcaaa5BzcrSRT0SWRMl4qLmS6Zt239i5A=;
 b=GZpPXpnalCD5zZDumyRE603dSF7YjgdxwgDE+4/9TWdtzq/03BR5hRNcB+p7Ff4bsQC0ZA
 QsERMgBhVzHcB+0lKvlBp1ePeaSbqXWnPd2GKWJgOs2OOWQaLys+jGUgBPCvPF/MIndOm1
 nUonsvoyjp85W9g+gLPQjX1d1yspSvQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-Heh-kpQAMt6ekqVi2Kmw3Q-1; Fri,
 30 Oct 2026 17:14:36 -0400
X-MC-Unique: Heh-kpQAMt6ekqVi2Kmw3Q-1
X-Mimecast-MFC-AGG-ID: Heh-kpQAMt6ekqVi2Kmw3Q_1793394875
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46953195604C; Fri, 30 Oct 2026 21:14:35 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B34418004D2; Fri, 30 Oct 2026 21:14:33 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 31 Oct 2026 01:14:09 +0400
Subject: [GIT PULL 06/10] igvm: make IgvmMemoryRegion a QOM
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261031-nohmp-next-v1-6-9a9fb205cf3f@redhat.com>
References: <20261031-nohmp-next-v1-0-9a9fb205cf3f@redhat.com>
In-Reply-To: <20261031-nohmp-next-v1-0-9a9fb205cf3f@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6441;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=RovLfg3KeEvmI1e1nvBzSdiv3u1NML2gU9Euy2FVfuY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5QigA8607S+L+LhBCB/3Sxtve33LrOiQjJSuE
 6l62EzlvxOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauUIoAAKCRDa6OEJdZac
 5TLcEACo0D+NGFxuhKUVt5b/SJC8V16qPniztRnoxkXO6F9zynGxvJACNdKz32NIz6E+08d+mCX
 8BQ5Ou/nul02h/7UiqWytwo69evuB7e06bkhf94J3si0m87r9Mo3AlgBapGKsOkE2nnGt8C6J6a
 BjB7XHC5NZglUEPAyDPhHF1oOR33TSY/IgbgDzAdatGyDNczMsAMaAvTDPuvYgYWib9OJNWRt5A
 MWjvn6KZ2Im2qtviE5b8+Vozty9zQPTQukZN/fLJtqZdh93Q4TZP/L0651A5fHuk1Fq5PqZwhj4
 XUXbmiFh8YwkV5ddoZEdIP+LZ3RTWw+LgJR+Ktwsc0x3me5ILE4CZwNVnmh19eMyiCPxjkpDp2F
 IecGR3fvW8UQs6EYeQ9Idd2Bnh3qB67+KNpgvqPaaC8sVpmUdkPQUQdn0dEiFU278/QvkALGE1U
 +9yNeWfOYaTxpxts6/pYWexdRGbnZkz9QV/dQ+BQAL/TRVJwq3Zdl4Xe/KZybuWQrMwGQ7quv/W
 KXYLIjE/4ilXA9NwMUwJQ0sy8VoWSG1vb4DJGYhOZxqMStLTi0+DLasjd6NBe4IlfFkSY30/Ctt
 ZBtnMCRTzqulbRfpvAFmVW97aq2JGhqeo+eWGdWjLolJcI1DZqZgd/0JkB9TR2JuOAW8x8UcS02
 NMChGedBxwWhxwg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Tested-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 backends/igvm.c                | 97 +++++++++++++++++++++++++-----------------
 include/system/igvm-internal.h |  9 ++--
 2 files changed, 64 insertions(+), 42 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index a9dc19b73997..4dd89282e5b8 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -38,6 +38,12 @@
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
@@ -260,10 +266,13 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
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
@@ -286,36 +295,29 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
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
@@ -1206,14 +1208,33 @@ void qigvm_cleanup_memory(IgvmCfg *cfg)
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
index 7ec6c204721b..98208a3fbde2 100644
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


