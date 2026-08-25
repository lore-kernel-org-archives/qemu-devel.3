Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA55CC61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyrF-0005wd-Qa; Tue, 25 Aug 2026 17:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyrE-0005wA-Sx; Tue, 25 Aug 2026 17:39:00 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyrC-000580-R7; Tue, 25 Aug 2026 17:39:00 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 446FF80900;
 Wed, 26 Aug 2026 00:38:57 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-ivIrbZkj; Wed, 26 Aug 2026 00:38:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693936;
 bh=OTcaoVL0jFQJye1RDa6kfEsVtuP3AO7ZE+Bi7QLZWuc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=jUBX6XD81CfXyN1M4tuoMvwgHYLdC0E3OLPrcTL6HYnWVdTc7Du+z12+7DLkRGHA6
 xo7x+4nABDaUI8hoyuIC96U5FQsJXwbQjG0DxlwTEUVxRpbovInZABwRZXgpfsOyGA
 bnRBtO1NH8fd+YFs8rbiUQ+o0m8yKVmSu+esZNZk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH 27/30] arm/machine: move to new migration APIs
Date: Wed, 26 Aug 2026 00:38:07 +0300
Message-ID: <20260825213811.3725682-28-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 target/arm/machine.c | 107 ++++++++++++++++++++++---------------------
 1 file changed, 56 insertions(+), 51 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index 89127e5d83c..159a1f0e930 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -51,8 +51,8 @@ static bool vfp_fpcr_fpsr_needed(void *opaque)
         (vfp_get_fpsr(env) & ~FPSCR_FPSR_MASK);
 }
 
-static int get_fpscr(QEMUFile *f, void *opaque, size_t size,
-                     const VMStateField *field)
+static bool load_fpscr(QEMUFile *f, void *opaque, size_t size,
+                     const VMStateField *field, Error **errp)
 {
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
@@ -62,78 +62,81 @@ static int get_fpscr(QEMUFile *f, void *opaque, size_t size,
         /* 0 means we might have the data in the fpcr_fpsr subsection */
         vfp_set_fpscr(env, val);
     }
-    return 0;
+    return true;
 }
 
