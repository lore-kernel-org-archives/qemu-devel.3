Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B073C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24lc-0001k6-1s; Thu, 03 Sep 2026 06:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x24lZ-0001jw-VK
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:33:57 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x24lU-0004zS-Th
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:33:57 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c25b661d37dso340119166b.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788431631; cv=none;
 d=google.com; s=arc-20260327;
 b=s2KXtnn+mUikgz7XPztP9kWizfW+aS9MbaJawY32NTGQe7z5ychJbZDz2ih+uo4m/t
 G+LqrWF6dVLBQi4mcc/8LBR4KTRe+tUZAVqcBlYU2gVnZw2sCXiK1cst+1UbOKwcicQ+
 MX9AyBJRDXW4p1YV3Qh3MuQTUssgymQ+y0fYzicAFwCoT6QrDpx3UBCLCYJNEFd8mi5J
 R9CqP/LD3bWeszm86gqn2o4AgrCQoNZZwrWVZ5T9DK/wWXgNcdGBUU8tzWURQgFuroGu
 9a0hx9HyUC8T5rZ8IKgBm6T2Rq+3jY+w9qjfQtFMEeA4naoxFHXJmIc6GAI9/XUGoQfe
 X7xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=62nnckoREV5HuEKodvrv/30bNiy9dStnTBWa9sJRVLE=;
 fh=6UkxoP8KCmVMBDyOS1hn57znOaE9M4/rLh+Ztpe1tr8=;
 b=Cl6HGI7JBVaw3m8wvcOZmO8kMi7XDymZXAw5PFmSBYoaY+niJC8tlmULwJKO+PSfyG
 4OQGs3IvQ4CrW5gKETyf1bfY5vt0/HelAVNcPlrP+qUEeuW6/d/885Kz3tBl5JPsXwHA
 CfiAXEIceDkwempZSlkm+wtND5S8oF04geJ0qYjbiUMbTD0Relj5K8yLmZAQNQVidqMZ
 fbin4aprjtEbihYjoKi/f50HK3sEDNy9eufIGxJZISLjDqnvwvFnF26cK/4iPTwyiV+m
 phn2mH2OQTwjifMw7GXfhOEKijj/SVrQZqEgKxWMI2zgbIbA7/M3O5YqS2KXljuggAfM
 ukIg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788431631; x=1789036431; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=62nnckoREV5HuEKodvrv/30bNiy9dStnTBWa9sJRVLE=;
 b=hAYGb+LyIHkp7qgo6yKmDpUqy4El0grPbs30Cu4PjyDqy6j21YJzjF0VUBDb+a+0uN
 7OTyFakcp3EhRqXxLFV6lB7q+Hum1Yf+OzTKN/EixCBDWtIS099ejJUPE9CnA8/MyHkn
 BqYOl/9YvObtDlMoYF1g5RcpnUytN5uzrQCOEe7xQrI8tWts0sCHwEhw1cKZrA/KVKWA
 S8N0lUBjE0H6jQImNKpa71PSP7KJbbVqLHuMvUykJ3U0cW1y2GMiBfrgNkmS/CPKb5S2
 2cG+oiMYzfgVAoaQcZbMQjVi2939/DWez/6CjdbdgVbaVSmqa+MCnXSCbFjwxbcmEbf6
 HjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788431631; x=1789036431;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=62nnckoREV5HuEKodvrv/30bNiy9dStnTBWa9sJRVLE=;
 b=re2NUabQ3oRz69ExrpkUvFG4vguDpu5XT5e07Q/IguZaTWBCBDA3MO/JNTWdwty99o
 BWjkKinOXCrrS3vAlEhrAN1MatkPDyEuza8nOehth1usPvtkj12juIPxW0tNQZwAn8Fo
 c3jGGA4N0KsH+N8T8FUFFwBTVyMomKuBmFC3s2wO6GjeJEF+N/d9fpUBXFTKbvlyWG1P
 +YD90FBoZv9l4roRwgbk1U2YV6rWAxOcB9Ik0uVOrAuBs4YBk986oNsKLMyzKl+imynh
 j3FX62bRwBejw0pHMHcOixmHa87pGgzWJzzY6EdTyUU6i6Hzu/VEIar8D8mX2sSH2NDM
 tHOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBymYvZfOyD385rODdmc3K36vH13cmGwIReg1otM95M8CrWiQrTFQwG3zYSIFE8UsdwrJYo125p4faix@nongnu.org
X-Gm-Message-State: AFuF++kagR1mxdJJwbMrWJpww0JABSCXvHCI/TewlruLbqqfl5xoIvpi
 fpnZcpNS/VJoYTU1yMkirpcoVVqjgv+lQtjQvGQTugMvBiOr0nd4Ed9hwWY0m7QI6wdHA9/fYSj
 8dM9quYyDWbXZnJPZzaoMHy5//1gcKmw=
X-Gm-Gg: AYBFou1aKwjL7GT26qIY7fJ9jrfsgpSid9nO2czEpsqncdtsaxnX9j4nSPUMRWVWxg2
 Vj0+DMcCjFSuF7AJE+8pPrNPu9OKbR0IUwIOEogqK1MGnMRH4KcrRKnRU5oLeB1ZyyPcIIhN1Pz
 UQd73uT4yC27joEscNULZL7rk8CYH+oOgjADCm4cluPHmfkhQPrenVlqLR+/FpSQGJAl+M41Oaf
 NtXLZDS1uXHOhymRv53a4tVxxpBoRemBbrRz0NV8//6PAJ7F4W8SqBFMvtjaptduevwy1N/LbYO
 RjEy13qYzWZ8Q1FneYaI7lPq1RDWtjnh+uUz43Ugo+HB
X-Received: by 2002:a17:906:c150:b0:c25:afb6:2d91 with SMTP id
 a640c23a62f3a-c25d527a4a2mr714071266b.2.1788431631006; Thu, 03 Sep 2026
 03:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
 <8a68284e-7947-4766-a42a-6dca3e1a4e01@oss.qualcomm.com>
In-Reply-To: <8a68284e-7947-4766-a42a-6dca3e1a4e01@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 3 Sep 2026 18:33:37 +0800
X-Gm-Features: AcwNN1UL2aBdkj-Xx0Lz_aU7OfmLLo_CVvdCGYvPPSdrmuWLWXVaB2GiqyuMm3Q
Message-ID: <CAE2XoE_zkdFEFLp_eaKbX0ftROPJXxGQvv81z6CQrdjx2k5Y8g@mail.gmail.com>
Subject: Re: [PATCH 00/14] target-info: remove machine_typename
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 Anton Johansson <anjo@rev.ng>, Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/mixed; boundary="000000000000128c22065a91b0eb"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000128c22065a91b0eb
Content-Type: multipart/alternative; boundary="000000000000128c21065a91b0e9"

--000000000000128c21065a91b0e9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> > Pierrick Bouvier (14):
> >    qom/object: add is_available callback to TypeInfo
>

Patches for is_available callback to TypeInfo, it's can be merged latter

The reason is for the following command to execute:

we need add target_info_select and pass TargetInfo to is_available

- Move target_info() into qom/object.c. Default to SYS_EMU_TARGET_NONE
  until a real target is selected.
- Add target_info_select(); it may be called only once with a non-NULL
  TargetInfo that is not SYS_EMU_TARGET_NONE.
- Invoke TypeInfo.is_available after select, passing target_info().
- Change target_* helpers to take const TargetInfo *.
- Select the sole TargetInfo in user-mode MODULE_INIT_TARGET_INFO.

With these changes, when `qemu-system` does not select TargetInfo, we can
still list all machines and devices for each target properly.
```
$ ./qemu-system.exe -machine ?
Supported machines are:
none:
amd-microblaze-v-generic AMD Microblaze-V generic platform
xlnx-versal-virt     AMD Versal Virtual development board (alias of
amd-versal-virt)
amd-versal-virt      AMD Versal Virtual development board
amd-versal2-virt     AMD Versal Gen 2 Virtual development board
anacapa-bmc          Facebook Anacapa BMC (Cortex-A7)
ast1030-evb          Aspeed AST1030 MiniBMC (Cortex-M4)
ast1040-evb          Aspeed AST1040 BIC EVB (Cortex-M4F)
ast1060-evb          Aspeed AST1060 Platform Root of Trust (Cortex-M4)
ast2500-evb          Aspeed AST2500 EVB (ARM1176)
ast2600-evb          Aspeed AST2600 EVB (Cortex-A7)
axiado-scm3003       Axiado SCM3003 EVK Board
b-l475e-iot01a       B-L475E-IOT01A Discovery Kit (Cortex-M4)
bletchley-bmc        Facebook Bletchley BMC (Cortex-A7)
boston-aia           MIPS Boston-aia
bpim2u               Bananapi M2U (Cortex-A7)
canon-a1100          Canon PowerShot A1100 IS (ARM946)
catalina-bmc         Facebook Catalina BMC (Cortex-A7)
collie               Sharp SL-5500 (Collie) PDA (SA-1110)
cubieboard           cubietech cubieboard (Cortex-A8)
emcraft-sf2          SmartFusion2 SOM kit from Emcraft (M2S010)
fby35-bmc            Facebook fby35 BMC (Cortex-A7)
fuji-bmc             Facebook Fuji BMC (Cortex-A7)
g220a-bmc            Bytedance G220A BMC (ARM1176)
gb200nvl-bmc         Nvidia GB200NVL BMC (Cortex-A7)
imx25-pdk            ARM i.MX25 PDK board (ARM926)
imx8mm-evk           NXP i.MX 8MM EVK Board
imx8mp-evk           NXP i.MX 8M Plus EVK Board
integratorcp         ARM Integrator/CP (ARM926EJ-S)
kudo-bmc             Kudo BMC (Cortex-A9)
kzm                  ARM KZM Emulation Baseboard (ARM1136)
lm3s6965evb          Stellaris LM3S6965EVB (Cortex-M3)
lm3s811evb           Stellaris LM3S811EVB (Cortex-M3)
max78000fthr         MAX78000FTHR Board (Cortex-M4 / (Unimplemented) RISC-V=
)
mcimx6ul-evk         Freescale i.MX6UL Evaluation Kit (Cortex-A7)
mcimx7d-sabre        Freescale i.MX7 DUAL SABRE (Cortex-A7)
microbit             BBC micro:bit (Cortex-M0)
mori-bmc             Mori BMC (Cortex-A9)
mps2-an385           ARM MPS2 with AN385 FPGA image for Cortex-M3
mps2-an386           ARM MPS2 with AN386 FPGA image for Cortex-M4
mps2-an500           ARM MPS2 with AN500 FPGA image for Cortex-M7
mps2-an505           ARM MPS2 with AN505 FPGA image for Cortex-M33
mps2-an511           ARM MPS2 with AN511 DesignStart FPGA image for
Cortex-M3
mps2-an521           ARM MPS2 with AN521 FPGA image for dual Cortex-M33
mps3-an524           ARM MPS3 with AN524 FPGA image for dual Cortex-M33
mps3-an536           ARM MPS3 with AN536 FPGA image for Cortex-R52
mps3-an547           ARM MPS3 with AN547 FPGA image for Cortex-M55
mps3-an555           ARM MPS3 with AN555 FPGA image for Cortex-M85
musca-a              ARM Musca-A board (dual Cortex-M33)
musca-b1             ARM Musca-B1 board (dual Cortex-M33)
netduino2            Netduino 2 Machine (Cortex-M3)
netduinoplus2        Netduino Plus 2 Machine (Cortex-M4)
none                 empty machine
npcm750-evb          Nuvoton NPCM750 Evaluation Board (Cortex-A9)
npcm845-evb          Nuvoton NPCM845 Evaluation Board (Cortex-A35)
nuri                 Samsung NURI board (Exynos4210)
olimex-stm32-h405    Olimex STM32-H405 (Cortex-M4)
orangepi-pc          Orange Pi PC (Cortex-A7)
palmetto-bmc         OpenPOWER Palmetto BMC (ARM926EJ-S)
quanta-gbs-bmc       Quanta GBS (Cortex-A9)
quanta-gsj           Quanta GSJ (Cortex-A9)
quanta-q71l-bmc      Quanta-Q71l BMC (ARM926EJ-S)
rainier-bmc          IBM Rainier BMC (Cortex-A7)
raspi0               Raspberry Pi Zero (revision 1.2)
raspi1ap             Raspberry Pi A+ (revision 1.1)
raspi2b              Raspberry Pi 2B (revision 1.1)
realview-eb          ARM RealView Emulation Baseboard (ARM926EJ-S)
realview-eb-mpcore   ARM RealView Emulation Baseboard (ARM11MPCore)
realview-pb-a8       ARM RealView Platform Baseboard for Cortex-A8
realview-pbx-a9      ARM RealView Platform Baseboard Explore for Cortex-A9
romulus-bmc          OpenPOWER Romulus BMC (ARM1176)
sabrelite            Freescale i.MX6 Quad SABRE Lite Board (Cortex-A9)
sbsa-ref             QEMU 'SBSA Reference' ARM Virtual Machine
smdkc210             Samsung SMDKC210 board (Exynos4210)
stm32vldiscovery     ST STM32VLDISCOVERY (Cortex-M3)
supermicro-x11spi-bmc Supermicro X11 SPI BMC (ARM1176)
supermicrox11-bmc    Supermicro X11 BMC (ARM926EJ-S)
sx1                  Siemens SX1 (OMAP310) V2
sx1-v1               Siemens SX1 (OMAP310) V1
tiogapass-bmc        Facebook Tiogapass BMC (ARM1176)
versatileab          ARM Versatile/AB (ARM926EJ-S)
versatilepb          ARM Versatile/PB (ARM926EJ-S)
vexpress-a15         ARM Versatile Express for Cortex-A15
vexpress-a9          ARM Versatile Express for Cortex-A9
virt-10.0            QEMU 10.0 ARM Virtual Machine
virt-10.1            QEMU 10.1 ARM Virtual Machine
virt-10.2            QEMU 10.2 ARM Virtual Machine
virt-11.0            QEMU 11.0 ARM Virtual Machine
virt-11.1            QEMU 11.1 ARM Virtual Machine
virt                 QEMU 11.2 ARM Virtual Machine (alias of virt-11.2)
virt-11.2            QEMU 11.2 ARM Virtual Machine
virt-6.0             QEMU 6.0 ARM Virtual Machine (deprecated)
virt-6.1             QEMU 6.1 ARM Virtual Machine (deprecated)
virt-6.2             QEMU 6.2 ARM Virtual Machine (deprecated)
virt-7.0             QEMU 7.0 ARM Virtual Machine (deprecated)
virt-7.1             QEMU 7.1 ARM Virtual Machine (deprecated)
virt-7.2             QEMU 7.2 ARM Virtual Machine (deprecated)
virt-8.0             QEMU 8.0 ARM Virtual Machine (deprecated)
virt-8.1             QEMU 8.1 ARM Virtual Machine (deprecated)
virt-8.2             QEMU 8.2 ARM Virtual Machine (deprecated)
virt-9.0             QEMU 9.0 ARM Virtual Machine
virt-9.1             QEMU 9.1 ARM Virtual Machine
virt-9.2             QEMU 9.2 ARM Virtual Machine
witherspoon-bmc      OpenPOWER Witherspoon BMC (ARM1176)
xilinx-zynq-a9       Xilinx Zynq 7000 Platform Baseboard for Cortex-A9
xlnx-zcu102          Xilinx ZynqMP ZCU102 board with 4xA53s and 2xR5Fs
based on the value of smp
yosemitev2-bmc       Facebook YosemiteV2 BMC (ARM1176)

aarch64:
ast2700a1-evb        Aspeed AST2700 A1 EVB (Cortex-A35)
ast2700-evb          Aspeed AST2700 A2 EVB (Cortex-A35) (alias of
ast2700a2-evb)
ast2700a2-evb        Aspeed AST2700 A2 EVB (Cortex-A35)
ast2700fc            ast2700 full core support
raspi3ap             Raspberry Pi 3A+ (revision 1.0)
raspi3b              Raspberry Pi 3B (revision 1.2)
raspi4b              Raspberry Pi 4B (revision 1.5)


riscv32:
k230                 RISC-V Board compatible with Kendryte K230 SDK
microchip-icicle-kit Microchip PolarFire SoC Icicle Kit
opentitan            RISC-V Board compatible with OpenTitan
shakti_c             RISC-V Board compatible with Shakti SDK (deprecated)
sifive_e             RISC-V Board compatible with SiFive E SDK
sifive_u             RISC-V Board compatible with SiFive U SDK
spike                RISC-V Spike board
tt-atlantis          Tenstorrent Atlantis RISC-V SoC (Experimental)
virt                 RISC-V VirtIO board
xiangshan-kunminghu  RISC-V Board compatible with the Xiangshan Kunminghu
FPGA prototype platform

riscv64:
k230                 RISC-V Board compatible with Kendryte K230 SDK
microchip-icicle-kit Microchip PolarFire SoC Icicle Kit
opentitan            RISC-V Board compatible with OpenTitan
shakti_c             RISC-V Board compatible with Shakti SDK (deprecated)
sifive_e             RISC-V Board compatible with SiFive E SDK
sifive_u             RISC-V Board compatible with SiFive U SDK
spike                RISC-V Spike board
tt-atlantis          Tenstorrent Atlantis RISC-V SoC (Experimental)
virt                 RISC-V VirtIO board
xiangshan-kunminghu  RISC-V Board compatible with the Xiangshan Kunminghu
FPGA prototype platform
```

