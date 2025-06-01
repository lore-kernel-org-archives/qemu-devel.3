Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80EFC5AE59
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 01:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLXGF-0006Nv-02; Sat, 31 May 2025 21:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1uLXGA-0006NS-Ez
 for qemu-devel@nongnu.org; Sat, 31 May 2025 21:13:13 -0400
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1uLXG7-0007YB-Os
 for qemu-devel@nongnu.org; Sat, 31 May 2025 21:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1748740384; bh=CUbukhQU3/CyVim5q4PHrJr6SwGMKyDByRSt72Ermz4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=PMX+6wVBFPdLm6XRZ1i/AbNlSAHC7MbF5sSD+i4cIpXnkgorLtzyuLHuJRTROA0Dq
 s5Nze2A5Vy3ph4aYg8SCXO6WHIluVY0n2/7ahbHGi0t6ZR5ttZjgE59xKkTEHCNXBq
 TP5z7ftF/OeP3DzY1NDuolNwON+AE/C3Ooi7EUWjua6y90JR9qqeBqoTtEc7K93SDP
 YsSKbrHtNjMsvOJRTWAiIwPT2bighRGOXIGR27j8Gub+z0iJXNKF9hYjauEII1h776
 FEBIWA1sHVMyBwBSXEuKDGbuK8ryMDGQ9saRZOCPQ4U3J3b5J+evo5j5ySxKB6FyrN
 ym2JSZ3S1/LTw==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 7B3783F226AB;
 Sat, 31 May 2025 18:13:04 -0700 (PDT)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id p4Qe2I27OZPb; Sat, 31 May 2025 18:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1748740382; bh=CUbukhQU3/CyVim5q4PHrJr6SwGMKyDByRSt72Ermz4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=mQf3bOc2AMDD4IQBTQj1x+1x+L86XD3tWxPbjDJ/dLRVlK40nYv4MZWsqXjvDeiin
 EQqmuNda4yescaQea/S9el55qFxTV3O4iewSA/SsKOrQuajSsIaY7yxlO+cUAb+9X/
 tmxrEQHOhyfdhe8lRGEOIVBkdjMhwKsB7LUA1Mbxbn1B7TZeIv0THTSXLkfKS4K9l7
 FVoAGzbbj1Lt93yTU5BafpAOCPFqm1Z+PWFwWnKYnmIWMGKpNzuukTmhBsZr9EFHWL
 MEHf8PSMW8RNBCY6xhoHlVya62uZjL0cokgiLe3IYsRoiuBEf+TqYHnxkF4c9oOASz
 VBIotPbAWZwXQ==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id E1F6C3F204E1;
 Sat, 31 May 2025 18:13:02 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
 id C772B1E600FB; Sat, 31 May 2025 18:13:02 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 3/4] hw/rx: Reset the CPU at qemu reset time
In-Reply-To: <CAFEAcA-YDsGJNyARdv4_3TmzvDyT06xykzLCxyVXY3YZCk6bCA@mail.gmail.com>
References: <20250215021654.1786679-1-keithp@keithp.com>
 <20250218212103.2024039-1-keithp@keithp.com>
 <20250218212103.2024039-4-keithp@keithp.com>
 <CAFEAcA-YDsGJNyARdv4_3TmzvDyT06xykzLCxyVXY3YZCk6bCA@mail.gmail.com>
Date: Sat, 31 May 2025 18:13:02 -0700
Message-ID: <87o6v8cli9.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain

From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 07 Mar 2025 13:26:14 +0000

> Unless there's a strong reason for doing something different,
> I would favour following the same pattern arm does for this.

Thanks for the suggested cleanup; this looks a lot nicer now.


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-hw-rx-Reset-the-CPU-at-qemu-reset-time.patch
Content-Transfer-Encoding: quoted-printable

From=2002d0f2b006500dec62e91bd571a8722c354133e5 Mon Sep 17 00:00:00 2001
From: Keith Packard <keithp@keithp.com>
Date: Wed, 12 Feb 2025 16:42:38 -0800
Subject: [PATCH] hw/rx: Reset the CPU at qemu reset time

