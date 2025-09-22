Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E33CA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lfg-0004Y9-CQ; Mon, 22 Sep 2025 14:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfC-0003Z2-QU
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:53:29 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lf5-0004wK-K2
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:53:26 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b4ee87cc81eso4591888a12.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567194; x=1759171994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c8wyuys4m1d8GhLqeKYb3zwEPLO/sLqR4mHAelbDpjY=;
 b=GRO4EMf2KFL/IY1EpbX25Eopao1U+R5cPMtyu9VaGDxxM79ZS1YsT3ty9JETv7IDvU
 C/4wQb/ecuSaKLgo/0Mlp0Iu+bOZ5HUAsvLLUw9UfAAeUKF5ywY3yFBf1dcYiUztAe4c
 RZmluZRqoSFT8vyR0Ob0ISqAdtsauqfyG0FWNBRAMa37CRGQUbK4VEhsJVWMB+sTT1Oi
 AQP9eGj9zLXxNZ5kevZKsEjZyWEj5QpMt7e681itR1b0Zsh1/DGEgS66BDykOWuEzjKG
 M3bSgiFSAloEzs0NHu5fFi7iZ77+616aVFcVjOBJkKF78zAgu1WR+jrxe/tcpQCZsPTE
 dmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567194; x=1759171994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c8wyuys4m1d8GhLqeKYb3zwEPLO/sLqR4mHAelbDpjY=;
 b=DFULTRMVinu6xVZbH/umWVjOLXEkiZqm9DhUyS1M0t9JCynshhW0KwFwbGQ7Y5jXAK
 Gga7zJbXwykaLAaZvYdG7PM/+o0fDyRgMVCDzjoJdSvKQmKbuy32h14NrebKRZSU/Hio
 zwyl09bpRvJZjGeDbPLX8VwNCJjqf/bRh3XgdRh1P4q7ZQyH+K6KnaBORcFlZnsTZmmm
 qVQ0noptOEoheiALBGl0OOh7DcNvwc9TtAg5JVTfYbThGASzXsDWhUKbwMk+XkhVSUJl
 pkcuUFnnnXARSC/j5RHmL2tXVi4CXYzx7HgTkhSHvxab6krdOFgE20B0plmOk6nWvcB7
 +o/w==
X-Gm-Message-State: AOJu0Yzf//DpfvGSuiklLBXewQWkNinxT46URdeh+xLdzviFEJCoWKCY
 MphEBAwToH72oEGBp2YwuN99hudRar299XZFeSrhHtjL5Ws5VLK1reoUklo04aaTxH9IR3AK6Ef
 npkrL
X-Gm-Gg: ASbGncsfeDR+IAf8WETQ+IBbPGuJGsqvUKgEXHYF6aACxqNUWgMCfGe+tjhkZV191Vd
 oqI7JZRip1PQi1CCEyQQcSiQq7QCZDUJ1lukMyZNBaVtN3/TJLlcqdEi3uV/TOKyoNtHgOv1Tdf
 X+J0as2FseguuhzAMqGpjg+Sbys/ynb2whYlJ6+H0OxrUvxAEEJ1L5fIiIqCzk96WaEFfkegxlI
 sYUQhoRqmA6W2Zc6dVvjxZH4CvKxE4yglnp6Nq0RmdLNCuCl0GCFiRa+Bt+IgapLHoonmnrvAxQ
 zE5Hfv3TPZMs1RJQtMtcibxdakwa59+pax4Zqe8uCl2pW/6ybM3Oot4OFOk6L4X41eBj1dAIlZe
 E3Htlb1dBgRmDw7vS8peilfJkvyp5
X-Google-Smtp-Source: AGHT+IG5dEyukZKTtzWMUKbT+WNVl/fuUbv7f6jTIQPKZqdUH78QggLxTRJxyyqzFsbg93OGaGDOPw==
X-Received: by 2002:a17:902:eccf:b0:269:8404:9a6b with SMTP id
 d9443c01a7336-269ba563609mr208360705ad.57.1758567194008; 
 Mon, 22 Sep 2025 11:53:14 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 41/76] target/arm: Add arm_hcr_el2_nvx_eff
Date: Mon, 22 Sep 2025 11:48:49 -0700
Message-ID: <20250922184924.2754205-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Implement the pseudocode function EffectiveHCR_EL2_NVx.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |  1 +
 target/arm/helper.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c79393d9c2..b36436ee2b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2639,6 +2639,7 @@ static inline bool arm_is_el2_enabled(CPUARMState *env)
  */
 uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, ARMSecuritySpace space);
 uint64_t arm_hcr_el2_eff(CPUARMState *env);
+uint64_t arm_hcr_el2_nvx_eff(CPUARMState *env);
 uint64_t arm_hcrx_el2_eff(CPUARMState *env);
 
 /*
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 37cfd2064c..e3ea5254c5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3899,6 +3899,16 @@ uint64_t arm_hcr_el2_eff(CPUARMState *env)
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