--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000128c21065a91b0e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>&gt;<br>&gt; &gt; Pierrick Bouvier (14):<br>&gt; &=
gt; =C2=A0 =C2=A0qom/object: add is_available callback to TypeInfo<br>&gt;<=
br><br>Patches for is_available callback to TypeInfo, it&#39;s can be merge=
d latter<br><br>The reason is for the following command to execute:<div><br=
></div><div>we need add target_info_select and pass TargetInfo to is_availa=
ble<br><br>- Move target_info() into qom/object.c. Default to SYS_EMU_TARGE=
T_NONE<br>=C2=A0 until a real target is selected.<br>- Add target_info_sele=
ct(); it may be called only once with a non-NULL<br>=C2=A0 TargetInfo that =
is not SYS_EMU_TARGET_NONE.<br>- Invoke TypeInfo.is_available after select,=
 passing target_info().<br>- Change target_* helpers to take const TargetIn=
fo *.<br>- Select the sole TargetInfo in user-mode MODULE_INIT_TARGET_INFO.=
</div><div><br></div><div>With these changes, when `qemu-system` does not s=
elect TargetInfo, we can still list all machines and devices for each targe=
t properly.<br><div>```</div><div>$ ./qemu-system.exe -machine ?<br>Support=
ed machines are:<br>none:<br>amd-microblaze-v-generic AMD Microblaze-V gene=
ric platform<br>xlnx-versal-virt =C2=A0 =C2=A0 AMD Versal Virtual developme=
nt board (alias of amd-versal-virt)<br>amd-versal-virt =C2=A0 =C2=A0 =C2=A0=
AMD Versal Virtual development board<br>amd-versal2-virt =C2=A0 =C2=A0 AMD =
Versal Gen 2 Virtual development board<br>anacapa-bmc =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0Facebook Anacapa BMC (Cortex-A7)<br>ast1030-evb =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Aspeed AST1030 MiniBMC (Cortex-M4)<br>ast1040-evb =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Aspeed AST1040 BIC EVB (Cortex-M4F)<br>ast10=
60-evb =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Aspeed AST1060 Platform Root of Tr=
ust (Cortex-M4)<br>ast2500-evb =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Aspeed AST=
2500 EVB (ARM1176)<br>ast2600-evb =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Aspeed =
AST2600 EVB (Cortex-A7)<br>axiado-scm3003 =C2=A0 =C2=A0 =C2=A0 Axiado SCM30=
03 EVK Board<br>b-l475e-iot01a =C2=A0 =C2=A0 =C2=A0 B-L475E-IOT01A Discover=
y Kit (Cortex-M4)<br>bletchley-bmc =C2=A0 =C2=A0 =C2=A0 =C2=A0Facebook Blet=
chley BMC (Cortex-A7)<br>boston-aia =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS=
 Boston-aia<br>bpim2u =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Bana=
napi M2U (Cortex-A7)<br>canon-a1100 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Canon=
 PowerShot A1100 IS (ARM946)<br>catalina-bmc =C2=A0 =C2=A0 =C2=A0 =C2=A0 Fa=
cebook Catalina BMC (Cortex-A7)<br>collie =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Sharp SL-5500 (Collie) PDA (SA-1110)<br>cubieboard =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cubietech cubieboard (Cortex-A8)<br>emcraft-sf=
2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SmartFusion2 SOM kit from Emcraft (M2S0=
10)<br>fby35-bmc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Facebook fby35 BM=
C (Cortex-A7)<br>fuji-bmc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Faceboo=
k Fuji BMC (Cortex-A7)<br>g220a-bmc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Bytedance G220A BMC (ARM1176)<br>gb200nvl-bmc =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Nvidia GB200NVL BMC (Cortex-A7)<br>imx25-pdk =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0ARM i.MX25 PDK board (ARM926)<br>imx8mm-evk =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 NXP i.MX 8MM EVK Board<br>imx8mp-evk =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 NXP i.MX 8M Plus EVK Board<br>integratorcp =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ARM Integrator/CP (ARM926EJ-S)<br>kudo-bmc =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 Kudo BMC (Cortex-A9)<br>kzm =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ARM KZM Emulation Baseboard (ARM11=
36)<br>lm3s6965evb =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Stellaris LM3S6965EVB =
(Cortex-M3)<br>lm3s811evb =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Stellaris LM3S=
811EVB (Cortex-M3)<br>max78000fthr =C2=A0 =C2=A0 =C2=A0 =C2=A0 MAX78000FTHR=
 Board (Cortex-M4 / (Unimplemented) RISC-V)<br>mcimx6ul-evk =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 Freescale i.MX6UL Evaluation Kit (Cortex-A7)<br>mcimx7d-sabre=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0Freescale i.MX7 DUAL SABRE (Cortex-A7)<br>micro=
bit =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BBC micro:bit (Cortex-M0)<br>=
mori-bmc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Mori BMC (Cortex-A9)<br>=
mps2-an385 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ARM MPS2 with AN385 FPGA imag=
e for Cortex-M3<br>mps2-an386 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ARM MPS2 w=
ith AN386 FPGA image for Cortex-M4<br>mps2-an500 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ARM MPS2 with AN500 FPGA image for Cortex-M7<br>mps2-an505 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ARM MPS2 with AN505 FPGA image for Cortex-M=
33<br>mps2-an511 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ARM MPS2 with AN511 Des=
ignStart FPGA image for Cortex-M3<br>mps2-an521 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ARM MPS2 with AN521 FPGA image for dual Cortex-M33<br>mps3-an524 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ARM MPS3 with AN524 FPGA image for dual =
Cortex-M33<br>mps3-an536 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ARM MPS3 with A=
N536 FPGA image for Cortex-R52<br>mps3-an547 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ARM MPS3 with AN547 FPGA image for Cortex-M55<br>mps3-an555 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ARM MPS3 with AN555 FPGA image for Cortex-M85<b=
r>musca-a =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ARM Musca-A board=
 (dual Cortex-M33)<br>musca-b1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AR=
M Musca-B1 board (dual Cortex-M33)<br>netduino2 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0Netduino 2 Machine (Cortex-M3)<br>netduinoplus2 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0Netduino Plus 2 Machine (Cortex-M4)<br>none =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 empty machine<br>npcm750-evb =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0Nuvoton NPCM750 Evaluation Board (Cortex-A9)<br>=
npcm845-evb =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Nuvoton NPCM845 Evaluation Bo=
ard (Cortex-A35)<br>nuri =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Samsung NURI board (Exynos4210)<br>olimex-stm32-h405 =C2=A0 =C2=A0Ol=
imex STM32-H405 (Cortex-M4)<br>orangepi-pc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Orange Pi PC (Cortex-A7)<br>palmetto-bmc =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ope=
nPOWER Palmetto BMC (ARM926EJ-S)<br>quanta-gbs-bmc =C2=A0 =C2=A0 =C2=A0 Qua=
nta GBS (Cortex-A9)<br>quanta-gsj =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Quanta=
 GSJ (Cortex-A9)<br>quanta-q71l-bmc =C2=A0 =C2=A0 =C2=A0Quanta-Q71l BMC (AR=
M926EJ-S)<br>rainier-bmc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IBM Rainier BMC =
(Cortex-A7)<br>raspi0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Rasp=
berry Pi Zero (revision 1.2)<br>raspi1ap =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 Raspberry Pi A+ (revision 1.1)<br>raspi2b =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0Raspberry Pi 2B (revision 1.1)<br>realview-eb =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ARM RealView Emulation Baseboard (ARM926EJ-S=
)<br>realview-eb-mpcore =C2=A0 ARM RealView Emulation Baseboard (ARM11MPCor=
e)<br>realview-pb-a8 =C2=A0 =C2=A0 =C2=A0 ARM RealView Platform Baseboard f=
or Cortex-A8<br>realview-pbx-a9 =C2=A0 =C2=A0 =C2=A0ARM RealView Platform B=
aseboard Explore for Cortex-A9<br>romulus-bmc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0OpenPOWER Romulus BMC (ARM1176)<br>sabrelite =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Freescale i.MX6 Quad SABRE Lite Board (Cortex-A9)<br>sbsa-=
ref =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QEMU &#39;SBSA Reference&#39;=
 ARM Virtual Machine<br>smdkc210 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
Samsung SMDKC210 board (Exynos4210)<br>stm32vldiscovery =C2=A0 =C2=A0 ST ST=
M32VLDISCOVERY (Cortex-M3)<br>supermicro-x11spi-bmc Supermicro X11 SPI BMC =
(ARM1176)<br>supermicrox11-bmc =C2=A0 =C2=A0Supermicro X11 BMC (ARM926EJ-S)=
<br>sx1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Sieme=
ns SX1 (OMAP310) V2<br>sx1-v1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Siemens SX1 (OMAP310) V1<br>tiogapass-bmc =C2=A0 =C2=A0 =C2=A0 =C2=A0Fa=
cebook Tiogapass BMC (ARM1176)<br>versatileab =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0ARM Versatile/AB (ARM926EJ-S)<br>versatilepb =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ARM Versatile/PB (ARM926EJ-S)<br>vexpress-a15 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ARM Versatile Express for Cortex-A15<br>vexpress-a9 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0ARM Versatile Express for Cortex-A9<br>virt-10.0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QEMU 10.0 ARM Virtual Machine<br>v=
irt-10.1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QEMU 10.1 ARM Virtual Mac=
hine<br>virt-10.2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QEMU 10.2 ARM Vi=
rtual Machine<br>virt-11.0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QEMU 11=
.0 ARM Virtual Machine<br>virt-11.1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0QEMU 11.1 ARM Virtual Machine<br>virt =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 QEMU 11.2 ARM Virtual Machine (alias of virt-11.2)<br=
>virt-11.2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QEMU 11.2 ARM Virtual M=
achine<br>virt-6.0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QEMU 6.0 ARM V=
irtual Machine (deprecated)<br>virt-6.1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 QEMU 6.1 ARM Virtual Machine (deprecated)<br>virt-6.2 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 QEMU 6.2 ARM Virtual Machine (deprecated)<br>vi=
rt-7.0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QEMU 7.0 ARM Virtual Machi=
ne (deprecated)<br>virt-7.1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QEMU =
7.1 ARM Virtual Machine (deprecated)<br>virt-7.2 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 QEMU 7.2 ARM Virtual Machine (deprecated)<br>virt-8.0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QEMU 8.0 ARM Virtual Machine (deprec=
ated)<br>virt-8.1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QEMU 8.1 ARM Vi=
rtual Machine (deprecated)<br>virt-8.2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 QEMU 8.2 ARM Virtual Machine (deprecated)<br>virt-9.0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 QEMU 9.0 ARM Virtual Machine<br>virt-9.1 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QEMU 9.1 ARM Virtual Machine<br>virt-9.=
2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QEMU 9.2 ARM Virtual Machine<br=
>witherspoon-bmc =C2=A0 =C2=A0 =C2=A0OpenPOWER Witherspoon BMC (ARM1176)<br=
>xilinx-zynq-a9 =C2=A0 =C2=A0 =C2=A0 Xilinx Zynq 7000 Platform Baseboard fo=
r Cortex-A9<br>xlnx-zcu102 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Xilinx ZynqMP =
ZCU102 board with 4xA53s and 2xR5Fs based on the value of smp<br>yosemitev2=
-bmc =C2=A0 =C2=A0 =C2=A0 Facebook YosemiteV2 BMC (ARM1176)<br><br>aarch64:=
<br>ast2700a1-evb =C2=A0 =C2=A0 =C2=A0 =C2=A0Aspeed AST2700 A1 EVB (Cortex-=
A35)<br>ast2700-evb =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Aspeed AST2700 A2 EVB=
 (Cortex-A35) (alias of ast2700a2-evb)<br>ast2700a2-evb =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Aspeed AST2700 A2 EVB (Cortex-A35)<br>ast2700fc =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0ast2700 full core support<br>raspi3ap =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Raspberry Pi 3A+ (revision 1.0)<br>raspi3b =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Raspberry Pi 3B (revision 1.2)=
<br>raspi4b =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Raspberry Pi 4B=
 (revision 1.5)<br><br><br>riscv32:<br>k230 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 RISC-V Board compatible with Kendryte K230 SDK<br>=
microchip-icicle-kit Microchip PolarFire SoC Icicle Kit<br>opentitan =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RISC-V Board compatible with OpenTitan<b=
r>shakti_c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISC-V Board compatibl=
e with Shakti SDK (deprecated)<br>sifive_e =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 RISC-V Board compatible with SiFive E SDK<br>sifive_u =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISC-V Board compatible with SiFive U SDK<b=
r>spike =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RISC-V Spike=
 board<br>tt-atlantis =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Tenstorrent Atlanti=
s RISC-V SoC (Experimental)<br>virt =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 RISC-V VirtIO board<br>xiangshan-kunminghu =C2=A0RISC-V B=
oard compatible with the Xiangshan Kunminghu FPGA prototype platform<br><br=
>riscv64:<br>k230 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 R=
ISC-V Board compatible with Kendryte K230 SDK<br>microchip-icicle-kit Micro=
chip PolarFire SoC Icicle Kit<br>opentitan =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0RISC-V Board compatible with OpenTitan<br>shakti_c =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RISC-V Board compatible with Shakti SDK (deprec=
ated)<br>sifive_e =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISC-V Board co=
mpatible with SiFive E SDK<br>sifive_u =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 RISC-V Board compatible with SiFive U SDK<br>spike =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RISC-V Spike board<br>tt-atlantis =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Tenstorrent Atlantis RISC-V SoC (Experimenta=
l)<br>virt =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISC-V V=
irtIO board<br>xiangshan-kunminghu =C2=A0RISC-V Board compatible with the X=
iangshan Kunminghu FPGA prototype platform<br></div><div>```<br><br>--<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=
=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<=
/div></div></div>

