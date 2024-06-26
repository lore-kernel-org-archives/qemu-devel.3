Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3500C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 23:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMbpF-0003Bi-GM; Wed, 26 Jun 2024 19:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMbp5-00038r-Uk
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:13:07 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMbp2-0000OT-93
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:13:06 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fa75f53f42so15328285ad.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 16:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719443582; x=1720048382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wNUrB5s89at4qVbSixRsMpXHb5fy+r0uHrHpGaYcnnM=;
 b=JuEymtKHG35dTbAQC1ruRvFXVeZ4EEKQqpJFRtHQiHQ8pmK+h1jVSwBgEuQ+nOUpGH
 oxyVrz/hwPAvUmRKP7Wbd8G3D3ZK8yGsmBLB8QXbCCySYNFmwqbTpclT9b1oMdwaJuRT
 w6P1b2jn+bpjFDLN+lPuXZ6BpJh1O/b0CGxYIPBzLxZJeNVcWe7twH6fc5ovu0/9Fv9+
 Zzp9jhz0tLCh3SCai6252RYo/Og5k+R8lgOMR582iltM9yX/rDsO2u7oLAWLXsJ3vuqq
 MGQ6wNin//0Fm8jK7Vm2krpYq7em4MFWZQ/vQUOll1qL2KKBHPw+2tVYdk3f9tDfqJxi
 WnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719443582; x=1720048382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wNUrB5s89at4qVbSixRsMpXHb5fy+r0uHrHpGaYcnnM=;
 b=of1KoQkZCvFi/BKQtv2JyjWtwxUMwjejQliKZWaysgzKawyYjiXtE64XgV/n0kcikv
 EKuT8w2Wf4kPlEi0nxXzHi64R4uoWQRjhGudn9A4JanzIufnK6PCrkfWsHh08JfC7k0q
 5ZGDT1ESU+e/PeVEITpmtVgw/xjoUSAjhAPNOcf+SEImOnDMWc0c2iQpOFBigxxKRuof
 AowoFJR/Si69CeQ4utL/Y88Ie2wHY8VIfHYzbbKsGgqCjKymmZjqtoYoiHL5QeGIc39Y
 G0uUvCTZC3+kcAnGBupIY1Tseiv0KVy4FuH8Eubbvui6nqXNYXKXCJFvSa5VpwXsFrDE
 CSmw==
X-Gm-Message-State: AOJu0YwMjXRM0FfT6D/Tque+oStDIicLAIHP98azq05Q1R7MVGRQjaWs
 ibrKUeyH7G2qi71aD5NKknmYARBMwQOkAgZwEnK03CNCoMUPMJOFo4dCPBiYbAht4u8vThS2LDk
 BGGg=
X-Google-Smtp-Source: AGHT+IEAHdDpzeL58BbU42NP9soHV3hC+mxi/rUJs8i9zKa+FSCH5PX4PiViOPx+4qecaVdnwKs4ww==
X-Received: by 2002:a17:902:6545:b0:1f7:3379:1c71 with SMTP id
 d9443c01a7336-1fa23f49e0cmr108907745ad.27.1719443581412; 
 Wed, 26 Jun 2024 16:13:01 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1faac82cd3bsm478215ad.0.2024.06.26.16.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 16:13:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/7] plugins: save value during memory accesses
Date: Wed, 26 Jun 2024 16:12:50 -0700
Message-Id: <20240626231255.339353-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240626231255.339353-1-pierrick.bouvier@linaro.org>
References: <20240626231255.339353-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

Different code paths handle memory accesses:
- tcg generated code
- load/store helpers
- atomic helpers

This value is saved in cpu->plugin_state.

Atomic operations are doing read/write at the same time, so we generate
two memory callbacks instead of one, to allow plugins to access distinct
values.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/atomic_template.h   | 64 +++++++++++++++++++++++++++----
 include/qemu/plugin.h         |  8 ++++
 plugins/core.c                |  7 ++++
 tcg/tcg-op-ldst.c             | 72 +++++++++++++++++++++++++++++++----
 accel/tcg/atomic_common.c.inc | 13 ++++++-
 accel/tcg/ldst_common.c.inc   | 38 +++++++++++-------
 6 files changed, 171 insertions(+), 31 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 1dc2151dafd..0c3ac79a6af 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -53,6 +53,14 @@
 # error unsupported data size
 #endif
 
