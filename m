Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85600C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkso-0001cB-FO; Sun, 27 Sep 2026 05:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkri-0003Gr-Vm
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:08:11 -0400
Received: from mail-pj2-x0d.google.com ([2607:f8b0:4864:39::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrg-0008Jv-7r
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:08:10 -0400
Received: by mail-pj2-x0d.google.com with SMTP id
 98e67ed59e1d1-3a0abca97c0so1115244a91.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790500087; x=1791104887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p2GTV+O9/n8SvpmsgHiFDR5+m1ogdREIlJhufmWgbrk=;
 b=hKKUQhLCmkJlbDdIm3vfzImqjSfXYfxzN7hNZLoCrC5glyekr9QV+aOgO+j/43q/PN
 nFetgbwciPdh3QSq3oXx3VUP5tSrNlrEoTb1NiOaanp3l61lT/ZUDHOddg4Izo/fWVMy
 36ODVlTXzaV1rSJFNDbla/L0HQISSR9s9JubSJAXS9dYD8gbkuPaTPxpxa0uAZVeQgXc
 +bwCmeAZcQkUaHX2M1oku8Y9l+0KUjEbpmhELDTeAptyr1z4MHUCWUYeL++RiPwFlrhg
 YLvEXyfMoya7aE1HU1QXO6EhmW9aUGdI2ptGn6OAH2770pln0tmSI/eYDXsfM5hDi0P1
 PrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790500087; x=1791104887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p2GTV+O9/n8SvpmsgHiFDR5+m1ogdREIlJhufmWgbrk=;
 b=D7giCIxAMBu93L7k4rKnSLd7w2l91aijo3nUFJ0j7lFGbs7q0M3pDV4sJliuJHogd4
 Vvz0TL3lgw6PqyG6cyuxSBUdkPNuPOWscRmDSOosR338MdjR4cDQ/AEUxIh5YlftTxvQ
 J1bun+psYgzkNDKkJRSMIVpqejfd/RjDx4zLnJUTEvv8I0O+Ad37pPQW6CdFjTJKRQMw
 CiK6BjZ3YmyZ1R6F1j1RCF266Ye7nU9ZKnfkLdbAP8s8yNPuVuP2j+WIoB5j3cIIx63J
 0ztIqMeP8QdFjD2BQhx3e33HQtGUlsXFJlVRNASYvLkBdsFdz81+ovtCKJta/kq7SEOX
 TT/Q==
X-Gm-Message-State: AFq9FYLG/uZLo6hkOkyu+OhfVwDA8uZKGol80kvPM3jsKnjGcRBWPyg3
 VlX1FfmJ7E0XGGsuYbnuCxlcOxgSrYQS6emwUvGiCz7mvEHSvrsgSEz+nHgUREMPh3ZG4pljpn+
 oyBrU
X-Gm-Gg: AYBFou0WpHyxt3cHw2jWDQlWUj97oCKYeDUxEFdWRPKspavFiSYZ/i4FAAjaDipS6g3
 gzl56VIw2xWmqdBDm7MRM8Djvzn5wJFfOMOI+csIcbYqR6LH2q4ZOZKRdcqacXrSRRH4ayfTsdM
 zm7W+1FL6NZlv1CjFwXmdHIkIoj7+GIxWEG84r6he/f4QepMznr40ejyipBnGHSOFUhtGXwC6K8
 gg4JSzDjrZm1MLB2AScTjzKiIt0AMH1zY2HAwGhKE3iSIaWymfRDAG6tqCAZIBYWS3i09nP0SLC
 ygttorxE1bUGhxdMigEfa8iwTyUfK6LcpMeCHcYG2UNCWNGhXHqFa4Th+rT9dSo5UzLuOmH1Vjf
 CasKxMPkZH3mDFJQa9EudxHFSo9nV/IFBxuXacppF/EG9N/AJ6bU4jJ3lzyZAbQ+V9Ol83YdL6a
 CiyQ65yRyTHHY5141AdaoDyCszHIBA1XThzYhFHyy95+zXMjzElK2px8eYP5A6Kg3aQJArvt6R7
 0tYmkjUBmqPE9Mw7J0AK7YLMsBgEpQLqohKFySH
X-Received: by 2002:a17:90b:2b44:b0:3a0:c276:1ed1 with SMTP id
 98e67ed59e1d1-3a0c27622bamr4576051a91.3.1790500086737; 
 Sun, 27 Sep 2026 02:08:06 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e7036e3bsm7144984a91.13.2026.09.27.02.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:08:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 101/101] tcg: Annontate functions in tcg-op-common.h with
 QEMU_*_NONNULL
Date: Sun, 27 Sep 2026 02:00:11 -0700
Message-ID: <20260927090011.10724-102-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h | 188 +++++++++++++++++++-----------------
 1 file changed, 99 insertions(+), 89 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index bc96c02aaea..ec0b7d37684 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -12,24 +12,24 @@
 #include "exec/helper-proto-common.h"
 #include "exec/helper-gen-common.h"
 
-TCGv_i32 tcg_constant_i32(int32_t val);
-TCGv_i64 tcg_constant_i64(int64_t val);
-TCGv_vaddr tcg_constant_vaddr(uintptr_t val);
-TCGv_vec tcg_constant_vec(TCGType type, unsigned vece, int64_t val);
-TCGv_vec tcg_constant_vec_matching(TCGv_vec match, unsigned vece, int64_t val);
+QEMU_RET_NONNULL TCGv_i32 tcg_constant_i32(int32_t val);
+QEMU_RET_NONNULL TCGv_i64 tcg_constant_i64(int64_t val);
+QEMU_RET_NONNULL TCGv_vaddr tcg_constant_vaddr(uintptr_t val);
+QEMU_RET_NONNULL TCGv_vec tcg_constant_vec(TCGType type, unsigned vece, int64_t val);
+QEMU_RET_NONNULL TCGv_vec tcg_constant_vec_matching(TCGv_vec match, unsigned vece, int64_t val);
 
-TCGv_i128 tcg_zero_i128(void);
+QEMU_RET_NONNULL TCGv_i128 tcg_zero_i128(void);
 
-TCGv_i32 tcg_temp_new_i32(void);
-TCGv_i64 tcg_temp_new_i64(void);
-TCGv_ptr tcg_temp_new_ptr(void);
-TCGv_i128 tcg_temp_new_i128(void);
-TCGv_vec tcg_temp_new_vec(TCGType type);
-TCGv_vec tcg_temp_new_vec_matching(TCGv_vec match);
+QEMU_RET_NONNULL TCGv_i32 tcg_temp_new_i32(void);
+QEMU_RET_NONNULL TCGv_i64 tcg_temp_new_i64(void);
+QEMU_RET_NONNULL TCGv_ptr tcg_temp_new_ptr(void);
+QEMU_RET_NONNULL TCGv_i128 tcg_temp_new_i128(void);
+QEMU_RET_NONNULL TCGv_vec tcg_temp_new_vec(TCGType type);
+QEMU_RET_NONNULL TCGv_vec tcg_temp_new_vec_matching(TCGv_vec match);
 
-TCGv_i32 tcg_global_mem_new_i32(TCGv_ptr reg, intptr_t off, const char *name);
-TCGv_i64 tcg_global_mem_new_i64(TCGv_ptr reg, intptr_t off, const char *name);
-TCGv_ptr tcg_global_mem_new_ptr(TCGv_ptr reg, intptr_t off, const char *name);
+QEMU_RET_NONNULL TCGv_i32 tcg_global_mem_new_i32(TCGv_ptr reg, intptr_t off, const char *name);
+QEMU_RET_NONNULL TCGv_i64 tcg_global_mem_new_i64(TCGv_ptr reg, intptr_t off, const char *name);
+QEMU_RET_NONNULL TCGv_ptr tcg_global_mem_new_ptr(TCGv_ptr reg, intptr_t off, const char *name);
 
 /* Generic ops.  */
 static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1,
@@ -41,8 +41,8 @@ static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1,
     tcg_set_insn_start_param(op, 2, a2);
 }
 
