Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEDEC44500
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNvu-0005Bs-B5; Sun, 05 Jul 2026 10:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNvs-0005BH-Sj
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:34:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNvr-00016m-1R
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OZ+hFgNQf8FoNmFlIkaqMaOQk1+bebbE5wXB+o3lSjg=;
 b=RrQ7Birkq5Qb0UrIxnMcqSatJ+KtLE+u2Q1G3Twmc0LF9INquD+B+HIpQPwSrKngZiNJG1
 IngmJFb/kPModUCqSxr3an1jawi8Q5J6tSD+1gFgYS98dEiig/y188N9cgrjshRKZ+vKDO
 rzQIX7MKQlvuZIMh7CTrELuAYnif6tQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-8u3J8gsDOhK20fQaPLs2-Q-1; Sun, 05 Jul 2026 10:34:52 -0400
X-MC-Unique: 8u3J8gsDOhK20fQaPLs2-Q-1
X-Mimecast-MFC-AGG-ID: 8u3J8gsDOhK20fQaPLs2-Q_1783262091
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-493b0fe95b6so11366865e9.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262091; x=1783866891; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OZ+hFgNQf8FoNmFlIkaqMaOQk1+bebbE5wXB+o3lSjg=;
 b=ZK2ibwWLBvGBFrcNcJKbU0ZJnZAI7XnW4K2jALBHtAgu9mfpJyvjy5KSX0fPG0D9K4
 7il8SP5nZ1/xS00R1cxasu4B3bKQTgQYnhVLKDbLPEgahS4VhgpKf0K2JJPDGfNai7k0
 Y+sO+7RCYeRkZH8VIJwrwctHwIpbNcsKksMO7xTfH4uaw0owHHATXY6XyM/gieeRMxoj
 v3+JcdZ8zAYjwQS0bNY1Hp3jgsPFA7pRyvgtNbvQyRnV4bPLRmNq1iKFbT1B9vWzMK1u
 CJypEOB6W7EmwWmP4+QTJOfGTNhZdKV3O9dIQWOOJeA975cw+R/FQkvIwCTSuCLbYIYj
 CVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262091; x=1783866891;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OZ+hFgNQf8FoNmFlIkaqMaOQk1+bebbE5wXB+o3lSjg=;
 b=kYxxXuLJMt0KjSEMh6y7K0SjuI5jgYL/xXNWpkS3tDQsXGfzcajmfXhYLJRCP92L1q
 +8BVWCDbKaweWMkRin1lrQa5xT4i5sSfLstYaKgjdKD4Mc+EYkGUV1nE8ukc+ekNQcY3
 zZyqQ4K/B91xIssqCqFoF93DLCwbTp1C0F/3jcAPqQkqf6v3QGCoDL6rffX/iFNhYy7M
 I0o0JlGYVU2YPxLAAAN9lDY9bEoVNIFYVYAGZjZonhVJVgRkhNg+uWbve4Bv2AYs2Gaw
 XIHeM1BMN3jQsYOYNhfQkvh/DPOtfC/2Q9IB83oyBiqMMRLbMirwSylnfJWtW753TJsd
 koWQ==
X-Gm-Message-State: AOJu0YwZwcDepIueAmm3EWU7CPkS1uw7ngP0+AEtF6w67++wlGN9PGmS
 VTeMxa3VJ7UnClMKg/s2eI2yIAiqyRAjjMIsF7aKXEyHHxdDHsf52Pob8vjzsM0bDL7YzuNh3Qe
 gG4X8/5Mo4Mpvq6EzhEzI9ZaYHadohPNil6nVGDAAhCJs1UaJNbNRgZoLPwjLOWW1MvKuMFeAiC
 RC3Xy6wR/bkSPactrZB5K8/e58xnFpUVelVQ==
X-Gm-Gg: AfdE7cm6h44f8c4M/P+px93GXEnyVdab6ifXgZeWV57dP9TU/bgdM0Qx/2iPxG8O/xn
 zfOTiRi2j5mfsNlWkWB1y/9G4kL/g+POL0idccqgiBlmGcA6ZuGT4cm57BgX+D/nCz0OufxxgOa
 FGWdzIgjo5Y4/oHR9GAZAfusLFtCvDPHHYU2Sk2bsL8VZCtDHPC8NahiWIF545ubbh1ASBt0mfj
 M+G8ivqrnmhqzir0MyG5N8AQwr2oShXE4ME4QlH3QfJrsL9tluqOJ3lCR1rmn3JOUjryQDlKcwM
 7BRDNnLHhqL5SplvnViF4lCtTEgvjPxMohvankcUcqpOshcTOjdLcvWwU8L9A/B3UClilHknhge
 VsFo/S5YNwspo/AzHzmkBPx4Tc/FIQ0Cn
