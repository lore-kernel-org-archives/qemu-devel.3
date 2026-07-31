Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4FF3C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpgFY-0002cf-Ud; Fri, 31 Jul 2026 01:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM5-0005rE-Sh; Thu, 30 Jul 2026 23:56:18 -0400
Received: from [115.124.30.119] (helo=out30-119.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM0-0002Id-8L; Thu, 30 Jul 2026 23:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785470168; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=niXZVhC6dZEmlpUlZukHv4t50+0oDWItTHBANrdas1g=;
 b=MYBj0xYNxOBLil091XudCcgj/ObhEpeJ38WfYEjWmtApEtYKaVL4c5bnVrrUBRq9KWZQe++Zcr5jys1GZFH986GNk6ieDdkYPUwOuCQkbIfWp3NIhFK5J01LTsMY33iWrfE5iG5leFkh2uAvnqzvahiX8nSiu61zugatf4HmX8M=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=blduan@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0X86jwUT_1785469856; 
Received: from ea134-sw16.eng.xrvm.cn(mailfrom:blduan@linux.alibaba.com
 fp:SMTPD_---0X86jwUT_1785469856 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 31 Jul 2026 11:50:57 +0800
From: Baolong Duan <blduan@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair23@gmail.com, dbarboza@ventanamicro.com,
 cxx194832@alibaba-inc.com, zengxiangyi.zxy@alibaba-inc.com,
 Baolong Duan <blduan@linux.alibaba.com>
Subject: [RFC PATCH v1 10/17] target/riscv/kvm: skip unsupported KVM requests
 for a CoVE guest
Date: Fri, 31 Jul 2026 11:50:04 +0800
Message-Id: <20260731035011.4178103-11-blduan@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731035011.4178103-1-blduan@linux.alibaba.com>
References: <20260731035011.4178103-1-blduan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.119 (deferred)
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=blduan@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 31 Jul 2026 01:57:33 -0400
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

A TEE VM has no APLIC and no PLIC, and its timer state lives inside the
TVM where the host cannot read it.  Skip the KVM requests that would fail
or return meaningless data: reading the timer back, injecting a wired
interrupt, and the APLIC part of the in-kernel AIA setup.

Note that kvm_mark_guest_state_protected(), which SEV and TDX use, would
cover the vCPU state part of this generically.  It is not used here
because it also changes the reset and migration paths, which have not
been evaluated for CoVE yet.

Signed-off-by: Baolong Duan <blduan@linux.alibaba.com>
---
 target/riscv/kvm/kvm-cpu.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 67c99d68ce..23c2ae2214 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1477,7 +1477,13 @@ static void kvm_riscv_vm_state_change(void *opaque, bool running,
     if (running) {
         kvm_riscv_put_regs_timer(cs);
     } else {
-        kvm_riscv_get_regs_timer(cs);
+        /*
+         * The timer state of a CoVE guest is kept inside the TVM and cannot
+         * be read back by the host.
+         */
+        if (!riscv_cove_vm_active()) {
+            kvm_riscv_get_regs_timer(cs);
+        }
     }
 }
 
@@ -1791,6 +1797,14 @@ void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level)
     int ret;
     unsigned virq = level ? KVM_INTERRUPT_SET : KVM_INTERRUPT_UNSET;
 
+    /*
+     * A CoVE guest has neither APLIC nor PLIC, so there is no wired
+     * interrupt to inject.
+     */
+    if (riscv_cove_vm_active()) {
+        return;
+    }
+
     if (irq != IRQ_S_EXT) {
         perror("kvm riscv set irq != IRQ_S_EXT\n");
         abort();
@@ -1924,8 +1938,11 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
      * This is done by leaving KVM_DEV_RISCV_AIA_CONFIG_SRCS
      * unset. We can also skip KVM_DEV_RISCV_AIA_ADDR_APLIC
      * since KVM won't be using it.
+     *
+     * The same applies to a CoVE guest: KVM does not implement an
+     * APLIC for a TVM, only the IMSIC is used.
      */
-    if (!kvm_kernel_irqchip_split()) {
+    if (!kvm_kernel_irqchip_split() && !riscv_cove_vm_active()) {
         ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
                                 KVM_DEV_RISCV_AIA_CONFIG_SRCS,
                                 &aia_irq_num, true, NULL);
-- 
2.34.1


