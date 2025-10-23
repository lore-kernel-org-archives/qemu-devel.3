Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2027DCCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBn31-0003b2-VX; Thu, 23 Oct 2025 00:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn30-0003ao-7L
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:35:34 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn2x-0001Le-Eo
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:35:33 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-27ee41e074dso3610755ad.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761194129; x=1761798929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yKNfPhQybkr+kdghjTk1+NTs/BYrMKh7K92oxFd3u+0=;
 b=TOyjEzJndd7LHYR6n4h/b5qUBBnAwk8T/iso21j50lNFFk3Ktowi1TE8o+YJNhM0mw
 ZIbl8+zcbGZLSfh2akPU3ItDNFOl5sU4CPGsVLtUyBt2axYwfk9ELNiCjKSk8xlQdvWQ
 xUHdStwBPD4wyDNkZsbHDyTTI6sKA4QBPfvOMNi4rDkjiC7ekvbfbtvzUL8AKRxjqpDQ
 +ZXOaTthgsHeHMFKED2OxyhFXes7ZPZdrJIL8d8gToOtwtk3oDk+O6j+V0mhaO1avHna
 dnHyeZkcoHeeyI7HoF+9U16EDeAP8Fh6LuQy94kriLa1qtRoxbP/wpEnRSwWIjFsYOjc
 QeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761194129; x=1761798929;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yKNfPhQybkr+kdghjTk1+NTs/BYrMKh7K92oxFd3u+0=;
 b=YD80PBChBg9WhysbQAxu9qKLJFUrKek/KzoE3SiefaJQCThqnr0oybF7J7NP1tIo1F
 vT51VRCA7WW0PCdKGwyYp+tL3ftrvBwzpju8EAd0yt+6xDmC84337z+VDr0FIkkazX/C
 c8rocjNi7pWgvGu9PjZx9Yhf2DjmSgpfE2ui9OHKIYzjUBgE4QGwsE3lUffCQynfLGgI
 OOQZCvlBhgqcAnQ32UIiCdEBBwD3NWjDIT/J5K9eOgdD7i68/oMofFUtIJPIG0yG+zAn
 M+1FFCknHT4HCtH3mjAblfdu4ktVeA9g6a3x/hyd+YW4l7hVA4mDc7T2telXOD5Hzlqs
 CYlA==
X-Gm-Message-State: AOJu0Yyx2z1BZKMbMg6zul2e4YUchbeExjkZF73hAjg0ZG81xXzS1Wte
 Z3j0YfiuPxGLQvyMAlD+eh846QctsLPODP6gRpUME8doD1vxZk/b6/sOjQ31WQ==
X-Gm-Gg: ASbGncv5aN5tCQ8WcPiBvv3H4JMSnkKOP3z7ehjTY8kGqKSEpNCtikhcP1WZhlkeMcW
 NG+dtFtP1LytzoleJVN6JWN98uxVJfxKa6I+WT5aj/AcJUfrr1mPCnCAD5B7gkHXrwgIldzao0t
 jllzpzze6fOOA6FcskoznlzTN611JyYgbskPgvedN+27rAKNOQQDTOUMw+rtqBb5sRD/lvQI6Nu
 zpx04v9oyK7BdXADto/ZPWD/5BkmDTv6bdfMZ6VY2Ymh3pvBm0AEz5wzYOQt90SGxfgFJ4saH+d
 CJ/RsbQbnKEXdlvP90jnwXJmhhDA3pURO+gEZEv0SKu7bGkcyyJz9uLigf/zBe3cJ3bXgYhSlKr
 2yo03hydx6Lh1d49uqZb5hNQvjSzKtrdMtFzvUlQyWGXM4izViIdQaMkMxt4RI0GLOHFVncnS+n
 yZreBghn7+HUFGLmuzIgI6HcKVfwhfz8tzqhkTIgsz+gpxyrMrAzB32ypjHf9cri2FanGswiHmQ
 88YRQNj
X-Google-Smtp-Source: AGHT+IG7/VKdWM3jibVRfGTgu2d7m1W9/DZlKjURxqj/fL24EiWxwm9vKXMuE4/ueHMTv0Eg5t1Tsg==
X-Received: by 2002:a17:902:dac2:b0:275:2328:5d3e with SMTP id
 d9443c01a7336-290c9ca32f9mr304534045ad.18.1761194129220; 
 Wed, 22 Oct 2025 21:35:29 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dfc113csm8643015ad.68.2025.10.22.21.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:35:28 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 22/37] target/riscv: Add MIPS P8700 CSRs
Date: Thu, 23 Oct 2025 14:35:05 +1000
Message-ID: <20251023043520.1777130-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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
Message-ID: <20251018154522.745788-5-djordje.todorovic@htecgroup.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h       |   3 +
 target/riscv/cpu.c       |   3 +
 target/riscv/mips_csr.c  | 217 +++++++++++++++++++++++++++++++++++++++
 target/riscv/meson.build |   1 +
 4 files changed, 224 insertions(+)
 create mode 100644 target/riscv/mips_csr.c

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0ac31e5c61..00ac947772 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -988,5 +988,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 /* In th_csr.c */
 extern const RISCVCSR th_csr_list[];
 
+/* Implemented in mips_csr.c */
+extern const RISCVCSR mips_csr_list[];
+
 const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f05747a2d2..a52e6b7b7a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3297,6 +3297,9 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
2.51.0


