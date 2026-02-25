Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B722AFD45FB
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOAF-0007D8-Re; Wed, 25 Feb 2026 18:19:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO9z-00079K-01
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:19:18 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO9x-0003RF-Dc
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:19:14 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4837f27cf2dso2455615e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061548; x=1772666348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UOwcsNYx5lvxmM9HIkeoZLS1sLoRQuqq5LOWsdVgJ+A=;
 b=NxKgI0fcoyISH0U8gjUDpdthGsYFA4cKHOlopDt91KkGikHctRfVm2+UY3DQaiH5wA
 q+YfA3BiylfvXiMPmnvWl9MSzwMQ0Tf3T/DeDnsNEARfoakSNzMNkWBsimEwqSlEvO56
 joNcujMXLU5Sl3y/wEutEPWI4JN/NvfA11k2rqNlPq9T36pzsdJIWqBo63MtaAd9f7mo
 YsA3uDF/V5hfyJnhsZwjpMt1D57xfdb46L+mnLp5mB8uAYkg04vkByNxqKzgrVEsxWrl
 pCspzR2hPKVkTIC5eLtekNQUpaTt3DozkPZUoXcG2UM4rfb0MkxwO1H2lNM9q9l56mii
 4JBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061548; x=1772666348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UOwcsNYx5lvxmM9HIkeoZLS1sLoRQuqq5LOWsdVgJ+A=;
 b=oZro90Io2mZllnNCN6Y1njFh22hx7EViUdouGYCMTt4FNHCujBUJPZCn8KpYgkrcVo
 ngZlYR0ey4U3R7FEdQlPqC9G5hp6b4wFRJbUebOmeYfgveEHuSmWwyFiAlkFK6Mn1CN2
 vYTPm7Ws9y3OI9ItIrOeHsQlXlPPGwk7VNdBa63RVC2El/ihKFoXgpYGTOLce7XbJ/5N
 LlK2UqgMokl5pFxbC9xTNG+Gl/lN4pg13iZWyiJJ9W4vweGYyIWTHFQnp/Q0Sy8hXMlY
 /RD0GdD3B2ZRknZ1U2bB0M5F0zADgndxCfirqHqdFWvaI97+/DwxtBL1lCgsT23BogZ4
 jWPQ==
X-Gm-Message-State: AOJu0Yy7cUnNaZD8xQMhFn5mooUrNgue3sp50hbq46022j7gnk8M/zW3
 KkepOrLyLF70mqPPUlWOhDozQe2tKcDbuvYM/pfcgyNEAYQIvaA91BYW/+QoGwfegrOWe58A186
 bGeZQL9A=
X-Gm-Gg: ATEYQzxWCKDoy6LXc+jyrMyuW/668YkPjx42K0ldj7Ary8zRyQXg667UcgTdjCZxtzt
 ADbYXrca/kurykI9qKwacyTYdErx43DQsIxEYZ037Jhs5y93e/Ov3ERD9JR+Q65RHzwfv0f/0Q+
 JEQbnDB8PK4QhHKzZwtWLOi52HBvrNNIGmmOVZmITdr60gmokIZNx2k6YcgEESRAgjO8JxAjanG
 2DmqHM1SeXvfAEgOnvIZVGfNkBBafqXVAe4Rw7aew76t4S5xvEadWPbFrY66WC7eaYv9zjQ6q/u
 BwQTPfA9QAaSpy+D+k6V+xLHcdd+V6ATd4dO3lHFnMsX5HU6Y+tRlctYJsz0tZfS5dkpkdcS5VC
 c3VwK0zYXoCxmhVDPBVjcua/NC2f+t6gJhFo2/+0AjnCIZ1bPUGzHPHBJIOcgkTN96Seojvmzga
 alJ2LIRDVP+/2Y3+PFosGlGGgaedewwX0pbOA9+DVuDGWqAY3t7h8fqAZ/nOJb3QPUMxGYWDMU
X-Received: by 2002:a05:600c:6217:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-483a95eb550mr276028245e9.3.1772061548081; 
 Wed, 25 Feb 2026 15:19:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b3ce8fsm4360355e9.4.2026.02.25.15.19.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:19:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/70] target/sh4: Expand gdb_get_regl() -> gdb_get_reg32()
