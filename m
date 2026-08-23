Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78B3C5DF8C
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 16:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyBUW-0000Mj-48; Sun, 23 Aug 2026 12:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wyBUU-0000MW-VA
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 12:56:14 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wyBUS-0007Lh-PN
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 12:56:14 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c197eaaab00so437738666b.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 09:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787504171; x=1788108971; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E3PkpzZLHXU4uuQ2YqhThC4IEBNqgSzz31m3yIWRICY=;
 b=FabKfAXJLghCkDPk4S0cGCDUuT8tJCuGrfe+y5ixSd9fZBOyP2diWLY6XrkfeQ77qT
 H4g74syGRbjcGNjgtLXdYDVAWvxt5wOdltigGcIi9IDNvzDdXItDT+cFPBOWJA85IoxV
 RWxOFp9fJ2yPSa9199xEvbDqDTPWTflliQJny8qGuq5xRf9wzlMh7hU7kZiK1XvpCaPP
 ZgKqC7Eb+gF1+4gAaJWp5eIp0iw+BnZ9OjWIKWYe3QWGWOCH15TY60D/adC77eEMc3tk
 D+RKcMtR+Dh3zMOOBgz5JihpLHoXJbizbJAs3Sxwm13Aezij6E+zXWqPI5mkXEVVWsFl
 aV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787504171; x=1788108971;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E3PkpzZLHXU4uuQ2YqhThC4IEBNqgSzz31m3yIWRICY=;
 b=U2aPjHAqNGHcpgzXngK7/F96pZLDWkmcAGmP3xwyIHlxrxRt91qJlM8O8P8GUzRZsl
 xJkd04QBsKkElev3fpB0IwC3LxmcBOhZgv3Rt8g7f116ICO676VuXce1/bCznv5Pkgyi
 BBT+2IKuWy+MjWkFYblVDUBATByPKXlbPYagYtr60eTWgis60bD/ilcjhDF4L/wbjcFL
 K6ibg3SPt4nwKHhuQATcWOry1NAjYt2DMhixad59+24aqbq0X+W/OaCr74yA/214IGfl
 fKscefjWPALvNc/BlCGWg5AcoN9s76iHODUEIlPXV/PiFw8HLPghwAb2Knc0oohVwSxy
 QVEA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4l+aQUcM5rBjGYKjfC95m2hwSWstxbY47gsmnlDLmtBSAeCe/NOyKIxMFtc8qU0cd3aNkdplPYMUN@nongnu.org
X-Gm-Message-State: AFuF++mue3MESkra83OAUYXbmIiOaPmn6OIp9LYKxkXy04jF17DkmpKX
 IAOvaPIAtXUsJQ3IgFW01WecCcAKNWAddkW+wzhKOQbvovzVmxjfOqiA
X-Gm-Gg: AR+sD10k+A3U+LiPYWaTHPuLzRA0DwWtBT0ELUAqoEIvt6SqhSElCsHlcGCNkf92SeB
 0QhmPQP//jSN1YwmKUASjXOpFKCp0s2GmmYjCOsuK3XyKrbJUNlK4EH8eqFry7jo8QwzTznbw2z
 zpXLEjB81BnkQrO9ovz9+xQhzU3iig4SxEpmdiAtzI46cQjfp0YjU70ftytLl3qT6Hy+Ctnf0c+
 XzdVkDEuWpX2TpUEH2/OF3wIod5q2QZ4giLu8xsBuTP7XGsvmV81ZmxNUVBQquY15iu8EAfWrAK
 IA4WhvoC3/M5G/fWKgiUWXQ/gFA3E4YUxg7DxaLR8Eul7lnmKSpoHQrMlQnm0pjhRyEP154Lgz3
 Sy8Y3JgFpkg3GI97FC+5RGOtFGFWrDlqUhkFzuAj9QUMJZH+nsDBfC+gqiv7Ek75aFT/hq4d7+5
 l98i2e5rqxPy6FnfKUddoKbnbI2/XG8g3t2ZkyjSOggFNF9REwMkVtmJNaJZEiiwgW+GoSpWKDW
 LG9UvjWMssVaTZAoaLXiV+yvN8W88Eqn9Sm1FYhBjwqED8dFB4=
X-Received: by 2002:a17:907:d12:b0:c24:82b9:361c with SMTP id
 a640c23a62f3a-c2482b93766mr2112785066b.17.1787504171023; 
 Sun, 23 Aug 2026 09:56:11 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (dynamic-092-224-251-016.92.224.pool.telefonica.de. [92.224.251.16])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496297189sm813517366b.22.2026.08.23.09.56.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Aug 2026 09:56:10 -0700 (PDT)
Date: Sun, 23 Aug 2026 16:56:07 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: =?US-ASCII?Q?RE=3A_=5BPATCHv2_0/7=5D_hw/arm=3A_Adding_Cortex-M7_Asym?=
 =?US-ASCII?Q?metric_Multiprocessing_boot_support_for_i=2EMX8MP?=