X-Received: by 2002:a05:600c:198d:b0:493:bb6b:5bb5 with SMTP id
 5b1f17b1804b1-493d11db4c1mr78424215e9.13.1783262090987; 
 Sun, 05 Jul 2026 07:34:50 -0700 (PDT)
X-Received: by 2002:a05:600c:198d:b0:493:bb6b:5bb5 with SMTP id
 5b1f17b1804b1-493d11db4c1mr78423865e9.13.1783262090398; 
 Sun, 05 Jul 2026 07:34:50 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63bf7efsm299935025e9.14.2026.07.05.07.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:34:49 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:34:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Sairaj Kodilkar <sarunkod@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/44] amd_iommu: Decode IRTEs without bitfields
Message-ID: <5bebd769ec33aaeafbdefa7aebc0ea016ba07f09.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Interrupt remapping table entries are data stored in guest memory in
little-endian format. Decoding them with bitfields depends on host bitfield
layout and the value returned from dma_memory_read() is not portable to
big-endian hosts.

Replace the legacy and GA IRTE bitfield definitions with explicit FIELD()
definitions. Convert the guest memory values returned from dma_memory_read()
with le32_to_cpu() or le64_to_cpu(), then extract relevant fields using
FIELD_EX32() or FIELD_EX64() as appropriate to match the IRTE format.

Fixes: b44159fe0078 ("x86_iommu/amd: Add interrupt remap support when VAPIC is not enabled")
Fixes: 135f866e609c ("x86_iommu/amd: Add interrupt remap support when VAPIC is enabled")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260630220806.1758748-5-alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.h | 49 ------------------------
 hw/i386/amd_iommu.c | 93 +++++++++++++++++++++++++++++++++------------
 2 files changed, 69 insertions(+), 73 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index ca4440a4c1..687691ec1c 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -291,55 +291,6 @@
 #define AMDVI_DEV_LINT0_PASS_MASK       (1ULL << 62)
 #define AMDVI_DEV_LINT1_PASS_MASK       (1ULL << 63)
 
-/* Interrupt remapping table fields (Guest VAPIC not enabled) */
-union irte {
-    uint32_t val;
-    struct {
-        uint32_t valid:1,
-                 no_fault:1,
-                 int_type:3,
-                 rq_eoi:1,
-                 dm:1,
-                 guest_mode:1,
-                 destination:8,
-                 vector:8,
-                 rsvd:8;
-    } fields;
-};
-
-/* Interrupt remapping table fields (Guest VAPIC is enabled) */
-union irte_ga_lo {
-  uint64_t val;
-
-  /* For int remapping */
-  struct {
-      uint64_t  valid:1,
-                no_fault:1,
-                /* ------ */
-                int_type:3,
-                rq_eoi:1,
-                dm:1,
-                /* ------ */
-                guest_mode:1,
-                destination:24,
-                rsvd_1:32;
-  } fields_remap;
-};
-
-union irte_ga_hi {
-  uint64_t val;
-  struct {
-      uint64_t  vector:8,
-                rsvd_2:48,
-                destination_hi:8;
-  } fields;
-};
-
-struct irte_ga {
-  union irte_ga_lo lo;
-  union irte_ga_hi hi;
-};
-
 #define TYPE_AMD_IOMMU_DEVICE "amd-iommu"
 OBJECT_DECLARE_SIMPLE_TYPE(AMDVIState, AMD_IOMMU_DEVICE)
 
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 291cb368a9..c7bf21b762 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -89,6 +89,11 @@ typedef struct AMDVIIOTLBKey {
     uint16_t devid;
 } AMDVIIOTLBKey;
 
+typedef struct AMDVIIrteGA {
+    uint64_t ga_lo;
+    uint64_t ga_hi;
+} AMDVIIrteGA;
+
 /* XT IOMMU General Interrupt Control Register layout */
 FIELD(AMDVI_XT_GEN_INTR, DEST_MODE, 2, 1)
 FIELD(AMDVI_XT_GEN_INTR, DEST_LO, 8, 24)
@@ -96,6 +101,37 @@ FIELD(AMDVI_XT_GEN_INTR, VECTOR, 32, 8)
 FIELD(AMDVI_XT_GEN_INTR, DELIVERY_MODE, 40, 1)
 FIELD(AMDVI_XT_GEN_INTR, DEST_HI, 56, 8)
 
