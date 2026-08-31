Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70278C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x17AV-0008KE-GL; Mon, 31 Aug 2026 14:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x17AR-0008Jl-0w
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:55:39 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x17AN-0007o2-9v
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:55:38 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4843e9c5960so87809f8f.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 11:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788202533; x=1788807333; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=O5DVkrjuURnSyFjcfrphawr+MGHfDMu1MsGnQwJw27k=;
 b=glR8KFFFPfqMKxKpCgvtJzBFzZHDzRDk95PFOL4caqZQ8UZFSEDO2EnBJS7WAu6vKy
 k5x5T9JKzBL56P1OAes7LedE0gKG7XaRZVSbT+LWEu9FYi2waW91ktC1NHbCH+4y5U8H
 lhkLF+tbwpn8GoCO0I9QJ2nIryIxyxbOM2a94oA9loh2HaR9NCBIfM7wi3zimEGYstGV
 a4eTOBetCjccqPyjTUCMKAk7GfmPNdOZjiA0lGgadIAMuwklhPW7jHtVkw5StZc+DvQC
 J8mAsaE1u/58jCRVq5/8Ps6OfAem9vUjalaWGUj2CLw/G5U8XslmNDm9AofpUeo6HxU9
 zS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788202533; x=1788807333;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O5DVkrjuURnSyFjcfrphawr+MGHfDMu1MsGnQwJw27k=;
 b=HKLMHl8zdZl4Zpo1I7XeFK4+P72rTDbRfALKliqyYJwyvU+RmC3nr1it+K+pSwuyq9
 6yaqqBN1NbynCbvX9HS9VhsMAlyyHMt7vAOwvy4SI5p4AJVpivpFGWQatpWM2UuXE2wy
 pXsmKujb7B7O331JJHsetmoPYmg3D9uvoGRrArWxSzXjstQ0RGMstHwB4cLwk1lAy3CK
 bBKTdcQeVdAXVQTbjnCrDxoR87NfdFt/8B1z0J20M3HgNHBczY6pUKwoSBudJ2eWlmIU
 ZU5IOZ7iPRcmOYgMfnc5MAWMiIrAXa3A3LaQu3teh0kzqblxLIR25HZyZMsgJKZyMy5p
 L63w==
X-Gm-Message-State: AFuF++laO1oFFa239oNLD3DbvItNjWkY1uSQEvNu3U/e9Hi+1wry7b4L
 gniJ7FN12S6s7mx1P/8c/SG+1avUGPhlfiZ4ykp1eb44HmSMoL3/qLXEllF3GA==
X-Gm-Gg: AYBFou2ANXPI7U/EB6WFUGL4aAY0G9IXGodjc+dLia+6IkZbHIgNbdr5tWez4JCZJSg
 hBZx1+vgijHwoyOV/XFr0vBnEroxBOZD3N6+4UYrxhJlJImpahn/deHtPnFpPdx3uxbBERw98za
 52+wEDajvO7eKvHPAW9Yiy2RrPfsjxqJW4SSyHhy4qTHs0+E57bdYPNbL99wv30SN99+May4NeC
 j+31370br5LRJ1Iw6mtLbgY8AtZKJPhkHqjBpRJQ/RijkvuqgWWtxfMJGeTPnx2cuoSun4J/UKM
 WPKJAjuvHEATWUYt+QMUmwK1h1GuOiLTqBL0ADOI2D83bsOJYBCLucKTk87bROmuUvKC4hhhlQy
 UESv1fLtCz+FYQnQ3WlEHVJPqarLp3HIicmb0uX4S0M43lN9WXgcv+m4maAT6NJU+FvOD0bnSKu
 D6IhXbRqRapB1F3gY60zoL0Uwwm43l4uQ61bxt34HioJT2fWzwgi0cfEn4trXNT016tZfdycJZH
 IyebAahgiMIBCU8q+qEjd2c7gxMlo4YN2dxcTwUgFQvfis8VcxUCi2+oGv4yCeSx7dXu1fMAc/o
 iZH2Jfro
