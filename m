Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3989CD6E79
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWtB6-00071Y-F3; Tue, 09 Jun 2026 05:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wWtAq-0006nQ-Gt
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:55:12 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wWtAo-0004w1-De
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:55:08 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxLurt4idqiDUSAA--.48158S3;
 Tue, 09 Jun 2026 17:54:54 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxSMHg4idqJrGgAA--.28412S12;
 Tue, 09 Jun 2026 17:54:53 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PULL 10/14] linux-user/loongarch64: Use sys_state when accessing CSR
 registers
Date: Tue,  9 Jun 2026 17:28:20 +0800
Message-Id: <20260609092824.227250-11-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260609092824.227250-1-gaosong@loongson.cn>
References: <20260609092824.227250-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxSMHg4idqJrGgAA--.28412S12
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

When accessing CSR registers in directory linux-user/loongarch64/, use
sys_state rather than env. There is no function change.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Tested-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20260605083844.175612-1-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 linux-user/loongarch64/cpu_loop.c |  5 +++--
 linux-user/loongarch64/elfload.c  |  4 +++-
 linux-user/loongarch64/signal.c   | 16 ++++++++++------
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/linux-user/loongarch64/cpu_loop.c b/linux-user/loongarch64/cpu_loop.c
index 603fcc39c7..27d6eef5cb 100644
--- a/linux-user/loongarch64/cpu_loop.c
+++ b/linux-user/loongarch64/cpu_loop.c
@@ -19,6 +19,7 @@ enum {
 
 void cpu_loop(CPULoongArchState *env)
 {
+    CPUSysState *sys = env_sys(env);
     CPUState *cs = env_cpu(env);
     int trapnr, si_code;
     abi_long ret;
@@ -103,10 +104,10 @@ void cpu_loop(CPULoongArchState *env)
          * choose the layout of any signal frame.
          */
         case EXCCODE_SXD:
-            env->CSR_EUEN |= R_CSR_EUEN_SXE_MASK;
+            sys->CSR_EUEN |= R_CSR_EUEN_SXE_MASK;
             break;
         case EXCCODE_ASXD:
-            env->CSR_EUEN |= R_CSR_EUEN_ASXE_MASK;
+            sys->CSR_EUEN |= R_CSR_EUEN_ASXE_MASK;
             break;
 
         case EXCP_ATOMIC:
diff --git a/linux-user/loongarch64/elfload.c b/linux-user/loongarch64/elfload.c
index ce3bd0c607..e53957e36d 100644
--- a/linux-user/loongarch64/elfload.c
+++ b/linux-user/loongarch64/elfload.c
@@ -67,6 +67,8 @@ const char *get_elf_platform(CPUState *cs)
 
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPULoongArchState *env)
 {
+    CPUSysState *sys = env_sys((CPULoongArchState *)env);
+
     r->pt.regs[0] = 0;
 
     for (int i = 1; i < ARRAY_SIZE(env->gpr); i++) {
@@ -74,5 +76,5 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPULoongArchState *env)
     }
 
     r->pt.csr_era = tswapreg(env->pc);
-    r->pt.csr_badv = tswapreg(env->CSR_BADV);
+    r->pt.csr_badv = tswapreg(sys->CSR_BADV);
 }
diff --git a/linux-user/loongarch64/signal.c b/linux-user/loongarch64/signal.c
index 1a322f9697..eff75bcdc8 100644
--- a/linux-user/loongarch64/signal.c
+++ b/linux-user/loongarch64/signal.c
@@ -126,6 +126,8 @@ static abi_ptr extframe_alloc(struct extctx_layout *extctx,
 static abi_ptr setup_extcontext(CPULoongArchState *env,
                                 struct extctx_layout *extctx, abi_ptr sp)
 {
+    CPUSysState *sys = env_sys(env);
+
     memset(extctx, 0, sizeof(struct extctx_layout));
 
     /* Grow down, alloc "end" context info first. */
@@ -134,10 +136,10 @@ static abi_ptr setup_extcontext(CPULoongArchState *env,
     /* For qemu, there is no lazy fp context switch, so fp always present. */
     extctx->flags = SC_USED_FP;
 
-    if (FIELD_EX64(env->CSR_EUEN, CSR_EUEN, ASXE)) {
+    if (FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, ASXE)) {
         sp = extframe_alloc(extctx, &extctx->lasx,
                         sizeof(struct target_lasx_context), LASX_CTX_ALIGN, sp);
-    } else if (FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE)) {
+    } else if (FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, SXE)) {
         sp = extframe_alloc(extctx, &extctx->lsx,
                         sizeof(struct target_lsx_context), LSX_CTX_ALIGN, sp);
     } else {
@@ -152,6 +154,7 @@ static void setup_sigframe(CPULoongArchState *env,
                            struct target_sigcontext *sc,
                            struct extctx_layout *extctx)
 {
+    CPUSysState *sys = env_sys(env);
     struct target_sctx_info *info;
     int i;
 
@@ -166,7 +169,7 @@ static void setup_sigframe(CPULoongArchState *env,
      * Set extension context
      */
 
-    if (FIELD_EX64(env->CSR_EUEN, CSR_EUEN, ASXE)) {
+    if (FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, ASXE)) {
         struct target_lasx_context *lasx_ctx;
         info = extctx->lasx.haddr;
 
@@ -183,7 +186,7 @@ static void setup_sigframe(CPULoongArchState *env,
         }
         __put_user(read_fcc(env), &lasx_ctx->fcc);
         __put_user(env->fcsr0, &lasx_ctx->fcsr);
-    } else if (FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE)) {
+    } else if (FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, SXE)) {
         struct target_lsx_context *lsx_ctx;
         info = extctx->lsx.haddr;
 
@@ -350,6 +353,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
                     target_siginfo_t *info,
                     target_sigset_t *set, CPULoongArchState *env)
 {
+    CPUSysState *sys = env_sys(env);
     struct target_rt_sigframe *frame;
     struct extctx_layout extctx;
     abi_ptr frame_addr;
@@ -365,10 +369,10 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
         return;
     }
 
-    if (FIELD_EX64(env->CSR_EUEN, CSR_EUEN, ASXE)) {
+    if (FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, ASXE)) {
         extctx.lasx.haddr = (void *)frame + (extctx.lasx.gaddr - frame_addr);
         extctx.end.haddr = (void *)frame + (extctx.end.gaddr - frame_addr);
-    } else if (FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE)) {
+    } else if (FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, SXE)) {
         extctx.lsx.haddr = (void *)frame + (extctx.lsx.gaddr - frame_addr);
         extctx.end.haddr = (void *)frame + (extctx.end.gaddr - frame_addr);
     } else {
-- 
2.54.0