-static int put_fpscr(QEMUFile *f, void *opaque, size_t size,
-                     const VMStateField *field, JSONWriter *vmdesc)
+static bool save_fpscr(QEMUFile *f, void *opaque, size_t size,
+                      const VMStateField *field,
+                      JSONWriter *vmdesc, Error **errp)
 {
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
     uint32_t fpscr = vfp_fpcr_fpsr_needed(opaque) ? 0 : vfp_get_fpscr(env);
 
     qemu_put_be32(f, fpscr);
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_fpscr = {
     .name = "fpscr",
-    .get = get_fpscr,
-    .put = put_fpscr,
+    .load = load_fpscr,
+    .save = save_fpscr,
 };
 
-static int get_fpcr(QEMUFile *f, void *opaque, size_t size,
-                     const VMStateField *field)
+static bool load_fpcr(QEMUFile *f, void *opaque, size_t size,
+                     const VMStateField *field, Error **errp)
 {
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
     uint64_t val = qemu_get_be64(f);
 
     vfp_set_fpcr(env, val);
-    return 0;
+    return true;
 }
 
-static int put_fpcr(QEMUFile *f, void *opaque, size_t size,
-                     const VMStateField *field, JSONWriter *vmdesc)
+static bool save_fpcr(QEMUFile *f, void *opaque, size_t size,
+                    const VMStateField *field,
+                    JSONWriter *vmdesc, Error **errp)
 {
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
 
     qemu_put_be64(f, vfp_get_fpcr(env));
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_fpcr = {
     .name = "fpcr",
-    .get = get_fpcr,
-    .put = put_fpcr,
+    .load = load_fpcr,
+    .save = save_fpcr,
 };
 
-static int get_fpsr(QEMUFile *f, void *opaque, size_t size,
-                     const VMStateField *field)
+static bool load_fpsr(QEMUFile *f, void *opaque, size_t size,
+                     const VMStateField *field, Error **errp)
 {
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
     uint64_t val = qemu_get_be64(f);
 
     vfp_set_fpsr(env, val);
-    return 0;
+    return true;
 }
 
-static int put_fpsr(QEMUFile *f, void *opaque, size_t size,
-                     const VMStateField *field, JSONWriter *vmdesc)
+static bool save_fpsr(QEMUFile *f, void *opaque, size_t size,
+                    const VMStateField *field,
+                    JSONWriter *vmdesc, Error **errp)
 {
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
 
     qemu_put_be64(f, vfp_get_fpsr(env));
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_fpsr = {
     .name = "fpsr",
-    .get = get_fpsr,
-    .put = put_fpsr,
+    .load = load_fpsr,
+    .save = save_fpsr,
 };
 
 static const VMStateDescription vmstate_vfp_fpcr_fpsr = {
@@ -755,8 +758,8 @@ static const VMStateDescription vmstate_m_security = {
     }
 };
 
-static int get_cpsr(QEMUFile *f, void *opaque, size_t size,
-                    const VMStateField *field)
+static bool load_cpsr(QEMUFile *f, void *opaque, size_t size,
+                    const VMStateField *field, Error **errp)
 {
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
@@ -797,22 +800,22 @@ static int get_cpsr(QEMUFile *f, void *opaque, size_t size,
         }
         /* Ignore the low bits, they are handled by vmstate_m. */
         xpsr_write(env, val, ~XPSR_EXCP);
-        return 0;
+        return true;
     }
 
     env->aarch64 = ((val & PSTATE_nRW) == 0);
 
     if (is_a64(env)) {
         pstate_write(env, val);
-        return 0;
+        return true;
     }
 
     cpsr_write(env, val, 0xffffffff, CPSRWriteRaw);
-    return 0;
+    return true;
 }
 
-static int put_cpsr(QEMUFile *f, void *opaque, size_t size,
-                    const VMStateField *field, JSONWriter *vmdesc)
+static bool save_cpsr(QEMUFile *f, void *opaque, size_t size,
+                    const VMStateField *field, JSONWriter *vmdesc, Error **errp)
 {
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
@@ -828,17 +831,17 @@ static int put_cpsr(QEMUFile *f, void *opaque, size_t size,
     }
 
     qemu_put_be32(f, val);
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_cpsr = {
     .name = "cpsr",
-    .get = get_cpsr,
-    .put = put_cpsr,
+    .load = load_cpsr,
+    .save = save_cpsr,
 };
 
-static int get_pstate64(QEMUFile *f, void *opaque, size_t size,
-                        const VMStateField *field)
+static bool load_pstate64(QEMUFile *f, void *opaque, size_t size,
+                        const VMStateField *field, Error **errp)
 {
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
@@ -850,11 +853,12 @@ static int get_pstate64(QEMUFile *f, void *opaque, size_t size,
     } else {
         cpsr_write_from_spsr_elx(env, val);
     }
-    return 0;
+    return true;
 }
 
-static int put_pstate64(QEMUFile *f, void *opaque, size_t size,
-                        const VMStateField *field, JSONWriter *vmdesc)
+static bool save_pstate64(QEMUFile *f, void *opaque, size_t size,
+                         const VMStateField *field,
+                         JSONWriter *vmdesc, Error **errp)
 {
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
@@ -866,7 +870,7 @@ static int put_pstate64(QEMUFile *f, void *opaque, size_t size,
         val = cpsr_read_for_spsr_elx(env);
     }
     qemu_put_be64(f, val);
-    return 0;
+    return true;
 }
 
 static bool pstate64_needed(void *opaque)
@@ -901,8 +905,8 @@ static const VMStateDescription vmstate_pstate64 = {
             .size = sizeof(uint64_t),
             .info = &(const VMStateInfo) {
                 .name = "pstate64",
-                .get = get_pstate64,
-                .put = put_pstate64,
+                .load = load_pstate64,
+                .save = save_pstate64,
             },
             .flags = VMS_SINGLE,
             .offset = 0,
@@ -911,17 +915,17 @@ static const VMStateDescription vmstate_pstate64 = {
     },
 };
 
-static int get_power(QEMUFile *f, void *opaque, size_t size,
-                    const VMStateField *field)
+static bool load_power(QEMUFile *f, void *opaque, size_t size,
+                    const VMStateField *field, Error **errp)
 {
     ARMCPU *cpu = opaque;
     bool powered_off = qemu_get_byte(f);
     arm_set_cpu_power_state(cpu, powered_off ? PSCI_OFF : PSCI_ON);
-    return 0;
+    return true;
 }
 
-static int put_power(QEMUFile *f, void *opaque, size_t size,
-                    const VMStateField *field, JSONWriter *vmdesc)
+static bool save_power(QEMUFile *f, void *opaque, size_t size,
+                    const VMStateField *field, JSONWriter *vmdesc, Error **errp)
 {
     ARMCPU *cpu = opaque;
 
@@ -931,16 +935,17 @@ static int put_power(QEMUFile *f, void *opaque, size_t size,
         cpu->power_state == PSCI_OFF) {
         bool powered_off = (cpu->power_state == PSCI_OFF) ? true : false;
         qemu_put_byte(f, powered_off);
-        return 0;
+        return true;
     } else {
-        return 1;
+        error_setg(errp, "Migration should not happen during power transition");
+        return false;
     }
 }
 
 static const VMStateInfo vmstate_powered_off = {
     .name = "powered_off",
-    .get = get_power,
-    .put = put_power,
+    .load = load_power,
+    .save = save_power,
 };
 
 static bool syndrome64_needed(void *opaque)
-- 
2.43.0