-void gen_set_label(TCGLabel *l);
-void tcg_gen_br(TCGLabel *l);
+QEMU_ARG_NONNULL void gen_set_label(TCGLabel *l);
+QEMU_ARG_NONNULL void tcg_gen_br(TCGLabel *l);
 void tcg_gen_mb(TCGBar);
 
 /**
@@ -86,7 +86,7 @@ void tcg_gen_goto_tb(unsigned idx);
 void tcg_gen_lookup_and_goto_ptr(void);
 
 void tcg_gen_plugin_cb(unsigned from);
-void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
+QEMU_ARG_NONNULL void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /*
  * Construct operations from templates.
@@ -135,23 +135,23 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
+QEMU_ARG_NONNULL void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
+QEMU_ARG_NONNULL void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
+QEMU_ARG_NONNULL void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
+QEMU_ARG_NONNULL void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
-void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
-void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
-void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
+QEMU_ARG_NONNULL void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
+QEMU_ARG_NONNULL void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
+QEMU_ARG_NONNULL void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
+QEMU_ARG_NONNULL void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
+QEMU_ARG_NONNULL void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
+QEMU_ARG_NONNULL void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
+QEMU_ARG_NONNULL void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
+QEMU_ARG_NONNULL void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
+QEMU_ARG_NONNULL void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
+QEMU_ARG_NONNULL void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
@@ -160,96 +160,106 @@ void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 
 /* Size changing operations.  */
 