In-Reply-To: <C7FBB1C7-732B-4BFB-9073-CA8A44C41C3B@gmail.com>
References: <20260706162859.3361063-1-gaurav.sharma_7@nxp.com>
 <DB8PR04MB717781FAC6A65C0BE2AF1D0587CF2@DB8PR04MB7177.eurprd04.prod.outlook.com>
 <DB8PR04MB717730147C8E5B87FF57D07D87DD2@DB8PR04MB7177.eurprd04.prod.outlook.com>
 <C7FBB1C7-732B-4BFB-9073-CA8A44C41C3B@gmail.com>
Message-ID: <5496592E-1B57-420F-B87B-8070A3F7D2AA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



Am 23=2E August 2026 12:02:22 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>
>
>Am 11=2E August 2026 04:47:40 UTC schrieb Gaurav Sharma <gaurav=2Esharma_=
7@nxp=2Ecom>:
>>ping
>>
>>> -----Original Message-----
>>> From: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>>> Sent: 24 July 2026 09:32
>>> To: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>; qemu-devel@nongnu=2Eo=
rg
>>> Cc: pbonzini@redhat=2Ecom; peter=2Emaydell@linaro=2Eorg; Bernhard Besc=
how
>>> <shentey@gmail=2Ecom>
>>> Subject: RE: [PATCHv2 0/7] hw/arm: Adding Cortex-M7 Asymmetric
>>> Multiprocessing boot support for i=2EMX8MP
>>>=20
>>> Ping
>
>Hi Gurav,
>
>I finally could test your series=2E I built Buildroot's freescale_imx8mpe=
vk_defonfig (v2026=2E05) which has the required kernel options already enab=
led and passed imx8mp-evk-rpmsg=2Edtb to QEMU=2E QEMU starts successfully=
=2E However, when attempting to load an =2Eelf image to remoteproc0/firmwar=
e, I get:
>
>    # echo zephyr=2Eelf > /sys/devices/platform/imx8mp-cm7/remoteproc/rem=
oteproc0/firm
>ware=20
>    [  887=2E325597] imx-rproc imx8mp-cm7: can't change firmware while ru=
nning
>    sh: write error: Device or resource busy
>
>Checking the state results in:
>
>    # cat /sys/devices/platform/imx8mp-cm7/remoteproc/remoteproc0/state=
=20
>    attached
>
>I didn't dig into the Linux kernel sources to investigate this further=2E=
 Do you have an idea of what is missing?

Okay, I missed the -mmio change as well as the reserved regions: https://d=
ocs=2Enxp=2Ecom/bundle/AN5317/page/topics/imx_linux_rproc_support=2Ehtml =
=2E Fixed=2E

Then I set up MCUXpresso following this guide: https://mcuxpresso=2Enxp=2E=
com/mcuxsdk/latest/html/gsd/repo_setup=2Ehtml

With an ARM eabi toolchain provided by my distrubution I created the =2Eel=
f file:

    west build -b evkmimx8mp examples/driver_examples/uart/polling/ --conf=
ig ddr_release

With the apporpriate =2Edtb I get in Buildroot guest:

    # modprobe rpmsg_char
    # echo uart_polling_cm7=2Eelf > /sys/devices/platform/imx8mp-cm7/remot=
eproc/remoteproc0/firmware=20
    # echo start > /sys/devices/platform/imx8mp-cm7/remoteproc/remoteproc0=
/state=20
    [   52=2E182388] remoteproc remoteproc0: powering up imx-rproc
    [   52=2E195672] remoteproc remoteproc0: Direct firmware load for uart=
_polling_cm7=2Eelf failed with error -2
    [   52=2E195895] remoteproc remoteproc0: Falling back to sysfs fallbac=
k for: uart_polling_cm7=2Eelf
    [  113=2E748324] remoteproc remoteproc0: request_firmware failed: -110
    [  113=2E755836] remoteproc remoteproc0: Boot failed: -110
    sh: write error: Connection timed out

Any ideas?

Best regards,
Bernhard

>
>Note that I built Zephyr's imx8mp_evk for the M7 [1] which produces zephy=
r=2Eelf=2E Does the series provide everything to use Zephyr or do we need t=
o add ITCM memory? Adding a dedicated memory map including ITCM for the M7 =
core doesn't seem too complicated=2E Using Zephyr may allow for having a fu=
nctional test in our CI, though of course binary images had to be provided=
=2E
>
>Best regards,
>Bernhard
>
>[1] https://docs=2Ezephyrproject=2Eorg/latest/boards/nxp/imx8mp_evk/doc/i=
ndex=2Ehtml#programming-and-debugging-m7
>
>
>>>=20
>>> > -----Original Message-----
>>> > From: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>>> > Sent: 06 July 2026 21:59
>>> > To: qemu-devel@nongnu=2Eorg
>>> > Cc: pbonzini@redhat=2Ecom; peter=2Emaydell@linaro=2Eorg; Gaurav Shar=
ma
>>> > <gaurav=2Esharma_7@nxp=2Ecom>
>>> > Subject: [PATCHv2 0/7] hw/arm: Adding Cortex-M7 Asymmetric
>>> > Multiprocessing boot support for i=2EMX8MP
>>> >
>>> > Changes in v1:
>>> >
>>> > This series adds Asymmetric Multiprocessing (AMP) boot support for t=
he
>>> > Cortex-M7 core on the i=2EMX8MP SoC=2E The M7 firmware can be loaded=
 and
