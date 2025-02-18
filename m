Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D168C021AF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 21:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkV2E-00032b-Jv; Tue, 18 Feb 2025 16:21:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tkV2D-00032M-FX
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 16:21:41 -0500
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tkV2A-00033B-Sh
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 16:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739913697; bh=teoTsh+CvtnyfxlQFH0EO7DMOroSayuJqtpkRTSKTfg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=n3NvL8NiPH/rHw8FKMJbdXIIFYgY/Dn/528dNZloXwAR0nZk7aqo4EQNDLQAT5qYO
 oDcrJt1ge11oux8z2WSAzNC2H5woJhxDudH50rTicVRO5LM8hTVQgSB9h6FpbH6Coh
 oHj+sRo98S9Bg0R6t3WA2nIz2dOm888vUldBemsRzUM89N6d96jnaNjiH2C48LhGtU
 yzEzApIseB0Putu4AOwbMCnOB5/bmxWl4qDsFLg9SM2Ql9EspwcGTNszhe8xz06grq
 W/1HcVZURLsE09jiluxgsBP/RQhRuBCPyKYSEvxEiagwkdL0AshxlMjjUSnKcNo4nK
 zCMzyas+cdiyg==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 428253F20D3C
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 13:21:37 -0800 (PST)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id kI16fiP6pMAe; Tue, 18 Feb 2025 13:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739913694; bh=teoTsh+CvtnyfxlQFH0EO7DMOroSayuJqtpkRTSKTfg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=K2w1gBLPfGrank0tzejcTv8+SNqFbR80HEIxJXYTmi+ZZhpROaKFjVScIn0DID26Q
 0lYczHqQthQebWpzUNqV8eY32wLg/NfqoDsqvNA3aHHF9NRaqGdq3pA4ZuECLcBLXb
 V3hrCRCvJDKkjgPMhx0P0//bVsEXqOFwS1e1TZu3iSLgM6LfedQr1YSp78ymffHzVU
 msFeuns179kYgC/LGzzqYFgkoDxLPOFkaOjvYh8nwvmG7GoAXgf3lN6gOX9T9jJYbm
 iQMpkUaiL02nQ8d+CIXCl6g/m15195BPJLTrOFKU/kWPtrTBLRYO1rmT2TIcXxvy5o
 Kz2jGhVZYVHVA==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id E7EBE3F20DB1;
 Tue, 18 Feb 2025 13:21:34 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1000)
 id BDBC21E6009E; Tue, 18 Feb 2025 13:21:34 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: Keith Packard <keithp@keithp.com>
Subject: [PATCH 3/4] hw/rx: Reset the CPU at qemu reset time
Date: Tue, 18 Feb 2025 13:21:02 -0800
Message-ID: <20250218212103.2024039-4-keithp@keithp.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250218212103.2024039-1-keithp@keithp.com>
References: <20250215021654.1786679-1-keithp@keithp.com>
 <20250218212103.2024039-1-keithp@keithp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Keith Packard <keithp@keithp.com>
From:  Keith Packard via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This ensure that the CPU gets reset every time QEMU resets. Use either
the kernel entry point or the reset vector if no kernel was loaded.

Signed-off-by: Keith Packard <keithp@keithp.com>
---
 hw/rx/rx-gdbsim.c | 36 +++++++++++++++++++++++++++++++++++-
 target/rx/cpu.c   |  9 ++-------
 target/rx/cpu.h   |  3 +++
 3 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index 4afd77efd5..9e395ae345 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -22,6 +22,7 @@
 #include "qemu/guest-random.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "exec/cpu_ldst.h"
 #include "hw/loader.h"
 #include "hw/rx/rx62n.h"
 #include "system/qtest.h"
@@ -56,6 +57,34 @@ DECLARE_OBJ_CHECKERS(RxGdbSimMachineState, RxGdbSimMachineClass,
                      RX_GDBSIM_MACHINE, TYPE_RX_GDBSIM_MACHINE)
 
 
