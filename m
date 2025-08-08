Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F887C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 02:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukCVx-0008Cp-11; Thu, 07 Aug 2025 22:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukCVt-000889-Un
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 22:07:23 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukCVr-0003Ur-1J
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 22:07:21 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-76bc5e68e26so1721607b3a.0
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 19:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754618836; x=1755223636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dcx/SXeVPZrEb+bZtbiVnjd582rVKcmddr3/xl05bmI=;
 b=CAarvhqM1BGK6KHqZ3gy7fpFXPrSaY89zCfQBkfE8pb/Xu6EMcUKYq5bm6H3APmKD0
 IKDC1HZBtrU52nnnJGqixQ5b47k0LLULsN1ER1svlRXgJ3CALGUWdDJQvsBJw1+W92c2
 Hmv52ITP0Tc8xlAccVlJUwz3JiZtISAT4a9AxIUMGX62+RTftapzPTLh6oupw//mO76R
 fn2esimtEngAqwRoQIglSxGAKZIK0HKbdexD/e5HBA0sEGPK0m8jYe0HgF+0y2WcyVDi
 pkvgA2tyczMOT0aSKwPGF7aUEh/k8PzCKdqfMPSnUiwumbrpXAtx1jecKloF9K1QJs5Y
 ETYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754618836; x=1755223636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dcx/SXeVPZrEb+bZtbiVnjd582rVKcmddr3/xl05bmI=;
 b=CKfW/7qp2DxumGnPTHc4O85/mCsxrxp8m4tyfM+yPxEzgt7eahSSt5Djveqq23NQYK
 annbClZGnLhaaE9CxzWieuJAfU09Ck4T3KSzWW82c16tFwfbliLNEVppZT+/D6BRZKDG
 zWpT/MzNara0Vc92zib5iY8P14F9Qeh1YCeEiPL3E8S1imHyMMjSUdbULKgirqQrE9Yf
 RpHGqyb2iL4ozAXuA0i9jNpYe9ZlkCPS9yx5hhXBb5hif5FyL3SwsY6FA+8id5flT7UL
 BFwzP5m9jyx9k7fxbuqWWLdjJtVpxGS5YfZqSLGwMHO/w2FhRbQK9AiBym6C+6xgyFK/
 JfAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjailiNfYXOSi13qf5Pq72/zLOxpri2KjbYgXZQK2AOx3u692+M5IVhcNb6c+KDgbvTw3hj+24CtIF@nongnu.org
X-Gm-Message-State: AOJu0YxvCkwIAFTW6OLipJS4ln+FaYv7s9/ODcK1iZ8r9QCJuWHr1tkz
 BC3RWSxLXWq00282dbu0Jr484VAveFHLyY69GSVzsnodtXS/qVlsJY0h9HBaLXH2T0c=
X-Gm-Gg: ASbGncvskmwTrKjLxjVTOmtBCSdWqsQvg3PCN8VQgNdECHO7Iff53Qeq+yIPYyYlhTy
 8FoMrhiuzFbCM5Fwbh+PBreOqwEsmf/OOMZ5mkt1EjVfU4xxhrrHFwr31Dbj81pwW56ShYO9niR
 CHIhh8N/6l1rHL4ssQ1A6N3X26w124SlP/BNH9E1krfI0wuCzp2SSyYLWDFZugBKc3aeA0Gopnb
 1IgF8wVQ5urRFyQSFVmS5/5hU3VFprfWVCwShDLkRTmfG/dupVdFMz9kp4dyepln+kkD8DH/QFZ
 n3WrEaJR1ZyvrDuOb3IVu7CNaRzPIyhLLAWKFzqsB+pOVU2CF/AVRV6XVAICU037jWIp5am4P6G
 ZCVrOOYzauEJocgvgUrn+OQ==
X-Google-Smtp-Source: AGHT+IF8XLaBIVTx/8gadg/Iq9ZQ7ERVwOg8wBFmMm5548X2y+Mpn2CxkUktlhSDYjR3OGuolT/UhA==
X-Received: by 2002:a05:6a20:6a1c:b0:23f:fbb1:c229 with SMTP id
 adf61e73a8af0-24054d788a7mr1720360637.0.1754618836075; 
 Thu, 07 Aug 2025 19:07:16 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b428ba4cf35sm3705433a12.14.2025.08.07.19.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 19:07:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: pierrick.bouvier@linaro.org,
	qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 7/9] contrib/plugins/uftrace: implement x64 support