+#if DATA_SIZE == 16
+# define UPPER_MEMORY_VALUE(val) int128_gethi(val)
+# define LOWER_MEMORY_VALUE(val) int128_getlo(val)
+#else
+# define UPPER_MEMORY_VALUE(val) 0
+# define LOWER_MEMORY_VALUE(val) val
+#endif
+
 #if DATA_SIZE >= 4
 # define ABI_TYPE  DATA_TYPE
 #else
@@ -83,7 +91,12 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, abi_ptr addr,
     ret = qatomic_cmpxchg__nocheck(haddr, cmpv, newv);
 #endif
     ATOMIC_MMU_CLEANUP;
-    atomic_trace_rmw_post(env, addr, oi);
+    atomic_trace_rmw_post(env, addr,
+                          UPPER_MEMORY_VALUE(ret),
+                          LOWER_MEMORY_VALUE(ret),
+                          UPPER_MEMORY_VALUE(newv),
+                          LOWER_MEMORY_VALUE(newv),
+                          oi);
     return ret;
 }
 
@@ -97,7 +110,12 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, abi_ptr addr, ABI_TYPE val,
 
     ret = qatomic_xchg__nocheck(haddr, val);
     ATOMIC_MMU_CLEANUP;
-    atomic_trace_rmw_post(env, addr, oi);
+    atomic_trace_rmw_post(env, addr,
+                          UPPER_MEMORY_VALUE(ret),
+                          LOWER_MEMORY_VALUE(ret),
+                          UPPER_MEMORY_VALUE(val),
+                          LOWER_MEMORY_VALUE(val),
+                          oi);
     return ret;
 }
 
@@ -109,7 +127,12 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
     haddr = atomic_mmu_lookup(env_cpu(env), addr, oi, DATA_SIZE, retaddr);   \
     ret = qatomic_##X(haddr, val);                                  \
     ATOMIC_MMU_CLEANUP;                                             \
-    atomic_trace_rmw_post(env, addr, oi);                           \
+    atomic_trace_rmw_post(env, addr,                                \
+                          UPPER_MEMORY_VALUE(ret),                  \
+                          LOWER_MEMORY_VALUE(ret),                  \
+                          UPPER_MEMORY_VALUE(val),                  \
+                          LOWER_MEMORY_VALUE(val),                  \
+                          oi);                                      \
     return ret;                                                     \
 }
 
@@ -145,7 +168,12 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
         cmp = qatomic_cmpxchg__nocheck(haddr, old, new);            \
     } while (cmp != old);                                           \
     ATOMIC_MMU_CLEANUP;                                             \
-    atomic_trace_rmw_post(env, addr, oi);                           \
+    atomic_trace_rmw_post(env, addr,                                \
+                          UPPER_MEMORY_VALUE(old),                  \
+                          LOWER_MEMORY_VALUE(old),                  \
+                          UPPER_MEMORY_VALUE(xval),                 \
+                          LOWER_MEMORY_VALUE(xval),                 \
+                          oi);                                      \
     return RET;                                                     \
 }
 
@@ -188,7 +216,12 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, abi_ptr addr,
     ret = qatomic_cmpxchg__nocheck(haddr, BSWAP(cmpv), BSWAP(newv));
 #endif
     ATOMIC_MMU_CLEANUP;
-    atomic_trace_rmw_post(env, addr, oi);
+    atomic_trace_rmw_post(env, addr,
+                          UPPER_MEMORY_VALUE(ret),
+                          LOWER_MEMORY_VALUE(ret),
+                          UPPER_MEMORY_VALUE(newv),
+                          LOWER_MEMORY_VALUE(newv),
+                          oi);
     return BSWAP(ret);
 }
 
