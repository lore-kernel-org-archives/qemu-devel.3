Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B8BC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkss-0002Bi-U8; Sun, 27 Sep 2026 05:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrd-0002gz-BQ
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:08:05 -0400
Received: from mail-pj2-x0d.google.com ([2607:f8b0:4864:39::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkra-0008Id-QS
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:08:05 -0400
Received: by mail-pj2-x0d.google.com with SMTP id
 98e67ed59e1d1-3a0bd71827eso1103871a91.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790500081; x=1791104881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S/GG6PKiHKPpRp51zLZR3cqK4p7vpAEeQdEkscB0mkw=;
 b=RnvpTZYF4zR2+X5OGT0kBjhta3+usH8DAOf/fH/hcu5Xttq3x6L0nIK2gsFJKWBaFP
 3FCJXge9fOWnssA0NCI38tj+jHnMZ+oDN6k9Q6uVcoTePum8hZpmDwpI9AbEFhYbCVlr
 Jy+fL4ytfBp2tTCMxoY0FmDnxHP9oPd4GchRByf2rH2TBtwCgbaMEL6cbYI/dnBi+8b4
 h0jCNC2SvrcDjjVFjSxq1dz57bXiDA3PoQ7UzbNtMEH35dno3NT/DmbnLnVudUMdfwsZ
 AH5SWnSas8NgaNVgWIPviuqBa+vcFjgJ1zV3/k3TYaPC2K+4GxZFx2UXihHanKv5LKvz
 /a7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790500081; x=1791104881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=S/GG6PKiHKPpRp51zLZR3cqK4p7vpAEeQdEkscB0mkw=;
 b=g8BbTeAbrMfr3h26FNpENEZ5w7ugtOKBJ9AKzIoXg+H93dn8VN3V/X17oEpm4AeUGx
 pjPgWpZ6Cet6P1k9wPvRz93ic4rtHMfpKvBvEicSeLAWUouAuAEyuV+7uFiCQElNjMxn
 l8uAIz/f8G9Wc4FE7a/HTpNOjXSHqECh3kfsxKffNykRHan/ZLMpcIk44iNidf61BU5a
 RbThTQHOyOI5Fw8aAZEz+q7MyG2KUZ+HVse46RGcDvAQwim5eEKZKZBheh53K9R3g833
 g5CPIlYh4CdoF4mfED4pOBWuvBtxeqAxPrmRaLvu/FdPdGhFzFl29+a6ciC5dbBHzn/V
 l+8Q==
X-Gm-Message-State: AFq9FYKMv+2crxTUecQyYjV4TArKyfs+xtaZsaHm1iKkfo4JZzyZ0UFf
 xjl8HYOc4p1GuFrds+IdkGcw4ZvYG2hBit1MtgA6nKhSjcjvk1JBsF2aYCdVSv9d8OdjKHetuir
 ohjrR
X-Gm-Gg: AYBFou1Z6UW9M9QlmXj+EuORfaH8iYWEYWJDchTm+OJKsw7qTMtJzo+QQIpldARSs9+
 iwv4MFbBEyA8Wom3wN3j1VoFVnfMEjeK4XGn0P5uDdZgQ5d7lm4H/Jzk716B2gQ0ROioTJqroKt
 8G05B2Ml6zXkAdxWS9IcQAl8Kjp8S5HTnAdLhaLrqybQgKFibgVQcoMsKwOGKTYEmIHM/VVrkv9
 GBRu+2jp26gaIguZmk2YxzGh0wnrFrfn7Obfmi0/y4TlTbXukpIkcr9zCYRTflwL/n/N8OVWWoQ
 gPqF3adgwZOvE0huDKTUgwkcghgSKQrIguX1GNIoCsZuUxI1JJr6pdtvnCphZ8x80w6jG9WevlL
 g9u1nm/UofSCBGljs4S+BjsnXCP3lhONoCqUIsbMT82IPNPfYsAZfcGraMuNkYB8fYFJ0U7W+Ee
 MB3ClWuNXguQCOb92y5ImboaE+cfgENFpvm/JmdQCt2eHwTnJ2DbsUBjYwVobpi3SAd1Osxjeto
 OqvazjeieDtIHut46drzwWFkEH8FQ==
X-Received: by 2002:a17:90a:1149:b0:3a0:9c9d:eb0b with SMTP id
 98e67ed59e1d1-3a09c9df050mr5898654a91.58.1790500081321; 
 Sun, 27 Sep 2026 02:08:01 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e7036e3bsm7144984a91.13.2026.09.27.02.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:08:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 097/101] tcg: Generic expansion of tcg_gen_qemu_ld_chk
Date: Sun, 27 Sep 2026 02:00:07 -0700
Message-ID: <20260927090011.10724-98-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |   4 +-
 include/tcg/tcg-op-mem.h     |   6 +-
 include/tcg/tcg.h            |   2 +
 include/tcg/tcg-op-def.h.inc |   1 +
 tcg/tcg-op-ldst.c            | 164 ++++++++++++++---------------------
 tcg/tcg-op.c                 |   4 +
 6 files changed, 75 insertions(+), 106 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 583f6ebb2f5..fcbaae3def5 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -177,11 +177,9 @@ void tcg_gen_st_i128(TCGv_i128 val, TCGv_ptr base, tcg_target_long offset);
 
 /* Local load/store bit ops */
 
-void tcg_gen_qemu_ld_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType);
+void tcg_gen_qemu_ld_chk_i128(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
 void tcg_gen_qemu_st_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType);