--000000000000128c21065a91b0e9--

--000000000000128c22065a91b0eb
Content-Type: text/plain; charset="US-ASCII"; 
	name="0002-qom-add-target_info_select-and-pass-TargetInfo-to-is.patch"
Content-Disposition: attachment; 
	filename="0002-qom-add-target_info_select-and-pass-TargetInfo-to-is.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mtldwhx92>
X-Attachment-Id: f_mtldwhx92

RnJvbSA4YWZjYTE3OGI2OWViZjM4ZTBmMGVkMDQ4YTU5ODgzYWM5MjMwOGIzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZb25nZ2FuZyBMdW8gPGx1b3lvbmdnYW5nQGdtYWlsLmNvbT4K
RGF0ZTogVGh1LCAzIFNlcCAyMDI2IDEzOjEyOjMyICswODAwClN1YmplY3Q6IFtQQVRDSCAyLzNd
IHFvbTogYWRkIHRhcmdldF9pbmZvX3NlbGVjdCBhbmQgcGFzcyBUYXJnZXRJbmZvIHRvCiBpc19h
dmFpbGFibGUKCi0gTW92ZSB0YXJnZXRfaW5mbygpIGludG8gcW9tL29iamVjdC5jLiBEZWZhdWx0
IHRvIFNZU19FTVVfVEFSR0VUX05PTkUKICB1bnRpbCBhIHJlYWwgdGFyZ2V0IGlzIHNlbGVjdGVk
LgotIEFkZCB0YXJnZXRfaW5mb19zZWxlY3QoKTsgaXQgbWF5IGJlIGNhbGxlZCBvbmx5IG9uY2Ug
d2l0aCBhIG5vbi1OVUxMCiAgVGFyZ2V0SW5mbyB0aGF0IGlzIG5vdCBTWVNfRU1VX1RBUkdFVF9O
T05FLgotIEludm9rZSBUeXBlSW5mby5pc19hdmFpbGFibGUgYWZ0ZXIgc2VsZWN0LCBwYXNzaW5n
IHRhcmdldF9pbmZvKCkuCi0gQ2hhbmdlIHRhcmdldF8qIGhlbHBlcnMgdG8gdGFrZSBjb25zdCBU
YXJnZXRJbmZvICouCi0gU2VsZWN0IHRoZSBzb2xlIFRhcmdldEluZm8gaW4gdXNlci1tb2RlIE1P
RFVMRV9JTklUX1RBUkdFVF9JTkZPLgotLS0KIGJzZC11c2VyL21haW4uYyAgICAgICAgICAgICAg
ICAgfCAgMSArCiBody9hcm0vYXNwZWVkX2FzdDI3eDAuYyAgICAgICAgIHwgIDQgKy0tCiBody9h
cm0vdmlydC5jICAgICAgICAgICAgICAgICAgIHwgIDQgKy0tCiBody9uaXRyby9tYWNoaW5lLmMg
ICAgICAgICAgICAgIHwgIDIgKy0KIGh3L3BjaS9wY2kuYyAgICAgICAgICAgICAgICAgICAgfCAg
MiArLQogaHcvc2NzaS9zY3NpLWRpc2suYyAgICAgICAgICAgICB8ICAyICstCiBody92ZmlvL21p
Z3JhdGlvbi1tdWx0aWZkLmMgICAgIHwgIDIgKy0KIGh3L3ZpcnRpby92aG9zdC11c2VyLmMgICAg
ICAgICAgfCAgMiArLQogaW5jbHVkZS9xZW11L3RhcmdldC1pbmZvLWltcGwuaCB8IDEzICsrKy0t
LS0tCiBpbmNsdWRlL3FlbXUvdGFyZ2V0LWluZm8taW5pdC5oIHwgMTggKysrKysrLS0tLS0KIGlu
Y2x1ZGUvcWVtdS90YXJnZXQtaW5mby5oICAgICAgfCA0NCArKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0KIGluY2x1ZGUvcW9tL29iamVjdC5oICAgICAgICAgICAgfCA1MyArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0KIGxpbnV4LXVzZXIvbWFpbi5jICAgICAgICAgICAgICAgfCAg
MSArCiBxb20vb2JqZWN0LmMgICAgICAgICAgICAgICAgICAgIHwgMzYgKysrKysrKysrKysrKysr
KysrKysrLQogdGFyZ2V0LWluZm8tcW9tLmMgICAgICAgICAgICAgICB8ICA5ICstLS0tLQogdGFy
Z2V0LWluZm8uYyAgICAgICAgICAgICAgICAgICB8IDMyICsrKysrKysrKystLS0tLS0tLS0tCiB0
YXJnZXQvYXJtL2NwdS1tYXguYyAgICAgICAgICAgIHwgIDIgKy0KIHRhcmdldC9hcm0vdGNnL2Nw
dS1tYXgtdjguYyAgICAgfCAgMiArLQogMTggZmlsZXMgY2hhbmdlZCwgMTU3IGluc2VydGlvbnMo
KyksIDcyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2JzZC11c2VyL21haW4uYyBiL2JzZC11
c2VyL21haW4uYwppbmRleCA2OTQ0ODFhZTNlYy4uNTkyYzA0ZjFlNzkgMTAwNjQ0Ci0tLSBhL2Jz
ZC11c2VyL21haW4uYworKysgYi9ic2QtdXNlci9tYWluLmMKQEAgLTI4NSw2ICsyODUsNyBAQCBp
bnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAgICAgZXJyb3JfaW5pdChhcmd2WzBdKTsK
ICAgICBtb2R1bGVfY2FsbF9pbml0KE1PRFVMRV9JTklUX1RSQUNFKTsKICAgICBxZW11X2luaXRf
Y3B1X2xpc3QoKTsKKyAgICBtb2R1bGVfY2FsbF9pbml0KE1PRFVMRV9JTklUX1RBUkdFVF9JTkZP
KTsKICAgICBtb2R1bGVfY2FsbF9pbml0KE1PRFVMRV9JTklUX1FPTSk7CiAKICAgICBlbnZsaXN0
ID0gZW52bGlzdF9jcmVhdGUoKTsKZGlmZiAtLWdpdCBhL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5j
IGIvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMKaW5kZXggNjM2NWRiZDYzOGIuLjE3MDNhYzdkMGNh
IDEwMDY0NAotLS0gYS9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYworKysgYi9ody9hcm0vYXNwZWVk
X2FzdDI3eDAuYwpAQCAtNDIwLDcgKzQyMCw3IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9zb2NfYXN0
MjcwMF9pbml0KE9iamVjdCAqb2JqKQogICAgIH0KIAogICAgIGZvciAoaSA9IDA7IGkgPCBzYy0+
bnVtX2NwdXM7IGkrKykgewotICAgICAgICBpZiAocXRlc3RfZW5hYmxlZCgpICYmICF0YXJnZXRf
YWFyY2g2NCgpKSB7CisgICAgICAgIGlmIChxdGVzdF9lbmFibGVkKCkgJiYgIXRhcmdldF9hYXJj
aDY0KHRhcmdldF9pbmZvKCkpKSB7CiAgICAgICAgICAgICAvKgogICAgICAgICAgICAgICogSW50
cm9zcGVjdGlvbiBxdGVzdCBqdXN0IHdhbnQgdG8gY3JlYXRlIHRoaXMgb2JqZWN0CiAgICAgICAg
ICAgICAgKiB3aXRob3V0IHJlYWxpemluZyBpdC4gQVJNX0NQVV9UWVBFX05BTUUoImNvcnRleC1h
MzUiKQpAQCAtNzAzLDcgKzcwMyw3IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9zb2NfYXN0MjcwMF9y
ZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkKICAgICBxZW11X2lycSBpcnE7
CiAgICAgaW50IHVhcnQ7CiAKLSAgICBpZiAocXRlc3RfZW5hYmxlZCgpICYmICF0YXJnZXRfYWFy
Y2g2NCgpKSB7CisgICAgaWYgKHF0ZXN0X2VuYWJsZWQoKSAmJiAhdGFyZ2V0X2FhcmNoNjQodGFy
Z2V0X2luZm8oKSkpIHsKICAgICAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKICAgICB9CiAK
ZGlmZiAtLWdpdCBhL2h3L2FybS92aXJ0LmMgYi9ody9hcm0vdmlydC5jCmluZGV4IDA4NzFhMzVl
MTFmLi5kYmRmNTVkZmVhOSAxMDA2NDQKLS0tIGEvaHcvYXJtL3ZpcnQuYworKysgYi9ody9hcm0v
dmlydC5jCkBAIC00MTMyLDcgKzQxMzIsNyBAQCBzdGF0aWMgR1B0ckFycmF5ICp2aXJ0X2dldF92
YWxpZF9jcHVfdHlwZXMoY29uc3QgTWFjaGluZVN0YXRlICptcykKICAgICAgICAgZ19wdHJfYXJy
YXlfYWRkKHZjdCwgZ19zdHJkdXAoQVJNX0NQVV9UWVBFX05BTUUoImNvcnRleC1hMTUiKSkpOwog
ICAgICAgICBnX3B0cl9hcnJheV9hZGQodmN0LCBnX3N0cmR1cChBUk1fQ1BVX1RZUEVfTkFNRSgi
bWF4LXY4IikpKTsKICAgICB9Ci0gICAgaWYgKHRjZ19lbmFibGVkKCkgJiYgdGFyZ2V0X2FhcmNo
NjQoKSkgeworICAgIGlmICh0Y2dfZW5hYmxlZCgpICYmIHRhcmdldF9hYXJjaDY0KHRhcmdldF9p
bmZvKCkpKSB7CiAgICAgICAgIGdfcHRyX2FycmF5X2FkZCh2Y3QsIGdfc3RyZHVwKEFSTV9DUFVf
VFlQRV9OQU1FKCJjb3J0ZXgtYTM1IikpKTsKICAgICAgICAgZ19wdHJfYXJyYXlfYWRkKHZjdCwg
Z19zdHJkdXAoQVJNX0NQVV9UWVBFX05BTUUoImNvcnRleC1hNTUiKSkpOwogICAgICAgICBnX3B0
cl9hcnJheV9hZGQodmN0LCBnX3N0cmR1cChBUk1fQ1BVX1RZUEVfTkFNRSgiY29ydGV4LWE3MiIp
KSk7CkBAIC00MTQ0LDcgKzQxNDQsNyBAQCBzdGF0aWMgR1B0ckFycmF5ICp2aXJ0X2dldF92YWxp
ZF9jcHVfdHlwZXMoY29uc3QgTWFjaGluZVN0YXRlICptcykKICAgICAgICAgZ19wdHJfYXJyYXlf
YWRkKHZjdCwgZ19zdHJkdXAoQVJNX0NQVV9UWVBFX05BTUUoIm5lb3ZlcnNlLW4yIikpKTsKICAg
ICAgICAgZ19wdHJfYXJyYXlfYWRkKHZjdCwgZ19zdHJkdXAoQVJNX0NQVV9UWVBFX05BTUUoIm1h
eC12OSIpKSk7CiAgICAgfQotICAgIGlmICh0YXJnZXRfYWFyY2g2NCgpKSB7CisgICAgaWYgKHRh
cmdldF9hYXJjaDY0KHRhcmdldF9pbmZvKCkpKSB7CiAgICAgICAgIGdfcHRyX2FycmF5X2FkZCh2
Y3QsIGdfc3RyZHVwKEFSTV9DUFVfVFlQRV9OQU1FKCJjb3J0ZXgtYTUzIikpKTsKICAgICAgICAg
Z19wdHJfYXJyYXlfYWRkKHZjdCwgZ19zdHJkdXAoQVJNX0NQVV9UWVBFX05BTUUoImNvcnRleC1h
NTciKSkpOwogICAgICAgICBpZiAoa3ZtX2VuYWJsZWQoKSB8fCBodmZfZW5hYmxlZCgpIHx8IHdo
cHhfZW5hYmxlZCgpKSB7CmRpZmYgLS1naXQgYS9ody9uaXRyby9tYWNoaW5lLmMgYi9ody9uaXRy
by9tYWNoaW5lLmMKaW5kZXggODhkMDE5NjBhMDEuLjJhOTI0Y2FiNGY3IDEwMDY0NAotLS0gYS9o
dy9uaXRyby9tYWNoaW5lLmMKKysrIGIvaHcvbml0cm8vbWFjaGluZS5jCkBAIC05Nyw3ICs5Nyw3
IEBAIHN0YXRpYyBjaGFyICpidWlsZF9laWYoY29uc3QgY2hhciAqa2VybmVsX2RhdGEsIGdzaXpl
IGtlcm5lbF9zaXplLAogICAgIGhkciA9IChFaWZIZWFkZXIpIHsKICAgICAgICAgLm1hZ2ljID0g
RUlGX01BR0lDLAogICAgICAgICAudmVyc2lvbiA9IGNwdV90b19iZTE2KDQpLAotICAgICAgICAu
ZmxhZ3MgPSBjcHVfdG9fYmUxNih0YXJnZXRfYWFyY2g2NCgpID8gRUlGX0hEUl9BUkNIX0FSTTY0
IDogMCksCisgICAgICAgIC5mbGFncyA9IGNwdV90b19iZTE2KHRhcmdldF9hYXJjaDY0KHRhcmdl
dF9pbmZvKCkpID8gRUlGX0hEUl9BUkNIX0FSTTY0IDogMCksCiAgICAgfTsKIAogICAgIGdfYnl0
ZV9hcnJheV9hcHBlbmQoYnVmLCAoY29uc3QgdWludDhfdCAqKSZoZHIsIHNpemVvZihoZHIpKTsK
ZGlmZiAtLWdpdCBhL2h3L3BjaS9wY2kuYyBiL2h3L3BjaS9wY2kuYwppbmRleCBjMTVmMmI5ZjA4
NC4uMjYwMDNmMmI0ZGYgMTAwNjQ0Ci0tLSBhL2h3L3BjaS9wY2kuYworKysgYi9ody9wY2kvcGNp
LmMKQEAgLTI4ODgsNyArMjg4OCw3IEBAIHZvaWQgcGNpX3FkZXZfcHJvcGVydHlfYWRkX3NwZWNp
ZmljcyhEZXZpY2VDbGFzcyAqZGMpCiAgICAgT2JqZWN0Q2xhc3MgKm9jID0gT0JKRUNUX0NMQVNT
KGRjKTsKIAogICAgIC8qIFRoZSBsb2FkcGFybSBwcm9wZXJ0eSBpcyBvbmx5IHN1cHBvcnRlZCBv
biBzMzkweCAqLwotICAgIGlmICh0YXJnZXRfczM5MHgoKSkgeworICAgIGlmICh0YXJnZXRfczM5
MHgodGFyZ2V0X2luZm8oKSkpIHsKICAgICAgICAgb2JqZWN0X2NsYXNzX3Byb3BlcnR5X2FkZF9z
dHIob2MsICJsb2FkcGFybSIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHBjaV9xZGV2X3Byb3BlcnR5X2dldF9sb2FkcGFybSwKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcGNpX3FkZXZfcHJvcGVydHlfc2V0X2xvYWRwYXJtKTsKZGlmZiAtLWdp
dCBhL2h3L3Njc2kvc2NzaS1kaXNrLmMgYi9ody9zY3NpL3Njc2ktZGlzay5jCmluZGV4IGE0MmY3
ZDhlNzdkLi4zMTE3MGU4N2EzMyAxMDA2NDQKLS0tIGEvaHcvc2NzaS9zY3NpLWRpc2suYworKysg
Yi9ody9zY3NpL3Njc2ktZGlzay5jCkBAIC0zMTkwLDcgKzMxOTAsNyBAQCBzdGF0aWMgdm9pZCBz
Y3NpX3Byb3BlcnR5X2FkZF9zcGVjaWZpY3MoRGV2aWNlQ2xhc3MgKmRjKQogICAgIE9iamVjdENs
YXNzICpvYyA9IE9CSkVDVF9DTEFTUyhkYyk7CiAKICAgICAvKiBUaGUgbG9hZHBhcm0gcHJvcGVy
dHkgaXMgb25seSBzdXBwb3J0ZWQgb24gczM5MHggKi8KLSAgICBpZiAodGFyZ2V0X3MzOTB4KCkp
IHsKKyAgICBpZiAodGFyZ2V0X3MzOTB4KHRhcmdldF9pbmZvKCkpKSB7CiAgICAgICAgIG9iamVj
dF9jbGFzc19wcm9wZXJ0eV9hZGRfc3RyKG9jLCAibG9hZHBhcm0iLAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzY3NpX3Byb3BlcnR5X2dldF9sb2FkcGFybSwKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2NzaV9wcm9wZXJ0eV9zZXRfbG9hZHBh
cm0pOwpkaWZmIC0tZ2l0IGEvaHcvdmZpby9taWdyYXRpb24tbXVsdGlmZC5jIGIvaHcvdmZpby9t
aWdyYXRpb24tbXVsdGlmZC5jCmluZGV4IGEwNmNiZjNjNjQ2Li4zZDc0N2I0NzBjYyAxMDA2NDQK
LS0tIGEvaHcvdmZpby9taWdyYXRpb24tbXVsdGlmZC5jCisrKyBiL2h3L3ZmaW8vbWlncmF0aW9u
LW11bHRpZmQuYwpAQCAtNTQsNyArNTQsNyBAQCBib29sIHZmaW9fbG9hZF9jb25maWdfYWZ0ZXJf
aXRlcihWRklPRGV2aWNlICp2YmFzZWRldikKICAgICAgKiBTZWUgY29tbWl0IGQzMjlmNTAzMmUx
NyAoInZmaW86IE1vdmUgdGhlIHNhdmluZyBvZiB0aGUgY29uZmlnIHNwYWNlIHRvCiAgICAgICog
dGhlIHJpZ2h0IHBsYWNlIGluIFZGSU8gbWlncmF0aW9uIikuCiAgICAgICovCi0gICAgcmV0dXJu
IHRhcmdldF9iYXNlX2FybSgpOworICAgIHJldHVybiB0YXJnZXRfYmFzZV9hcm0odGFyZ2V0X2lu
Zm8oKSk7CiB9CiAKIC8qIHR5cGUgc2FmZXR5ICovCmRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhv
c3QtdXNlci5jIGIvaHcvdmlydGlvL3Zob3N0LXVzZXIuYwppbmRleCAyODgxY2VjNzJkOS4uMzM4
M2FmNjQ4NTkgMTAwNjQ0Ci0tLSBhL2h3L3ZpcnRpby92aG9zdC11c2VyLmMKKysrIGIvaHcvdmly
dGlvL3Zob3N0LXVzZXIuYwpAQCAtMjYzMSw3ICsyNjMxLDcgQEAgc3RhdGljIGludCB2aG9zdF91
c2VyX2JhY2tlbmRfaW5pdChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIHZvaWQgKm9wYXF1ZSwKICAg
ICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKICAgICAgICAgICAgIH0KIAotICAgICAgICAg
ICAgY29uc3QgdWludDY0X3Qgdmhvc3RfdXNlcl9tYXhfcmFtX3Nsb3RzID0gdGFyZ2V0X2Jhc2Vf
cHBjKCkgPworICAgICAgICAgICAgY29uc3QgdWludDY0X3Qgdmhvc3RfdXNlcl9tYXhfcmFtX3Ns
b3RzID0gdGFyZ2V0X2Jhc2VfcHBjKHRhcmdldF9pbmZvKCkpID8KICAgICAgICAgICAgICAgICBT
UEFQUl9NQVhfUkFNX1NMT1RTIDogVkhPU1RfVVNFUl9NQVhfUkFNX1NMT1RTOwogICAgICAgICAg
ICAgdS0+dXNlci0+bWVtb3J5X3Nsb3RzID0gTUlOKHJhbV9zbG90cywgdmhvc3RfdXNlcl9tYXhf
cmFtX3Nsb3RzKTsKICAgICAgICAgfQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11L3RhcmdldC1p
bmZvLWltcGwuaCBiL2luY2x1ZGUvcWVtdS90YXJnZXQtaW5mby1pbXBsLmgKaW5kZXggY2Y0MmFh
YmJjOGIuLjYxNDA0YmFhNGI1IDEwMDY0NAotLS0gYS9pbmNsdWRlL3FlbXUvdGFyZ2V0LWluZm8t
aW1wbC5oCisrKyBiL2luY2x1ZGUvcWVtdS90YXJnZXQtaW5mby1pbXBsLmgKQEAgLTksMTAgKzks
MTIgQEAKICNpZm5kZWYgUUVNVV9UQVJHRVRfSU5GT19JTVBMX0gKICNkZWZpbmUgUUVNVV9UQVJH
RVRfSU5GT19JTVBMX0gKIAorI2luY2x1ZGUgInFlbXUvdGFyZ2V0LWluZm8uaCIKKyNpbmNsdWRl
ICJxb20vb2JqZWN0LmgiCiAjaW5jbHVkZSAicWFwaS9xYXBpLXR5cGVzLWNvbW1vbi5oIgogI2lu
Y2x1ZGUgInFhcGkvcWFwaS10eXBlcy1tYWNoaW5lLmgiCiAKLXR5cGVkZWYgc3RydWN0IFRhcmdl
dEluZm8geworc3RydWN0IFRhcmdldEluZm8gewogICAgIC8qIHJ1bnRpbWUgZXF1aXZhbGVudCBv
ZiBUQVJHRVRfTkFNRSBkZWZpbml0aW9uICovCiAgICAgY29uc3QgY2hhciAqdGFyZ2V0X25hbWU7
CiAgICAgLyogcmVsYXRlZCB0byBUQVJHRVRfQVJDSCBkZWZpbml0aW9uICovCkBAIC0zMCwxMyAr
MzIsNiBAQCB0eXBlZGVmIHN0cnVjdCBUYXJnZXRJbmZvIHsKICAgICB1bnNpZ25lZCBwYWdlX2Jp
dHNfaW5pdDsKICAgICAvKiBydW50aW1lIGVxdWl2YWxlbnQgb2YgVEFSR0VUX1BBR0VfQklUU19W
QVJZIGRlZmluaXRpb24gKi8KICAgICBib29sIHBhZ2VfYml0c192YXJ5OwotfSBUYXJnZXRJbmZv
OwotCi0vKioKLSAqIHRhcmdldF9pbmZvOgotICoKLSAqIFJldHVybnM6IFRoZSBUYXJnZXRJbmZv
IHN0cnVjdHVyZSBkZWZpbml0aW9uIGZvciB0aGlzIHRhcmdldCBiaW5hcnkuCi0gKi8KLWNvbnN0
IFRhcmdldEluZm8gKnRhcmdldF9pbmZvKHZvaWQpOworfTsKIAogI2VuZGlmCmRpZmYgLS1naXQg
YS9pbmNsdWRlL3FlbXUvdGFyZ2V0LWluZm8taW5pdC5oIGIvaW5jbHVkZS9xZW11L3RhcmdldC1p
bmZvLWluaXQuaAppbmRleCBiNzAyNGM5ZmFlZi4uMmExOTkxOGFlMDggMTAwNjQ0Ci0tLSBhL2lu
Y2x1ZGUvcWVtdS90YXJnZXQtaW5mby1pbml0LmgKKysrIGIvaW5jbHVkZS9xZW11L3RhcmdldC1p
bmZvLWluaXQuaApAQCAtMTIsNiArMTIsOCBAQAogI2lmbmRlZiBRRU1VX1RBUkdFVF9JTkZPX0lO
SVRfSAogI2RlZmluZSBRRU1VX1RBUkdFVF9JTkZPX0lOSVRfSAogCisjaW5jbHVkZSAicW9tL29i
amVjdC5oIgorCiAjZGVmaW5lIERFRklORV9UQVJHRVRfSU5GT19UWVBFKGluZm8pICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAogc3RhdGljIHZvaWQgZG9fcWVtdV9pbml0
X3RhcmdldF9pbmZvKHZvaWQpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKIHsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBcCkBAIC0yMywxOSArMjUsMTkgQEAgbW9kdWxlX2luaXQoZG9fcWVt
dV9pbml0X3RhcmdldF9pbmZvLCBNT0RVTEVfSU5JVF9UQVJHRVRfSU5GTykKICNpZmRlZiBDT05G
SUdfVVNFUl9PTkxZCiAKIC8qCi0gKiBVc2VyIG1vZGUgZG9lcyBub3Qgc3VwcG9ydCBtdWx0aXBs
ZSB0YXJnZXRzIGluIHRoZSBzYW1lIGJpbmFyeSwgc28ganVzdAotICogZGVmaW5lIHRhcmdldF9p
bmZvKCkuCisgKiBVc2VyIG1vZGUgZG9lcyBub3Qgc3VwcG9ydCBtdWx0aXBsZSB0YXJnZXRzIGlu
IHRoZSBzYW1lIGJpbmFyeS4KKyAqIEluc3RhbGwgdGhlIHNvbGUgVGFyZ2V0SW5mbyBiZWZvcmUg
TU9EVUxFX0lOSVRfUU9NLgogICovCi0jZGVmaW5lIHRhcmdldF9pbmZvX2luaXQodGlfdmFyKSAg
ICAgICAgXAotY29uc3QgVGFyZ2V0SW5mbyAqdGFyZ2V0X2luZm8odm9pZCkgICAgIFwKLXsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCi0gICAgcmV0dXJuICZ0aV92YXI7
ICAgICAgICAgICAgICAgICAgICAgXAotfQorI2RlZmluZSB0YXJnZXRfaW5mb19pbml0KHRpX3Zh
cikgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAorc3RhdGljIHZvaWQg
ZG9fcWVtdV9pbml0X3RhcmdldF9pbmZvKHZvaWQpICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXAoreyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXAorICAgIHRhcmdldF9pbmZvX3NlbGVjdCgmdGlfdmFyKTsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAorfSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XAorbW9kdWxlX2luaXQoZG9fcWVtdV9pbml0X3RhcmdldF9pbmZvLCBNT0RVTEVfSU5JVF9UQVJH
RVRfSU5GTykKIAogI2Vsc2UgLyogQ09ORklHX1VTRVJfT05MWSAqLwogCiAjaW5jbHVkZSAicWVt
dS90YXJnZXQtaW5mby1xb20uaCIKLSNpbmNsdWRlICJxb20vb2JqZWN0LmgiCiAKICNkZWZpbmUg
dGFyZ2V0X2luZm9faW5pdCh0aV92YXIpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBcCiBzdGF0aWMgY29uc3QgVHlwZUluZm8gdGFyZ2V0X2luZm9fcW9tX3Rhcmdl
dF90eXBlX2luZm8gPSB7ICAgICAgICAgICAgICAgICAgXApkaWZmIC0tZ2l0IGEvaW5jbHVkZS9x
ZW11L3RhcmdldC1pbmZvLmggYi9pbmNsdWRlL3FlbXUvdGFyZ2V0LWluZm8uaAppbmRleCBiMjNl
NWJjNTg2NS4uZjZhODJiZTYyOTAgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvcWVtdS90YXJnZXQtaW5m
by5oCisrKyBiL2luY2x1ZGUvcWVtdS90YXJnZXQtaW5mby5oCkBAIC05LDYgKzksMTAgQEAKICNp
Zm5kZWYgUUVNVV9UQVJHRVRfSU5GT19ICiAjZGVmaW5lIFFFTVVfVEFSR0VUX0lORk9fSAogCisj
aW5jbHVkZSA8c3RkYm9vbC5oPgorCit0eXBlZGVmIHN0cnVjdCBUYXJnZXRJbmZvIFRhcmdldElu
Zm87CisKIC8qKgogICogdGFyZ2V0X25hbWU6CiAgKgpAQCAtNDQsNTggKzQ4LDY2IEBAIGJvb2wg
dGFyZ2V0X2JpZ19lbmRpYW4odm9pZCk7CiAKIC8qKgogICogdGFyZ2V0X2Jhc2VfYXJtOgorICog
QHRpOiBUYXJnZXRJbmZvIHRvIHRlc3QuCiAgKgotICogUmV0dXJucyB3aGV0aGVyIHRoZSB0YXJn
ZXQgYXJjaGl0ZWN0dXJlIGlzIEFSTSBvciBBYXJjaDY0LgorICogUmV0dXJucyB3aGV0aGVyIEB0
aSBpcyBBUk0gb3IgQUFyY2g2NC4KICAqLwotYm9vbCB0YXJnZXRfYmFzZV9hcm0odm9pZCk7Citi
b29sIHRhcmdldF9iYXNlX2FybShjb25zdCBUYXJnZXRJbmZvICp0aSk7CiAKIC8qKgogICogdGFy
Z2V0X2FybToKKyAqIEB0aTogVGFyZ2V0SW5mbyB0byB0ZXN0LgogICoKLSAqIFJldHVybnMgd2hl
dGhlciB0aGUgdGFyZ2V0IGFyY2hpdGVjdHVyZSBpcyBBUk0gKDMyLWJpdCwgbm90IEFhcmNoNjQp
LgorICogUmV0dXJucyB3aGV0aGVyIEB0aSBpcyBBUk0gKDMyLWJpdCwgbm90IEFBcmNoNjQpLgog
ICovCi1ib29sIHRhcmdldF9hcm0odm9pZCk7Citib29sIHRhcmdldF9hcm0oY29uc3QgVGFyZ2V0
SW5mbyAqdGkpOwogCiAvKioKICAqIHRhcmdldF9hYXJjaDY0OgorICogQHRpOiBUYXJnZXRJbmZv
IHRvIHRlc3QuCiAgKgotICogUmV0dXJucyB3aGV0aGVyIHRoZSB0YXJnZXQgYXJjaGl0ZWN0dXJl
IGlzIEFhcmNoNjQuCisgKiBSZXR1cm5zIHdoZXRoZXIgQHRpIGlzIEFBcmNoNjQuCiAgKi8KLWJv
b2wgdGFyZ2V0X2FhcmNoNjQodm9pZCk7Citib29sIHRhcmdldF9hYXJjaDY0KGNvbnN0IFRhcmdl
dEluZm8gKnRpKTsKIAogLyoqCiAgKiB0YXJnZXRfYmFzZV9wcGM6CisgKiBAdGk6IFRhcmdldElu
Zm8gdG8gdGVzdC4KICAqCi0gKiBSZXR1cm5zIHdoZXRoZXIgdGhlIHRhcmdldCBhcmNoaXRlY3R1
cmUgaXMgUG93ZXJQQyAzMi1iaXQgb3IgNjQtYml0LgorICogUmV0dXJucyB3aGV0aGVyIEB0aSBp
cyBQb3dlclBDIDMyLWJpdCBvciA2NC1iaXQuCiAgKi8KLWJvb2wgdGFyZ2V0X2Jhc2VfcHBjKHZv
aWQpOworYm9vbCB0YXJnZXRfYmFzZV9wcGMoY29uc3QgVGFyZ2V0SW5mbyAqdGkpOwogCiAvKioK
ICAqIHRhcmdldF9wcGM6CisgKiBAdGk6IFRhcmdldEluZm8gdG8gdGVzdC4KICAqCi0gKiBSZXR1
cm5zIHdoZXRoZXIgdGhlIHRhcmdldCBhcmNoaXRlY3R1cmUgaXMgUG93ZXJQQyAzMi1iaXQuCisg
KiBSZXR1cm5zIHdoZXRoZXIgQHRpIGlzIFBvd2VyUEMgMzItYml0LgogICovCi1ib29sIHRhcmdl
dF9wcGModm9pZCk7Citib29sIHRhcmdldF9wcGMoY29uc3QgVGFyZ2V0SW5mbyAqdGkpOwogCiAv
KioKICAqIHRhcmdldF9wcGM2NDoKKyAqIEB0aTogVGFyZ2V0SW5mbyB0byB0ZXN0LgogICoKLSAq
IFJldHVybnMgd2hldGhlciB0aGUgdGFyZ2V0IGFyY2hpdGVjdHVyZSBpcyBQb3dlclBDIDY0LWJp
dC4KKyAqIFJldHVybnMgd2hldGhlciBAdGkgaXMgUG93ZXJQQyA2NC1iaXQuCiAgKi8KLWJvb2wg
dGFyZ2V0X3BwYzY0KHZvaWQpOworYm9vbCB0YXJnZXRfcHBjNjQoY29uc3QgVGFyZ2V0SW5mbyAq
dGkpOwogCiAvKioKICAqIHRhcmdldF9zMzkweDoKKyAqIEB0aTogVGFyZ2V0SW5mbyB0byB0ZXN0
LgogICoKLSAqIFJldHVybnMgd2hldGhlciB0aGUgdGFyZ2V0IGFyY2hpdGVjdHVyZSBpcyBTMzkw
eC4KKyAqIFJldHVybnMgd2hldGhlciBAdGkgaXMgUzM5MHguCiAgKi8KLWJvb2wgdGFyZ2V0X3Mz
OTB4KHZvaWQpOworYm9vbCB0YXJnZXRfczM5MHgoY29uc3QgVGFyZ2V0SW5mbyAqdGkpOwogCiAv
KioKICAqIHRhcmdldF9yaXNjdjY0OgorICogQHRpOiBUYXJnZXRJbmZvIHRvIHRlc3QuCiAgKgot
ICogUmV0dXJucyB3aGV0aGVyIHRoZSB0YXJnZXQgYXJjaGl0ZWN0dXJlIGlzIHJpc2N2NjQKKyAq
IFJldHVybnMgd2hldGhlciBAdGkgaXMgUklTQy1WIDY0LWJpdC4KICAqLwotYm9vbCB0YXJnZXRf
cmlzY3Y2NCh2b2lkKTsKK2Jvb2wgdGFyZ2V0X3Jpc2N2NjQoY29uc3QgVGFyZ2V0SW5mbyAqdGkp
OwogCiAjZW5kaWYKZGlmZiAtLWdpdCBhL2luY2x1ZGUvcW9tL29iamVjdC5oIGIvaW5jbHVkZS9x
b20vb2JqZWN0LmgKaW5kZXggN2VjZDBmMjEwZmIuLmFlYjE4NzExNDZiIDEwMDY0NAotLS0gYS9p
bmNsdWRlL3FvbS9vYmplY3QuaAorKysgYi9pbmNsdWRlL3FvbS9vYmplY3QuaApAQCAtMTE3LDYg
KzExNyw0MiBAQCB0eXBlZGVmIHZvaWQgKE9iamVjdFVucGFyZW50KShPYmplY3QgKm9iaik7CiAg
Ki8KIHR5cGVkZWYgdm9pZCAoT2JqZWN0RnJlZSkodm9pZCAqb2JqKTsKIAordHlwZWRlZiBzdHJ1
Y3QgVGFyZ2V0SW5mbyBUYXJnZXRJbmZvOworCisvKioKKyAqIHRhcmdldF9pbmZvOgorICoKKyAq
IFJldHVybnM6IFRoZSBjdXJyZW50IFRhcmdldEluZm8uIEJlZm9yZSB0YXJnZXRfaW5mb19zZWxl
Y3QoKSwgdGhlCisgKiBkZWZhdWx0IHVzZXMgU1lTX0VNVV9UQVJHRVRfTk9ORS4KKyAqLworY29u
c3QgVGFyZ2V0SW5mbyAqdGFyZ2V0X2luZm8odm9pZCk7CisKKy8qKgorICogdGFyZ2V0X2luZm9f
c2VsZWN0OgorICogQHRpOiBUYXJnZXRJbmZvIHRvIHNlbGVjdAorICoKKyAqIFNldHMgdGhlIFRh
cmdldEluZm8gcmV0dXJuZWQgYnkgdGFyZ2V0X2luZm8oKS4gTXVzdCBiZSBjYWxsZWQgb25seQor
ICogb25jZS4gQHRpIG11c3Qgbm90IGJlIE5VTEwgYW5kIG11c3Qgbm90IHVzZSBTWVNfRU1VX1RB
UkdFVF9OT05FLgorICovCit2b2lkIHRhcmdldF9pbmZvX3NlbGVjdChjb25zdCBUYXJnZXRJbmZv
ICp0aSk7CisKKy8qKgorICogdHlwZWRlZiBUeXBlSXNBdmFpbGFibGU6CisgKiBAdGk6IFRhcmdl
dEluZm8gdG8gdGVzdC4KKyAqCisgKiBSZXR1cm5zIHdoZXRoZXIgYSB0eXBlIGlzIGF2YWlsYWJs
ZSBmb3IgQHRpLiBUeXBpY2FsIGltcGxlbWVudGF0aW9ucworICogYXJlIHRhcmdldF8qKCkuCisg
KgorICogQXQgcmVnaXN0cmF0aW9uLCBRT00gY2FsbHMgdGhpcyB3aXRoIHRhcmdldF9pbmZvKCkg
YWZ0ZXIKKyAqIHRhcmdldF9pbmZvX3NlbGVjdCgpLiBJdCBpcyBza2lwcGVkIHVudGlsIGEgVGFy
Z2V0SW5mbyBpcyBzZWxlY3RlZC4KKyAqCisgKiBCZWZvcmUgYSBUYXJnZXRJbmZvIGlzIHNlbGVj
dGVkLCBjYWxsZXJzIG1heSBpbnZva2UgdGhpcyB3aXRoIGEKKyAqIGN1c3RvbSBUYXJnZXRJbmZv
IHRvIGxpc3Qgd2hldGhlciBhIHR5cGUgYmVsb25ncyB0byB0aGF0IHRhcmdldC4KKyAqIEZvciBl
eGFtcGxlLCBhIG1hY2hpbmUgdHlwZSBtYXkgbWF0Y2ggYSBzcGVjaWZpYyBsaXN0IG9mIHRhcmdl
dAorICogbmFtZXMuCisgKi8KK3R5cGVkZWYgYm9vbCAoVHlwZUlzQXZhaWxhYmxlKShjb25zdCBU
YXJnZXRJbmZvICp0aSk7CisKICNkZWZpbmUgT0JKRUNUX0NMQVNTX0NBU1RfQ0FDSEUgNAogCiAv
KioKQEAgLTQ2OSw4ICs1MDUsMTAgQEAgc3RydWN0IE9iamVjdAogICogQGNsYXNzX2RhdGE6IERh
dGEgdG8gcGFzcyB0byB0aGUgQGNsYXNzX2luaXQsCiAgKiAgIEBjbGFzc19iYXNlX2luaXQuIFRo
aXMgY2FuIGJlIHVzZWZ1bCB3aGVuIGJ1aWxkaW5nIGR5bmFtaWMKICAqICAgY2xhc3Nlcy4KLSAq
IEBpc19hdmFpbGFibGU6IGNhbGxiYWNrIGludm9rZWQgYXQgcmVnaXN0cmF0aW9uIHRpbWUsIHRv
IGR5bmFtaWNhbGx5IGNoZWNrIGlmCi0gKiAgIHRoaXMgdHlwZSBzaG91bGQgYmUgYXZhaWxhYmxl
IG9yIG5vdC4KKyAqIEBpc19hdmFpbGFibGU6IGNhbGxiYWNrIGludm9rZWQgYXQgcmVnaXN0cmF0
aW9uIHRpbWUgd2l0aAorICogICB0YXJnZXRfaW5mbygpIGFmdGVyIHRhcmdldF9pbmZvX3NlbGVj
dCgpLCB0byBkeW5hbWljYWxseSBjaGVjayBpZgorICogICB0aGlzIHR5cGUgc2hvdWxkIGJlIGF2
YWlsYWJsZS4gU2tpcHBlZCB1bnRpbCBhIFRhcmdldEluZm8gaXMKKyAqICAgc2VsZWN0ZWQuIExp
c3RpbmcgY29kZSBtYXkgY2FsbCBpdCB3aXRoIGEgc3BlY2lmaWMgVGFyZ2V0SW5mby4KICAqIEBp
bnRlcmZhY2VzOiBUaGUgbGlzdCBvZiBpbnRlcmZhY2VzIGFzc29jaWF0ZWQgd2l0aCB0aGlzIHR5
cGUuICBUaGlzCiAgKiAgIHNob3VsZCBwb2ludCB0byBhIHN0YXRpYyBhcnJheSB0aGF0J3MgdGVy
bWluYXRlZCB3aXRoIGEgemVybyBmaWxsZWQKICAqICAgZWxlbWVudC4KQEAgLTQ5Myw3ICs1MzEs
NyBAQCBzdHJ1Y3QgVHlwZUluZm8KICAgICB2b2lkICgqY2xhc3NfYmFzZV9pbml0KShPYmplY3RD
bGFzcyAqa2xhc3MsIGNvbnN0IHZvaWQgKmRhdGEpOwogICAgIGNvbnN0IHZvaWQgKmNsYXNzX2Rh
dGE7CiAKLSAgICBib29sICgqaXNfYXZhaWxhYmxlKSh2b2lkKTsKKyAgICBUeXBlSXNBdmFpbGFi
bGUgKmlzX2F2YWlsYWJsZTsKICAgICBjb25zdCBJbnRlcmZhY2VJbmZvICppbnRlcmZhY2VzOwog
fTsKIApAQCAtMTA2Niw2ICsxMTA0LDE1IEBAIE9iamVjdENsYXNzICpvYmplY3RfY2xhc3NfZ2V0
X3BhcmVudChPYmplY3RDbGFzcyAqa2xhc3MpOwogICovCiBjb25zdCBjaGFyICpvYmplY3RfY2xh
c3NfZ2V0X25hbWUoT2JqZWN0Q2xhc3MgKmtsYXNzKTsKIAorLyoqCisgKiBvYmplY3RfY2xhc3Nf
Z2V0X2lzX2F2YWlsYWJsZToKKyAqIEBrbGFzczogVGhlIGNsYXNzIHRvIG9idGFpbiBUeXBlSW5m
by5pc19hdmFpbGFibGUgZm9yLgorICoKKyAqIFJldHVybnM6IFRoZSBhdmFpbGFiaWxpdHkgY2Fs
bGJhY2ssIG9yICVOVUxMIGlmIHRoZSB0eXBlIGlzIGFsd2F5cworICogYXZhaWxhYmxlLgorICov
CitUeXBlSXNBdmFpbGFibGUgKm9iamVjdF9jbGFzc19nZXRfaXNfYXZhaWxhYmxlKE9iamVjdENs
YXNzICprbGFzcyk7CisKIC8qKgogICogb2JqZWN0X2NsYXNzX2lzX2Fic3RyYWN0OgogICogQGts
YXNzOiBUaGUgY2xhc3MgdG8gb2J0YWluIHRoZSBhYnN0cmFjdG5lc3MgZm9yLgpkaWZmIC0tZ2l0
IGEvbGludXgtdXNlci9tYWluLmMgYi9saW51eC11c2VyL21haW4uYwppbmRleCA2MGE2OTViN2Nh
My4uMzZkNWM2ZGVkNGYgMTAwNjQ0Ci0tLSBhL2xpbnV4LXVzZXIvbWFpbi5jCisrKyBiL2xpbnV4
LXVzZXIvbWFpbi5jCkBAIC03MDAsNiArNzAwLDcgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIg
Kiphcmd2LCBjaGFyICoqZW52cCkKICAgICBlcnJvcl9pbml0KGFyZ3ZbMF0pOwogICAgIG1vZHVs
ZV9jYWxsX2luaXQoTU9EVUxFX0lOSVRfVFJBQ0UpOwogICAgIHFlbXVfaW5pdF9jcHVfbGlzdCgp
OworICAgIG1vZHVsZV9jYWxsX2luaXQoTU9EVUxFX0lOSVRfVEFSR0VUX0lORk8pOwogICAgIG1v
ZHVsZV9jYWxsX2luaXQoTU9EVUxFX0lOSVRfUU9NKTsKIAogICAgIGVudmxpc3QgPSBlbnZsaXN0
X2NyZWF0ZSgpOwpkaWZmIC0tZ2l0IGEvcW9tL29iamVjdC5jIGIvcW9tL29iamVjdC5jCmluZGV4
IGIxODM0YTU3Y2M5Li4xNGU0YzlhMDk0YyAxMDA2NDQKLS0tIGEvcW9tL29iamVjdC5jCisrKyBi
L3FvbS9vYmplY3QuYwpAQCAtMTUsNiArMTUsOCBAQAogI2luY2x1ZGUgInFvbS9jb21wYXQtcHJv
cGVydGllcy5oIgogI2luY2x1ZGUgInFvbS9vYmplY3QuaCIKICNpbmNsdWRlICJxb20vb2JqZWN0
X2ludGVyZmFjZXMuaCIKKyNpbmNsdWRlICJxZW11L3RhcmdldC1pbmZvLWltcGwuaCIKKyNpbmNs
dWRlICJxZW11L3RhcmdldC1pbmZvLXFhcGkuaCIKICNpbmNsdWRlICJxZW11L2N1dGlscy5oIgog
I2luY2x1ZGUgInFlbXUvbWVtYWxpZ24uaCIKICNpbmNsdWRlICJxYXBpL3Zpc2l0b3IuaCIKQEAg
LTYxLDYgKzYzLDcgQEAgc3RydWN0IFR5cGVJbXBsCiAgICAgdm9pZCAoKmNsYXNzX2Jhc2VfaW5p
dCkoT2JqZWN0Q2xhc3MgKmtsYXNzLCBjb25zdCB2b2lkICpkYXRhKTsKIAogICAgIGNvbnN0IHZv
aWQgKmNsYXNzX2RhdGE7CisgICAgVHlwZUlzQXZhaWxhYmxlICppc19hdmFpbGFibGU7CiAKICAg
ICB2b2lkICgqaW5zdGFuY2VfaW5pdCkoT2JqZWN0ICpvYmopOwogICAgIHZvaWQgKCppbnN0YW5j
ZV9wb3N0X2luaXQpKE9iamVjdCAqb2JqKTsKQEAgLTgzLDYgKzg2LDMwIEBAIHN0YXRpYyBHSGFz
aFRhYmxlICp0eXBlX3RhYmxlOwogCiBzdGF0aWMgYm9vbCBlbnVtZXJhdGluZ190eXBlczsKIAor
c3RhdGljIGNvbnN0IFRhcmdldEluZm8gdGFyZ2V0X2luZm9fbm9uZSA9IHsKKyAgICAudGFyZ2V0
X2FyY2ggPSBTWVNfRU1VX1RBUkdFVF9OT05FLAorICAgIC50YXJnZXRfbmFtZSA9ICJub25lIiwK
K307CisKKy8qIFVzZSBUeXBlSW5mby5pc19hdmFpbGFibGUgYXQgcmVnaXN0cmF0aW9uIG9uY2Ug
VGFyZ2V0SW5mbyBpcyBzZWxlY3RlZC4gKi8KK3N0YXRpYyBib29sIHRhcmdldF9pbmZvX3NlbGVj
dGVkID0gZmFsc2U7CitzdGF0aWMgY29uc3QgVGFyZ2V0SW5mbyAqdGFyZ2V0X2luZm9fcHRyID0g
JnRhcmdldF9pbmZvX25vbmU7CisKK2NvbnN0IFRhcmdldEluZm8gKnRhcmdldF9pbmZvKHZvaWQp
Cit7CisgICAgcmV0dXJuIHRhcmdldF9pbmZvX3B0cjsKK30KKwordm9pZCB0YXJnZXRfaW5mb19z
ZWxlY3QoY29uc3QgVGFyZ2V0SW5mbyAqdGkpCit7CisgICAgZ19hc3NlcnQoIXRhcmdldF9pbmZv
X3NlbGVjdGVkKTsKKyAgICBnX2Fzc2VydCh0aSAhPSBOVUxMKTsKKyAgICBnX2Fzc2VydCh0aS0+
dGFyZ2V0X2FyY2ggIT0gU1lTX0VNVV9UQVJHRVRfTk9ORSk7CisKKyAgICB0YXJnZXRfaW5mb19z
ZWxlY3RlZCA9IHRydWU7CisgICAgdGFyZ2V0X2luZm9fcHRyID0gdGk7Cit9CisKIHN0YXRpYyB2
b2lkIHR5cGVfdGFibGVfYWRkKFR5cGVJbXBsICp0aSkKIHsKICAgICBhc3NlcnQoIWVudW1lcmF0
aW5nX3R5cGVzKTsKQEAgLTExNiw2ICsxNDMsNyBAQCBzdGF0aWMgVHlwZUltcGwgKnR5cGVfbmV3
KGNvbnN0IFR5cGVJbmZvICppbmZvKQogICAgIHRpLT5jbGFzc19pbml0ID0gaW5mby0+Y2xhc3Nf
aW5pdDsKICAgICB0aS0+Y2xhc3NfYmFzZV9pbml0ID0gaW5mby0+Y2xhc3NfYmFzZV9pbml0Owog
ICAgIHRpLT5jbGFzc19kYXRhID0gaW5mby0+Y2xhc3NfZGF0YTsKKyAgICB0aS0+aXNfYXZhaWxh
YmxlID0gaW5mby0+aXNfYXZhaWxhYmxlOwogCiAgICAgdGktPmluc3RhbmNlX2luaXQgPSBpbmZv
LT5pbnN0YW5jZV9pbml0OwogICAgIHRpLT5pbnN0YW5jZV9wb3N0X2luaXQgPSBpbmZvLT5pbnN0
YW5jZV9wb3N0X2luaXQ7CkBAIC0xNjMsNyArMTkxLDggQEAgc3RhdGljIFR5cGVJbXBsICp0eXBl
X3JlZ2lzdGVyX2ludGVybmFsKGNvbnN0IFR5cGVJbmZvICppbmZvKQogICAgICAgICBhYm9ydCgp
OwogICAgIH0KIAotICAgIGlmIChpbmZvLT5pc19hdmFpbGFibGUgJiYgIWluZm8tPmlzX2F2YWls
YWJsZSgpKSB7CisgICAgaWYgKHRhcmdldF9pbmZvX3NlbGVjdGVkICYmCisgICAgICAgIGluZm8t
PmlzX2F2YWlsYWJsZSAmJiAhaW5mby0+aXNfYXZhaWxhYmxlKHRhcmdldF9pbmZvKCkpKSB7CiAg
ICAgICAgIHJldHVybiBOVUxMOwogICAgIH0KIApAQCAtMTE0OSw2ICsxMTc4LDExIEBAIGNvbnN0
IGNoYXIgKm9iamVjdF9jbGFzc19nZXRfbmFtZShPYmplY3RDbGFzcyAqa2xhc3MpCiAgICAgcmV0
dXJuIGtsYXNzLT50eXBlLT5uYW1lOwogfQogCitUeXBlSXNBdmFpbGFibGUgKm9iamVjdF9jbGFz
c19nZXRfaXNfYXZhaWxhYmxlKE9iamVjdENsYXNzICprbGFzcykKK3sKKyAgICByZXR1cm4ga2xh
c3MtPnR5cGUtPmlzX2F2YWlsYWJsZTsKK30KKwogT2JqZWN0Q2xhc3MgKm9iamVjdF9jbGFzc19i
eV9uYW1lKGNvbnN0IGNoYXIgKnR5cGVuYW1lKQogewogICAgIFR5cGVJbXBsICp0eXBlID0gdHlw
ZV9nZXRfYnlfbmFtZV9ub2xvYWQodHlwZW5hbWUpOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0LWluZm8t
cW9tLmMgYi90YXJnZXQtaW5mby1xb20uYwppbmRleCA2OTY1ZTRkMTE2OS4uYWJhMWY5NTQ0OTYg
MTAwNjQ0Ci0tLSBhL3RhcmdldC1pbmZvLXFvbS5jCisrKyBiL3RhcmdldC1pbmZvLXFvbS5jCkBA
IC0zMywxMyArMzMsNiBAQCBzdGF0aWMgY29uc3QgVHlwZUluZm8gdGFyZ2V0X2luZm9fcGFyZW50
X3R5cGUgPSB7CiAKIERFRklORV9UQVJHRVRfSU5GT19UWVBFKHRhcmdldF9pbmZvX3BhcmVudF90
eXBlKQogCi1zdGF0aWMgY29uc3QgVGFyZ2V0SW5mbyAqdGFyZ2V0X2luZm9fcHRyOwotCi1jb25z
dCBUYXJnZXRJbmZvICp0YXJnZXRfaW5mbyh2b2lkKQotewotICAgIHJldHVybiB0YXJnZXRfaW5m
b19wdHI7Ci19Ci0KIHZvaWQgdGFyZ2V0X2luZm9fcW9tX3NldF90YXJnZXQodm9pZCkKIHsKICAg
ICBnX2F1dG9wdHIoR1NMaXN0KSB0YXJnZXRzID0gb2JqZWN0X2NsYXNzX2dldF9saXN0KFRZUEVf
VEFSR0VUX0lORk8sIGZhbHNlKTsKQEAgLTUxLDUgKzQ0LDUgQEAgdm9pZCB0YXJnZXRfaW5mb19x
b21fc2V0X3RhcmdldCh2b2lkKQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIm1v
cmUgdGhhbiBvbmUgdGFyZ2V0LWluZm8gaXMgYXZhaWxhYmxlIik7CiAgICAgfQogCi0gICAgdGFy
Z2V0X2luZm9fcHRyID0gVEFSR0VUX0lORk9fQ0xBU1ModGFyZ2V0cy0+ZGF0YSktPnRhcmdldF9p
bmZvOworICAgIHRhcmdldF9pbmZvX3NlbGVjdChUQVJHRVRfSU5GT19DTEFTUyh0YXJnZXRzLT5k
YXRhKS0+dGFyZ2V0X2luZm8pOwogfQpkaWZmIC0tZ2l0IGEvdGFyZ2V0LWluZm8uYyBiL3Rhcmdl
dC1pbmZvLmMKaW5kZXggMDEyYjM4NDAzNmQuLmI2OTBiYTE0ZTZmIDEwMDY0NAotLS0gYS90YXJn
ZXQtaW5mby5jCisrKyBiL3RhcmdldC1pbmZvLmMKQEAgLTQyLDkgKzQyLDkgQEAgYm9vbCB0YXJn
ZXRfYmlnX2VuZGlhbih2b2lkKQogICAgIHJldHVybiB0YXJnZXRfZW5kaWFuX21vZGUoKSA9PSBF
TkRJQU5fTU9ERV9CSUc7CiB9CiAKLWJvb2wgdGFyZ2V0X2Jhc2VfYXJtKHZvaWQpCitib29sIHRh
cmdldF9iYXNlX2FybShjb25zdCBUYXJnZXRJbmZvICp0aSkKIHsKLSAgICBzd2l0Y2ggKHRhcmdl
dF9hcmNoKCkpIHsKKyAgICBzd2l0Y2ggKHRpLT50YXJnZXRfYXJjaCkgewogICAgIGNhc2UgU1lT
X0VNVV9UQVJHRVRfQVJNOgogICAgIGNhc2UgU1lTX0VNVV9UQVJHRVRfQUFSQ0g2NDoKICAgICAg
ICAgcmV0dXJuIHRydWU7CkBAIC01MywxOSArNTMsMTkgQEAgYm9vbCB0YXJnZXRfYmFzZV9hcm0o
dm9pZCkKICAgICB9CiB9CiAKLWJvb2wgdGFyZ2V0X2FybSh2b2lkKQorYm9vbCB0YXJnZXRfYXJt
KGNvbnN0IFRhcmdldEluZm8gKnRpKQogewotICAgIHJldHVybiB0YXJnZXRfYXJjaCgpID09IFNZ
U19FTVVfVEFSR0VUX0FSTTsKKyAgICByZXR1cm4gdGktPnRhcmdldF9hcmNoID09IFNZU19FTVVf
VEFSR0VUX0FSTTsKIH0KIAotYm9vbCB0YXJnZXRfYWFyY2g2NCh2b2lkKQorYm9vbCB0YXJnZXRf
YWFyY2g2NChjb25zdCBUYXJnZXRJbmZvICp0aSkKIHsKLSAgICByZXR1cm4gdGFyZ2V0X2FyY2go
KSA9PSBTWVNfRU1VX1RBUkdFVF9BQVJDSDY0OworICAgIHJldHVybiB0aS0+dGFyZ2V0X2FyY2gg
PT0gU1lTX0VNVV9UQVJHRVRfQUFSQ0g2NDsKIH0KIAotYm9vbCB0YXJnZXRfYmFzZV9wcGModm9p
ZCkKK2Jvb2wgdGFyZ2V0X2Jhc2VfcHBjKGNvbnN0IFRhcmdldEluZm8gKnRpKQogewotICAgIHN3
aXRjaCAodGFyZ2V0X2FyY2goKSkgeworICAgIHN3aXRjaCAodGktPnRhcmdldF9hcmNoKSB7CiAg
ICAgY2FzZSBTWVNfRU1VX1RBUkdFVF9QUEM6CiAgICAgY2FzZSBTWVNfRU1VX1RBUkdFVF9QUEM2
NDoKICAgICAgICAgcmV0dXJuIHRydWU7CkBAIC03NCwyMiArNzQsMjIgQEAgYm9vbCB0YXJnZXRf
YmFzZV9wcGModm9pZCkKICAgICB9CiB9CiAKLWJvb2wgdGFyZ2V0X3BwYyh2b2lkKQorYm9vbCB0
YXJnZXRfcHBjKGNvbnN0IFRhcmdldEluZm8gKnRpKQogewotICAgIHJldHVybiB0YXJnZXRfYXJj
aCgpID09IFNZU19FTVVfVEFSR0VUX1BQQzsKKyAgICByZXR1cm4gdGktPnRhcmdldF9hcmNoID09
IFNZU19FTVVfVEFSR0VUX1BQQzsKIH0KIAotYm9vbCB0YXJnZXRfcHBjNjQodm9pZCkKK2Jvb2wg
dGFyZ2V0X3BwYzY0KGNvbnN0IFRhcmdldEluZm8gKnRpKQogewotICAgIHJldHVybiB0YXJnZXRf
YXJjaCgpID09IFNZU19FTVVfVEFSR0VUX1BQQzY0OworICAgIHJldHVybiB0aS0+dGFyZ2V0X2Fy
Y2ggPT0gU1lTX0VNVV9UQVJHRVRfUFBDNjQ7CiB9CiAKLWJvb2wgdGFyZ2V0X3MzOTB4KHZvaWQp
Citib29sIHRhcmdldF9zMzkweChjb25zdCBUYXJnZXRJbmZvICp0aSkKIHsKLSAgICByZXR1cm4g
dGFyZ2V0X2FyY2goKSA9PSBTWVNfRU1VX1RBUkdFVF9TMzkwWDsKKyAgICByZXR1cm4gdGktPnRh
cmdldF9hcmNoID09IFNZU19FTVVfVEFSR0VUX1MzOTBYOwogfQogCi1ib29sIHRhcmdldF9yaXNj
djY0KHZvaWQpCitib29sIHRhcmdldF9yaXNjdjY0KGNvbnN0IFRhcmdldEluZm8gKnRpKQogewot
ICAgIHJldHVybiB0YXJnZXRfYXJjaCgpID09IFNZU19FTVVfVEFSR0VUX1JJU0NWNjQ7CisgICAg
cmV0dXJuIHRpLT50YXJnZXRfYXJjaCA9PSBTWVNfRU1VX1RBUkdFVF9SSVNDVjY0OwogfQpkaWZm
IC0tZ2l0IGEvdGFyZ2V0L2FybS9jcHUtbWF4LmMgYi90YXJnZXQvYXJtL2NwdS1tYXguYwppbmRl
eCA3Mzk1MDBhMDRmYy4uZTBjZDhmZDY1ZTYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9hcm0vY3B1LW1h
eC5jCisrKyBiL3RhcmdldC9hcm0vY3B1LW1heC5jCkBAIC05NCw3ICs5NCw3IEBAIHZvaWQgYWFy
Y2g2NF9hYTMyX2E1N19pbml0KEFSTUNQVSAqY3B1LCBib29sIGFhcmNoNjRfZW5hYmxlZCkKIHN0
YXRpYyB2b2lkIGNwdV9tYXhfaW5pdGZuKE9iamVjdCAqb2JqKQogewogICAgIEFSTUNQVSAqY3B1
ID0gQVJNX0NQVShvYmopOwotICAgIGNvbnN0IGJvb2wgYWFyY2g2NF9lbmFibGVkID0gdGFyZ2V0
X2FhcmNoNjQoKTsKKyAgICBjb25zdCBib29sIGFhcmNoNjRfZW5hYmxlZCA9IHRhcmdldF9hYXJj
aDY0KHRhcmdldF9pbmZvKCkpOwogCiAgICAgaWYgKGh3YWNjZWxfZW5hYmxlZCgpKSB7CiAgICAg
ICAgIGFzc2VydChhYXJjaDY0X2VuYWJsZWQpOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2FybS90Y2cv
Y3B1LW1heC12OC5jIGIvdGFyZ2V0L2FybS90Y2cvY3B1LW1heC12OC5jCmluZGV4IDY1Zjg1MWYy
MDA2Li5lMjRjYjQxODM3MyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2FybS90Y2cvY3B1LW1heC12OC5j
CisrKyBiL3RhcmdldC9hcm0vdGNnL2NwdS1tYXgtdjguYwpAQCAtMTI1LDYgKzEyNSw2IEBAIHN0
YXRpYyB2b2lkIGNwdV9tYXhfdjhfcmVnaXN0ZXJfdHlwZSh2b2lkKQogICAgICAgICB7IC5uYW1l
ID0gIm1heC12OCIsIC5pbml0Zm4gPSBhYXJjaDMyX21heF92OF90Y2dfaW5pdGZuIH0sCiAgICAg
ICAgIHsgLm5hbWUgPSAibWF4LXY4IiwgLmluaXRmbiA9IGFhcmNoNjRfbWF4X3Y4X3RjZ19pbml0
Zm4gfSwKICAgICB9OwotICAgIGFybV9jcHVfcmVnaXN0ZXIoJm1heF92OFt0YXJnZXRfYWFyY2g2
NCgpXSk7CisgICAgYXJtX2NwdV9yZWdpc3RlcigmbWF4X3Y4W3RhcmdldF9hYXJjaDY0KHRhcmdl
dF9pbmZvKCkpXSk7CiB9CiB0eXBlX2luaXQoY3B1X21heF92OF9yZWdpc3Rlcl90eXBlKQotLSAK
Mi41Mi4wLndpbmRvd3MuMQoK
--000000000000128c22065a91b0eb
Content-Type: text/plain; charset="US-ASCII"; 
	name="0003-system-vl-group-M-help-by-TargetInfo.patch"