@@ -202,7 +235,12 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, abi_ptr addr, ABI_TYPE val,
 
     ret = qatomic_xchg__nocheck(haddr, BSWAP(val));
     ATOMIC_MMU_CLEANUP;
-    atomic_trace_rmw_post(env, addr, oi);
+    atomic_trace_rmw_post(env, addr,
+                          UPPER_MEMORY_VALUE(ret),
+                          LOWER_MEMORY_VALUE(ret),
+                          UPPER_MEMORY_VALUE(val),
+                          LOWER_MEMORY_VALUE(val),
+                          oi);
     return BSWAP(ret);
 }
 
@@ -214,7 +252,12 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
     haddr = atomic_mmu_lookup(env_cpu(env), addr, oi, DATA_SIZE, retaddr);   \
     ret = qatomic_##X(haddr, BSWAP(val));                           \
     ATOMIC_MMU_CLEANUP;                                             \
-    atomic_trace_rmw_post(env, addr, oi);                           \
+    atomic_trace_rmw_post(env, addr,                                \
+                          UPPER_MEMORY_VALUE(ret),                  \
+                          LOWER_MEMORY_VALUE(ret),                  \
+                          UPPER_MEMORY_VALUE(val),                  \
+                          LOWER_MEMORY_VALUE(val),                  \
+                          oi);                                      \
     return BSWAP(ret);                                              \
 }
 
@@ -247,7 +290,12 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
         ldn = qatomic_cmpxchg__nocheck(haddr, ldo, BSWAP(new));     \
     } while (ldo != ldn);                                           \
     ATOMIC_MMU_CLEANUP;                                             \
