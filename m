Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEB6CD5BB4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 06:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRld2-0002JS-9l; Tue, 26 May 2026 02:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wRlcc-0002GS-Gx
 for qemu-devel@nongnu.org; Tue, 26 May 2026 02:50:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wRlcX-0000aS-PU
 for qemu-devel@nongnu.org; Tue, 26 May 2026 02:50:37 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxnOm2QhVqYUwNAA--.36072S3;
 Tue, 26 May 2026 14:50:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBx68GwQhVqMF6RAA--.10913S7;
 Tue, 26 May 2026 14:50:29 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH 05/12] target/loongarch: Use curState in kvm.c when accessing
 CSR registers
Date: Tue, 26 May 2026 14:50:16 +0800
Message-Id: <20260526065023.1639371-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260526065023.1639371-1-maobibo@loongson.cn>
References: <20260526065023.1639371-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBx68GwQhVqMF6RAA--.10913S7
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
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

When accessing CSR registers in file kvm.c, use curState rather than
env.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/kvm/kvm.c | 228 +++++++++++++++++++------------------
 1 file changed, 116 insertions(+), 112 deletions(-)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 9d844c4905..1534fcb7c3 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -160,6 +160,7 @@ static int kvm_loongarch_put_pmu(CPUState *cs)
     int i, ret = 0;
     CPULoongArchState *env = cpu_env(cs);
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPUSysState *cur = get_current_state(env);
 
     if (cpu->pmu != ON_OFF_AUTO_ON) {
         return 0;
@@ -167,9 +168,9 @@ static int kvm_loongarch_put_pmu(CPUState *cs)
 
     for (i = 0; i < env->perf_event_num; i++) {
         ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCTRL(i)),
-                               &env->CSR_PERFCTRL[i]);
+                               &cur->CSR_PERFCTRL[i]);
         ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCNTR(i)),
-                               &env->CSR_PERFCNTR[i]);
+                               &cur->CSR_PERFCNTR[i]);
     }
 
     return ret;
@@ -180,6 +181,7 @@ static int kvm_loongarch_get_pmu(CPUState *cs)
     int i, ret = 0;
     CPULoongArchState *env = cpu_env(cs);
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPUSysState *cur = get_current_state(env);
 
     if (cpu->pmu != ON_OFF_AUTO_ON) {
         return 0;
@@ -187,9 +189,9 @@ static int kvm_loongarch_get_pmu(CPUState *cs)
 
     for (i = 0; i < env->perf_event_num; i++) {
         ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCTRL(i)),
-                               &env->CSR_PERFCTRL[i]);
+                               &cur->CSR_PERFCTRL[i]);
         ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCNTR(i)),
-                               &env->CSR_PERFCNTR[i]);
+                               &cur->CSR_PERFCNTR[i]);
     }
 
     return ret;
