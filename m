Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58FEC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 23:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgBWg-00008P-Df; Thu, 06 Feb 2025 18:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tgBWf-00007n-3o; Thu, 06 Feb 2025 18:43:17 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tgBWc-00006U-Uq; Thu, 06 Feb 2025 18:43:16 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so17213295e9.2; 
 Thu, 06 Feb 2025 15:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738885392; x=1739490192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ef2X/w1OEVzetm/xDnp2TSrMjqMdFQzu2Vl2N5HSSLY=;
 b=IMx4Zgal4W9smggwxgqBkP1NeRvegJY+woeCEhTrPYJGb3dd0abjKQQA9zKHktmU5h
 doVtgdkbH3Ha+vHZhQGuXrBh+2ZcaktoDlhwEJOlRXs/SpwOWov8WmsatzlSfd5cOfU8
 OYpxxq42K9rk16+d8MNz6Wf1pMQZejZ6aBbWX5FceCgllpib2yWsyQ0Snt8ta2WrZ7TA
 +8RVfwDoysGPGQVUWCa12Zuu43HR4haAsjx756TBSG++p/85JPw8PbKOJNdNUpqEl4JD
 Y9qZfWUWZIuHfB94Q2n8V79wHCyRb9dT1j6NaWUL8/FpIqVNmilxkjxO3kavUkZOoOyH
 g6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738885392; x=1739490192;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ef2X/w1OEVzetm/xDnp2TSrMjqMdFQzu2Vl2N5HSSLY=;
 b=SHDHHu/69WzeSDnQCkDFhMzh1+CXZqw65FpZanwsFtAIkTHCKycLyT8YWHUomb5bgT
 vAmxEMMP5zhLOJ8Hr3KXN8HP04/uSH2MfizevdaQ1XCQk2Zjv3M5i46sdmHn5JKZ05I6
 VO9YT8OA6gS/kd25gb1vFlBwtDiiVOfGCEFM6THLPCyHyz+QNITRjBM5YrxkJG+B9ahH
 wADqliCdboBGQTdGBU3B6ClIhXzOOP1kJ15V+UWGO7UBycODo938RS1CJ7viVcvSXo8e
 mAU/Fyk+SZDhZeQPsHjP9yp6xdos47vGp/SK9IdpYUzjZ1KiiyiH2tXQAuDdf0Jh6pKr
 BZFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBNSPl/epJsG73YWhruY9S8OcCZEh/bKgxvlCqE+1Z3cD6fpy2GGWwoDgLXxtf9emouWLwMd8hbA==@nongnu.org
X-Gm-Message-State: AOJu0YydlWuOG6hatsbsyTYb+0pFaiJs2GAbjlOo2iMu9Buiw7teDN+T
 DI4s35VyrEUmt+9wwmvqE27EYqR2ubTREw7fVvckKyngdz50emSk
X-Gm-Gg: ASbGncsPg63NGd2xB4EELeisXC9Hg5OyN7tzbsauKAYc21QStWens8NDMakao4Y8Uwl
 SxK2EXNOP5ZphJBa5wpycgvS5Tfzgz86aKrPPqbnE8CtfFPeY+rFC3jYI6FQ65zxlU4ZFm61JnO
 mJgsheK0Kt+WyhWbpLzi0AWHpE88ytle7gPPOQ4wcQ3EupYYjLqsp+lhrMHRpfguoeAFUalRknU
 qnyyzss8JKp9FRAzWfTKcVc0WmM882qH2pyZ50vcnTI0hQWQ5vdRKORRyFzdNZzYfhQXO5ryGnw
 FBwigKlQqp3KfQWgTY5ZRSUJmJdmePFnppBjU/GAmv/Tx+w6WLr8gBs+gMXubxNViqzdC9XaeFw
 =
X-Google-Smtp-Source: AGHT+IGSEug/k+1lFlEO+t2OZrhv4ZSdcxsfQzu/VoTc2Vmw1Btzzgx/rqf8/aF99xsfbBSmszMYgA==
X-Received: by 2002:a05:600c:3556:b0:434:a781:f5d9 with SMTP id
 5b1f17b1804b1-4392498a1c0mr15093555e9.11.1738885392274; 
 Thu, 06 Feb 2025 15:43:12 -0800 (PST)