-    atomic_trace_rmw_post(env, addr, oi);                           \
+    atomic_trace_rmw_post(env, addr,                                \
+                          UPPER_MEMORY_VALUE(old),                  \
+                          LOWER_MEMORY_VALUE(old),                  \
+                          UPPER_MEMORY_VALUE(xval),                 \
+                          LOWER_MEMORY_VALUE(xval),                 \
+                          oi);                                      \
     return RET;                                                     \
 }
 
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index bc5aef979e7..112dcdad717 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -142,9 +142,13 @@ struct qemu_plugin_tb {
 /**
  * struct CPUPluginState - per-CPU state for plugins
  * @event_mask: plugin event bitmap. Modified only via async work.
+ * @mem_value_upper_bits: 64 upper bits of latest accessed mem value.
+ * @mem_value_lower_bits: 64 lower bits of latest accessed mem value.
  */
 struct CPUPluginState {
     DECLARE_BITMAP(event_mask, QEMU_PLUGIN_EV_MAX);
+    uint64_t mem_value_upper_bits;
+    uint64_t mem_value_lower_bits;
 };
 
 /**
@@ -164,6 +168,8 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1,
 void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret);
 
 void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
+                             uint64_t value_upper_bits,
+                             uint64_t value_lower_bits,
                              MemOpIdx oi, enum qemu_plugin_mem_rw rw);
 
 void qemu_plugin_flush_cb(void);
@@ -248,6 +254,8 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
 { }
 
 static inline void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
+                                           uint64_t value_upper_bits,
+                                           uint64_t value_lower_bits,
                                            MemOpIdx oi,
                                            enum qemu_plugin_mem_rw rw)
 { }
diff --git a/plugins/core.c b/plugins/core.c
index 9d737d82787..957a3efb06d 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -575,14 +575,21 @@ void exec_inline_op(enum plugin_dyn_cb_type type,
 }
 
 void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
+                             uint64_t value_upper_bits,
+                             uint64_t value_lower_bits,
                              MemOpIdx oi, enum qemu_plugin_mem_rw rw)
 {
     GArray *arr = cpu->neg.plugin_mem_cbs;
+    CPUPluginState *plugin_state = cpu->plugin_state;
     size_t i;
 
     if (arr == NULL) {
         return;
     }
+
+    plugin_state->mem_value_upper_bits = value_upper_bits;
+    plugin_state->mem_value_lower_bits = value_lower_bits;
+
     for (i = 0; i < arr->len; i++) {
         struct qemu_plugin_dyn_cb *cb =
             &g_array_index(arr, struct qemu_plugin_dyn_cb, i);
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 85101602581..93b338704dc 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -148,14 +148,24 @@ static TCGv_i64 plugin_maybe_preserve_addr(TCGTemp *addr)
     return NULL;
 }
 
+#ifdef CONFIG_PLUGIN
 static void
-plugin_gen_mem_callbacks(TCGv_i64 copy_addr, TCGTemp *orig_addr, MemOpIdx oi,
+plugin_gen_mem_callbacks(TCGv_i64 value_upper_bits, TCGv_i64 value_lower_bits,
+                         TCGv_i64 copy_addr, TCGTemp *orig_addr, MemOpIdx oi,
                          enum qemu_plugin_mem_rw rw)
 {
-#ifdef CONFIG_PLUGIN
     if (tcg_ctx->plugin_insn != NULL) {
         qemu_plugin_meminfo_t info = make_plugin_meminfo(oi, rw);
 
+        TCGv_ptr plugin_state = tcg_temp_ebb_new_ptr();
+        tcg_gen_ld_ptr(plugin_state, tcg_env,
+                       offsetof(CPUState, plugin_state) - sizeof(CPUState));
+        tcg_gen_st_i64(value_upper_bits, plugin_state,
+                       offsetof(CPUPluginState, mem_value_upper_bits));
+        tcg_gen_st_i64(value_lower_bits, plugin_state,
+                       offsetof(CPUPluginState, mem_value_lower_bits));
+        tcg_temp_free_ptr(plugin_state);
+
         if (tcg_ctx->addr_type == TCG_TYPE_I32) {
             if (!copy_addr) {
                 copy_addr = tcg_temp_ebb_new_i64();
@@ -172,6 +182,48 @@ plugin_gen_mem_callbacks(TCGv_i64 copy_addr, TCGTemp *orig_addr, MemOpIdx oi,
             }
         }
     }
+}
+#endif
+
+static void
+plugin_gen_mem_callbacks_i32(TCGv_i32 val,
+                             TCGv_i64 copy_addr, TCGTemp *orig_addr,
+                             MemOpIdx oi, enum qemu_plugin_mem_rw rw)
+{
+#ifdef CONFIG_PLUGIN
+    if (tcg_ctx->plugin_insn != NULL) {
+        TCGv_i64 ext_val = tcg_temp_ebb_new_i64();
+        tcg_gen_extu_i32_i64(ext_val, val);
+        plugin_gen_mem_callbacks(tcg_constant_i64(0), ext_val,
+                                 copy_addr, orig_addr, oi, rw);
+        tcg_temp_free_i64(ext_val);
+    }
+#endif
+}
+
+static void
+plugin_gen_mem_callbacks_i64(TCGv_i64 val,
+                             TCGv_i64 copy_addr, TCGTemp *orig_addr,
+                             MemOpIdx oi, enum qemu_plugin_mem_rw rw)
+{
+#ifdef CONFIG_PLUGIN
+    if (tcg_ctx->plugin_insn != NULL) {
+        plugin_gen_mem_callbacks(tcg_constant_i64(0), val,
+                                 copy_addr, orig_addr, oi, rw);
+    }
+#endif
+}
+
+static void
+plugin_gen_mem_callbacks_i128(TCGv_i128 val,
+                             TCGv_i64 copy_addr, TCGTemp *orig_addr,
+                             MemOpIdx oi, enum qemu_plugin_mem_rw rw)
+{
+#ifdef CONFIG_PLUGIN
+    if (tcg_ctx->plugin_insn != NULL) {
+        plugin_gen_mem_callbacks(TCGV128_HIGH(val), TCGV128_LOW(val),
+                                 copy_addr, orig_addr, oi, rw);
+    }
 #endif
 }
 
@@ -203,7 +255,8 @@ static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
         opc = INDEX_op_qemu_ld_a64_i32;
     }
     gen_ldst(opc, tcgv_i32_temp(val), NULL, addr, oi);
-    plugin_gen_mem_callbacks(copy_addr, addr, orig_oi, QEMU_PLUGIN_MEM_R);
+    plugin_gen_mem_callbacks_i32(val, copy_addr, addr, orig_oi,
+                                 QEMU_PLUGIN_MEM_R);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         switch (orig_memop & MO_SIZE) {
@@ -271,7 +324,7 @@ static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
         }
     }
     gen_ldst(opc, tcgv_i32_temp(val), NULL, addr, oi);
-    plugin_gen_mem_callbacks(NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
+    plugin_gen_mem_callbacks_i32(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
 
     if (swap) {
         tcg_temp_free_i32(swap);
@@ -324,7 +377,8 @@ static void tcg_gen_qemu_ld_i64_int(TCGv_i64 val, TCGTemp *addr,
         opc = INDEX_op_qemu_ld_a64_i64;
     }
     gen_ldst_i64(opc, val, addr, oi);
-    plugin_gen_mem_callbacks(copy_addr, addr, orig_oi, QEMU_PLUGIN_MEM_R);
+    plugin_gen_mem_callbacks_i64(val, copy_addr, addr, orig_oi,
+                                 QEMU_PLUGIN_MEM_R);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         int flags = (orig_memop & MO_SIGN
@@ -396,7 +450,7 @@ static void tcg_gen_qemu_st_i64_int(TCGv_i64 val, TCGTemp *addr,
         opc = INDEX_op_qemu_st_a64_i64;
     }
     gen_ldst_i64(opc, val, addr, oi);
-    plugin_gen_mem_callbacks(NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
+    plugin_gen_mem_callbacks_i64(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
 
     if (swap) {
         tcg_temp_free_i64(swap);
@@ -606,7 +660,8 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
                            tcg_constant_i32(orig_oi));
     }
 
-    plugin_gen_mem_callbacks(ext_addr, addr, orig_oi, QEMU_PLUGIN_MEM_R);
+    plugin_gen_mem_callbacks_i128(val, ext_addr, addr, orig_oi,
+                                  QEMU_PLUGIN_MEM_R);
 }
 
 void tcg_gen_qemu_ld_i128_chk(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
@@ -722,7 +777,8 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
                            tcg_constant_i32(orig_oi));
     }
 
-    plugin_gen_mem_callbacks(ext_addr, addr, orig_oi, QEMU_PLUGIN_MEM_W);
+    plugin_gen_mem_callbacks_i128(val, ext_addr, addr, orig_oi,
+                                  QEMU_PLUGIN_MEM_W);
 }
 
 void tcg_gen_qemu_st_i128_chk(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
diff --git a/accel/tcg/atomic_common.c.inc b/accel/tcg/atomic_common.c.inc
index 95a5c5ff12d..bed56d25d47 100644
--- a/accel/tcg/atomic_common.c.inc
+++ b/accel/tcg/atomic_common.c.inc
@@ -14,9 +14,20 @@
  */
 
 static void atomic_trace_rmw_post(CPUArchState *env, uint64_t addr,
+                                  uint64_t read_value_upper_bits,
+                                  uint64_t read_value_lower_bits,
+                                  uint64_t write_value_upper_bits,
+                                  uint64_t write_value_lower_bits,
                                   MemOpIdx oi)
 {
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_RW);
+    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
+        qemu_plugin_vcpu_mem_cb(env_cpu(env), addr,
+                                read_value_upper_bits, read_value_lower_bits,
+                                oi, QEMU_PLUGIN_MEM_R);
+        qemu_plugin_vcpu_mem_cb(env_cpu(env), addr,
+                                write_value_upper_bits, write_value_lower_bits,
+                                oi, QEMU_PLUGIN_MEM_W);
+    }
 }
 
 /*
diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
index 87ceb954873..f6d5613a358 100644
--- a/accel/tcg/ldst_common.c.inc
+++ b/accel/tcg/ldst_common.c.inc
@@ -123,10 +123,15 @@ void helper_st_i128(CPUArchState *env, uint64_t addr, Int128 val, MemOpIdx oi)
  * Load helpers for cpu_ldst.h
  */
 
