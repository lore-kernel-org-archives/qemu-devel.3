Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28973C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 19:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVl8-0006Pa-VQ; Tue, 20 Feb 2024 14:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcVl1-0006Oo-F3
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:26:25 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcVkx-0006UE-6F
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:26:22 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e0f803d9dfso2998819b3a.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 11:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708457177; x=1709061977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FPdDCmWzGgfuhWMKdviQmAa6vh4ca66KNyBNGlWXFxg=;
 b=hLeTh7K2qP7zMg6GCvME8XhKG1hD/6XZ31bGMP4zNHiwV0FiuBQoRec7Hd37ml1vXn
 02zgLm6yj0Er2ukX24M/wYXAVe6Mrk5G/WKTnnuEsGrjZY0ryHBuIDge1NGCzWCjoAXz
 /HegcN8Wa0+MAvUDFybDhZVhXTmT4YBPFl0lWoB7dl4VNilvX9nXFVPTuNJ6zgm8p5Mw
 nzpbd2gT6lwsO+uDbAQ+wSG3X45BUpm7E/MIzakJqoqZjmm05LU1PnQ5xmEUq/t6pTZ7
 c877/kRIri0VPz78+56Zlx+AqauwJnDzmucD6gwwE7tNPMx8qdxvyGMMGoUaEbZbfsvW
 xamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708457177; x=1709061977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FPdDCmWzGgfuhWMKdviQmAa6vh4ca66KNyBNGlWXFxg=;
 b=q5Vt36DLEKpNMQSX50EZ0ivmYc+P3ZkpHhB4KC8YAMbbkVcc73icSME/wm8szep3ec
 LgVvqjZQS0hXa2lW4I7hCw0/TvHVu8R47sg01DB+0hm5IkTnhbDevCc3laxhdReDaaA4
 QSCIeMx7DcOZI2sXeAqUInFfJr/1azL++4B3lzAifRLXQ1ELmmH0Uc1hiPPoSPUZ+pMR
 2l0N33iYuCGQ1x0ec7HydLh/9rxmqJxcXrlreZn7agKNXMUYMKbI8E3Xg6zFpD8iAPXt
 uzc8kklBDB7hkoCHzl8/Mw3azNJhXyF+pbkr8BKS3I1WeQjTzhUSVyo3ehA/yDVDQsq4
 AOSA==
X-Gm-Message-State: AOJu0YyLQMvFKIJhe4cXSUIk+RtRLJHo/8ACRMqS1y6JGUUeAzWoMAKv
 5MiXfQK0EetuhuxNkIVaIN/H5STSI8SxbGeHSc9GPwE+EmK+AoXUBLpapFs3opw70lqLVrCCvIO
 j
X-Google-Smtp-Source: AGHT+IEO3eJ6R7osdAOgEp3riBiizINxcCnm0ilai+noqN8M12U/Y5xH92JXrcWGs9lBIYDHP/8uVA==
X-Received: by 2002:a05:6a20:4f05:b0:19e:8b31:f1ae with SMTP id
 gi5-20020a056a204f0500b0019e8b31f1aemr15316010pzb.29.1708457177195; 
 Tue, 20 Feb 2024 11:26:17 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 i73-20020a636d4c000000b005b458aa0541sm6943005pgc.15.2024.02.20.11.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 11:26:16 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 1/5] trans_rvv.c.inc: mark_vs_dirty() before stores
Date: Tue, 20 Feb 2024 16:26:03 -0300
Message-ID: <20240220192607.141880-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220192607.141880-1-dbarboza@ventanamicro.com>
References: <20240220192607.141880-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
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

Do a mark_vs_dirty() before store operations. Keep the mark_vs_dirty()
call at the end for loads - the function is a no-op if mstatus_vs is
already set to EXT_STATUS_DIRTY so there's no hurt in store functions
calling it twice.

[1] https://lore.kernel.org/qemu-riscv/72c7503b-0f43-44b8-aa82-fbafed2aac0c@linaro.org/

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 29 +++++++++++++++----------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 9e101ab434..2065e9064e 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -636,12 +636,13 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
     tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
 
-    fn(dest, mask, base, tcg_env, desc);
-
-    if (!is_store) {
+    if (is_store) {
         mark_vs_dirty(s);
     }
 
+    fn(dest, mask, base, tcg_env, desc);
+
+    mark_vs_dirty(s);
     gen_set_label(over);
     return true;
 }
@@ -797,12 +798,13 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
     tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
     tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
 
-    fn(dest, mask, base, stride, tcg_env, desc);
-
-    if (!is_store) {
+    if (is_store) {
         mark_vs_dirty(s);
     }
 
+    fn(dest, mask, base, stride, tcg_env, desc);
+
+    mark_vs_dirty(s);
     gen_set_label(over);
     return true;
 }
@@ -904,12 +906,13 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     tcg_gen_addi_ptr(index, tcg_env, vreg_ofs(s, vs2));
     tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
 
-    fn(dest, mask, base, index, tcg_env, desc);
-
-    if (!is_store) {
+    if (is_store) {
         mark_vs_dirty(s);
     }
 
+    fn(dest, mask, base, index, tcg_env, desc);
+
+    mark_vs_dirty(s);
     gen_set_label(over);
     return true;
 }
@@ -1102,11 +1105,13 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
     base = get_gpr(s, rs1, EXT_NONE);
     tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
 
-    fn(dest, base, tcg_env, desc);
-
-    if (!is_store) {
+    if (is_store) {
         mark_vs_dirty(s);
     }
+
+    fn(dest, base, tcg_env, desc);
+
+    mark_vs_dirty(s);
     gen_set_label(over);
 
     return true;
-- 
2.43.2


