Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EC8D232C8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6RI-00067k-Op; Fri, 09 Jan 2026 01:57:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6QF-00056a-Rk
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:38 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6QD-0002uK-W2
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:35 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-bcfd82f55ebso1262236a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941792; x=1768546592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aeod3ku1ZvciysL5QBT9RVp5GEzJeCAgzafr1FJ8KfY=;
 b=PacspK4Md+E373Iy6S3OPUaItsRtpojeebzbJeFyo5D2nS53hIkuqhKV7rwlhX24EW
 H6YcRkbr2UDAWxm9U6D1HcVYOZ38rT5IFGj9vhcFf0h2XcPhAMae7wTeVLdpGZ3zFDIX
 PHCJ9rf/so8+a2/foN0skgH3eBY7DVASqUgbTXKLhcoSMZSIZniw9UVuf3CwhaNBn5nK
 UF2TTlqan3QSUcvY5lag5fqywmQ5JgkLYxpc1jIGHnv6n/SJQZPHKws0sVlnenUaBnLt
 msOHyg4NhnrZ41UE7TJqTVbETbMcpTBbMweETeGOg/TYntnFpDAViFdlG8/fAfeRrMxP
 e9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941792; x=1768546592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Aeod3ku1ZvciysL5QBT9RVp5GEzJeCAgzafr1FJ8KfY=;
 b=l5dQPJO2Tbhj6fjV7yhhL+QiTAajq40urBRx75+muwkDyuq5uOVoGb0WTF4JTKGjMd
 Q2azPVnwBbRfuop99j1bulBKuLpbY85zoJd9zZ+gN2y/ZmMbK5ki75930lvZub+LOZ7H
 0GZOLPYD5stnAs/7xojrLpLKx9/79LeidMdaexVYgV+GjVY7wIxEqafetjFvFXnetVcb
 to8yzkRD4RxyvHo0ABbYWTcRstreaCDsuCYFzJDd4I6qXpGsHT1hVJp893d7O7FYnQ5z
 jYsQ+4eSwIiML+nKghTl3VTVMISOg/xtkZVtQQvHBEB08koW1Hcu7DWPkhjpxlTCc3HS
 pWyQ==
X-Gm-Message-State: AOJu0YxWFcRWIdjocH1MUiLg01++Km+D/whCVwLzCHhKozaPL8ihlOtM
 vw5NBtfKIl8pRmBk6KOC6KganWcwUyGGILV7t/vEJ6XS5KXNJ/G8MCtEqD4tmA==
X-Gm-Gg: AY/fxX4kHITBIKdPsYh3Lead08wk+rbLD0DmMhQiGZi4VoLAJHVk+QNjkXC7lQ8S3Bn
 ixTih0shKSct7SkpmlRO1cNCQHfUXg/b7DBE5pAAS9esoOjLFp0uQgX9+6R0kkjFTq+2ecUnpeN
 RozzlZ5QlG02xmtwdDhTIHqPZaHAIlM10eClE6YyiPr3+hNhMr4ukofeH867PGUrcA2Pk1z09Fg
 zPPpDoGhOkiGQ3SZoz3aPlDY8vLPmOpaY2PDv/IptACfSIvBAWB7I2YQHE2/3kER+XPo/XjMJ2u
 RXScJQDHH0maUw9uIQ3lNKU8BjB6AK4n2ZX6G9IULfDzSGleWksDoJDRi+ICMPnEmeWUb+SQd3W
 4EX51Q5OdsTHIau5a48KkTy1eG6Wmz+d6+Kxw1IaWK6TNlNSIyNVxCPanNYkb8AFwgSCke71LLA
 I+UQL8jUJBmj1tmeKFaa6jzKCh9xyS+vsd0vZV2CEmLeoIuPKFiXucihY/2HA09V0jcY5f7vS4g
 jKLP6PLqHU4Cnon5TsVMEoS3mfbhA==
X-Google-Smtp-Source: AGHT+IHffFa2/mzenLvBqDMkQ0R7YUa4HA2oaym/mscNjL1HDVYd6Mfi5RukyBQizTKN6VGKmDc5DA==
X-Received: by 2002:a05:6a21:3281:b0:371:7666:648c with SMTP id
 adf61e73a8af0-3898eaae00dmr9143662637.24.1767941792274; 
 Thu, 08 Jan 2026 22:56:32 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:56:31 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 25/34] target/riscv: Add MIPS P8700 CSRs
