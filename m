Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9EFC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR43-0001Cg-Vr; Thu, 18 Jul 2024 09:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3p-0008FZ-1Z
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:42 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3m-0004U2-NA
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:40 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-426636ef8c9so2640585e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721308836; x=1721913636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D810Dx8frc2vW1zCIoJr9KDHLMBTCs78RFKDiRd8O1g=;
 b=I/NJ1XlQZFzucj3Gt09lVnDkNH1vYWCD/NP2/5tBBntFB6/in33/6enj3AHEBAzcj7
 d6OJLjXxu6dKP/EXm1VS5uWL8OzoPqQJ+VZWWbdzGhGRRhKPgbP+DzynrXjt59+bF3IE
 u9U/yBUKSBJb2bd8y4SbXy2K8zTMYFd64UiLeglsVoXCVh+MH7nkPLpAoZfVA1HOcwHR
 7sOd3iyLDtqdLJLhi/Bgr28iNMkrMsqrfPny44+fdTOhWG1fXe2aqpklRvvcnzrOwL+X
 ITpjuTrXoNSpP7HdblsUAKthwPLqVg+TwGyEEeYZFWbek0dJyFa21RHXD1ceIDPTE6tj
 RRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721308836; x=1721913636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D810Dx8frc2vW1zCIoJr9KDHLMBTCs78RFKDiRd8O1g=;
 b=gngM0iXHjKPGqZKZmoq5n878+HwH7vyC1Bu+1S45kDtz/WlGs4F1O0FIovw5CwuU0Q
 LIGFRlnlHQTKQ3/k0PObXdpg9aaYhYmzVGNMhGCTdKIRlZ6x+4d3YCa1aI01KfkncAIn
 GH1xcSjLKpPBmwoxt81zfr5Q+x/BJOyEc6VasPlYZ+F+3vvPaJ7XnF0ODKBP1is32MhY
 PjOPk7HSFFxePEdVNON5E5CKLOspSkgYdQbciuN0xW8mFwA5uI69QfqdQ86pp57IFuSU
 ZpIS3CsnB9s9RufR7Ya0IjcismvLtdV6SjE0XWWszIZkV2E3+FQ+y7Lj+1S4CXTDTLJm
 spgA==
X-Gm-Message-State: AOJu0Yx6rIsytWx5WqRGpKdTKeQCIVZCmLuGm06cvrMZL5KIY0Fu8/Ik
 eJoQrIU1G/I1ZHst+4Jk781qj1DyvVgHfd20JC7qCCw+jSMaiXRVOprrRCVo8QfolCXvzdXQmG7
 +
X-Google-Smtp-Source: AGHT+IFdNU0vBG7fuqtRknxK3HQcMQx4RxHzpJqc4Se9Ga1iCEVfSdpF7XQtDAvqDGJeYx7SYqHzdQ==
X-Received: by 2002:a05:600c:3b8c:b0:427:abf6:f0e6 with SMTP id
 5b1f17b1804b1-427c2cb0878mr35155145e9.9.1721308835758; 
 Thu, 18 Jul 2024 06:20:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e420sm14059315e9.35.2024.07.18.06.20.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:20:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/26] hw/arm/smmuv3: Translate CD and TT using stage-2 table
Date: Thu, 18 Jul 2024 14:20:13 +0100
Message-Id: <20240718132028.697927-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718132028.697927-1-peter.maydell@linaro.org>
References: <20240718132028.697927-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mostafa Saleh <smostafa@google.com>

According to ARM SMMU architecture specification (ARM IHI 0070 F.b),
In "5.2 Stream Table Entry":
 [51:6] S1ContextPtr
 If Config[1] == 1 (stage 2 enabled), this pointer is an IPA translated by
 stage 2 and the programmed value must be within the range of the IAS.

In "5.4.1 CD notes":
 The translation table walks performed from TTB0 or TTB1 are always performed
 in IPA space if stage 2 translations are enabled.