X-Received: by 2002:a05:6000:1449:b0:47f:fb2e:f63d with SMTP id
 ffacd0b85a97d-482f79859b9mr39266162f8f.9.1788202532949; 
 Mon, 31 Aug 2026 11:55:32 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-290d-6700-d99b-d42d-2461-dbe0.310.pool.telefonica.de.
 [2a02:3100:290d:6700:d99b:d42d:2461:dbe0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbad08d2sm26307498f8f.16.2026.08.31.11.55.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 11:55:32 -0700 (PDT)
Date: Mon, 31 Aug 2026 17:56:00 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>
CC: pbonzini@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCHv2 6/7] hw/arm: Enable Cortex-M7 AMP boot on i.MX8MP
In-Reply-To: <20260706162859.3361063-7-gaurav.sharma_7@nxp.com>
References: <20260706162859.3361063-1-gaurav.sharma_7@nxp.com>
 <20260706162859.3361063-7-gaurav.sharma_7@nxp.com>
Message-ID: <C4E61885-855A-4254-AE68-D87220ECC6EB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_CSS=0.1, URIBL_CSS_A=0.1,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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



Am 6=2E Juli 2026 16:28:58 UTC schrieb Gaurav Sharma <gaurav=2Esharma_7@nx=
p=2Ecom>:
>Configure the i=2EMX8MP to boot the Cortex-M7 core alongside
>the Cortex-A53 cores in an Asymmetric Multiprocessing (AMP)
>configuration=2E The M7 firmware can be loaded and started from Linux
>running on the A53 cores via the remoteproc framework=2E
>
>CM7 boot is made optional=2E A GPR IRQ is connected to a cpuwait handler=
=2E
>The handler translates the CPUWAIT into STOP and RUN=2EIt follows the
>classic Cortex-M boot sequence: initial SP and reset vector taken from
>the vector table=2E
>
>Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>---
> docs/system/arm/imx8m=2Erst   | 184 +++++++++++++++++++++++++++++++++++-
> hw/arm/fsl-imx8mp=2Ec         | 151 ++++++++++++++++++++++++++---
> hw/arm/imx8mp-evk=2Ec         |   3 +-
> include/hw/arm/fsl-imx8mp=2Eh |  13 ++-
> 4 files changed, 333 insertions(+), 18 deletions(-)
>
>diff --git a/docs/system/arm/imx8m=2Erst b/docs/system/arm/imx8m=2Erst
>index c482bf180f=2E=2E294c333127 100644
>--- a/docs/system/arm/imx8m=2Erst
>+++ b/docs/system/arm/imx8m=2Erst
>@@ -12,6 +12,7 @@ The ``imx8mp-evk`` and ``imx8mm-evk`` machines implemen=
t the
> following devices:
>=20
>  * Up to 4 Cortex-A53 cores
>+ * 1 Cortex-M7 core (``imx8mp-evk`` only)
>  * Generic Interrupt Controller (GICv3)
>  * 4 UARTs
>  * 3 USDHC Storage Controllers
>@@ -36,6 +37,187 @@ Boot options
> The ``imx8mp-evk`` and ``imx8mm-evk`` machines can start a Linux
> kernel directly using the standard ``-kernel`` functionality=2E
>=20
>+
>+Asymmetric Multiprocessing (AMP) Boot Recipe (``imx8mp-evk`` only)
>+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>+
>+The ``imx8mp-evk`` machine includes a Cortex-M7 core alongside the
>+Cortex-A53 cores, enabling Asymmetric Multiprocessing (AMP)=2E The M7
>+firmware can be loaded from Linux using the remoteproc framework=2E
>+
>+There are 2 control paths for Cortex-M7 on iMX8MP:-
>+1=2E Firmware-mediated (via SMC/ATF)
>+2=2E MMIO driven path (via SRC and GPR access)
>+
>+``fsl,imx8mp-cm7-mmio`` exists specifically to select the MMIO path and =
avoid dependence on firmware interfaces that aren=E2=80=99t guaranteed in q=
emu=2E
>+This mode uses the SRC syscon block and the IOMUXC GPR for start/stop co=
ntrol=2E
>+
>+Memory carveouts for resource table, vrings need to be specified in the =
``imx8mp-evk-rpmsg=2Edts``=2E
>+Follow this application note to make the necessary changes - https://www=
=2Enxp=2Ecom/docs/en/application-note/AN5317=2Epdf
>+
>+When Linux boots CM7 via remoteproc, the typical flow is:
>+
>+1=2E Linux booted with imx8mp-evk-rpmsg=2Edtb
>+2=2E Linux loads the CM7 ELF into a reserved DDR region
>+3=2E Linux toggles the CM7 start/stop control (SRC/GPR CPUWAIT, etc=2E)
>+4=2E CM7 starts executing from that DDR entry
>+
>+
>+Prerequisites
>+~~~~~~~~~~~~~
>+
>+To manually test Cortex-M7 firmware loading from Linux, the following
>+components are needed:
>+
>+1=2E Linux kernel configuration to enable i=2EMX remoteproc support=2E
>+2=2E ``imx8mp-evk-rpmsg=2Edtb`` -  device tree that enables the Cortex-M=
7 remoteproc node, reserves DDR memory regions
>+   for the Cortex-M7 firmware, resource table,vrings and buffers=2E
>+3=2E A Cortex-M7 ELF firmware image linked to execute from DDR=2E
>+
>+NXP application note AN5317 describes the required remoteproc and reserv=
ed-memory setup
>+for loading Cortex-M firmware from Linux=2E
>+
>+
>+Linux kernel configuration
>+~~~~~~~~~~~~~~~~~~~~~~~~~~
>+
>+The guest kernel needs remoteproc support=2E On official linux-imx kerne=
ls, this support is enabled by default=2E
>+When using Buildroot, verify that the kernel configuration enables the r=
emoteproc and rpmsg options needed by the
>+i=2EMX remoteproc driver, for example:
>+
>+=2E=2E code-block:: none
>+
>+  CONFIG_REMOTEPROC=3Dy
>+  CONFIG_IMX_REMOTEPROC=3Dy
>+  CONFIG_RPMSG=3Dy
>+  CONFIG_VIRTIO_RPMSG_BUS=3Dy
>+  CONFIG_RPMSG_CHAR=3Dy
>+
>+Depending on the kernel version and configuration, some options may be s=
elected
>+automatically by the i=2EMX remoteproc driver=2E
>+
>+
>+
>+Device tree preparation
>+~~~~~~~~~~~~~~~~~~~~~~~
>+
>+1=2E Refer to ``9=2E1 i=2EMX Linux rproc support`` of application note A=
N5317 to add the
>+   following nodes in ``imx8mp-evk-rpmsg=2Edts`` :-
>+
>+   m7_ddr_alias
>+   m7_itcm
>+   m7_dtcm
>+
>+2=2E Modify the compatible string of ``imx8mp-cm7`` node from ``fsl,imx8=
mn-cm7`` to ``fsl,imx8mp-cm7-mmio``
>+3=2E Add the following properties to the ``imx8mp-cm7`` node :-
>+
>+   ``syscon =3D <&src>;``
>+   ``fsl,iomuxc-gpr =3D <&gpr>;``
>+
>+   These references are needed by imx_rproc_mmio_detect_mode in i=2EMX r=
emoteproc driver
>+   for M7 boot mode detection=2E
>+
>+
>+   Build ``imx8mp-evk-rpmsg=2Edtb`` from the above dts changes=2E
>+
>+
>+
>+Building a Cortex-M7 ELF firmware
>+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>+
>+A simple manual test is the MCUXpresso SDK UART polling example for the =
i=2EMX8MP
>+EVK=2E It prints to a UART and is therefore easy to observe from QEMU=2E
>+
>+1=2E Follow this guide to set up MCUXpresso SDK for i=2EMX8MPEVK :- MCUX=
SDKIMX8MPGSUG[https://share=2Egoogle/qD4D09FCkkydTurqp]
>+2=2E Build a DDR-linked Cortex-M7 ELF using the ARM GNU toolchain from t=
he MCUXpresso SDK:-
>+
>+
>+=2E=2E code-block:: bash
>+
>+  $ cd ${MCUX_SDK}/boards/evkmimx8mp/driver_examples/uart/polling/armgcc
>+  $ =2E/build_ddr_release=2Esh
>+
>+As a result, ``iuart_polling_cm7=2Eelf`` will be generated  in ``ddr_rel=
ease`` folder=2E
>+
>+Boot qemu i=2EMX8MP EVK machine with the updated linux kernel and ``imx8=
mp-evk-rpmsg=2Edtb``
>+
>+3=2E Copy the ``iuart_polling_cm7=2Eelf`` to ``/lib/firmware/`` path ins=
ide iMX8MPEVK qemu emulation=2E
>+
>+
>+Serial ports (UARTs)
>+''''''''''''''''''''
>+
>+The i=2EMX 8M Plus EVK model provides four UARTs=2E QEMU connects each U=
ART to a
>+host character backend using the ``-serial`` option=2E This option can b=
e used
>+multiple times to create and wire multiple serial ports=2E
>+
>+The ``-serial`` options are positional:
>+
>+* the 1st ``-serial =2E=2E=2E`` maps to ``serial0`` (UART1)
>+* the 2nd ``-serial =2E=2E=2E`` maps to ``serial1`` (UART2)
>+* the 3rd ``-serial =2E=2E=2E`` maps to ``serial2`` (UART3)
>+* the 4th ``-serial =2E=2E=2E`` maps to ``serial3`` (UART4)
>+
>+Example usage:- To enable serial console for the official M7 mcuxpresso =
sdk driver example - driver_examples/uart/polling which uses UART4, use:-
>+
>+=2E=2E code-block:: bash
>+
>+  -serial null -serial stdio -serial null -serial pty:/tmp/imx8mp-uart4
>+
>+This will create a symlink /tmp/imx8mp-uart4 pointed to the allocated PT=
Y=2E On a different tab the console for UART4 can be opened using the follo=
wing:-
>+
>+=2E=2E code-block:: bash
>+
>+  $ screen /tmp/imx8mp-uart4 115200
>+
>+
>+Starting QEMU for Cortex-M7 remoteproc testing
>+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>+
>+1=2E Execute the following command to start i=2EMX8MPEVK emulation:-
>+
>+=2E=2E code-block:: bash
>+
>+  $ qemu-system-aarch64 -M imx8mp-evk \
>+      -display none -serial null -serial stdio -serial null -serial /tmp=
/imx8mp-uart4 \
>+      -kernel Image \
>+      -dtb imx8mp-evk-rpmsg=2Edtb \
>+      -append "root=3D/dev/mmcblk2p2" \
>+      -drive file=3Dsdcard=2Eimg,if=3Dsd,bus=3D2,format=3Draw,id=3Dmmcbl=
k2
>+
>+2=2E On a new tab execute the following to open a console:-
>+
>+=2E=2E code-block:: bash
>+
>+  $ screen /tmp/imx8mp-uart4 115200
>+
>+3=2E Execute the following commands inside emulation to load the firmwar=
e elf:-
>+
>+=2E=2E code-block:: bash
>+
>+   $ echo iuart_polling_cm7=2Eelf > /sys/class/remoteproc/remoteproc0/fi=
rmware
>+   $ echo start > /sys/class/remoteproc/remoteproc0/state
>+
>+
>+On the tab where the console is opened, you will observe the UART logs=
=2E The characters
>+typed from the keyboard will echo on the console=2E
>+
>+
>+Note:-
>+
>+Only DDR-linked bare-metal ELF images are currently supported by QEMU
>+emulation=2E If the firmware is linked for a vector table base address o=
ther than
>+``0x80000000``, configure the Cortex-M7 vector base using the SoC proper=
ty
>+``cm7-vector-base``:-
>+
>+=2E=2E code-block:: bash
>+
>+  -global fsl-imx8mp=2Ecm7-vector-base=3D0x80000000
>+
>+If this property is not provided, QEMU uses ``0x80000000`` by default=2E
>+
>+
>+
> Direct Linux Kernel Boot
> ''''''''''''''''''''''''
>=20
>@@ -72,7 +254,7 @@ For i=2EMX 8M Plus EVK:
> =2E=2E code-block:: bash
>=20
>   $ qemu-system-aarch64 -M imx8mp-evk \
>-      -display none -serial null -serial stdio \
>+      -display none -serial null -serial stdio -serial null -serial /tmp=
/imx8mp-uart4 \
>       -kernel Image \
>       -dtb imx8mp-evk=2Edtb \
>       -append "root=3D/dev/mmcblk2p2" \
>diff --git a/hw/arm/fsl-imx8mp=2Ec b/hw/arm/fsl-imx8mp=2Ec
>index eec83deced=2E=2E8d6a1c3f4d 100644
>--- a/hw/arm/fsl-imx8mp=2Ec
>+++ b/hw/arm/fsl-imx8mp=2Ec
>@@ -22,6 +22,8 @@
> #include "qapi/error=2Eh"
> #include "qobject/qlist=2Eh"
>=20
>+#define IMX8MP_NUM_A53 4
>+
> static const struct {
>     hwaddr addr;
>     size_t size;
>@@ -196,6 +198,10 @@ static void fsl_imx8mp_init(Object *obj)
>     FslImx8mpState *s =3D FSL_IMX8MP(obj);
>     int i;
>=20
>+    s->cm7_booted =3D false;
>+
>+    object_initialize_child(obj, "cm7", &s->cm7, TYPE_ARMV7M);
>+
>     object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
>=20
>     object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX8MP_CCM);
>@@ -269,6 +275,93 @@ static void fsl_imx8mp_init(Object *obj)
>                             TYPE_FSL_IMX8M_PCIE_PHY);
> }
>=20
>+static inline void imx8mp_cm7_halt(CPUState *m7cs)
>+{
>+    cpu_interrupt(m7cs, CPU_INTERRUPT_HALT);
>+    m7cs->halted =3D 1;
>+    qemu_cpu_kick(m7cs);
>+}
>+
>+static inline void imx8mp_cm7_resume(CPUState *m7cs)
>+{
>+    /* Clear HALT interrupt (from STOP) and resume */
>+    cpu_reset_interrupt(m7cs, CPU_INTERRUPT_HALT);
>+    m7cs->halted =3D 0;
>+    m7cs->stopped =3D 0;
>+    cpu_resume(m7cs);
>+    cpu_interrupt(m7cs, CPU_INTERRUPT_EXITTB);
>+    qemu_cpu_kick(m7cs);
>+}