+static void rx_cpu_reset(void *opaque)
+{
+    RXCPU *cpu = opaque;
+    CPUState *cs = CPU(cpu);
+    CPURXState *env = cpu_env(cs);
+
+    cpu_reset(cs);
+
+    if (env->use_reset_pc) {
+        /*
+         * Load the PC with the starting address for the kernel
+         */
+        env->pc = env->reset_pc;
+    } else {
+        /*
+         * Load the initial PC from the reset vector. If there is
+         * a ROM containing that vector use that, otherwise read
+         * it from target memory.
+         */
+        uint32_t *resetvec_p = rom_ptr_for_as(cs->as, 0xfffffffc, 4);
+        if (resetvec_p) {
+            env->pc = ldl_p(resetvec_p);
+        } else {
+            env->pc = cpu_ldl_data(env, 0xfffffffc);
+        }
+    }
+}
+
 static void rx_load_image(RXCPU *cpu, const char *filename,
                           uint32_t start, uint32_t size)
 {
@@ -68,7 +97,8 @@ static void rx_load_image(RXCPU *cpu, const char *filename,
         fprintf(stderr, "qemu: could not load kernel '%s'\n", filename);
         exit(1);
     }
-    cpu->env.pc = start;
+    cpu->env.reset_pc = start;
+    cpu->env.use_reset_pc = true;
 
     /* setup exception trap trampoline */
     /* linux kernel only works little-endian mode */
@@ -87,6 +117,7 @@ static void rx_gdbsim_init(MachineState *machine)
     const char *kernel_filename = machine->kernel_filename;
     const char *dtb_filename = machine->dtb;
     uint8_t rng_seed[32];
+    CPUState *cs;
 
     if (machine->ram_size < mc->default_ram_size) {
         char *sz = size_to_str(mc->default_ram_size);
@@ -153,6 +184,9 @@ static void rx_gdbsim_init(MachineState *machine)
             s->mcu.cpu.env.regs[1] = SDRAM_BASE + dtb_offset;
         }
     }
+    for (cs = first_cpu; cs; cs = CPU_NEXT(cs)) {
+        qemu_register_reset(rx_cpu_reset, RX_CPU(cs));
+    }
 }
 
 static void rx_gdbsim_class_init(ObjectClass *oc, void *data)
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 37a6fdd569..528cda486c 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -76,7 +76,6 @@ static void rx_cpu_reset_hold(Object *obj, ResetType type)
     CPUState *cs = CPU(obj);
     RXCPUClass *rcc = RX_CPU_GET_CLASS(obj);
     CPURXState *env = cpu_env(cs);
-    uint32_t *resetvec;
 
     if (rcc->parent_phases.hold) {
         rcc->parent_phases.hold(obj, type);
@@ -84,11 +83,6 @@ static void rx_cpu_reset_hold(Object *obj, ResetType type)
 
     memset(env, 0, offsetof(CPURXState, end_reset_fields));
 
-    resetvec = rom_ptr(0xfffffffc, 4);
-    if (resetvec) {
-        /* In the case of kernel, it is ignored because it is not set. */
-        env->pc = ldl_p(resetvec);
-    }
     rx_cpu_unpack_psw(env, 0, 1);
     env->regs[0] = env->isp = env->usp = 0;
     env->fpsw = 0;
@@ -142,7 +136,6 @@ static void rx_cpu_realize(DeviceState *dev, Error **errp)
     }
 
     qemu_init_vcpu(cs);
-    cpu_reset(cs);
 
     rcc->parent_realize(dev, errp);
 }
@@ -189,6 +182,8 @@ static void rx_cpu_init(Object *obj)
 {
     RXCPU *cpu = RX_CPU(obj);
 
+    cpu->env.reset_pc = 0;
+    cpu->env.use_reset_pc = false;
     qdev_init_gpio_in(DEVICE(cpu), rx_cpu_set_irq, 2);
 }
 
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 5ba1874bd7..c42a03efb3 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -98,6 +98,9 @@ typedef struct CPUArchState {
     uint32_t ack_ipl;           /* execute ipl */
     float_status fp_status;
     qemu_irq ack;               /* Interrupt acknowledge */
+
+    bool use_reset_pc;          /* Use reset_pc instead of reset vector */
+    uint32_t reset_pc;          /* PC reset value when use_reset_pc */
 } CPURXState;
 
 /*
-- 
2.47.2


