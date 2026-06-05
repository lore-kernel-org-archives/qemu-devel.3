Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D63CD6E5D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVPqz-0006Sz-Vk; Fri, 05 Jun 2026 04:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wVPqy-0006S5-6e
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:24:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wVPqt-0004hb-Ds
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:24:31 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8BxDuq5hyJqruMQAA--.45590S3;
 Fri, 05 Jun 2026 16:24:25 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJCxvsKuhyJqnLucAA--.34744S7;
 Fri, 05 Jun 2026 16:24:24 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v3 05/14] target/loongarch: Use sys_state in kvm.c when
 accessing CSR registers
Date: Fri,  5 Jun 2026 16:25:43 +0800
Message-ID: <20260605082552.175336-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605082552.175336-1-maobibo@loongson.cn>
References: <20260605082552.175336-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxvsKuhyJqnLucAA--.34744S7
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoW3Kr1fGr1UXFy5ur4xtr4xAFc_yoW8XF43uo
 WDZw4fW3W3XrsFkF15Cw1Yga98Xry8CwnrCFW5CrWUua48tFZ5tryxG34Uur43Wa98WF18
 Way7tr4kZayUWr1Dl-sFpf9Il3svdjkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
 UjIYCTnIWjp_UUUYy7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
 8IcIk0rVWrJVCq3wAFIxvE14AKwVWUAVWUZwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
 Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
 v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
 xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
 Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
 0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
 xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
 AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI
 42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
 IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
 xhVjvjDU0xZFpf9x07jfl1kUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

When accessing CSR registers in file kvm.c, use sys_state rather than
env.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
---
 target/loongarch/kvm/kvm.c | 228 +++++++++++++++++++------------------
 1 file changed, 116 insertions(+), 112 deletions(-)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 4af4ab2ed0..d6539c12ac 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -161,6 +161,7 @@ static int kvm_loongarch_put_pmu(CPUState *cs)
     int i, ret = 0;
     CPULoongArchState *env = cpu_env(cs);
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPUSysState *sys = env_sys(env);
 
     if (cpu->pmu != ON_OFF_AUTO_ON) {
         return 0;
@@ -168,9 +169,9 @@ static int kvm_loongarch_put_pmu(CPUState *cs)
 
     for (i = 0; i < env->perf_event_num; i++) {
         ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCTRL(i)),
-                               &env->CSR_PERFCTRL[i]);
+                               &sys->CSR_PERFCTRL[i]);
         ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCNTR(i)),
-                               &env->CSR_PERFCNTR[i]);
+                               &sys->CSR_PERFCNTR[i]);
     }
 
     return ret;
@@ -181,6 +182,7 @@ static int kvm_loongarch_get_pmu(CPUState *cs)
     int i, ret = 0;
     CPULoongArchState *env = cpu_env(cs);
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPUSysState *sys = env_sys(env);
 
     if (cpu->pmu != ON_OFF_AUTO_ON) {
         return 0;
@@ -188,9 +190,9 @@ static int kvm_loongarch_get_pmu(CPUState *cs)
 
     for (i = 0; i < env->perf_event_num; i++) {
         ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCTRL(i)),
-                               &env->CSR_PERFCTRL[i]);
+                               &sys->CSR_PERFCTRL[i]);
         ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCNTR(i)),
-                               &env->CSR_PERFCNTR[i]);
+                               &sys->CSR_PERFCNTR[i]);
     }
 
     return ret;
