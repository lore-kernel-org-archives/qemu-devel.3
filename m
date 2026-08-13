Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F0FC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 04:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuMpX-0000QD-Om; Thu, 13 Aug 2026 00:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wuMpU-0000Pp-KQ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 00:14:09 -0400
Received: from mail-pz2-x00.google.com ([2607:f8b0:4864:3b::])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wuMpQ-0000Re-Uv
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 00:14:08 -0400
Received: by mail-pz2-x00.google.com with SMTP id
 41be03b00d2f7-ca92f36c4acso523262a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786594441; x=1787199241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3XrzIrA1JuucWpBjA8Dkb9lEhb/qMMWIJ3x1kaDWT+c=;
 b=j25KtU4AAY/a1HhNtG+CVXbFZtxZzIQEhilhbfoKA/N5BdDRmolIcwy/JTedHb6rN0
 fMvKQFf7zaepkbPpRYrqmqQjNutdI9o5fxzVeqPQzejs1XoDzIJaDrrVQ4P+VWTo3UUD
 isJZjpfQ2qa/Z3qaN9aplm/yDzJFD6t7MrXAV3l9fTSyAKNap2bPKXOahaedqSwdME86
 w6gXN6pjJICCAXZotyuj9otANAhHLZ7ifJdjzIMsxTDcUrVfOBBOxYtbvX1gh1nxwjky
 t4Lhrn0VKp/aAXsi1YadyZCSDQEbCRj0/RFDNv3rr0hL3hH/OKqW8C7DCbBKJQ4Fim7q
 9hXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786594441; x=1787199241;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3XrzIrA1JuucWpBjA8Dkb9lEhb/qMMWIJ3x1kaDWT+c=;
 b=qj6c5uoeD1pbhIOQ/ChBMs6IfAlF4GFgrGuDfJxGIt7wbnDcdDc5TokKld2dNne3Bc
 Q9ZEXG+F6buwSyZD1tnWDsKGAb0Ml0OP5kwnL/LdjzN3lXtXPnT+iZkmDlRc+8oIJGfm
 beG3AtFGjxtWTnmqwWaa3yLe+EJXrrRrWtdyG/VOMgH7lLnXWyVklCGSt8XINl0sXmju
 fV0e9tVDY9ni88xfsctWfZZ8t4IpGzmMFnTR1DvObroP4IGVYsPxtbt2vQSDfV7pIhmD
 Z9wzDSIpvyUFlCUM0w8pqAOF8Ujbpq9rlApZ/tJFzizLWNxCuZtaNPfwsi8k0muZ7PPs
 6ZRg==
X-Gm-Message-State: AOJu0YwzgiA9FclIBzxogTVOHSZUWmrfkpPgRzZq1bPqGI5hp3TaJzNZ
 MAWGr+cLJ/fGtPIGp+8T32dQOFPnNF46RacBB946mQUmD1vNUdKCOpVL+Cc974bi8uo=
X-Gm-Gg: AR+sD13QvEttk16SihZ7p9ORSRRBnuAv70bLiTYB9ogYuy5Ym92/7LEPl9ZJlXKHtdY
 N6/0HCEEHuwa2M2+jfbwRgcMma4akq+EqOGIdhVk7kdnm0Mp7/Cg1KH2QonxyZVrSb4Oubgh5Iv
 NE43yPb4usLJCEQdCg2TC18LLgH/kNF1oWfNMayDmKKCbEzmA1tMA/ll4eibWD48JCAx00IH+GJ
 6lTbhEpATvu9sdT7mbB6wC2MtRYn+zxSf1HLOKwBeVLl/8QdexGMEnFN3wVYAHS/kA3ttHPsC3Q
 FC6X1ZQBKJQy+WcPBcnNwiGsOLaYxz5Xz+fpn/blFgb5B1eUNpYkAUxcW/Se0/Xs6VWOIgzPstU
 nMtbpiDTzHzmRLdZnzCiit2U5CEvKHljJ32gGS17knA2l/8ww1q7NsdidaMrnWnPKwwcAjMyf6N
 P4aJFZ/L801DtWq8vtEk1cy8l//mokBAlmXRGPJW2viKvt/EbePCwaG2n+hbB9T2qacMSTWkjCY
 Yqy3XsS1rZDyku/
X-Received: by 2002:a05:6a00:331b:b0:84c:1cd2:142e with SMTP id
 d2e1a72fcca58-84fc6e04488mr3122453b3a.23.1786594440970; 
 Wed, 12 Aug 2026 21:14:00 -0700 (PDT)
Received: from Dell-WorkStation.localdomain ([149.118.62.92])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef5cc4c9dsm423483a12.0.2026.08.12.21.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 21:14:00 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Zephyr Li <fritchleybohrer@gmail.com>
Subject: [PATCH] target/riscv: reject FMV.X.W and FMV.W.X with Zfinx
Date: Thu, 13 Aug 2026 12:13:03 +0800
Message-ID: <20260813041304.7618-1-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-pz2-x00.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Zfinx excludes FMV.X.W and FMV.W.X, but QEMU currently accepts both
instructions when Zfinx is enabled without the F extension.

