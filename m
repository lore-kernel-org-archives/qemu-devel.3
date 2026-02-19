Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EDAE9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1MY-00079F-Kv; Thu, 19 Feb 2026 05:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MM-00073t-Ou
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:16 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MI-00061b-7c
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:12 -0500
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-435f177a8f7so743924f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497248; x=1772102048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fZqFlJE71QpBgupRkc1HcKWWAy8MPJgu6Npsxt6eiZI=;
 b=x5SAUUMPJg6mJ5TRk/JQAU44OVb8jiEXBw3DToxJ1dKWdUyInQr1cir7JOtiYnWok/
 ONRXhZvNN6vvalLuwVefqQ0KNjxW3yph2vM9HWAX5DA8gxsRyA+1nbDle4EXPEwoa0aG
 QnkObcoJ1nMTa+BVhxZ6RQ1xdgfJWgo1TA4E+jkjhzIyyPfdMcard3NHVuCmSmA/n5bP
 afv3gOzIsdx1i0myVyxKc6EVwZyZ4yGiR65+nhRmOuIAteBl969QAjBjQcVUZ9YSyY96
 O0nYtvPj9m4hxw8XL69B0x2F8c0xcgQwsqSmQpiZYq6U0VPgXV9EVccLNrmrBK7qaVKm
 GT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497248; x=1772102048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fZqFlJE71QpBgupRkc1HcKWWAy8MPJgu6Npsxt6eiZI=;
 b=IAz+3P3gexV2Mj356sk8X8ngTOF4GIKlw+HBdHCTIRaImDXKzC3XuzJhp+kE2sNikD
 +uWA8Hh906OO6hs/vmdEnunrys9bwzYCD4JQL5UgtKfPINvkp9QQzMRLliIsIsJbddUL
 zHsXpb0jkg757kQHmWbhX3ZMtSGOqxQOTrhPTmjTBkvoC5sCeqYfuolYCbGJsI0yMgoV
 QKI4JMSzoJ1RFuTsCdIlSgCX0rOBj0TsY9Yr/Xx/4IlNVqa3lmthaK5Xc5rWl7E3Jxul
 dNCnkvOTzFR3I83Bmf0HyIejkV2cR+wYUVIPRhiYSU0Xn3xfnv2goWjYc4bZ3iGQTv3Q
 rS3Q==
X-Gm-Message-State: AOJu0YzCef4BT+qBFWkI6IGSJPGepBO4UTQujTajLxXDAt3vbLgflX48
 vlCAA8YEH0/IRkYU9FW/XG/wlKI3889xfmnsztx5oO2F+5jRXvnpcfXtKTRbfqBQtMXOa8F5djK
 xA5QINNU=
X-Gm-Gg: AZuq6aLbbej9i/5tyWcm23v9PMtbCY6Xtus6DQuo1Wps0Hl523tv+kRcqheW2Q5PrY5
 +NFisLR+OWoKg0q4KdiwI4dVldKn8KYYlM/8m1zdba1YjDnfSBkpgm27ufqiwdkqKssG2S7WfZR
 0hSrWMRHGQ8oiBUDz/hB/tZP/Du6hJJJ48jLZg5Ny9SBSU+Ic06Liww//1f4J9pxL2+JpAhEMCI
 e6IOaoSkAKl4s8z4DbGjRb1P1rM3laE8ZzU4UYf2ZDUAB96i3C5qOlU+RuckSKXbSJIMwLwTctO
 OJeAGw6ZeuS3YnfVZd7dPwfctZEdQzxOkeBdRfhEB6S2cizTi8Ggk0TAyWv7ItDu2vmNJiSWN6B
 It/wPr4QXyOvoGqgxH8tbwtwkC8bGmvywvTNX3GYiJqsPjSYWxRoSWI5adLm1G8UdK0n3Xn1wAT
 7GaPbBC7frn+EXZXR0kZj9swVUJZp/3X5NM+3wK2CWmWVL1s4KWMfroE9VRpYU6xn0izg1hyEWH
 x+2jdSFq/vK+H+erbNGtQ4s/6a0784=
X-Received: by 2002:a05:600c:83c6:b0:477:639d:bca2 with SMTP id
 5b1f17b1804b1-48379b93357mr253017505e9.4.1771497248090; 
 Thu, 19 Feb 2026 02:34:08 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/32] target/arm: Account for SME in aarch64_sve_narrow_vq()
 assertion
Date: Thu, 19 Feb 2026 10:33:34 +0000
Message-ID: <20260219103405.3793357-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_PH_BODY_ACCOUNTS_POST=1.995 autolearn=no autolearn_force=no
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

In aarch64_sve_narrow_vq() we assert that the new VQ is within
the maximum supported range for the CPU. We forgot to update
this to account for SME, which might have a different maximum.

Update the assert to permit any VQ which is valid for either
SVE or SME.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260202133353.2231685-2-peter.maydell@linaro.org
---
 target/arm/helper.c    | 2 +-
 target/arm/internals.h | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8c5769477c..373f0ebcb3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10088,7 +10088,7 @@ void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq)
     uint64_t pmask;
 
     assert(vq >= 1 && vq <= ARM_MAX_VQ);
-    assert(vq <= env_archcpu(env)->sve_max_vq);
+    assert(vq <= arm_max_vq(env_archcpu(env)));
 
     /* Zap the high bits of the zregs.  */
     for (i = 0; i < 32; i++) {
diff --git a/target/arm/internals.h b/target/arm/internals.h
index f7b641342a..8ec2750847 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1808,6 +1808,15 @@ static inline uint64_t arm_mdcr_el2_eff(CPUARMState *env)
     ((1 << (1 - 1)) | (1 << (2 - 1)) |                  \
      (1 << (4 - 1)) | (1 << (8 - 1)) | (1 << (16 - 1)))
 
+/*
+ * Return the maximum SVE/SME VQ for this CPU. This defines
+ * the maximum possible size of the Zn vector registers.
+ */
+static inline int arm_max_vq(ARMCPU *cpu)
+{
+    return MAX(cpu->sve_max_vq, cpu->sme_max_vq);
+}
+
 /*
  * Return true if it is possible to take a fine-grained-trap to EL2.
  */
-- 
2.43.0