Content-Disposition: attachment; 
	filename="0003-system-vl-group-M-help-by-TargetInfo.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mtldwhwq0>
X-Attachment-Id: f_mtldwhwq0

RnJvbSA5OTFlMzEyZDRjZmNkODZkZDU3ZGIxMzc1ZDQzY2QyOTZmMDY2NzlhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZb25nZ2FuZyBMdW8gPGx1b3lvbmdnYW5nQGdtYWlsLmNvbT4K
RGF0ZTogVGh1LCAzIFNlcCAyMDI2IDE2OjMwOjQwICswODAwClN1YmplY3Q6IFtQQVRDSCAzLzNd
IHN5c3RlbS92bDogZ3JvdXAgLU0gaGVscCBieSBUYXJnZXRJbmZvCgotIEZvciBxZW11LXN5c3Rl
bSB3aXRoIG5vIHNlbGVjdGVkIHRhcmdldCwgcHJpbnQgdGhlIG5vbmUgVGFyZ2V0SW5mbwogIGZp
cnN0LCB0aGVuIGVhY2ggcmVnaXN0ZXJlZCBUWVBFX1RBUkdFVF9JTkZPIHNlY3Rpb24uCi0gTWFj
aGluZXMgd2l0aCBubyBUeXBlSW5mby5pc19hdmFpbGFibGUgc3RheSBpbiB0aGUgbm9uZSBncm91
cC4KICBNYWNoaW5lcyB3aXRoIGEgY2FsbGJhY2sgYXBwZWFyIG9ubHkgdW5kZXIgdGFyZ2V0cyBp
dCBhY2NlcHRzLgotIFNpbmdsZS10YXJnZXQgYmluYXJpZXMgKGV4ZSBuYW1lIG9yIC10YXJnZXQp
IGxpc3QgcmVnaXN0ZXJlZAogIG1hY2hpbmVzIHdpdGhvdXQgYSBzZWN0aW9uIGhlYWRlciBhbmQg
d2l0aG91dCByZS1jaGVja2luZwogIGlzX2F2YWlsYWJsZSwgc2luY2UgUU9NIGFscmVhZHkgZmls
dGVyZWQgdHlwZXMgYXQgcmVnaXN0cmF0aW9uLgotLS0KIHN5c3RlbS92bC5jIHwgNTQgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3N5
c3RlbS92bC5jIGIvc3lzdGVtL3ZsLmMKaW5kZXggMWIyMmEzNThkMjMuLjAzYWZiNmRiNDUyIDEw
MDY0NAotLS0gYS9zeXN0ZW0vdmwuYworKysgYi9zeXN0ZW0vdmwuYwpAQCAtMTU2NCwxMCArMTU2
NCw0NiBAQCBzdGF0aWMgZ2ludCBtYWNoaW5lX2NsYXNzX2NtcChnY29uc3Rwb2ludGVyIGEsIGdj
b25zdHBvaW50ZXIgYiwgZ3BvaW50ZXIgZCkKICAgICAgICAgICAgICAgICAgIG9iamVjdF9jbGFz
c19nZXRfbmFtZShPQkpFQ1RfQ0xBU1MobWMxKSkpOwogfQogCitzdGF0aWMgdm9pZCBtYWNoaW5l
X2hlbHBfcHJpbnRfdGFyZ2V0KEdTTGlzdCAqbWFjaGluZXMsIGNvbnN0IFRhcmdldEluZm8gKnRp
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIHByaW50X2hlYWRl
cikKK3sKKyAgICBib29sIHByaW50ZWQgPSBmYWxzZTsKKyAgICBHU0xpc3QgKmVsOworCisgICAg
Zm9yIChlbCA9IG1hY2hpbmVzOyBlbDsgZWwgPSBlbC0+bmV4dCkgeworICAgICAgICBNYWNoaW5l
Q2xhc3MgKm1jID0gZWwtPmRhdGE7CisgICAgICAgIGlmIChwcmludF9oZWFkZXIpIHsKKyAgICAg
ICAgICAgIFR5cGVJc0F2YWlsYWJsZSAqaXNfYXZhaWxhYmxlID0KKyAgICAgICAgICAgICAgICBv
YmplY3RfY2xhc3NfZ2V0X2lzX2F2YWlsYWJsZShPQkpFQ1RfQ0xBU1MobWMpKTsKKworICAgICAg
ICAgICAgaWYgKGlzX2F2YWlsYWJsZSkgeworICAgICAgICAgICAgICAgIGlmICghaXNfYXZhaWxh
YmxlKHRpKSkgeworICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsKKyAgICAgICAgICAgICAg
ICB9CisgICAgICAgICAgICB9IGVsc2UgaWYgKHRpLT50YXJnZXRfYXJjaCAhPSBTWVNfRU1VX1RB
UkdFVF9OT05FKSB7CisgICAgICAgICAgICAgICAgY29udGludWU7CisgICAgICAgICAgICB9Cisg
ICAgICAgICAgICBpZiAoIXByaW50ZWQpIHsKKyAgICAgICAgICAgICAgICBwcmludGYoIiVzOlxu
IiwgdGktPnRhcmdldF9uYW1lKTsKKyAgICAgICAgICAgICAgICBwcmludGVkID0gdHJ1ZTsKKyAg
ICAgICAgICAgIH0KKyAgICAgICAgfQorICAgICAgICBpZiAobWMtPmFsaWFzKSB7CisgICAgICAg
ICAgICBwcmludGYoIiUtMjBzICVzIChhbGlhcyBvZiAlcylcbiIsIG1jLT5hbGlhcywgbWMtPmRl
c2MsIG1jLT5uYW1lKTsKKyAgICAgICAgfQorICAgICAgICBwcmludGYoIiUtMjBzICVzJXMlc1xu
IiwgbWMtPm5hbWUsIG1jLT5kZXNjLAorICAgICAgICAgICAgICAgbWMtPmlzX2RlZmF1bHQgPyAi
IChkZWZhdWx0KSIgOiAiIiwKKyAgICAgICAgICAgICAgIG1jLT5kZXByZWNhdGlvbl9yZWFzb24g
PyAiIChkZXByZWNhdGVkKSIgOiAiIik7CisgICAgfQorCisgICAgaWYgKHByaW50X2hlYWRlcikg
eworICAgICAgICBwcmludGYoIlxuIik7CisgICAgfQorfQorCiBzdGF0aWMgdm9pZCBtYWNoaW5l
X2hlbHBfZnVuYyhjb25zdCBRRGljdCAqcWRpY3QpCiB7CiAgICAgZ19hdXRvcHRyKEdTTGlzdCkg
bWFjaGluZXMgPSBOVUxMOwotICAgIEdTTGlzdCAqZWw7CiAgICAgY29uc3QgY2hhciAqdHlwZSA9
IHFkaWN0X2dldF90cnlfc3RyKHFkaWN0LCAidHlwZSIpOwogCiAgICAgbWFjaGluZXMgPSBvYmpl
Y3RfY2xhc3NfZ2V0X2xpc3QoVFlQRV9NQUNISU5FLCBmYWxzZSk7CkBAIC0xNTgxLDE0ICsxNjE3
LDE2IEBAIHN0YXRpYyB2b2lkIG1hY2hpbmVfaGVscF9mdW5jKGNvbnN0IFFEaWN0ICpxZGljdCkK
IAogICAgIHByaW50ZigiU3VwcG9ydGVkIG1hY2hpbmVzIGFyZTpcbiIpOwogICAgIG1hY2hpbmVz
ID0gZ19zbGlzdF9zb3J0X3dpdGhfZGF0YShtYWNoaW5lcywgbWFjaGluZV9jbGFzc19jbXAsIE5V
TEwpOwotICAgIGZvciAoZWwgPSBtYWNoaW5lczsgZWw7IGVsID0gZWwtPm5leHQpIHsKLSAgICAg
ICAgTWFjaGluZUNsYXNzICptYyA9IGVsLT5kYXRhOwotICAgICAgICBpZiAobWMtPmFsaWFzKSB7
Ci0gICAgICAgICAgICBwcmludGYoIiUtMjBzICVzIChhbGlhcyBvZiAlcylcbiIsIG1jLT5hbGlh
cywgbWMtPmRlc2MsIG1jLT5uYW1lKTsKKyAgICBpZiAodGFyZ2V0X2luZm8oKS0+dGFyZ2V0X2Fy
Y2ggPT0gU1lTX0VNVV9UQVJHRVRfTk9ORSkgeworICAgICAgICBnX2F1dG9wdHIoR1NMaXN0KSB0
YXJnZXRzID0KKyAgICAgICAgICAgIG9iamVjdF9jbGFzc19nZXRfbGlzdF9zb3J0ZWQoVFlQRV9U
QVJHRVRfSU5GTywgZmFsc2UpOworICAgICAgICBtYWNoaW5lX2hlbHBfcHJpbnRfdGFyZ2V0KG1h
Y2hpbmVzLCB0YXJnZXRfaW5mbygpLCB0cnVlKTsKKyAgICAgICAgZm9yIChHU0xpc3QgKmVsZW0g
PSB0YXJnZXRzOyBlbGVtOyBlbGVtID0gZWxlbS0+bmV4dCkgeworICAgICAgICAgICAgY29uc3Qg
VGFyZ2V0SW5mbyAqdGkgPSBUQVJHRVRfSU5GT19DTEFTUyhlbGVtLT5kYXRhKS0+dGFyZ2V0X2lu
Zm87CisgICAgICAgICAgICBtYWNoaW5lX2hlbHBfcHJpbnRfdGFyZ2V0KG1hY2hpbmVzLCB0aSwg
dHJ1ZSk7CiAgICAgICAgIH0KLSAgICAgICAgcHJpbnRmKCIlLTIwcyAlcyVzJXNcbiIsIG1jLT5u
YW1lLCBtYy0+ZGVzYywKLSAgICAgICAgICAgICAgIG1jLT5pc19kZWZhdWx0ID8gIiAoZGVmYXVs
dCkiIDogIiIsCi0gICAgICAgICAgICAgICBtYy0+ZGVwcmVjYXRpb25fcmVhc29uID8gIiAoZGVw
cmVjYXRlZCkiIDogIiIpOworICAgIH0gZWxzZSB7CisgICAgICAgIG1hY2hpbmVfaGVscF9wcmlu
dF90YXJnZXQobWFjaGluZXMsIHRhcmdldF9pbmZvKCksIGZhbHNlKTsKICAgICB9CiB9CiAKLS0g
CjIuNTIuMC53aW5kb3dzLjEKCg==
--000000000000128c22065a91b0eb
Content-Type: text/plain; charset="US-ASCII"; name="0001-qapi-add-SysEmuTarget-none.patch"
Content-Disposition: attachment; 
	filename="0001-qapi-add-SysEmuTarget-none.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mtldwhx51>
