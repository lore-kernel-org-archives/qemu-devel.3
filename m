Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA1CACC6B2D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 03:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHBzj-0006mR-Sm; Wed, 14 Oct 2026 23:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xHBzg-0006l3-NO
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:19:01 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xHBze-0006l5-JC
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:19:00 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-89a837bf00eso394496b3a.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792034337; x=1792639137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dgo2XhJWzYeIm74eJEIkWqQP5o4rena+PUi0auaTe00=;
 b=JFO785pgDFhc7AMZqZsuOFACAiIq8uWVjgHs+aUEZr0CCGx5z28eM5XnBA807auGL5
 CO8HZDJ27YHfxYxQUrrMrHaQO7PCGg/FVeZCTUIfrHA+BTcj3w4tIDsUgVz85sQc5pQS
 CyrsZFCnlkZZ+huW8edgzlcsp38tAC7kCJ81q6ir3NGbe/pAfTvTHvNOxiobsEx8Oebt
 IJFSWL9P47G0dnp8jv99t1fonyugNhl9FDitxqDJKKRWrG5Jau2Ao2fyGMv9WF6G/2fM
 RZf+MawTahMnIPn6V5ER7PFT10NDJbtHq21F7rGEHI4TwVkkF0O663c8+SVSoZLnVrzb
 WddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792034337; x=1792639137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dgo2XhJWzYeIm74eJEIkWqQP5o4rena+PUi0auaTe00=;
 b=bbYOsn7bn4xfPjpR0waVeUwXjI0ZRKJWyseVT/YVYoQq1wNfEMR9fiYlhPRWx5WSNT
 K5zifcK++tZbnue9FCoIh4l1b3Q91/k5on9uIAL7S0K8W7GqG8omoukLbxAeAzBVrDYq
 8QRfsFstKhDti5e/YaW8t6BPDQ5UkhJaUphEWJBiJjPQ8ZzPr8Zimdh/WjOIUnkHkdli
 KPlKRTqSFno886Rl7yiRWBD5U0bCo8+kwrwQU4ULV6Ac+rn399BuFVVYy3/5n1QgBpIP
 W1gMJGojDDlBHWo2iBnbyjCpLnzG4zTj3mxqyYaDv9shDC3tjqzE4l3DqKdEi0XhdJp/
 y1Wg==
X-Gm-Message-State: AFq9FYKMOnOwneVxCRF3TW1fZH28Oa3ePR1z7DPEhTzMGvxGdXAG2FCu
 mpnU8/K5GwjQjJ+S8AUDZzeDzE591xo//DULycRTqcjfOje7eKq+s3ric4DmDXEfDeWXuzU8EZP
 SJzE7/Hw=
X-Gm-Gg: AYBFou288AK9qvsog6+jdl7TD5nIXT0ZmcXpvq1QdKqh7K9DkvveQnwVRayrv4AKseu
 CdkQ1W8biblVr/o2N4gjotlZockBH+uMKmc2Vhv7wrQOpHZdIDSKj0VBTrS/5qSl6a96JBdkxhj
 VZEhdJhBkuhwcNsVSNa1HRxlplSQdTRurw2MzpiR49r+wLr9nYICQJ/wAB7ajSKYnR8oorxduQ8
 ErzHa7Tdo7OXQn2lNo1SGSjvaHMpO5kewixjHdfvgRf9OJaxen045SeUyGS3KtPJwu4zwdEQhfa
 qpPE0gJir8wuOHLCxE0j6U1N8TzstUj1XLL2BQggbQl1qzgKw1zmfvwMvbDFrD3t/mibGaY+hyk
 Yl4rUcGfCCNzTyOHzvU2hXsayV76gWymnrXlc5E4NtMk4lUVoppR1D5oxf21qWsmTyBE7qB7Z6I
 c6M+3sSwNkw8JqjoVizgzdM+6eyrqTs//Zt2aCeOsNpLRTf9bzrW4lsgZErpAKbUSRP35C+jUeS
 O19QQgnzZoi8zczEjoQ9ZW/TfG/utFQoG6ffy77TqWLjT0qDVdue61+BQ==
X-Received: by 2002:a17:90a:d44d:b0:3a0:c162:51af with SMTP id
 98e67ed59e1d1-3ab39fed8b6mr23577980a91.0.1792034337268; 
 Wed, 14 Oct 2026 20:18:57 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac93049ec2sm1321725a91.1.2026.10.14.20.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 20:18:56 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>
Subject: [PATCH 06/12] target/riscv: Add Tenstorrent Real-time CPU
Date: Thu, 15 Oct 2026 13:17:58 +1000
Message-ID: <20261015031804.2406055-7-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015031804.2406055-1-portias@oss.tenstorrent.com>
References: <20261015031804.2406055-1-portias@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=portias@tenstorrent.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The RCPU is a high-performance 32-bit RISC-V embedded processor featuring
a 6-stage, dual-issue superscalar pipeline, with tightly-coupled memories
(TCMs), advanced interrupt controller (CLIC), and comprehensive
debug/trace capabilities. It is designed for real-time, system
management, and safety-critical applications requiring deterministic
execution and low interrupt latency. See the Atlantis Datasheet, section
2.2 for more information [1].

The Atlantis SoC includes an RCPU used for boot, low-level control, and
ongoing system management [1]. This adds a cpu entry for the RCPU
and implementation specific CSRs. The CSRs are stubbed to allow code to
run without exceptions but does not implement their functionality.

