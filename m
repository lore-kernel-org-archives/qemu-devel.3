Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BC3C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHUL-0007Bv-ET; Wed, 12 Aug 2026 18:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUJ-0007As-LX
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:31:55 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUI-0000wH-3O
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:31:55 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-cbee846deecso1283341a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573913; x=1787178713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=63lJkhjE5NjzMRJjmXxoIck4WQcRpRq7JHbI5QrXX6o=;
 b=CPuqso0yH8imqK6lTmIJa34No8qNIoHzroh0uSUk68XYsAIAc6i4m3EGAdlq9tOAmO
 OmlOVPObcRG2HSN+n4J6yGwCORUze/fthCl7mv6jVLfOpiiS6jEbjiOOawXllPPddegF
 wrn22pu1ViEv228yqb1q+uYzUCevpcmIxYKX+Qi80QSGL3uEgYcaOEekWxssXieF6+Pb
 MLCSsEmHORHRkSpN2vYtVKDCGRNRWk/gtTa3UEL/hI3mgcHelD7oL2RrEL7/w8GPNIyQ
 nzMk2+Z84jdAV/rad7biZvT2Z8dqlBZCuDNIFgbL8QvwQxwXaAQh5E8V1qF0gvDF5pkN
 sHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573913; x=1787178713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=63lJkhjE5NjzMRJjmXxoIck4WQcRpRq7JHbI5QrXX6o=;
 b=XMVk/WNhjC3bXD9Kg567ophj4d2R1DPyo8uJcAEB7v8CkTRcvlII/M7BppP7YM+P04
 rk0hkPSHJnOfCnVnQmdsutMRsxhuSObK6QQjBz8Lhi4h0ARCWbOZKJTl7GJS/PEFIELt
 fX7S4X973W4JsmQhsVmu37mD0GoN0OH/viplenfAeVXop/widaPv07c6beyGoB+fnlQi
 I2ry7Ef/sCpFxmm1XKdGzod35B7MnLLncZeZOVpJaIMV5Rupr4AXnQZBaZgMFNAY+Kqp
 HiOWnhWfYcn9517R1f1HCgouJAVS2rDNamWqd8m8qdep3AjsTL1jqHbIYgUluJDe6+DX
 roow==
X-Gm-Message-State: AOJu0YwXmln/KTn2Veup0oY4AYrGmLydvA+7IkcI1hhD2/h7DAG8b4cd
 qMhU4lpXm8uP2D0GNk0XQ93wlq3FefgyWijGuBz6hTFcE/SoCXD6uaQC4vGR8wvVuDHIwSUuYPh
 NPeaC
X-Gm-Gg: AR+sD11RBA0Zmk5cDyI9SfK+XVvA43lCwhaotgT4EyEEsBnATjhqjX4JoSoMgo70ZJF
 H4UjnA4O+hAyzU9y9qK/B4rvculOHODJ1hU+VE5IETiA3EvXeViXAzN2p3Rcfx/wiclex1m3xJu
 QcSJDZQtm9GjSYqEWF/1lszZQwLOvDwfuvX4nHvp2MqIBJ1FQmN56tzm9kfzfdkP/gkXpFIxqj/
 OOAccI/tcstAPvjP4yPVXuKzA6jzCBK3qRptM5XPU4QycEnacniHQ+CYhSN6tuTE/gCwhwhzgY2
 nex6tHYZPoYLFPjykfTww3qTna74A89M+muwvWAMVPYZLAvIonnHftCWf21suqDjmysXZ0QJzBg
 2jTuEVwI0wqbcVPtR9JbRqPjvMQeM4esCRZbzLg11qc9FS0kWTPWLpOmKp6+56cqbxP6eQqRfXL
 p3KnuLzgMyTzBc8p2DpY9uUq/j3RGDWQCs71Wa+pvdln7ZicfR1dBX+cIEAWUN1GIIGQbaazX/Q
 9vwUwgFirJwgPY1aR1FelcI51DC6sM=
X-Received: by 2002:a05:6a21:44ca:b0:3c4:2eb6:c3a0 with SMTP id
 adf61e73a8af0-3cc5538c0d5mr2098330637.30.1786573912595; 
 Wed, 12 Aug 2026 15:31:52 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:31:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 07/52] disas/riscv: Pass rv_opcode_data pointer to
 format_inst
Date: Wed, 12 Aug 2026 15:30:57 -0700
Message-ID: <20260812223142.349142-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 0be2f07612..70ea41f125 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5111,17 +5111,16 @@ static size_t inst_length(rv_inst inst)
 
 /* format instruction */
 
-static GString *format_inst(size_t tab, rv_decode *dec)
+static GString *format_inst(size_t tab, rv_decode *dec,
+                            const rv_opcode_data *op)
 {
-    const rv_opcode_data *opcode_data = dec->opcode_data;
     GString *buf = g_string_sized_new(64);
-    const char *fmt;
+    const char *fmt = op->format;
 
-    fmt = opcode_data[dec->op].format;
     while (*fmt) {
         switch (*fmt) {
         case 'O':
-            g_string_append(buf, opcode_data[dec->op].name);
+            g_string_append(buf, op->name);
             break;
         case '(':
         case ',':
@@ -5466,7 +5465,7 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
     decode_inst_operands(&dec, isa, op);
     op = decode_inst_decompress(&dec, isa, op);
     op = decode_inst_lift_pseudo(&dec, op);
-    return format_inst(24, &dec);
+    return format_inst(24, &dec, op);
 }
 
 #define INST_FMT_2 "%04x              "
-- 
2.43.0


