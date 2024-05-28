Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB08DC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmpd-0004OL-C9; Mon, 27 May 2024 22:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpb-0004Fq-QJ
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:44:55 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpZ-0003nT-Ed
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:44:55 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f480624d04so3222565ad.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 19:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716864292; x=1717469092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MDhqEB3afbuqQBasKQEWSnaR1QfgS0WX/aMKej21gLY=;
 b=gpIig6ytuyarLbgvdMNbAM5QY/ALCsfd6IIFKNG3WQE7b3vAfgRIMAmGdo6aD4sgmc
 962TqbbVcOOzF9Vrxsx64umMAkUdcguUikGBQKBq/nPVAGGRefqzy15LgSQn5ODwsSvV
 FBdi/VmI9KFTTaiALPC0kirbXyGfDTLzbkLWrbzbiifUg1hUOAik+68bOIyDVpWuqr3R
 lKD+CwB7L4eH7DJUSPwdragRsyjahy1ztbueZZHMQ8okfs5BNxk037NCk6hlQxsLRDSg
 hGKM/aJYA1avRuxObC12WenZoyPkgQclJLWbN/bL0NDaf6bCmYw7XEXfaCcrBsstrHee
 YTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716864292; x=1717469092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MDhqEB3afbuqQBasKQEWSnaR1QfgS0WX/aMKej21gLY=;
 b=LnBfK/yfxbDWaVbwnUsEEobvIUCY8K5vvkv6d/OuoJetgOMPem2paXWpsS9pnkpXoU
 ZER4VT4qu1872zOTVo/W6KNtVRQnVi9N+oV9VDKx7I17OIdnmR5u9naISNr+4lXO3Duk
 a3c+TtgcSp8lDpcs+MqIFX1ko4t0tlA1HxFcb0VJTbqL6WtRSC3j6yl1NITikMZgodqb
 6a8VzokfGd7WTJERFQ2FszSFlT23J2mZ/KmSyE8snJD5m8c9PPwmYmEzzODpHbhW52/R
 V6l500KY+yr2asTpVIJewG1nl1ootFAtGsa9caSnvk+5xAri4LBqDQ5JmJyASoIO6kbX
 AWJg==
X-Gm-Message-State: AOJu0YxAM7X343k3FR5Emo2O/459Op8KWe0jiGyjahaagkLO2G76e7t3
 3v4WKZNwM5HOuRcfyrUQsD9IrbqpA4uMa4dUwLcUQBWEj1ligv3pd3o80Q==
X-Google-Smtp-Source: AGHT+IFYuVj7MR/PjCJhrz+1Hf/yuYWk6h2qDpi5JwoOqJulT/owCROj6pjO8MXlOe7fKvn1dFSZDw==
X-Received: by 2002:a17:903:22c8:b0:1f3:6ac:fbcd with SMTP id
 d9443c01a7336-1f4497df62cmr141652575ad.44.1716864291632; 
 Mon, 27 May 2024 19:44:51 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970ca0sm70733225ad.142.2024.05.27.19.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 19:44:51 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 LIU Zhiwei <zhiwe_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 16/28] riscv: thead: Add th.sxstatus CSR emulation
Date: Tue, 28 May 2024 12:43:16 +1000
Message-ID: <20240528024328.246965-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528024328.246965-1-alistair.francis@wdc.com>
References: <20240528024328.246965-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Christoph Müllner <christoph.muellner@vrull.eu>

The th.sxstatus CSR can be used to identify available custom extension
on T-Head CPUs. The CSR is documented here:
  https://github.com/T-head-Semi/thead-extension-spec/blob/master/xtheadsxstatus.adoc

An important property of this patch is, that the th.sxstatus MAEE field
is not set (indicating that XTheadMae is not available).
XTheadMae is a memory attribute extension (similar to Svpbmt) which is
implemented in many T-Head CPUs (C906, C910, etc.) and utilizes bits
in PTEs that are marked as reserved. QEMU maintainers prefer to not
implement XTheadMae, so we need give kernels a mechanism to identify
if XTheadMae is available in a system or not. And this patch introduces
this mechanism in QEMU in a way that's compatible with real HW
(i.e., probing the th.sxstatus.MAEE bit).

