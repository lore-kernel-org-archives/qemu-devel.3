Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278F0CAC58E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 09:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvuMk-0000JD-Mz; Tue, 09 Sep 2025 05:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xb@ultrarisc.com>)
 id 1uvuMd-0000H2-2k; Tue, 09 Sep 2025 05:10:11 -0400
Received: from [218.76.62.146] (helo=ultrarisc.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xb@ultrarisc.com>)
 id 1uvuMY-0006ZV-Kf; Tue, 09 Sep 2025 05:10:10 -0400
Received: from ur-dp1000.. (unknown [192.168.100.1])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAfwDnYNAE779o6nwsAA--.43713S3; 
 Tue, 09 Sep 2025 17:11:06 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: qemu-devel@nongnu.org
Cc: ajones@ventanamicro.com, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 anup@brainfault.org, alistair.francis@wdc.com, rkrcmar@ventanamicro.com,
 palmer@dabbelt.com, xiamy@ultrarisc.com, Xie Bo <xb@ultrarisc.com>
Subject: [PATCH v5 for v10.0.0 1/2]
 =?UTF-8?q?target/riscv=EF=BC=9ASet-KVM-initial-pri?=
 =?UTF-8?q?vilege-mode=20and=20mp=5Fstate?=
Date: Tue,  9 Sep 2025 17:09:16 +0800
Message-ID: <20250909090917.21301-2-xb@ultrarisc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909090917.21301-1-xb@ultrarisc.com>
References: <20250818-e7e56e26bbf62a23417c2567@orel>
 <20250909090917.21301-1-xb@ultrarisc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDnYNAE779o6nwsAA--.43713S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr47XF1kur4xZry8Cry8Krg_yoW8Cw4fpF
 Z7Gw4akrykXaykJa1fJ3yDuw1UuayDGr45Cws7AryDJr45ZrWY9F1ktrW7CF9rXFW5Jrya
 9as8Zr15Aa1UZwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmm14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
 x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
 ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
 xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
 vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
 r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
 v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCF
 s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
 1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
 JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
 1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
 YxBIdaVFxhVjvjDU0xZFpf9x0JUqkskUUUUU=
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQAAB2i-hXAAHgAAs6
X-Host-Lookup-Failed: Reverse DNS lookup failed for 218.76.62.146 (failed)
Received-SPF: pass client-ip=218.76.62.146; envelope-from=xb@ultrarisc.com;
 helo=ultrarisc.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

For KVM mode, the privilege mode should not include M-mode, and the initial value should be set to S-mode. Additionally,patch 2 adds the implementation of putting the vCPU privilege mode to KVM. When the vCPU runs for the first time, QEMU will first put the privilege state to KVM.If the initial value is set to M-mode, KVM will encounter an error.

In addition, this patch introduces the 'mp_state' field to RISC-V vCPUs,following the convention used by KVM on x86. The 'mp_state' reflects the multiprocessor state of a vCPU, and is used to control whether the vCPU is runnable by KVM.
- The bootstrap processor (cpu_index == 0) is initialized with KVM_MP_STATE_RUNNABLE.
- All other vCPUs are initialized with KVM_MP_STATE_STOPPED.

Signed-off-by: Xie Bo <xb@ultrarisc.com>
---
 target/riscv/cpu.c | 11 ++++++++++-
 target/riscv/cpu.h |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 09ded6829a..5fa48c1485 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1042,7 +1042,16 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     }
 #ifndef CONFIG_USER_ONLY
     env->misa_mxl = mcc->misa_mxl_max;
-    env->priv = PRV_M;
+    if (kvm_enabled()) {
+        env->priv = PRV_S;
+    } else {
+        env->priv = PRV_M;
+    }
+    if (cs->cpu_index == 0) {
+        env->mp_state = KVM_MP_STATE_RUNNABLE;
+    } else {
+        env->mp_state = KVM_MP_STATE_STOPPED;
+    }
     env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
     if (env->misa_mxl > MXL_RV32) {
         /*
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 51e49e03de..4b1c5bf0e4 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -256,6 +256,8 @@ struct CPUArchState {
 #endif
 
     target_ulong priv;
+    /* Current multiprocessor state of this vCPU. */
+    uint32_t mp_state;
     /* CSRs for execution environment configuration */
     uint64_t menvcfg;
     target_ulong senvcfg;
-- 
2.43.0


