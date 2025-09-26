Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998CECAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v28Q1-0006KH-Ip; Fri, 26 Sep 2025 09:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28Pz-0006I7-C2
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:23:23 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28Pq-0004wM-Ss
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:23:22 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so20607755e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 06:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758892987; x=1759497787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1CsXT4XW0gMpq2CgRKHDuuLo03s2cz6MrOCSkvlsK6s=;
 b=ItKDzA0Wcg0VCPuvBgKPzxQDFy+xm1qta1f/0A/0S74iB5uqCzi2fG9OUZDrZyjSX1
 96g29oOIv5Cl062DQZuotULZ8PbT8HK+uNZsd53+hjCoO3K+5FDr2I5AHlYF9R6ad5mE
 sZJ1Ph4hgpiyXfUeB7Kp8wqPZoJjNNaYtuCsxOA5rX88KGlm4BD0xoLD/xuwEe1PjjJx
 UJiyREgenfKtQI7rET70vbkognjfqkv/iKYHy5PPI8CKNzZddp34V+TjJDX36jwDaYEL
 x3n5mscfdPzs5MYKmD/HCsLnhp8ucPlRvprYcJETPMVTyxpk3Dd7djp9edOlRiPzYe8+
 H5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758892987; x=1759497787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1CsXT4XW0gMpq2CgRKHDuuLo03s2cz6MrOCSkvlsK6s=;
 b=AIGib42mGd4+SHqb46ngS10hJqvURcEFi0Z8rWtbmHG0GPU/+ujf+kCR3IVyy0m1Ea
 0Kabm9VMjs8VVnOeyd4SfvH1v6HiQQ3i28DxPY7lRAje0BpJ2vIa1ZsoLar9UEj4Vj1d
 ltrklQ2xXMc3nzJkVP2Q9l+2ovOUGAwtwkd0+GjMgK9OgBRX47iweJiwF3tmEZM1mYQD
 Xi1TaLRQ1t13u1hqWrFAuPSVpi3EukX3Hk68hod48qs8cTnYbdZNRAG4+2VUL17NzW3f
 h+MupC1MWUh88A8pxPrf+b4dru6DkbpfLq+NnaLyF6eiEVhgWglcl7F3/2mpm20dlDgH
 idJw==
X-Gm-Message-State: AOJu0Yymx3JJgkb+nOoWNahK0eqy3DV8j7PdMe5GlemN+4DBOkrHX/ea
 FsxmcB5oqxecle+b4KVSO6NZ3rEO3BM+Suex3B8Rh81KSXN30/r0QdGvRTprp80E3nU=
X-Gm-Gg: ASbGncuA6jah8UtvmmEkd+o+cAk737WTTQo8U2Am1mK1Ormtf2CdAktO91J2op3eGaE
 4OR/iCt8QC/JBD3AMmr1EHpHNOG0WV13dcjlA5RkhbvH06gDvszVlkbgchIQItZa/+cSgp1zOWG
 vyF2l0nbgUgPYjBuoZWENMaJQVnTNZqPYj5n/UzFlW6fWybtySw88HfE0V11xJ00wYn5L0Qs88Y
 C7xvpfAGV7/zXOP3aeOWEAP6WHTDYURK5DW/R33q69aTkqdXHdY774CDBN4OFp2BijJzraO8lli
 UHjY5UO+Cfi1IvzWGSR0i9ZuwPrjP14JengMyTJrVSg/fh5bCjf2Xgteyrz4ZlsGQG3Ng6tQrCJ
 /VUE+x7hB1JvsHvknuE/OtL4=
X-Google-Smtp-Source: AGHT+IEUwpE+AP/TaYfDp6K1Tih84aIrjrAO6KZLiKKPRfkEjPbVI4ebuHjqrja48tfLrLsJMKxjQA==
X-Received: by 2002:a05:600c:8b16:b0:45f:2bc1:22d0 with SMTP id
 5b1f17b1804b1-46e32aff787mr71465645e9.33.1758892987200; 
 Fri, 26 Sep 2025 06:23:07 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33be21casm38066685e9.2.2025.09.26.06.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 06:23:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CEE825F937;
 Fri, 26 Sep 2025 14:17:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 22/24] contrib/plugins/uftrace: implement x64 support
Date: Fri, 26 Sep 2025 14:17:41 +0100
Message-ID: <20250926131744.432185-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926131744.432185-1-alex.bennee@linaro.org>
References: <20250926131744.432185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

It's trivial to implement x64 support, as it's the same stack layout
as aarch64.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250902075042.223990-8-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250922093711.2768983-24-alex.bennee@linaro.org>

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index 2386cc723bc..b7d6124d2f5 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -82,6 +82,21 @@ typedef struct {
     struct qemu_plugin_register *reg_scr_el3;
 } Aarch64Cpu;
 
+typedef enum {
+    X64_RING0,
+    X64_RING1,
+    X64_RING2,
+    X64_RING3,
+    X64_REAL_MODE,
+    X64_PRIVILEGE_LEVEL_MAX,
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
@@ -570,6 +585,75 @@ static CpuOps aarch64_ops = {
     .does_insn_modify_frame_pointer = aarch64_does_insn_modify_frame_pointer,
 };
 
+static uint8_t x64_num_privilege_levels(void)
+{
+    return X64_PRIVILEGE_LEVEL_MAX;
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
@@ -777,6 +861,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     if (!strcmp(info->target_name, "aarch64")) {
         arch_ops = aarch64_ops;
+    } else if (!strcmp(info->target_name, "x86_64")) {
+        arch_ops = x64_ops;
     } else {
         fprintf(stderr, "plugin uftrace: %s target is not supported\n",
                 info->target_name);
-- 
2.47.3


