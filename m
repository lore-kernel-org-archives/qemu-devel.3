Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741E7C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 17:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhuvv-0007p7-KO; Wed, 06 Mar 2024 12:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhuvn-0007jA-IQ
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:19:53 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhuvi-0000Zg-Mj
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:19:50 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dc0d11d1b7so378935ad.2
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 09:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709745580; x=1710350380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kyujL+gBJnyXc4btQWbM8dsePlAWzhj7CULgQEyCEx4=;
 b=Z6T+RA1u/sSCcQv0SpirXSi/XRp8xvPuYgKJ7tbS8HK76sZbZcy/F0OVPLRYwe1BO0
 /+MICV2uKZxsfpG4oTNB0ytMDZ46FAEy4EXWTKvuv1SR+ZzQhbYHY7Mg0qfQE/zTGfJb
 c1Y24o/q1XuUy34Vys4JqRkmnLLUzuH5ONaBx6lCnLMmF2v11V/NVWYnq7TpgB6IOvla
 uNYudu+Koy8nA5dwLMnZU0x+Bk7KxTHuI3HwfX4vcZoKsC7pwSvgTScDDe0GmWab66Mo
 GmUPQ0CaHFRuJBr49lbvxNk10IeGrmumDa56uyS4gee+MGQ3y9jYjEl6uQNW9GgDuzrJ
 MveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709745580; x=1710350380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kyujL+gBJnyXc4btQWbM8dsePlAWzhj7CULgQEyCEx4=;
 b=XPjkgs6Cs/Redl5wMpAAKPu1Q3HIl/653yVhzSDm6nf/Z0FBu5nVJR/1xWZZB+LTAT
 /5xJVv8qXvJY9sDb8FDQNgW/QVDlFuXcE1XS4udcPL1nnu/3Ryrponx+Aaclro+WWEgZ
 fbG4x4hnk29cQ8yIFHVDFGV+yRCAXt2eHirCnwro7FhhTcQCrLVIh9tpCT6HGUn35Wkz
 dOFndvovY8D3KfJRa2pN16gNvcs++xZ0DU51sda4e7q7+0Is2NtQ2KevdGXBDS8zmzYd
 RRu4CWd1+4ecEvQQ1inQGcHPS2K5du4aRpu1ABIdoGdoses4ZNoKGCbU91zXT5JuoAEp
 4ecw==
X-Gm-Message-State: AOJu0YzBD0kniET9tVbFNr49I0T75F4GK0a/b+znbCp+U3kQXlM2i2Ba
 2tyqlhSSvJkOSNfbBnnR9KnK6V6J/FuGGQfL8n8RF/bOLqtaqhyv3Jrdvbu3XouJyDUfsN9Z++I
 6
X-Google-Smtp-Source: AGHT+IHKwk9FU5UHVHqZe6EyWawkYE/Tu4Q6EETkYSJFRlthHm75kmynDsB47Mu0JP+X7bZYlfp/HQ==
X-Received: by 2002:a17:902:d4d1:b0:1dc:fce2:3084 with SMTP id
 o17-20020a170902d4d100b001dcfce23084mr7214693plg.7.1709745580406; 
 Wed, 06 Mar 2024 09:19:40 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a170902c71100b001dbb6fef41fsm12869712plp.257.2024.03.06.09.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 09:19:40 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 1/9] trans_rvv.c.inc: mark_vs_dirty() before loads and
 stores
Date: Wed,  6 Mar 2024 14:19:24 -0300
Message-ID: <20240306171932.549549-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240306171932.549549-1-dbarboza@ventanamicro.com>
References: <20240306171932.549549-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 742008f58b..b838b8ea5b 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -652,16 +652,14 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
     }
 
+    mark_vs_dirty(s);
+
     fn(dest, mask, base, tcg_env, desc);
 
     if (!is_store && s->ztso) {
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
     }
 
-    if (!is_store) {
-        mark_vs_dirty(s);
-    }
-
     gen_set_label(over);
     return true;
 }
@@ -817,11 +815,9 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
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
@@ -924,11 +920,9 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
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
@@ -1122,11 +1116,10 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
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


