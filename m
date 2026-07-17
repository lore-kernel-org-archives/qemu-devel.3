Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC10C4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 17:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkmc7-00018L-1U; Fri, 17 Jul 2026 13:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wkmc5-00017y-Kv; Fri, 17 Jul 2026 13:44:41 -0400
Received: from m16.mail.163.com ([117.135.210.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wkmc1-0002W2-1O; Fri, 17 Jul 2026 13:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=dc
 BYXKvEXuS1ZIzgwUOlicrmN5rzBDgv2rwoTtsElp4=; b=A3X8Fh8jN62hMxKjlz
 LO+tnUdw4b/jWYI2Cye9Ydbeyv1Y6nQmlllPBFOsKe8jx8Eyu/sE+U5nXjuwxOKv
 NhFi08pc5kOjnXXmMvPCQM1Yttme1A/uNAEDwH997+XMYNkWIu9zUu4w99pq/K11
 FMTGND2AZN/KPgNNM6i+YSrRU=
Received: from dt-VM.localdomain (unknown [])
 by gzsmtp1 (Coremail) with SMTP id PCgvCgA3K23uaVpqrimnGg--.13203S3;
 Sat, 18 Jul 2026 01:44:15 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 Tao Ding <dingtao0430@163.com>
Subject: [PATCH 1/1] aarch32 cpu secure register tcg migration
Date: Sat, 18 Jul 2026 01:44:12 +0800
Message-ID: <20260717174412.88258-2-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717174412.88258-1-dingtao0430@163.com>
References: <20260717174412.88258-1-dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PCgvCgA3K23uaVpqrimnGg--.13203S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw43JFW3JFW7KryxWrWxJFb_yoWrJFW7pr
 sxJryfKrWkWFy3Jws5Xrn8Grn8W393Xay7C397Kr1fAF13uryFvr4vk345GFy7CrWfA3Wr
 XFn5Ar13ua1xZFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEJPEsUUUUU=
X-Originating-IP: [119.4.20.225]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC4hDHBmpaafBQQQAA3L
Received-SPF: pass client-ip=117.135.210.2; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_MSPIKE_H2=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

In TCG mode, cpu_pre_save is called when saving state and cpu_post_load
is called when restore state. There are two key functions write_cpustate_to_list
and write_list_to_cpustate that use kvm_to_cpreg_id to obtain the regidx.

However, during the processing of kvm_to_cpreg_id, secure state information will
be lost in aarch32 cpu.
The code in kvm_to_cpreg_id always add the NS flag.
     "cpregid |= CP_REG_AA32_NS_MASK;"

The final result is that after migration, some secure registers were not restored, 
such as DACR_S. And this register will affect the CPU's access to the address.

To fix this issue, a new function kvm_to_cpreg_id_with_secure is added to 
restore secure bit information. Call different functions according to 
different modes to keep KVM unaffected.

Signed-off-by: Tao Ding <dingtao0430@163.com>
---
Steps to reproduce:
1. prepare uboot
     git clone https://github.com/u-boot/u-boot
     cd u-boot && make xilinx_zynq_virt_defconfig && make -j4
2. compile qemu
     mkdir build
     cd build && ../configure --target-list="arm-softmmu"
3. run qemu and save vmstate
     ./build/qemu-system-arm -M xilinx-zynq-a9 -machine boot-mode=sd -m 1024 \
     -display none -serial null -serial mon:stdio \
     -device loader,file=~/u-boot/u-boot-dtb.bin,addr=0x04000000,cpu-num=0 

Model: Xilinx ZC706 board
......
Hit any key to stop autoboot: 0
Zynq> 
(ctrl + a + c)
QEMU 11.0.90 monitor - type 'help' for more information
(qemu) migrate -d file:vmstate
(qemu) q

4. restore qemu
     ./build/qemu-system-arm -M xilinx-zynq-a9 -machine boot-mode=sd -m 1024 \
     -display none -serial null -serial mon:stdio \
     -device loader,file=~/u-boot/u-boot-dtb.bin,addr=0x04000000,cpu-num=0 \
     -incoming file:vmstate

Before fixed, the terminal will hang in step 4.
After fixed, Can enter uboot interaction normally in step 4.

 target/arm/cpregs.h | 11 +++++++++++
 target/arm/helper.c | 14 ++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 391c0e322b..c0d1235625 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -258,6 +258,17 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
     return kvmid;
 }
 
+/*
+ * Convert kvmid to cpreg_id but keep secure mask.
+ */
+static inline uint32_t kvm_to_cpreg_id_with_secure(uint64_t kvmid)
+{
+    uint32_t cpregid = kvm_to_cpreg_id(kvmid);
+    cpregid &= ~CP_REG_AA32_NS_MASK;
+    cpregid |= (kvmid & CP_REG_AA32_NS_MASK);
+    return cpregid;
+}
+
 /*
  * Valid values for ARMCPRegInfo state field, indicating which of
  * the AArch32 and AArch64 execution states this register is visible in.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index af45234ad2..c8fccf9c0e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -160,7 +160,12 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync)
     bool ok = true;
 
     for (i = 0; i < cpu->cpreg_array_len; i++) {
-        uint32_t regidx = kvm_to_cpreg_id(cpu->cpreg_indexes[i]);
+        uint32_t regidx;
+        if (kvm_enabled()) {
+            regidx = kvm_to_cpreg_id(cpu->cpreg_indexes[i]);
+        } else {
+            regidx = kvm_to_cpreg_id_with_secure(cpu->cpreg_indexes[i]);
+        }
         const ARMCPRegInfo *ri;
         uint64_t newval;
 
@@ -205,7 +210,12 @@ bool write_list_to_cpustate(ARMCPU *cpu)
     bool ok = true;
 
     for (i = 0; i < cpu->cpreg_array_len; i++) {
-        uint32_t regidx = kvm_to_cpreg_id(cpu->cpreg_indexes[i]);
+        uint32_t regidx;
+        if (kvm_enabled()) {
+            regidx = kvm_to_cpreg_id(cpu->cpreg_indexes[i]);
+        } else {
+            regidx = kvm_to_cpreg_id_with_secure(cpu->cpreg_indexes[i]);
+        }
         uint64_t v = cpu->cpreg_values[i];
         const ARMCPRegInfo *ri;
 
-- 
2.43.0


