Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B4EC54798
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcuCA-0004WD-AY; Wed, 21 Feb 2024 16:32:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcuC5-00047p-30
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:31:57 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcuC1-0004H5-9T
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:31:56 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dc49b00bdbso770855ad.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708551111; x=1709155911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6I/kQk2SJrf45BvogIDX/Yl21y/g0Vy+Ano204ZYEw0=;
 b=Fy8BZ+C2QlbGb0fCSD5PGsQiwHOSrxLrhkfFxLPuxWuEFo7JK9drWNs3u21WnE04Cb
 4M6yVyHsh92qzPxjk/p2x07QxKdLMS89d5t8cCTb/K08kWgpkxq/Igi6pjBDAnwzPDC0
 wPISwg+t0Wc8Er8buoELrWNLPOTy3LoCn9Jt9E60NBNBoVm+63Y5VhHBWCUjr7fAOcsR
 sByI4WXXd+d2SJldb3B3p3492IVGtWxVUODbJ6pv1blqSRwn8p/KEKl5CEOtPRXBkuVY
 q9b5dzhpdYlykjPSdMsW86dTFYU7BMNaac5eBBEaHqoj+j6sBow5zfCBcuNt7D+DcbZ0
 cuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708551111; x=1709155911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6I/kQk2SJrf45BvogIDX/Yl21y/g0Vy+Ano204ZYEw0=;
 b=CXkEBw53A8S2cX3U8XdMnY2yrOTBjjNWGEQvKR4EMEJX829ZVQpBfXpayIVZ01kzFh
 L87vuYdzuoSAgq8YJUbPNGhFfLMYoP1qsitvQhfAMulWUIDFZy4uWRcBTquEyh3A3FCq
 lVOPoTRnhnU+OnYklPD28LbTSSRN3+q1yXlxFUBCXjqcV/MLV01UE+xZzdwSzSKeI9hT
 ZRpZFvdSjvwRTyBRx3N5SQwce3Myx4iGUkGiojie7i3MF8CCxQRvvT9gWQqvPUaIGrYm
 qyDLURDqxmbYrkJ9zHnnF+h7Mo2MD4Vusoev9sUR7DCmbA3EmjxUdW1re8j1TPRA93xk
 qaNw==
X-Gm-Message-State: AOJu0YxHld0SiJIUIFa9Lhl2kXFV5Ffm5YuSQC6/a5FJFt/BObY5Qbtw
 zzs86dz1idH/wYBHS24ScCmngnRTzmyGw61My7BNniXQol1LR6/tEUbnoWqiWke3JMn8Z4uqsjd
 w
X-Google-Smtp-Source: AGHT+IGJDT77tDxtTxlIMqCofDFFj6wVIMDgzZtltk12eHdQwes5NnjWfktuPIFcTrYOse27IFP0Gg==
X-Received: by 2002:a17:903:40c8:b0:1db:b09c:6d0 with SMTP id
 t8-20020a17090340c800b001dbb09c06d0mr17720063pld.64.1708551110980; 
 Wed, 21 Feb 2024 13:31:50 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 a19-20020a170902ee9300b001dbb0348733sm6618051pld.67.2024.02.21.13.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 13:31:50 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 1/9] trans_rvv.c.inc: mark_vs_dirty() before loads and
 stores
Date: Wed, 21 Feb 2024 18:31:32 -0300
Message-ID: <20240221213140.365232-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221213140.365232-1-dbarboza@ventanamicro.com>
References: <20240221213140.365232-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


