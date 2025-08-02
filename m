Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8B1C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLi5-0000gm-IZ; Sat, 02 Aug 2025 19:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLhC-0007Xz-Up
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:31:28 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLhA-00051H-C9
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:31:21 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-741a0ec1a05so314769a34.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177479; x=1754782279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7hKQRMRTXCmigZqJckaUTqAy652f0/yVmAQHFcYbaY=;
 b=bbXrrwoRMVsWjYSY483eSrER4dCtMKctGrkUqIhUICqRZ8X4u0HjSKD1kfM1ljiFCe
 GM/zph8HsUNZibXLKQSi3N3VSilERhxhSXazCdASUt6amrhEMh8eQSk6OJmZb10SLHyZ
 mKmerrTfeeH4nSRRkMM/NjCUHKY9l3PH6JcNp6g56VMa/Qv52D633oVHbaaqoj/r1BM/
 2WiX9FCi1sRnetfiUXsN5vL0RNtlapgS7NIIICseooxxSp8pICn9/XQdEtyp8jrk68JY
 8Vl77JaPUmpFIdTIvwPdS6lm+w7vENAsG9+2LenYNpwZDXxDN5+qY/qKMOdMCVZtfW5/
 Z1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177479; x=1754782279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E7hKQRMRTXCmigZqJckaUTqAy652f0/yVmAQHFcYbaY=;
 b=HzFlbu+g510x3+iEnq3JygLHxw7LxDaT5NaYJ+E7DCzHwtxHhkAmhL/i7uJecZuyP6
 nQd4kLe9qvcPokO2kChH+in6OtGagzU70KnfWRWQ8Gq1norvKzpVIlNnySRnNQgtaGGb
 JIjbkcacTYjkHefF8cnEomNrcXZAtOqUsmEEZ9BoS1Spf8LA4O/MpK/JUIJhV3Nfubhk
 EfIcjfirAdxxYZK+SWoeF3Vp/JAgH5Or+batO0cFlDSPCkI2rmrgrsB4vME3hwiZAQqq
 AdNnbr/Q+pJmTZfxs8SrzlV24jST3/nj0NYhIelLbUhPRFsrCa38yXCkYU0q6UUc3ExD
 wxOg==
X-Gm-Message-State: AOJu0YzOyLigexHTqwQJXWc1mJaP0j8cK0GMHbsGlF2sVIUt3FgId/xY
 BhE3cq2OefzMNPeWlsAqAuurJLEGXpDlyCBc5/E9cxoijqdiX56r6MBNA+kEl6FkXIueaBhta+7
 l0R+XIDI=
X-Gm-Gg: ASbGncszAcOJCpSqZ1+BoVZtu/GZlxco8qnd1Gq0rR76ZyKwYMkiDp4OvBwbKKBB/8J
 K4fKVMxhrHo58NIEw75r9FJ76m2OKrtD2/R9KD940vPhH55wAG5HP4thquvAKHffTnk0n7bOAR2
 +oNNpQ8zaYKWu4B7PxmU+h5uwaQ+seoL+JssyAcqFp0+73t6q9+NXL8A4HsZM97JQ58JaTkGodW
 VU43u3ZvPqvEALV2WeT78rwIIzBVmQBA6aHCi0b9l4n+objBS5V+tEsbsBmt8q9WDj8m2ZHCR+j
 aS2OErKrj6AZI34TSVO8YIDyeTAVNoPDT/Jn4QR/7na+guSETGSJDbh7DoFsaS4yvmut3DEXYUM
 IT2C9QK4uPofiKqkbu4cj6ryvQDkwcwZMVVDU2q8hLzZm3eex9HqThh6/erLQCWE=
X-Google-Smtp-Source: AGHT+IGzoPOgD0uSrt+THKXIeR3GKFbFA7ExjR4dUGzLOmW6YosuZIa+AxpXHODvRYP5LMjLsrkzLg==
X-Received: by 2002:a05:6870:80c6:b0:2e8:eccb:fe1c with SMTP id
 586e51a60fabf-30b678c0905mr2797589fac.31.1754177479011; 
 Sat, 02 Aug 2025 16:31:19 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:31:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 17/85] target/arm: Cache NV1 early in get_phys_addr_lpae
Date: Sun,  3 Aug 2025 09:28:45 +1000
Message-ID: <20250802232953.413294-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

We were not using the correct security space in the existing call
to nv_nv1_enabled, because it may have been modified for NSTable.

Cache it early, as we will shortly need it elsewhere as well.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 2eb2041edb..a5a3c03a4c 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -76,6 +76,8 @@ typedef struct S1Translate {
      * may be suppressed for debug or AT insns.
      */
     uint8_t in_prot_check;
+    /* Cached EffectiveHCR_EL2_NVx() bit */
+    bool in_nv1;
     bool out_rw;
     bool out_be;
     ARMSecuritySpace out_space;
@@ -1642,12 +1644,6 @@ static bool lpae_block_desc_valid(ARMCPU *cpu, bool ds,
     }
 }
 
-static bool nv_nv1_enabled(CPUARMState *env, S1Translate *ptw)
-{
-    uint64_t hcr = arm_hcr_el2_eff_secstate(env, ptw->in_space);
-    return (hcr & (HCR_NV | HCR_NV1)) == (HCR_NV | HCR_NV1);
-}
-
 /**
  * get_phys_addr_lpae: perform one stage of page table walk, LPAE format
  *
@@ -1699,6 +1695,10 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
                                    !arm_el_is_aa64(env, 1));
         level = 0;
 
+        /* Cache NV1 before we adjust ptw->in_space for NSTable. */
+        ptw->in_nv1 = (arm_hcr_el2_eff_secstate(env, ptw->in_space)
+                       & (HCR_NV | HCR_NV1)) == (HCR_NV | HCR_NV1);
+
         /*
          * If TxSZ is programmed to a value larger than the maximum,
          * or smaller than the effective minimum, it is IMPLEMENTATION
@@ -2074,7 +2074,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         xn = extract64(attrs, 54, 1);
         pxn = extract64(attrs, 53, 1);
 
-        if (el == 1 && nv_nv1_enabled(env, ptw)) {
+        if (el == 1 && ptw->in_nv1) {
             /*
              * With FEAT_NV, when HCR_EL2.{NV,NV1} == {1,1}, the block/page
              * descriptor bit 54 holds PXN, 53 is RES0, and the effective value
-- 
2.43.0