-void tcg_gen_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg);
-void tcg_gen_ext_i32_i64(TCGv_i64 ret, TCGv_i32 arg);
-void tcg_gen_concat_i32_i64(TCGv_i64 dest, TCGv_i32 low, TCGv_i32 high);
-void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg);
-void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg);
-void tcg_gen_extr_i64_i32(TCGv_i32 lo, TCGv_i32 hi, TCGv_i64 arg);
-void tcg_gen_extr32_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i64 arg);
-void tcg_gen_concat32_i64(TCGv_i64 ret, TCGv_i64 lo, TCGv_i64 hi);
+QEMU_ARG_NONNULL void tcg_gen_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg);
+QEMU_ARG_NONNULL void tcg_gen_ext_i32_i64(TCGv_i64 ret, TCGv_i32 arg);
+QEMU_ARG_NONNULL void tcg_gen_concat_i32_i64(TCGv_i64 dest, TCGv_i32 low, TCGv_i32 high);
+QEMU_ARG_NONNULL void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg);
+QEMU_ARG_NONNULL void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg);
+QEMU_ARG_NONNULL void tcg_gen_extr_i64_i32(TCGv_i32 lo, TCGv_i32 hi, TCGv_i64 arg);
+QEMU_ARG_NONNULL void tcg_gen_extr32_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i64 arg);
+QEMU_ARG_NONNULL void tcg_gen_concat32_i64(TCGv_i64 ret, TCGv_i64 lo, TCGv_i64 hi);
 
-void tcg_gen_extr_i128_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i128 arg);
-void tcg_gen_concat_i64_i128(TCGv_i128 ret, TCGv_i64 lo, TCGv_i64 hi);
+QEMU_ARG_NONNULL void tcg_gen_extr_i128_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i128 arg);
+QEMU_ARG_NONNULL void tcg_gen_concat_i64_i128(TCGv_i128 ret, TCGv_i64 lo, TCGv_i64 hi);
 
 /* 128 bit ops */
 
-void tcg_gen_mov_i128(TCGv_i128 dst, TCGv_i128 src);
-void tcg_gen_ld_i128(TCGv_i128 ret, TCGv_ptr base, tcg_target_long offset);
-void tcg_gen_st_i128(TCGv_i128 val, TCGv_ptr base, tcg_target_long offset);
+QEMU_ARG_NONNULL void tcg_gen_mov_i128(TCGv_i128 dst, TCGv_i128 src);
+QEMU_ARG_NONNULL void tcg_gen_ld_i128(TCGv_i128 ret, TCGv_ptr base, tcg_target_long offset);
+QEMU_ARG_NONNULL void tcg_gen_st_i128(TCGv_i128 val, TCGv_ptr base, tcg_target_long offset);
 
