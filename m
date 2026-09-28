Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE9BC9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBACR-000308-70; Mon, 28 Sep 2026 08:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xBAC0-00022j-H4
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:10:50 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xBABy-0006C0-GX
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:10:48 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ffb83bf7aso15378855e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 05:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790597444; x=1791202244; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8uLsWFBAwoNnVuqk/hxCl5YS7RooPa8d8u1LGQIXtd8=;
 b=MBHSDRXoS2G5qlFelTiWp4dNm5IiYmeIdcChasAVnqKbPZwlYcspIEsIYfXFh1I+Ij
 T7gngDgBp+lVfBsnolHAlhuBZZ7o/ssIoJws5gBcnyLzp2psTgDMMn5TZNGeEs78HVFi
 QnbesZ/fsiB322cYiR3QOgweIJDQa+jwjdOiJFlVDCN8Q/Bks4izrCm6VIZM8BZsJWix
 q1PcNqxEOOj7fgDTV0Eme/Pg7+u3JVhFnan5ORFv08P2fx5YHpFTEdL16LR90v4Wvc3O
 s17N2SSUM3lnQ+hTWtMhbSH5Ppk5XgSvyjwz9/RC4LQncdwgB9DDiGfMuHjS1Qr0+7TK
 JZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790597444; x=1791202244;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8uLsWFBAwoNnVuqk/hxCl5YS7RooPa8d8u1LGQIXtd8=;
 b=AfvcxLae9N525vUR5Qt+u0KqgMeriCZdpPqeXYVEpQBfefSh+XaZ++EjTU5zvIhlAD
 CvzxcJrRzhNsC3SmoG4H5VJuzMp9uN1kLUaH4VoEdLWJoQ4gaLpCw2Wuq2de9oAqopoZ
 gIPQTJtp8AIgj5TvS/h/ci7cqGMyr/JoYa5mLEunNfB8/q1Vlmtbg0BhN+nFNwECnEaL
 Rl+om+tuWxKucRxQtxcyefvKH5O3J6MP37Fq2ssWGU8XOtAzVci4ti3ZAKlFa5qWtOzW
 JH/WrL0rIwr7zlmCY15QOQjvIKBi918Q0/FZWNL0xf/EmRCUuN7I5yWgfCGA8KfMbO4Z
 fC8w==
X-Forwarded-Encrypted: i=1;
 AKwUvByhlreDrZPLolYM+77H+MUhmXgARMSwDkqIt/VuBS+78x5eLHzPillP40Qwk9V1++PMXEXbpC0GMuj1@nongnu.org
X-Gm-Message-State: AFuF++nXb4Auvk583J/UWiiWN1NFXgwrB2O5DXWoR3LnGlSrWZ7HBTFY
 t3S79MuIEjHKMmhoZICocWezp+E3MFPxWbj+69ZUfWjy14eX6PX7StRH
X-Gm-Gg: AYBFou3XXyQ4O9noMwoD8k8wUr5v7C2TM20Em9t+4qFJA3HEvq3bscxLJvVDtCHcK5I
 HAAAk2ifkUdoUqte4muXHucCO+8gNVvMexgw3zzgBCiwICizGPb7n7xGn7Vi8wbN2gQIpxu1TgE
 MZPnPEGSevL4mGjcZyOvDJS6IsWzKJ5bcDGjA32jXUDzd2iPSMvj3KnaUKp+3gREUFWw7fCanic
 LVjN3NsSDA4o9O85eip23sS+QDakSlXBHYY3W03P3iODT5CDANsbGmS1AX2tzmXtvxYEVr+pP3b
 3AExGX/atTkNoKEed+LQj3IQDQoMpqPXSrkmjTxi1MIIcTyu3bCt7Nj6bZzwvY3DYJGBzLI1Gsv
 WKIanuaB+0S5UYppHusCOiaCvALiZL9QDjMvxsaefBywPOj+La+vALOZ9gVy1wpvE2b8CdaZjl7
 rM0pI9XuJpZ/mNC6H14ytMsayord2MH3RI54R+18TGqwyOLixky8IJGTO5brxoQa2VcQYU2HxJ2
 /B+/odZ1QFPHPndKexKF1xrfaI+2YIKXywefFEoZES/zwvvV/IXqvrFURiD561GRA==
X-Received: by 2002:a05:600c:4754:b0:49d:1e09:694a with SMTP id
 5b1f17b1804b1-49fe66d2ce2mr231107505e9.11.1790597444170; 
 Mon, 28 Sep 2026 05:10:44 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (business-090-187-110-129.90.187.pools.vodafone-ip.de. [90.187.110.129])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-489bd7b1df0sm6670310f8f.31.2026.09.28.05.10.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 05:10:43 -0700 (PDT)
