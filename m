Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93B5C61DC7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzWxj-0001Ya-Bc; Thu, 27 Aug 2026 06:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wzWxi-0001YM-Eg
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:03:58 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wzWxf-0000Iz-53
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:03:58 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so16289735e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 03:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787825033; x=1788429833; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=csgrpDKtf2UyMheOyiDVEI2NzIE/1VuTDsipBKYqE94=;
 b=N9lK7pQvAIkdNLVIFkLqz224SpR95sMTFfDWThytodGsH48/ixzg6ORIvXLgF5j/mA
 hhu/mkLk+z/OeiGjk4UEYIfpmYmtRViJREbJq1uBrdPIB+1ogoIYFB1/ITOLzxdhtJ/r
 p3KQlzLKkgtllSdM32bLOhgu7aPxBAzC+FFKxk9+drc/3tfTOS4NKZgrw/ONa6Yplzl1
 2NWNuFGFYpSmr27augO6IO534fNfBir/0aQKHpL2JOFqLa81+eXi5RF2BxSPSWqd+VC8
 Ylom6M+fETkQmSoDraBSbm9MKwoB3zpgV852RNU+KjnldeHHTFFVSBDoTKZYUYb9pgsD
 pD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787825033; x=1788429833;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=csgrpDKtf2UyMheOyiDVEI2NzIE/1VuTDsipBKYqE94=;
 b=Np+ozMqv8wuJ3+90VozuTcDBTKVcz0AzyGorB534mJ3G6T3jcQeuqMacQ3kYrkBjux
 wqUGLhJnMQvMEyGkXTbQih1LqNFRoavzxYZmhaRIFoO4TEUZky6Z2pYJRIQMn1hTnSwf
 ZXVyqYItNJTS+VV4/4wULTNKfM9ZojGWwMDsWOe+lotYFcf3hIzAJUzUz6eBcN0Wj9Jp
 Xb1as36Ef4PpoGbcbcqArpaGDDaAmoY3xF1C4RrgpuMHz91lK+9hmPnLPM8UIkB6SI1v
 NNtfjq1KMXkiYJNq7YIabHZLIzv5idpja4z0aF2mSXIf1VdgeH0bwsoOdtPryRaylLHZ
 iJ4A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqsmA5/9jW6WvZcp+SqDjrB73opdirc88FdxM8NOpC16tFybGzvjKnLaGFIxbsUqH60KfiERvQfWxkc@nongnu.org
X-Gm-Message-State: AFuF++nvphUYDDoCJdNwg1i5wRytmPgNo6t5j+9DCl87yjGcMVhFWxO7
 65AYkZ/tN138dw7sdNIIy9flcGFVnSD/Xxat7svdAg4avTD+TlzeFD0L
X-Gm-Gg: AR+sD13Jvfhf8npkVrpjDhRR9C/hYesybmKTID7j0i6fQmDNc9X4ajc+AaXxBDsTlpI
 a6QqnOvUr82L2E85kg3Ymq7L4ehK6PIRXjvIHtnp4Wm0CRvr5EaJH3VtgUQIlHeU8rFVTEd9hVk
 j3IGHoYNkXoz7HudqDPsJPKvK3v7+jcgbs4gkiKmUBR+jSd7KvWUvmcukZjxtV7sqYZgBx9h2+l
 0yRL2c+xhGR/0b1XbsQ8llmSjGaK5KLdmv9yFMtdDWkti1nEq5j12T8FFuoai+llkeHjtzlQ7fq
 e6wRMHAfPsfMKIOwqbuDAwh+OKtKZBa6eiuDTkw9elihC5BwXWrpdO+HLPIO4HlXK97DnYYZAfH
 P8Zu9JQO4lwqxK5Ivlh3tQ0E8c5AWME97C6qs05MYO3oyGVpR4SKIGEcnhit+vY4ulVthrT9Sz8
 SYo3XAVUQyeg0L5iMkTpkIaK+uZv8umOm7GYZmZ65mzMGR6oL6PjVprliudUpxpxLo8w==
