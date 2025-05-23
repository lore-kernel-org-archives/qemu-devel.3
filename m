Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1429C54ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 02:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIHlU-0001GJ-Pu; Thu, 22 May 2025 22:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uIHlN-0001En-Km
 for qemu-devel@nongnu.org; Thu, 22 May 2025 22:03:57 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uIHlH-0007ju-Rm
 for qemu-devel@nongnu.org; Thu, 22 May 2025 22:03:57 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso338452b3a.1
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 19:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747965828; x=1748570628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZaHbTkEBubNAQpkCtAP0YTzxiH/VFIPfImRnxNMGa9s=;
 b=HVxgQQKoGAhoTrnZ3w0eNyaIwZ/lWUNNyOLUjE32MHZJspbs4hFT03Zu8d+cUlNLGU
 xiG+BxpsLXyeL9eH0f67QnWoSkVAS1bx71zLy0a+1gXCp1SrdoBO85WPfP31HJGgh35/
 Ed8GIRcFEY1OjgxST9Npx8y+jCF2a5p23NCeXzbg4eunJAkIWG/rbaKS/DYFRnhJz94r
 sq8ftD3FWlD9rzUq5D3Jhcw98ssAwuhb0cq3pkdAvzT8kTw6poKwF4mvlW/VEa2ztH49
 uALumra73YacJCPeVtgMxCCdlCxDK/PfdQZe9oN3x7LC/N7FxuJFXKIC4NpaflCWjclW
 1bMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747965828; x=1748570628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZaHbTkEBubNAQpkCtAP0YTzxiH/VFIPfImRnxNMGa9s=;
 b=GZvqwG7g2aEfgAnasE2fFzEUtBZ6li24HrbaZzNkjDqhXsO+6QQtZwQHkxAoNWuGPJ
 78uBDJnh7gfxnClEzLoRHPWRK550+ajtOTQtlla8LZ49B/tv1ok/K9lIgVRy3hwmuGo6
 PAuadPwHfTtvD+6i350SFi4Bc7kHgR+GFHEmTDk1vskJN7nEstS2eRhLera725GhWkBc
 Vg95r89nkYekOnpFX0Nq6RKC/k2jeQPIgDln9rhKKw1jwLXyAzYLbzdu6nYsHFJeeve+
 MB0f2kaAd2JuV0WLVpKVc3Ib6umV/ARZnxQKEGPWfwthdBhg+1GFcM1Hw4oBSipPeeX8
 3lVg==
X-Gm-Message-State: AOJu0Yz3okioXTg4S77d76w/9TytRIZTUSDPqR09tYsGslz3H/xQdQBH
 96K34+p9tWC1bsCD3FQnq17KVB7CIEnV02Fzlz2TaOEQCGjs1eLaazNRyT6uk3r75BA=
X-Gm-Gg: ASbGncvpqBes9dPTuJf9o5yDWSXVnpaG3kjm7Nb960gLyKv/jKoH605tktU8NMvldrJ
 jqLVGA2qnWCb3uLVKf3RbEdN9XrW+1jUxl+Pp5PcCblqI5S5xh+Atc45vGCXXREA9NHMzkpv360
 fM1AIUhJ1j/gKq/ehSZ+yXTByHySijJC0yjwBax2pYJL74CDs0Fx4KIJKRn2QeO6LDtynd5oBXX
 ppRGkQ/qGa3dF/k3XuNHzqXIK8Y107Q8RkrhY60anb7fdGn+/ziCKkyIw50VzQVx3JjyZH2p9qv
 KxYSCzt0gric5V9MGBzQ+6t6dbionhgx8vEAuaZqvhJ8Ci91xgE=