+QEMU_ARG_NONNULL
 void tcg_gen_qemu_ld_chk_i128(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_qemu_st_chk_i128(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
 
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_cmpxchg_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
                                      TCGv_i128, TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_nonatomic_cmpxchg_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
                                         TCGv_i128, TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_xchg_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
                                   TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_fetch_and_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
                                        TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_fetch_or_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
                                       TCGArg, MemOp, TCGType);
 
 /* Vector ops */
 
-void tcg_gen_mov_vec(TCGv_vec, TCGv_vec);
-void tcg_gen_dup_i32_vec(unsigned vece, TCGv_vec, TCGv_i32);
-void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec, TCGv_i64);
-void tcg_gen_dup_mem_vec(unsigned vece, TCGv_vec, TCGv_ptr, tcg_target_long);
-void tcg_gen_dupi_vec(unsigned vece, TCGv_vec, uint64_t);
-void tcg_gen_add_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_sub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_mul_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_and_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_or_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_xor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_andc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_orc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_nand_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_nor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_eqv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
-void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
-void tcg_gen_abs_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
-void tcg_gen_ssadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_usadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_sssub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_ussub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_smin_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_umin_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_smax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_umax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_mov_vec(TCGv_vec, TCGv_vec);
+QEMU_ARG_NONNULL void tcg_gen_dup_i32_vec(unsigned vece, TCGv_vec, TCGv_i32);
+QEMU_ARG_NONNULL void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec, TCGv_i64);
+QEMU_ARG_NONNULL void tcg_gen_dup_mem_vec(unsigned vece, TCGv_vec, TCGv_ptr, tcg_target_long);
+QEMU_ARG_NONNULL void tcg_gen_dupi_vec(unsigned vece, TCGv_vec, uint64_t);
+QEMU_ARG_NONNULL void tcg_gen_add_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_sub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_mul_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_and_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_or_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_xor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_andc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_orc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_nand_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_nor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_eqv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
+QEMU_ARG_NONNULL void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
+QEMU_ARG_NONNULL void tcg_gen_abs_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
+QEMU_ARG_NONNULL void tcg_gen_ssadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_usadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_sssub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_ussub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_smin_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_umin_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_smax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_umax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 
-void tcg_gen_shli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
-void tcg_gen_shri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
-void tcg_gen_sari_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
-void tcg_gen_rotli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
-void tcg_gen_rotri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
+QEMU_ARG_NONNULL void tcg_gen_shli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
+QEMU_ARG_NONNULL void tcg_gen_shri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
+QEMU_ARG_NONNULL void tcg_gen_sari_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
+QEMU_ARG_NONNULL void tcg_gen_rotli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
+QEMU_ARG_NONNULL void tcg_gen_rotri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 
-void tcg_gen_shls_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
-void tcg_gen_shrs_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
-void tcg_gen_sars_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
-void tcg_gen_rotls_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
+QEMU_ARG_NONNULL void tcg_gen_shls_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
+QEMU_ARG_NONNULL void tcg_gen_shrs_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
+QEMU_ARG_NONNULL void tcg_gen_sars_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
+QEMU_ARG_NONNULL void tcg_gen_rotls_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
 
-void tcg_gen_shlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
-void tcg_gen_shrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
-void tcg_gen_sarv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
-void tcg_gen_rotlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
-void tcg_gen_rotrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
+QEMU_ARG_NONNULL void tcg_gen_shlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
+QEMU_ARG_NONNULL void tcg_gen_shrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
+QEMU_ARG_NONNULL void tcg_gen_sarv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
+QEMU_ARG_NONNULL void tcg_gen_rotlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
+QEMU_ARG_NONNULL void tcg_gen_rotrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
 
+QEMU_ARG_NONNULL
 void tcg_gen_cmp_vec(TCGCond cond, unsigned vece, TCGv_vec r,
                      TCGv_vec a, TCGv_vec b);
 
+QEMU_ARG_NONNULL
 void tcg_gen_bitsel_vec(unsigned vece, TCGv_vec r, TCGv_vec a,
                         TCGv_vec b, TCGv_vec c);
+QEMU_ARG_NONNULL
 void tcg_gen_cmpsel_vec(TCGCond cond, unsigned vece, TCGv_vec r,
                         TCGv_vec a, TCGv_vec b, TCGv_vec c, TCGv_vec d);
 
-void tcg_gen_ld_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
-void tcg_gen_st_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
-void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
+QEMU_ARG_NONNULL void tcg_gen_ld_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
+QEMU_ARG_NONNULL void tcg_gen_st_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
+QEMU_ARG_NONNULL void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 
 /* Host pointer ops */
 
-- 
2.53.0