X-Received: by 2002:a05:600c:a418:b0:49a:2c4b:403f with SMTP id
 5b1f17b1804b1-49a2c4b41dfmr111526485e9.13.1787825031458; 
 Thu, 27 Aug 2026 03:03:51 -0700 (PDT)
Received: from ehlo.thunderbird.net ([62.214.191.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4aff5ffbsm34378305e9.13.2026.08.27.03.03.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 03:03:51 -0700 (PDT)
Date: Thu, 27 Aug 2026 10:03:41 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: =?US-ASCII?Q?RE=3A_=5BEXT=5D_RE=3A_=5BPATCHv2_0/7?=
 =?US-ASCII?Q?=5D_hw/arm=3A_Adding_Cortex-M7?=
 =?US-ASCII?Q?_Asymmetric_Multiprocessing_boot_support_for_i=2EMX8MP?=
In-Reply-To: <DB8PR04MB71771CD2C2030CDC5C554A6887A02@DB8PR04MB7177.eurprd04.prod.outlook.com>
References: <20260706162859.3361063-1-gaurav.sharma_7@nxp.com>
 <DB8PR04MB717781FAC6A65C0BE2AF1D0587CF2@DB8PR04MB7177.eurprd04.prod.outlook.com>
 <DB8PR04MB717730147C8E5B87FF57D07D87DD2@DB8PR04MB7177.eurprd04.prod.outlook.com>
 <C7FBB1C7-732B-4BFB-9073-CA8A44C41C3B@gmail.com>
 <5496592E-1B57-420F-B87B-8070A3F7D2AA@gmail.com>
 <DB8PR04MB71774BF67E652DD2B6DD3A6187A02@DB8PR04MB7177.eurprd04.prod.outlook.com>
 <64BC2648-354C-4F3B-A22E-1E45725B82AB@gmail.com>
 <DB8PR04MB71771CD2C2030CDC5C554A6887A02@DB8PR04MB7177.eurprd04.prod.outlook.com>
Message-ID: <213A4391-3DB7-4AC4-9AF3-6C06DAD27C0D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32e.google.com
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



Am 24=2E August 2026 11:16:11 UTC schrieb Gaurav Sharma <gaurav=2Esharma_7=
@nxp=2Ecom>:
>
>
>
>NXP Confidential
>> -----Original Message-----
>> From: Bernhard Beschow <shentey@gmail=2Ecom>
>> Sent: 24 August 2026 16:13
>> To: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>; qemu-devel@nongnu=2Eor=
g
>> Cc: pbonzini@redhat=2Ecom; peter=2Emaydell@linaro=2Eorg
>> Subject: RE: [EXT] RE: [PATCHv2 0/7] hw/arm: Adding Cortex-M7 Asymmetri=
c
>> Multiprocessing boot support for i=2EMX8MP
>>
>> Caution: This is an external email=2E Please take care when clicking li=
nks or
>> opening attachments=2E When in doubt, report the message using the 'Rep=
ort
>> this email' button
>>
>>
>> Am 24=2E August 2026 04:55:28 UTC schrieb Gaurav Sharma
>> <gaurav=2Esharma_7@nxp=2Ecom>:
>> >
>> >
>> >
>> >NXP Confidential
>> >> -----Original Message-----
>> >> From: Bernhard Beschow <shentey@gmail=2Ecom>
>> >> Sent: 23 August 2026 22:26
>> >> To: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>; qemu-
>> devel@nongnu=2Eorg
>> >> Cc: pbonzini@redhat=2Ecom; peter=2Emaydell@linaro=2Eorg
>> >> Subject: [EXT] RE: [PATCHv2 0/7] hw/arm: Adding Cortex-M7 Asymmetric
>> >> Multiprocessing boot support for i=2EMX8MP
>> >>
>> >> Caution: This is an external email=2E Please take care when clicking
>> >> links or opening attachments=2E When in doubt, report the message us=
ing
>> >> the 'Report this email' button
>> >>
>> >>
>> >> Am 23=2E August 2026 12:02:22 UTC schrieb Bernhard Beschow
>> >> <shentey@gmail=2Ecom>:
>> >> >
>> >> >
>> >> >Am 11=2E August 2026 04:47:40 UTC schrieb Gaurav Sharma
>> >> <gaurav=2Esharma_7@nxp=2Ecom>:
>> >> >>ping
>> >> >>
>> >> >>> -----Original Message-----
>> >> >>> From: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>> >> >>> Sent: 24 July 2026 09:32
>> >> >>> To: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>; qemu-
>> >> devel@nongnu=2Eorg
>> >> >>> Cc: pbonzini@redhat=2Ecom; peter=2Emaydell@linaro=2Eorg; Bernhar=
d
>> >> >>> Beschow <shentey@gmail=2Ecom>
>> >> >>> Subject: RE: [PATCHv2 0/7] hw/arm: Adding Cortex-M7 Asymmetric
>> >> >>> Multiprocessing boot support for i=2EMX8MP
>> >> >>>
>> >> >>> Ping
>> >> >
>> >> >Hi Gurav,
>> >> >
>> >> >I finally could test your series=2E I built Buildroot's
>> >> freescale_imx8mpevk_defonfig (v2026=2E05) which has the required ker=
nel
>> >> options already enabled and passed imx8mp-evk-rpmsg=2Edtb to QEMU=2E
>> QEMU
>> >> starts successfully=2E However, when attempting to load an =2Eelf im=
age
>> >> to remoteproc0/firmware, I get:
>> >> >
>> >> >    # echo zephyr=2Eelf >
>> >> >/sys/devices/platform/imx8mp-cm7/remoteproc/remoteproc0/firm
>> >> >ware
>> >> >    [  887=2E325597] imx-rproc imx8mp-cm7: can't change firmware wh=
ile
>> >> running
>> >> >    sh: write error: Device or resource busy
>> >> >
>> >> >Checking the state results in:
>> >> >
>> >> >    # cat /sys/devices/platform/imx8mp-
>> cm7/remoteproc/remoteproc0/state
>> >> >    attached
>> >> >
>> >> >I didn't dig into the Linux kernel sources to investigate this
>> >> >further=2E Do you
>> >> have an idea of what is missing?
>> >>
>> >> Okay, I missed the -mmio change as well as the reserved regions:
>> >> https://eur01=2Esafelinks=2Eprotection=2Eoutlook=2Ecom/?url=3Dhttps%=
3A%2F%2Fdoc
>> >>
>> s=2En%2F&data=3D05%7C02%7Cgaurav=2Esharma_7%40nxp=2Ecom%7C078980c8a6cf4
>> 41d336
>> >>
>> 708df01cc83b7%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6392
>> 316500
>> >>
>> 62951398%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYi
>> OiIwLjAu
>> >>
>> MDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%
>> 7C%7C
>> >>
>> &sdata=3DEZYjWZBic3VeUAYyFd2MmxmMdnt5OHtR1pujyFlD01Y%3D&reserved
>> =3D0
>> >>
>> xp=2Ecom%2Fbundle%2FAN5317%2Fpage%2Ftopics%2Fimx_linux_rproc_suppo
>> >>
>> rt=2Ehtml&data=3D05%7C02%7Cgaurav=2Esharma_7%40nxp=2Ecom%7Cba42497956e9=
4
>> >>
>> 77b17c608df01376f9a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%
>> >>
>> 7C639231009747150362%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGki
>> >>
>> OnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoy
>> >>
>> fQ%3D%3D%7C0%7C%7C%7C&sdata=3DVnPdMGYtloMgOrGjEMM8V0fAeyJ4PX
>> >> 1mE0mDUQJiasA%3D&reserved=3D0 =2E Fixed=2E
>> >>
>> >> Then I set up MCUXpresso following this guide:
>> >> https://mcuxpr/
>> >>
>> esso=2Enxp=2Ecom%2Fmcuxsdk%2Flatest%2Fhtml%2Fgsd%2Frepo_setup=2Ehtml&da=
t
>> >>
>> a=3D05%7C02%7Cgaurav=2Esharma_7%40nxp=2Ecom%7Cba42497956e9477b17c608
>> >>
>> df01376f9a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6392310
>> >>
>> 09747181724%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUs
>> >>
>> IlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D
>> >> %7C0%7C%7C%7C&sdata=3D9h%2BskLy4Ymmj5Hdm4bbxNWwBMVmTA%2Fj
>> %2
>> >> Bt2eAQvbKnrg%3D&reserved=3D0
>> >>
>> >> With an ARM eabi toolchain provided by my distrubution I created the
>> >> =2Eelf
>> >> file:
>> >>
>> >>     west build -b evkmimx8mp examples/driver_examples/uart/polling/
>> >> -- config ddr_release
>> >>
>> >> With the apporpriate =2Edtb I get in Buildroot guest:
>> >>
>> >>     # modprobe rpmsg_char
>> >>     # echo uart_polling_cm7=2Eelf > /sys/devices/platform/imx8mp-
>> >> cm7/remoteproc/remoteproc0/firmware
>> >>     # echo start > /sys/devices/platform/imx8mp-
>> >> cm7/remoteproc/remoteproc0/state
>> >>     [   52=2E182388] remoteproc remoteproc0: powering up imx-rproc
>> >>     [   52=2E195672] remoteproc remoteproc0: Direct firmware load fo=
r
>> >> uart_polling_cm7=2Eelf failed with error -2
>> >>     [   52=2E195895] remoteproc remoteproc0: Falling back to sysfs f=
allback for:
>> >> uart_polling_cm7=2Eelf
>> >>     [  113=2E748324] remoteproc remoteproc0: request_firmware failed=
: -110
>> >>     [  113=2E755836] remoteproc remoteproc0: Boot failed: -110
>> >>     sh: write error: Connection timed out
>> >>
>> >> Any ideas?
>> >>
>> >
>> >Hey Bernhard,
>>
>> Hi Gurav,
>>
>> >Please copy the elf firmware to /lib/firmware directory before trying
>> >the above remoteproc loading=2E Linux kernel has a built-in firmware
>> >loader subsystem that automatically searches for firmware files in
>> >specific directories such as :- /lib/firmware/
>> >
>> >It is a one-time setup=2E The firmware loading should then work=2E I m=
ight have
>> missed this copy step in the rst=2E I will add it=2E
>>
>> The step is there, I missed it=2E Now I moved the =2Eelf file to /lib/f=
irmware and
>> performed the loading with the new, absolute path=2E Still the same out=
come=2E=2E=2E
>>
>
>I have uploaded the test binaries here - https://github=2Ecom/gauravsharm=
a0305/qemu_test_bins=2E So, you will get:-
>1=2E Kernel Image
>2=2E RPMSG DTB
>3=2E M7 binary elf
>
>can you please test the emulation with the above binaries ? that way you'=
ll know which side of changes are being missed=2E I have been testing it co=
nsistently with these binaries=2E
>
>=2E/qemu-system-aarch64 -M imx8mp-evk -m 3G -display none -serial null -s=
erial stdio -serial null -serial pty:/tmp/imx8mp-uart4 -kernel Image -dtb i=
mx8mp-evk-rpmsg=2Edtb -append "root=3D/dev/mmcblk2p1" -drive file=3D2024052=
2-br2024=2E02-nitrogen8mp_qt5_gst1=2Eimg,if=3Dsd,bus=3D2,format=3Draw,id=3D=
mmcblk2

Thanks! I finally succeeded=2E The missing detail was to echo just the nam=
e of the =2Eelf file rather than its absolute path, and your log file helpe=
d me spot that=2E

Now that I've a working setup I will be able to provide feedback=2E

Until then and best regards,
Bernhard

>
>> >
>> >> Best regards,
>> >> Bernhard
>> >>
>> >> >
>> >> >Note that I built Zephyr's imx8mp_evk for the M7 [1] which produces
>> >> zephyr=2Eelf=2E Does the series provide everything to use Zephyr or =
do we
>> >> need to add ITCM memory? Adding a dedicated memory map including
>> ITCM
>> >> for the
>> >> M7 core doesn't seem too complicated=2E Using Zephyr may allow for
>> >> having a functional test in our CI, though of course binary images h=
ad to
>> be provided=2E
>> >> >
>> >> >Best regards,
>> >> >Bernhard
>> >> >
>> >> >[1]
>> >> >https://docs/=2E
>> >> >zephyrproject=2Eorg%2Flatest%2Fboards%2Fnxp%2Fimx8mp_evk%2Fdoc%2
>> Fin
>> >> dex=2Eht
>> >> >ml%23programming-and-debugging-
>> >> m7&data=3D05%7C02%7Cgaurav=2Esharma_7%40nxp=2E
>> >> >com%7Cba42497956e9477b17c608df01376f9a%7C686ea1d3bc2b4c6fa92
>> cd
>> >> 99c5c3016
>> >> >35%7C0%7C0%7C639231009747200340%7CUnknown%7CTWFpbGZsb3d
>> 8ey
>> >> JFbXB0eU1hcGk
>> >> >iOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIld
>> UIj
>> >> oyfQ
>> >> >%3D%3D%7C0%7C%7C%7C&sdata=3DcyY1qeaapUnyZB45dfZ5V4Os0S2gkQr
>> rq
>> >> MXR5XZ83fw%3
>> >> >D&reserved=3D0
>> >> >
>> >> >
>> >> >>>
>> >> >>> > -----Original Message-----
>> >> >>> > From: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>> >> >>> > Sent: 06 July 2026 21:59
>> >> >>> > To: qemu-devel@nongnu=2Eorg
>> >> >>> > Cc: pbonzini@redhat=2Ecom; peter=2Emaydell@linaro=2Eorg; Gaura=
v
>> >> >>> > Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>> >> >>> > Subject: [PATCHv2 0/7] hw/arm: Adding Cortex-M7 Asymmetric
>> >> >>> > Multiprocessing boot support for i=2EMX8MP
>> >> >>> >
>> >> >>> > Changes in v1:
>> >> >>> >
>> >> >>> > This series adds Asymmetric Multiprocessing (AMP) boot support
>> >> >>> > for the
>> >> >>> > Cortex-M7 core on the i=2EMX8MP SoC=2E The M7 firmware can be
>> >> >>> > loaded and started from Linux running on the Cortex-A53 cores
>> >> >>> > via the remoteproc framework=2E
>> >> >>> >
>> >> >>> > The series introduces the following peripheral models needed f=
or
>> AMP:
>> >> >>> >   - GPC (General Power Controller)
>> >> >>> >   - GPR (General Purpose Registers)
>> >> >>> >   - SRC (System Reset Controller) authored by Bernhard Beschow
>> >> >>> > <shentey@gmail=2Ecom>
>> >> >>> >   - MU (Messaging Unit)
>> >> >>> >   - Extends the CCM with M7 clock outputs and wires into the
>> >> >>> > i=2EMX8MP
>> >> SoC
>> >> >>> >   - Enable Cortex-M7 boot in i=2EMX8MP EVK functional test
>> >> >>> >
>> >> >>> > Changes in v2:
>> >> >>> >
>> >> >>> > - Removed the usage of device_class_set_legacy_reset in imx8mp
>> >> >>> > gpc,gpr,mu and
>> >> >>> >   src=2E
>> >> >>> > - Removed the usage of 'smp' , 'maxcpus' and 'enable-cm7' to m=
ake
>> the
>> >> >>> >   invocation simpler=2E
>> >> >>> > - Cleaned up imx8mp_src by removing redundant/unused code=2E
>> >> >>> > - Updated Maintainers and improved the imx8mp documentation
>> >> >>> >
>> >> >>> > Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>> >> >>> >
>> >> >>> > Bernhard Beschow (1):
>> >> >>> >   hw/misc: Add SRC (System Reset Controller) to i=2EMX8MP
>> >> >>> >
>> >> >>> > Gaurav Sharma (6):
>> >> >>> >   hw/misc: Add i=2EMX8MP GPC (General Power Controller) IP
>> >> >>> >   hw/misc: Add GPR (General Purpose Register) IP to iMX8MP
>> >> >>> >   hw/misc: Add MU (Messaging Unit) IP to i=2EMX8MP device mode=
l
>> >> >>> >   hw/misc: Extend i=2EMX8MP CCM with Cortex-M7 clock outputs
>> >> >>> >   hw/arm: Enable Cortex-M7 AMP boot on i=2EMX8MP
>> >> >>> >   tests/functional: Enable Cortex-M7 boot in i=2EMX8MP EVK
>> >> >>> > functional test
>> >> >>> >
>> >> >>> >  MAINTAINERS                                 |  13 +-
>> >> >>> >  docs/system/arm/imx8m=2Erst                   | 188 +++++++++=
+-
>> >> >>> >  hw/arm/Kconfig                              |   4 +
>> >> >>> >  hw/arm/fsl-imx8mp=2Ec                         | 220 +++++++++=
+++-
>> >> >>> >  hw/arm/imx8mp-evk=2Ec                         |   3 +-
>> >> >>> >  hw/misc/Kconfig                             |  12 +
>> >> >>> >  hw/misc/imx8mp_ccm=2Ec                        |   9 +
>> >> >>> >  hw/misc/imx8mp_gpc=2Ec                        | 146 +++++++++
>> >> >>> >  hw/misc/imx8mp_gpr=2Ec                        | 153 +++++++++
>> >> >>> >  hw/misc/imx8mp_mu=2Ec                         | 328 +++++++++=
+++++++++++
>> >> >>> >  hw/misc/imx8mp_src=2Ec                        | 275 +++++++++=
+++++++
>> >> >>> >  hw/misc/meson=2Ebuild                         |   4 +
>> >> >>> >  hw/misc/trace-events                        |   5 +
>> >> >>> >  include/hw/arm/fsl-imx8mp=2Eh                 |  29 +-
>> >> >>> >  include/hw/misc/imx8mp_ccm=2Eh                |   3 +
>> >> >>> >  include/hw/misc/imx8mp_gpc=2Eh                |  34 ++
>> >> >>> >  include/hw/misc/imx8mp_gpr=2Eh                |  56 ++++
>> >> >>> >  include/hw/misc/imx8mp_mu=2Eh                 |  53 ++++
>> >> >>> >  include/hw/misc/imx8mp_src=2Eh                |  31 ++
>> >> >>> >  tests/functional/aarch64/test_imx8mp_evk=2Epy |   1 -
>> >> >>> >  20 files changed, 1539 insertions(+), 28 deletions(-)  create
>> >> >>> > mode
>> >> >>> > 100644 hw/misc/imx8mp_gpc=2Ec  create mode 100644
>> >> >>> hw/misc/imx8mp_gpr=2Ec
>> >> >>> > create mode 100644 hw/misc/imx8mp_mu=2Ec  create mode 100644
>> >> >>> > hw/misc/imx8mp_src=2Ec  create mode 100644
>> >> >>> include/hw/misc/imx8mp_gpc=2Eh
>> >> >>> > create mode 100644 include/hw/misc/imx8mp_gpr=2Eh  create mode
>> >> >>> > 100644 include/hw/misc/imx8mp_mu=2Eh  create mode 100644
>> >> >>> > include/hw/misc/imx8mp_src=2Eh
>> >> >>> >
>> >> >>> > --
>> >> >>> > 2=2E34=2E1
>> >> >>

