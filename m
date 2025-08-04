Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F95C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj0jx-0002O1-9y; Mon, 04 Aug 2025 15:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj06T-00019m-Tr
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:40:13 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj06O-0000wY-HF
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:40:09 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-76b77a97a04so2734416b3a.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 11:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754332801; x=1754937601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r2HhmWn+3Uhat9xr0ViadQ+YUOagyNbQxWkSxpV2E5c=;
 b=nSH1IIwIX2gR+Xz0UamSK8KEDGym03VtIcFSQnrUcUJdL7N7xpv3KjJVuK8vvpj11I
 NU+p8vn4D7n4R9SlUAmdorFPqfc76wUenFbgUyOzNW1JTObWbpXy8vlyckAq2Qua04sZ
 GYk3AKl6Vh1+HIqpyyNDFSGC3dxGpVPyWL4+N3aGWBcbRDY4H/8pwCZPWMjtaMxuDmL7
 5N5ASO12BjdkEq9V1CXVwN1CXinHTs+qB10lFvM+5ggn3iNoaBfk/Ra4odoXJZ0FW7JN
 dc84iXoBumOvFUhoGJc3NaGA+UZDWhrcxyFXhgWZ83dtm8X5P5qWpi2mRB/bCCbInouB
 qIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754332801; x=1754937601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r2HhmWn+3Uhat9xr0ViadQ+YUOagyNbQxWkSxpV2E5c=;
 b=lW0P5yVZiwG6sYo5+4m2bQnqKwxe2BCMXVcapG63vnmoShhAXG94PghmCc+mdpUAcf
 weTkev1M1RtBWYeu7UTYjlxBo8K9w6OboaCKyulMums/piV+YGLL2iVBaKadi/XM2Fvq
 KH0IphtiH9mhENCRN7d9FERCpBqSWmXWe3fkoNbD78uk0CEQ+59/32CHke6qIYUm8uHe
 zm+07HN3wJNm66dBd+YYDwa/C4Fg0o2mLBvnAT8RPsS442iJOGX8lxWO6yEad0s/u84I
 jE28LBwRubPxI/I8fsGVnYOhMoz33ofvlBSB9NJCuJrD6tSPGhTGoq40sOlGINea+Nhp
 Z+yA==
X-Gm-Message-State: AOJu0YyTAm68Oe2mGdt3HHnW5gI+JkNlqDU/OK/1g1TNMiRZYq9btpu4
 X1ilKw/P/6MGk2bi3np6ECo8ruwIn7+u8ZLc+7SAL8E50/pbVkzFZwreko23GKObQO0zh2NFFLp
 H8p8n
X-Gm-Gg: ASbGncuXvlQEzNZ78s7gvMiPhE2hKSMYnR9/M6awYdWufp+CeD1SepY68ECXnM2kR5B
 eYAmMLgRiy/wzhLb7Z2fH4+rGz2hJ+vA5J2cSPdcSEACTXk/8IrWcGrS4z1WjobO9S/Tynqqzpd
 LfzzDH1JNiQr6Bgsekf5Coi1umRNth/ZzGhCbFv7nwnvqyoAYu/lxy11DcSOk6QPpHHvRjXrQap
 xHTgudk/GqU9tHRUsI/NBa9Mw8jjGhav3gHr3kZHpy38dsYGwkH8TIKsv6cHffz2GaAioXJruIH
 Y4MbFKy695XZ6C/dl8qqWjWcSoGvqaGIIE/lfdiBau6X1Udc76cwYyMDBFrFdMiumwRmF6m/qAw
 hboAGvjquxF4B9Z/ZhYldKQ==
X-Google-Smtp-Source: AGHT+IFc3oT+XcNNEGUU9pmAKKrlbKZ2uaO8uJ6AS0ce2FHjFrSGPfAg4Wy97lxXrO3V1aJqQDDRyQ==
X-Received: by 2002:a05:6a00:3910:b0:736:5f75:4a3b with SMTP id
 d2e1a72fcca58-76bec30c7ccmr13794563b3a.7.1754332801410; 
 Mon, 04 Aug 2025 11:40:01 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bd78875cesm9940171b3a.15.2025.08.04.11.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 11:40:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, Weiwei Li <liwei1518@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 05/12] target/riscv/common-semi-target: remove
 sizeof(target_ulong)
Date: Mon,  4 Aug 2025 11:39:43 -0700
Message-ID: <20250804183950.3147154-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804183950.3147154-1-pierrick.bouvier@linaro.org>
References: <20250804183950.3147154-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

Only riscv64 extends SYS_EXIT, similar to aarch64.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/riscv/common-semi-target.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/riscv/common-semi-target.h b/target/riscv/common-semi-target.h
index ba40e794dcc..7e6ea8da02c 100644
--- a/target/riscv/common-semi-target.h
+++ b/target/riscv/common-semi-target.h
@@ -25,16 +25,16 @@ static inline void common_semi_set_ret(CPUState *cs, target_ulong ret)
     env->gpr[xA0] = ret;
 }
 
-static inline bool common_semi_sys_exit_is_extended(CPUState *cs)
-{
-    return sizeof(target_ulong) == 8;
-}
-
 static inline bool is_64bit_semihosting(CPUArchState *env)
 {
     return riscv_cpu_mxl(env) != MXL_RV32;
 }
 
+static inline bool common_semi_sys_exit_is_extended(CPUState *cs)
+{
+    return is_64bit_semihosting(cpu_env(cs));
+}
+
 static inline target_ulong common_semi_stack_bottom(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
-- 
2.47.2


