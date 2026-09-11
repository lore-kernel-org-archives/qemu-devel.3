Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBF3C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xAv-0005qj-9K; Fri, 11 Sep 2026 05:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAI-0004I3-NV
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAG-0008IH-K6
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PWQxLCtaF9Z/qhP7GNgCPFbg0LbmSSJO7NpN+DpDut8=;
 b=S7rYXnPBvvGsMLWdGNRhKO/Dr2nZ5AWVfi5nbUhw6f1LM8hkAw0cg17P7lALybX5akWmSd
 3DQH4D/khEEAsucGHIBlRCZEETGC+g/uXbHlq8n0TGVsF3JNYYWahD7QHiZQazV/sJMJPn
 oxeK1d6EBP5p4YSSswa8QzSX8+HA6hY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-k2vySDC3OZulp23l022kQw-1; Fri, 11 Sep 2026 05:03:18 -0400
X-MC-Unique: k2vySDC3OZulp23l022kQw-1
X-Mimecast-MFC-AGG-ID: k2vySDC3OZulp23l022kQw_1789117397
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490a767b782so5965195e9.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117397; x=1789722197; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PWQxLCtaF9Z/qhP7GNgCPFbg0LbmSSJO7NpN+DpDut8=;
 b=h9AWcvLVnEJHKJitR2dVAZlSwliADp89SH0FFYmhpSny5q8aLv2M2jDaiuFyJkIhJJ
 BQEUck7lTys3tg9CieQ5jA+bi7jGTrEqufzl5ZSJxUuCMOoY8kFjv7j2swcEPbUKZS6Z
 Zrn9fu+fcrODilQ+t8PGDOq0Iqj1daJMyKGNxepC7nyrByn3oBfm1oKiGIs6uo9QIZJU
 Nk19/dqq7nDa+OIwWt6N/kP/nypUZhnxZQ0adlaPqvezS2hdR54QHLoJzd23XmlW7aP2
 ljaKyFvabWd0ayD741DyCoceEhmU2nCvMeBs/CYc7nWlcKQnMbX/2Yz8U3Ki2jjcPFUm
 7qZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117397; x=1789722197;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PWQxLCtaF9Z/qhP7GNgCPFbg0LbmSSJO7NpN+DpDut8=;
 b=MSGxohPWsPn9DQJbzp2r3rVFnumtkwynIl+kRg56EBtAZzaeDTWoODth7aCTm+YAPE
 ba5SPvuq+Hq0KjgTioPvzbDLPd12DvNVkCj31E2+qHaLpfJk1NiLLEkjmMngLnzXf0hk
 r+RUipr+RHFVmpgsj86NGAfeszObb5uCBGNRDnD8BycF7lO7atmVpKG1r0cT/XwH2xcn
 wXDLlIccw+tOxVi3wVznF3NEsx37yC5iQT74wPVAhVVyer/eLKbCYaudINHb1xY9SXNg
 vYUqv49GLf4GCuK7ooJdHD50z3P2FuRgZM2neXhYsCIpKuPXJ/wTyuqL3U/tMdbLY+ve
 LvHg==
X-Gm-Message-State: AFuF++k5Ozrzeej5A0N40r6g5vtAfopwTiZtS5ajjsk3VgB0WFREzQY9
 +OE2mubYVUd6X9x/oFYrLsPzBMbCIgKHNqiv3lXuuXm+04gfPCVEJLYlto+Ce5CuTXGIk+QPWWs
 9P4HiSDnshUMIFmQQemYQy+eMGrGjdEihe50sStkTPw0WqdGuH6pqIARbR87LddGt9+FiyNzSMM
 438PE+d7mQG6DcweD2V1PsF2ls7w==
X-Gm-Gg: AYBFou3+yjpZagDGD+QoisPe+QpuyFoNvF+/vP5aOIeodLebTZIf8lSHgGmMB6hRhnO
 NjYwn76adIv/kzDzv32tadAeW3Ho46E8UEP3KR3mMMnpo099hZMFLV3s+7cp3wh9M6vDp2P9ebq
 WjuZRnbpdiULmag2q0V5gR3RpJ2QZ22xCAFp/ZFWtMxVackKcAUvyhaVQhiFE4lWnnXWZBuIiID
 AXNirEU3LDRzo0/VNNrrO0Fpc2OnS9hbAr5ha7sH+zCGw8XbEpvjQUUxX+JcB1hvg23IVJMCowy
 H41FgKd5LZlQWyEPF239XX8Xr+u+pk7HeBGF3rbyIu5/aRhP257IlBRa2SEDPxNO
X-Received: by 2002:a05:600c:6296:b0:49d:191b:88be with SMTP id
 5b1f17b1804b1-49e6164a26dmr34354095e9.0.1789117395134; 
 Fri, 11 Sep 2026 02:03:15 -0700 (PDT)
X-Received: by 2002:a05:600c:6296:b0:49d:191b:88be with SMTP id
 5b1f17b1804b1-49e6164a26dmr34353445e9.0.1789117394459; 
 Fri, 11 Sep 2026 02:03:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26be3e35sm134873165e9.2.2026.09.11.02.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:03:14 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:03:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Subject: [PULL v2 48/75] acpi_build: Build IVRS feature report using extended
 feature register
Message-ID: <7dbb1e91e35020245c24e5d911e00cce2a7bac1c.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sairaj Kodilkar <sarunkod@amd.com>

Currently IVRS feature report values are hardcoded, this is difficult to
maintain as any updates to extended feature must be synced. Along with
it, current feature report does not have GATS and HATS set. Hence use
the extended feature registers to build the IVRS feature report.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260807061250.27739-6-sarunkod@amd.com>
---
 hw/i386/amd_iommu.h  | 11 ++++++++++
 hw/i386/acpi-build.c | 48 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index d01f9b41df..319db18618 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -174,7 +174,11 @@
 #define AMDVI_DTE_QUAD3_RESERVED        (GENMASK64(14, 0) | GENMASK64(53, 48))
 
 /* AMDVI paging mode */