Date: Mon, 28 Sep 2026 10:41:53 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>
Subject: =?US-ASCII?Q?RE=3A_=5BEXT=5D_Re=3A_=5BPATCHv3_00/?=
 =?US-ASCII?Q?10=5D_hw/arm=3A_Adding_Cortex-M?=
 =?US-ASCII?Q?7_Asymmetric_Multiprocessing_boot_support_for_i=2EMX8MP?=
In-Reply-To: <DB8PR04MB71779F207064411F31E56DBC87822@DB8PR04MB7177.eurprd04.prod.outlook.com>
References: <20260920115458.481605-1-gaurav.sharma_7@nxp.com>
 <DC17DA54-3C43-4955-A38F-6FADFAA2EFF5@gmail.com>
 <DB8PR04MB71779F207064411F31E56DBC87822@DB8PR04MB7177.eurprd04.prod.outlook.com>
Message-ID: <473ADFC2-3FC7-4CB6-A9B1-D554A6EA2E05@gmail.com>
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



Am 23=2E September 2026 17:24:58 UTC schrieb Gaurav Sharma <gaurav=2Esharm=
a_7@nxp=2Ecom>:
>
>
>
>NXP Confidential
>> -----Original Message-----
>> From: Bernhard Beschow <shentey@gmail=2Ecom>
>> Sent: 22 September 2026 11:42
>> To: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>; qemu-devel@nongnu=2Eor=
g
>> Cc: qemu-arm@nongnu=2Eorg; pbonzini@redhat=2Ecom;
>> peter=2Emaydell@linaro=2Eorg; pierrick=2Ebouvier@oss=2Equalcomm=2Ecom
>> Subject: [EXT] Re: [PATCHv3 00/10] hw/arm: Adding Cortex-M7 Asymmetric
>> Multiprocessing boot support for i=2EMX8MP
>>
>> Caution: This is an external email=2E Please take care when clicking li=
nks or
>> opening attachments=2E When in doubt, report the message using the 'Rep=
ort
>> this email' button
>>
>>
>> Am 20=2E September 2026 11:54:48 UTC schrieb Gaurav Sharma
>> <gaurav=2Esharma_7@nxp=2Ecom>:
>>
>> Hi Gaurav,
>>
>> >Changes in v1:
>> >
>> >This series adds Asymmetric Multiprocessing (AMP) boot support for the
>> >Cortex-M7 core on the i=2EMX8MP SoC=2E The M7 firmware can be loaded a=
nd
>> >started from Linux running on the Cortex-A53 cores via the remoteproc
>> >framework=2E
>> >
>> >The series introduces the following peripheral models needed for AMP:
>> >  - GPC (General Power Controller)
>> >  - GPR (General Purpose Registers)
>> >  - SRC (System Reset Controller) authored by Bernhard Beschow
>> ><shentey@gmail=2Ecom>
>> >  - MU (Messaging Unit)
>> >  - Extends the CCM with M7 clock outputs and wires into the i=2EMX8MP
>> >SoC
>> >  - Enable Cortex-M7 boot in i=2EMX8MP EVK functional test
>> >
>> >Changes in v2:
>> >
>> >- Removed the usage of device_class_set_legacy_reset in imx8mp
>> >gpc,gpr,mu and
>> >  src=2E
>> >- Removed the usage of 'smp' , 'maxcpus' and 'enable-cm7' to make the
>> >  invocation simpler=2E
>> >- Cleaned up imx8mp_src by removing redundant/unused code=2E
>> >- Updated Maintainers and improved the imx8mp documentation
>> >
>> >Changes in v3:
>> >
>> >- Added a new patch for smp removal from test_imx8mp_evk=2Epy=2E
>> >- Added a new patch to introduce IRQ splitting for i=2EMX8MP AMP
>> >interrupt
>> >  routing=2E
>> >- Added a new patch to rename FSL_IMX8MP_NUM_CPUS to
>> >FSL_IMX8MP_NUM_A53,
>> >  since M7 is being introduced now=2E
>> >- In GPR, parent_phases moved from global variable to class struct
>> >- M7 reset handling moved from the machine to SRC device model=2E
>> >- Added ITCM and DTCM memory regions to support zephyr firmware
>> loading=2E
>> >
>> >Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>> >
>> >Bernhard Beschow (1):
>> >  hw/misc: Add SRC (System Reset Controller) to i=2EMX8MP
>>
>> I think you can claim ownership of the SRC since I think only non-
>> copyrightable changes are left from the original commit=2E
>>
>
>Sure=2E I will update the authorship accordingly in v4=2E Your sign-off c=
an still be retained right?

I think there is no need for retaining it=2E

