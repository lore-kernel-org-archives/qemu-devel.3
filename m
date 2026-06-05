Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0871ACD6E6B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVQ3G-00034I-Qj; Fri, 05 Jun 2026 04:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wVQ3E-00033w-IT
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:37:12 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wVQ3C-0008NB-8n
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:37:12 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8Dx13i0iiJq4eQQAA--.21565S3;
 Fri, 05 Jun 2026 16:37:08 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJDxysGziiJqWL2cAA--.32906S2;
 Fri, 05 Jun 2026 16:37:07 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v3 10/14] linux-user/loongarch64: Use sys_state when accessing
 CSR registers
Date: Fri,  5 Jun 2026 16:38:44 +0800
Message-ID: <20260605083844.175612-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605082552.175336-1-maobibo@loongson.cn>
References: <20260605082552.175336-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxysGziiJqWL2cAA--.32906S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF4UKFW8Aw45tF18Jr4kKrX_yoW7Jw1fpF
 W7CFW7ArW8GrsxC3Zrta4ruF15urnru393GFWxG34jyFs3Cr15Was7J3W7KF1DAw13uFW2
 vFZrt3WUuFW3JrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
 xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
 Wrv_ZF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
 Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAF
 wI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
 AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1l
 IxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
 4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
 daVFxhVjvjDU0xZFpf9x07jxSdgUUUUU=
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

When accessing CSR registers in directory linux-user/loongarch64/, use
sys_state rather than env. There is no function change.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
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