Date: Thu,  7 Aug 2025 19:07:00 -0700
Message-ID: <20250808020702.410109-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

It's trivial to implement x64 support, as it's the same stack layout
than aarch64.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace.c | 85 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index 6628b4256fd..f10172eed10 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -79,6 +79,20 @@ typedef struct {
     struct qemu_plugin_register *reg_scr_el3;
 } Aarch64Cpu;
 
+typedef enum {
+    X64_RING0,
+    X64_RING1,
+    X64_RING2,
+    X64_RING3,
+    X64_REAL_MODE,
+} X64PrivilegeLevel;
+
+typedef struct {
+    struct qemu_plugin_register *reg_rbp;
+    struct qemu_plugin_register *reg_cs;
+    struct qemu_plugin_register *reg_cr0;
+} X64Cpu;
+
 typedef struct {
     uint64_t timestamp;
     uint64_t data;
@@ -565,6 +579,75 @@ static CpuOps aarch64_ops = {
     .does_insn_modify_frame_pointer = aarch64_does_insn_modify_frame_pointer,
 };
 
+static uint8_t x64_num_privilege_levels(void)
+{
+    return X64_REAL_MODE + 1;
+}
+
+static const char *x64_get_privilege_level_name(uint8_t pl)
+{
+    switch (pl) {
+    case X64_RING0: return "Ring0";
+    case X64_RING1: return "Ring1";
+    case X64_RING2: return "Ring2";
+    case X64_RING3: return "Ring3";
+    case X64_REAL_MODE: return "RealMode";
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static uint8_t x64_get_privilege_level(Cpu *cpu_)
+{
+    X64Cpu *cpu = cpu_->arch;
+    uint64_t cr0 = cpu_read_register64(cpu_, cpu->reg_cr0);
+    uint64_t protected_mode = (cr0 >> 0) & 0b1;
+    if (!protected_mode) {
+        return X64_REAL_MODE;
+    }
+    uint32_t cs = cpu_read_register32(cpu_, cpu->reg_cs);
+    uint32_t ring_level = (cs >> 0) & 0b11;
+    return ring_level;
+}
+
+static uint64_t x64_get_frame_pointer(Cpu *cpu_)
+{
+    X64Cpu *cpu = cpu_->arch;
+    return cpu_read_register64(cpu_, cpu->reg_rbp);
+}
+
+static void x64_init(Cpu *cpu_)
+{
+    X64Cpu *cpu = g_new0(X64Cpu, 1);
+    cpu_->arch = cpu;
+    cpu->reg_rbp = plugin_find_register("rbp");
+    g_assert(cpu->reg_rbp);
+    cpu->reg_cs = plugin_find_register("cs");
+    g_assert(cpu->reg_cs);
+    cpu->reg_cr0 = plugin_find_register("cr0");
+    g_assert(cpu->reg_cr0);
+}
+
+static void x64_end(Cpu *cpu)
+{
+    g_free(cpu->arch);
+}
+
+static bool x64_does_insn_modify_frame_pointer(const char *disas)
+{
+    return strstr(disas, "rbp");
+}
+
+static CpuOps x64_ops = {
+    .init = x64_init,
+    .end = x64_end,
+    .get_frame_pointer = x64_get_frame_pointer,
+    .get_privilege_level = x64_get_privilege_level,
+    .num_privilege_levels = x64_num_privilege_levels,
+    .get_privilege_level_name = x64_get_privilege_level_name,
+    .does_insn_modify_frame_pointer = x64_does_insn_modify_frame_pointer,
+};
+
 static void track_privilege_change(unsigned int cpu_index, void *udata)
 {
     Cpu *cpu = qemu_plugin_scoreboard_find(score, cpu_index);
@@ -771,6 +854,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     if (!strcmp(info->target_name, "aarch64")) {
         arch_ops = aarch64_ops;
+    } else if (!strcmp(info->target_name, "x86_64")) {
+        arch_ops = x64_ops;
     } else {
         fprintf(stderr, "plugin uftrace: %s target is not supported\n",
                 info->target_name);
-- 
2.47.2