-static void plugin_load_cb(CPUArchState *env, abi_ptr addr, MemOpIdx oi)
+static void plugin_load_cb(CPUArchState *env, abi_ptr addr,
+                           uint64_t value_upper_bits,
+                           uint64_t value_lower_bits,
+                           MemOpIdx oi)
 {
     if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
-        qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
+        qemu_plugin_vcpu_mem_cb(env_cpu(env), addr,
+                                value_upper_bits, value_lower_bits,
+                                oi, QEMU_PLUGIN_MEM_R);
     }
 }
 
@@ -136,7 +141,7 @@ uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr addr, MemOpIdx oi, uintptr_t ra)
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_UB);
     ret = do_ld1_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-    plugin_load_cb(env, addr, oi);
+    plugin_load_cb(env, addr, 0, ret, oi);
     return ret;
 }
 
@@ -147,7 +152,7 @@ uint16_t cpu_ldw_mmu(CPUArchState *env, abi_ptr addr,
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
     ret = do_ld2_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-    plugin_load_cb(env, addr, oi);
+    plugin_load_cb(env, addr, 0, ret, oi);
     return ret;
 }
 
@@ -158,7 +163,7 @@ uint32_t cpu_ldl_mmu(CPUArchState *env, abi_ptr addr,
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
     ret = do_ld4_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-    plugin_load_cb(env, addr, oi);
+    plugin_load_cb(env, addr, 0, ret, oi);
     return ret;
 }
 