@@ -199,170 +201,171 @@ static int kvm_loongarch_get_csr(CPUState *cs)
 {
     int ret = 0;
     CPULoongArchState *env = cpu_env(cs);
+    CPUSysState *cur = get_current_state(env);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_CRMD),
-                           &env->CSR_CRMD);
+                           &cur->CSR_CRMD);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PRMD),
-                           &env->CSR_PRMD);
+                           &cur->CSR_PRMD);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_EUEN),
-                           &env->CSR_EUEN);
+                           &cur->CSR_EUEN);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MISC),
-                           &env->CSR_MISC);
+                           &cur->CSR_MISC);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_ECFG),
-                           &env->CSR_ECFG);
+                           &cur->CSR_ECFG);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_ESTAT),
-                           &env->CSR_ESTAT);
+                           &cur->CSR_ESTAT);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_ERA),
-                           &env->CSR_ERA);
+                           &cur->CSR_ERA);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_BADV),
-                           &env->CSR_BADV);
+                           &cur->CSR_BADV);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_BADI),
-                           &env->CSR_BADI);
+                           &cur->CSR_BADI);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_EENTRY),
-                           &env->CSR_EENTRY);
+                           &cur->CSR_EENTRY);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBIDX),
-                           &env->CSR_TLBIDX);
+                           &cur->CSR_TLBIDX);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBEHI),
-                           &env->CSR_TLBEHI);
+                           &cur->CSR_TLBEHI);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBELO0),
-                           &env->CSR_TLBELO0);
+                           &cur->CSR_TLBELO0);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBELO1),
-                           &env->CSR_TLBELO1);
+                           &cur->CSR_TLBELO1);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_ASID),
-                           &env->CSR_ASID);
+                           &cur->CSR_ASID);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PGDL),
-                           &env->CSR_PGDL);
+                           &cur->CSR_PGDL);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PGDH),
-                           &env->CSR_PGDH);
+                           &cur->CSR_PGDH);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PGD),
-                           &env->CSR_PGD);
+                           &cur->CSR_PGD);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PWCL),
-                           &env->CSR_PWCL);
+                           &cur->CSR_PWCL);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PWCH),
-                           &env->CSR_PWCH);
+                           &cur->CSR_PWCH);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_STLBPS),
-                           &env->CSR_STLBPS);
+                           &cur->CSR_STLBPS);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_RVACFG),
-                           &env->CSR_RVACFG);
+                           &cur->CSR_RVACFG);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_CPUID),
-                           &env->CSR_CPUID);
+                           &cur->CSR_CPUID);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PRCFG1),
-                           &env->CSR_PRCFG1);
+                           &cur->CSR_PRCFG1);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PRCFG2),
-                           &env->CSR_PRCFG2);
+                           &cur->CSR_PRCFG2);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PRCFG3),
-                           &env->CSR_PRCFG3);
+                           &cur->CSR_PRCFG3);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(0)),
-                           &env->CSR_SAVE[0]);
+                           &cur->CSR_SAVE[0]);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(1)),
-                           &env->CSR_SAVE[1]);
+                           &cur->CSR_SAVE[1]);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(2)),
-                           &env->CSR_SAVE[2]);
+                           &cur->CSR_SAVE[2]);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(3)),
-                           &env->CSR_SAVE[3]);
+                           &cur->CSR_SAVE[3]);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(4)),
-                           &env->CSR_SAVE[4]);
+                           &cur->CSR_SAVE[4]);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(5)),
-                           &env->CSR_SAVE[5]);
+                           &cur->CSR_SAVE[5]);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(6)),
-                           &env->CSR_SAVE[6]);
+                           &cur->CSR_SAVE[6]);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(7)),
-                           &env->CSR_SAVE[7]);
+                           &cur->CSR_SAVE[7]);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TID),
-                           &env->CSR_TID);
+                           &cur->CSR_TID);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_CNTC),
-                           &env->CSR_CNTC);
+                           &cur->CSR_CNTC);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TICLR),
-                           &env->CSR_TICLR);
+                           &cur->CSR_TICLR);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_LLBCTL),
-                           &env->CSR_LLBCTL);
+                           &cur->CSR_LLBCTL);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_IMPCTL1),
-                           &env->CSR_IMPCTL1);
+                           &cur->CSR_IMPCTL1);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_IMPCTL2),
-                           &env->CSR_IMPCTL2);
+                           &cur->CSR_IMPCTL2);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRENTRY),
-                           &env->CSR_TLBRENTRY);
+                           &cur->CSR_TLBRENTRY);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRBADV),
-                           &env->CSR_TLBRBADV);
+                           &cur->CSR_TLBRBADV);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRERA),
-                           &env->CSR_TLBRERA);
+                           &cur->CSR_TLBRERA);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRSAVE),
-                           &env->CSR_TLBRSAVE);
+                           &cur->CSR_TLBRSAVE);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRELO0),
-                           &env->CSR_TLBRELO0);
+                           &cur->CSR_TLBRELO0);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRELO1),
-                           &env->CSR_TLBRELO1);
+                           &cur->CSR_TLBRELO1);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBREHI),
-                           &env->CSR_TLBREHI);
+                           &cur->CSR_TLBREHI);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRPRMD),
-                           &env->CSR_TLBRPRMD);
+                           &cur->CSR_TLBRPRMD);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(0)),
-                           &env->CSR_DMW[0]);
+                           &cur->CSR_DMW[0]);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(1)),
-                           &env->CSR_DMW[1]);
+                           &cur->CSR_DMW[1]);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(2)),
-                           &env->CSR_DMW[2]);
+                           &cur->CSR_DMW[2]);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(3)),
-                           &env->CSR_DMW[3]);
+                           &cur->CSR_DMW[3]);
 
     ret |= kvm_loongarch_get_pmu(cs);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TVAL),
-                           &env->CSR_TVAL);
+                           &cur->CSR_TVAL);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TCFG),
-                           &env->CSR_TCFG);
+                           &cur->CSR_TCFG);
 
     return ret;
 }
@@ -371,165 +374,166 @@ static int kvm_loongarch_put_csr(CPUState *cs, KvmPutState level)
 {
     int ret = 0;
     CPULoongArchState *env = cpu_env(cs);
+    CPUSysState *cur = get_current_state(env);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_CRMD),
-                           &env->CSR_CRMD);
+                           &cur->CSR_CRMD);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PRMD),
-                           &env->CSR_PRMD);
+                           &cur->CSR_PRMD);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_EUEN),
-                           &env->CSR_EUEN);
+                           &cur->CSR_EUEN);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MISC),
-                           &env->CSR_MISC);
+                           &cur->CSR_MISC);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_ECFG),
-                           &env->CSR_ECFG);
+                           &cur->CSR_ECFG);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_ESTAT),
-                           &env->CSR_ESTAT);
+                           &cur->CSR_ESTAT);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_ERA),
-                           &env->CSR_ERA);
+                           &cur->CSR_ERA);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_BADV),
-                           &env->CSR_BADV);
+                           &cur->CSR_BADV);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_BADI),
-                           &env->CSR_BADI);
+                           &cur->CSR_BADI);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_EENTRY),
-                           &env->CSR_EENTRY);
+                           &cur->CSR_EENTRY);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBIDX),
-                           &env->CSR_TLBIDX);
+                           &cur->CSR_TLBIDX);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBEHI),
-                           &env->CSR_TLBEHI);
+                           &cur->CSR_TLBEHI);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBELO0),
-                           &env->CSR_TLBELO0);
+                           &cur->CSR_TLBELO0);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBELO1),
-                           &env->CSR_TLBELO1);
+                           &cur->CSR_TLBELO1);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_ASID),
-                           &env->CSR_ASID);
+                           &cur->CSR_ASID);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PGDL),
-                           &env->CSR_PGDL);
+                           &cur->CSR_PGDL);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PGDH),
-                           &env->CSR_PGDH);
+                           &cur->CSR_PGDH);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PGD),
-                           &env->CSR_PGD);
+                           &cur->CSR_PGD);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PWCL),
-                           &env->CSR_PWCL);
+                           &cur->CSR_PWCL);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PWCH),
-                           &env->CSR_PWCH);
+                           &cur->CSR_PWCH);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_STLBPS),
-                           &env->CSR_STLBPS);
+                           &cur->CSR_STLBPS);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_RVACFG),
-                           &env->CSR_RVACFG);
+                           &cur->CSR_RVACFG);
 
     /* CPUID is constant after poweron, it should be set only once */
     if (level >= KVM_PUT_FULL_STATE) {
         ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_CPUID),
