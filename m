Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A774C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 18:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKpn-0005Ja-7q; Sun, 09 Mar 2025 13:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKpk-0005Iy-H1
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:04 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKpi-0004sa-NQ
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:04 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-391342fc0b5so2663754f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542781; x=1742147581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zPyx2ZZAkNbMr4x6s2PTNuf6aA8UZ98dZ1dk69dQsTE=;
 b=MaiPxAJUwRpirsMtDE4UxIQBrUefQvKv1cFGooDyVXwQinSdxbsGFOlvq//Iw+Gag9
 EgRybst2qtfIcUmk5jsVyDsHZf0V/lQx4a4vrpkkeyifKxU+mXv2vfjpssXsbM2wsd+5
 vNZl5H5OnErrv75NOiTZ3YW6I6H0IqO3TH6TGV+vxuaxJvm8WE8CcYL1fGi/sha9pclQ
 h+d2Jk7LYLIukhoYh+Kl3qqRh6x0hJbqjuZGyROOMb7NghBTE0chWfhqji9Jmme4XK+Y
 D1IQjoAJPoqZDuhQVgK3oCO5a/4QjBPeWZuwCiRxtNRvPrNCalvd4v/vVAiraC69uf8p
 gbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542781; x=1742147581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zPyx2ZZAkNbMr4x6s2PTNuf6aA8UZ98dZ1dk69dQsTE=;
 b=UNG3stBebNn+jQGnJX/ZAEnt2Vx7ztfK07ssvmIi4nJgBAAYG/k5+ejoapqTHaTZBJ
 /KhjlUjIrmwmFbKSeM+C3IC1fCKTw0+u04/rm5dUCcPtPlWgCkVxOMZbpzvffP7ZWtwz
 1/qUXR4L77Bi4FV4O9ceEoxqgfxiNzlEe5VQNMOdc9gX/pZd52rVFUrdFJlwzllgZCu8
 aNrpGirF46hvP6VaGu5Dh/tfiJ9Ag/hJhF0fI7+CpU7ehrLyQTo9N+yI8EnEPK2mYx2D
 8RluGAbOVXxoipWF34ubsnR2PadDzcLq61kJPpIpO52O5JS7YSgkijLRv2shu0pvmREJ
 tJzQ==
X-Gm-Message-State: AOJu0YxKnK6XcSiAq9iubm/DcscKfa6pFcmBh3hgOH2gvtP9k+FFp3Ut
 Bnpq3pzbU9/dbq2ocaSu27LJIQVRoAXOUtDoeNVM4cinLdZrM202SEdsGjtPIB8mL+L4Q1C7hEU
 UhlY=
X-Gm-Gg: ASbGncuaJTsSOkC70J7G7L4JhHKj7wYYZi1Hj7FyG/bDyHGTdvO1JH0twGIqglx+GR/
 I10CM9V22kUEFsgM15Wiy5rMG3TmMrdEpg8FYq01VAMwPGeFMYH2obv/04cOe2QiWQeb2Hm8p5t
 9muD9kYbiewWedU2vxb5JsTMqe75i+GPKiLgOQWKQygkPGItKAO8PQ5z9OzJ1zoyvHoHiLmnkrj
 Smriq3hHKo8HFmm9W8H0AgF+39hfKMJ/ijRoT0DDCfdW5wTUIrIFiVNAD/H5j5MhbFP+wistWbq
 ct9wqrXfo4sWyyFY3d+BoxvEqtfSQ2YdGzWcK+SrbCSHWRsP0g6ARqBasO88/WOla1xddqostIl
 b48nwTRaT9NqsJzIekno=
X-Google-Smtp-Source: AGHT+IHmO+bWJSrOEAyN9lLmq1Vflz0VK5BCLNB1EApRjdXsGsfwc5eYwvUi2DRAxNJE9BOaYpf65g==
X-Received: by 2002:a05:6000:1a88:b0:385:d7f9:f157 with SMTP id
 ffacd0b85a97d-39132da227bmr6965076f8f.36.1741542780765; 
 Sun, 09 Mar 2025 10:53:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ceba8d727sm51272085e9.25.2025.03.09.10.53.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:53:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/38] gdbstub: Prefer cached CpuClass over CPU_GET_CLASS()
 macro
Date: Sun,  9 Mar 2025 18:51:40 +0100
Message-ID: <20250309175207.43828-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

CpuState caches its CPUClass since commit 6fbdff87062
("cpu: cache CPUClass in CPUState for hot code paths"),
use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250122093028.52416-9-philmd@linaro.org>
---
 gdbstub/gdbstub.c     | 26 +++++++++-----------------
 gdbstub/system.c      |  7 ++-----
 gdbstub/user-target.c |  6 ++----
 gdbstub/user.c        |  7 ++-----
 4 files changed, 15 insertions(+), 31 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index e366df12d4a..282e13e163f 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -354,7 +354,6 @@ static const char *get_feature_xml(const char *p, const char **newp,
                                    GDBProcess *process)
 {
     CPUState *cpu = gdb_get_first_cpu_in_process(process);
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     GDBRegisterState *r;
     size_t len;
 
@@ -377,11 +376,11 @@ static const char *get_feature_xml(const char *p, const char **newp,
                          "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">"
                          "<target>"));
 
