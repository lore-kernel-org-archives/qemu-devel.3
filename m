Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD3ECA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNve-00062a-Hh; Sat, 30 Aug 2025 11:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELy-0005wA-Ak
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:22 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELu-00049D-KG
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:17 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b4c9a6d3fc7so1260198a12.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532533; x=1757137333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XuSNhIuWtZ+D9TGrKCnrrzHc63/oKkL0AUYE0riaIqA=;
 b=m3+dtxVgW/ToMz07vuHYSEMzc93x3gbYVQ6AORxMjNPErphGzfD4KQwIQ0kTrJj2KY
 FZ/ap1nytlII0Wd4I+gAFkL3FkG+h2o99BIUC5OL8QRYKrRlqXKbZ95MVfuzJvI8pBoV
 oUzDW7ppzp0dSu3uXP5vsMFtobtN0xXW+2Jo22KSNbBcpsoVGQhvR1rXZ+UDUUaObUbZ
 Vg16mPOM2jyhQuAGrBYWK9L8niqbmVWgqIpu8X8s6+oO+sgXMT+A1i4CEMyzKvuYWhXN
 PcpiDOTMrdMqw4ZKCRbHvhydkDLFrMKJyxzq5i3K73N/lU8uCvac3VZfktKvDnznkhYc
 QWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532533; x=1757137333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XuSNhIuWtZ+D9TGrKCnrrzHc63/oKkL0AUYE0riaIqA=;
 b=iu74KKuDtNXNiq1ittcPnGmDThQ/Qo6VcSk+Bjic4bxaC3SuYbYHvmPl/kkIVQ7SeW
 XzQSCFM7SN9ynFFqJK1lfeuQCmIO3eX2wtWflFrLMm2drIgLe//6bOLF82ohjHE7C4Am
 TdF4bV655DWHnOkhjiQnCRVy22FatmWqF7GPzgezSosU1/7HnBxnqsyOdNUFPBByMO6j
 w8YG3Qmf3DyhbhFSGU+ZJkzlxqkUe9DQN1NScoauX4mGcueQpyAU7bDkILmBatv+GjSg
 j/DeETewnpYOd6o8pPTr4PngGqGxOO1Smpp39Lb3iIVlRRJj7IduGG6umyrj3dP45l0Q
 iDBw==
X-Gm-Message-State: AOJu0YxHCqr0LXHN+iRFLlWkTtYl2UGPt7JK5w1F+0JD4Kha1sCBRJJN
 hOFN0YRHYDE5xh4jr8QPXaf2SFfdiGTvogq/kgksn+nVXyIqO62wRx9MbuXbtSoRBbaIKzU9c87
 aKaHhjKQ=
X-Gm-Gg: ASbGncvnRXIXb7SSp/uoFxOCJ7J/B63PwA/pgAXh4W6BaM9EnYjzzPfh1VRaKiaMEif
 fQKIX6QrsIPMqlEtZeAJvnHJLqfiERUYfzSE1/f1XDbfU0/eqruLSHNvLp+1GRRSm9OzkENZvJQ
 dCRKDvH45OfiT3JVhiC+Vmf9rwUmzPryXYM6XzSSexX43xgXVtLCt0AfzCa2cBPUjWXfDuHyfrT
 6IYmednRSkbwgRdcx+rQPoirEcU8XsJFVxYx1lCPMFtxI12IgsQhA4p00EmJvz3mqt9ygwf9Wv+
 Q1Nr1Bc0RC4YSVHd/G6iGxkRe5uhM8FDgXMMKmM8ZY/cHWlKW7BvlVmy9hjAYvz5iy52AIFYJVk
 Pts+ZllaQR1eDSfzKKbAewwHmK3VIdvEw16mqYpzltOoFGgGy2WwFudxS68Zo
X-Google-Smtp-Source: AGHT+IGIjdh2FkR5dIXbHOOqp/Ubl5RjhkPk+tHofOEa+kUEq/0F9Ef619D2/ehLduPzRypXjbmCMg==
X-Received: by 2002:a17:903:1b6e:b0:246:648f:80a3 with SMTP id
 d9443c01a7336-24944b5734amr13349865ad.50.1756532533087; 
 Fri, 29 Aug 2025 22:42:13 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:42:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 14/84] target/arm: Enable TCR2_ELx.PIE
Date: Sat, 30 Aug 2025 15:40:18 +1000
Message-ID: <20250830054128.448363-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 11e1c52b70..167362e32c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6106,8 +6106,12 @@ static CPAccessResult tcr2_el1_access(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tcr2_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                            uint64_t value)
 {
+    ARMCPU *cpu = env_archcpu(env);
     uint64_t valid_mask = 0;
 
+    if (cpu_isar_feature(aa64_s1pie, cpu)) {
+        valid_mask |= TCR2_PIE;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
@@ -6115,8 +6119,12 @@ static void tcr2_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tcr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
                            uint64_t value)
 {
+    ARMCPU *cpu = env_archcpu(env);
     uint64_t valid_mask = 0;
 
+    if (cpu_isar_feature(aa64_s1pie, cpu)) {
+        valid_mask |= TCR2_PIE;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
-- 
2.43.0


