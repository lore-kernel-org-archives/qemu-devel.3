Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6677C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR49-0001pR-Cz; Thu, 18 Jul 2024 09:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3q-0008Nb-Vo
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:46 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3o-0004V2-Iq
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:42 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4272738eb9eso2687385e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721308838; x=1721913638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sA1K5/Oeol4qp2eoj4lcjjemIJtuASvZg2EHT+nPS3A=;
 b=SAzlInyZ7HieFRSNQYa9FZTeZpLPRPPNYNx7lPwXIXB0uPEkmZIVdyAzCfYqZrVdAy
 VFb4YFORKiIRf0xq2k7QsChMhCAytuXBsO0OyuAqbNr66M/vqowa2VFjxZGAdrZrGcwA
 TNG95dkA6V0spMsv8RCotAQm/7k/Ct9GHS8+AC8hIOGfBBn2viwNGPf4Z2K5b0210deH
 lyBccN1CGdLBCZaZUOCO7p5J8gkF5oLTYTRkBpWLzb5TmKnIXu8kKqtXy6t+3ZGzT9Fn
 ZWTHIq2Yfn3ASvWOoTFYfUDxHcHzePCl+kwGBszHV/ur+QjSrwvqLanctxNVwSa03SNi
 WOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721308838; x=1721913638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sA1K5/Oeol4qp2eoj4lcjjemIJtuASvZg2EHT+nPS3A=;
 b=MVn3l1wZtNPjqthAduhc4f/CL50EpTYl7/WgFvyOX00FsQJmdMXMRgejlcOKPmod3w
 F2VpVOlqJHbBgcAR58K+ktrwWM3NrBi/1CGiEf1i1OwCgvmMsNZblb1mt2HiTTxacrO8
 UXtMIlFOffBA/Kn92igd2k1okRsKI0z+FvTaC+b4KTdIAorEDaUvEeCQaf405TNc0kpy
 NP/TB3YshQXAig7WvU0GtOePbdcoJNZB5D2F6jp9H00YXhKMNMKBekucs+aJW/PIiL7d
 TuVpWFXUGPZ+aThJCAO5bTTI4/2cpnXnfwkGoHy8atXOamsBtUjl9PHleGSRz5r7gKpJ
 K0Ng==
X-Gm-Message-State: AOJu0YxilnN5s0RKsKvqqnIHqNdRSTEwbZPaNGcSmZS2WFSXQ3UZVbP7
 OV4l2G347lACub87CqSkYDs1hygABJ5ZF5hwtfvp4Km61LCpPk46xZQXSr5RVgQDpRPGNtAjAAc
 M
X-Google-Smtp-Source: AGHT+IHQzqjAA469010/g1HtMi0tQKIAS8p3PqpaURCKfGx6mGa8S5TsMjQo32Jwig3WwkgK9moE2A==
X-Received: by 2002:a05:600c:4e92:b0:426:5c34:b19b with SMTP id
 5b1f17b1804b1-427c2cc33damr30765765e9.20.1721308838254; 
 Thu, 18 Jul 2024 06:20:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e420sm14059315e9.35.2024.07.18.06.20.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:20:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/26] hw/arm/smmu: Introduce smmu_iotlb_inv_asid_vmid
Date: Thu, 18 Jul 2024 14:20:18 +0100
Message-Id: <20240718132028.697927-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718132028.697927-1-peter.maydell@linaro.org>
References: <20240718132028.697927-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Soon, Instead of doing TLB invalidation by ASID only, VMID will be
also required.
Add smmu_iotlb_inv_asid_vmid() which invalidates by both ASID and VMID.

However, at the moment this function is only used in SMMU_CMD_TLBI_NH_ASID
which is a stage-1 command, so passing VMID = -1 keeps the original
behaviour.

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20240715084519.1189624-14-smostafa@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/smmu-common.h |  2 +-
 hw/arm/smmu-common.c         | 20 +++++++++++++-------
 hw/arm/smmuv3.c              |  2 +-
 hw/arm/trace-events          |  2 +-
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index da9ff45fb5a..eaee867e45c 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -213,7 +213,7 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
 SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
                                 uint8_t tg, uint8_t level);
 void smmu_iotlb_inv_all(SMMUState *s);
-void smmu_iotlb_inv_asid(SMMUState *s, int asid);
+void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid);
 void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
 void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
                          uint8_t tg, uint64_t num_pages, uint8_t ttl);
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 4b0857ab4d7..e7f9c758fa6 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -159,13 +159,14 @@ void smmu_iotlb_inv_all(SMMUState *s)
     g_hash_table_remove_all(s->iotlb);
 }
 
-static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
-                                         gpointer user_data)
+static gboolean smmu_hash_remove_by_asid_vmid(gpointer key, gpointer value,
+                                              gpointer user_data)
 {
-    int asid = *(int *)user_data;
+    SMMUIOTLBPageInvInfo *info = (SMMUIOTLBPageInvInfo *)user_data;
     SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
 
-    return SMMU_IOTLB_ASID(*iotlb_key) == asid;
+    return (SMMU_IOTLB_ASID(*iotlb_key) == info->asid) &&
+           (SMMU_IOTLB_VMID(*iotlb_key) == info->vmid);
 }
 
 static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
@@ -270,10 +271,15 @@ void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
                                 &info);
 }
 
-void smmu_iotlb_inv_asid(SMMUState *s, int asid)
+void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid)
 {
-    trace_smmu_iotlb_inv_asid(asid);
-    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid, &asid);
+    SMMUIOTLBPageInvInfo info = {
+        .asid = asid,
+        .vmid = vmid,
+    };
+
+    trace_smmu_iotlb_inv_asid_vmid(asid, vmid);
+    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid_vmid, &info);
 }
 
 void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ebf29f3adf7..847fc566762 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1357,7 +1357,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
 
             trace_smmuv3_cmdq_tlbi_nh_asid(asid);
             smmu_inv_notifiers_all(&s->smmu_state);
-            smmu_iotlb_inv_asid(bs, asid);
+            smmu_iotlb_inv_asid_vmid(bs, asid, -1);
             break;
         }
         case SMMU_CMD_TLBI_NH_ALL:
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 7d9c1703da1..4aa71b1b196 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -11,7 +11,7 @@ smmu_ptw_page_pte(int stage, int level,  uint64_t iova, uint64_t baseaddr, uint6
 smmu_ptw_block_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t iova, uint64_t gpa, int bsize_mb) "stage=%d level=%d base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" iova=0x%"PRIx64" block address = 0x%"PRIx64" block size = %d MiB"
 smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "baseaddr=0x%"PRIx64" index=0x%x, pteaddr=0x%"PRIx64", pte=0x%"PRIx64
 smmu_iotlb_inv_all(void) "IOTLB invalidate all"
-smmu_iotlb_inv_asid(int asid) "IOTLB invalidate asid=%d"
+smmu_iotlb_inv_asid_vmid(int asid, int vmid) "IOTLB invalidate asid=%d vmid=%d"
 smmu_iotlb_inv_vmid(int vmid) "IOTLB invalidate vmid=%d"
 smmu_iotlb_inv_iova(int asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
 smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
-- 
2.34.1