This patch implements translation of the S1 context descriptor pointer and
TTBx base addresses through the S2 stage (IPA -> PA)

smmuv3_do_translate() is updated to have one arg which is translation
class, this is useful to:
 - Decide wether a translation is stage-2 only or use the STE config.
 - Populate the class in case of faults, WALK_EABT is left unchanged
   for stage-1 as it is always IN, while stage-2 would match the
   used class (TT, IN, CD), this will change slightly when the ptw
   supports nested translation as it can also issue TT event with
   class IN.

In case for stage-2 only translation, used in the context of nested
translation, the stage and asid are saved and restored before and
after calling smmu_translate().

Translating CD or TTBx can fail for the following reasons:
1) Large address size: This is described in
   (3.4.3 Address sizes of SMMU-originated accesses)
   - For CD ptr larger than IAS, for SMMUv3.1, it can trigger either
     C_BAD_STE or Translation fault, we implement the latter as it
     requires no extra code.
   - For TTBx, if larger than the effective stage 1 output address size, it
     triggers C_BAD_CD.

2) Faults from PTWs (7.3 Event records)
   - F_ADDR_SIZE: large address size after first level causes stage 2 Address
     Size fault (Also in 3.4.3 Address sizes of SMMU-originated accesses)
   - F_PERMISSION: Same as an address translation. However, when
     CLASS == CD, the access is implicitly Data and a read.
   - F_ACCESS: Same as an address translation.
   - F_TRANSLATION: Same as an address translation.
   - F_WALK_EABT: Same as an address translation.
  These are already implemented in the PTW logic, so no extra handling
  required.

As in CD and TTBx translation context, the iova is not known, setting
the InputAddr was removed from "smmuv3_do_translate" and set after
from "smmuv3_translate" with the new function "smmuv3_fixup_event"

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20240715084519.1189624-9-smostafa@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 120 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 103 insertions(+), 17 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index dc63e07d683..5c5fee27997 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -337,14 +337,35 @@ static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
 
 }
 
+static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
+                                                 SMMUTransCfg *cfg,
+                                                 SMMUEventInfo *event,
+                                                 IOMMUAccessFlags flag,
+                                                 SMMUTLBEntry **out_entry,
+                                                 SMMUTranslationClass class);
 /* @ssid > 0 not supported yet */
-static int smmu_get_cd(SMMUv3State *s, STE *ste, uint32_t ssid,
-                       CD *buf, SMMUEventInfo *event)
+static int smmu_get_cd(SMMUv3State *s, STE *ste, SMMUTransCfg *cfg,
+                       uint32_t ssid, CD *buf, SMMUEventInfo *event)
 {
     dma_addr_t addr = STE_CTXPTR(ste);
     int ret, i;
+    SMMUTranslationStatus status;
+    SMMUTLBEntry *entry;
 
     trace_smmuv3_get_cd(addr);
+
+    if (cfg->stage == SMMU_NESTED) {
+        status = smmuv3_do_translate(s, addr, cfg, event,
+                                     IOMMU_RO, &entry, SMMU_CLASS_CD);
+
+        /* Same PTW faults are reported but with CLASS = CD. */
+        if (status != SMMU_TRANS_SUCCESS) {
+            return -EINVAL;
+        }
+
+        addr = CACHED_ENTRY_TO_ADDR(entry, addr);
+    }
+
     /* TODO: guarantee 64-bit single-copy atomicity */
     ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf),
                           MEMTXATTRS_UNSPECIFIED);
@@ -659,10 +680,13 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
     return 0;
 }
 
