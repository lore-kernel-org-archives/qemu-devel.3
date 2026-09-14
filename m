Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B81C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 02:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5wC4-0001DU-FI; Sun, 13 Sep 2026 22:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x5wC1-0001CM-Bo
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 22:13:13 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x5wBw-0007Dx-NH
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 22:13:11 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8AxS_AwWKdqgqULAA--.33935S3;
 Mon, 14 Sep 2026 10:13:04 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJDxTs8rWKdqC2ggAA--.4739S4;
 Mon, 14 Sep 2026 10:13:03 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Subject: [PATCH 2/6] target/loongarch/kvm: Check LoongArch Instruction Set
 version 1.1
Date: Mon, 14 Sep 2026 10:14:16 +0800
Message-ID: <20260914021420.4065683-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260914021420.4065683-1-maobibo@loongson.cn>
References: <20260914021420.4065683-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxTs8rWKdqC2ggAA--.4739S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWry7ZF1ruw13Xw4fWFWDWrX_yoW5Ar48pr
 4UCrs0grWrtFZ7CwnxJrWqvrs8ZF48K3yIyFyxArySvwn8JrnrZFyIya1DZFn8G34rZrs3
 WF4kAFZ8uF1DAwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
 0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7JKsUUUUU
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

Besides PTW and DINTC features, there are some small features about
LoongArch Instruction Set version 1.1, mainly they are about atomic
instruction enhancement.

For these features, there are no special property selection, and they
are enabled from CPU type selection such as host or max CPU type. Here
adds these features if host supports and they are enabled from the
specified CPU type.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/kvm/kvm.c | 65 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 15082a01f8..0626c553d5 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1234,6 +1234,65 @@ static int kvm_cpu_check_msgint(CPUState *cs, Error **errp)
     return 0;
 }
 
+/* Check LoongArch Instruction Set 1.1 others feature */
+static int kvm_cpu_check_misc_v1_1(CPUState *cs, Error **errp)
+{
+    int ret;
+    uint64_t val, field;
+    struct kvm_device_attr attr;
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    uint32_t data;
+
+    val = 0;
+    attr.group = KVM_LOONGARCH_VCPU_CPUCFG;
+    attr.attr  = 2;
+    attr.addr  = (uint64_t)&val;
+    ret = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, &attr);
+    if (!ret) {
+        ret = kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
+    }
+
+    /* Disable LA 1.1 features if host cpucfg2 get not supported */
+    if (ret) {
+        val = 0;
+    }
+
+    data = cpu->env.cpucfg[2];
+    val &= data;
+    field = FIELD_EX32((uint32_t)val, CPUCFG2, FRECIPE);
+    data  = FIELD_DP32(data, CPUCFG2, FRECIPE, field);
+    field = FIELD_EX32((uint32_t)val, CPUCFG2, LAM_BH);
+    data = FIELD_DP32(data, CPUCFG2, LAM_BH, field);
+    field = FIELD_EX32((uint32_t)val, CPUCFG2, LAMCAS);
+    data = FIELD_DP32(data, CPUCFG2, LAMCAS, field);
+    field = FIELD_EX32((uint32_t)val, CPUCFG2, LLACQ_SCREL);
+    data = FIELD_DP32(data, CPUCFG2, LLACQ_SCREL, field);
+    field = FIELD_EX32((uint32_t)val, CPUCFG2, SCQ);
+    data = FIELD_DP32(data, CPUCFG2, SCQ, field);
+    cpu->env.cpucfg[2] = data;
+
+    val = 0;
+    attr.group = KVM_LOONGARCH_VCPU_CPUCFG;
+    attr.attr  = 3;
+    attr.addr  = (uint64_t)&val;
+    ret = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, &attr);
+    if (!ret) {
+        ret = kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
+    }
+
+    /* Disable LA 1.1 features if host cpucfg3 get not supported */
+    if (ret) {
+        val = 0;
+    }
+
+    data = cpu->env.cpucfg[3];
+    val &= data;
+    field = FIELD_EX32((uint32_t)val, CPUCFG3, DBAR_HINTS);
+    data  = FIELD_DP32(data, CPUCFG3, DBAR_HINTS, field);
+    cpu->env.cpucfg[3] = data;
+    return 0;
+}
+
 int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
 {
     return 0;
@@ -1295,6 +1354,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return ret;
     }
 
+    ret = kvm_cpu_check_misc_v1_1(cs, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+        return ret;
+    }
+
     return 0;
 }
 
-- 
2.54.0


