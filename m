Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D5BCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cpt-0006e2-9p; Fri, 10 Oct 2025 09:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cpn-0006TP-FL
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:01 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cp6-0003wU-0A
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:57 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b85so2230327f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101573; x=1760706373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yZ1ukoZcfL91EUHEhf8u5pzbtt8p50/QdMP7WRR0CUU=;
 b=OUA1YT8vsLANCCzAam8tYqhWT1Pbr+pEO23wBnUOly4qyClwPbvikkUN2Dnt8ijEIN
 p6dgzLGyci+MHmRX7Pq8e/q0DYzpSwJdCrCHk1th6S5dSVuDfisqdbzEMX7zgSMOZzkl
 hwe8dLl+qd1rE9soa29uF0oGYrz7nxK5gbDrDJcvYh5s49jaFfPFjtNl1D9M7O6WvtHg
 k0VdwLwYt39u63s71AJJq4YQTsHlapXYquf3/PzBDTNjhOo6dM4m8YEEMM490lVMQ7kf
 XZOqjSi0DJoIkY/fjLGa9395gd8vW0Aipep0Ie7NJ2RI148dzFzJp/x/J/HHBZ1rRVPJ
 6pDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101573; x=1760706373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yZ1ukoZcfL91EUHEhf8u5pzbtt8p50/QdMP7WRR0CUU=;
 b=VyYe7cyOZy/8NcKd0s3m0NsrrIv5gKxjS4Rx5+RIaQoMAg3O+hJEwvNKIwHmjtiIfB
 z2kkD3/ypBCAGHB9rTsKGHZKBhRJUtt1Djba9oMGG3epB+A2FFwMI7Qlus7ouozEqcAS
 6oB1E7Kv8p/953qrkNr8D9voxUWkAHY3x/Bw8xkI73q4sTBKPjFPf7mq/lqScl9KXwfA
 Nod0n2H+EUaHoVQQk+LC6dSMWGZxmBwuDsQCK1v0BHKz22cl3LqoKRbAIykZXt5Qmmb+
 ELKv4hOr2Y0T8zmEW9aPPEvPc3/WlIkD39x/P6jJhqQv/PvS794XnhoZgNds6Zw6xJKk
 wISw==
X-Gm-Message-State: AOJu0YwgCfdp8OxW7A0wfHHQnV5/qbF51wrwKAC9f8TFkrJ8DfPwiv9M
 /QDH6A95+wqcKti1JLPI22feHlU7WG1zqBEFoLnUtrZXa8qwEEkuoOFumKkyKEyZ4y8hRzvEaCZ
 Rfpc8
X-Gm-Gg: ASbGncsn9+Vti9nSPUWdpbMWgUzecaPRObAbRrsTHjq2jK1Mr82nT4c7KrcW7Jd3Ggm
 LMBiEvINumJr9t5l7MtTPwGyDMe3lr4tCtQA+H8efrbwzP3wxJ8wsAxw5cc/Q+FBDt/I057hD9j
 9tFvHih5rT4DK5XuXCil9QLjrV5Wbcxbd50+oX95PoMVNRGeW1SnhW8uHqYb5iUTDFUzdMhceSL
 dEM9pGzHfhQliWG60osDuqVsmPFz/ZdJe4r6nZXEI/hUoA6ySORSppJvC/O3oG6oUXITUYJaMe/
 2kZH+I2lQh6BVUwyhA/Gf78symMUjqPX1zDPTX4gAwIXI5kV129ap3/AYVcRF0n+3YCdcMQ/nDg
 MGWt/0ArZcOKc594MENcvU8N7wrgyY2WZwBHp9nIoM8EYCBOWFuY=
X-Google-Smtp-Source: AGHT+IHoZrz83o8mfyTN5B06D66bCAdQ1tFBlHaaieXALH+CcS05s7cmY0tWDbc/s8baKmTLmtclQQ==
X-Received: by 2002:a05:6000:400f:b0:425:74bb:7c4d with SMTP id
 ffacd0b85a97d-4266e8e68a5mr8048050f8f.61.1760101572853; 
 Fri, 10 Oct 2025 06:06:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/76] target/arm: Add arm_hcr_el2_nvx_eff
Date: Fri, 10 Oct 2025 14:04:49 +0100
Message-ID: <20251010130527.3921602-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Implement the pseudocode function EffectiveHCR_EL2_NVx.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251008215613.300150-39-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    |  1 +
 target/arm/helper.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b8abfd82762..54f3d7b1cca 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2235,6 +2235,7 @@ static inline bool arm_is_el2_enabled(CPUARMState *env)
  */
 uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, ARMSecuritySpace space);
 uint64_t arm_hcr_el2_eff(CPUARMState *env);
+uint64_t arm_hcr_el2_nvx_eff(CPUARMState *env);
 uint64_t arm_hcrx_el2_eff(CPUARMState *env);
 
 /*
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8e342b08118..e397fe75bd1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3904,6 +3904,16 @@ uint64_t arm_hcr_el2_eff(CPUARMState *env)
     return arm_hcr_el2_eff_secstate(env, arm_security_space_below_el3(env));
 }
 
+uint64_t arm_hcr_el2_nvx_eff(CPUARMState *env)
+{
+    uint64_t hcr = arm_hcr_el2_eff(env);
+
+    if (!(hcr & HCR_NV)) {
+        return 0; /* CONSTRAINED UNPREDICTABLE wrt NV1 */
+    }
+    return hcr & (HCR_NV2 | HCR_NV1 | HCR_NV);
+}
+
 /*
  * Corresponds to ARM pseudocode function ELIsInHost().
  */
-- 
2.43.0