@@ -200,170 +202,171 @@ static int kvm_loongarch_get_csr(CPUState *cs)
 {
     int ret = 0;
     CPULoongArchState *env = cpu_env(cs);
+    CPUSysState *sys = env_sys(env);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_CRMD),
-                           &env->CSR_CRMD);
+                           &sys->CSR_CRMD);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PRMD),
-                           &env->CSR_PRMD);
+                           &sys->CSR_PRMD);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_EUEN),
-                           &env->CSR_EUEN);
+                           &sys->CSR_EUEN);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MISC),
-                           &env->CSR_MISC);
+                           &sys->CSR_MISC);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_ECFG),
-                           &env->CSR_ECFG);
+                           &sys->CSR_ECFG);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_ESTAT),
-                           &env->CSR_ESTAT);
+                           &sys->CSR_ESTAT);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_ERA),
-                           &env->CSR_ERA);
+                           &sys->CSR_ERA);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_BADV),
-                           &env->CSR_BADV);
+                           &sys->CSR_BADV);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_BADI),
-                           &env->CSR_BADI);
+                           &sys->CSR_BADI);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_EENTRY),
-                           &env->CSR_EENTRY);
+                           &sys->CSR_EENTRY);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBIDX),
-                           &env->CSR_TLBIDX);
+                           &sys->CSR_TLBIDX);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBEHI),
-                           &env->CSR_TLBEHI);
+                           &sys->CSR_TLBEHI);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBELO0),
-                           &env->CSR_TLBELO0);
+                           &sys->CSR_TLBELO0);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBELO1),
-                           &env->CSR_TLBELO1);
+                           &sys->CSR_TLBELO1);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_ASID),
-                           &env->CSR_ASID);
+                           &sys->CSR_ASID);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PGDL),
-                           &env->CSR_PGDL);
+                           &sys->CSR_PGDL);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PGDH),
-                           &env->CSR_PGDH);
+                           &sys->CSR_PGDH);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PGD),
-                           &env->CSR_PGD);
+                           &sys->CSR_PGD);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PWCL),
-                           &env->CSR_PWCL);
+                           &sys->CSR_PWCL);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PWCH),
-                           &env->CSR_PWCH);
+                           &sys->CSR_PWCH);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_STLBPS),
-                           &env->CSR_STLBPS);
+                           &sys->CSR_STLBPS);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_RVACFG),
-                           &env->CSR_RVACFG);
+                           &sys->CSR_RVACFG);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_CPUID),
-                           &env->CSR_CPUID);
+                           &sys->CSR_CPUID);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PRCFG1),
-                           &env->CSR_PRCFG1);
+                           &sys->CSR_PRCFG1);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PRCFG2),
-                           &env->CSR_PRCFG2);
+                           &sys->CSR_PRCFG2);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PRCFG3),
-                           &env->CSR_PRCFG3);
+                           &sys->CSR_PRCFG3);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(0)),
-                           &env->CSR_SAVE[0]);
+                           &sys->CSR_SAVE[0]);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(1)),
-                           &env->CSR_SAVE[1]);
+                           &sys->CSR_SAVE[1]);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(2)),
-                           &env->CSR_SAVE[2]);
+                           &sys->CSR_SAVE[2]);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(3)),
-                           &env->CSR_SAVE[3]);
+                           &sys->CSR_SAVE[3]);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(4)),
-                           &env->CSR_SAVE[4]);
+                           &sys->CSR_SAVE[4]);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(5)),
-                           &env->CSR_SAVE[5]);
+                           &sys->CSR_SAVE[5]);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(6)),
-                           &env->CSR_SAVE[6]);
+                           &sys->CSR_SAVE[6]);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(7)),
-                           &env->CSR_SAVE[7]);
+                           &sys->CSR_SAVE[7]);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TID),
-                           &env->CSR_TID);
+                           &sys->CSR_TID);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_CNTC),
-                           &env->CSR_CNTC);
+                           &sys->CSR_CNTC);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TICLR),
-                           &env->CSR_TICLR);
+                           &sys->CSR_TICLR);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_LLBCTL),
-                           &env->CSR_LLBCTL);
+                           &sys->CSR_LLBCTL);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_IMPCTL1),
-                           &env->CSR_IMPCTL1);
+                           &sys->CSR_IMPCTL1);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_IMPCTL2),
-                           &env->CSR_IMPCTL2);
+                           &sys->CSR_IMPCTL2);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRENTRY),
-                           &env->CSR_TLBRENTRY);
+                           &sys->CSR_TLBRENTRY);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRBADV),
-                           &env->CSR_TLBRBADV);
+                           &sys->CSR_TLBRBADV);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRERA),
-                           &env->CSR_TLBRERA);
+                           &sys->CSR_TLBRERA);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRSAVE),
-                           &env->CSR_TLBRSAVE);
+                           &sys->CSR_TLBRSAVE);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRELO0),
-                           &env->CSR_TLBRELO0);
+                           &sys->CSR_TLBRELO0);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRELO1),
-                           &env->CSR_TLBRELO1);
+                           &sys->CSR_TLBRELO1);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBREHI),
-                           &env->CSR_TLBREHI);
+                           &sys->CSR_TLBREHI);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRPRMD),
-                           &env->CSR_TLBRPRMD);
+                           &sys->CSR_TLBRPRMD);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(0)),
-                           &env->CSR_DMW[0]);
+                           &sys->CSR_DMW[0]);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(1)),
-                           &env->CSR_DMW[1]);
+                           &sys->CSR_DMW[1]);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(2)),
-                           &env->CSR_DMW[2]);
+                           &sys->CSR_DMW[2]);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(3)),
-                           &env->CSR_DMW[3]);
+                           &sys->CSR_DMW[3]);
 
     ret |= kvm_loongarch_get_pmu(cs);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TVAL),