Date: Fri,  9 Jan 2026 16:54:50 +1000
Message-ID: <20260109065459.19987-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Define MIPS CSRs used for P8700 CPU.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260108134128.2218102-4-djordje.todorovic@htecgroup.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h       |   3 +
 target/riscv/cpu.c       |   3 +
 target/riscv/mips_csr.c  | 217 +++++++++++++++++++++++++++++++++++++++
 target/riscv/meson.build |   1 +
 4 files changed, 224 insertions(+)
 create mode 100644 target/riscv/mips_csr.c

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 08a6e491f3..35d1f6362c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -985,5 +985,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 /* In th_csr.c */
 extern const RISCVCSR th_csr_list[];
 
+/* Implemented in mips_csr.c */
+extern const RISCVCSR mips_csr_list[];
+
 const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3562cbec32..e17b3e0785 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3317,6 +3317,9 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zbb = true,
         .cfg.marchid = 0x8000000000000201,
         .cfg.mvendorid = MIPS_VENDOR_ID,
+#ifndef CONFIG_USER_ONLY
+        .custom_csrs = mips_csr_list,
+#endif
     ),
 
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
diff --git a/target/riscv/mips_csr.c b/target/riscv/mips_csr.c
new file mode 100644
index 0000000000..822e25e346
--- /dev/null
+++ b/target/riscv/mips_csr.c
@@ -0,0 +1,217 @@
+/*
+ * MIPS-specific CSRs.
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "cpu_vendorid.h"
+
+/* Static MIPS CSR state storage */
+static struct {
+    uint64_t tvec;
+    uint64_t config[12];
+    uint64_t pmacfg[16];
+} mips_csr_state;
+
+/* MIPS CSR */
+#define CSR_MIPSTVEC        0x7c0
+#define CSR_MIPSCONFIG0     0x7d0
+#define CSR_MIPSCONFIG1     0x7d1
+#define CSR_MIPSCONFIG2     0x7d2
+#define CSR_MIPSCONFIG3     0x7d3
+#define CSR_MIPSCONFIG4     0x7d4
+#define CSR_MIPSCONFIG5     0x7d5
+#define CSR_MIPSCONFIG6     0x7d6
+#define CSR_MIPSCONFIG7     0x7d7
+#define CSR_MIPSCONFIG8     0x7d8
+#define CSR_MIPSCONFIG9     0x7d9
+#define CSR_MIPSCONFIG10    0x7da
+#define CSR_MIPSCONFIG11    0x7db
+#define CSR_MIPSPMACFG0     0x7e0
+#define CSR_MIPSPMACFG1     0x7e1
+#define CSR_MIPSPMACFG2     0x7e2
+#define CSR_MIPSPMACFG3     0x7e3
+#define CSR_MIPSPMACFG4     0x7e4
+#define CSR_MIPSPMACFG5     0x7e5
+#define CSR_MIPSPMACFG6     0x7e6
+#define CSR_MIPSPMACFG7     0x7e7
+#define CSR_MIPSPMACFG8     0x7e8
+#define CSR_MIPSPMACFG9     0x7e9
+#define CSR_MIPSPMACFG10    0x7ea
+#define CSR_MIPSPMACFG11    0x7eb
+#define CSR_MIPSPMACFG12    0x7ec
+#define CSR_MIPSPMACFG13    0x7ed
+#define CSR_MIPSPMACFG14    0x7ee
+#define CSR_MIPSPMACFG15    0x7ef
+
+static RISCVException any(CPURISCVState *env, int csrno)
+{
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipstvec(CPURISCVState *env, int csrno,
+                                    target_ulong *val)
+{
+    *val = mips_csr_state.tvec;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipstvec(CPURISCVState *env, int csrno,
+                                     target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.tvec = val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipsconfig(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val = mips_csr_state.config[csrno - CSR_MIPSCONFIG0];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipsconfig(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.config[csrno - CSR_MIPSCONFIG0] = val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipspmacfg(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val = mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipspmacfg(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0] = val;
+    return RISCV_EXCP_NONE;
+}
+
+const RISCVCSR mips_csr_list[] = {
+    {
+        .csrno = CSR_MIPSTVEC,
+        .csr_ops = { "mipstvec", any, read_mipstvec, write_mipstvec }
+    },
+    {
+        .csrno = CSR_MIPSCONFIG0,
+        .csr_ops = { "mipsconfig0", any, read_mipsconfig, write_mipsconfig }
+    },
+    {
+        .csrno = CSR_MIPSCONFIG1,
+        .csr_ops = { "mipsconfig1", any, read_mipsconfig, write_mipsconfig }
+    },
+    {
+        .csrno = CSR_MIPSCONFIG2,
+        .csr_ops = { "mipsconfig2", any, read_mipsconfig, write_mipsconfig }
+    },
+    {
+        .csrno = CSR_MIPSCONFIG3,
+        .csr_ops = { "mipsconfig3", any, read_mipsconfig, write_mipsconfig }
+    },
+    {
+        .csrno = CSR_MIPSCONFIG4,
+        .csr_ops = { "mipsconfig4", any, read_mipsconfig, write_mipsconfig }
+    },
+    {
+        .csrno = CSR_MIPSCONFIG5,
+        .csr_ops = { "mipsconfig5", any, read_mipsconfig, write_mipsconfig }
+    },
+    {
+        .csrno = CSR_MIPSCONFIG6,
+        .csr_ops = { "mipsconfig6", any, read_mipsconfig, write_mipsconfig }
+    },
+    {
+        .csrno = CSR_MIPSCONFIG7,
+        .csr_ops = { "mipsconfig7", any, read_mipsconfig, write_mipsconfig }
+    },
+    {
+        .csrno = CSR_MIPSCONFIG8,
+        .csr_ops = { "mipsconfig8", any, read_mipsconfig, write_mipsconfig }
+    },
+    {
+        .csrno = CSR_MIPSCONFIG9,
+        .csr_ops = { "mipsconfig9", any, read_mipsconfig, write_mipsconfig }
+    },
+    {
+        .csrno = CSR_MIPSCONFIG10,
+        .csr_ops = { "mipsconfig10", any, read_mipsconfig, write_mipsconfig }
+    },
+    {
+        .csrno = CSR_MIPSCONFIG11,
+        .csr_ops = { "mipsconfig11", any, read_mipsconfig, write_mipsconfig }
+    },
+    {
+        .csrno = CSR_MIPSPMACFG0,
+        .csr_ops = { "mipspmacfg0", any, read_mipspmacfg, write_mipspmacfg }
+    },
+    {
+        .csrno = CSR_MIPSPMACFG1,
+        .csr_ops = { "mipspmacfg1", any, read_mipspmacfg, write_mipspmacfg }
+    },
+    {
+        .csrno = CSR_MIPSPMACFG2,
+        .csr_ops = { "mipspmacfg2", any, read_mipspmacfg, write_mipspmacfg }
+    },
+    {
+        .csrno = CSR_MIPSPMACFG3,
+        .csr_ops = { "mipspmacfg3", any, read_mipspmacfg, write_mipspmacfg }
+    },
+    {
+        .csrno = CSR_MIPSPMACFG4,
+        .csr_ops = { "mipspmacfg4", any, read_mipspmacfg, write_mipspmacfg }
+    },
+    {
+        .csrno = CSR_MIPSPMACFG5,
+        .csr_ops = { "mipspmacfg5", any, read_mipspmacfg, write_mipspmacfg }
+    },
+    {
+        .csrno = CSR_MIPSPMACFG6,
+        .csr_ops = { "mipspmacfg6", any, read_mipspmacfg, write_mipspmacfg }
+    },
+    {
+        .csrno = CSR_MIPSPMACFG7,
+        .csr_ops = { "mipspmacfg7", any, read_mipspmacfg, write_mipspmacfg }
+    },
+    {
+        .csrno = CSR_MIPSPMACFG8,
+        .csr_ops = { "mipspmacfg8", any, read_mipspmacfg, write_mipspmacfg }
+    },
+    {
+        .csrno = CSR_MIPSPMACFG9,
+        .csr_ops = { "mipspmacfg9", any, read_mipspmacfg, write_mipspmacfg }
+    },
+    {
+        .csrno = CSR_MIPSPMACFG10,
+        .csr_ops = { "mipspmacfg10", any, read_mipspmacfg, write_mipspmacfg }
+    },
+    {
+        .csrno = CSR_MIPSPMACFG11,
+        .csr_ops = { "mipspmacfg11", any, read_mipspmacfg, write_mipspmacfg }
+    },
+    {
+        .csrno = CSR_MIPSPMACFG12,
+        .csr_ops = { "mipspmacfg12", any, read_mipspmacfg, write_mipspmacfg }
+    },
+    {
+        .csrno = CSR_MIPSPMACFG13,
+        .csr_ops = { "mipspmacfg13", any, read_mipspmacfg, write_mipspmacfg }
+    },
+    {
+        .csrno = CSR_MIPSPMACFG14,
+        .csr_ops = { "mipspmacfg14", any, read_mipspmacfg, write_mipspmacfg }
+    },
+    {
+        .csrno = CSR_MIPSPMACFG15,
+        .csr_ops = { "mipspmacfg15", any, read_mipspmacfg, write_mipspmacfg }
+    },
+    { },
+};
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index fdefe88ccd..25d59ef9f9 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -36,6 +36,7 @@ riscv_system_ss.add(files(
   'debug.c',
   'monitor.c',
   'machine.c',
+  'mips_csr.c',
   'pmu.c',
   'th_csr.c',
   'time_helper.c',
-- 
2.52.0


