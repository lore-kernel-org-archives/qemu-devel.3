Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A53CD484E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 02:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMcoy-0000ao-0P; Mon, 11 May 2026 22:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <min_halo@163.com>)
 id 1wMcov-0000WP-I0; Mon, 11 May 2026 22:26:06 -0400
Received: from m16.mail.163.com ([220.197.31.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <min_halo@163.com>)
 id 1wMcor-0007gX-Qy; Mon, 11 May 2026 22:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=tN
 vZjkPLtWPgkon/io+FpFV+gie2PZXSVNPlw/SVBsE=; b=Cua6r8oWV6cWiDGjMi
 6RBDOafnI4fKm3RvnBAMuL+HJHedKxXEWS3H6C+vlMTp+HbNfVs8HgKC60Q4m8Pr
 9LcX8AkhvHD+LErH3gIe4F8w6ntpnHA6//Zb9+rbmUHIz1hCMcvEVW9JH9H8WSBF
 XrxRnyb1m3LI8AKWYcyaxlfd8=
Received: from thinkpadx13gen2i.. (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wCntZKfjwJqqjd+Aw--.60433S3; 
 Tue, 12 May 2026 10:25:48 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH 1/2] target/riscv/kvm: add KVM support for Zicbop extension
Date: Tue, 12 May 2026 10:25:19 +0800
Message-Id: <bb6271546f870f3ee3cbeafdf0eb065925bb384d.1778551633.git.zhouzongmin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1778551633.git.zhouzongmin@kylinos.cn>
References: <cover.1778551633.git.zhouzongmin@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCntZKfjwJqqjd+Aw--.60433S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw17Wr4xZryUtFyrGr13CFg_yoW5trWUpr
 47Cw45CFy5Zr17C3y3Xr1kXF1Sgw4kCa1kG39ag3W7XFW7KryIgryvka45AF4UtF1xZrs8
 ZF1vgr4UCF4UJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzOJ5UUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbC8w0q1WoCj60f8wAA3n
Received-SPF: pass client-ip=220.197.31.5; envelope-from=min_halo@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

When the Zicbop extension is available expose it to the KVM guest.
Also read and validate cbop_blocksize from the host via KVM interface.

Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
---
 target/riscv/kvm/kvm-cpu.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index b047ffa9c0..a46737f934 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -293,6 +293,7 @@ static void kvm_cpu_csr_set_u64(RISCVCPU *cpu, KVMCPUConfig *csr_cfg,
 
 static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zicbom", ext_zicbom, KVM_RISCV_ISA_EXT_ZICBOM),
+    KVM_EXT_CFG("zicbop", ext_zicbop, KVM_RISCV_ISA_EXT_ZICBOP),
     KVM_EXT_CFG("zicboz", ext_zicboz, KVM_RISCV_ISA_EXT_ZICBOZ),
     KVM_EXT_CFG("ziccrse", ext_ziccrse, KVM_RISCV_ISA_EXT_ZICCRSE),
     KVM_EXT_CFG("zicntr", ext_zicntr, KVM_RISCV_ISA_EXT_ZICNTR),
@@ -439,6 +440,12 @@ static KVMCPUConfig kvm_cboz_blocksize = {
     .kvm_reg_id = KVM_REG_RISCV_CONFIG_REG(zicboz_block_size)
 };
 
+static KVMCPUConfig kvm_cbop_blocksize = {
+    .name = "cbop_blocksize",
+    .offset = CPU_CFG_OFFSET(cbop_blocksize),
+    .kvm_reg_id = KVM_REG_RISCV_CONFIG_REG(zicbop_block_size)
+};
+
 static KVMCPUConfig kvm_v_vlenb = {
     .name = "vlenb",
     .offset = CPU_CFG_OFFSET(vlenb),
@@ -1114,6 +1121,10 @@ static void kvm_riscv_read_multiext_legacy(RISCVCPU *cpu,
         kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cbom_blocksize);
     }
 
+    if (cpu->cfg.ext_zicbop) {
+        kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cbop_blocksize);
+    }
+
     if (cpu->cfg.ext_zicboz) {
         kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cboz_blocksize);
     }
@@ -1293,6 +1304,10 @@ static void kvm_riscv_init_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
         kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cbom_blocksize);
     }
 
+    if (cpu->cfg.ext_zicbop) {
+        kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cbop_blocksize);
+    }
+
     if (cpu->cfg.ext_zicboz) {
         kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cboz_blocksize);
     }
@@ -2014,8 +2029,8 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     int ret;
 
     /* short-circuit without spinning the scratch CPU */
-    if (!cpu->cfg.ext_zicbom && !cpu->cfg.ext_zicboz &&
-        !riscv_has_ext(env, RVV)) {
+    if (!cpu->cfg.ext_zicbom && !cpu->cfg.ext_zicbop &&
+        !cpu->cfg.ext_zicboz && !riscv_has_ext(env, RVV)) {
         return;
     }
 
@@ -2062,6 +2077,25 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
         }
     }
 
+    if (cpu->cfg.ext_zicbop &&
+        riscv_cpu_option_set(kvm_cbop_blocksize.name)) {
+
+        reg.id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CONFIG,
+                                        kvm_cbop_blocksize.kvm_reg_id);
+        reg.addr = (uint64_t)&val;
+        ret = ioctl(kvmcpu.cpufd, KVM_GET_ONE_REG, &reg);
+        if (ret != 0) {
+            error_setg_errno(errp, errno, "Unable to read cbop_blocksize");
+            return;
+        }
+
+        if (cpu->cfg.cbop_blocksize != val) {
+            error_setg(errp, "Unable to set cbop_blocksize to a different "
+                       "value than the host (%lu)", val);
+            return;
+        }
+    }
+
     /* Users are setting vlen, not vlenb */
     if (riscv_has_ext(env, RVV) && riscv_cpu_option_set("vlen")) {
         if (!kvm_v_vlenb.supported) {
-- 
2.43.0


