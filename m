Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B4BC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBxc-0001Oo-H7; Wed, 28 May 2025 04:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvn-0007wl-Ek
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:36 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvl-0005G9-FA
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:35 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-441c99459e9so27414225e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420072; x=1749024872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sZ6vIxBu6FW/KD0BR1BtFe96Giz9M9xn+TA9iSEi6Lo=;
 b=kiiJxqYP9YTY+tEduQniU+a6gffEfYwQwW4WFL2/9nbLQFV54SKZ6z1AaKG+8gxkSj
 5WM+K9x+5DB/9y+9j5ixeyBCX3EL+Uqls5oUJ7+cg0cMUICndAhWw6Y+Q+J6tiKnewf+
 MtJ1DnPoR+yKvwk60RRcdAYYghhEmDoAItULBX21LC3MAuVwzaCkXPjg5V5vjE6cSP2P
 IKUY8QSFhV/5ehL0nlTau2teH6mgSTiYp+n61dB3vc11oeSviCKCmkrjTTP1w0ZS/2zV
 gSC6N5FZ29fnhBB2VKt7lVWToNtJEQJbtwbP+HIXoX7s3YFFZxGRS8diMYLE+gMrszD9
 rTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420072; x=1749024872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sZ6vIxBu6FW/KD0BR1BtFe96Giz9M9xn+TA9iSEi6Lo=;
 b=lMKIRG3RucRH9BXZy2i7D05GZ50scpWDYDGcz9HQ/xcMlX2aC8Ch0ibW8A803IzOKY
 vRjS2CjXE3Utt+bUbbwX2uKBST43mG3HAFocGrvQjAiYTvXJi/Yz33F0LWB8/3WLD2zl
 0aFiOvfbokq58VIp02hG4Y/lU/rwZXCCc7hMiuZwHUx/7Cns1kAyIdURWvU28CAXgJC9
 EFQSku7i56RH3x5fyPqQz1r2y5AHrqMjvBw1LnmEUj1abiAjEdu7YzjoTJ0x0Erwkibv
 Nn1IofqlFpkTfUYmjuraBZuMjDHs6E+KVf6vvIIsYkb+idHDHGZLCZ47TdEa/TzHRjy8
 UAWQ==
X-Gm-Message-State: AOJu0YzD66kLGXHJCL5e+R82gQivX9Lr+CxQfZiUBLMOZzWPm3K1jbxt
 TBLCZ2/zo6hjEoJ1EPfCLI5csZWpDEfO8Zifip8R8tLvAluy6cqGsBU2c6Z/xkyZpTZEFRePc4q
 LWGRFUuZIsw==
X-Gm-Gg: ASbGnctoxfE6M6Qjgu6EbvLBNn78rxNoPNbKQphoJ+itXxLGvCVF6LbqrzyRKNRv7MO
 TvMw/MMjTFff5rA4y1toXVJ/nWhDwk9wTXYLRTAVT3VgdkM+qNKCQBCffTZX+2CyhquPB4QzuRM
 c/LkuL2/ZbAosrzANGgbKdYpl6F6xzdtKjYM/QKS3H9oo105MYTXb9IZtAF2qHoXeMxp/dnkwCM
 ETPOa/hxVtd/Vutsb9DYL9CWpMrXx/gzgSIXUNBBQYLYJJ2IDwH74CVvXEMbamoXYI3uAMd3GnX
 lYtXfEsinGyrn+6mY7BD+1kmQC5Hz8ZCs7D82n7Ml81Drh6x19SB0mPm
X-Google-Smtp-Source: AGHT+IGtqbcS/sBD1oun10YafHHDwyXTqhjySXP78345dQDxv1VJUgwienYJTXBBgttNUaVMDlQEag==
X-Received: by 2002:a05:600c:1d15:b0:43c:fe90:1282 with SMTP id
 5b1f17b1804b1-450725458d3mr8625985e9.7.1748420071807; 
 Wed, 28 May 2025 01:14:31 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/28] tcg: Drop TCGContext.tlb_dyn_max_bits
Date: Wed, 28 May 2025 09:13:56 +0100
Message-ID: <20250528081410.157251-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This was an extremely minor optimization for aarch64
and x86_64, to use a 32-bit AND instruction when the
guest softmmu tlb maximum was sufficiently small.
Both hosts can simply use a 64-bit AND insn instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h            | 1 -
 accel/tcg/translate-all.c    | 2 --
 tcg/aarch64/tcg-target.c.inc | 6 +-----
 tcg/i386/tcg-target.c.inc    | 6 ++----
 4 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 3fa5a7aed2..e440c889c8 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -368,7 +368,6 @@ struct TCGContext {
 
     int page_mask;
     uint8_t page_bits;
-    uint8_t tlb_dyn_max_bits;
     TCGBar guest_mo;
 
     TCGRegSet reserved_regs;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 451b383aa8..6735a40ade 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -24,7 +24,6 @@
 #include "tcg/tcg.h"
 #include "exec/mmap-lock.h"
 #include "tb-internal.h"
-#include "tlb-bounds.h"
 #include "exec/tb-flush.h"
 #include "qemu/cacheinfo.h"
 #include "qemu/target-info.h"
@@ -316,7 +315,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
 #ifdef CONFIG_SOFTMMU
     tcg_ctx->page_bits = TARGET_PAGE_BITS;
     tcg_ctx->page_mask = TARGET_PAGE_MASK;
-    tcg_ctx->tlb_dyn_max_bits = CPU_TLB_DYN_MAX_BITS;
 #endif
     tcg_ctx->guest_mo = cpu->cc->tcg_ops->guest_default_memory_order;
 
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 4cb647cb34..6356a81c2a 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1661,7 +1661,6 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         unsigned s_mask = (1u << s_bits) - 1;
         unsigned mem_index = get_mmuidx(oi);
         TCGReg addr_adj;
-        TCGType mask_type;
         uint64_t compare_mask;
 
         ldst = new_ldst_label(s);
@@ -1669,9 +1668,6 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst->oi = oi;
         ldst->addr_reg = addr_reg;
 
-        mask_type = (s->page_bits + s->tlb_dyn_max_bits > 32
-                     ? TCG_TYPE_I64 : TCG_TYPE_I32);
-
         /* Load cpu->neg.tlb.f[mmu_idx].{mask,table} into {tmp0,tmp1}. */
         QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
         QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 8);
@@ -1679,7 +1675,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
                      tlb_mask_table_ofs(s, mem_index), 1, 0);
 
         /* Extract the TLB index from the address into X0.  */
-        tcg_out_insn(s, 3502S, AND_LSR, mask_type == TCG_TYPE_I64,
+        tcg_out_insn(s, 3502S, AND_LSR, TCG_TYPE_I64,
                      TCG_REG_TMP0, TCG_REG_TMP0, addr_reg,
                      s->page_bits - CPU_TLB_ENTRY_BITS);
 
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 09fce27b06..2990912080 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2199,10 +2199,8 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             trexw = (ttype == TCG_TYPE_I32 ? 0 : P_REXW);
             if (TCG_TYPE_PTR == TCG_TYPE_I64) {
                 hrexw = P_REXW;
-                if (s->page_bits + s->tlb_dyn_max_bits > 32) {
-                    tlbtype = TCG_TYPE_I64;
-                    tlbrexw = P_REXW;
-                }
+                tlbtype = TCG_TYPE_I64;
+                tlbrexw = P_REXW;
             }
         }
 
-- 
2.43.0