Require the F extension for these instructions so they raise an illegal
instruction exception on Zfinx-only CPUs.

Add TCG regression tests for both instructions.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4108
Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
 target/riscv/tcg/insn_trans/trans_rvf.c.inc |  4 +--
 tests/tcg/riscv64/Makefile.target           | 10 +++++++
 tests/tcg/riscv64/test-zfinx-fmv-w-x.S      | 33 +++++++++++++++++++++
 tests/tcg/riscv64/test-zfinx-fmv-x-w.S      | 33 +++++++++++++++++++++
 4 files changed, 78 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-zfinx-fmv-w-x.S
 create mode 100644 tests/tcg/riscv64/test-zfinx-fmv-x-w.S

diff --git a/target/riscv/tcg/insn_trans/trans_rvf.c.inc b/target/riscv/tcg/insn_trans/trans_rvf.c.inc
index e935523c93..70c66e9e25 100644
--- a/target/riscv/tcg/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvf.c.inc
@@ -428,7 +428,7 @@ static bool trans_fmv_x_w(DisasContext *ctx, arg_fmv_x_w *a)
 {
     /* NOTE: This was FMV.X.S in an earlier version of the ISA spec! */
     REQUIRE_FPU;
-    REQUIRE_ZFINX_OR_F(ctx);
+    REQUIRE_EXT(ctx, RVF);
 
     TCGv dest = dest_gpr(ctx, a->rd);
     TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
@@ -531,7 +531,7 @@ static bool trans_fmv_w_x(DisasContext *ctx, arg_fmv_w_x *a)
 {
     /* NOTE: This was FMV.S.X in an earlier version of the ISA spec! */
     REQUIRE_FPU;
-    REQUIRE_ZFINX_OR_F(ctx);
+    REQUIRE_EXT(ctx, RVF);
 
     TCGv_i64 dest = dest_fpr(ctx, a->rd);
     TCGv src = get_gpr(ctx, a->rs1, EXT_ZERO);
diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
index 4da5b9a3b3..23e1152a10 100644
--- a/tests/tcg/riscv64/Makefile.target
+++ b/tests/tcg/riscv64/Makefile.target
@@ -18,3 +18,13 @@ TESTS += test-fcvtmod
 test-fcvtmod: CFLAGS += -march=rv64imafdc
 test-fcvtmod: LDFLAGS += -static
 run-test-fcvtmod: QEMU_OPTS += -cpu rv64,d=true,zfa=true
+
+TESTS += test-zfinx-fmv-x-w
+test-zfinx-fmv-x-w: LDFLAGS = -nostdlib -static
+run-test-zfinx-fmv-x-w: QEMU_OPTS += \
+	-cpu rv64,f=false,d=false,zfa=false,zfh=false,zfhmin=false,zfinx=true
+
+TESTS += test-zfinx-fmv-w-x
+test-zfinx-fmv-w-x: LDFLAGS = -nostdlib -static
+run-test-zfinx-fmv-w-x: QEMU_OPTS += \
+	-cpu rv64,f=false,d=false,zfa=false,zfh=false,zfhmin=false,zfinx=true
diff --git a/tests/tcg/riscv64/test-zfinx-fmv-w-x.S b/tests/tcg/riscv64/test-zfinx-fmv-w-x.S
new file mode 100644
index 0000000000..73c5c2b2bf
--- /dev/null
+++ b/tests/tcg/riscv64/test-zfinx-fmv-w-x.S
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include <asm/unistd.h>
+
+        .text
+        .globl  _start
+_start:
+        .option norvc
+
+        li      a0, 4
+        la      a1, sa
+        li      a2, 0
+        li      a3, 8
+        li      a7, __NR_rt_sigaction
+        scall
+
+        .word   0xf0030453
+
+        li      a0, 1
+        j       exit
+
+pass:
+        li      a0, 0
+
+exit:
+        li      a7, __NR_exit
+        scall
+
+        .data
+        .type   sa, @object
+        .size   sa, 32
+sa:
+        .dword  pass
+        .zero   24
diff --git a/tests/tcg/riscv64/test-zfinx-fmv-x-w.S b/tests/tcg/riscv64/test-zfinx-fmv-x-w.S
new file mode 100644
index 0000000000..c4e853036f
--- /dev/null
+++ b/tests/tcg/riscv64/test-zfinx-fmv-x-w.S
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include <asm/unistd.h>
+
+        .text
+        .globl  _start
+_start:
+        .option norvc
+
+        li      a0, 4
+        la      a1, sa
+        li      a2, 0
+        li      a3, 8
+        li      a7, __NR_rt_sigaction
+        scall
+
+        .word   0xe0030453
+
+        li      a0, 1
+        j       exit
+
+pass:
+        li      a0, 0
+
+exit:
+        li      a7, __NR_exit
+        scall
+
+        .data
+        .type   sa, @object
+        .size   sa, 32
+sa:
+        .dword  pass
+        .zero   24
-- 
2.43.0