This ensure that the CPU gets reset every time QEMU resets. Use either
the kernel entry point or the reset vector if no kernel was loaded.

Signed-off-by: Keith Packard <keithp@keithp.com>
=2D--
 hw/rx/rx-gdbsim.c | 31 ++++++++++++++++++++++++++++++-
 target/rx/cpu.c   | 20 +++++++++++++-------
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index 5b9004e9e1..5765cb91c6 100644
=2D-- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -22,6 +22,7 @@
 #include "qemu/guest-random.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "hw/loader.h"
 #include "hw/rx/rx62n.h"
 #include "system/qtest.h"
@@ -47,6 +48,9 @@ struct RxGdbSimMachineState {
     MachineState parent_obj;
     /*< public >*/
     RX62NState mcu;
+
+    bool use_reset_pc;          /* Use reset_pc instead of reset vector */
+    uint32_t reset_pc;          /* PC reset value when use_reset_pc */
 };
 typedef struct RxGdbSimMachineState RxGdbSimMachineState;
=20
@@ -56,9 +60,29 @@ DECLARE_OBJ_CHECKERS(RxGdbSimMachineState, RxGdbSimMachi=
neClass,
                      RX_GDBSIM_MACHINE, TYPE_RX_GDBSIM_MACHINE)
=20
=20
+static void rx_cpu_reset(void *opaque)
+{
+    RXCPU *cpu =3D opaque;
+    CPUState *cs =3D CPU(cpu);
+    CPURXState *env =3D cpu_env(cs);
+    MachineState *machine =3D MACHINE(qdev_get_machine());
+    RxGdbSimMachineState *s =3D RX_GDBSIM_MACHINE(machine);
+
+    cpu_reset(cs);
+
+    if (s->use_reset_pc) {
+        /*
+         * Load the PC with the starting address for the kernel
+         */
+        env->pc =3D s->reset_pc;
+    }
+}
+
 static void rx_load_image(RXCPU *cpu, const char *filename,
                           uint32_t start, uint32_t size)
 {
+    MachineState *machine =3D MACHINE(qdev_get_machine());
+    RxGdbSimMachineState *s =3D RX_GDBSIM_MACHINE(machine);
     static uint32_t extable[32];
     long kernel_size;
     int i;
@@ -68,7 +92,8 @@ static void rx_load_image(RXCPU *cpu, const char *filenam=
e,
         fprintf(stderr, "qemu: could not load kernel '%s'\n", filename);
         exit(1);
     }
=2D    cpu->env.pc =3D start;
+    s->reset_pc =3D start;
+    s->use_reset_pc =3D true;
=20
     /* setup exception trap trampoline */
     /* linux kernel only works little-endian mode */
@@ -87,6 +112,7 @@ static void rx_gdbsim_init(MachineState *machine)
     const char *kernel_filename =3D machine->kernel_filename;
     const char *dtb_filename =3D machine->dtb;
     uint8_t rng_seed[32];
+    CPUState *cs;
=20
     if (machine->ram_size < mc->default_ram_size) {
         char *sz =3D size_to_str(mc->default_ram_size);
@@ -153,6 +179,9 @@ static void rx_gdbsim_init(MachineState *machine)
             s->mcu.cpu.env.regs[1] =3D SDRAM_BASE + dtb_offset;
         }
     }
+    for (cs =3D first_cpu; cs; cs =3D CPU_NEXT(cs)) {
+        qemu_register_reset(rx_cpu_reset, RX_CPU(cs));
+    }
 }
=20
 static void rx_gdbsim_class_init(ObjectClass *oc, const void *data)
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index c6dd5d6f83..4d568bbd92 100644
=2D-- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -29,6 +29,7 @@
 #include "fpu/softfloat.h"
 #include "tcg/debug-assert.h"
 #include "accel/tcg/cpu-ops.h"
+#include "accel/tcg/cpu-ldst.h"
=20
 static void rx_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -89,7 +90,6 @@ static void rx_cpu_reset_hold(Object *obj, ResetType type)
     CPUState *cs =3D CPU(obj);
     RXCPUClass *rcc =3D RX_CPU_GET_CLASS(obj);
     CPURXState *env =3D cpu_env(cs);
