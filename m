Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADE7CF9C73
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 12:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st54S-0003c8-8v; Tue, 24 Sep 2024 08:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhouquan@iscas.ac.cn>)
 id 1st0fj-00067V-HI; Tue, 24 Sep 2024 04:13:24 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <zhouquan@iscas.ac.cn>)
 id 1st0fh-0008GX-NT; Tue, 24 Sep 2024 04:13:23 -0400
Received: from zq-Legion-Y7000.. (unknown [180.111.100.113])
 by APP-03 (Coremail) with SMTP id rQCowAC3vKycdPJm1OOdAA--.562S2;
 Tue, 24 Sep 2024 16:13:16 +0800 (CST)
From: zhouquan@iscas.ac.cn
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, dbarboza@ventanamicro.com, zhouquan@iscas.ac.cn
Subject: [PATCH 2/2] target/riscv/kvm: Update kvm exts to Linux v6.11
Date: Tue, 24 Sep 2024 16:13:16 +0800
Message-ID: <ada40759a79c0728652ace59579aa843cb7bf53f.1727164986.git.zhouquan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1727164986.git.zhouquan@iscas.ac.cn>
References: <cover.1727164986.git.zhouquan@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAC3vKycdPJm1OOdAA--.562S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tryfXFyxurykWF1Uur45KFg_yoW8CFyUpr
 s3KFyfCrW8J348uw48trZ8Gr1UJ3yYyw4kGw4293W8JrW7CrySkF93t3ZxCa1DGa4rtryY
 vF4rWrnYkws8XwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUPY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
 xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
 8cxan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwI
 xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU6a0QU
 UUUU=
X-Originating-IP: [180.111.100.113]
X-CM-SenderInfo: 52kr31xxdqqxpvfd2hldfou0/1tbiBwoKBmbyQ5G4ZgAAsZ
Received-SPF: pass client-ip=159.226.251.81; envelope-from=zhouquan@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 24 Sep 2024 08:54:46 -0400
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
Message-ID: <20240924081316.eAkiF9xN7JmqsMl93QijEgegrjI7ayhaLIQ7FBuhUS4@z>

From: Quan Zhou <zhouquan@iscas.ac.cn>

Add support for a few Zc* extensions, Zimop, Zcmop and Zawrs.

Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
---
 target/riscv/kvm/kvm-cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index f6e3156b8d..428aaee552 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -281,7 +281,10 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zihintntl", ext_zihintntl, KVM_RISCV_ISA_EXT_ZIHINTNTL),
     KVM_EXT_CFG("zihintpause", ext_zihintpause, KVM_RISCV_ISA_EXT_ZIHINTPAUSE),
     KVM_EXT_CFG("zihpm", ext_zihpm, KVM_RISCV_ISA_EXT_ZIHPM),
+    KVM_EXT_CFG("zimop", ext_zimop, KVM_RISCV_ISA_EXT_ZIMOP),
+    KVM_EXT_CFG("zcmop", ext_zcmop, KVM_RISCV_ISA_EXT_ZCMOP),
     KVM_EXT_CFG("zacas", ext_zacas, KVM_RISCV_ISA_EXT_ZACAS),
+    KVM_EXT_CFG("zawrs", ext_zawrs, KVM_RISCV_ISA_EXT_ZAWRS),
     KVM_EXT_CFG("zfa", ext_zfa, KVM_RISCV_ISA_EXT_ZFA),
     KVM_EXT_CFG("zfh", ext_zfh, KVM_RISCV_ISA_EXT_ZFH),
     KVM_EXT_CFG("zfhmin", ext_zfhmin, KVM_RISCV_ISA_EXT_ZFHMIN),
@@ -292,6 +295,10 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zbkc", ext_zbkc, KVM_RISCV_ISA_EXT_ZBKC),
     KVM_EXT_CFG("zbkx", ext_zbkx, KVM_RISCV_ISA_EXT_ZBKX),
     KVM_EXT_CFG("zbs", ext_zbs, KVM_RISCV_ISA_EXT_ZBS),
+    KVM_EXT_CFG("zca", ext_zca, KVM_RISCV_ISA_EXT_ZCA),
+    KVM_EXT_CFG("zcb", ext_zcb, KVM_RISCV_ISA_EXT_ZCB),
+    KVM_EXT_CFG("zcd", ext_zcd, KVM_RISCV_ISA_EXT_ZCD),
+    KVM_EXT_CFG("zcf", ext_zcf, KVM_RISCV_ISA_EXT_ZCF),
     KVM_EXT_CFG("zknd", ext_zknd, KVM_RISCV_ISA_EXT_ZKND),
     KVM_EXT_CFG("zkne", ext_zkne, KVM_RISCV_ISA_EXT_ZKNE),
     KVM_EXT_CFG("zknh", ext_zknh, KVM_RISCV_ISA_EXT_ZKNH),
-- 
2.34.1


