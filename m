Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6B8C3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 17:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ozS-0006lV-Jr; Tue, 29 Apr 2025 13:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9ozQ-0006l1-6n
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:43:28 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9ozN-0006eM-MU
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:43:27 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so94949235ad.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 10:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745948603; x=1746553403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k3nV9Ny53k5M2p2D/6hdWEhlGk4a6icaPdiqA/NIhyA=;
 b=OBUcU9DXNIsBOokjEnV5O/PrKuugV7YOYN6ABYMh0KENkLz5VuJsbz9qpKcpXL10mb
 Jbb/YZzt2OdtaJQEw/nwfdOaayJ/MPWMyTE29pNW3OjzV16wtP6JbsgDXfw73rSFPaxw
 A3YXTolxCRXD1SadaPJPlPRQbSgKtw4XJmRR+MDiEI54QeyPUQ1ypmeBLh1buOVRmZ5h
 8WM/YPT1TS+tazEuYU6p5Mx//l9ui2+wPp/S9KY/fU5VCZ8gsnzFgzxqIeZ3n2x5SjbD
 cc+DOG3WeKp8ndIj3K6ZETlCgRzmxMFvR5oPCzkPB5ivKVBPJFC5kvkfSaa68U5jg324
 tVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745948603; x=1746553403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k3nV9Ny53k5M2p2D/6hdWEhlGk4a6icaPdiqA/NIhyA=;
 b=jucKAkLtYOCVfUYwBqh8fcwATulzkW7If/aX4wAj+tmQl2McFxlZJzgxhHjzikEx9S
 3nGAZuIaPjJEDe2uAjlz680V8FCgm8pkQKxCSz/7iMMggnbb/ez6yL6Nmor0DfPygjs6
 nAwYOCECeD40ZVL73tddlCGv9s8sLXpo+vg2dLwdhG+arQs9IPqNXzrFIINp3TkBFKSe
 0/O8MBnCYyDmG75fhOJ8FtKHoNIRLZx3Q3hJfkV/qMprqlHha/EG2Y7pXFuR6VLNiVdJ
 E1hv6CmC7Yu1OL+PUaXxYhgrvIjbeThWNNXeDLqgfeaxDy4zmLkNx6LXFeyb83QjmO2S
 tjcA==
X-Gm-Message-State: AOJu0YwaAdXEk9NDrNmjHAOfPXbFUEfJSNxJSmiMFc1Hn0vqvmdJQW5B
 5F+Cyq8/Q/8BVnVGvjeTEg20OLFU7NpdYLNQIhKVyyvBj9wZSSAH4q3FaDDVQHa/bIUyEy9nwp7
 /
X-Gm-Gg: ASbGncuOKwVT799gGRk4OIqoykyO49GqSYbhcyPPaL4ygJ2OBtXUM7E5/142TTWgaNU
 0jIW4Ia+/2lY+mvp88hmlbr4Tq6pa0cy11mNamiKdDDwsqmQSNgye7hMQKV2U7+ui0QDBTKZ44w
 KxZ5sQgJV06ygnwZCdAp8XDteq6ybktKodyq8fHHFW5OqU+swaAcjlen47aHmsuRncepDc/0Nyv
 seC5BmQ8c/gN3mUndt2RKZxbWajfYwN9UdW8CikmJVNNHp+hsIxlxAq2RUJW+397+VBXYzd0oLR
 zKomMcbeohl3rJYrl0WMDFO6LcEhi9BlPf3NMXO3dKOYkKjqLATpkY6VHOO8IUaixf99OAfMlxU
 =
X-Google-Smtp-Source: AGHT+IGbBwudOtCLYwzWV/W04je9ISnHZXnehszNM+gf2NCc9/lOIiDt8EZKbJgtzn5ZIblE5dqPrw==
X-Received: by 2002:a17:902:f68f:b0:220:e9ef:ec98 with SMTP id
 d9443c01a7336-22df34d8324mr3976475ad.19.1745948603377; 
 Tue, 29 Apr 2025 10:43:23 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4e0c385sm105795955ad.105.2025.04.29.10.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 10:43:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 161/161] tcg/sparc64: Implement CTPOP
Date: Tue, 29 Apr 2025 10:43:20 -0700
Message-ID: <20250429174320.1841700-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429174320.1841700-1-richard.henderson@linaro.org>
References: <20250429174320.1841700-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target.c.inc | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 260dd461bd..9e004fb511 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -210,6 +210,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define ARITH_UDIVX (INSN_OP(2) | INSN_OP3(0x0d))
 #define ARITH_SDIVX (INSN_OP(2) | INSN_OP3(0x2d))
 #define ARITH_MOVCC (INSN_OP(2) | INSN_OP3(0x2c))
+#define ARITH_POPC (INSN_OP(2) | INSN_OP3(0x2e))
 #define ARITH_MOVR (INSN_OP(2) | INSN_OP3(0x2f))
 
 #define ARITH_ADDXC (INSN_OP(2) | INSN_OP3(0x36) | INSN_OPF(0x11))
@@ -274,6 +275,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define STW_LE     (STWA  | INSN_ASI(ASI_PRIMARY_LITTLE))
 #define STX_LE     (STXA  | INSN_ASI(ASI_PRIMARY_LITTLE))
 
+static bool use_popc_instructions;
 #if defined(__VIS__) && __VIS__ >= 0x300
 #define use_vis3_instructions  1
 #else
@@ -1511,8 +1513,23 @@ static const TCGOutOpBinary outop_clz = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_ctpop(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_arith(s, a0, TCG_REG_G0, a1, ARITH_POPC);
+}
+
+static TCGConstraintSetIndex cset_ctpop(TCGType type, unsigned flags)
+{
+    if (use_popc_instructions && type == TCG_TYPE_I64) {
+        return C_O1_I1(r, r);
+    }
+    return C_NotImplemented;
+}
+
 static const TCGOutOpUnary outop_ctpop = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_ctpop,
+    .out_rr = tgen_ctpop,
 };
 
 static const TCGOutOpBinary outop_ctz = {
@@ -2084,15 +2101,15 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
 static void tcg_target_init(TCGContext *s)
 {
+    unsigned long hwcap = qemu_getauxval(AT_HWCAP);
+
     /*
      * Only probe for the platform and capabilities if we haven't already
      * determined maximum values at compile time.
      */
+    use_popc_instructions = (hwcap & HWCAP_SPARC_POPC) != 0;
 #ifndef use_vis3_instructions
-    {
-        unsigned long hwcap = qemu_getauxval(AT_HWCAP);
-        use_vis3_instructions = (hwcap & HWCAP_SPARC_VIS3) != 0;
-    }
+    use_vis3_instructions = (hwcap & HWCAP_SPARC_VIS3) != 0;
 #endif
 
     tcg_target_available_regs[TCG_TYPE_I32] = ALL_GENERAL_REGS;
-- 
2.43.0


