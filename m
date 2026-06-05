Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E0DCD6E7B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVQ41-0003Yp-QI; Fri, 05 Jun 2026 04:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wVQ3n-0003Oe-Az
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:37:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wVQ3j-00007t-SH
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:37:45 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8DxlnjViiJq_uQQAA--.21687S3;
 Fri, 05 Jun 2026 16:37:41 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJDxTMLMiiJqa72cAA--.32572S2;
 Fri, 05 Jun 2026 16:37:32 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v3 13/14] target/loongarch: Add macro CSR_OFFSET and
 CPU_CSR_OFFSET
Date: Fri,  5 Jun 2026 16:39:10 +0800
Message-ID: <20260605083910.175647-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605082552.175336-1-maobibo@loongson.cn>
References: <20260605082552.175336-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxTMLMiiJqa72cAA--.32572S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF1kZFW5Wr43Gw13Xw17CFX_yoW5XF1fpr
 4avrW7GF4UJrZ0y3s5J3Z0gFn8Xr1xGw42qa1S93s3Kay3tw1Iv3WvqwsI9Fy5Ja1UXr92
 qFyFyw17uF47X3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9qb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
 xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
 ZF0_GryDMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
 kI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E
 14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
 CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1U
 MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
 CTnIWIevJa73UjIFyTuYvjxUxGNtUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

Instruction rdtime is to read TSC timestamp and logic vCPU id,
it is also used by Linux user mode emulation. However function
get_csr_offset() cannot be called in user mode emulation, here
macro CSR_OFFSET and CPU_CSR_OFFSET are added. The added macro
can be called in both user emulation and system emulation.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
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