Can the above two functions be replaced by those in target/arm/arm-powerct=
l=2Eh?

>+
>+static void imx8mp_cm7_ctrl_apply(CPUState *cpu, run_on_cpu_data data)
>+{
>+    struct CM7CtlReq *r =3D data=2Ehost_ptr;
>+    FslImx8mpState *s =3D r->s;
>+    ARMCPU *m7 =3D s->cm7=2Ecpu;
>+    CPUState *m7cs =3D CPU(m7);
>+
>+    if (!r->run) {
>+        /* STOP: halt the M7 */
>+    imx8mp_cm7_halt(m7cs);

Wrong indentation=2E

>+        goto out;

Let's avoid goto=2E The reset case can be folded into the run branch, espe=
cially with the simplification (see below)=2E

>+    }
>+
>+    /*
>+     * RUN:
>+     * CPUWAIT is modeled as a run/stop gate=2E On first RUN, boot from =
vector
>+     * table=2E Subsequent RUN resumes execution without resetting CM7 s=
tate=2E
>+     */

Really? This seems to work only on first boot and not after further machin=
e resets=2E Isn't the CPU reset requested by the guest anyway by means of S=
RC_M7RCR bits in the SRC?

>+    if (s->cm7_booted) {
>+        imx8mp_cm7_resume(m7cs);
>+        goto out;
>+    }
>+
>+    uint32_t msp_le =3D 0, pc_le =3D 0;
>+    uint32_t msp, pc;
>+    hwaddr vbase =3D s->cm7_vector_base;
>+
>+    address_space_read(&address_space_memory, vbase,
>+                       MEMTXATTRS_UNSPECIFIED, &msp_le, sizeof(msp_le));
>+    address_space_read(&address_space_memory, vbase + 4,
>+                       MEMTXATTRS_UNSPECIFIED, &pc_le, sizeof(pc_le));
>+    msp =3D le32_to_cpu(msp_le);
>+    pc  =3D le32_to_cpu(pc_le);
>+
>+
>+    /* Clear Thumb indicator bit (bit0) */
>+    pc &=3D ~1u;
>+
>+    cpu_reset(m7cs);
>+
>+    /* Set SP (R13) and PC (R15)=2E Cortex-M uses Thumb */
>+    m7->env=2Eregs[13] =3D msp;
>+    m7->env=2Eregs[15] =3D pc;
>+    m7->env=2Ethumb =3D 1;

These three lines and the code for them are redundant to cpu_reset()=2E

>+
>+    imx8mp_cm7_resume(m7cs);
>+
>+    s->cm7_booted =3D true;
>+out:
>+    g_free(r);
>+};
>+
>+static void imx8mp_cm7_cpuwait_handler(void *opaque, int n, int level)
>+{
>+    FslImx8mpState *s =3D opaque;
>+    (void)n;
>+
>+    if (!s->cm7=2Ecpu) {
>+        return;
>+    }
>+
>+    struct CM7CtlReq *r =3D g_new0(struct CM7CtlReq, 1);
>+    r->s =3D s;
>+    r->run =3D !!level;
>+
>+    async_run_on_cpu(CPU(s->cm7=2Ecpu), imx8mp_cm7_ctrl_apply,
>+                     RUN_ON_CPU_HOST_PTR(r));
>+}