@@ -169,7 +174,7 @@ uint64_t cpu_ldq_mmu(CPUArchState *env, abi_ptr addr,
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
     ret = do_ld8_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-    plugin_load_cb(env, addr, oi);
+    plugin_load_cb(env, addr, 0, ret, oi);
     return ret;
 }
 
@@ -180,7 +185,7 @@ Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
     ret = do_ld16_mmu(env_cpu(env), addr, oi, ra);
-    plugin_load_cb(env, addr, oi);
+    plugin_load_cb(env, addr, int128_gethi(ret), int128_getlo(ret), oi);
     return ret;
 }
 
@@ -188,10 +193,15 @@ Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
  * Store helpers for cpu_ldst.h
  */
 
-static void plugin_store_cb(CPUArchState *env, abi_ptr addr, MemOpIdx oi)
+static void plugin_store_cb(CPUArchState *env, abi_ptr addr,
+                            uint64_t value_upper_bits,
+                            uint64_t value_lower_bits,
+                            MemOpIdx oi)
 {
     if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
-        qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
+        qemu_plugin_vcpu_mem_cb(env_cpu(env), addr,
+                                value_upper_bits, value_lower_bits,
+                                oi, QEMU_PLUGIN_MEM_W);
     }
 }
 
@@ -199,7 +209,7 @@ void cpu_stb_mmu(CPUArchState *env, abi_ptr addr, uint8_t val,
                  MemOpIdx oi, uintptr_t retaddr)
 {
     helper_stb_mmu(env, addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
+    plugin_store_cb(env, addr, 0, val, oi);
 }
 
 void cpu_stw_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
@@ -207,7 +217,7 @@ void cpu_stw_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
     do_st2_mmu(env_cpu(env), addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
+    plugin_store_cb(env, addr, 0, val, oi);
 }
 
 void cpu_stl_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
@@ -215,7 +225,7 @@ void cpu_stl_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
     do_st4_mmu(env_cpu(env), addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
+    plugin_store_cb(env, addr, 0, val, oi);
 }
 
 void cpu_stq_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
@@ -223,7 +233,7 @@ void cpu_stq_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
     do_st8_mmu(env_cpu(env), addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
+    plugin_store_cb(env, addr, 0, val, oi);
 }
 
 void cpu_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
@@ -231,7 +241,7 @@ void cpu_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
     do_st16_mmu(env_cpu(env), addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
+    plugin_store_cb(env, addr, int128_gethi(val), int128_getlo(val), oi);
 }
 
 /*
-- 
2.39.2