Date: Thu, 26 Feb 2026 00:13:43 +0100
Message-ID: <20260225231411.96482-44-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

The SH4 targets are only built as 32-bit:

  $ git grep TARGET_LONG_BITS configs/targets/sh4*
  configs/targets/sh4-linux-user.mak:5:TARGET_LONG_BITS=32
  configs/targets/sh4-softmmu.mak:2:TARGET_LONG_BITS=32
  configs/targets/sh4eb-linux-user.mak:6:TARGET_LONG_BITS=32
  configs/targets/sh4eb-softmmu.mak:3:TARGET_LONG_BITS=32

Mechanically replace:

  gdb_get_regl() -> gdb_get_reg32()

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-36-philmd@linaro.org>
---
 target/sh4/gdbstub.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/sh4/gdbstub.c b/target/sh4/gdbstub.c
index 75926d4e049..4f36e800d2c 100644
--- a/target/sh4/gdbstub.c
+++ b/target/sh4/gdbstub.c
@@ -31,43 +31,43 @@ int superh_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     switch (n) {
     case 0 ... 7:
         if ((env->sr & (1u << SR_MD)) && (env->sr & (1u << SR_RB))) {
-            return gdb_get_regl(mem_buf, env->gregs[n + 16]);
+            return gdb_get_reg32(mem_buf, env->gregs[n + 16]);
         } else {
-            return gdb_get_regl(mem_buf, env->gregs[n]);
+            return gdb_get_reg32(mem_buf, env->gregs[n]);
         }
     case 8 ... 15:
-        return gdb_get_regl(mem_buf, env->gregs[n]);
+        return gdb_get_reg32(mem_buf, env->gregs[n]);
     case 16:
-        return gdb_get_regl(mem_buf, env->pc);
+        return gdb_get_reg32(mem_buf, env->pc);
     case 17:
-        return gdb_get_regl(mem_buf, env->pr);
+        return gdb_get_reg32(mem_buf, env->pr);
     case 18:
-        return gdb_get_regl(mem_buf, env->gbr);
+        return gdb_get_reg32(mem_buf, env->gbr);
     case 19:
-        return gdb_get_regl(mem_buf, env->vbr);
+        return gdb_get_reg32(mem_buf, env->vbr);
     case 20:
-        return gdb_get_regl(mem_buf, env->mach);
+        return gdb_get_reg32(mem_buf, env->mach);
     case 21:
-        return gdb_get_regl(mem_buf, env->macl);
+        return gdb_get_reg32(mem_buf, env->macl);
     case 22:
-        return gdb_get_regl(mem_buf, cpu_read_sr(env));
+        return gdb_get_reg32(mem_buf, cpu_read_sr(env));
     case 23:
-        return gdb_get_regl(mem_buf, env->fpul);
+        return gdb_get_reg32(mem_buf, env->fpul);
     case 24:
-        return gdb_get_regl(mem_buf, env->fpscr);
+        return gdb_get_reg32(mem_buf, env->fpscr);
     case 25 ... 40:
         if (env->fpscr & FPSCR_FR) {
             return gdb_get_reg32(mem_buf, env->fregs[n - 9]);
         }
         return gdb_get_reg32(mem_buf, env->fregs[n - 25]);
     case 41:
-        return gdb_get_regl(mem_buf, env->ssr);
+        return gdb_get_reg32(mem_buf, env->ssr);
     case 42:
-        return gdb_get_regl(mem_buf, env->spc);
+        return gdb_get_reg32(mem_buf, env->spc);
     case 43 ... 50:
-        return gdb_get_regl(mem_buf, env->gregs[n - 43]);
+        return gdb_get_reg32(mem_buf, env->gregs[n - 43]);
     case 51 ... 58:
-        return gdb_get_regl(mem_buf, env->gregs[n - (51 - 16)]);
+        return gdb_get_reg32(mem_buf, env->gregs[n - (51 - 16)]);
     }
 
     return 0;
-- 
2.52.0