>
>> >
>> >Gaurav Sharma (9):
>> >  hw/misc: Add i=2EMX8MP GPC (General Power Controller) IP
>> >  hw/misc: Add GPR (General Purpose Register) IP to iMX8MP
>> >  hw/misc: Add MU (Messaging Unit) IP to i=2EMX8MP device model
>> >  hw/misc: Extend i=2EMX8MP CCM with Cortex-M7 clock outputs
>>
>> >  hw/arm: Enable Cortex-M7 AMP boot on i=2EMX8MP
>>
>> This should be the last patch of the series=2E The paches below are ref=
actorings
>> and should rather be the first patches in the series=2E Right now they =
depend on
>> changes in this series which prevents them from being cherry-picked for=
 early
>> merge=2E
>>
>> Generally, touching the same code twice in a series is discuraged and s=
hould
>> only be done with good reasons=2E In favor of a clean history QEMU is n=
ot
>> interested in the detours during development and instead we pretend as =
if we
>> knew the shortest path towards a goal in the first place=2E Makes sense=
?
>>
>> Best regards,
>> Bernhard
>>
>
>Yes, it does make sense=2E Thank you for the guidance=2E In v4 I will reo=
rder the
>series so that all independent refactoring patches come first and the
>CM7 boot patch comes last=2E Something like this:-
>
>0001-0005 hw/misc: GPC, GPR, SRC, MU, CCM (unchanged)
>  0006         hw/arm: Add ITCM/DTCM memory regions (new, split from 0009=
)
>  0007         hw/arm: Rename FSL_IMX8MP_NUM_CPUS to FSL_IMX8MP_NUM_A53

Make sure it only contains the renaming of the enum=2E CM7 stuff should be=
 postponed to the patch integrating it=2E

>  0008         hw/arm: Add IRQ splitter for AMP interrupt routing
>  0009         MAINTAINERS: Merge MCIMX8MM-EVK and MCIMX8MP-EVK entries
>  0010         tests/functional: Fix i=2EMX8MP EVK SMP configuration
>  0011         hw/arm: Enable Cortex-M7 AMP boot on i=2EMX8MP

I'd move patches 9, 7, and 10 to the front since they're independent refac=
torings=2E This allows them to be pulled independently=2E Other than that t=
he ordering looks fine to me=2E

Best regards,
Bernhard

>
>>
>> >  hw/arm: Rename FSL_IMX8MP_NUM_CPUS to FSL_IMX8MP_NUM_A53
>> >  MAINTAINERS: Merge MCIMX8MM-EVK and MCIMX8MP-EVK entries
>> >  hw/arm: Add IRQ splitter for i=2EMX8MP AMP interrupt routing
>> >  tests/functional: Fix i=2EMX8MP EVK SMP configuration
>> >
>> > MAINTAINERS                                 |  13 +-
>> > docs/system/arm/imx8m=2Erst                   | 188 ++++++++-
>> > hw/arm/Kconfig                              |   4 +
>> > hw/arm/fsl-imx8mp=2Ec                         | 227 +++++++++--
>> > hw/arm/imx8mp-evk=2Ec                         |   5 +-
>> > hw/misc/Kconfig                             |  12 +
>> > hw/misc/imx8mp_ccm=2Ec                        |   9 +
>> > hw/misc/imx8mp_gpc=2Ec                        | 146 +++++++
>> > hw/misc/imx8mp_gpr=2Ec                        | 155 ++++++++
>> > hw/misc/imx8mp_mu=2Ec                         | 328 ++++++++++++++++
>> > hw/misc/imx8mp_src=2Ec                        | 411 +++++++++++++++++=
+++
>> > hw/misc/meson=2Ebuild                         |   4 +
>> > hw/misc/trace-events                        |   5 +
>> > include/hw/arm/fsl-imx8mp=2Eh                 |  33 +-
>> > include/hw/misc/imx8mp_ccm=2Eh                |   3 +
>> > include/hw/misc/imx8mp_gpc=2Eh                |  34 ++
>> > include/hw/misc/imx8mp_gpr=2Eh                |  62 +++
>> > include/hw/misc/imx8mp_mu=2Eh                 |  53 +++
>> > include/hw/misc/imx8mp_src=2Eh                |  52 +++
>> > tests/functional/aarch64/test_imx8mp_evk=2Epy |   1 -
>> > 20 files changed, 1696 insertions(+), 49 deletions(-) create mode
>> > 100644 hw/misc/imx8mp_gpc=2Ec create mode 100644 hw/misc/imx8mp_gpr=
=2Ec
>> > create mode 100644 hw/misc/imx8mp_mu=2Ec create mode 100644
>> > hw/misc/imx8mp_src=2Ec create mode 100644
>> include/hw/misc/imx8mp_gpc=2Eh
>> > create mode 100644 include/hw/misc/imx8mp_gpr=2Eh create mode 100644
>> > include/hw/misc/imx8mp_mu=2Eh create mode 100644
>> > include/hw/misc/imx8mp_src=2Eh
>> >