+/* Interrupt Remapping Table Fields Formats */
+
+/* Basic 32-bit IRTE layout (GAEn=0) */
+FIELD(AMDVI_IRTE, VALID, 0, 1)
+FIELD(AMDVI_IRTE, SUP_IOPF, 1, 1)
+FIELD(AMDVI_IRTE, INT_TYPE, 2, 3)
+FIELD(AMDVI_IRTE, RQ_EOI, 5, 1)
+FIELD(AMDVI_IRTE, DM, 6, 1)
+FIELD(AMDVI_IRTE, GUEST_MODE, 7, 1)
+FIELD(AMDVI_IRTE, DESTINATION, 8, 8)
+FIELD(AMDVI_IRTE, VECTOR, 16, 8)
+
+/* 128-bit IRTE layout (GAEn=1) */
+FIELD(AMDVI_IRTE_GA_LO, VALID, 0, 1)
+FIELD(AMDVI_IRTE_GA_LO, SUP_IOPF, 1, 1)
+FIELD(AMDVI_IRTE_GA_LO, INT_TYPE, 2, 3)
+FIELD(AMDVI_IRTE_GA_LO, RQ_EOI, 5, 1)
+FIELD(AMDVI_IRTE_GA_LO, DM, 6, 1)
+FIELD(AMDVI_IRTE_GA_LO, GUEST_MODE, 7, 1)
+/*
+ * In the 128-bit IRTE format, XT mode uses IRTE_GA_LOW.Destination[23:0]
+ * together with IRTE_GA_HI.DestinationHi[7:0] to construct a 32-bit x2APIC
+ * destination.
+ * Without XTEn (i.e. when x2APIC support is not enabled), only
+ * IRTE_GA_LOW.Destination[7:0] is used.
+ */
+FIELD(AMDVI_IRTE_GA_LO, DESTINATION, 8, 24)
+
+FIELD(AMDVI_IRTE_GA_HI, VECTOR, 0, 8)
+FIELD(AMDVI_IRTE_GA_HI, DESTINATION_HI, 56, 8)
+
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
     uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
@@ -1983,7 +2019,7 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
 }
 
 static int amdvi_get_irte(AMDVIState *s, MSIMessage *origin, uint64_t *dte,
-                          union irte *irte, uint16_t devid)
+                          uint32_t *irte, uint16_t devid)
 {
     uint64_t irte_root, offset;
 
@@ -1998,7 +2034,8 @@ static int amdvi_get_irte(AMDVIState *s, MSIMessage *origin, uint64_t *dte,
         return -AMDVI_IR_GET_IRTE;
     }
 
-    trace_amdvi_ir_irte_val(irte->val);
+    *irte = le32_to_cpu(*irte);
+    trace_amdvi_ir_irte_val(*irte);
 
     return 0;
 }
