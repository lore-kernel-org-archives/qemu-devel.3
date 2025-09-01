Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC15CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut30U-0001RP-0N; Mon, 01 Sep 2025 07:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut30R-0001LK-Av; Mon, 01 Sep 2025 07:47:27 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut30L-0001bF-4U; Mon, 01 Sep 2025 07:47:26 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-24456ce0b96so44278855ad.0; 
 Mon, 01 Sep 2025 04:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727225; x=1757332025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QST8MQTRFZEhs5AjQPRXH0ReyeMh+BeVvkW3QZwh+1A=;
 b=I9Nr8S3cCBG/lQHyTg3tyjqCK5IpMKUT3hcCI6Dbr0RnS2RKGl9qROBkOXb41vQFz9
 l3qm6tiISSn3DBUS/AdX9CydsU2DHOjxFaDn9KoXj2WGlISl9+EK3BS1+pJ1BW/C4EK3
 bWy2E0nkaZyduJVgMmfslEBPJcA51G17fp1knIZeJee1TEJdnZQw/UlFbvwHQcsiMVym
 gnLQ/YOtNmrqMPiQ4o/jPQWnc3an1RHIF4fk50wZNgbZqEXEO7KQ3lNSJ3qCws1bbitb
 aqDZZMmF9EpDifQMqhE2bP9AWEohLx93umoZ5VZgTwr4kKMEBq+XcsAENBneNl5/537d
 1bIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727225; x=1757332025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QST8MQTRFZEhs5AjQPRXH0ReyeMh+BeVvkW3QZwh+1A=;
 b=tREkewBSnHS5H4fG5zIdxI4rsJbzVrRrGSbiOcDfYgEIj1mG1KXGv7Uyfk0LAXmtgU
 DEOl6afc7rTL9aFM4Fjkhl3+hPQXNAcWRBl8U5Jx3ieYp7OnJIk5OZRCNn3lJSIAacZw
 BbnzqkgLrH2GSfyO9WjxnjURBICNjxPwt2dgaH+9HymL4MJnW+Hnh+rCVZwXGc9znS4J
 I9/c1iDLqpe3pVqP4wqQ+GMu+COs+S1W9sbLuIgXJk/K/ykBZCEbCL80NoW4J4HZhrnw
 bwQzbWornZPSsLTj4St52cPgH6DFgSPsBGck4Fr7aV9GnZATLJSFrqH5fIeP7M1eSDYt
 beNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2/Gp0oGiwC7EBv6bw8xJP3515sKqfHQgpcJP+BdxGJeg3kuZyo1v4WOUZ5X/mPi+LWUaUbV2e1Q==@nongnu.org,
 AJvYcCXQ5uj+7Q3B1qxOwubfcMoWzXe/au9kHEbmPnx5Jkev1RF3VicKSYARSvGnKbGRrcI5tEB2Xioms4pkOQ==@nongnu.org
X-Gm-Message-State: AOJu0YyQtW6oGfklW79hMQt/CduBvaXLeTATNA56Rb9qpN8ejICRdX8h
 lFZhKQ7TGHFdepaWNYICvdks1ayIzuSKKvwULIaz9AylXbuwHsYQzpv9NZjaEQ==
X-Gm-Gg: ASbGncvfKgQyllazs0CE6oL8Butz8+JxEdzfmg1LPMqnI8sZeR/nTkcAy1r0W6Epdur
 unq9Sioec+2w8hiKDaP1OwwDCIhbqfBH3/8wPiJlYD49wgrdZS09K2ENeBgXm56fDqgSYVrE3je
 6ALaDMWyYWJocYcygkwzqDG3TY7u0SFMMZh3Rmahx7zT1xbYX//bSR8whhak2X7J9mopD524BWy
 kd3rOtuwdcpMmIiA+d3XZiXWyWL1xD5QUY3spu//wXbE9K5QTix39zIVwW86TIvYtttok/mDKCT
 x8h1Xb3mZceu4P/NaMofRTtVwABHe3o+Ma61X/Hw9wOfS39fJI+Lp02sttFH3IvBc9L4bjqQX4l
 nDX+LWX9S1fitLNz8hYqR6YbzhaKJiglU
X-Google-Smtp-Source: AGHT+IGcvRy/DceMUMT1/SF1BY0nUDrsEocsXYek2qfwdA2hXghrEfet/9dRcAQ1DhtTkyNav6ZJkQ==
X-Received: by 2002:a17:902:c951:b0:24a:aeb6:f1ae with SMTP id
 d9443c01a7336-24aaeb6f56cmr61121845ad.11.1756727225496; 
 Mon, 01 Sep 2025 04:47:05 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:47:04 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v3 18/35] tcg/wasm: Add neg/ctpop instructions
Date: Mon,  1 Sep 2025 20:44:20 +0900
Message-ID: <2cb39a5cb4df42d6a7b3bdc3d6449fb9a60e861f.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The neg/ctpop operations are implemented using the corresponding
instructions in Wasm. TCI instructions are also generated in the same way as
the original TCI backend.

The Wasm backend implements only TCG_TARGET_REG_BITS=64 so the ctpop
instruction is generated only for 64bit operations, as declared in
cset_ctpop. Therefore, this commit adds only the 64bit version of ctpop
implementation.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm.c                |  4 ++++
 tcg/wasm/tcg-target.c.inc | 44 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/tcg/wasm.c b/tcg/wasm.c
index 8c8dcb81c7..a5e72d8fe5 100644
--- a/tcg/wasm.c
+++ b/tcg/wasm.c
@@ -359,6 +359,10 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (uint32_t)regs[r1] % (uint32_t)regs[r2];
             break;
+        case INDEX_op_ctpop:
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = ctpop64(regs[r1]);
+            break;
         default:
             g_assert_not_reached();
         }
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 38459a60d6..27f3a7414b 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -188,6 +188,7 @@ typedef enum {
     OPC_I32_SHR_S = 0x75,
     OPC_I32_SHR_U = 0x76,
 
+    OPC_I64_POPCNT = 0x7b,
     OPC_I64_ADD = 0x7c,
     OPC_I64_SUB = 0x7d,
     OPC_I64_MUL = 0x7e,
@@ -547,6 +548,21 @@ static void tcg_wasm_out_movi(TCGContext *s, TCGType type,
    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
 }
 
+static void tcg_wasm_out_neg(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, 0);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg));
+    tcg_wasm_out_op(s, OPC_I64_SUB);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+}
+
+static void tcg_wasm_out_ctpop64(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg));
+    tcg_wasm_out_op(s, OPC_I64_POPCNT);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+}
+
 static void tcg_out_op_ri(TCGContext *s, TCGOpcode op, TCGReg r0, int32_t i1)
 {
     tcg_insn_unit_tci insn = 0;
@@ -1138,6 +1154,34 @@ static const TCGOutOpBinary outop_remu = {
     .out_rrr = tgen_remu,
 };
 
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_op_rr(s, INDEX_op_neg, a0, a1);
+    tcg_wasm_out_neg(s, a0, a1);
+}
+
+static const TCGOutOpUnary outop_neg = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_neg,
+};
+
+static void tgen_ctpop(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_op_rr(s, INDEX_op_ctpop, a0, a1);
+    tcg_wasm_out_ctpop64(s, a0, a1);
+}
+
+static TCGConstraintSetIndex cset_ctpop(TCGType type, unsigned flags)
+{
+    return type == TCG_TYPE_REG ? C_O1_I1(r, r) : C_NotImplemented;
+}
+
+static const TCGOutOpUnary outop_ctpop = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_ctpop,
+    .out_rr = tgen_ctpop,
+};
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     init_sub_buf();
-- 
2.43.0