-static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
+static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
+                     CD *cd, SMMUEventInfo *event)
 {
     int ret = -EINVAL;
     int i;
+    SMMUTranslationStatus status;
+    SMMUTLBEntry *entry;
 
     if (!CD_VALID(cd) || !CD_AARCH64(cd)) {
         goto bad_cd;
@@ -713,9 +737,26 @@ static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
 
         tt->tsz = tsz;
         tt->ttb = CD_TTB(cd, i);
+
         if (tt->ttb & ~(MAKE_64BIT_MASK(0, cfg->oas))) {
             goto bad_cd;
         }
+
+        /* Translate the TTBx, from IPA to PA if nesting is enabled. */
+        if (cfg->stage == SMMU_NESTED) {
+            status = smmuv3_do_translate(s, tt->ttb, cfg, event, IOMMU_RO,
+                                         &entry, SMMU_CLASS_TT);
+            /*
+             * Same PTW faults are reported but with CLASS = TT.
+             * If TTBx is larger than the effective stage 1 output addres
+             * size, it reports C_BAD_CD, which is handled by the above case.
+             */
+            if (status != SMMU_TRANS_SUCCESS) {
+                return -EINVAL;
+            }
+            tt->ttb = CACHED_ENTRY_TO_ADDR(entry, tt->ttb);
+        }
+
         tt->had = CD_HAD(cd, i);
         trace_smmuv3_decode_cd_tt(i, tt->tsz, tt->ttb, tt->granule_sz, tt->had);
     }
@@ -767,12 +808,12 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
         return 0;
     }
 
-    ret = smmu_get_cd(s, &ste, 0 /* ssid */, &cd, event);
+    ret = smmu_get_cd(s, &ste, cfg, 0 /* ssid */, &cd, event);
     if (ret) {
         return ret;
     }
 
-    return decode_cd(cfg, &cd, event);
+    return decode_cd(s, cfg, &cd, event);
 }
 
 /**
@@ -832,58 +873,80 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
                                                  SMMUTransCfg *cfg,
                                                  SMMUEventInfo *event,
                                                  IOMMUAccessFlags flag,
-                                                 SMMUTLBEntry **out_entry)
+                                                 SMMUTLBEntry **out_entry,
+                                                 SMMUTranslationClass class)
 {
     SMMUPTWEventInfo ptw_info = {};
     SMMUState *bs = ARM_SMMU(s);
     SMMUTLBEntry *cached_entry = NULL;
+    int asid, stage;
+    bool desc_s2_translation = class != SMMU_CLASS_IN;
+
+    /*
+     * The function uses the argument class to identify which stage is used:
+     * - CLASS = IN: Means an input translation, determine the stage from STE.
+     * - CLASS = CD: Means the addr is an IPA of the CD, and it would be
+     *   translated using the stage-2.
+     * - CLASS = TT: Means the addr is an IPA of the stage-1 translation table
+     *   and it would be translated using the stage-2.
+     * For the last 2 cases instead of having intrusive changes in the common
+     * logic, we modify the cfg to be a stage-2 translation only in case of
+     * nested, and then restore it after.
+     */
+    if (desc_s2_translation) {
+        asid = cfg->asid;
+        stage = cfg->stage;
+        cfg->asid = -1;
+        cfg->stage = SMMU_STAGE_2;
+    }
 
     cached_entry = smmu_translate(bs, cfg, addr, flag, &ptw_info);