Can we move starting and stopping of the M7 core into the SRC? This way, i=
t might be possible to share the implementation with imx8mm (if the registe=
rs line up appropriately)=2E Also, the main CPUs would be started there as =
well, see e=2Eg=2E imx6_src=2E

>+
> static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
> {
>     MachineState *ms =3D MACHINE(qdev_get_machine());
>@@ -277,21 +370,15 @@ static void fsl_imx8mp_realize(DeviceState *dev, Er=
ror **errp)
>     const char *cpu_type =3D ms->cpu_type ?: ARM_CPU_TYPE_NAME("cortex-a=
53");
>     int i;
>=20
>-    if (ms->smp=2Ecpus > FSL_IMX8MP_NUM_CPUS) {
>-        error_setg(errp, "%s: Only %d CPUs are supported (%d requested)"=
,
>-                   TYPE_FSL_IMX8MP, FSL_IMX8MP_NUM_CPUS, ms->smp=2Ecpus)=
;
>-        return;
>-    }
>-
>-    for (i =3D 0; i < ms->smp=2Ecpus; i++) {
>+    for (i =3D 0; i < IMX8MP_NUM_A53; i++) {
>         g_autofree char *name =3D g_strdup_printf("cpu%d", i);
>         object_initialize_child(OBJECT(dev), name, &s->cpu[i], cpu_type)=
;
>     }
>=20
>     /* CPUs */
>-    for (i =3D 0; i < ms->smp=2Ecpus; i++) {
>+    for (i =3D 0; i < IMX8MP_NUM_A53; i++) {
>         /* On uniprocessor, the CBAR is set to 0 */
>-        if (ms->smp=2Ecpus > 1 &&
>+        if (IMX8MP_NUM_A53 > 1 &&
>                 object_property_find(OBJECT(&s->cpu[i]), "reset-cbar")) =
{
>             object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
>                                     fsl_imx8mp_memmap[FSL_IMX8MP_GIC_DIS=
T]=2Eaddr,
>@@ -334,11 +421,11 @@ static void fsl_imx8mp_realize(DeviceState *dev, Er=
ror **errp)
>         QList *redist_region_count;
>         bool pmu =3D object_property_get_bool(OBJECT(first_cpu), "pmu", =
NULL);
>=20
>-        qdev_prop_set_uint32(gicdev, "num-cpu", ms->smp=2Ecpus);
>+        qdev_prop_set_uint32(gicdev, "num-cpu", IMX8MP_NUM_A53);
>         qdev_prop_set_uint32(gicdev, "num-irq",
>                              FSL_IMX8MP_NUM_IRQS + GIC_INTERNAL);
>         redist_region_count =3D qlist_new();
>-        qlist_append_int(redist_region_count, ms->smp=2Ecpus);
>+        qlist_append_int(redist_region_count, IMX8MP_NUM_A53);
>         qdev_prop_set_array(gicdev, "redist-region-count", redist_region=
_count);
>         object_property_set_link(OBJECT(&s->gic), "sysmem",
>                                  OBJECT(get_system_memory()), &error_fat=
al);
>@@ -353,7 +440,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Erro=
r **errp)
>          * maintenance interrupt signal to the appropriate GIC PPI input=
s, and
>          * the GIC's IRQ/FIQ interrupt outputs to the CPU's inputs=2E
>          */
>-        for (i =3D 0; i < ms->smp=2Ecpus; i++) {
>+        for (i =3D 0; i < IMX8MP_NUM_A53; i++) {
>             DeviceState *cpudev =3D DEVICE(&s->cpu[i]);
>             int intidbase =3D FSL_IMX8MP_NUM_IRQS + i * GIC_INTERNAL;
>             qemu_irq irq;
>@@ -383,11 +470,11 @@ static void fsl_imx8mp_realize(DeviceState *dev, Er=
ror **errp)
>=20
>             sysbus_connect_irq(gicsbd, i,
>                                qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
>-            sysbus_connect_irq(gicsbd, i + ms->smp=2Ecpus,
>+            sysbus_connect_irq(gicsbd, i + IMX8MP_NUM_A53,
>                                qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
>-            sysbus_connect_irq(gicsbd, i + 2 * ms->smp=2Ecpus,
>+            sysbus_connect_irq(gicsbd, i + 2 * IMX8MP_NUM_A53,
>                                qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
>-            sysbus_connect_irq(gicsbd, i + 3 * ms->smp=2Ecpus,
>+            sysbus_connect_irq(gicsbd, i + 3 * IMX8MP_NUM_A53,
>                                qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
>=20
>             if (kvm_enabled()) {
>@@ -459,6 +546,38 @@ static void fsl_imx8mp_realize(DeviceState *dev, Err=
or **errp)
>     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpr), 0,
>                     fsl_imx8mp_memmap[FSL_IMX8MP_IOMUXC_GPR]=2Eaddr);
>=20
>+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpr), 0,
>+                   qemu_allocate_irq(imx8mp_cm7_cpuwait_handler, s, 0));
>+
>+    /* Realize Cortex-M7 subsystem */
>+    {
>+        DeviceState *cm7dev =3D DEVICE(&s->cm7);
>+        DeviceState *ccmdev =3D DEVICE(&s->ccm);
>+        qdev_prop_set_string(cm7dev, "cpu-type",
>+                             ARM_CPU_TYPE_NAME("cortex-m7"));
>+        qdev_prop_set_uint32(cm7dev, "num-irq", 64);
>+        qdev_prop_set_bit(cm7dev, "enable-bitband", true);
>+
>+        /* CM7 vector table base (configurable) */
>+        qdev_prop_set_uint32(cm7dev, "init-nsvtor", s->cm7_vector_base);
>+
>+        /* Connect CM7 clocks from CCM exported outputs */
>+        qdev_connect_clock_in(cm7dev, "cpuclk",
>+                              qdev_get_clock_out(ccmdev, "cm7_cpuclk"));
>+        qdev_connect_clock_in(cm7dev, "refclk",
>+                              qdev_get_clock_out(ccmdev, "cm7_refclk"));
>+        object_property_set_link(OBJECT(&s->cm7), "memory",
>+                                 OBJECT(get_system_memory()), &error_abo=
rt);
>+
>+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->cm7), errp)) {
>+            return;
>+        }
>+
>+        CPUState *m7cs =3D CPU(s->cm7=2Ecpu);
>+        cpu_interrupt(m7cs, CPU_INTERRUPT_HALT);
>+        m7cs->halted =3D 1;
>+    }
>+
>     /* GPTs */
>     object_property_set_int(OBJECT(&s->gpt5_gpt6_irq), "num-lines", 2,
>                             &error_abort);
>@@ -784,6 +903,8 @@ static void fsl_imx8mp_realize(DeviceState *dev, Erro=
r **errp)
> static const Property fsl_imx8mp_properties[] =3D {
>     DEFINE_PROP_UINT32("fec1-phy-num", FslImx8mpState, phy_num, 0),
>     DEFINE_PROP_BOOL("fec1-phy-connected", FslImx8mpState, phy_connected=
, true),
>+    DEFINE_PROP_UINT32("cm7-vector-base", FslImx8mpState,
>+                       cm7_vector_base, 0x80000000),
> };
>=20
> static void fsl_imx8mp_class_init(ObjectClass *oc, const void *data)
>diff --git a/hw/arm/imx8mp-evk=2Ec b/hw/arm/imx8mp-evk=2Ec
>index b84ac91a17=2E=2E0f92bf5dc8 100644
>--- a/hw/arm/imx8mp-evk=2Ec
>+++ b/hw/arm/imx8mp-evk=2Ec
>@@ -117,7 +117,8 @@ static void imx8mp_evk_machine_init(MachineClass *mc)
> {
>     mc->desc =3D "NXP i=2EMX 8M Plus EVK Board";
>     mc->init =3D imx8mp_evk_init;
>-    mc->default_cpus =3D 4;
>+    mc->default_cpus =3D 5;
>+    mc->min_cpus =3D 5;
>     mc->max_cpus =3D FSL_IMX8MP_NUM_CPUS;
>     mc->default_ram_id =3D "imx8mp-evk=2Eram";
>     mc->default_ram_size =3D 6 * GiB;
>diff --git a/include/hw/arm/fsl-imx8mp=2Eh b/include/hw/arm/fsl-imx8mp=2E=
h
>index 94d198b932=2E=2E335e4beb6c 100644
>--- a/include/hw/arm/fsl-imx8mp=2Eh
>+++ b/include/hw/arm/fsl-imx8mp=2Eh
>@@ -10,6 +10,7 @@
> #define FSL_IMX8MP_H
>=20
> #include "target/arm/cpu=2Eh"
>+#include "hw/arm/armv7m=2Eh"
> #include "hw/char/imx_serial=2Eh"
> #include "hw/gpio/imx_gpio=2Eh"
> #include "hw/i2c/imx_i2c=2Eh"
>@@ -30,6 +31,7 @@
> #include "hw/timer/imx_gpt=2Eh"
> #include "hw/usb/hcd-dwc3=2Eh"
> #include "hw/watchdog/wdt_imx2=2Eh"
>+#include "hw/core/qdev-clock=2Eh"
> #include "hw/core/sysbus=2Eh"
> #include "qom/object=2Eh"
> #include "qemu/units=2Eh"
>@@ -43,7 +45,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mpState, FSL_IMX8MP)
> #define FSL_IMX8MP_MU1_A_IRQ  88
>=20
> enum FslImx8mpConfiguration {
>-    FSL_IMX8MP_NUM_CPUS         =3D 4,
>+    FSL_IMX8MP_NUM_CPUS         =3D 5,

Separate patch please=2E Also let's keep this constant as is (or rename to=
 e=2Eg=2E FSL_IMX8MP_NUM_A53_CPUS) to avoid having five ARM64 CPUs (in the =
array below)=2E

Best regards,
Bernhard

>     FSL_IMX8MP_NUM_ECSPIS       =3D 3,
>     FSL_IMX8MP_NUM_GPIOS        =3D 5,
>     FSL_IMX8MP_NUM_GPTS         =3D 6,
>@@ -65,6 +67,10 @@ struct FslImx8mpState {
>     SysBusDevice   parent_obj;
>=20
>     ARMCPU             cpu[FSL_IMX8MP_NUM_CPUS];
>+    ARMv7MState        cm7;
>+    bool               enable_cm7;
>+    bool               cm7_booted;
>+    uint32_t           cm7_vector_base;
>     GICv3State         gic;
>     IMX8MPGPCState     gpc;
>     IMX8MPGPRState     gpr;
>@@ -91,6 +97,11 @@ struct FslImx8mpState {
>     bool               phy_connected;
> };
>=20
>+struct CM7CtlReq {
>+    FslImx8mpState *s;
>+    bool run;
>+};
>+
> enum FslImx8mpMemoryRegions {
>     FSL_IMX8MP_A53_DAP,
>     FSL_IMX8MP_AIPS1_CONFIGURATION,