[1] https://github.com/tenstorrent/atlantis-soc-docs/blob/main/data_sheet/atl_soc_data_sheet.pdf

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 MAINTAINERS                  |  1 +
 target/riscv/cpu-qom.h       |  1 +
 target/riscv/cpu.c           | 28 +++++++++++++++++
 target/riscv/tcg/csr.h       |  3 ++
 target/riscv/tcg/meson.build |  1 +
 target/riscv/tcg/tt_csr.c    | 58 ++++++++++++++++++++++++++++++++++++
 6 files changed, 92 insertions(+)
 create mode 100644 target/riscv/tcg/tt_csr.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8cc426451c..b5b019b3e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1847,6 +1847,7 @@ R: Portia Stephens <portias@oss.tenstorrent.com>
 L: qemu-riscv@nongnu.org
 S: Supported
 F: docs/system/riscv/tt_*.rst
+F: target/riscv/tcg/tt_*.c
 F: hw/misc/tt_*.c
 F: hw/riscv/tt_*.c
 F: include/hw/misc/tt_*.h
diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 61234842e3..72570ed47e 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -57,6 +57,7 @@
 #define TYPE_RISCV_CPU_THEAD_C908V      RISCV_CPU_TYPE_NAME("thead-c908v")
 #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
+#define TYPE_RISCV_CPU_TT_RCPU          RISCV_CPU_TYPE_NAME("tt-rcpu")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
 #define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kunminghu")
 #define TYPE_RISCV_CPU_MIPS_P8700       RISCV_CPU_TYPE_NAME("mips-p8700")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a682350d28..fdedf16ebe 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3455,6 +3455,34 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.pmp_regions = 8
     ),
 
+#if defined(TARGET_RISCV32) || \
+    (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_TT_RCPU, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV32,
+        .misa_ext = RVI | RVM | RVA | RVB | RVC | RVD | RVF | RVU,
+        .priv_spec = PRIV_VERSION_1_13_0,
+
+        .cfg.mmu = false,
+        .cfg.ext_zbc = true,
+
+        .cfg.ext_zba = true,
+        .cfg.ext_zbb = true,
+        .cfg.ext_zbs = true,
+        .cfg.ext_zca = true,
+        .cfg.ext_zcb = true,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zicsr = true,
+        .cfg.ext_zicbom = true,
+        .cfg.ext_zicntr = true,
+        .cfg.ext_zihpm = true,
+        .cfg.ext_zicond = true,
+        .cfg.pmp = true,
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+        .custom_csrs = tt_csr_list,
+#endif
+    ),
+#endif
+
 #if defined(TARGET_RISCV32) || \
     (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
diff --git a/target/riscv/tcg/csr.h b/target/riscv/tcg/csr.h
index 53ba3b4a4d..4bc55b70d6 100644
--- a/target/riscv/tcg/csr.h
+++ b/target/riscv/tcg/csr.h
@@ -87,6 +87,9 @@ extern const RISCVCSR th_csr_list[];
 /* Implemented in mips_csr.c */
 extern const RISCVCSR mips_csr_list[];
 
+/* In tt_csr.c */
+extern const RISCVCSR tt_csr_list[];
+
 /* PMP CSRs, defined in pmp.c */
 void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
                       target_ulong val);
diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
index 86805b30cb..77357475c3 100644
--- a/target/riscv/tcg/meson.build
+++ b/target/riscv/tcg/meson.build
@@ -25,6 +25,7 @@ riscv_system_ss.add(files(
   'pmp.c',
   'pmu.c',
   'th_csr.c',
+  'tt_csr.c',
 ))
 
 
diff --git a/target/riscv/tcg/tt_csr.c b/target/riscv/tcg/tt_csr.c
new file mode 100644
index 0000000000..c76cd1a9cb
--- /dev/null
+++ b/target/riscv/tcg/tt_csr.c
@@ -0,0 +1,58 @@
+/*
+ * Tenstorrent CPU implementation specifics.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright 2026 Tenstorrent
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "target/riscv/tcg/csr.h"
+
+/* RCPU custom CSRs */
+#define RCPU_CSR_MICACHE          0x7c0
+#define RCPU_CSR_MDCACHE          0x7c1
+#define RCPU_CSR_MITCMCR          0x7c5
+#define RCPU_CSR_MDTCMCR          0x7c6
+#define RCPU_CSR_MHCR             0x7c7
+#define RCPU_CSR_MEXINFO          0x7ca
+#define RCPU_CSR_MNMIE            0xbc6
+
+/* predicate for an RCPU core */
+static RISCVException any(CPURISCVState *env, int csrno)
+{
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_zero(CPURISCVState *env, int csrno,
+                                target_ulong *val)
+{
+    *val = 0;
+
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_none(CPURISCVState *env, int csrno,
+                                 target_ulong val, uintptr_t ra)
+{
+    return RISCV_EXCP_NONE;
+}
+
+const RISCVCSR tt_csr_list[] = {
+    { .csrno = RCPU_CSR_MICACHE,
+      .csr_ops = { "micache", any, read_zero, write_none} },
+    { .csrno = RCPU_CSR_MDCACHE,
+      .csr_ops = { "mdcache", any, read_zero, write_none} },
+    { .csrno = RCPU_CSR_MITCMCR,
+      .csr_ops = { "mitcmcr", any, read_zero, write_none} },
+    { .csrno = RCPU_CSR_MDTCMCR,
+      .csr_ops = { "mdtcmcr", any, read_zero, write_none} },
+    { .csrno = RCPU_CSR_MHCR,
+      .csr_ops = { "mhcr", any, read_zero, write_none} },
+    { .csrno = RCPU_CSR_MEXINFO,
+      .csr_ops = { "mexinfo", any, read_zero, write_none} },
+    { .csrno = RCPU_CSR_MNMIE,
+       .csr_ops = { "mnmie", any, read_zero, write_none} },
+    { },
+};
-- 
2.43.0