Received: from ?IPv6:::1?
 (p200300faaf004300ecd7bea232a7e2ce.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:ecd7:bea2:32a7:e2ce])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d94d802sm72999415e9.12.2025.02.06.15.43.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 15:43:11 -0800 (PST)
Date: Thu, 06 Feb 2025 23:41:13 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hw/ppc/e500=3A_Partial_impleme?=
 =?US-ASCII?Q?ntation_of_local_access_window_registers?=
In-Reply-To: <69e08a66-b146-4d76-080f-7fa6f4a0a13f@eik.bme.hu>
References: <20250115211544.307124E602F@zero.eik.bme.hu>
 <22e114ac-2c3f-76f1-2172-9adf0c50ad5f@eik.bme.hu>
 <DE6FAB3B-F994-47B8-95A5-9D1BFD6B621F@gmail.com>
 <06F97BE3-057D-4D9D-AAAF-2B7438358BB8@gmail.com>
 <69e08a66-b146-4d76-080f-7fa6f4a0a13f@eik.bme.hu>
Message-ID: <32BC6ABA-EE27-437C-81C0-AEEE3E0DFC9A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x334.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 2=2E Februar 2025 01:25:22 UTC schrieb BALATON Zoltan <balaton@eik=2Ebm=
e=2Ehu>:
>On Sat, 1 Feb 2025, Bernhard Beschow wrote:
>> Am 1=2E Februar 2025 14:55:15 UTC schrieb Bernhard Beschow <shentey@gma=
il=2Ecom>:
>>> Am 30=2E Januar 2025 12:45:58 UTC schrieb BALATON Zoltan <balaton@eik=
=2Ebme=2Ehu>:
>>>> On Wed, 15 Jan 2025, BALATON Zoltan wrote:
>>>>> This allows guests to set the CCSR base address=2E Also store and re=
turn
>>>>> values of the local access window registers but their functionality
>>>>> isn't implemented=2E
>>>>=20
>>>> Ping?
>>>=20
>>> I guess you're trying to boot a real firmware image from SD card?
>
>I'm not trying, I've done it=2E I only needed these patches and commentin=
g out the page_aligned =3D true in hw/sd/sdhci=2Ec as I noted in the previo=
us patch=2E

I had to apply <https://github=2Ecom/shentok/qemu/commit/56550cbb2805be291=
3ad9c12d6d9c6a9a3bf6f2c> to have the SPL load the whole U-Boot proper=2E

>U-Boot works and I can run commands in the firmware prompt but I did not =
try to boot an OS yet=2E The amigaos boot loader which U-Boot for Tabor loa=
ds by default crashes somewhere but this may be a bug in the patched U-Boot=
=2E I think I've seen similar with sam460ex U-Boot before, maybe it's becau=
se of not finding some expected devices and not handling the returned NULL =
value well but I did not debug it=2E

Do you use the Tabor U-Boot or something else? How do you get to the comma=
nd prompt? For me, the bootloader application started by Tabor U-Boot doesn=
't crash but then doesn't find bootable devices, not even with an emulated =
USB stick=2E Instead of dropping to the command prompt it only offers a res=
tart to the firmware which then starts the bootloader application again=2E=
=2E=2E

>
>>> I've implemented that in my e500-fdt branch which I want to send as an=
 RFC=2E I still need to clean it up=2E Once it's on the list we could make =
a plan how to turn it into a p10xx=2E Would that work for you?
>
>Sure, I can try to test your patches once they are submitted to the list =
and rebase my changes on top if they still needed=2E I've just submitted th=
ese so you can incorporate them in your tree so I have less to rebase but I=
 see you already have most of these=2E I'm OK to wait until your tree is cl=
eaned and submitted but it seems there are a lot of patches so it might tak=
e a while=2E I don't expect that you can get it merged before the next rele=
ase=2E Some of the patches may need several versions or alternative approac=
hes until they can be merged=2E For example I expect problems with allowing=
 ',' in device names as this is something that was removed before to avoid =
the need of quoting or something like that=2E But I'm not in a hurry as I d=
on't have much free time for it anyway so only come back to this time to ti=
me and it's far from anything useful yet=2E

My branch is not a maintainer tree=2E I neither expect it to be mergeable =
like this, nor is it my goal=2E Instead, it's just an experiment to investi=
gate data-driven machine creation which I'd like to share as an RFC with th=
e community=2E