-                           &env->CSR_CPUID);
+                           &cur->CSR_CPUID);
     }
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PRCFG1),
-                           &env->CSR_PRCFG1);
+                           &cur->CSR_PRCFG1);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PRCFG2),
-                           &env->CSR_PRCFG2);
+                           &cur->CSR_PRCFG2);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PRCFG3),
-                           &env->CSR_PRCFG3);
+                           &cur->CSR_PRCFG3);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(0)),
-                           &env->CSR_SAVE[0]);
+                           &cur->CSR_SAVE[0]);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(1)),
-                           &env->CSR_SAVE[1]);
+                           &cur->CSR_SAVE[1]);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(2)),
-                           &env->CSR_SAVE[2]);
+                           &cur->CSR_SAVE[2]);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(3)),
-                           &env->CSR_SAVE[3]);
+                           &cur->CSR_SAVE[3]);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(4)),
-                           &env->CSR_SAVE[4]);
+                           &cur->CSR_SAVE[4]);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(5)),
-                           &env->CSR_SAVE[5]);
+                           &cur->CSR_SAVE[5]);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(6)),
-                           &env->CSR_SAVE[6]);
+                           &cur->CSR_SAVE[6]);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(7)),
-                           &env->CSR_SAVE[7]);
+                           &cur->CSR_SAVE[7]);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TID),
-                           &env->CSR_TID);
+                           &cur->CSR_TID);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_CNTC),
-                           &env->CSR_CNTC);
+                           &cur->CSR_CNTC);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TICLR),
-                           &env->CSR_TICLR);
+                           &cur->CSR_TICLR);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_LLBCTL),
-                           &env->CSR_LLBCTL);
+                           &cur->CSR_LLBCTL);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_IMPCTL1),
-                           &env->CSR_IMPCTL1);
+                           &cur->CSR_IMPCTL1);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_IMPCTL2),
-                           &env->CSR_IMPCTL2);
+                           &cur->CSR_IMPCTL2);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRENTRY),
-                           &env->CSR_TLBRENTRY);
+                           &cur->CSR_TLBRENTRY);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRBADV),
-                           &env->CSR_TLBRBADV);
+                           &cur->CSR_TLBRBADV);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRERA),
-                           &env->CSR_TLBRERA);
+                           &cur->CSR_TLBRERA);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRSAVE),
-                           &env->CSR_TLBRSAVE);
+                           &cur->CSR_TLBRSAVE);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRELO0),
-                           &env->CSR_TLBRELO0);
+                           &cur->CSR_TLBRELO0);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRELO1),
-                           &env->CSR_TLBRELO1);
+                           &cur->CSR_TLBRELO1);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBREHI),
-                           &env->CSR_TLBREHI);
+                           &cur->CSR_TLBREHI);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRPRMD),
-                           &env->CSR_TLBRPRMD);
+                           &cur->CSR_TLBRPRMD);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(0)),
-                           &env->CSR_DMW[0]);
+                           &cur->CSR_DMW[0]);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(1)),
-                           &env->CSR_DMW[1]);
+                           &cur->CSR_DMW[1]);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(2)),
-                           &env->CSR_DMW[2]);
+                           &cur->CSR_DMW[2]);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(3)),
-                           &env->CSR_DMW[3]);
+                           &cur->CSR_DMW[3]);
 
     ret |= kvm_loongarch_put_pmu(cs);
 
@@ -538,10 +542,10 @@ static int kvm_loongarch_put_csr(CPUState *cs, KvmPutState level)
      * guest timer
      */
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TVAL),
-                           &env->CSR_TVAL);
+                           &cur->CSR_TVAL);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TCFG),
-                           &env->CSR_TCFG);
+                           &cur->CSR_TCFG);
     return ret;
 }
 
-- 
2.39.3


