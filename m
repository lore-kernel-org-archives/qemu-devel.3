Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D422C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHJ-0002MC-4z; Fri, 26 Jan 2024 09:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHG-0002Jd-V9
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:54 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHE-0007wX-Aa
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:54 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-337cf4eabc9so530805f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279631; x=1706884431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=REDIbkefaHLl5VHtlOjlhfc4RzzdVkDK80vRRwWKuZc=;
 b=IfNhhx5q8HfdM8X7V5D1BVrn5s4fHkr9+i9Q2XPZdBNq7IZIq2FAcywdQ5cJvKsy/q
 pxJsrFPGBMvuItpbSJkU+Bo8d8HKbxxwEZJoD5W1FiBS82qFxgGUcaT+LC8iwMH1R2tO
 ubr4zaSyLTl3dLwuzQpmARf97s5+Lrp0Jh2uRrhtk1bDJm0QJYp0LkV0ogvIR7zRSp/j
 PBnsO6XfYAx8iYWtkmIsbJOxItvZ2kOzieCPSm4vBFy0z/HlXvxRa5ZDN92L5VBOfJe6
 kAu1O9fNSt6U35JDmkC6j9S6U7okmOeFPJeZUf9IM5wYaoXK117lBi8jUw40lYTVnbdu
 dH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279631; x=1706884431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=REDIbkefaHLl5VHtlOjlhfc4RzzdVkDK80vRRwWKuZc=;
 b=ioWmd7g9KC903VjVxL3mEo6QK18hQQ77XKKlQSF82F99SCihMfRd6XlTo9ZHd75nkW
 Mx3V1rS+RkntUQJqfG6om3nykaFp527nvGlVjDlNbuXxfrxGYdKHhs+OErXMRRykuZxp
 BVvhVQN+L65wlY0wYKKTP4RL5eh6hH0W+Z1M+EzfadopP1qig9437NekJuSw2/MaykdX
 GYtCXI6fKWFeC1IEB4mK3g46DWzU+oaz78zMiRvE1cJ7wZ/r1DvIbCzhrB/KenMST7iq
 STr1t0cz5456jJl2wWmIi2Y6+GFe7lY2w60Qpa9pbT5lzBe/6p82NymqgUQEC6UZGyye
 UG2g==
X-Gm-Message-State: AOJu0YyxGUaLuTpeiZfhWAPhqYeEVZYzFNKuEU5en3de5gX/zsoWi1Za
 zgA5D8h+vxy9Im0IgRGe+U0V4eZrPEe6GarpSSPHNOZy3tNqB4M0rpCg1XgAFwuFq2HrNb+g/Qu
 s
X-Google-Smtp-Source: AGHT+IEvOQJ/vsG+Xzc79qS1kUH+Htbk/BG6NHSjSTEIr9T+0yCJnlJvTaif+wGC/2vziqW8FicwUA==
X-Received: by 2002:adf:ee46:0:b0:336:68dd:c7e2 with SMTP id
 w6-20020adfee46000000b0033668ddc7e2mr992707wro.27.1706279631022; 
 Fri, 26 Jan 2024 06:33:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/36] target/arm: Declare ARM_CPU_TYPE_NAME/SUFFIX in
 'cpu-qom.h'
Date: Fri, 26 Jan 2024 14:33:25 +0000
Message-Id: <20240126143341.2101237-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Missed in commit 2d56be5a29 ("target: Declare
FOO_CPU_TYPE_NAME/SUFFIX in 'cpu-qom.h'"). See
it for more details.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240118200643.29037-12-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-qom.h | 3 +++
 target/arm/cpu.h     | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index 02b914c8767..f795994135f 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -33,4 +33,7 @@ typedef struct AArch64CPUClass AArch64CPUClass;
 DECLARE_CLASS_CHECKERS(AArch64CPUClass, AARCH64_CPU,
                        TYPE_AARCH64_CPU)
 
+#define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
+#define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
+
 #endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cecac4c0a12..41659d0ef15 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2837,8 +2837,6 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
 #define ARM_CPUID_TI915T      0x54029152
 #define ARM_CPUID_TI925T      0x54029252
 
-#define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
-#define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
 #define CPU_RESOLVING_TYPE TYPE_ARM_CPU
 
 #define TYPE_ARM_HOST_CPU "host-" TYPE_ARM_CPU
-- 
2.34.1


