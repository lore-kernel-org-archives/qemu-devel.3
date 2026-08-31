Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDDAC624C6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0web-0003mQ-6t; Mon, 31 Aug 2026 03:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xb@ultrarisc.com>)
 id 1x0weY-0003kw-Ro; Mon, 31 Aug 2026 03:42:02 -0400
Received: from [218.76.62.146] (helo=ultrarisc.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xb@ultrarisc.com>)
 id 1x0weW-00053C-KK; Mon, 31 Aug 2026 03:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding; bh=1aMCn457NawyLRoDOeCVaYbrIcUjzFHs6N
 mlhXiS9sU=; b=gVNv1E28R2fdFOgwsgShvOvWbjhQPfXEOKO5g6SMc3NEW0ucO6
 J5u8CLavSogbXDcwK3ZYo/3v9edK0bEMjVt15nz0aCNGQFRrM73ZiOtrldRP0wBL
 XWu+KOzfqj8qjdMvh+ITjiqVzdcVCMQMyRAfXGFKksq/mXtjiTdcwWcFg=
Received: from ur-dp1000 (unknown [192.168.100.1])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAfwDHQAceMJVq4BUAAA--.112S5; 
 Mon, 31 Aug 2026 15:41:59 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, qemu-stable@nongnu.org,
 Xie Bo <xb@ultrarisc.com>
Subject: [PATCH 3/3] target/riscv/kvm: Preserve VCSR across migration
Date: Mon, 31 Aug 2026 15:41:06 +0800
Message-ID: <20260831074106.1798671-4-xb@ultrarisc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831074106.1798671-1-xb@ultrarisc.com>
References: <20260831074106.1798671-1-xb@ultrarisc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDHQAceMJVq4BUAAA--.112S5
X-Coremail-Antispam: 1UD129KBjvJXoW7CryUZr1ktryrWw43GF45Wrg_yoW8Wr17pa
 n7WFW3Kr93tFZ7J34Sywn0qr4rAr4rKw4DAFZxuwna9r45JFZ0qF1vgw4YqF15Ja4rJFnY
 gFWUCr95urs8Xa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUml14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
 x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
 ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS
 0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
 IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
 Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
 xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E
 4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
 WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
 Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
 WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
 JbIYCTnIWIevJa73UjIFyTuYvjfU5CztUUUUU
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQAMB2qOWvsAQwARsd
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

The vector state sync handles vstart, vl and vtype, but leaves vcsr
behind.  vxrm and vxsat in the migration stream are therefore stale,
and the destination does not restore the values held by KVM.

Read vcsr when collecting vector state and split it into vxrm and
vxsat.  Rebuild it from those fields when writing vector state back.

Fixes: 3ca78c0689d5 ("target/riscv/kvm: add RVV and Vector CSR regs")
Cc: qemu-stable@nongnu.org
Signed-off-by: Xie Bo <xb@ultrarisc.com>
---
 target/riscv/kvm/kvm-cpu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 1993bd446b..45ad5e1525 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -910,6 +910,13 @@ static int kvm_riscv_get_regs_vector(CPUState *cs)
     }
     env->vtype = reg;
 
+    ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(vcsr), &reg);
+    if (ret) {
+        return ret;
+    }
+    env->vxrm = (reg & VCSR_VXRM) >> VCSR_VXRM_SHIFT;
+    env->vxsat = (reg & VCSR_VXSAT) >> VCSR_VXSAT_SHIFT;
+
     if (kvm_v_vlenb.supported) {
         ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(vlenb), &reg);
         if (ret) {
@@ -966,6 +973,13 @@ static int kvm_riscv_put_regs_vector(CPUState *cs)
         return ret;
     }
 
+    reg = (env->vxrm << VCSR_VXRM_SHIFT) |
+          (env->vxsat << VCSR_VXSAT_SHIFT);
+    ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(vcsr), &reg);
+    if (ret) {
+        return ret;
+    }
+
     if (kvm_v_vlenb.supported) {
         reg = cpu->cfg.vlenb;
         ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(vlenb), &reg);
-- 
2.17.1