-                           &env->CSR_TVAL);
+                           &sys->CSR_TVAL);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TCFG),
-                           &env->CSR_TCFG);
+                           &sys->CSR_TCFG);
 
     return ret;
 }
@@ -372,165 +375,166 @@ static int kvm_loongarch_put_csr(CPUState *cs, KvmPutState level)
 {
     int ret = 0;
     CPULoongArchState *env = cpu_env(cs);
+    CPUSysState *sys = env_sys(env);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_CRMD),
-                           &env->CSR_CRMD);
+                           &sys->CSR_CRMD);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PRMD),
-                           &env->CSR_PRMD);
+                           &sys->CSR_PRMD);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_EUEN),
-                           &env->CSR_EUEN);
+                           &sys->CSR_EUEN);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MISC),
-                           &env->CSR_MISC);
+                           &sys->CSR_MISC);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_ECFG),
-                           &env->CSR_ECFG);
+                           &sys->CSR_ECFG);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_ESTAT),
-                           &env->CSR_ESTAT);
+                           &sys->CSR_ESTAT);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_ERA),
-                           &env->CSR_ERA);
+                           &sys->CSR_ERA);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_BADV),
-                           &env->CSR_BADV);
+                           &sys->CSR_BADV);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_BADI),
-                           &env->CSR_BADI);
+                           &sys->CSR_BADI);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_EENTRY),
-                           &env->CSR_EENTRY);
+                           &sys->CSR_EENTRY);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBIDX),
-                           &env->CSR_TLBIDX);
+                           &sys->CSR_TLBIDX);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBEHI),
-                           &env->CSR_TLBEHI);
+                           &sys->CSR_TLBEHI);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBELO0),
-                           &env->CSR_TLBELO0);
+                           &sys->CSR_TLBELO0);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBELO1),
-                           &env->CSR_TLBELO1);
+                           &sys->CSR_TLBELO1);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_ASID),
-                           &env->CSR_ASID);
+                           &sys->CSR_ASID);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PGDL),
-                           &env->CSR_PGDL);
+                           &sys->CSR_PGDL);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PGDH),
-                           &env->CSR_PGDH);
+                           &sys->CSR_PGDH);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PGD),
-                           &env->CSR_PGD);
+                           &sys->CSR_PGD);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PWCL),
-                           &env->CSR_PWCL);
+                           &sys->CSR_PWCL);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PWCH),
-                           &env->CSR_PWCH);
+                           &sys->CSR_PWCH);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_STLBPS),
-                           &env->CSR_STLBPS);
+                           &sys->CSR_STLBPS);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_RVACFG),
-                           &env->CSR_RVACFG);
+                           &sys->CSR_RVACFG);
 
     /* CPUID is constant after poweron, it should be set only once */
     if (level >= KVM_PUT_FULL_STATE) {
         ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_CPUID),
