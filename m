Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511C3C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 17:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8hlp-0007XT-9b; Mon, 21 Sep 2026 13:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8hlj-0007QW-Li
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 13:25:31 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8hlg-0003Eb-Mf
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 13:25:31 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b965f447cso27834905e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 10:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790011527; x=1790616327; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BtNiTsJvgNm2kuS1K4yCUWJj5u44C2x5MLAhn1KOmbE=;
 b=SwCEaxLUm0F3As04nUw8AY0W0+X4nNSB0bzb3j7oY2rGKDpN1cuQm3inivurPRubNs
 fBL6lD0dvvOXrz0xrt/flyGKAU851/72ecODkHyrcAdk1Rl1Gs1fL3/Oz/ZG3ITdZvSL
 ZrC421l2urwNzNEf29sAzGK4MX9AGlibu1FjdQaHQCFnUPYpdw+ZsH4vF6d8Tvr1qWta
 PD8d/OxWZwHixS6IajQ1wVf1YhZtIMRgmh+bMYS6Brfu5YKSbV4jK+qh/vBK2aoFpJma
 s/NWjKV1ok2hyo0LdCEWGDjd0bI/zm47caVtc46kkSSppEamaL3Y071tv22sZWLCAs48
 JYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790011527; x=1790616327;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BtNiTsJvgNm2kuS1K4yCUWJj5u44C2x5MLAhn1KOmbE=;
 b=FscP4A0EfI6mXRgP+etoqteuhjoi1EvlPVCdpyWgH1O/mW4Fd8GA5fzB5D9r6jN9Ey
 us+vleDbj2V39ZDfYM6DEDe0Vo/CvqMT+OVppEp0SrbGaKQa6j28peUG6I5K+YQP835I
 eEXLaL3craR83CDAspTnjoE68GFUIJqK8cOGqtTTL25jHlL2+Ri0ZHqdPyfFfKmvSQCj
 FAEPiDGvziC6GrRwRBOxmF5PuCjlZLZzOJF49n0DUWPnP5iC35nxRnTLGci8DqFx/+a3
 yTuL9XB0ZDnH+aLicXPOvQqufmJMEjhsrNjh/MrDRq7BhkNAk84Q7HXJfyeSeqscea8h
 fmew==
X-Forwarded-Encrypted: i=1;
 AKwUvByoEiab18JvFy+0jnSuYl9pWhnd8Md9PkfVyhMKE6SQOGL+04xn2EUkBtTpIZreC6ZqL8stwwGI6MN6@nongnu.org
X-Gm-Message-State: AFuF++nQN10DUfk0bjZE17ofPOqcw8qDqK8k8F9HKyJL0q99zxAjt/uE
 ufg7Lyu7IHoTlOFUHYD24hBmBwlyTo5D0SH6jJO0noZkMfRm3+2Bd23y
X-Gm-Gg: AYBFou1Z2iZtIf3pixwKktMRT0fJj6LCHRN7UzG3GOdc8NMjfeC54FUjqy4CFY6MhES
 5r9Izk88gfzNfZwCUa2Q5SBua41Ytz+1l+OHVIHC6hPtaPadgUc7xx5LIUbYqzmt3FWO0kV6smt
 2CPJz5021jIKYc2q2C0NHoowg8abCJc1dqvbY6YiNbjGaFTh5XzMoPa3iUdMENUV7CF1nO5OIXJ
 voiwZZWPg6w0NTfp85LvrBKUE1Pvv9upROHFaD9Q6xcAwO/Vk/FHtB4XjwjPut6KpnsTcD/UQq+
 GcFRPXY9/kHmLLF4GaL12VfdPFpwPyK5lCgxWojYUycD60WPKts0TOaab56hjip+SwKJ++GVSNL
 anX1GTp2kOy7E6wd0LM6e15pFbhRokYdbGGhGu609V7kkH68hsZR/vk3hes6DJgXpwFwpKiW7jd
 irQybgBO2K8tkcSKw8yGbbredr2UUar117Ei3vto/HoSUrdYLwqpZlJ9IOcsJ8qNjuhVu5KXSdd
 cRa4TQj76FBVg==
