Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD82CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtUi-0006R4-2o; Fri, 15 May 2026 10:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtUD-0005qw-P3
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:25:57 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtU9-0000xh-8o
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:25:55 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-44e1860558fso5989662f8f.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778855151; x=1779459951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dG4YbbQLzdn6s6+yCfVqlzQwYjjvxFEtdufrlxMzgL4=;
 b=Uw9g5njR/dDRRoyiPO0XdzmZa+lG1znEV6c8pA/tAgkOTb4j0W827XR92BD3hfZtiN
 o1/V7RME3zjLTyk630/S7agOfVbO2u+T5YIC6cY+blrziTMhEYMK8kHXr8tbiaydCzrK
 BEifc4zXV4d+YyXGgWitkvXuTFXbLGPoczVm/IxEZ6tngbj7lxi2lFSUEpTI4ouh/Jx9
 8HXZ7llnbQZHKzq/Shm73auzJmt/oElrYq2zYnmy0vDwW2hsxpT921Wv7dZmmypy4VQ5
 8BdNijsB12D2kT92D9B9NDpV0SemeOnde/jEqWruwR7+PkDXBPTQwltBn74HbOghzzrr
 5qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855151; x=1779459951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dG4YbbQLzdn6s6+yCfVqlzQwYjjvxFEtdufrlxMzgL4=;
 b=UeD/qgOQeauwKYSc8JpI73dz2ABhc1peEG6iHU+guV1Ct9R08bEqCZCwq4s+kwM11d
 kkd40ooVPWGUSzoHq15pN24wR3H8KKLtUHDYPfSvxpfjvavoQkNpqTnJOzxWfSTHzRk9
 QnJEUrUSdg0BZtnHdptqUIHh1TDk18xew4wZ6RNTYT4W8MLB3VgDXwNtBpvhE+Eo1sHG
 XO7CeTiwRX5SxEqhbjkfO4w9MPZl+qELeSo5usq0byXnZdmCIp0n3sfBg+MjgttoQxZI
 Q4Zz7iqrVMjP9eAKKaVpu7PzWTrvmatzs9dlyzbP6sRcA4OQ1gymNKeMVip266KTmdRb
 wdmg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/s8EBuzPqCj4gu2offFEjXOXh7+4pglStZgW7lokMj+cIxWTwxUjnHFhyUoWxFEZisTpR9ZW0VSXrk@nongnu.org
X-Gm-Message-State: AOJu0YwRBnF2nLEXvjiRVVVRHT82o8QHZQ0ZmeMy9CTHxvFJlrN0m2MX
 PET9DwXC8nxte6oDtIc3frRvypMgFb0L8tmRf9wWn28DbnfrJ8ICXrqiRvn7mmUrS6s=
X-Gm-Gg: Acq92OFdvI1d2o1+NiVELNiVLSO93lAwZqAKNHTa+yt3wP2iuQfXG1WCpbcwY4O1PtO
 OiYeLTjxUw7Gaw1ZbCV6qi36yYF0KERgA7NvTL+7UWScRATEt6D6DwExXpRqcUmrGk2CpoJ1qRw
 ZmiBb7PcSTyizi10DS6P5tbgHi0EIk+uygtvvB0QfI1F2UkrAWitUmZmeEHXo4s7DTbREf7zbt3
 qrQZRkTuj7LNCjmkJFB/EynLwzEYkolMUEBfrJ4+zQgSalZKy9FijKlLAB/ai3XaoqCupbNT0h3
 U0KGIwd+IJLyEFMxb4qjgIwjDjToxnQNGX3Q8JI/hH6z88clTTu1GohKX4jcSBZ0YUkXIprREsO
 m0U1geWET2+7Han8F3I/L4c9/wDkSbcMiC8Qk1G+aeQXNbGYjftWtOM8XNezl+KqFbMFb6djCtg
 gK8tpASM37/y7Ah/p+1zSh3uegRw+2z2pcOEHp3p50OhYKV+4EKngY0Nblgw1CFzAHQML5O/uq+
 opYpXUPa2EPLPX53nzaCmND7O9mx9w=
X-Received: by 2002:a05:6000:1ace:b0:43d:775b:c9bd with SMTP id
 ffacd0b85a97d-45e5c58906amr5815222f8f.10.1778855151388; 
 Fri, 15 May 2026 07:25:51 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a666fsm13560603f8f.36.2026.05.15.07.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 07:25:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 08/14] target/arm/ptw: Flip sense of pmsav8_mpu_lookup
 return value
Date: Fri, 15 May 2026 15:25:35 +0100
Message-ID: <20260515142541.571911-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515142541.571911-1-peter.maydell@linaro.org>
References: <20260515142541.571911-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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
---
 target/arm/ptw.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 9e5a7e77c0..c89cccd431 100644
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