=2D    uint32_t *resetvec;
=20
     if (rcc->parent_phases.hold) {
         rcc->parent_phases.hold(obj, type);
@@ -97,11 +97,6 @@ static void rx_cpu_reset_hold(Object *obj, ResetType typ=
e)
=20
     memset(env, 0, offsetof(CPURXState, end_reset_fields));
=20
=2D    resetvec =3D rom_ptr(0xfffffffc, 4);
=2D    if (resetvec) {
=2D        /* In the case of kernel, it is ignored because it is not set. */
=2D        env->pc =3D ldl_p(resetvec);
=2D    }
     rx_cpu_unpack_psw(env, 0, 1);
     env->regs[0] =3D env->isp =3D env->usp =3D 0;
     env->fpsw =3D 0;
@@ -124,6 +119,18 @@ static void rx_cpu_reset_hold(Object *obj, ResetType t=
ype)
      * be the correct setting.
      */
     set_float_ftz_detection(float_ftz_before_rounding, &env->fp_status);
+
+    /*
+     * Load the initial PC from the reset vector. If there is
+     * a ROM containing that vector use that, otherwise read
+     * it from target memory.
+     */
+    uint32_t *resetvec_p =3D rom_ptr_for_as(cs->as, 0xfffffffc, 4);
+    if (resetvec_p) {
+        env->pc =3D ldl_p(resetvec_p);
+    } else {
+        env->pc =3D cpu_ldl_data(env, 0xfffffffc);
+    }
 }
=20
 static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
@@ -155,7 +162,6 @@ static void rx_cpu_realize(DeviceState *dev, Error **er=
rp)
     }
=20
     qemu_init_vcpu(cs);
=2D    cpu_reset(cs);
=20
     rcc->parent_realize(dev, errp);
 }
=2D-=20
2.49.0


--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Btw, I went and looked at other qemu target support for -kernel; a whole
bunch support loading of arbitrary .elf files using that parameter. I
had to temporarily add that patch back in to test the enclosed reset
change...

=2D-=20
=2Dkeith

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAmg7qR4ACgkQ2yIaaQAA
ABHGThAAosRQUp+moLyhR3vDCFPEw3OL7N73Un5kzRg+Q4/c5LfJLsd6hMiGQexX
uY1oJB3aao4AyIWeVT9e4B2GtD589LYgkwqie3Y2Q+npNoPiVJ3ucLMnugsLGLxN
P2jbPvwvu0wGp0KE9A6sH6nuR7CwG3UThVIa8Byv9y2z6ylDxDnslGrX0Hfdr8nX
XkfvW8pylg/gldH4nP4/b2aUrQbmGTB14x4cPAjx1VAiVTmcdj4slBjBvQx/PhRh
5TVyzkozyL2Nbf50+cOj8APreWIYbNbSI7QuDjozgnOUDCSHI9V4XkHL+gV5MRJc
X32dw7HG1fluZYvHALm0cWYo42hbrhIGABEu7HYS1X6C1c0MUXaQzv73XcpYeRs4
EFO8rZdmsJg0R1zzt64gU5Ykw31t44KRwOEDEio4/zVHw86Qc2CtfImtGzSmMi0x
CEgoRzryULSwBkzRxcTAj/yhSnKJ1/kCIcExfVSnTcQ/Ih4aSL+VPZFkMBv/+APi
rO3p6lxCIUSZ6ok4HyXrkHzNKzqZg54ZZnySqPlKLCDybxV7mk+kKhiV3WDUhKX6
7lvMW/h1mpoDSwHuwtqtvdERLHrVJ+2RJYDI2v1/ZUHymWJls8YWsjrqvWLvZ1Mh
0j2Sh1TpnoBgwx2uifXxsqSaWQxY1Xgv0+mL5eyxj/SQuI8SCrM=
=tsyN
-----END PGP SIGNATURE-----
--==-=-=--