X-Attachment-Id: f_mtldwhx51

RnJvbSA2NGQ0OGI1Y2E2OWNhNDVjNzIwNDBiMDcyZDU0NDA2YWRlZjE2Y2E5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZb25nZ2FuZyBMdW8gPGx1b3lvbmdnYW5nQGdtYWlsLmNvbT4K
RGF0ZTogVGh1LCAzIFNlcCAyMDI2IDEyOjQwOjA3ICswODAwClN1YmplY3Q6IFtQQVRDSCAxLzNd
IHFhcGk6IGFkZCBTeXNFbXVUYXJnZXQgbm9uZQoKLSBBZGQgU3lzRW11VGFyZ2V0IG1lbWJlciBu
b25lIGFzIHRoZSBmaXJzdCBlbnVtZXJhdG9yIChDIHZhbHVlIDApCiAgZm9yIHdoZW4gbm8gVGFy
Z2V0SW5mbyBpcyBzZWxlY3RlZC4KLSBEb2N1bWVudCB0aGF0IG5vbmUgaXMgbm90IGEgcWVtdS1z
eXN0ZW0tIGV4ZWN1dGFibGUgbmFtZS4KLS0tCiBxYXBpL21hY2hpbmUuanNvbiB8IDE1ICsrKysr
KysrKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvcWFwaS9tYWNoaW5lLmpzb24gYi9xYXBpL21hY2hpbmUuanNvbgpp
bmRleCAyZDYzYzFiYWMzYi4uZjE0YjE0NjJlZTUgMTAwNjQ0Ci0tLSBhL3FhcGkvbWFjaGluZS5q
c29uCisrKyBiL3FhcGkvbWFjaGluZS5qc29uCkBAIC0yMiw2ICsyMiwxMCBAQAogIyBUaGUgaW5k
aXZpZHVhbCB0YXJnZXQgY29uc3RhbnRzIGFyZSBub3QgZG9jdW1lbnRlZCBoZXJlLCBmb3IgdGhl
CiAjIHRpbWUgYmVpbmcuCiAjCisjIEBub25lOiBubyBUYXJnZXRJbmZvIHNlbGVjdGVkLiAgTm90
IGEgcWVtdS1zeXN0ZW0tIGV4ZWN1dGFibGUgbmFtZS4KKyMgICAgIEFsd2F5cyB0aGUgZmlyc3Qg
ZW51bWVyYXRvciAoQyB2YWx1ZSAwKS4KKyMgICAgIChzaW5jZSAxMS4yKQorIwogIyBAcng6IHNp
bmNlIDUuMAogIwogIyBAYXZyOiBzaW5jZSA1LjEKQEAgLTMwLDE1ICszNCwxNiBAQAogIwogIyBA
aGV4YWdvbjogc2luY2UgMTEuMAogIwotIyAuLiBub3RlOjogVGhlIHJlc3VsdGluZyBRTVAgc3Ry
aW5ncyBjYW4gYmUgYXBwZW5kZWQgdG8gdGhlCi0jICAgICJxZW11LXN5c3RlbS0iIHByZWZpeCB0
byBwcm9kdWNlIHRoZSBjb3JyZXNwb25kaW5nIFFFTVUKLSMgICAgZXhlY3V0YWJsZSBuYW1lLiAg
VGhpcyBpcyB0cnVlIGV2ZW4gZm9yICJxZW11LXN5c3RlbS14ODZfNjQiLgorIyAuLiBub3RlOjog
RXhjZXB0IGZvciBgYG5vbmVgYCwgdGhlIHJlc3VsdGluZyBRTVAgc3RyaW5ncyBjYW4gYmUKKyMg
ICAgYXBwZW5kZWQgdG8gdGhlICJxZW11LXN5c3RlbS0iIHByZWZpeCB0byBwcm9kdWNlIHRoZQor
IyAgICBjb3JyZXNwb25kaW5nIFFFTVUgZXhlY3V0YWJsZSBuYW1lLiAgVGhpcyBpcyB0cnVlIGV2
ZW4gZm9yCisjICAgICJxZW11LXN5c3RlbS14ODZfNjQiLgogIwogIyBTaW5jZTogMy4wCiAjIwog
eyAnZW51bScgOiAnU3lzRW11VGFyZ2V0JywKLSAgJ2RhdGEnIDogWyAnYWFyY2g2NCcsICdhbHBo
YScsICdhcm0nLCAnYXZyJywgJ2hleGFnb24nLCAnaHBwYScsICdpMzg2JywKLSAgICAgICAgICAg
ICAnbG9vbmdhcmNoNjQnLCAnbTY4aycsICdtaWNyb2JsYXplJywgJ21pcHMnLCAnbWlwczY0JywK
KyAgJ2RhdGEnIDogWyAnbm9uZScsICdhYXJjaDY0JywgJ2FscGhhJywgJ2FybScsICdhdnInLCAn
aGV4YWdvbicsICdocHBhJywKKyAgICAgICAgICAgICAnaTM4NicsICdsb29uZ2FyY2g2NCcsICdt
NjhrJywgJ21pY3JvYmxhemUnLCAnbWlwcycsICdtaXBzNjQnLAogICAgICAgICAgICAgICdtaXBz
NjRlbCcsICdtaXBzZWwnLCAnb3IxaycsICdwcGMnLAogICAgICAgICAgICAgICdwcGM2NCcsICdy
aXNjdjMyJywgJ3Jpc2N2NjQnLCAncngnLCAnczM5MHgnLCAnc2g0JywKICAgICAgICAgICAgICAn
c2g0ZWInLCAnc3BhcmMnLCAnc3BhcmM2NCcsICd0cmljb3JlJywKLS0gCjIuNTIuMC53aW5kb3dz
LjEKCg==
--000000000000128c22065a91b0eb--

