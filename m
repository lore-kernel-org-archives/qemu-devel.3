Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2E0C48295
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvax-0000Cb-63; Fri, 02 Feb 2024 10:36:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvav-0000Ba-Rn
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:45 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvau-0004S5-9F
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:45 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40e8fec0968so20018835e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888203; x=1707493003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XXyoo0uTxQx7WIeKUGD+qu1FchhSMRmgTj+B/msMnZw=;
 b=EmC/UTeMd9TjGy6IaNnt1SAJVwIgBxUoO+HXzXpbuuQN+uSIuQio2DKIECEJQvNGAe
 9i0dtuvUs2f6d2ilYN8mCkWarD0TtI+9+mytIS465LhkROdwWSSVyZPmUpQAzu0p4ZYK
 f+XiFQqJdTw7/qhKPgqd1jOKLQe4z70VAXwYq4D1hBuGWK9S5aGgBkKgMFUL3XJdHEuq
 mWeWnp7RSMcKE6knD9G6o4RyS0eT8u+8ZdLvVXx1KZwiCg1ld1krV+dVSx9uCMxY9BNr
 0kl8npRYeGw13eIS3llok32FLyr+jsXdWSrbRDpJfzFlMK2xHkfGY4rvk0YoMIolzC5s
 X05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888203; x=1707493003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XXyoo0uTxQx7WIeKUGD+qu1FchhSMRmgTj+B/msMnZw=;
 b=sT24o46trVSCtBM3vrjTVVpCtHlVI2fnedrFI7Ujo8JKz7bcEgkIHzR3qqfJDxpxkq
 u56bisYBr8fMdC6VRIbIA9RNUm7U25pu3hc7wNE14CT+bimI1/6H/2Z/CqmxhKu21Kzp
 MJfqImJ2rabGiIZ97W8Kvh3dU/cLsN/4hvFwTP3sAEXLOD4Tg/Zyipm5dKcpNmUxckwH
 1T+cBQvEoKzJOkRypQXAcoR4TkZuEvIyWcRwkeLcLQ1FW1Gm+6fd1u57qzhD8FiILN3Y
 2T3Ew7m8Fqgs1tYNEXCsOaabBvb7TpU41rbBVqmO4yZdJtsBVJp46B0YZN9JH3z/K4QS
 JoXg==
X-Gm-Message-State: AOJu0YxF4O/TBRkBFzZ513goU16vUTLhvToW6gfdmQDi6MMp27HuMffr
 L85finve5pDixJnoBm9zVCKgSLm+vl1i+kCjGdGvdkuF8bkYsyAt0mNoiFD3Ete8JJJZQqIDQ/5
 B
X-Google-Smtp-Source: AGHT+IGwMhcfy7lfme8yuzsYCldGdu6eGi4FEeZk9pd4ZTXJhxIA/5d8vUZEAeFx7jpiPOFewfkDww==
X-Received: by 2002:a05:600c:3b93:b0:40f:b64e:d28a with SMTP id
 n19-20020a05600c3b9300b0040fb64ed28amr6246744wms.10.1706888203082; 
 Fri, 02 Feb 2024 07:36:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/36] target/arm: Add ID_AA64ZFR0_EL1.B16B16 to the
 exposed-to-userspace set
Date: Fri,  2 Feb 2024 15:36:10 +0000
Message-Id: <20240202153637.3710444-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

In kernel commit 5d5b4e8c2d9ec ("arm64/sve: Report FEAT_SVE_B16B16 to
userspace") Linux added ID_AA64ZFR0_el1.B16B16 to the set of ID
register fields which it exposes to userspace.  Update our
exported_bits mask to include this.

(This doesn't yet change any behaviour for us, because we don't yet
have any CPUs that implement this feature, which is part of SVE2.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240125134304.1470404-1-peter.maydell@linaro.org
---
 target/arm/helper.c         | 1 +
 tests/tcg/aarch64/sysregs.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a0041aa0ec7..d51093a7c44 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8897,6 +8897,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
                                R_ID_AA64ZFR0_AES_MASK |
                                R_ID_AA64ZFR0_BITPERM_MASK |
                                R_ID_AA64ZFR0_BFLOAT16_MASK |
+                               R_ID_AA64ZFR0_B16B16_MASK |
                                R_ID_AA64ZFR0_SHA3_MASK |
                                R_ID_AA64ZFR0_SM4_MASK |
                                R_ID_AA64ZFR0_I8MM_MASK |
diff --git a/tests/tcg/aarch64/sysregs.c b/tests/tcg/aarch64/sysregs.c
index f7a055f1d5f..301e61d0dd4 100644
--- a/tests/tcg/aarch64/sysregs.c
+++ b/tests/tcg/aarch64/sysregs.c
@@ -137,7 +137,7 @@ int main(void)
     /* all hidden, DebugVer fixed to 0x6 (ARMv8 debug architecture) */
     get_cpu_reg_check_mask(id_aa64dfr0_el1,  _m(0000,0000,0000,0006));
     get_cpu_reg_check_zero(id_aa64dfr1_el1);
-    get_cpu_reg_check_mask(SYS_ID_AA64ZFR0_EL1,  _m(0ff0,ff0f,00ff,00ff));
+    get_cpu_reg_check_mask(SYS_ID_AA64ZFR0_EL1,  _m(0ff0,ff0f,0fff,00ff));
     get_cpu_reg_check_mask(SYS_ID_AA64SMFR0_EL1, _m(8ff1,fcff,0000,0000));
 
     get_cpu_reg_check_zero(id_aa64afr0_el1);
-- 
2.34.1