-void tcg_gen_qemu_ld_i64_chk(TCGv_i64, TCGTemp *, TCGArg, MemOp, TCGType);
 void tcg_gen_qemu_st_i64_chk(TCGv_i64, TCGTemp *, TCGArg, MemOp, TCGType);
-void tcg_gen_qemu_ld_i128_chk(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
 void tcg_gen_qemu_st_i128_chk(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
 
 /* Atomic ops */
diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
index 29e7c02f256..76955d27c1f 100644
--- a/include/tcg/tcg-op-mem.h
+++ b/include/tcg/tcg-op-mem.h
@@ -31,7 +31,7 @@ typedef TCGv_i64 TCGv_va;
 QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_ld_i32(TCGv_i32 v, TCGv_va a, TCGArg i, MemOp m)
 {
-    tcg_gen_qemu_ld_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
+    tcg_gen_qemu_ld_chk_i32(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
 QEMU_ARG_NONNULL static inline void
@@ -43,7 +43,7 @@ tcg_gen_qemu_st_i32(TCGv_i32 v, TCGv_va a, TCGArg i, MemOp m)
 QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_ld_i64(TCGv_i64 v, TCGv_va a, TCGArg i, MemOp m)
 {
-    tcg_gen_qemu_ld_i64_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
+    tcg_gen_qemu_ld_chk_i64(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
 QEMU_ARG_NONNULL static inline void
@@ -55,7 +55,7 @@ tcg_gen_qemu_st_i64(TCGv_i64 v, TCGv_va a, TCGArg i, MemOp m)
 QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_ld_i128(TCGv_i128 v, TCGv_va a, TCGArg i, MemOp m)
 {
-    tcg_gen_qemu_ld_i128_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
+    tcg_gen_qemu_ld_chk_i128(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
 QEMU_ARG_NONNULL static inline void
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 077a1b37021..fd719f9a36a 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -293,6 +293,8 @@ typedef struct TCGTemp {
     void *state_ptr;
 } TCGTemp;
 
+typedef TCGTemp *TCGTempPtr;
+
 typedef struct TCGContext TCGContext;
 
 typedef struct TCGTempSet {
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 556f7470cd6..e2da3ddef66 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -53,6 +53,7 @@ DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
 DEF3(orc, TCGV, TCGV, TCGV)
+DEF5(qemu_ld_chk, TCGV, TCGTempPtr, unsigned, MemOp, TCGType)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF2(revbit8, TCGV, TCGV)
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 031c5ce926b..c48b8c0e3d1 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -191,33 +191,37 @@ plugin_gen_mem_callbacks(TCGv_i64 copy_addr, TCGTemp *orig_addr, MemOpIdx oi,
 #endif
 
 static void
-plugin_gen_mem_callbacks_i32(TCGv_i32 val,
+plugin_gen_mem_callbacks_tmp(TCGType type, TCGTemp *val,
                              TCGv_i64 copy_addr, TCGTemp *orig_addr,
                              MemOpIdx oi, enum qemu_plugin_mem_rw rw)
 {
 #ifdef CONFIG_PLUGIN
     if (tcg_ctx->plugin_insn != NULL) {
-        tcg_gen_st_i32(val, tcg_env,
-                       offsetof(CPUState, neg.plugin_mem_value_low) -
-                       sizeof(CPUState) + (HOST_BIG_ENDIAN * 4));
+        tcg_gen_st(type, val, tcgv_ptr_temp(tcg_env),
+                   offsetof(CPUState, neg.plugin_mem_value_low)
+                   - sizeof(CPUState)
+                   + (HOST_BIG_ENDIAN && type == TCG_TYPE_I32 ? 4 : 0));
         plugin_gen_mem_callbacks(copy_addr, orig_addr, oi, rw);
     }
 #endif
 }
 
+static void
+plugin_gen_mem_callbacks_i32(TCGv_i32 val,
+                             TCGv_i64 copy_addr, TCGTemp *orig_addr,
+                             MemOpIdx oi, enum qemu_plugin_mem_rw rw)
+{
+    plugin_gen_mem_callbacks_tmp(TCG_TYPE_I32, tcgv_i32_temp(val), copy_addr,
+                                 orig_addr, oi, rw);
+}
+
 static void
 plugin_gen_mem_callbacks_i64(TCGv_i64 val,
                              TCGv_i64 copy_addr, TCGTemp *orig_addr,
                              MemOpIdx oi, enum qemu_plugin_mem_rw rw)
 {
-#ifdef CONFIG_PLUGIN
-    if (tcg_ctx->plugin_insn != NULL) {
-        tcg_gen_st_i64(val, tcg_env,
-                       offsetof(CPUState, neg.plugin_mem_value_low) -
-                       sizeof(CPUState));
-        plugin_gen_mem_callbacks(copy_addr, orig_addr, oi, rw);
-    }
-#endif
+    plugin_gen_mem_callbacks_tmp(TCG_TYPE_I64, tcgv_i64_temp(val), copy_addr,
+                                 orig_addr, oi, rw);
 }
 
 static void
@@ -238,8 +242,31 @@ plugin_gen_mem_callbacks_i128(TCGv_i128 val,
 #endif
 }
 
-static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
-                                    TCGArg idx, MemOp memop)
+static void tcg_gen_bswap(TCGType type, TCGTemp *dst,
+                          TCGTemp *src, unsigned flags, MemOp memop)
+{
+    switch (memop & MO_SIZE) {
+    case MO_16:
+        tcg_gen_bswap16(type, src, dst, flags);
+        break;
+    case MO_32:
+        if (type == TCG_TYPE_I32) {
+            tcg_gen_bswap32_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src));
+        } else {
+            tcg_gen_bswap32_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src), flags);
+        }
+        break;
+    case MO_64:
+        tcg_debug_assert(type == TCG_TYPE_I64);
+        tcg_gen_bswap64_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src));
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_gen_qemu_ld_int(TCGType type, TCGTemp *val,
+                                TCGTemp *addr, TCGArg idx, MemOp memop)
 {
     MemOp orig_memop;
     MemOpIdx orig_oi, oi;
@@ -247,48 +274,40 @@ static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
     TCGTemp *addr_new;
 
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
-    orig_memop = memop = tcg_canonicalize_memop(memop, 0, 0);
+    memop = tcg_canonicalize_memop(memop, type != TCG_TYPE_I32, 0);
+    orig_memop = memop;
     orig_oi = oi = make_memop_idx(memop, idx);
 
     if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
-        memop &= ~MO_BSWAP;
         /* The bswap primitive benefits from zero-extended input.  */
-        if ((memop & MO_SSIZE) == MO_SW) {
-            memop &= ~MO_SIGN;
-        }
+        memop &= ~(MO_BSWAP | MO_SIGN);
         oi = make_memop_idx(memop, idx);
     }
 
     addr_new = tci_extend_addr(addr);
     copy_addr = plugin_maybe_preserve_addr(addr);
-    gen_ldst1(INDEX_op_qemu_ld, TCG_TYPE_I32, tcgv_i32_temp(val), addr_new, oi);
+    tcg_gen_op_tti(INDEX_op_qemu_ld, type, val, addr_new, oi);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
-        switch (orig_memop & MO_SIZE) {
-        case MO_16:
-            tcg_gen_bswap16_i32(val, val, (orig_memop & MO_SIGN
-                                           ? TCG_BSWAP_IZ | TCG_BSWAP_OS
-                                           : TCG_BSWAP_IZ | TCG_BSWAP_OZ));
-            break;
-        case MO_32:
-            tcg_gen_bswap32_i32(val, val);
-            break;
-        default:
-            g_assert_not_reached();
-        }
+        int flags = (orig_memop & MO_SIGN
+                     ? TCG_BSWAP_IZ | TCG_BSWAP_OS
+                     : TCG_BSWAP_IZ | TCG_BSWAP_OZ);
+        tcg_gen_bswap(type, val, val, flags, orig_memop);
     }
 
-    plugin_gen_mem_callbacks_i32(val, copy_addr, addr, orig_oi,
-                                 QEMU_PLUGIN_MEM_R);
+    plugin_gen_mem_callbacks_tmp(type, val, copy_addr, addr,
+                                 orig_oi, QEMU_PLUGIN_MEM_R);
     maybe_free_addr(addr, addr_new);
 }
 
-void tcg_gen_qemu_ld_i32_chk(TCGv_i32 val, TCGTemp *addr, TCGArg idx,
-                             MemOp memop, TCGType addr_type)
+void tcg_gen_qemu_ld_chk(TCGType val_type, TCGTemp *val, TCGTemp *addr,
+                         unsigned idx, MemOp memop, TCGType addr_type)
 {
     tcg_debug_assert(addr_type == tcg_ctx->addr_type);
-    tcg_debug_assert((memop & MO_SIZE) <= MO_32);
-    tcg_gen_qemu_ld_i32_int(val, addr, idx, memop);
+    tcg_debug_assert(memop_size(memop) <= tcg_type_size(val_type));
+    tcg_debug_assert(idx < NB_MMU_MODES);
+
+    tcg_gen_qemu_ld_int(val_type, val, addr, idx, memop);
 }
 
 static void tcg_gen_qemu_st_i32_int(TCGv_i32 orig_val, TCGTemp *addr,
@@ -337,63 +356,6 @@ void tcg_gen_qemu_st_i32_chk(TCGv_i32 val, TCGTemp *addr, TCGArg idx,
     tcg_gen_qemu_st_i32_int(val, addr, idx, memop);
 }
 
-static void tcg_gen_qemu_ld_i64_int(TCGv_i64 val, TCGTemp *addr,
-                                    TCGArg idx, MemOp memop)
-{
-    MemOp orig_memop;
-    MemOpIdx orig_oi, oi;
-    TCGv_i64 copy_addr;
-    TCGTemp *addr_new;
-
-    tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
-    orig_memop = memop = tcg_canonicalize_memop(memop, 1, 0);
-    orig_oi = oi = make_memop_idx(memop, idx);
-
-    if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
-        memop &= ~MO_BSWAP;
-        /* The bswap primitive benefits from zero-extended input.  */
-        if ((memop & MO_SIGN) && (memop & MO_SIZE) < MO_64) {
-            memop &= ~MO_SIGN;
-        }
-        oi = make_memop_idx(memop, idx);
-    }
-
-    addr_new = tci_extend_addr(addr);
-    copy_addr = plugin_maybe_preserve_addr(addr);
-    gen_ld_i64(val, addr_new, oi);
-
-    if ((orig_memop ^ memop) & MO_BSWAP) {
-        int flags = (orig_memop & MO_SIGN
-                     ? TCG_BSWAP_IZ | TCG_BSWAP_OS
-                     : TCG_BSWAP_IZ | TCG_BSWAP_OZ);
-        switch (orig_memop & MO_SIZE) {
-        case MO_16:
-            tcg_gen_bswap16_i64(val, val, flags);
-            break;
-        case MO_32:
-            tcg_gen_bswap32_i64(val, val, flags);
-            break;
-        case MO_64:
-            tcg_gen_bswap64_i64(val, val);
-            break;
-        default:
-            g_assert_not_reached();
-        }
-    }
-
-    plugin_gen_mem_callbacks_i64(val, copy_addr, addr, orig_oi,
-                                 QEMU_PLUGIN_MEM_R);
-    maybe_free_addr(addr, addr_new);
-}
-
-void tcg_gen_qemu_ld_i64_chk(TCGv_i64 val, TCGTemp *addr, TCGArg idx,
-                             MemOp memop, TCGType addr_type)
-{
-    tcg_debug_assert(addr_type == tcg_ctx->addr_type);
-    tcg_debug_assert((memop & MO_SIZE) <= MO_64);
-    tcg_gen_qemu_ld_i64_int(val, addr, idx, memop);
-}
-
 static void tcg_gen_qemu_st_i64_int(TCGv_i64 orig_val, TCGTemp *addr,
                                     TCGArg idx, MemOp memop)
 {
@@ -638,7 +600,7 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
                                   QEMU_PLUGIN_MEM_R);
 }
 
-void tcg_gen_qemu_ld_i128_chk(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
+void tcg_gen_qemu_ld_chk_i128(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
                               MemOp memop, TCGType addr_type)
 {
     tcg_debug_assert(addr_type == tcg_ctx->addr_type);
@@ -800,7 +762,8 @@ static void tcg_gen_nonatomic_cmpxchg_i32_int(TCGv_i32 retv, TCGTemp *addr,
 
     tcg_gen_ext_i32(t2, cmpv, memop & MO_SIZE);
 
-    tcg_gen_qemu_ld_i32_int(t1, addr, idx, memop & ~MO_SIGN);
+    tcg_gen_qemu_ld_int(TCG_TYPE_I32, tcgv_i32_temp(t1),
+                        addr, idx, memop & ~MO_SIGN);
     tcg_gen_movcond_i32(TCG_COND_EQ, t2, t1, t2, newv, t1);
     tcg_gen_qemu_st_i32_int(t2, addr, idx, memop);
     tcg_temp_free_i32(t2);
@@ -871,7 +834,8 @@ static void tcg_gen_nonatomic_cmpxchg_i64_int(TCGv_i64 retv, TCGTemp *addr,
 
     tcg_gen_ext_i64(t2, cmpv, memop & MO_SIZE);
 
-    tcg_gen_qemu_ld_i64_int(t1, addr, idx, memop & ~MO_SIGN);
+    tcg_gen_qemu_ld_int(TCG_TYPE_I64, tcgv_i64_temp(t1),
+                        addr, idx, memop & ~MO_SIGN);
     tcg_gen_movcond_i64(TCG_COND_EQ, t2, t1, t2, newv, t1);
     tcg_gen_qemu_st_i64_int(t2, addr, idx, memop);
     tcg_temp_free_i64(t2);
@@ -1047,7 +1011,7 @@ static void do_nonatomic_op_i32(TCGv_i32 ret, TCGTemp *addr, TCGv_i32 val,
 
     memop = tcg_canonicalize_memop(memop, 0, 0);
 
-    tcg_gen_qemu_ld_i32_int(t1, addr, idx, memop);
+    tcg_gen_qemu_ld_int(TCG_TYPE_I32, tcgv_i32_temp(t1), addr, idx, memop);
     tcg_gen_ext_i32(t2, val, memop);
     gen(t2, t1, t2);
     tcg_gen_qemu_st_i32_int(t2, addr, idx, memop);
@@ -1088,7 +1052,7 @@ static void do_nonatomic_op_i64(TCGv_i64 ret, TCGTemp *addr, TCGv_i64 val,
 
     memop = tcg_canonicalize_memop(memop, 1, 0);
 
-    tcg_gen_qemu_ld_i64_int(t1, addr, idx, memop);
+    tcg_gen_qemu_ld_int(TCG_TYPE_I64, tcgv_i64_temp(t1), addr, idx, memop);
     tcg_gen_ext_i64(t2, val, memop);
     gen(t2, t1, t2);
     tcg_gen_qemu_st_i64_int(t2, addr, idx, memop);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 924b94414b7..c68e9e10501 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -239,6 +239,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #define C_MemOp
 #define C_TCGCond
 #define C_TCGLabelPtr
+#define C_TCGTempPtr
+#define C_TCGType
 #define C_tcg_target_long
 #define C_unsigned
 
@@ -272,6 +274,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef C_MemOp
 #undef C_TCGCond
 #undef C_TCGLabelPtr
+#undef C_TCGTempPtr
+#undef C_TCGType
 #undef C_tcg_target_long
 #undef C_unsigned
 
-- 
2.53.0


