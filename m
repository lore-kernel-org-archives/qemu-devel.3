Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01534C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR4A-000204-V1; Thu, 18 Jul 2024 09:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3n-00085I-0z
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:40 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3i-0004TC-O4
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:37 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2eeb1ba0468so11465821fa.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721308832; x=1721913632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v9HD9ARg19Jqe83BWvMljdXei9HAy93M0+v9flXqPJQ=;
 b=K3ooLbL/4O7X8tEWY9qor/yiDmOB/eRbguIsSJQyVYNViXHvFf39heNva1CRScgUM1
 544fm+GZ+oNRDB2Vg/SAg4zsF0nm3IY/84Is79E+1+29j8d6g9rrh7rTh5W8Jv9gm3uA
 /LGs+lcGAr7PeFV531CuaBIf2iuv6StElHK6kKTQy7ZHgTTAtLPnZVZcNtviNZriJIoJ
 qKg16x54qQQnZodrbcJjNb4dOvw/5kU35Mu439YRZzNKGQLsGMGX9FJ6ajtgida51A0S
 MzNgT6/3eCoV3ut9gWFf8RuRTBP/dFLulfnZwFksFLXElJ71FMhgltO166vP0+7Dyj2x
 iXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721308832; x=1721913632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v9HD9ARg19Jqe83BWvMljdXei9HAy93M0+v9flXqPJQ=;
 b=UJ58N8NYEcQnq9m67QGuoM2/citDO8Ky48/3kYVhLKz981996Ieb5d/cZ6I5kKJ6CC
 2E4YgHdjao97bvxm3RJsS8cEX6NOags0FSu47iYPNSJtN7l4Hhocv87AChzmEiMvvY46
 8UqwNcegMdr0aDJLgZ7U5oK/d5sgdlWHHdw037a4gXFgSABvY7CbSi3+ZhsqfAqhQg/q
 M7CokF8Y1DFpcW20A/YT5GXl+rMyi37+zH8Sz7B3JAFJuHXAMvZkOka2p27d2o3gL3Vm
 7buZuCYc6W0cWf0nhoBDdzwWfhPLfqq+DJqKWd6OcIeHReq6cFgY3va7Mzg3YhD6Sk9U
 MpAQ==
X-Gm-Message-State: AOJu0Yx/33ARx/6W2Mh9vkQ94zNbrQTsRuZ+s88I81n5amn0+dA3KPOx
 2sEeMzgifGGbWU0fZaoIhwFDq/xB6A06VnRPXMfFvOIneLA2eMjB3hsxu2+3KL8IxFltrO+v/7x
 h
X-Google-Smtp-Source: AGHT+IH/HcLT9iXrBqLy0X+P+SJ9nmkUh/djx72ZDktpqrqSu9uqZMZXSogjepbEAm8aGLRHUF3S6w==
X-Received: by 2002:a2e:a304:0:b0:2ee:8ce9:3037 with SMTP id
 38308e7fff4ca-2ef05d27e3emr17883461fa.37.1721308832561; 
 Thu, 18 Jul 2024 06:20:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e420sm14059315e9.35.2024.07.18.06.20.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:20:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/26] hw/arm/smmu: Fix IPA for stage-2 events
Date: Thu, 18 Jul 2024 14:20:07 +0100
Message-Id: <20240718132028.697927-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718132028.697927-1-peter.maydell@linaro.org>
References: <20240718132028.697927-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
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

For the following events (ARM IHI 0070 F.b - 7.3 Event records):
- F_TRANSLATION
- F_ACCESS
- F_PERMISSION
- F_ADDR_SIZE

If fault occurs at stage 2, S2 == 1 and:
  - If translating an IPA for a transaction (whether by input to
    stage 2-only configuration, or after successful stage 1 translation),
    CLASS == IN, and IPA is provided.

At the moment only CLASS == IN is used which indicates input
translation.

However, this was not implemented correctly, as for stage 2, the code
only sets the  S2 bit but not the IPA.

This field has the same bits as FetchAddr in F_WALK_EABT which is
populated correctly, so we don’t change that.
The setting of this field should be done from the walker as the IPA address
wouldn't be known in case of nesting.

For stage 1, the spec says:
  If fault occurs at stage 1, S2 == 0 and:
  CLASS == IN, IPA is UNKNOWN.

So, no need to set it to for stage 1, as ptw_info is initialised by zero in
smmuv3_translate().

Fixes: e703f7076a “hw/arm/smmuv3: Add page table walk for stage-2”
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
Message-id: 20240715084519.1189624-3-smostafa@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmu-common.c | 10 ++++++----
 hw/arm/smmuv3.c      |  4 ++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index e81b684d06c..e8cdbcd8aef 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -448,7 +448,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
      */
     if (ipa >= (1ULL << inputsize)) {
         info->type = SMMU_PTW_ERR_TRANSLATION;
-        goto error;
+        goto error_ipa;
     }
 
     while (level < VMSA_LEVELS) {
@@ -494,13 +494,13 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
          */
         if (!PTE_AF(pte) && !cfg->s2cfg.affd) {
             info->type = SMMU_PTW_ERR_ACCESS;
-            goto error;
+            goto error_ipa;
         }
 
         s2ap = PTE_AP(pte);
         if (is_permission_fault_s2(s2ap, perm)) {
             info->type = SMMU_PTW_ERR_PERMISSION;
-            goto error;
+            goto error_ipa;
         }
 
         /*
@@ -509,7 +509,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
          */
         if (gpa >= (1ULL << cfg->s2cfg.eff_ps)) {
             info->type = SMMU_PTW_ERR_ADDR_SIZE;
-            goto error;
+            goto error_ipa;
         }
 
         tlbe->entry.translated_addr = gpa;
@@ -522,6 +522,8 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
     }
     info->type = SMMU_PTW_ERR_TRANSLATION;
 
+error_ipa:
+    info->addr = ipa;
 error:
     info->stage = 2;
     tlbe->entry.perm = IOMMU_NONE;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 445e04ddf7c..cab545a0b46 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -949,6 +949,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
             if (PTW_RECORD_FAULT(cfg)) {
                 event.type = SMMU_EVT_F_TRANSLATION;
                 event.u.f_translation.addr = addr;
+                event.u.f_translation.addr2 = ptw_info.addr;
                 event.u.f_translation.rnw = flag & 0x1;
             }
             break;
@@ -956,6 +957,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
             if (PTW_RECORD_FAULT(cfg)) {
                 event.type = SMMU_EVT_F_ADDR_SIZE;
                 event.u.f_addr_size.addr = addr;
+                event.u.f_addr_size.addr2 = ptw_info.addr;
                 event.u.f_addr_size.rnw = flag & 0x1;
             }
             break;
@@ -963,6 +965,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
             if (PTW_RECORD_FAULT(cfg)) {
                 event.type = SMMU_EVT_F_ACCESS;
                 event.u.f_access.addr = addr;
+                event.u.f_access.addr2 = ptw_info.addr;
                 event.u.f_access.rnw = flag & 0x1;
             }
             break;
@@ -970,6 +973,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
             if (PTW_RECORD_FAULT(cfg)) {
                 event.type = SMMU_EVT_F_PERMISSION;
                 event.u.f_permission.addr = addr;
+                event.u.f_permission.addr2 = ptw_info.addr;
                 event.u.f_permission.rnw = flag & 0x1;
             }
             break;
-- 
2.34.1


