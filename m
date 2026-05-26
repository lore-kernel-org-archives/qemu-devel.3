Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D002CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmc-0000ZL-FE; Tue, 26 May 2026 10:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmS-0008Px-LY
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:20 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmQ-0001GI-HM
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:15 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so112131715e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805752; x=1780410552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DuX344y2MohXdo2KnmkVfn2tDoDJCPtlSarvv0O7760=;
 b=C66QYmzzZgY9dWMIS/Uc1GiUT/QEIE9vmVGeCgzqMwpVIxvt6sO4OeHsCEBhr6XEck
 Ex5gEwLuDsgdOeMRSBLbmAR7DqFiFzXSfKKWyhosJepBVZ3ZcJgQw44Rge1zxd+6DCDH
 vWFpavszTS0GzyzKk3pOuC0v8fp+1yyv4RS2nB97KndgndB/sx3rvnPC0ZDrxlTXszaL
 YSbn28sfWcjquHMK3y5KBMt8n6jplUtivcWlbNenA1TykoFnfUOH2yfWsHklXfod0Fc8
 77Ls4xJ8UDDbPTvKUD3/Vc9yvQp3Hg3v245GqDJe10H84s8XpvgDayp/T1Dcy87U4DVj
 2KLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805752; x=1780410552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DuX344y2MohXdo2KnmkVfn2tDoDJCPtlSarvv0O7760=;
 b=N36T3FmHr4EleKrwlXn7CCBoq+SSEfF+sWI/wToAtToFkUo/AYVqLK3/KSC+UCnmeM
 1qT3sojOA7fOqgM4UYMqx2MZZ+N8kNxl4EH64mqIF+U2+ho3Yue4eJU/7/XPXgfmakto
 k0sieLOSqeSGZR8IheBpMvx/WmDIRJLCwhpsGlssXxdRrRHrCcXh3wNBWNp7/9zMKbq7
 THVLk/ykxtAwhIOu3flk9ACN+lpEViOTRSM0WZiCptgy8drDbPnj62PdeCY6K5PhtJ0v
 By/DclNwCBqXbmp8E0gOtRWGlTUc7lStl7DUAjTy4Q4v8uPdwYIKFAXMl/UpYnO2RWzK
 9Gxg==
X-Gm-Message-State: AOJu0Yx4jntwV7plvRYreN3o324cLuEOFg8UEBqm9HJewx/RzSpWREDX
 Qu7iI8Lt3WwjRLvc+bxX+O7icWM5XcU1C2+2VkUN7dQvg03EjDPuetoVfi/35wLGXnVwvFA7LO1
 ZCUJ3
X-Gm-Gg: Acq92OFSDki5bQ0gNo2mzHaJZILGy8PbxxFk3KUVbok12n3GUyJMb0QNKaknlfBxSoO
 HSH7LdPLK7iWrfZyxmeFru32OYPrx1TLBs4YhvxM2jSkccqLUh51/d2wquYsfJXtz1VUg+54npb
 D+fyN6wB1jf1YHbTwOSnWS1AlefaVcueGHjpCB6ec97jcPrfUjn18We+SxbwNRoqlCHK9p/CDnX
 wp1gem8z1SHFzqfGzxrw1CKAGqlNU5/zJo7jdMDB2h38AxVwsbm9r1+mz+o4R4NhQGU32seFVWw
 9sa+vQTau5GWZlfmtFITDRqlqjSmeqov8ppDga+U2UWlFEMhb/90ydLBcgfD765ylySxJMFhKl8
 /bWQmQdztLOe2axCy4vHLSJ/Hyn1Wvaeo4b6GbP2022Rj09AO/ArGrK1CuTkOzJNwbBjYOQfd3N
 21beOdPqFDlju8brbiUWEXhv3h6HacJkc1KS9W2dDjPxF/wdJXoksMB3EK97WUfWBdrCbF8VCpC
 HMymKMZa4bNGBUoN1aVRKFfc6G9XL1o3KUjJc2JUg==
X-Received: by 2002:a05:600c:83c6:b0:490:5872:e641 with SMTP id
 5b1f17b1804b1-4905872e758mr219348975e9.18.1779805752406; 
 Tue, 26 May 2026 07:29:12 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/54] target/arm/ptw: Flip sense of pmsav8_mpu_lookup return
 value
Date: Tue, 26 May 2026 15:28:17 +0100
Message-ID: <20260526142850.2326589-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260515142541.571911-9-peter.maydell@linaro.org
---
 target/arm/ptw.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 91aacfb814..ca4b638c43 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2844,6 +2844,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
      * If the region hit doesn't cover the entire TARGET_PAGE the address
      * is within, then we set the result page_size to 1 to force the
      * memory system to use a subpage.
+     * Return true on success, false on fault.
      */
     ARMCPU *cpu = env_archcpu(env);
     bool is_user = regime_is_user(mmu_idx);
@@ -2944,7 +2945,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
                 if (arm_feature(env, ARM_FEATURE_M)) {
                     fi->level = 1;
                 }
-                return true;
+                return false;
             }
 
             matchregion = n;
@@ -2958,7 +2959,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
         } else {
             fi->type = ARMFault_Permission;
         }
-        return true;
+        return false;
     }
 
     if (matchregion == -1) {
@@ -3020,7 +3021,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
     if (arm_feature(env, ARM_FEATURE_M)) {
         fi->level = 1;
     }
-    return (prot_check & ~result->f.prot) != 0;
+    return (prot_check & ~result->f.prot) == 0;
 }
 
 static bool v8m_is_sau_exempt(CPUARMState *env,
@@ -3222,7 +3223,7 @@ static bool get_phys_addr_pmsav8(CPUARMState *env,
         }
     }
 
-    ret = !pmsav8_mpu_lookup(env, address, access_type, ptw->in_prot_check,
+    ret = pmsav8_mpu_lookup(env, address, access_type, ptw->in_prot_check,
                             mmu_idx, secure, result, fi, NULL);
     /*
      * For two-stage PMSA translations, s2prot holds the stage 2
-- 
2.43.0