-            if (cc->gdb_arch_name) {
+            if (cpu->cc->gdb_arch_name) {
                 g_ptr_array_add(
                     xml,
                     g_markup_printf_escaped("<architecture>%s</architecture>",
-                                            cc->gdb_arch_name(cpu)));
+                                            cpu->cc->gdb_arch_name(cpu)));
             }
             for (guint i = 0; i < cpu->gdb_regs->len; i++) {
                 r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
@@ -520,11 +519,10 @@ GArray *gdb_get_register_list(CPUState *cpu)
 
 int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     GDBRegisterState *r;
 
-    if (reg < cc->gdb_num_core_regs) {
-        return cc->gdb_read_register(cpu, buf, reg);
+    if (reg < cpu->cc->gdb_num_core_regs) {
+        return cpu->cc->gdb_read_register(cpu, buf, reg);
     }
 
     for (guint i = 0; i < cpu->gdb_regs->len; i++) {
@@ -538,11 +536,10 @@ int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 
 static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     GDBRegisterState *r;
 
-    if (reg < cc->gdb_num_core_regs) {
-        return cc->gdb_write_register(cpu, mem_buf, reg);
+    if (reg < cpu->cc->gdb_num_core_regs) {
+        return cpu->cc->gdb_write_register(cpu, mem_buf, reg);
     }
 
     for (guint i = 0; i < cpu->gdb_regs->len; i++) {
@@ -570,7 +567,7 @@ static void gdb_register_feature(CPUState *cpu, int base_reg,
 
 void gdb_init_cpu(CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    CPUClass *cc = cpu->cc;
     const GDBFeature *feature;
 
     cpu->gdb_regs = g_array_new(false, false, sizeof(GDBRegisterState));
@@ -1646,11 +1643,8 @@ void gdb_extend_qsupported_features(char *qflags)
 
 static void handle_query_supported(GArray *params, void *user_ctx)
 {
-    CPUClass *cc;
-
     g_string_printf(gdbserver_state.str_buf, "PacketSize=%x", MAX_PACKET_LENGTH);
-    cc = CPU_GET_CLASS(first_cpu);
-    if (cc->gdb_core_xml_file) {
+    if (first_cpu->cc->gdb_core_xml_file) {
         g_string_append(gdbserver_state.str_buf, ";qXfer:features:read+");
     }
 
@@ -1697,7 +1691,6 @@ static void handle_query_supported(GArray *params, void *user_ctx)
 static void handle_query_xfer_features(GArray *params, void *user_ctx)
 {
     GDBProcess *process;
-    CPUClass *cc;
     unsigned long len, total_len, addr;
     const char *xml;
     const char *p;
@@ -1708,8 +1701,7 @@ static void handle_query_xfer_features(GArray *params, void *user_ctx)
     }
 
     process = gdb_get_cpu_process(gdbserver_state.g_cpu);
-    cc = CPU_GET_CLASS(gdbserver_state.g_cpu);
-    if (!cc->gdb_core_xml_file) {
+    if (!gdbserver_state.g_cpu->cc->gdb_core_xml_file) {
         gdb_put_packet("");
         return;
     }
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 416c1dbe1e9..dd22ff0fb3a 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -456,8 +456,6 @@ static int phy_memory_mode;
 int gdb_target_memory_rw_debug(CPUState *cpu, hwaddr addr,
                                uint8_t *buf, int len, bool is_write)
 {
-    CPUClass *cc;
-
     if (phy_memory_mode) {
         if (is_write) {
             cpu_physical_memory_write(addr, buf, len);
@@ -467,9 +465,8 @@ int gdb_target_memory_rw_debug(CPUState *cpu, hwaddr addr,
         return 0;
     }
 
-    cc = CPU_GET_CLASS(cpu);
-    if (cc->memory_rw_debug) {
-        return cc->memory_rw_debug(cpu, addr, buf, len, is_write);
+    if (cpu->cc->memory_rw_debug) {
+        return cpu->cc->memory_rw_debug(cpu, addr, buf, len, is_write);
     }
 
     return cpu_memory_rw_debug(cpu, addr, buf, len, is_write);
diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
index 4bfcf78aaab..43231e695e8 100644
--- a/gdbstub/user-target.c
+++ b/gdbstub/user-target.c
@@ -233,10 +233,8 @@ void gdb_handle_query_offsets(GArray *params, void *user_ctx)
 static inline int target_memory_rw_debug(CPUState *cpu, target_ulong addr,
                                          uint8_t *buf, int len, bool is_write)
 {
-    CPUClass *cc;
-    cc = CPU_GET_CLASS(cpu);
-    if (cc->memory_rw_debug) {
-        return cc->memory_rw_debug(cpu, addr, buf, len, is_write);
+    if (cpu->cc->memory_rw_debug) {
+        return cpu->cc->memory_rw_debug(cpu, addr, buf, len, is_write);
     }
     return cpu_memory_rw_debug(cpu, addr, buf, len, is_write);
 }
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 3730f32c415..67403e5a252 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -743,11 +743,8 @@ int gdb_continue_partial(char *newstates)
 int gdb_target_memory_rw_debug(CPUState *cpu, hwaddr addr,
                                uint8_t *buf, int len, bool is_write)
 {
-    CPUClass *cc;
-
-    cc = CPU_GET_CLASS(cpu);
-    if (cc->memory_rw_debug) {
-        return cc->memory_rw_debug(cpu, addr, buf, len, is_write);
+    if (cpu->cc->memory_rw_debug) {
+        return cpu->cc->memory_rw_debug(cpu, addr, buf, len, is_write);
     }
     return cpu_memory_rw_debug(cpu, addr, buf, len, is_write);
 }
-- 
2.47.1