+#define AMDVI_GATS_MODE_SHIFT           (12)
+#define AMDVI_GATS_MODE_MASK            (3ULL <<  12)
 #define AMDVI_GATS_MODE                 (2ULL <<  12)
+#define AMDVI_HATS_MODE_SHIFT           (10)
+#define AMDVI_HATS_MODE_MASK            (3ULL <<  10)
 #define AMDVI_HATS_MODE                 (2ULL <<  10)
 #define AMDVI_HATS_MODE_RESERVED        (3ULL <<  10)
 
@@ -296,6 +300,13 @@
 #define AMDVI_DEV_LINT0_PASS_MASK       (1ULL << 62)
 #define AMDVI_DEV_LINT1_PASS_MASK       (1ULL << 63)
 
+#define AMDVI_IVHD_FEATURE_REPORT_HATS_SHIFT        (30)
+#define AMDVI_IVHD_FEATURE_REPORT_GATS_SHIFT        (28)
+#define AMDVI_IVHD_FEATURE_REPORT_GA_SUP_SHIFT      (6)
+#define AMDVI_IVHD_FEATURE_REPORT_IA_SUP_SHIFT      (5)
+#define AMDVI_IVHD_FEATURE_REPORT_GT_SUP_SHIFT      (2)
+#define AMDVI_IVHD_FEATURE_REPORT_XT_SUP_SHIFT      (0)
+
 #define TYPE_AMD_IOMMU_DEVICE "amd-iommu"
 OBJECT_DECLARE_SIMPLE_TYPE(AMDVIState, AMD_IOMMU_DEVICE)
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index a28bb2ec63..7bf3858b63 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1842,6 +1842,37 @@ ivrs_host_bridges(Object *obj, void *opaque)
     return 0;
 }
 
+/*
+ * IVHD type 0x10 reports features using Feature Reporting field, which has
+ * different format than extended feature register (EFR) in the IOMMU MMIO
+ * space.
+ *
+ * Convert the EFR format to feature reporting format.
+ */
+static uint32_t
+get_amd_ivhd_feature_report(uint64_t extended_feature)
+{
+    uint32_t feature_report;
+    uint64_t hats_mode = (extended_feature & AMDVI_HATS_MODE_MASK) >>
+                         AMDVI_HATS_MODE_SHIFT;
+    uint64_t gats_mode = (extended_feature & AMDVI_GATS_MODE_MASK) >>
+                         AMDVI_GATS_MODE_SHIFT;
+    uint32_t is_ia = !!(extended_feature & AMDVI_FEATURE_IA);
+    uint32_t is_ga = !!(extended_feature & AMDVI_FEATURE_GA);
+    uint32_t is_gt = !!(extended_feature & AMDVI_FEATURE_GT);
+    uint32_t is_xt = !!(extended_feature & AMDVI_FEATURE_XT);
+
+    feature_report =
+        hats_mode << AMDVI_IVHD_FEATURE_REPORT_HATS_SHIFT |  /* HATS[31:30] */
+        gats_mode << AMDVI_IVHD_FEATURE_REPORT_GATS_SHIFT |  /* GATS[29:28] */
+        is_ia << AMDVI_IVHD_FEATURE_REPORT_IA_SUP_SHIFT |    /* IASup[5]    */
+        is_ga << AMDVI_IVHD_FEATURE_REPORT_GA_SUP_SHIFT |    /* GASup[6]    */
+        is_gt << AMDVI_IVHD_FEATURE_REPORT_GT_SUP_SHIFT |    /* GTSup[2]    */
+        is_xt << AMDVI_IVHD_FEATURE_REPORT_XT_SUP_SHIFT;     /* XTSup[0]    */
+
+    return feature_report;
+}
+
 static void
 build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
                 const char *oem_table_id)
@@ -1850,8 +1881,8 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     GArray *ivhd_blob = g_array_new(false, true, 1);
     AcpiTable table = { .sig = "IVRS", .rev = 1, .oem_id = oem_id,
                         .oem_table_id = oem_table_id };
-    uint64_t feature_report;
     uint16_t iommu_devid = pci_get_bdf(&s->pci->dev);
+    uint64_t extended_feature = amdvi_extended_feature_register(s);
 
     acpi_table_begin(&table, table_data);
     /* IVinfo - IO virtualization information common to all
@@ -1924,14 +1955,9 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     /* IOMMU info */
     build_append_int_noprefix(table_data, 0, 2);
     /* IOMMU Feature Reporting */
-    feature_report = (48UL << 30) | /* HATS   */
-                     (48UL << 28) | /* GATS   */
-                     (1UL << 2)   | /* GTSup  */
-                     (1UL << 6);    /* GASup  */
-    if (s->xtsup) {
-        feature_report |= (1UL << 0); /* XTSup */
-    }
-    build_append_int_noprefix(table_data, feature_report, 4);
+    build_append_int_noprefix(table_data,
+                              get_amd_ivhd_feature_report(extended_feature),
+                              4);
 
     /* IVHD entries as found above */
     g_array_append_vals(table_data, ivhd_blob->data, ivhd_blob->len);
@@ -1964,9 +1990,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
         build_append_int_noprefix(table_data, 0, 4);
     }
     /* EFR Register Image */
-    build_append_int_noprefix(table_data,
-                              amdvi_extended_feature_register(s),
-                              8);
+    build_append_int_noprefix(table_data, extended_feature, 8);
     /* EFR Register Image 2 */
     build_append_int_noprefix(table_data, 0, 8);
 
-- 
MST