@@ -2010,8 +2047,9 @@ static int amdvi_int_remap_legacy(AMDVIState *iommu,
                                   X86IOMMUIrq *irq,
                                   uint16_t sid)
 {
+    uint8_t int_type;
+    uint32_t irte;
     int ret;
-    union irte irte;
 
     /* get interrupt remapping table */
     ret = amdvi_get_irte(iommu, origin, dte, &irte, sid);
@@ -2019,32 +2057,33 @@ static int amdvi_int_remap_legacy(AMDVIState *iommu,
         return ret;
     }
 
-    if (!irte.fields.valid) {
+    if (!FIELD_EX32(irte, AMDVI_IRTE, VALID)) {
         trace_amdvi_ir_target_abort("RemapEn is disabled");
         return -AMDVI_IR_TARGET_ABORT;
     }
 
-    if (irte.fields.guest_mode) {
+    if (FIELD_EX32(irte, AMDVI_IRTE, GUEST_MODE)) {
         error_report_once("guest mode is not zero");
         return -AMDVI_IR_ERR;
     }
 
-    if (irte.fields.int_type > AMDVI_IOAPIC_INT_TYPE_ARBITRATED) {
+    int_type = FIELD_EX32(irte, AMDVI_IRTE, INT_TYPE);
+    if (int_type > AMDVI_IOAPIC_INT_TYPE_ARBITRATED) {
         error_report_once("reserved int_type");
         return -AMDVI_IR_ERR;
     }
 
-    irq->delivery_mode = irte.fields.int_type;
-    irq->vector = irte.fields.vector;
-    irq->dest_mode = irte.fields.dm;
-    irq->redir_hint = irte.fields.rq_eoi;
-    irq->dest = irte.fields.destination;
+    irq->delivery_mode = int_type;
+    irq->vector = FIELD_EX32(irte, AMDVI_IRTE, VECTOR);
+    irq->dest_mode = FIELD_EX32(irte, AMDVI_IRTE, DM);
+    irq->redir_hint = FIELD_EX32(irte, AMDVI_IRTE, RQ_EOI);
+    irq->dest = FIELD_EX32(irte, AMDVI_IRTE, DESTINATION);
 
     return 0;
 }
 
 static int amdvi_get_irte_ga(AMDVIState *s, MSIMessage *origin, uint64_t *dte,
-                             struct irte_ga *irte, uint16_t devid)
+                             AMDVIIrteGA *irte, uint16_t devid)
 {
     uint64_t irte_root, offset;
 
@@ -2058,7 +2097,9 @@ static int amdvi_get_irte_ga(AMDVIState *s, MSIMessage *origin, uint64_t *dte,
         return -AMDVI_IR_GET_IRTE;
     }
 
-    trace_amdvi_ir_irte_ga_val(irte->hi.val, irte->lo.val);
+    irte->ga_lo = le64_to_cpu(irte->ga_lo);
+    irte->ga_hi = le64_to_cpu(irte->ga_hi);
+    trace_amdvi_ir_irte_ga_val(irte->ga_hi, irte->ga_lo);
     return 0;
 }
 
@@ -2069,8 +2110,9 @@ static int amdvi_int_remap_ga(AMDVIState *iommu,
                               X86IOMMUIrq *irq,
                               uint16_t sid)
 {
+    AMDVIIrteGA irte;
+    uint8_t int_type;
     int ret;
-    struct irte_ga irte;
 
     /* get interrupt remapping table */
     ret = amdvi_get_irte_ga(iommu, origin, dte, &irte, sid);
@@ -2078,30 +2120,33 @@ static int amdvi_int_remap_ga(AMDVIState *iommu,
         return ret;
     }
 
-    if (!irte.lo.fields_remap.valid) {
+    if (!FIELD_EX64(irte.ga_lo, AMDVI_IRTE_GA_LO, VALID)) {
         trace_amdvi_ir_target_abort("RemapEn is disabled");
         return -AMDVI_IR_TARGET_ABORT;
     }
 
-    if (irte.lo.fields_remap.guest_mode) {
+    if (FIELD_EX64(irte.ga_lo, AMDVI_IRTE_GA_LO, GUEST_MODE)) {
         error_report_once("guest mode is not zero");
         return -AMDVI_IR_ERR;
     }
 
-    if (irte.lo.fields_remap.int_type > AMDVI_IOAPIC_INT_TYPE_ARBITRATED) {
+    int_type = FIELD_EX64(irte.ga_lo, AMDVI_IRTE_GA_LO, INT_TYPE);
+    if (int_type > AMDVI_IOAPIC_INT_TYPE_ARBITRATED) {
         error_report_once("reserved int_type is set");
         return -AMDVI_IR_ERR;
     }
 
-    irq->delivery_mode = irte.lo.fields_remap.int_type;
-    irq->vector = irte.hi.fields.vector;
-    irq->dest_mode = irte.lo.fields_remap.dm;
-    irq->redir_hint = irte.lo.fields_remap.rq_eoi;
+    irq->delivery_mode = int_type;
+    irq->vector = FIELD_EX64(irte.ga_hi, AMDVI_IRTE_GA_HI, VECTOR);
+    irq->dest_mode = FIELD_EX64(irte.ga_lo, AMDVI_IRTE_GA_LO, DM);
+    irq->redir_hint = FIELD_EX64(irte.ga_lo, AMDVI_IRTE_GA_LO, RQ_EOI);
     if (iommu->xten) {
-        irq->dest = irte.lo.fields_remap.destination |
-                    (irte.hi.fields.destination_hi << 24);
+        irq->dest = FIELD_EX64(irte.ga_lo, AMDVI_IRTE_GA_LO, DESTINATION) |
+                    (FIELD_EX64(irte.ga_hi, AMDVI_IRTE_GA_HI, DESTINATION_HI)
+                    << 24);
     } else {
-        irq->dest = irte.lo.fields_remap.destination & 0xff;
+        irq->dest = FIELD_EX64(irte.ga_lo, AMDVI_IRTE_GA_LO, DESTINATION) &
+                    0xff;
     }
 
     return 0;
-- 
MST