That said, one could probably turn that branch into a p10xx SoC implemente=
d in the classic way=2E For this, one would need to decide on how to procee=
d with the mpc8544ds and e500plat machines=2E There are Buildroot recipes f=
or the machines, both 32 and 64 bit, which might be nice to keep working --=
 ideas welcome=2E Once the p10xx SoC is implemented, a tabor machine could =
be added which uses it=2E

>
>>>=20
>>> Best regards,
>>> Bernhard
>>>=20
>>> P=2ES=2E The last commit teaches you how to start a firmware from SD c=
ard=2E
>
>I did not try your version but looking at the patch looks like you have s=
ome sparse-mem region=2E (I've added similar one from board code, I did not=
 know about this device=2E) Isn't that the l2cache as RAM or on-chip SRAM o=
r whatever it's called? You seem to have some emulation of that l2cache in =
a previous patch so can't that be mapped there? Maybe we'll eventually need=
 to implement reading the BOOT data from the beginning of the SD card or fl=
ash ROM which may have some initial register values that set things up that=
 are currently hard coded=2E

This is implemented on my branch=2E It pokes the L2 cache registers to con=
figure some (but not all) SRAM to load the SPL to=2E This SPL uses cache as=
 RAM which I'm emulating with a modified sparse-mem region device=2E

>
>Meanwhile I can cherry pick some patches from your tree and test them=2E =
Looks like you have some DDR3 support added, I haven't got to that yet=2E
>
>For USB I had this for now:
>
>diff --git a/hw/ppc/e500=2Ec b/hw/ppc/e500=2Ec
>index ee17acdb69=2E=2E54890d25f3 100644
>--- a/hw/ppc/e500=2Ec
>+++ b/hw/ppc/e500=2Ec
>@@ -900,6 +900,29 @@ static void ppce500_power_off(void *opaque, int line=
, int on)
>     }
> }
>
>+static uint64_t usb_read(void *opaque, hwaddr addr, unsigned size)
>+{
>+    switch (addr) {
>+    case 0:
>+        return BIT(2) | BIT(17);
>+    }
>+    return 0;
>+}
>+
>+static void usb_write(void *opaque, hwaddr addr, uint64_t val, unsigned =
size)
>+{
>+}
>+
>+static const MemoryRegionOps usb_ops =3D {
>+    =2Eread =3D usb_read,
>+    =2Ewrite =3D usb_write,
>+    =2Eendianness =3D DEVICE_BIG_ENDIAN,
>+    =2Evalid =3D {
>+        =2Emin_access_size =3D 4,
>+        =2Emax_access_size =3D 4,
>+    },
>+};
>+
> void ppce500_init(MachineState *machine)
> {
>     MemoryRegion *address_space_mem =3D get_system_memory();
>@@ -1118,6 +1141,19 @@ void ppce500_init(MachineState *machine)
>                                     sysbus_mmio_get_region(s, 0));
>     }
>
>+    /* USB */
>+    dev =3D qdev_new("tegra2-ehci-usb");
>+    s =3D SYS_BUS_DEVICE(dev);
>+    sysbus_realize_and_unref(s, &error_fatal);
>+    sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, 12));
>+    memory_region_add_subregion(ccsr_addr_space, 0x22000,
>+                                sysbus_mmio_get_region(s, 0));
>+    {
>+        MemoryRegion *mr =3D  g_new(MemoryRegion, 1);
>+        memory_region_init_io(mr, OBJECT(dev), &usb_ops, s, "fsl-ehci", =
4);
>+        memory_region_add_subregion(ccsr_addr_space, 0x22500, mr);
>+    }
>+
>     /* General Utility device */
>     dev =3D qdev_new("mpc8544-guts");
>     s =3D SYS_BUS_DEVICE(dev);
>
>which is reusing a sufficiently similar existing device just to have mini=
mal changes=2E This isn't the right way but since most of these just differ=
 in the reg offsets I wonder if we could turn these offsets into properties=
 so we don't need to add a new subclass for every device=2E I think subclas=
ses came from the pci version where the PCI IDs are different and maybe sys=
bus was modelled after that but we only need subclasses where additional re=
gisters are needed (which may be the case for this fsl device so this prope=
rty idea is just unrelated clean up)=2E

My implementation has similar usb_ops but is based on TYPE_CHIPIDEA which =
also has the "endpoints" registers covered=2E It is used by some i=2EMX mac=
hines and given that these and p1022 are NXP SoCs I wouldn't be surprised i=
f they shared a relation in the real world=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan

