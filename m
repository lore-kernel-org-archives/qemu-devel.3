Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299E2C54764
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYYN-0002Oy-5v; Tue, 20 Feb 2024 17:25:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcYYI-0002O4-2N
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:25:27 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcYYF-0003W2-7u
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:25:25 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d944e8f367so48685785ad.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 14:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708467921; x=1709072721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c06cdweMSPa1lLgHj48cX17VsakRjktLirNDmTiTsUo=;
 b=IkC13yn9c3hq5d4Gl6wv/IyNF14hX1CRI+xbYSDaa92t3SxPpI5XHd5Vz+ZXPpZQNR
 +hIdFS6+ii8+gstJo0BwHWiZ0xyQo23unj1VuG34PY3bDL3rRKs2lgwHyB4n2AV9bxdt
 ok7/KYh49ACiahGg0cgMYUB3YIhMu3qYd51MgjcMkdnl0BULImosUs79tIX/2Tn12olm
 g+rj6OINKz5HMVUIbpjYEeS6CwV7TU+Bjt3arx/l3mjr7o8cHwFDDdq1k6y3lE0FcILD
 3rqFNufldGWeS/fIK8NCEiLBf/O+PKzoBf9Idoz/3Iyvg9Gx2DwWMvwjprg1pBpz12W8
 ek2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708467921; x=1709072721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c06cdweMSPa1lLgHj48cX17VsakRjktLirNDmTiTsUo=;
 b=lXx6hCJFVneT1XtZgKpFK034C2RKZdvsuTbqf8IsyQnw/D1pJp4fHn13/N3OKwB/K3
 o83SNo4R2XFFd7o3VMMqIbyxZZXnN0xhNusFPZ9xL221UzuNCqHGoEAcHaVA2iIJZIxK
 3A/L5Dd+Xow/h1/euxpMf7Wb0eCuG4mcbrZ1ZGjW2qMGxRZTWYn+OEyMHIr/UvYdpgpP
 YrGwtm8gF4x6SBVCSMSeKhsiu2yrP4P90C3Fr6pf6tbTFumSZGioMA/J9znRlQw0mpqQ
 xs91SUk29bY1n/cuoKGPtV/3VkkCfLSHA9l3Tw1NSJbl9Jd5nuEeWzLbIJlBr2ZyTsQw
 CA7A==
X-Gm-Message-State: AOJu0Yz2xQDcYHHWeH46iMg9OPr9RpcknjpUKoLNUTdMcxWoU9FUUMNG
 N1mmVmPcBWx/GC10Tl2dUng5VyeAgUy8AxqasFSL9HfxqvniOsPWc+xdA4MTA7WVrlHxgWjjsEr
 Q
X-Google-Smtp-Source: AGHT+IHTgd5cERM41KMiZijEYZXrLRTliR4uEa2MJxO6UmDYu9WoXzMcjdyGcypahHBIWSsqigicRw==
X-Received: by 2002:a17:902:d4ca:b0:1db:f23f:678e with SMTP id
 o10-20020a170902d4ca00b001dbf23f678emr6359331plg.15.1708467921015; 
 Tue, 20 Feb 2024 14:25:21 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 iw20-20020a170903045400b001dbb86b88e5sm6761044plb.124.2024.02.20.14.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 14:25:20 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 1/6] trans_rvv.c.inc: mark_vs_dirty() before loads and
 stores
Date: Tue, 20 Feb 2024 19:25:05 -0300
Message-ID: <20240220222510.209448-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220222510.209448-1-dbarboza@ventanamicro.com>
References: <20240220222510.209448-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

While discussing a problem with how we're (not) setting vstart_eq_zero
Richard had the following to say w.r.t the conditional mark_vs_dirty()
calls on load/store functions [1]:

"I think it's required to have stores set dirty unconditionally, before
the operation.

Consider a store that traps on the 2nd element, leaving vstart = 2, and
exiting to the main loop via exception. The exception enters the kernel
page fault handler. The kernel may need to fault in the page for the
process, and in the meantime task switch.

If vs dirty is not already set, the kernel won't know to save vector
state on task switch."

Do a mark_vs_dirty() before both loads and stores.

[1] https://lore.kernel.org/qemu-riscv/72c7503b-0f43-44b8-aa82-fbafed2aac0c@linaro.org/

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 9e101ab434..7a98f1caa6 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -636,11 +636,9 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
     tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
 
-    fn(dest, mask, base, tcg_env, desc);
+    mark_vs_dirty(s);
 
-    if (!is_store) {
-        mark_vs_dirty(s);
-    }
+    fn(dest, mask, base, tcg_env, desc);
 
     gen_set_label(over);
     return true;
@@ -797,11 +795,9 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
     tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
     tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
 
-    fn(dest, mask, base, stride, tcg_env, desc);
+    mark_vs_dirty(s);
 
-    if (!is_store) {
-        mark_vs_dirty(s);
-    }
+    fn(dest, mask, base, stride, tcg_env, desc);
 
     gen_set_label(over);
     return true;
@@ -904,11 +900,9 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     tcg_gen_addi_ptr(index, tcg_env, vreg_ofs(s, vs2));
     tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
 
-    fn(dest, mask, base, index, tcg_env, desc);
+    mark_vs_dirty(s);
 
-    if (!is_store) {
-        mark_vs_dirty(s);
-    }
+    fn(dest, mask, base, index, tcg_env, desc);
 
     gen_set_label(over);
     return true;
@@ -1102,11 +1096,10 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
     base = get_gpr(s, rs1, EXT_NONE);
     tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
 
+    mark_vs_dirty(s);
+
     fn(dest, base, tcg_env, desc);
 
-    if (!is_store) {
-        mark_vs_dirty(s);
-    }
     gen_set_label(over);
 
     return true;
-- 
2.43.2


