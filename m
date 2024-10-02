Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2903DCF6D28
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 13:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svzrB-0007Jk-S5; Wed, 02 Oct 2024 09:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1svzqx-0007F7-7Z
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:57:23 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1svzqv-0003XD-L7
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:57:18 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a8d0d82e76aso1078617566b.3
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 06:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1727877436; x=1728482236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dBJVgoGbVEBWCKNsYWowDSG5FlAgb+PmFPWTiOzZRq8=;
 b=cuFnPkRk4qJHhcbZwWPqeUddItysQQUi5grPE3vl1JeeuYexphDGxu4tkpP2VBdFle
 dWG3ZSLqzDEm867cnJGQeXRtubsCsSf74R3wSPHmGeJcEGvuM+kTYsf5yPTKI/k/J2Vu
 GTM8pxOnnWlmX9XS+i+OOTTME7TdY2FuevemquX73brmlJlO20CtHkBZPt5UlD9vWfQ9
 3KaeIBCl36PLH1GlNEIbKm2b7uEx/TvWLH3ywCnQLHgR6glwqxm/prMZR24cFVGEFjgc
 JsNIRcI5lO+0tVbzyWQy2pNhtEDjYQXFneXY9NfJMik7aKSiT7sKwWjfQn2bXKKSUu+n
 lKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727877436; x=1728482236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dBJVgoGbVEBWCKNsYWowDSG5FlAgb+PmFPWTiOzZRq8=;
 b=iHeK9tHZx8ppXIYGbPdLkmBSWiMqDzR1FpUaw/kVWHzAid2n4lbsYy32P7zVbLpQHx
 f+miZhlN/ErNotYrOEU6W2pwuaVkjLmt2WI6rwDY0x0xaUHnBd+cP+utOXhZ+yKxwIh+
 WtlvVr4frgsDLDekO2PZT3m1y09sGsQg6JL+URnxMkKaFR/XoT9sGj1xe3+vXQB70fkk
 sFyomHW+jXLkx6MiGADedF/crs0P+/PdLk2Uh17krsbW1vxWYJF01oIwTAkMDSLRRyxW
 hnM2xiN3ZN+P/xaI/ctJCitiqlR7J/Sfcg7EUUplCNftivipV/aalaPVc5JkLLNFk59E
 wdeg==
X-Gm-Message-State: AOJu0Yw8upGPJIu5M6wVszGspFtBQ6gCLbrFLKrQS269onGH7FbNy+B3
 /GwbptAQ/8aBxGdtBXloBSNMn3yJjk4cCFIRGyZiNC+FEF3I597czaIf2lei3AGTGEAQGedX0Mm
 7/AU=
X-Google-Smtp-Source: AGHT+IGVrRNaX3N4Uh0UxUnYWKoPCTGvCx05N/H4p7a6zbGPRvniW83vmxJP3sNMLJbGtnS7ZLqIaw==
X-Received: by 2002:a17:907:989:b0:a7a:a892:8e05 with SMTP id
 a640c23a62f3a-a98f8269b77mr336659866b.33.1727877435666; 
 Wed, 02 Oct 2024 06:57:15 -0700 (PDT)
Received: from paolo-laptop-amd.sou.embecosm-corp.com ([212.69.42.53])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c299ac8esm869975266b.222.2024.10.02.06.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 06:57:15 -0700 (PDT)
From: Paolo Savini <paolo.savini@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Savini <paolo.savini@embecosm.com>,
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>
Subject: [RFC v2 1/2] target/riscv: rvv: reduce the overhead for simple RISC-V
 vector unit-stride loads and stores
Date: Wed,  2 Oct 2024 14:57:07 +0100
Message-ID: <20241002135708.99146-2-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241002135708.99146-1-paolo.savini@embecosm.com>
References: <20241002135708.99146-1-paolo.savini@embecosm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=paolo.savini@embecosm.com; helo=mail-ej1-x62b.google.com
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

From: Helene CHELIN <helene.chelin@embecosm.com>

This patch improves the performance of the emulation of the RVV unit-stride
loads and stores in the following cases:

- when the data being loaded/stored per iteration amounts to 8 bytes or less.
- when the vector length is 16 bytes (VLEN=128) and there's no grouping of the
  vector registers (LMUL=1).

The optimization consists of avoiding the overhead of probing the RAM of the
host machine and doing a loop load/store on the input data grouped in chunks
of as many bytes as possible (8,4,2,1 bytes).

Co-authored-by: Helene CHELIN <helene.chelin@embecosm.com>
Co-authored-by: Paolo Savini <paolo.savini@embecosm.com>

Signed-off-by: Helene CHELIN <helene.chelin@embecosm.com>
---
 target/riscv/vector_helper.c | 46 ++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 29849a8b66..4b444c6bc5 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -633,6 +633,52 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
 
     VSTART_CHECK_EARLY_EXIT(env);
 
+    /* For data sizes <= 64 bits and for LMUL=1 with VLEN=128 bits we get a
+     * better performance by doing a simple simulation of the load/store
+     * without the overhead of prodding the host RAM */
+    if ((nf == 1) && ((evl << log2_esz) <= 8 ||
+	((vext_lmul(desc) == 0) && (simd_maxsz(desc) == 16)))) {
+
+	uint32_t evl_b = evl << log2_esz;
+
+        for (uint32_t j = env->vstart; j < evl_b;) {
+	    addr = base + j;
+            if ((evl_b - j) >= 8) {
+                if (is_load)
+                    lde_d_tlb(env, adjust_addr(env, addr), j, vd, ra);
+                else
+                    ste_d_tlb(env, adjust_addr(env, addr), j, vd, ra);
+                j += 8;
+            }
+            else if ((evl_b - j) >= 4) {
+                if (is_load)
+                    lde_w_tlb(env, adjust_addr(env, addr), j, vd, ra);
+                else
+                    ste_w_tlb(env, adjust_addr(env, addr), j, vd, ra);
+                j += 4;
+            }
+            else if ((evl_b - j) >= 2) {
+                if (is_load)
+                    lde_h_tlb(env, adjust_addr(env, addr), j, vd, ra);
+                else
+                    ste_h_tlb(env, adjust_addr(env, addr), j, vd, ra);
+                j += 2;
+            }
+            else {
+                if (is_load)
+                    lde_b_tlb(env, adjust_addr(env, addr), j, vd, ra);
+                else
+                    ste_b_tlb(env, adjust_addr(env, addr), j, vd, ra);
+                j += 1;
+            }
+        }
+
+        env->vstart = 0;
+        vext_set_tail_elems_1s(evl, vd, desc, nf, esz, max_elems);
+        return;
+    }
+
+
     vext_cont_ldst_elements(&info, base, env->vreg, env->vstart, evl, desc,
                             log2_esz, false);
     /* Probe the page(s).  Exit with exception for any invalid page. */
-- 
2.17.1