+
+    if (desc_s2_translation) {
+        cfg->asid = asid;
+        cfg->stage = stage;
+    }
+
     if (!cached_entry) {
         /* All faults from PTW has S2 field. */
         event->u.f_walk_eabt.s2 = (ptw_info.stage == SMMU_STAGE_2);
         switch (ptw_info.type) {
         case SMMU_PTW_ERR_WALK_EABT:
             event->type = SMMU_EVT_F_WALK_EABT;
-            event->u.f_walk_eabt.addr = addr;
             event->u.f_walk_eabt.rnw = flag & 0x1;
             event->u.f_walk_eabt.class = (ptw_info.stage == SMMU_STAGE_2) ?
-                                          SMMU_CLASS_IN : SMMU_CLASS_TT;
+                                          class : SMMU_CLASS_TT;
             event->u.f_walk_eabt.addr2 = ptw_info.addr;
             break;
         case SMMU_PTW_ERR_TRANSLATION:
             if (PTW_RECORD_FAULT(cfg)) {
                 event->type = SMMU_EVT_F_TRANSLATION;
-                event->u.f_translation.addr = addr;
                 event->u.f_translation.addr2 = ptw_info.addr;
-                event->u.f_translation.class = SMMU_CLASS_IN;
+                event->u.f_translation.class = class;
                 event->u.f_translation.rnw = flag & 0x1;
             }
             break;
         case SMMU_PTW_ERR_ADDR_SIZE:
             if (PTW_RECORD_FAULT(cfg)) {
                 event->type = SMMU_EVT_F_ADDR_SIZE;
-                event->u.f_addr_size.addr = addr;
                 event->u.f_addr_size.addr2 = ptw_info.addr;
-                event->u.f_addr_size.class = SMMU_CLASS_IN;
+                event->u.f_addr_size.class = class;
                 event->u.f_addr_size.rnw = flag & 0x1;
             }
             break;
         case SMMU_PTW_ERR_ACCESS:
             if (PTW_RECORD_FAULT(cfg)) {
                 event->type = SMMU_EVT_F_ACCESS;
-                event->u.f_access.addr = addr;
                 event->u.f_access.addr2 = ptw_info.addr;
-                event->u.f_access.class = SMMU_CLASS_IN;
+                event->u.f_access.class = class;
                 event->u.f_access.rnw = flag & 0x1;
             }
             break;
         case SMMU_PTW_ERR_PERMISSION:
             if (PTW_RECORD_FAULT(cfg)) {
                 event->type = SMMU_EVT_F_PERMISSION;
-                event->u.f_permission.addr = addr;
                 event->u.f_permission.addr2 = ptw_info.addr;
-                event->u.f_permission.class = SMMU_CLASS_IN;
+                event->u.f_permission.class = class;
                 event->u.f_permission.rnw = flag & 0x1;
             }
             break;
@@ -896,6 +959,27 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
     return SMMU_TRANS_SUCCESS;
 }
 
+/*
+ * Sets the InputAddr for an SMMU_TRANS_ERROR, as it can't be
+ * set from all contexts, as smmuv3_get_config() can return
+ * translation faults in case of nested translation (for CD
+ * and TTBx). But in that case the iova is not known.
+ */
+static void smmuv3_fixup_event(SMMUEventInfo *event, hwaddr iova)
+{
+    switch (event->type) {
+    case SMMU_EVT_F_WALK_EABT:
+    case SMMU_EVT_F_TRANSLATION:
+    case SMMU_EVT_F_ADDR_SIZE:
+    case SMMU_EVT_F_ACCESS:
+    case SMMU_EVT_F_PERMISSION:
+        event->u.f_walk_eabt.addr = iova;
+        break;
+    default:
+        break;
+    }
+}
+
 /* Entry point to SMMU, does everything. */
 static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
                                       IOMMUAccessFlags flag, int iommu_idx)
@@ -944,7 +1028,8 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         goto epilogue;
     }
 
-    status = smmuv3_do_translate(s, addr, cfg, &event, flag, &cached_entry);
+    status = smmuv3_do_translate(s, addr, cfg, &event, flag,
+                                 &cached_entry, SMMU_CLASS_IN);
 
 epilogue:
     qemu_mutex_unlock(&s->mutex);
@@ -975,6 +1060,7 @@ epilogue:
                                      entry.perm);
         break;
     case SMMU_TRANS_ERROR:
+        smmuv3_fixup_event(&event, addr);
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s translation failed for iova=0x%"PRIx64" (%s)\n",
                       mr->parent_obj.name, addr, smmu_event_string(event.type));
-- 
2.34.1


