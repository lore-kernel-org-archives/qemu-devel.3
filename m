Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A90C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 15:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU6sp-0006Wd-Dm; Wed, 17 Jul 2024 11:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1sU6fm-0004d1-Gk
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:34:31 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1sU6fk-0004pA-Lc
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:34:30 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-367990aaef3so4022696f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 08:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1721230467; x=1721835267; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dBJVgoGbVEBWCKNsYWowDSG5FlAgb+PmFPWTiOzZRq8=;
 b=KpJWHlvIeDzjgigwjWrZW0APt/gx/REH+NbAf/fTxNBNK50lVVdqAJmZDw9Vu/Xw9r
 aB1W4NbP836H+Gu4feynR2G9mpBHKRalEdfNTRRcijzL5YkahT0v4RyVglpYZ2WosVXQ
 MsC1PHWner6Tnj0rZoE55Cv7tIlrHLA63Vr4DR50mX8NMThOP74CWgRo1v+sFy/6LINY
 QYamBR3CHT267wzmDaIsrjf0SPw+q6Lsg+/Q0clJdDyrpiW3At3IwAsnlzzlT0vedHcB
 S4brd1x54VtambrJ1taaGrhZPN5XK8k0j+NPscDg/tKcYbp1dUjqPeNOWCBbJuKF2oyd
 owmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721230467; x=1721835267;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dBJVgoGbVEBWCKNsYWowDSG5FlAgb+PmFPWTiOzZRq8=;
 b=SR9/ypMJLuy9UiY8O4jVMhiEFhGO67GUuvk2oHJh3vGHHwohNZzbOZJUgxoD2Vioj8
 takYa7ASWmPXVLhZUDtTxokeSqdaiB6EpPpPo2K1VxQC3vkpV1apFzY2Ku7XxkxBTHv5
 5kBgS/9ZQeuGokWhOM15+QQzogvb3owILIXvwSPxyErw/TRF90xXIkWxlB83q/mAN5P8
 ih6eJumKDdjmnU0c8zIpK4+T7j5hgUFhooWNCXrUtjzpwTfcdinA23iEBwHoaAX/yeAe
 ro6YgdMJw6d3cN5ck9taiCsa8WzlwekuJjJ7g1ALQ35z3BtXiuvohFACyBNcOG1tZbuw
 Lf2w==
X-Gm-Message-State: AOJu0YyWwxAqY4Dy/vWYO6tv+qIWOpprUEKyl+aNX3NKnc4GK9V5aiv1
 dJVa9mRRszBMYt7bWjAysi3wOt5z+gBTiNlvObnQw4moM+dEYAh4WeSgSpJYPwR+xQCrNFJuzRw
 W8IP9vA==
X-Google-Smtp-Source: AGHT+IFZY/LMmxUFu5e7QOXL/isaeNSjq2sEVYQiXcwxYqZwkUV9XayT8RKL1nPF76r/y5EIw36+WQ==
X-Received: by 2002:a05:6000:1449:b0:367:9224:9621 with SMTP id
 ffacd0b85a97d-36831652dbemr2032820f8f.31.1721230466778; 
 Wed, 17 Jul 2024 08:34:26 -0700 (PDT)
Received: from paolo-ThinkPad-T490.sou.embecosm-corp.com ([212.69.42.53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427c779839bsm2369475e9.7.2024.07.17.08.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:34:26 -0700 (PDT)
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
 Helene Chelin <helene.chelin@embecosm.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC 1/2] target/riscv: rvv: reduce the overhead for simple RISC-V
 vector unit-stride loads and stores
Date: Wed, 17 Jul 2024 16:30:39 +0100
Message-Id: <20240717153040.11073-2-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240717153040.11073-1-paolo.savini@embecosm.com>
References: <20240717153040.11073-1-paolo.savini@embecosm.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Jul 2024 11:47:57 -0400
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