X-Received: by 2002:a05:600c:3b05:b0:49e:6249:268b with SMTP id
 5b1f17b1804b1-49fc574194amr149078125e9.32.1790011526302; 
 Mon, 21 Sep 2026 10:25:26 -0700 (PDT)
Received: from ehlo.thunderbird.net ([62.214.191.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd8cc05f9sm5486335e9.3.2026.09.21.10.25.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 10:25:25 -0700 (PDT)
Date: Mon, 21 Sep 2026 17:25:05 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-devel@nongnu.org
CC: qemu-arm@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCHv3 06/10] hw/arm: Enable Cortex-M7 AMP boot on i.MX8MP
In-Reply-To: <20260920115458.481605-7-gaurav.sharma_7@nxp.com>
References: <20260920115458.481605-1-gaurav.sharma_7@nxp.com>
 <20260920115458.481605-7-gaurav.sharma_7@nxp.com>
Message-ID: <9C3C7F60-7ABD-4575-B649-5BEEF624B980@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



Am 20=2E September 2026 11:54:54 UTC schrieb Gaurav Sharma <gaurav=2Esharm=
a_7@nxp=2Ecom>:
>Configure the i=2EMX8MP to boot the Cortex-M7 core alongside
>the Cortex-A53 cores in an Asymmetric Multiprocessing (AMP)
>configuration=2E The M7 firmware can be loaded and started from Linux
>running on the A53 cores via the remoteproc framework=2E
>
>CM7 boot is made optional=2E A GPR IRQ is connected to a cpuwait handler=
=2E
>The handler translates the CPUWAIT into STOP and RUN=2E
>
>Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>---
> docs/system/arm/imx8m=2Erst   | 184 +++++++++++++++++++++++++++++++++++-
> hw/arm/fsl-imx8mp=2Ec         | 116 ++++++++++++++++++-----
> include/hw/arm/fsl-imx8mp=2Eh |  10 +-
> 3 files changed, 286 insertions(+), 24 deletions(-)
>
>diff --git a/docs/system/arm/imx8m=2Erst b/docs/system/arm/imx8m=2Erst
>index cdf862a456=2E=2E95fd27ec5c 100644
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
>@@ -37,6 +38,187 @@ Boot options
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
>@@ -73,7 +255,7 @@ For i=2EMX 8M Plus EVK:
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
>index 2d5b5f3870=2E=2Ecea8be7b71 100644
>--- a/hw/arm/fsl-imx8mp=2Ec
>+++ b/hw/arm/fsl-imx8mp=2Ec
>@@ -12,6 +12,8 @@
> #include "system/address-spaces=2Eh"
> #include "hw/arm/bsa=2Eh"
> #include "hw/arm/fsl-imx8mp=2Eh"
>+#include "hw/core/qdev-properties=2Eh"
>+#include "hw/core/qdev-clock=2Eh"
> #include "hw/misc/unimp=2Eh"
> #include "hw/core/boards=2Eh"
> #include "system/kvm=2Eh"
>@@ -21,6 +23,9 @@
> #include "target/arm/kvm_arm=2Eh"
> #include "qapi/error=2Eh"
> #include "qobject/qlist=2Eh"
>+#include "target/arm/arm-powerctl=2Eh"
>+
>+#define IMX8MP_NUM_A53 4
>=20
> static const struct {
>     hwaddr addr;
>@@ -196,6 +201,8 @@ static void fsl_imx8mp_init(Object *obj)
>     FslImx8mpState *s =3D FSL_IMX8MP(obj);
>     int i;
>=20
>+    object_initialize_child(obj, "cm7", &s->cm7, TYPE_ARMV7M);
>+
>     object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
>=20
>     object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX8MP_CCM);
>@@ -282,21 +289,15 @@ static void fsl_imx8mp_realize(DeviceState *dev, Er=
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
>@@ -339,11 +340,11 @@ static void fsl_imx8mp_realize(DeviceState *dev, Er=
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
>@@ -358,7 +359,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Erro=
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
>@@ -388,11 +389,11 @@ static void fsl_imx8mp_realize(DeviceState *dev, Er=
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
>@@ -443,13 +444,6 @@ static void fsl_imx8mp_realize(DeviceState *dev, Err=
or **errp)
>                            qdev_get_gpio_in(gicdev, serial_table[i]=2Eir=
q));
>     }
>=20
>-    /* SRC */
>-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->src), errp)) {
>-        return;
>-    }
>-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->src), 0,
>-                    fsl_imx8mp_memmap[FSL_IMX8MP_SRC]=2Eaddr);
>-
>     /* GPC */
>     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpc), errp)) {
>         return;
>@@ -464,6 +458,49 @@ static void fsl_imx8mp_realize(DeviceState *dev, Err=
or **errp)
>     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpr), 0,
>                     fsl_imx8mp_memmap[FSL_IMX8MP_IOMUXC_GPR]=2Eaddr);
>=20
>+    /* Realize Cortex-M7 subsystem */
>+    {
>+        DeviceState *cm7dev =3D DEVICE(&s->cm7);
>+        DeviceState *ccmdev =3D DEVICE(&s->ccm);
>+        qdev_prop_set_string(cm7dev, "cpu-type",
>+                             ARM_CPU_TYPE_NAME("cortex-m7"));
>+        qdev_prop_set_uint32(cm7dev, "num-irq", 160);
>+        qdev_prop_set_bit(cm7dev, "enable-bitband", false);
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
>+        arm_set_cpu_off(arm_cpu_mp_affinity(s->cm7=2Ecpu));
>+    }
>+
>+    qdev_prop_set_uint32(DEVICE(&s->src), "cm7-vector-base",
>+                         s->cm7_vector_base);
>+    object_property_set_link(OBJECT(&s->src), "cm7-cpu",
>+                             OBJECT(s->cm7=2Ecpu), &error_abort);
>+    object_property_set_link(OBJECT(&s->src), "gpr",
>+                             OBJECT(&s->gpr), &error_abort);
>+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->src), errp)) {
>+        return;
>+    }
>+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->src), 0,
>+                    fsl_imx8mp_memmap[FSL_IMX8MP_SRC]=2Eaddr);
>+
>+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpr), 0,
>+                       qdev_get_gpio_in_named(DEVICE(&s->src),
>+                                              "cm7-cpuwait", 0));
>+
>     /* GPTs */
>     object_property_set_int(OBJECT(&s->gpt5_gpt6_irq), "num-lines", 2,
>                             &error_abort);
>@@ -777,6 +814,37 @@ static void fsl_imx8mp_realize(DeviceState *dev, Err=
or **errp)
>                                 fsl_imx8mp_memmap[FSL_IMX8MP_OCRAM]=2Ead=
dr,
>                                 &s->ocram);
>=20
>+    if (!memory_region_init_ram(&s->itcm, OBJECT(dev), "imx8mp=2Eitcm",
>+                                fsl_imx8mp_memmap[FSL_IMX8MP_TCM_ITCM]=
=2Esize,
>+                                errp)) {
>+        return;
>+    }
>+    memory_region_add_subregion(get_system_memory(),
>+                                fsl_imx8mp_memmap[FSL_IMX8MP_TCM_ITCM]=
=2Eaddr,
>+                                &s->itcm);
>+
>+    if (!memory_region_init_ram(&s->dtcm, OBJECT(dev), "imx8mp=2Edtcm",
>+                                fsl_imx8mp_memmap[FSL_IMX8MP_TCM_DTCM]=
=2Esize,
>+                                errp)) {
>+        return;
>+    }
>+    memory_region_add_subregion(get_system_memory(),
>+                                fsl_imx8mp_memmap[FSL_IMX8MP_TCM_DTCM]=
=2Eaddr,
>+                                &s->dtcm);
>+
>+    /* M7-view aliases: ITCM@0x0, DTCM@0x20000000 */
>+    memory_region_init_alias(&s->itcm_alias, OBJECT(dev), "imx8mp=2Eitcm=
-alias",
>+                             &s->itcm, 0,
>+                             fsl_imx8mp_memmap[FSL_IMX8MP_TCM_ITCM]=2Esi=
ze);
>+    memory_region_add_subregion_overlap(get_system_memory(),
>+                                        0x00000000, &s->itcm_alias, 1);
>+
>+    memory_region_init_alias(&s->dtcm_alias, OBJECT(dev), "imx8mp=2Edtcm=
-alias",
>+                             &s->dtcm, 0,
>+                             fsl_imx8mp_memmap[FSL_IMX8MP_TCM_DTCM]=2Esi=
ze);
>+    memory_region_add_subregion_overlap(get_system_memory(),
>+                                        0x20000000, &s->dtcm_alias, 1);
>+
>     /* Unimplemented devices */
>     for (i =3D 0; i < ARRAY_SIZE(fsl_imx8mp_memmap); i++) {
>         switch (i) {
>@@ -794,6 +862,8 @@ static void fsl_imx8mp_realize(DeviceState *dev, Erro=
r **errp)
>         case FSL_IMX8MP_IOMUXC_GPR:
>         case FSL_IMX8MP_MU_1_A =2E=2E=2E FSL_IMX8MP_MU_3_B:
>         case FSL_IMX8MP_OCRAM:
>+        case FSL_IMX8MP_TCM_ITCM:
>+        case FSL_IMX8MP_TCM_DTCM:
>         case FSL_IMX8MP_PCIE1:
>         case FSL_IMX8MP_PCIE_PHY1:
>         case FSL_IMX8MP_RAM:
>@@ -822,6 +892,8 @@ static const Property fsl_imx8mp_properties[] =3D {
>                      CanBusState *),
>     DEFINE_PROP_LINK("canbus1", FslImx8mpState, canbus[1], TYPE_CAN_BUS,
>                      CanBusState *),
>+    DEFINE_PROP_UINT32("cm7-vector-base", FslImx8mpState,
>+                       cm7_vector_base, 0x80000000),
> };
>=20
> static void fsl_imx8mp_class_init(ObjectClass *oc, const void *data)
>diff --git a/include/hw/arm/fsl-imx8mp=2Eh b/include/hw/arm/fsl-imx8mp=2E=
h
>index f9fb703816=2E=2E317e6a4576 100644
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
>@@ -67,6 +68,9 @@ struct FslImx8mpState {
>     SysBusDevice   parent_obj;
>=20
>     ARMCPU             cpu[FSL_IMX8MP_NUM_CPUS];
>+    ARMv7MState        cm7;
>+    bool               enable_cm7;
>+    uint32_t           cm7_vector_base;
>     GICv3State         gic;
>     IMX8MPGPCState     gpc;
>     IMX8MPGPRState     gpr;
>@@ -89,13 +93,17 @@ struct FslImx8mpState {
>     FlexcanState       flexcan[FSL_IMX8MP_NUM_CANS];
>     OrIRQState         gpt5_gpt6_irq;
>     MemoryRegion       ocram;
>-
>+    MemoryRegion       itcm;
>+    MemoryRegion       dtcm;
>+    MemoryRegion       itcm_alias;
>+    MemoryRegion       dtcm_alias;

Separate commit for the TCMs please, like for any other devices that get a=
dded to the SoC=2E Also, the new commit should appear before the CM7 core i=
s added=2E That way, not only does the review becomes easier but the region=
s could be merged already while the rest of the series is still under revie=
w=2E IMO it is okay to add the TCMs in a single commit=2E

Best regards,
Bernhard


>     uint32_t           phy_num;
>     bool               phy_connected;
>=20
>     CanBusState       *canbus[FSL_IMX8MP_NUM_CANS];
> };
>=20
>+
> enum FslImx8mpMemoryRegions {
>     FSL_IMX8MP_A53_DAP,
>     FSL_IMX8MP_AIPS1_CONFIGURATION,

