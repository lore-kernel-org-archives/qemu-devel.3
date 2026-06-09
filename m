Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE30FCD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWtB5-000706-Oz; Tue, 09 Jun 2026 05:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wWtAq-0006nT-Ss
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:55:12 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wWtAo-0004wg-TR
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:55:08 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bxt3jv4idqjTUSAA--.23862S3;
 Tue, 09 Jun 2026 17:54:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxSMHg4idqJrGgAA--.28412S15;
 Tue, 09 Jun 2026 17:54:54 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PULL 13/14] target/loongarch: Add macro CSR_OFFSET and CPU_CSR_OFFSET
Date: Tue,  9 Jun 2026 17:28:23 +0800
Message-Id: <20260609092824.227250-14-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260609092824.227250-1-gaosong@loongson.cn>
References: <20260609092824.227250-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxSMHg4idqJrGgAA--.28412S15
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bibo Mao <maobibo@loongson.cn>

Instruction rdtime is to read TSC timestamp and logic vCPU id,
it is also used by Linux user mode emulation. However function
get_csr_offset() cannot be called in user mode emulation, here
macro CSR_OFFSET and CPU_CSR_OFFSET are added. The added macro
can be called in both user emulation and system emulation.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Tested-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20260605083910.175647-1-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/csr.c                            | 4 ++--
 target/loongarch/csr.h                            | 3 +++
 target/loongarch/tcg/insn_trans/trans_extra.c.inc | 6 +++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
index d759be316b..309b826ca9 100644
--- a/target/loongarch/csr.c
+++ b/target/loongarch/csr.c
@@ -9,14 +9,14 @@
 #define CSR_OFF_FUNCS(NAME, FL, RD, WR)                    \
     [LOONGARCH_CSR_##NAME] = {                             \
         .name   = (stringify(NAME)),                       \
-        .offset = offsetof(CPULoongArchState, CSR_##NAME), \
+        .offset = CSR_OFFSET(CSR_##NAME),                  \
         .flags = FL, .readfn = RD, .writefn = WR           \
     }
 
 #define CSR_OFF_ARRAY(NAME, N)                                \
     [LOONGARCH_CSR_##NAME(N)] = {                             \
         .name   = (stringify(NAME##N)),                       \
-        .offset = offsetof(CPULoongArchState, CSR_##NAME[N]), \
+        .offset = CSR_OFFSET(CSR_##NAME[N]),                  \
         .flags = CSRFL_BASIC, .readfn = NULL, .writefn = NULL           \
     }
 
diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
index ca988c21db..6e17275546 100644
--- a/target/loongarch/csr.h
+++ b/target/loongarch/csr.h
@@ -8,6 +8,9 @@
 
 #include "cpu-csr.h"
 
+#define CSR_OFFSET(id)                  offsetof(CPULoongArchState, id)
+#define CPU_CSR_OFFSET(id, vm_level)    CSR_OFFSET(id)
+
 typedef void (*GenCSRFunc)(void);
 enum {
     CSRFL_READONLY = (1 << 0),
diff --git a/target/loongarch/tcg/insn_trans/trans_extra.c.inc b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
index 298a80cff5..655dce329e 100644
--- a/target/loongarch/tcg/insn_trans/trans_extra.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
@@ -3,6 +3,7 @@
  * Copyright (c) 2021 Loongson Technology Corporation Limited
  */
 
+#include "csr.h"
 static bool trans_break(DisasContext *ctx, arg_break *a)
 {
     generate_exception(ctx, EXCCODE_BRK);
@@ -46,13 +47,16 @@ static bool gen_rdtime(DisasContext *ctx, arg_rr *a,
 {
     TCGv dst1 = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv dst2 = gpr_dst(ctx, a->rj, EXT_NONE);
+    tcg_target_long offset;
 
     translator_io_start(&ctx->base);
     gen_helper_rdtime_d(dst1, tcg_env);
     if (word) {
         tcg_gen_sextract_tl(dst1, dst1, high ? 32 : 0, 32);
     }
-    tcg_gen_ld_i64(dst2, tcg_env, offsetof(CPULoongArchState, CSR_TID));
+
+    offset = CPU_CSR_OFFSET(CSR_TID, 0);
+    tcg_gen_ld_i64(dst2, tcg_env, offset);
 
     return true;
 }
-- 
2.54.0


