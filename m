Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A98C54FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 05:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpJI1-0001Qz-3u; Thu, 30 Jul 2026 01:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xb@ultrarisc.com>)
 id 1wpJHz-0001QY-9A; Thu, 30 Jul 2026 01:26:39 -0400
Received: from [218.76.62.146] (helo=ultrarisc.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xb@ultrarisc.com>)
 id 1wpJHx-0000dF-7Y; Thu, 30 Jul 2026 01:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding; bh=DJ8hPiaRqQ2n5AJgLRt7ghP210MWnRvfNe
 B/k12XEBM=; b=jOx8ppMEPI+cfHpnJ0h4y+Pt7uZAdSEfj0wPvyJwrhkwi/wq41
 Pgi+EBBenKxOykeXuJg4KvqLAwgECaJVymF92esqeTCBI4V0cokmsZCGE0Yrkb3x
 ezl9ZqlhTNFAV7NYf1Q6M8Kctwyg3CCMP/1mGqC4/De366EnjhIyPFGfY=
Received: from ur-dp1000 (unknown [192.168.100.1])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAfwA3cUL63mpqEscVAA--.18165S3; 
 Thu, 30 Jul 2026 13:20:06 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: qemu-devel@nongnu.org
Cc: ajones@ventanamicro.com, qemu-riscv@nongnu.org, alistair23@gmail.com,
 pbonzini@redhat.com, anup@brainfault.org, alistair.francis@wdc.com,
 rkrcmar@ventanamicro.com, palmer@dabbelt.com,
 daniel.barboza@oss.qualcomm.com, xb@ultrarisc.com
Subject: [PATCH v10 1/2] target/riscv/kvm: Synchronize privilege mode
Date: Thu, 30 Jul 2026 13:19:25 +0800
Message-ID: <20260730051926.7322-2-xb@ultrarisc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730051926.7322-1-xb@ultrarisc.com>
References: <20250915070811.3422578-1-xb@ultrarisc.com>
 <20260730051926.7322-1-xb@ultrarisc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwA3cUL63mpqEscVAA--.18165S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWftw13GFWDtw1rAF1rXrb_yoW8Gry3pa
 n5Gay5KF93JFWxG3yfAr4DX3WrWr43GwsxZFWxuw129r45trWUKr9FgF4Utr95GFWrZr4Y
 vF4qkr1Y9F45ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmm14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
 x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
 ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
 xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
 vE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
 r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
 v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCF
 s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
 1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
 JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
 1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
 YxBIdaVFxhVjvjDU0xZFpf9x0JUTT5JUUUUU=
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQATB2pkMtIAAQAbsh
X-Host-Lookup-Failed: Reverse DNS lookup failed for 218.76.62.146 (failed)
Received-SPF: pass client-ip=218.76.62.146; envelope-from=xb@ultrarisc.com;
 helo=ultrarisc.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The KVM core register synchronization currently omits the vCPU privilege
mode. As a result, env.priv can be stale when the migration stream is saved
and the destination can restore the vCPU in the wrong mode.

Read and write the KVM core mode register together with the other core
registers. The generic RISC-V CPU VMState already carries env.priv, so no
migration format change is required.

Signed-off-by: Xie Bo <xb@ultrarisc.com>
---
 target/riscv/kvm/kvm-cpu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 495cb42dc8..8218832fbe 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -603,6 +603,12 @@ static int kvm_riscv_get_regs_core(CPUState *cs)
     }
     env->pc = reg;
 
+    ret = kvm_get_one_reg(cs, RISCV_CORE_REG(mode), &reg);
+    if (ret) {
+        return ret;
+    }
+    env->priv = reg;
+
     for (i = 1; i < 32; i++) {
         uint64_t id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CORE, i);
         ret = kvm_get_one_reg(cs, id, &reg);
@@ -628,6 +634,12 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
         return ret;
     }
 
+    reg = env->priv;
+    ret = kvm_set_one_reg(cs, RISCV_CORE_REG(mode), &reg);
+    if (ret) {
+        return ret;
+    }
+
     for (i = 1; i < 32; i++) {
         uint64_t id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CORE, i);
         reg = env->gpr[i];
-- 
2.17.1


