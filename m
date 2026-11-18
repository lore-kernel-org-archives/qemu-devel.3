Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D8C606A333
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 09:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=W9O/EXim
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTbYr-0008Ir-HR; Wed, 18 Nov 2026 04:02:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xTbYg-0008G1-KD; Wed, 18 Nov 2026 04:02:27 -0500
Received: from [115.124.30.110] (helo=out30-110.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xTbYc-000427-4L; Wed, 18 Nov 2026 04:02:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1794992517; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=CPuc4IitNHQxIm1Asdg17+hQBNpZhswNQTFjaeNZzSA=;
 b=W9O/EXimMiq8mA+ZEXQLsPucKi53nNWQsOCmGTwTmqeQpO+l2skQP+Qfo//7RN60SgB3chEEom9LukrZ7u1tsGzFw5lr+vFoPwJgFUegPCfA5IEpQ2QGF23tWkJ2gA61EE/Za9BX8Dj3PR2++XQR6+HXUKjwgXRqSo831Mr0t58=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0XF0GqhO_1794992515; 
Received: from
 riscv-project-v011122129236.ea134.tbsite.net(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XF0GqhO_1794992515 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 18 Nov 2026 17:01:56 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Wed, 18 Nov 2026 17:01:29 +0800
Subject: [PATCH RFC 2/8] target/riscv: Share instruction length helper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-zl-master-v1-2-129f85e0f887@linux.alibaba.com>
References: <20261118-zl-master-v1-0-129f85e0f887@linux.alibaba.com>
In-Reply-To: <20261118-zl-master-v1-0-129f85e0f887@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794992514; l=2775;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=fo4C3Qe0dkkrVp0HxkU905ZdgXelCU2FK4nYM3RyjPM=;
 b=XkozzhC7ndeLuo5oZOsotqXbUua2koXEWhLPLxMdOMX3SeHg78iLDX0/kkhnMepd+bcGmSB1F
 97kTf980NtqA19Vlaod8s8Mpnp2dAK/XyZ+zpSgno+mzSIWuL0aB6Fv
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.110 (deferred)
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The translator and built-in disassembler duplicate the 16/32-bit length
rule. Move it into a shared header.

Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 disas/riscv.c              |  9 ++-------
 target/riscv/insn_length.h | 12 ++++++++++++
 target/riscv/internals.h   |  6 +-----
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index eb4851b4cd4b14a43cc6592bd5011c6df53ec219..8c9e06b46f19efd6aa9f605ccd0bf3716fa62d44 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -21,6 +21,7 @@
 #include "qemu/bitops.h"
 #include "disas/dis-asm.h"
 #include "target/riscv/cpu_cfg.h"
+#include "target/riscv/insn_length.h"
 #include "disas/riscv.h"
 
 /* Vendor extensions */
@@ -3170,12 +3171,6 @@ static bool check_constraints(rv_decode *dec, const rvc_constraint *c)
     return true;
 }
 
-/* Same as insn_len() from target/riscv/internals.h */
-static size_t inst_length(rv_inst inst)
-{
-    return (inst & 3) == 3 ? 4 : 2;
-}
-
 /* format instruction */
 
 static GString *format_inst(size_t tab, rv_decode *dec,
@@ -3515,7 +3510,7 @@ print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_isa isa)
         }
         inst |= ((rv_inst) bfd_getl16(packet)) << (8 * n);
         if (n == 0) {
-            len = inst_length(inst);
+            len = insn_len(inst);
         }
     }
 
diff --git a/target/riscv/insn_length.h b/target/riscv/insn_length.h
new file mode 100644
index 0000000000000000000000000000000000000000..bfb3af0e6358249daf464fed670f09d7184d307b
--- /dev/null
+++ b/target/riscv/insn_length.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* RISC-V instruction length classification. */
+
+#ifndef TARGET_RISCV_INSN_LENGTH_H
+#define TARGET_RISCV_INSN_LENGTH_H
+
+static inline int insn_len(uint16_t first_word)
+{
+    return (first_word & 3) == 3 ? 4 : 2;
+}
+
+#endif
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 5466879a4aa541db8d6753c7e1eec8f3128a99c8..2d48abeef5dea2cb9d0e97852495fed75d670ae1 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -23,6 +23,7 @@
 #include "hw/core/registerfields.h"
 #include "fpu/softfloat-types.h"
 #include "target/riscv/cpu_bits.h"
+#include "target/riscv/insn_length.h"
 
 /*
  * The current MMU Modes are:
@@ -259,11 +260,6 @@ static inline target_ulong adjust_addr_virt(CPURISCVState *env,
     return adjust_addr_body(env, addr, true);
 }
 
-static inline int insn_len(uint16_t first_word)
-{
-    return (first_word & 3) == 3 ? 4 : 2;
-}
-
 int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
                                       int64_t *pval);
 

-- 
2.43.0


