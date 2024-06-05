Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A235CC27C55
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 03:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEgtB-0006u4-3t; Tue, 04 Jun 2024 23:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <duchao@eswincomputing.com>)
 id 1sEgt8-0006s5-6T; Tue, 04 Jun 2024 23:00:34 -0400
Received: from zg8tmtu5ljy1ljeznc42.icoremail.net ([159.65.134.6])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <duchao@eswincomputing.com>)
 id 1sEgt4-0005zG-0N; Tue, 04 Jun 2024 23:00:33 -0400
Received: from localhost.localdomain (unknown [10.12.130.31])
 by app1 (Coremail) with SMTP id TAJkCgDniOUt1F9mdWIOAA--.38214S6;
 Wed, 05 Jun 2024 10:57:53 +0800 (CST)
From: Chao Du <duchao@eswincomputing.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 ajones@ventanamicro.com, alistair23@gmail.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, anup@brainfault.org,
 duchao713@qq.com
Subject: [PATCH v3 2/3] target/riscv/kvm: handle the exit with debug reason
Date: Wed,  5 Jun 2024 02:55:26 +0000
Message-Id: <20240605025527.11711-3-duchao@eswincomputing.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240605025527.11711-1-duchao@eswincomputing.com>
References: <20240605025527.11711-1-duchao@eswincomputing.com>
X-CM-TRANSID: TAJkCgDniOUt1F9mdWIOAA--.38214S6
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4kJF4UCryUWr4rZw47urg_yoW8Gw4kpF
 45CFW5Crs3Jry7Gw4avFWkAF13Zrs7WFsxJ3y7Ga4Iqw4aqr4rWr1vg39xtrs5Ca93WF1a
 yF13Zr1fCF4Utr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUP2b7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF
 64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcV
 CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv
 6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
 02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
 4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2
 xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU866
 wtUUUUU==
X-CM-SenderInfo: xgxfxt3r6h245lqf0zpsxwx03jof0z/
Received-SPF: pass client-ip=159.65.134.6;
 envelope-from=duchao@eswincomputing.com;
 helo=zg8tmtu5ljy1ljeznc42.icoremail.net
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_BL=0.001,
 RCVD_IN_MSPIKE_L5=0.001, RCVD_IN_VALIDITY_RPBL=1.31, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

If the breakpoint belongs to the userspace then set the ret value.

Signed-off-by: Chao Du <duchao@eswincomputing.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 4fca6a3b99..8a10aecc72 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1418,6 +1418,21 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
     return ret;
 }
 
+static bool kvm_riscv_handle_debug(CPUState *cs)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+
+    /* Ensure PC is synchronised */
+    kvm_cpu_synchronize_state(cs);
+
+    if (kvm_find_sw_breakpoint(cs, env->pc)) {
+        return true;
+    }
+
+    return false;
+}
+
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     int ret = 0;
@@ -1425,6 +1440,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
     case KVM_EXIT_RISCV_SBI:
         ret = kvm_riscv_handle_sbi(cs, run);
         break;
+    case KVM_EXIT_DEBUG:
+        if (kvm_riscv_handle_debug(cs)) {
+            ret = EXCP_DEBUG;
+        }
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
                       __func__, run->exit_reason);
-- 
2.17.1


