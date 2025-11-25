Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DFCD0E6F1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 14:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNu9p-0004eO-Ng; Tue, 25 Nov 2025 09:36:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hayekeh@163.com>) id 1vNmBs-00085i-3m
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:06:16 -0500
Received: from m16.mail.163.com ([220.197.31.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hayekeh@163.com>) id 1vNmBn-0000ZD-2k
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:06:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=NW
 fjgycnsm8qtQ4veqGhkWqgRgw6K4XZ4toUCoss/6Q=; b=pGNh0PIIqBf2QdOzIP
 zaRyNXsdfy/FZwM/Liluj/QTrqcbEUHXXqMjFfebmg27jDQwyzNHBjnGm1o8z3rf
 tKDTnIaV05QbAYuJvJDq/SsFsg7mm3T5gPC7wP9CI6jKpAYIq10x2cVVkYF0MV9U
 Fxdbd8FmYyEMvcpu7G5CPJk8o=
Received: from server.. (unknown [])
 by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id
 _____wBHr2oyRyVpwZXnCQ--.4884S2; 
 Tue, 25 Nov 2025 14:05:54 +0800 (CST)
From: Eric Huang <hayekeH@163.com>
To: qemu-devel@nongnu.org
Cc: Eric Huang <hayekeH@163.com>
Subject: [PATCH 1/2] target/riscv: Add a new RISC-V CPU type
Date: Tue, 25 Nov 2025 14:05:35 +0800
Message-Id: <20251125060536.1427659-1-hayekeH@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHr2oyRyVpwZXnCQ--.4884S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF1ftw45uFyUCFWDtw45trb_yoW5CFykpr
 15Grs8tryUJFsrKrs3GFWUXrnYgw1rZrWIq3sxZ3ZrGr42kFZxAr1kJr1DGw4vgr1rJ3WF
 gw18Cw1UJwsrXa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEID7gUUUUU=
X-Originating-IP: [183.47.95.194]
X-CM-SenderInfo: 5kd1vylhk6il2tof0z/1tbiTgURdmklPhZVZQABs5
Received-SPF: pass client-ip=220.197.31.3; envelope-from=hayekeh@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 25 Nov 2025 09:36:38 -0500
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

Signed-off-by: Eric Huang <hayekeH@163.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 72 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 75f4e434085..44ac0a3d29e 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -56,6 +56,7 @@
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
 #define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kunminghu")
+#define TYPE_RISCV_CPU_LEAPFIVE_V1      RISCV_CPU_TYPE_NAME("leapfive-v1")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
 
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 73d4280d7c8..30cda2212c6 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3306,6 +3306,78 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_SV48,
     ),
 
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_LEAPFIVE_V1, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVG | RVC | RVS | RVU | RVH | RVV,
+        .priv_spec = PRIV_VERSION_1_13_0,
+
+        /* victory-v1 V extenson/configs */
+        .cfg.vlenb = 64,
+        .cfg.elen = 64,
+
+        /* Unprivileged ISA Extensions */
+        .cfg.ext_zawrs = true,
+        .cfg.ext_zama16b = true,
+        .cfg.ext_zba = true,
+        .cfg.ext_zbb = true,
+        .cfg.ext_zbc = true,
+        .cfg.ext_zbs = true,
+        .cfg.ext_zcb = true,
+        .cfg.ext_zcmop = true,
+        .cfg.ext_zimop = true,
+        .cfg.ext_ziccrse = true,
+        .cfg.ext_zfa = true,
+        .cfg.ext_zfhmin = true,
+        .cfg.ext_zfbfmin = true,
+
+        .cfg.ext_zic64b = true,
+        .cfg.ext_zicntr = true,
+        .cfg.ext_zicond = true,
+        .cfg.ext_zicsr = true,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zihintntl = true,
+        .cfg.ext_zihintpause = true,
+        .cfg.ext_zihpm = true,
+
+        .cfg.ext_zkt = true,
+        .cfg.ext_zvbb = true,
+        .cfg.ext_zvbc = true,
+        .cfg.ext_zvfhmin = true,
+        .cfg.ext_zvfbfwma = true,
+        .cfg.ext_zvfbfmin = true,
+        .cfg.ext_zvkt = true,
+        .cfg.ext_zvkn = true,
+        .cfg.ext_zvkg = true,
+        .cfg.ext_sha = true,
+
+        /* Privileged ISA Extensions */
+        .cfg.ext_smaia = true,
+        .cfg.ext_smepmp = true,
+        .cfg.ext_smstateen = true,
+        .cfg.ext_ssaia = true,
+        .cfg.ext_sscofpmf = true,
+        .cfg.ext_sstc = true,
+        .cfg.ext_svinval = true,
+        .cfg.ext_svnapot = true,
+        .cfg.ext_smnpm = true,
+        .cfg.ext_svpbmt = true,
+        .cfg.ext_ssnpm = true,
+        .cfg.ext_svvptc = true,
+        .cfg.ext_sspm = true,
+        .cfg.ext_supm = true,
+        .cfg.ext_svade = true,
+
+        .cfg.ext_zicbom = true,
+        .cfg.ext_zicbop = true,
+        .cfg.ext_zicboz = true,
+        .cfg.cbom_blocksize = 64,
+        .cfg.cbop_blocksize = 64,
+        .cfg.cboz_blocksize = 64,
+        .cfg.mmu = true,
+        .cfg.pmp = true,
+        .cfg.max_satp_mode = VM_1_10_SV48,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
-- 
2.34.1


