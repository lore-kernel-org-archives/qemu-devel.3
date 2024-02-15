Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B69C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafer-0000Pu-UG; Thu, 15 Feb 2024 12:36:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeN-00082D-AW
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:56 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeH-0003yH-9F
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:54 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3392b12dd21so593277f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018547; x=1708623347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Puvpk4TVJiO9xUni4lYr0u8G/jHoFixJ5pd80hsW78E=;
 b=Lsg3j2hXjTJtafdmjN28q+xxBgcZKK4yL2E0SH5+i8mt9rzf31IVIbfkymhKM9L2Re
 5j+3AHehw96FhZoCRfPyg46hkYNNBHTW4JW9+tZx2kaYs5c3extwbt/Ep4zHFicrT5jb
 8t7ZT4bgIXvx50FAayUS+7Nr0dgs/zzeppWibktVA+BjOVrzCH7o9bqT+ZeTzq4zz1pf
 dhh9Xr5BwubVrF7mRxSe0C69dMaLjLiNRiUXcPYVnuO8v1HJC05CxYSOwerXclFYPsjY
 vZrlqJZAWEezvIOlt7b8uibaPYtFeLsa7+kUlHQbEW1+IPXSrUwnIEr38CrKnlPKyQ8x
 oh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018547; x=1708623347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Puvpk4TVJiO9xUni4lYr0u8G/jHoFixJ5pd80hsW78E=;
 b=FrXGSLOsBn1aWp5wgU64MoEWx1qA7B99Y7X/x7WIxnHOBUKRYv8tVZ8q7DYhIj9oXD
 HS6HzNNocH45/7YZSw92zhJhMBbB6xPnI1V+MQR+u9eDkksq8BlLE8gTxiNsu0Ld681a
 EclrQq3Hql+2wh3gM59Fn8+P1xB8TbY2u94pfPadzDJd7PgS0AmvxrMsbiVeQG5ebJgP
 WliO3KLSUUqmVP3AED9tULvH/aWNM1m7UouMBQAcHYzomYD/hZD24G1MPXV5HCTtr96u
 TzCAdMwhGkW5UCa235oLqkaoFmKhyMTJkV5UnJ/AOld1Q1cSdA9XH/fDi4zEKKI1yDX+
 hG5Q==
X-Gm-Message-State: AOJu0Yy7HXj4IQv4KPUrOaNDvgTPqYcj1JgRVx7ZdG4zTcYx8XjpkPdg
 HgWGEeXBVzxlTA0XZ44BeLSudGkd2DZ27v4hMS9/sUI9OQeJF5Iuf8hhatvKQB2BtVvx4QcRuc/
 P
X-Google-Smtp-Source: AGHT+IGPN0VZ/f1ksdsC5RdZabcSKVr8/1/D8+rKfW1xS2MkdorSutz9f45Jo4j3cFotV/MrirENMQ==
X-Received: by 2002:a5d:4b50:0:b0:33b:607a:ba29 with SMTP id
 w16-20020a5d4b50000000b0033b607aba29mr1877161wrs.53.1708018547414; 
 Thu, 15 Feb 2024 09:35:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/35] hw/arm/smmuv3: add support for stage 1 access fault
Date: Thu, 15 Feb 2024 17:35:21 +0000
Message-Id: <20240215173538.2430599-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Luc Michel <luc.michel@amd.com>

An access fault is raised when the Access Flag is not set in the
looked-up PTE and the AFFD field is not set in the corresponding context
descriptor. This was already implemented for stage 2. Implement it for
stage 1 as well.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Message-id: 20240213082211.3330400-1-luc.michel@amd.com
[PMM: tweaked comment text]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-internal.h     |  1 +
 include/hw/arm/smmu-common.h |  1 +
 hw/arm/smmu-common.c         | 11 +++++++++++
 hw/arm/smmuv3.c              |  1 +
 4 files changed, 14 insertions(+)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index e987bc4686b..e4dd11e1e62 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -624,6 +624,7 @@ static inline int pa_range(STE *ste)
 #define CD_EPD(x, sel)   extract32((x)->word[0], (16 * (sel)) + 14, 1)
 #define CD_ENDI(x)       extract32((x)->word[0], 15, 1)
 #define CD_IPS(x)        extract32((x)->word[1], 0 , 3)
+#define CD_AFFD(x)       extract32((x)->word[1], 3 , 1)
 #define CD_TBI(x)        extract32((x)->word[1], 6 , 2)
 #define CD_HD(x)         extract32((x)->word[1], 10 , 1)
 #define CD_HA(x)         extract32((x)->word[1], 11 , 1)
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index fd8d772da11..5ec2e6c1a43 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -92,6 +92,7 @@ typedef struct SMMUTransCfg {
     bool disabled;             /* smmu is disabled */
     bool bypassed;             /* translation is bypassed */
     bool aborted;              /* translation is aborted */
+    bool affd;                 /* AF fault disable */
     uint32_t iotlb_hits;       /* counts IOTLB hits */
     uint32_t iotlb_misses;     /* counts IOTLB misses*/
     /* Used by stage-1 only. */
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index f58261bb81e..4caedb49983 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -364,6 +364,17 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
                                      pte_addr, pte, iova, gpa,
                                      block_size >> 20);
         }
+
+        /*
+         * QEMU does not currently implement HTTU, so if AFFD and PTE.AF
+         * are 0 we take an Access flag fault. (5.4. Context Descriptor)
+         * An Access flag fault takes priority over a Permission fault.
+         */
+        if (!PTE_AF(pte) && !cfg->affd) {
+            info->type = SMMU_PTW_ERR_ACCESS;
+            goto error;
+        }
+
         ap = PTE_AP(pte);
         if (is_permission_fault(ap, perm)) {
             info->type = SMMU_PTW_ERR_PERMISSION;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index b3d8642a499..9eb56a70f39 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -684,6 +684,7 @@ static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
     cfg->oas = MIN(oas2bits(SMMU_IDR5_OAS), cfg->oas);
     cfg->tbi = CD_TBI(cd);
     cfg->asid = CD_ASID(cd);
+    cfg->affd = CD_AFFD(cd);
 
     trace_smmuv3_decode_cd(cfg->oas);
 
-- 
2.34.1