-                           &env->CSR_CPUID);
+                           &sys->CSR_CPUID);
     }
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PRCFG1),
-                           &env->CSR_PRCFG1);
+                           &sys->CSR_PRCFG1);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PRCFG2),
-                           &env->CSR_PRCFG2);
+                           &sys->CSR_PRCFG2);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PRCFG3),
-                           &env->CSR_PRCFG3);
+                           &sys->CSR_PRCFG3);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(0)),
-                           &env->CSR_SAVE[0]);
+                           &sys->CSR_SAVE[0]);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(1)),
-                           &env->CSR_SAVE[1]);
+                           &sys->CSR_SAVE[1]);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(2)),
-                           &env->CSR_SAVE[2]);
+                           &sys->CSR_SAVE[2]);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(3)),
-                           &env->CSR_SAVE[3]);
+                           &sys->CSR_SAVE[3]);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(4)),
-                           &env->CSR_SAVE[4]);
+                           &sys->CSR_SAVE[4]);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(5)),
-                           &env->CSR_SAVE[5]);
+                           &sys->CSR_SAVE[5]);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(6)),
-                           &env->CSR_SAVE[6]);
+                           &sys->CSR_SAVE[6]);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(7)),
-                           &env->CSR_SAVE[7]);
+                           &sys->CSR_SAVE[7]);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TID),
-                           &env->CSR_TID);
+                           &sys->CSR_TID);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_CNTC),
-                           &env->CSR_CNTC);
+                           &sys->CSR_CNTC);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TICLR),
-                           &env->CSR_TICLR);
+                           &sys->CSR_TICLR);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_LLBCTL),
-                           &env->CSR_LLBCTL);
+                           &sys->CSR_LLBCTL);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_IMPCTL1),
-                           &env->CSR_IMPCTL1);
+                           &sys->CSR_IMPCTL1);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_IMPCTL2),
-                           &env->CSR_IMPCTL2);
+                           &sys->CSR_IMPCTL2);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRENTRY),
-                           &env->CSR_TLBRENTRY);
+                           &sys->CSR_TLBRENTRY);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRBADV),
-                           &env->CSR_TLBRBADV);
+                           &sys->CSR_TLBRBADV);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRERA),
-                           &env->CSR_TLBRERA);
+                           &sys->CSR_TLBRERA);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRSAVE),
-                           &env->CSR_TLBRSAVE);
+                           &sys->CSR_TLBRSAVE);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRELO0),
-                           &env->CSR_TLBRELO0);
+                           &sys->CSR_TLBRELO0);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRELO1),
-                           &env->CSR_TLBRELO1);
+                           &sys->CSR_TLBRELO1);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBREHI),
-                           &env->CSR_TLBREHI);
+                           &sys->CSR_TLBREHI);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRPRMD),
-                           &env->CSR_TLBRPRMD);
+                           &sys->CSR_TLBRPRMD);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(0)),
-                           &env->CSR_DMW[0]);
+                           &sys->CSR_DMW[0]);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(1)),
-                           &env->CSR_DMW[1]);
+                           &sys->CSR_DMW[1]);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(2)),
-                           &env->CSR_DMW[2]);
+                           &sys->CSR_DMW[2]);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(3)),
-                           &env->CSR_DMW[3]);
+                           &sys->CSR_DMW[3]);
 
     ret |= kvm_loongarch_put_pmu(cs);
 
@@ -539,10 +543,10 @@ static int kvm_loongarch_put_csr(CPUState *cs, KvmPutState level)
      * guest timer
      */
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TVAL),
-                           &env->CSR_TVAL);
+                           &sys->CSR_TVAL);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TCFG),
-                           &env->CSR_TCFG);
+                           &sys->CSR_TCFG);
     return ret;
 }
 
-- 
2.54.0