Further context can be found on the list:
https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg00775.html

Reviewed-by: LIU Zhiwei <zhiwe_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Message-ID: <20240429073656.2486732-1-christoph.muellner@vrull.eu>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS              |  1 +
 target/riscv/cpu.h       |  3 ++
 target/riscv/cpu.c       |  1 +
 target/riscv/th_csr.c    | 79 ++++++++++++++++++++++++++++++++++++++++
 target/riscv/meson.build |  1 +
 5 files changed, 85 insertions(+)
 create mode 100644 target/riscv/th_csr.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 448dc951c5..e9d861e8ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -343,6 +343,7 @@ L: qemu-riscv@nongnu.org
 S: Supported
 F: target/riscv/insn_trans/trans_xthead.c.inc
 F: target/riscv/xthead*.decode
+F: target/riscv/th_*
 F: disas/riscv-xthead*
 
 RISC-V XVentanaCondOps extension
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 04ab0f153a..12d8b5344a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -826,4 +826,7 @@ target_ulong riscv_new_csr_seed(target_ulong new_value,
 uint8_t satp_mode_max_from_map(uint32_t map);
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 
+/* Implemented in th_csr.c */
+void th_register_custom_csrs(RISCVCPU *cpu);
+
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index abeb50369c..2946ac298a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -547,6 +547,7 @@ static void rv64_thead_c906_cpu_init(Object *obj)
     cpu->cfg.mvendorid = THEAD_VENDOR_ID;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_SV39);
+    th_register_custom_csrs(cpu);
 #endif
 
     /* inherited from parent obj via riscv_cpu_init() */
diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
new file mode 100644
index 0000000000..6c970d4e81
--- /dev/null
+++ b/target/riscv/th_csr.c
@@ -0,0 +1,79 @@
+/*
+ * T-Head-specific CSRs.
+ *
+ * Copyright (c) 2024 VRULL GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "cpu_vendorid.h"
+
+#define CSR_TH_SXSTATUS 0x5c0
+
+/* TH_SXSTATUS bits */
+#define TH_SXSTATUS_UCME        BIT(16)
+#define TH_SXSTATUS_MAEE        BIT(21)
+#define TH_SXSTATUS_THEADISAEE  BIT(22)
+
+typedef struct {
+    int csrno;
+    int (*insertion_test)(RISCVCPU *cpu);
+    riscv_csr_operations csr_ops;
+} riscv_csr;
+
+static RISCVException smode(CPURISCVState *env, int csrno)
+{
+    if (riscv_has_ext(env, RVS)) {
+        return RISCV_EXCP_NONE;
+    }
+
+    return RISCV_EXCP_ILLEGAL_INST;
+}
+
+static int test_thead_mvendorid(RISCVCPU *cpu)
+{
+    if (cpu->cfg.mvendorid != THEAD_VENDOR_ID) {
+        return -1;
+    }
+
+    return 0;
+}
+
+static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
+                                       target_ulong *val)
+{
+    /* We don't set MAEE here, because QEMU does not implement MAEE. */
+    *val = TH_SXSTATUS_UCME | TH_SXSTATUS_THEADISAEE;
+    return RISCV_EXCP_NONE;
+}
+
+static riscv_csr th_csr_list[] = {
+    {
+        .csrno = CSR_TH_SXSTATUS,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.sxstatus", smode, read_th_sxstatus }
+    }
+};
+
+void th_register_custom_csrs(RISCVCPU *cpu)
+{
+    for (size_t i = 0; i < ARRAY_SIZE(th_csr_list); i++) {
+        int csrno = th_csr_list[i].csrno;
+        riscv_csr_operations *csr_ops = &th_csr_list[i].csr_ops;
+        if (!th_csr_list[i].insertion_test(cpu)) {
+            riscv_set_csr_ops(csrno, csr_ops);
+        }
+    }
+}
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index a5e0734e7f..a4bd61e52a 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -33,6 +33,7 @@ riscv_system_ss.add(files(
   'monitor.c',
   'machine.c',
   'pmu.c',
+  'th_csr.c',
   'time_helper.c',
   'riscv-qmp-cmds.c',
 ))
-- 
2.45.1


