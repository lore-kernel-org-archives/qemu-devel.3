Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653ACCD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsma-0000IK-0f; Tue, 26 May 2026 10:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmN-0008Ku-JD
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:12 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmL-0001Eo-0U
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:11 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-45d96d21e82so5806316f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805746; x=1780410546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tmBFhr5bZEi658a1Neb6LtFORntlytJah0gE3InO5v8=;
 b=Rk6CTtc8t+s8+IKKwTM8/kBXMUaTFe81omyluKq/+PMYP9Yab4oEp6hKy8V84wd57s
 LdVvQsyBJY/neb5VMfA5yHshP8O/feYcN30/HsjPbBTt819ZCoNds5h13yJ5iTbK7kNJ
 yBpOToGQkqNmkA6gViwrdNZcoJjO790Z220CVJ/gNt52z2NgEYeMu0oE1Oy85A5jDAKP
 2ozv2EjsKYSvZTqqbM6FPwlYtq8tm7BNEgUwum7B18iOIH8NLA5UCiei4YXfhK7mH7ef
 YHvSUj24Iq++IKZYteFVR1LfssFdSzfAKYIv+Y3+X6+0U3eD9wRTP8I6o4j4wz2oTDo5
 OIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805746; x=1780410546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tmBFhr5bZEi658a1Neb6LtFORntlytJah0gE3InO5v8=;
 b=cGDQgO6hpoGvHY6Ww55GYIV63CRQpQAzrMQTno/mZ1xNsINiCI/dCqDhHlRTYMa/KY
 73KH+ltjkZO6nZyYNVDKX6i497FK/l2e9mxvN3GAvfgPN00ayWIcAPt275zOYfyeiapq
 yar7Q0Z4zpoxd6h39LoTaN+sp4vcqOkTvASU3uZmd815qSWLYt8niNcKKslk/nZh3r2B
 KTTh855LH745+xyVwleOx3ClqoNaKzmJFDF2NWXr4IlYwuTUFGw6Apg6m5UuXLio6wIO
 xYouUkGw0exCoEhSozwZVXQPZtzyC0/1qbBatXy30g/FnHOApYfpdAn74TlmFlgCMCZD
 bcSQ==
X-Gm-Message-State: AOJu0YzYuRsA4OPNX3SyGikfHt5kxVFkP9VEh9W1mFpHhBmBDYUqukYL
 CsAIHQeAkmE+da5EGPdxTC7Cekxdbr0Ej9wI/ychRLKmnTN8llXUuA1QDtsLHQQeS+N1538G6fi
 0Yx+e
X-Gm-Gg: Acq92OFvYp47L103vE0tKfLRb0cnLJkPpHZzqXpL2F0TvbE4WzldoriVy8lC488Dvxp
 GIvzpFOeIRi1yC32adsE0z35/bjgYbxecuYm+64KtdoLJD8AuPAVuQd2Eyeya7OeUKdtBUmbVNa
 xHAc6VBp6Xf8f54zSldki3MK7p/FOE/yjerMHH7AYE5mLZJyMBkKPjtM5w7Ab8GMwnT/JA4HCTU
 9cHRni8Z9Dv8Hds7o/JZTNXFQJce2LI0sXP6YSxACsgp6rEBtjTPMI54YyBzZAtlUG3bxdl5JSm
 kbw+npFeEZfoDEmirYM1CRVVUGF2ynNgactY4ApMS0XczHzUNTsQUkJW2aHcXBG2YgcfDQ4VX5+
 ZrI3j07f3QIeU47it6+r9YeIt4WvPPWOmCilIm/QYuM7HjarVooHfMc0Sk8OrTev2UegH9aFzga
 Umv/pFoOQ7mR6DBaxv537d6PfifcgBkJNH0lOY61lGaw6JW0MoijeXV7504PWvXf1pWk5ziX1hp
 5T69yuXDf1vLuxE9jOwQvaNCr6PyEM=
X-Received: by 2002:a05:6000:2007:b0:44a:247e:67b4 with SMTP id
 ffacd0b85a97d-45eb3689031mr31516432f8f.18.1779805746477; 
 Tue, 26 May 2026 07:29:06 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/54] target/arm/ptw: Flip sense of get_phys_addr_lpae return
 value
Date: Tue, 26 May 2026 15:28:11 +0100
Message-ID: <20260526142850.2326589-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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
Message-id: 20260515142541.571911-3-peter.maydell@linaro.org
---
 target/arm/ptw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 9565a7d446..504ecb622a 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1842,7 +1842,7 @@ static bool lpae_block_desc_valid(ARMCPU *cpu, bool ds,
 /**
  * get_phys_addr_lpae: perform one stage of page table walk, LPAE format
  *
- * Returns false if the translation was successful. Otherwise, phys_ptr,
+ * Returns true if the translation was successful. Otherwise, phys_ptr,
  * attrs, prot and page_size may not be filled in, and the populated fsr
  * value provides information on why the translation aborted, in the format
  * of a long-format DFSR/IFSR fault register, with the following caveat:
@@ -2432,7 +2432,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
 
     result->f.phys_addr = descaddr;
     result->f.lg_page_size = ctz64(page_size);
-    return false;
+    return true;
 
  do_translation_fault:
     fi->type = ARMFault_Translation;
@@ -2445,7 +2445,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         fi->stage2 = regime_is_stage2(mmu_idx);
     }
     fi->s1ns = fault_s1ns(ptw->cur_space, mmu_idx);
-    return true;
+    return false;
 }
 
 static bool get_phys_addr_pmsav5(CPUARMState *env,
@@ -3787,7 +3787,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
     }
 
     if (regime_using_lpae_format(env, mmu_idx)) {
-        return get_phys_addr_lpae(env, ptw, address, access_type,
+        return !get_phys_addr_lpae(env, ptw, address, access_type,
                                   memop, result, fi);
     } else if (arm_feature(env, ARM_FEATURE_V7) ||
                regime_sctlr(env, mmu_idx) & SCTLR_XP) {
-- 
2.43.0


