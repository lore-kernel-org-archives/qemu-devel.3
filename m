Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FBCC021B6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 04:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmQLo-0004DE-Er; Sun, 23 Feb 2025 23:45:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhouquan@iscas.ac.cn>)
 id 1tmQLe-0004Cq-Vt; Sun, 23 Feb 2025 23:45:43 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <zhouquan@iscas.ac.cn>)
 id 1tmQLb-00045f-Gz; Sun, 23 Feb 2025 23:45:42 -0500
Received: from zq-Legion-Y7000.smartont.net (unknown [180.110.114.221])
 by APP-01 (Coremail) with SMTP id qwCowAAHDtJl+btn_XfvDw--.45145S2;
 Mon, 24 Feb 2025 12:45:26 +0800 (CST)
From: zhouquan@iscas.ac.cn
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, dbarboza@ventanamicro.com, zhouquan@iscas.ac.cn
Subject: [PATCH] target/riscv/kvm: Add some exts support
Date: Mon, 24 Feb 2025 12:39:39 +0800
Message-Id: <303616ccad2b5309768157b50d93b3e89fecc9cb.1740371468.git.zhouquan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAHDtJl+btn_XfvDw--.45145S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWxWr18ZFWDGFyDJFy3CFg_yoW8XFyfpr
 sxKa13CrWkt34rZw4xtrs5Gr1UJrWFkw4kWwsF93WrX3y7CryIvFnFv3W3C3WDG3W0gryY
 vFs5ur48Cws8taUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
 1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
 628vn2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
 0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUW6wtUUUUU=
X-Originating-IP: [180.110.114.221]
X-CM-SenderInfo: 52kr31xxdqqxpvfd2hldfou0/1tbiBgsDBme77aMgJwAAsd
Received-SPF: pass client-ip=159.226.251.21; envelope-from=zhouquan@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Quan Zhou <zhouquan@iscas.ac.cn>

When the Sscofpmf/Svade/Svadu/Smnpm/Ssnpm exts is available
expose it to the guest so that guest can use it.

Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
---
 target/riscv/kvm/kvm-cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 23ce779359..06a9f30841 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -319,9 +319,14 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zvksed", ext_zvksed, KVM_RISCV_ISA_EXT_ZVKSED),
     KVM_EXT_CFG("zvksh", ext_zvksh, KVM_RISCV_ISA_EXT_ZVKSH),
     KVM_EXT_CFG("zvkt", ext_zvkt, KVM_RISCV_ISA_EXT_ZVKT),
+    KVM_EXT_CFG("smnpm", ext_smnpm, KVM_RISCV_ISA_EXT_SMNPM),
     KVM_EXT_CFG("smstateen", ext_smstateen, KVM_RISCV_ISA_EXT_SMSTATEEN),
     KVM_EXT_CFG("ssaia", ext_ssaia, KVM_RISCV_ISA_EXT_SSAIA),
+    KVM_EXT_CFG("sscofpmf", ext_sscofpmf, KVM_RISCV_ISA_EXT_SSCOFPMF),
+    KVM_EXT_CFG("ssnpm", ext_ssnpm, KVM_RISCV_ISA_EXT_SSNPM),
     KVM_EXT_CFG("sstc", ext_sstc, KVM_RISCV_ISA_EXT_SSTC),
+    KVM_EXT_CFG("svade", ext_svade, KVM_RISCV_ISA_EXT_SVADE),
+    KVM_EXT_CFG("svadu", ext_svadu, KVM_RISCV_ISA_EXT_SVADU),
     KVM_EXT_CFG("svinval", ext_svinval, KVM_RISCV_ISA_EXT_SVINVAL),
     KVM_EXT_CFG("svnapot", ext_svnapot, KVM_RISCV_ISA_EXT_SVNAPOT),
     KVM_EXT_CFG("svpbmt", ext_svpbmt, KVM_RISCV_ISA_EXT_SVPBMT),
-- 
2.34.1