X-Google-Smtp-Source: AGHT+IFckDCU/JBVBOJqQ8MU8HM4V6/Q845XL4CqxkfAskItS6BYKiALZLIhwXlh3cVB/lEIEjNuMQ==
X-Received: by 2002:a05:6a00:2e17:b0:742:a628:f53c with SMTP id
 d2e1a72fcca58-745ece8b604mr2202448b3a.10.1747965827857; 
 Thu, 22 May 2025 19:03:47 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a98a242asm11820818b3a.164.2025.05.22.19.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 19:03:47 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v4 3/9] plugins: Add enforcement of QEMU_PLUGIN_CB flags in
 register R/W callbacks
Date: Thu, 22 May 2025 19:03:37 -0700
Message-ID: <20250523020344.1341179-4-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523020344.1341179-1-rowanbhart@gmail.com>
References: <20250523020344.1341179-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patch adds functionality to enforce the requested QEMU_PLUGIN_CB_
flags level passed when registering a callback function using the
plugins API. Each time a callback is about to be invoked, a thread-local
variable will be updated with the level that callback requested. Then,
called API functions (in particular, the register read and write API)
will call qemu_plugin_get_cb_flags() to check the level is at least the
level they require.

Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 accel/tcg/plugin-gen.c     | 27 +++++++++++++++++
 include/qemu/plugin.h      | 12 ++++++++
 include/qemu/qemu-plugin.h |  3 --
 plugins/api.c              |  8 +++++
 plugins/core.c             | 60 ++++++++++++++++++++++++++++++++++----
 5 files changed, 101 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index c1da753894..ceb2314bc1 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -117,10 +117,19 @@ static TCGv_i32 gen_cpu_index(void)
 static void gen_udata_cb(struct qemu_plugin_regular_cb *cb)
 {
     TCGv_i32 cpu_index = gen_cpu_index();
+    enum qemu_plugin_cb_flags cb_flags =
+        tcg_call_to_qemu_plugin_cb_flags(cb->info->flags);
+    TCGv_i32 flags = tcg_constant_i32(cb_flags);
+    tcg_gen_call1(qemu_plugin_set_cb_flags,
+                    qemu_plugin_get_set_cb_flags_helper_info(), NULL,
+                    tcgv_i32_temp(flags));
     tcg_gen_call2(cb->f.vcpu_udata, cb->info, NULL,
                   tcgv_i32_temp(cpu_index),
                   tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
+    tcg_gen_call0(qemu_plugin_clear_cb_flags,
+                  qemu_plugin_get_clear_cb_flags_helper_info(), NULL);
     tcg_temp_free_i32(cpu_index);
+    tcg_temp_free_i32(flags);
 }
 
 static TCGv_ptr gen_plugin_u64_ptr(qemu_plugin_u64 entry)
@@ -173,10 +182,19 @@ static void gen_udata_cond_cb(struct qemu_plugin_conditional_cb *cb)
     tcg_gen_ld_i64(val, ptr, 0);
     tcg_gen_brcondi_i64(cond, val, cb->imm, after_cb);
     TCGv_i32 cpu_index = gen_cpu_index();
+    enum qemu_plugin_cb_flags cb_flags =
+        tcg_call_to_qemu_plugin_cb_flags(cb->info->flags);
+    TCGv_i32 flags = tcg_constant_i32(cb_flags);
+    tcg_gen_call1(qemu_plugin_set_cb_flags,
+                  qemu_plugin_get_set_cb_flags_helper_info(), NULL,
+                  tcgv_i32_temp(flags));
     tcg_gen_call2(cb->f.vcpu_udata, cb->info, NULL,
                   tcgv_i32_temp(cpu_index),
                   tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
+     tcg_gen_call0(qemu_plugin_clear_cb_flags,
+                  qemu_plugin_get_clear_cb_flags_helper_info(), NULL);
     tcg_temp_free_i32(cpu_index);
+    tcg_temp_free_i32(flags);
     gen_set_label(after_cb);
 
     tcg_temp_free_i64(val);
@@ -210,12 +228,21 @@ static void gen_mem_cb(struct qemu_plugin_regular_cb *cb,
                        qemu_plugin_meminfo_t meminfo, TCGv_i64 addr)
 {
     TCGv_i32 cpu_index = gen_cpu_index();
+    enum qemu_plugin_cb_flags cb_flags =
+        tcg_call_to_qemu_plugin_cb_flags(cb->info->flags);
+    TCGv_i32 flags = tcg_constant_i32(cb_flags);
+    tcg_gen_call1(qemu_plugin_set_cb_flags,
+                  qemu_plugin_get_set_cb_flags_helper_info(), NULL,
+                  tcgv_i32_temp(flags));
     tcg_gen_call4(cb->f.vcpu_mem, cb->info, NULL,
                   tcgv_i32_temp(cpu_index),
                   tcgv_i32_temp(tcg_constant_i32(meminfo)),
                   tcgv_i64_temp(addr),
                   tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
+    tcg_gen_call0(qemu_plugin_clear_cb_flags,
+                  qemu_plugin_get_clear_cb_flags_helper_info(), NULL);
     tcg_temp_free_i32(cpu_index);
+    tcg_temp_free_i32(flags);
 }
 
 static void inject_cb(struct qemu_plugin_dyn_cb *cb)
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 9726a9ebf3..f312cc1a72 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -209,6 +209,18 @@ void qemu_plugin_user_prefork_lock(void);
  */
 void qemu_plugin_user_postfork(bool is_child);
 
+enum qemu_plugin_cb_flags tcg_call_to_qemu_plugin_cb_flags(int flags);
+
+void qemu_plugin_set_cb_flags(enum qemu_plugin_cb_flags flags);
+
+enum qemu_plugin_cb_flags qemu_plugin_get_cb_flags(void);
+
+void qemu_plugin_clear_cb_flags(void);
+
+TCGHelperInfo *qemu_plugin_get_set_cb_flags_helper_info(void);
+
+TCGHelperInfo *qemu_plugin_get_clear_cb_flags_helper_info(void);
+
 #else /* !CONFIG_PLUGIN */
 
 static inline void qemu_plugin_add_opts(void)
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index cfe1692ecb..120fb626a6 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -254,9 +254,6 @@ typedef struct {
  * @QEMU_PLUGIN_CB_NO_REGS: callback does not access the CPU's regs
  * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
  * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
- *
- * Note: currently QEMU_PLUGIN_CB_RW_REGS is unused, plugins cannot change
- * system register state.
  */
 enum qemu_plugin_cb_flags {
     QEMU_PLUGIN_CB_NO_REGS,
diff --git a/plugins/api.c b/plugins/api.c
index 3a7add50d2..16141f5c25 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -437,6 +437,10 @@ int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
 {
     g_assert(current_cpu);
 
+    if (qemu_plugin_get_cb_flags() == QEMU_PLUGIN_CB_NO_REGS) {
+        return -1;
+    }
+
     return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1);
 }
 
@@ -445,6 +449,10 @@ int qemu_plugin_write_register(struct qemu_plugin_register *reg,
 {
     g_assert(current_cpu);
 
+    if (buf->len == 0 || qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS) {
+        return 0;
+    }
+
     return gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1);
 }
 
diff --git a/plugins/core.c b/plugins/core.c
index eb9281fe54..0ebde1fb87 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -30,6 +30,9 @@ struct qemu_plugin_cb {
 };
 
 struct qemu_plugin_state plugin;
+static __thread enum qemu_plugin_cb_flags call_cb_flags;
+static TCGHelperInfo qemu_plugin_set_cb_flags_helper;
+static TCGHelperInfo qemu_plugin_clear_cb_flags_helper;
 
 struct qemu_plugin_ctx *plugin_id_to_ctx_locked(qemu_plugin_id_t id)
 {
@@ -364,14 +367,15 @@ void plugin_register_dyn_cb__udata(GArray **arr,
                                    enum qemu_plugin_cb_flags flags,
                                    void *udata)
 {
-    static TCGHelperInfo info[3] = {
+    static TCGHelperInfo info[4] = {
         [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
+        [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
         /*
          * Match qemu_plugin_vcpu_udata_cb_t:
          *   void (*)(uint32_t, void *)
          */
-        [0 ... 2].typemask = (dh_typemask(void, 0) |
+        [0 ... 3].typemask = (dh_typemask(void, 0) |
                               dh_typemask(i32, 1) |
                               dh_typemask(ptr, 2))
     };
@@ -393,14 +397,15 @@ void plugin_register_dyn_cond_cb__udata(GArray **arr,
                                         uint64_t imm,
                                         void *udata)
 {
-    static TCGHelperInfo info[3] = {
+    static TCGHelperInfo info[4] = {
         [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
+        [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
         /*
          * Match qemu_plugin_vcpu_udata_cb_t:
          *   void (*)(uint32_t, void *)
          */
-        [0 ... 2].typemask = (dh_typemask(void, 0) |
+        [0 ... 3].typemask = (dh_typemask(void, 0) |
                               dh_typemask(i32, 1) |
                               dh_typemask(ptr, 2))
     };
@@ -431,14 +436,15 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
         !__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t) &&
         !__builtin_types_compatible_p(qemu_plugin_meminfo_t, int32_t));
 
-    static TCGHelperInfo info[3] = {
+    static TCGHelperInfo info[4] = {
         [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
+        [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
         /*
          * Match qemu_plugin_vcpu_mem_cb_t:
          *   void (*)(uint32_t, qemu_plugin_meminfo_t, uint64_t, void *)
          */
-        [0 ... 2].typemask =
+        [0 ... 3].typemask =
             (dh_typemask(void, 0) |
              dh_typemask(i32, 1) |
              (__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t)
@@ -730,6 +736,11 @@ static void __attribute__((__constructor__)) plugin_init(void)
     qht_init(&plugin.dyn_cb_arr_ht, plugin_dyn_cb_arr_cmp, 16,
              QHT_MODE_AUTO_RESIZE);
     atexit(qemu_plugin_atexit_cb);
+    qemu_plugin_set_cb_flags_helper.flags = 0;
+    qemu_plugin_set_cb_flags_helper.typemask = (dh_typemask(void, 0) |
+                                               dh_typemask(i32, 1));
+    qemu_plugin_clear_cb_flags_helper.flags = 0;
+    qemu_plugin_clear_cb_flags_helper.typemask = dh_typemask(void, 0);
 }
 
 int plugin_num_vcpus(void)
@@ -760,3 +771,40 @@ void plugin_scoreboard_free(struct qemu_plugin_scoreboard *score)
     g_array_free(score->data, TRUE);
     g_free(score);
 }
+
+enum qemu_plugin_cb_flags tcg_call_to_qemu_plugin_cb_flags(int flags)
+{
+    if (flags & TCG_CALL_NO_RWG) {
+        return QEMU_PLUGIN_CB_NO_REGS;
+    } else if (flags & TCG_CALL_NO_WG) {
+        return QEMU_PLUGIN_CB_R_REGS;
+    } else {
+        return QEMU_PLUGIN_CB_RW_REGS;
+    }
+}
+
+void qemu_plugin_set_cb_flags(enum qemu_plugin_cb_flags flags)
+{
+    call_cb_flags = flags;
+}
+
+enum qemu_plugin_cb_flags qemu_plugin_get_cb_flags(void)
+{
+    return call_cb_flags;
+}
+
+void qemu_plugin_clear_cb_flags(void)
+{
+    call_cb_flags = QEMU_PLUGIN_CB_NO_REGS;
+}
+
+
+TCGHelperInfo *qemu_plugin_get_set_cb_flags_helper_info(void)
+{
+    return &qemu_plugin_set_cb_flags_helper;
+}
+
+TCGHelperInfo *qemu_plugin_get_clear_cb_flags_helper_info(void)
+{
+    return &qemu_plugin_clear_cb_flags_helper;
+}
-- 
2.49.0