>>> > started from Linux running on the Cortex-A53 cores via the remotepro=
c
>>> > framework=2E
>>> >
>>> > The series introduces the following peripheral models needed for AMP=
:
>>> >   - GPC (General Power Controller)
>>> >   - GPR (General Purpose Registers)
>>> >   - SRC (System Reset Controller) authored by Bernhard Beschow
>>> > <shentey@gmail=2Ecom>
>>> >   - MU (Messaging Unit)
>>> >   - Extends the CCM with M7 clock outputs and wires into the i=2EMX8=
MP SoC
>>> >   - Enable Cortex-M7 boot in i=2EMX8MP EVK functional test
>>> >
>>> > Changes in v2:
>>> >
>>> > - Removed the usage of device_class_set_legacy_reset in imx8mp
>>> > gpc,gpr,mu and
>>> >   src=2E
>>> > - Removed the usage of 'smp' , 'maxcpus' and 'enable-cm7' to make th=
e
>>> >   invocation simpler=2E
>>> > - Cleaned up imx8mp_src by removing redundant/unused code=2E
>>> > - Updated Maintainers and improved the imx8mp documentation
>>> >
>>> > Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>>> >
>>> > Bernhard Beschow (1):
>>> >   hw/misc: Add SRC (System Reset Controller) to i=2EMX8MP
>>> >
>>> > Gaurav Sharma (6):
>>> >   hw/misc: Add i=2EMX8MP GPC (General Power Controller) IP
>>> >   hw/misc: Add GPR (General Purpose Register) IP to iMX8MP
>>> >   hw/misc: Add MU (Messaging Unit) IP to i=2EMX8MP device model
>>> >   hw/misc: Extend i=2EMX8MP CCM with Cortex-M7 clock outputs
>>> >   hw/arm: Enable Cortex-M7 AMP boot on i=2EMX8MP
>>> >   tests/functional: Enable Cortex-M7 boot in i=2EMX8MP EVK functiona=
l
>>> > test
>>> >
>>> >  MAINTAINERS                                 |  13 +-
>>> >  docs/system/arm/imx8m=2Erst                   | 188 ++++++++++-
>>> >  hw/arm/Kconfig                              |   4 +
>>> >  hw/arm/fsl-imx8mp=2Ec                         | 220 ++++++++++++-
>>> >  hw/arm/imx8mp-evk=2Ec                         |   3 +-
>>> >  hw/misc/Kconfig                             |  12 +
>>> >  hw/misc/imx8mp_ccm=2Ec                        |   9 +
>>> >  hw/misc/imx8mp_gpc=2Ec                        | 146 +++++++++
>>> >  hw/misc/imx8mp_gpr=2Ec                        | 153 +++++++++
>>> >  hw/misc/imx8mp_mu=2Ec                         | 328 +++++++++++++++=
+++++
>>> >  hw/misc/imx8mp_src=2Ec                        | 275 +++++++++++++++=
+
>>> >  hw/misc/meson=2Ebuild                         |   4 +
>>> >  hw/misc/trace-events                        |   5 +
>>> >  include/hw/arm/fsl-imx8mp=2Eh                 |  29 +-
>>> >  include/hw/misc/imx8mp_ccm=2Eh                |   3 +
>>> >  include/hw/misc/imx8mp_gpc=2Eh                |  34 ++
>>> >  include/hw/misc/imx8mp_gpr=2Eh                |  56 ++++
>>> >  include/hw/misc/imx8mp_mu=2Eh                 |  53 ++++
>>> >  include/hw/misc/imx8mp_src=2Eh                |  31 ++
>>> >  tests/functional/aarch64/test_imx8mp_evk=2Epy |   1 -
>>> >  20 files changed, 1539 insertions(+), 28 deletions(-)  create mode
>>> > 100644 hw/misc/imx8mp_gpc=2Ec  create mode 100644
>>> hw/misc/imx8mp_gpr=2Ec
>>> > create mode 100644 hw/misc/imx8mp_mu=2Ec  create mode 100644
>>> > hw/misc/imx8mp_src=2Ec  create mode 100644
>>> include/hw/misc/imx8mp_gpc=2Eh
>>> > create mode 100644 include/hw/misc/imx8mp_gpr=2Eh  create mode 10064=
4
>>> > include/hw/misc/imx8mp_mu=2Eh  create mode 100644
>>> > include/hw/misc/imx8mp_src=2Eh
>>> >
>>> > --
>>> > 2=2E34=2E1
>>

