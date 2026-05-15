Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19C1CD4F48
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtUL-0005xL-Og; Fri, 15 May 2026 10:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtU7-0005iK-7W
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:25:53 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtU4-0000uk-IS
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:25:50 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so5830410f8f.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778855146; x=1779459946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NIviysq2AqiFz9fV8rr10jJmjEvBfhW9uzxUqRTLkmo=;
 b=Zk1XrYKJ1IJnPsMwjhmk37DRz5hPFO2ybd+J43Gb0ZwwefXnQQHnFcQB1m03f5p7Xp
 MLoKu/riYFpVKqCKwlRztMMeobXo63vdu1ukWwL1CgYHLKzg1kWEf7l0PFHDUc7DdYjP
 b6zEIN3pAVsmOoBFxnJpuvvcWxAwEiuzUKW/nm49jgunLzVXSY3tGH5EUh0MyWkEt/ro
 uA0mtfOXllV8yc37AcDAvVM9E2mjjS341TMh8DOVLk9rpEwJ3Xx8S6LR1J9AOZ2kJu28
 8iBrcF7xVqc4eiAWNagXcRwCoGaHHbushLIpbd82u93Y3qJmD6B1CYcy27c3kT9quIfh
 /LtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855146; x=1779459946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NIviysq2AqiFz9fV8rr10jJmjEvBfhW9uzxUqRTLkmo=;
 b=py9Prv5wwTFn5RF+uSoCsQdfA3zhE2b/ZMOl4XE0VS58GTwVXc1DzqBjE4zwZSgYth
 CWCIxFCmofn4pGCUpk2A/FIvz0rO473+0j2wuNBvynB4bHoUjVRTywqxQ9r0RyBBpJvH
 pqu9GMhN2AJVCxuMfHbaLrrev1LRVZy8pAP/zzBhsXupSXb/k5fjae7ZB94Jg8er2eO+
 voFuIjmt3YdDD6Tc4Ms/xPpK+xSiqJvhmJeAtdwm94GCToO7l5e9sfm6M2BwXvVzWIED
 0rC4elf3MvMtjhmXJDWWUiTreerpnPhdWYa05PueTgoPHeJsxgnhMkbjO4NOP6OARKY0
 W62g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/kMzu8k/UW+utM40Q4k4+jJyWRSAOgp+D8UmtB7W8sHU6gHzS1KRFOYuKSc9iql7LIODvO/G4yt8Mk@nongnu.org
X-Gm-Message-State: AOJu0YxSsPBGbLqp6T8rAEBZhczpSZucNucyb+bWubQjtvtg8sAzt7ol
 +kavUk+59/RQv6m2fHsEELa0vpyc5wyu5sGjMJ9SsjN9Xu0UlUAoZ2Hy+2zP3qc/SM0=
X-Gm-Gg: Acq92OEbEmEApmWJGq0v3vQs1SxwRYsFrxvz8ZZC7mkfWPI5iTVE095zy+k0zMxaYh4
 e7Cb/0Hcf+pb5DCp4vV8J1Hcqn5nLOWhI0LVMvNImR9SM0wgzU8Rt6n0Nv0XLpdYuRAhkIZ7tID
 TmKB/T+vwzauTQ4pnbXMLXqeYxBxft1KpHVn0yJQtEvECi3oRkuzGOY2LwzOr35T0VQ6kJyxZ+f
 YSlnZMu1XtJMh05ggsUO31Ppv8OKSAMuUZ8qvzAv34qqm/C6Mia8HDyVyd3fSGaaODtJIeOclxe
 yszug541NHxEbdwGVmJM71sBSp3Zws6YsM29rvXUiybBDoypsY+SckZkOZHPr8SyRn6sHGYtwyk
 +wtRkIH2gcyULF6fAqP///Fk0W6jYGeWXI/F4cRh1h08YQp5/VEEmoS4zVRPHN0w71yDSWv3sR2
 d0WNVhoUuQTtoGFoKqqCJvFRs4U1vKe1lRTQLE/5Dmj8THsixHpO1cWSkMzyQ+hrK0KycTO4fHw
 SzA6uH/0Ss4e/VvEYD3IvAF/K+csssWVtSTGmfj+g==
X-Received: by 2002:a05:6000:26cf:b0:43d:7a97:78b5 with SMTP id
 ffacd0b85a97d-45e5c5ccbe0mr5803493f8f.33.1778855145871; 
 Fri, 15 May 2026 07:25:45 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a666fsm13560603f8f.36.2026.05.15.07.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 07:25:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 02/14] target/arm/ptw: Flip sense of get_phys_addr_lpae
 return value
Date: Fri, 15 May 2026 15:25:29 +0100
Message-ID: <20260515142541.571911-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515142541.571911-1-peter.maydell@linaro.org>
References: <20260515142541.571911-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 target/arm/ptw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 8a412f463a..93e77b3eb6 100644
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


