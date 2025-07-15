Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E24C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZ0w-00029o-C9; Tue, 15 Jul 2025 02:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ0p-00022u-NA
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:19:35 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ0n-00070J-Rg
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:19:35 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-455b00339c8so25064445e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752560371; x=1753165171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RcBzpRDaRrnDJbIDx3w7L821BpSBhOYClllIovi4m+Y=;
 b=Zsnh0ePmpB4mGcB69W404Pyi0815IGCDfpRugMGLsB03mr0ioc2Q0f5IqXC5pwZbFR
 yGj3a7MY7GWy/75NDfcaS9LEtO3ewyZdp0tIbUg0GTTKIRQQhjdxxpAJVr31qMIXSCnT
 AOKf/onrfp9j7Q+AaFCpRmevklC+8dfryGEHyKIFYJwoSHtHFZ6qUYFp5zyJmEFryBvD
 /lJ02D224jicvLDug8WPW1C2+0cpg2s2h8n/sCvdQUPNx8SCYlBVs8aEn6Prnb5ltWZJ
 CDPEl2drmM5fJEoxhbCBqK+ZZrbzyYbYPic0bzndUqX5Xp4++4Q9syaXskdxj9lotrhD
 rotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752560371; x=1753165171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RcBzpRDaRrnDJbIDx3w7L821BpSBhOYClllIovi4m+Y=;
 b=nH6/FJvN3lUbg3CxHTQKXb3zUlWMApV3LHgrIiaNbQgG5tJoKHmbTI6MbXE7bEYO1X
 q8WDUMyP5yR7Z74qJ72INhCWRPdVfh1mxwJWo9Kpa3PyD9/DQZ4Vr9cO7YADLbFcAgFe
 VX40iytPyEGMoROjf5tp/Cy2Oz+cqCEIuQW253mlkumQErWuBWu2YxbwTdEzGCa4a7rk
 9fIOcB7MvAqkWBacPQUoCXiPoLrGQol5k1bUwM4pc1m3Hktr98YtfkFnlhF5ghsBmg/H
 JPuV1/U2VHmC5/0IBZXO84rFZCIEEZAuEm23qP8zzVtBB1AIhXqBJuDpjwSKPFcHJFgk
 fXzQ==
X-Gm-Message-State: AOJu0Yyr1tvTK3666IO/vYMJfU3X2ykr1YKCignPXVttSJ9i6/k3BKfT
 HygReUPxS+UZP3iPiHnEHZhbyvjepb3A91LZQ5K6wemc7LIo8D1UlId+sYwD8aESa5WeCcOEg7U
 9n2S8
X-Gm-Gg: ASbGnct8XlCKZVRqZtV0XaFM+9d8t4DikcvRthGJBgcFN41D2QRr491M1x/Sk+ogXF/
 mgknon6gHw4/yMBdamRCJEUWplP9/umUbO56W4wgsQwd1zJUzBKYv1TRYTXc5jPtJmvWZVt+SEj
 HkQ7eDhT3o+xBJvFIeiQWZxKudv+92xoq2OlNB4702YGLHtrytsKPZIatKKaZYxJxgA6jNdEEoW
 +jRjsKCTiWVQAcQf04URUHaaa5qDtWaGwoqPXQQxLT5AWDPh3++1XnW1QfQcZ/58/cUBpjCT6hg
 2tlRuUR0ZYwPMTXOrSroF1+BqIiTB0ScIU7xhYMjmsaQypFRf3rjVFZM9Jk3Qv+xAtFrY6i/uWO
 F27aoIQ4EZdlvqAN7e73W8GIslsBvBN1v78B0VrTQk5jOxUmHSPseEymjACDDRG0esQ6N2mPevC
 hgF1ubPBs=
X-Google-Smtp-Source: AGHT+IFtW9qTbg5ljD79tyErB0jrr+mfC7Wa4AcWfb3NmZzZWmnY+JISdrpOgumcx5m7vc6dX9rjeQ==
X-Received: by 2002:a05:600c:4e51:b0:456:8eb:a35c with SMTP id
 5b1f17b1804b1-45608eba50dmr105954455e9.31.1752560371517; 
 Mon, 14 Jul 2025 23:19:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc3a62sm14064198f8f.40.2025.07.14.23.19.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 14 Jul 2025 23:19:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PULL 02/17] target/mips: Extract gen_base_index_addr() helper
Date: Tue, 15 Jul 2025 08:19:02 +0200
Message-ID: <20250715061918.44971-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715061918.44971-1-philmd@linaro.org>
References: <20250715061918.44971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Factor out gen_base_index_addr() which is used twice
but we'll use it more.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241111222936.59869-2-philmd@linaro.org>
---
 target/mips/tcg/translate.h |  1 +
 target/mips/tcg/translate.c | 27 +++++++++++++--------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 428b53a0dac..e65593815e6 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -154,6 +154,7 @@ void check_cp1_registers(DisasContext *ctx, int regs);
 void check_cop1x(DisasContext *ctx);
 
 void gen_base_offset_addr(DisasContext *ctx, TCGv addr, int base, int offset);
+void gen_base_index_addr(DisasContext *ctx, TCGv addr, int base, int index);
 void gen_move_low32(TCGv ret, TCGv_i64 arg);
 void gen_move_high32(TCGv ret, TCGv_i64 arg);
 void gen_load_gpr(TCGv t, int reg);
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 5c80b030329..8816237e929 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1957,6 +1957,17 @@ void gen_base_offset_addr(DisasContext *ctx, TCGv addr, int base, int offset)
     }
 }
 
+void gen_base_index_addr(DisasContext *ctx, TCGv addr, int base, int index)
+{
+    if (base == 0) {
+        gen_load_gpr(addr, index);
+    } else if (index == 0) {
+        gen_load_gpr(addr, base);
+    } else {
+        gen_op_addr_add(ctx, addr, cpu_gpr[base], cpu_gpr[index]);
+    }
+}
+
 static target_ulong pc_relative_pc(DisasContext *ctx)
 {
     target_ulong pc = ctx->base.pc_next;
@@ -10546,13 +10557,7 @@ static void gen_flt3_ldst(DisasContext *ctx, uint32_t opc,
 {
     TCGv t0 = tcg_temp_new();
 
-    if (base == 0) {
-        gen_load_gpr(t0, index);
-    } else if (index == 0) {
-        gen_load_gpr(t0, base);
-    } else {
-        gen_op_addr_add(ctx, t0, cpu_gpr[base], cpu_gpr[index]);
-    }
+    gen_base_index_addr(ctx, t0, base, index);
     /*
      * Don't do NOP if destination is zero: we must perform the actual
      * memory access.
@@ -11334,13 +11339,7 @@ static void gen_mips_lx(DisasContext *ctx, uint32_t opc,
     }
     t0 = tcg_temp_new();
 
-    if (base == 0) {
-        gen_load_gpr(t0, offset);
-    } else if (offset == 0) {
-        gen_load_gpr(t0, base);
-    } else {
-        gen_op_addr_add(ctx, t0, cpu_gpr[base], cpu_gpr[offset]);
-    }
+    gen_base_index_addr(ctx, t0, base, offset);
 
     switch (opc) {
     case OPC_LBUX:
-- 
2.49.0


