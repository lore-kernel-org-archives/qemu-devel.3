Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693FFC52D7F
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 12:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfI5f-0003Yi-Jd; Sat, 17 Aug 2024 07:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sfI5e-0003XW-95; Sat, 17 Aug 2024 07:59:26 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sfI5b-0007nd-S5; Sat, 17 Aug 2024 07:59:26 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f029e9c9cfso41959971fa.2; 
 Sat, 17 Aug 2024 04:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723895962; x=1724500762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DuuEqdvWp2VO/h3npyUeTGfiUpyRrUe0LfMYTc7UhLA=;
 b=aSLypDt0pSJm8UmrIPIcpOtEb/64xO7JAgBYefq3IKBpJfa+847BTliycxM7Fs0FZw
 fDUxs/cAX4ny0SoFzrF6QdyZOyj/bmzsvE8RVVVU/7A2ZNAlCSRq48mrVUk7u84MuxO3
 V/5lJCeT1JIgzd809FxmzVEbavZZyoVpo/SzxqiVdkO5fYkf6zDRIlQdsRwvgsemYMZ9
 E5oS0tKyUBOL5gyUqJgXxSAUUQ2FWj3zVcZXI5UhfDaOCC5o1vzA8QgwlMJ1k8HYH5wt
 LrEgzRmVvRAfImq4KN4AfsBv6EnIfvtfWiCcT+6PzOgRq6EMCoJ9XovCyJ4/+8RavC8U
 9QvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723895962; x=1724500762;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DuuEqdvWp2VO/h3npyUeTGfiUpyRrUe0LfMYTc7UhLA=;
 b=BRI57utcOnZ9Fr2ufFHijHVH8RuQVWClqyci1eDYgb5mh89LG96bDiCA6Yaacfxxz7
 fdPgV+1RuphS8JQk3DssSAs73cgz4CNEJP9D65hbJThiMcIzDUN49SGCbcniq13jogvh
 HECTZf3dJkB4Z0bNs3IaVIkE429n9MGxPrqtX/COz6nL8MJnSnoNq0Eh68+zVBo5bL+r
 9dwvvgk4HxDpW6EOrJES2h99zdj7EQ+KH57a3ArSxavo6a49GiLbO36IxFi2pUlzD624
 kKkIK6L110+kkAllzZLH7yZ7dAcBMf1tqcRap63P9kr+q4cLgXh9BZsDhdyivCdwJohQ
 gTvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMHHr/ClwjiU9i4B+ok0L97u+CbNOdeGE2S8vtvzUIquS3tcoi6vTMIedZKNmiFFNj6J7Z+PzJgLvJUgvxMRp7scArU1A=
X-Gm-Message-State: AOJu0YzsHPoqMyEIjvBp1ViqXVgFxvbs9RuNfOiYAM9ix4QbMBxwodC+
 XJKdSBOD53z2z8cvGc776yafHe/VKYEoa2a+mKCK9RH3YefUGd1x
X-Google-Smtp-Source: AGHT+IGjM+dTm+kB3kMbjE4a9qoOoQRSmt8RVl/kriYHDEk1GbLcN3qoBm0eVh67SzKN9P2007hiLg==
X-Received: by 2002:a2e:be28:0:b0:2ef:29cd:3191 with SMTP id
 38308e7fff4ca-2f3be5d9997mr51704651fa.35.1723895961081; 
 Sat, 17 Aug 2024 04:59:21 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-089-012-173-151.89.12.pool.telefonica.de.
 [89.12.173.151]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83839472afsm396533066b.175.2024.08.17.04.59.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Aug 2024 04:59:20 -0700 (PDT)
Date: Sat, 17 Aug 2024 11:59:17 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?UTF-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH] hw/i386/pc: Warn about unsatisfied vmport deps
In-Reply-To: <30A32FEE-B310-49E7-8D79-746C786C3CE3@gmail.com>
References: <vsm1ly2eX009LRKgURcMp6qTYHWw1bZd3zg2GUbd4M90T91QvJRdKxiRS3rPl8PR96y2r890Am3Ajf4kQrwihn7-7hKBU9VicRPPtIRv_GI=@szczek.dev>
 <0D723368-3251-4D5E-A625-73169CBE3395@gmail.com>
 <qT_ps6medVHIOIF5hUE_tIMUtEdbHQw5wnhE2ZVauM1cpnfHXqnl9-hroGS-3due9uRtKlMR5RsREbzeIV_0Xp1-FM0w4UDFsvdo3PsIG6U=@szczek.dev>
 <30A32FEE-B310-49E7-8D79-746C786C3CE3@gmail.com>
Message-ID: <FFCCC526-C9CD-4C60-856E-968413BF5455@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=shentey@gmail.com; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



Am 17=2E August 2024 11:54:42 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>
>
>Am 17=2E August 2024 08:49:05 UTC schrieb "Kamil Szcz=C4=99k" <kamil@szcz=
ek=2Edev>:
>>On Friday, August 16th, 2024 at 15:14, Bernhard Beschow <shentey@gmail=
=2Ecom> wrote:
>>
>>>
>>> Am 14=2E August 2024 11:10:16 UTC schrieb "Kamil Szcz=C4=99k" kamil@sz=
czek=2Edev:
>>>
>>> > Since commit 4ccd5fe22feb95137d325f422016a6473541fe9f ('pc: add opti=
on
>>> > to disable PS/2 mouse/keyboard'), the vmport will not be created unl=
ess
>>> > the i8042 PS/2 controller is enabled=2E To not confuse users, let's =
add a
>>> > warning if vmport was explicitly requested, but the i8042 controller=
 is
>>> > disabled=2E This also changes the behavior of vmport=3Dauto to take =
i8042
>>> > controller availability into account=2E
>>> >
>>> > Signed-off-by: Kamil Szcz=C4=99k kamil@szczek=2Edev
>>> > ---
>>> > hw/i386/pc=2Ec | 4 ++++
>>> > hw/i386/pc_piix=2Ec | 3 ++-
>>> > hw/i386/pc_q35=2Ec | 2 +-
>>> > qemu-options=2Ehx | 4 ++--
>>> > 4 files changed, 9 insertions(+), 4 deletions(-)
>>> >
>>> > diff --git a/hw/i386/pc=2Ec b/hw/i386/pc=2Ec
>>> > index c74931d577=2E=2E5bd8dd0350 100644
>>> > --- a/hw/i386/pc=2Ec
>>> > +++ b/hw/i386/pc=2Ec
>>> > @@ -1100,6 +1100,10 @@ static void pc_superio_init(ISABus *isa_bus, =
bool create_fdctrl,
>>> > }
>>> >
>>> > if (!create_i8042) {
>>> > + if (!no_vmport) {
>>> > + warn_report("vmport requires the i8042 controller to be enabled");
>>> > + }
>>> > +
>>> > return;
>>> > }
>>> >
>>> > diff --git a/hw/i386/pc_piix=2Ec b/hw/i386/pc_piix=2Ec
>>> > index d9e69243b4=2E=2Ecf2e2e3e30 100644
>>> > --- a/hw/i386/pc_piix=2Ec
>>> > +++ b/hw/i386/pc_piix=2Ec
>>> > @@ -312,7 +312,8 @@ static void pc_init1(MachineState *machine, cons=
t char *pci_type)
>>> >
>>> > assert(pcms->vmport !=3D ON_OFF_AUTO__MAX);
>>> > if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
>>> > - pcms->vmport =3D xen_enabled() ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
>>> > + pcms->vmport =3D (xen_enabled() || !pcms->i8042_enabled)
>>> > + ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
>>> > }
>>>
>>>
>>> I think it makes sense to consolidate this handling into pc_basic_devi=
ces_init() before doing this change=2E Maybe just in front of the call to p=
c_superio_init()? The additional handling of xen_enabled() shouldn't hurt t=
here for q35: Even though q35 doesn't (yet) support Xen there are already c=
ode paths where this check is done=2E
>>
>>Makes sense technically, but since I'm new to the mailing list workflow =
I could use some help with logistics=2E I've already posted a v2 of this pa=
tch which was reviewed and accepted,
>
>Ouch, I've missed that=2E
>
>> should I wait for it to be pulled in and post a follow-up patch or post=
 another revision of this patch?
>
>Since Michael already tagged it, it seems safer to follow up with a new s=
eries or patch=2E You can use the `Based-on:` tag there to make the depende=
ncy of the new series explicit=2E See [1] for inspiration=2E To determine t=
he mail ID look up this series on lore=2Ekernel=2Eorg/qemu-devel =2E

Of course I meant the tagged version: <https://lore=2Ekernel=2Eorg/qemu-de=
vel/CJaQOvoJMl8P04F7-0Pk23paXt29GnSt2ICM-xlruQ9rGsMHocU_xH3RRaRRJEQpqUxGo63=
sATZb5St7968jHLV0r7NORODN3zHgi_qxpPE=3D@szczek=2Edev/>

>
>Best regards,
>Bernhard
>
>[1] https://patchew=2Eorg/QEMU/20230105143228=2E244965-1-shentey@gmail=2E=
com/
>
>>
>>>
>>> > /* init basic PC hardware */
>>> > diff --git a/hw/i386/pc_q35=2Ec b/hw/i386/pc_q35=2Ec
>>> > index 9d108b194e=2E=2E6c112d804d 100644
>>> > --- a/hw/i386/pc_q35=2Ec
>>> > +++ b/hw/i386/pc_q35=2Ec
>>> > @@ -278,7 +278,7 @@ static void pc_q35_init(MachineState *machine)
>>> >
>>> > assert(pcms->vmport !=3D ON_OFF_AUTO__MAX);
>>> > if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
>>> > - pcms->vmport =3D ON_OFF_AUTO_ON;
>>> > + pcms->vmport =3D pcms->i8042_enabled ? ON_OFF_AUTO_ON : ON_OFF_AUT=
O_OFF;
>>> > }
>>> >
>>> > /* init basic PC hardware */
>>> > diff --git a/qemu-options=2Ehx b/qemu-options=2Ehx
>>> > index cee0da2014=2E=2E0bc780a669 100644
>>> > --- a/qemu-options=2Ehx
>>> > +++ b/qemu-options=2Ehx
>>> > @@ -68,8 +68,8 @@ SRST
>>> >
>>> > `vmport=3Don|off|auto`
>>> > Enables emulation of VMWare IO port, for vmmouse etc=2E auto says
>>> > - to select the value based on accel=2E For accel=3Dxen the default =
is
>>> > - off otherwise the default is on=2E
>>> > + to select the value based on accel and i8042=2E For accel=3Dxen
>>> > + and/or i8042=3Doff the default is off otherwise the default is on=
=2E
>>>
>>>
>>> I'd do s#and/or#or# for readability=2E
>>>
>>> Best regards,
>>> Bernhard
>>>
>>> > `dump-guest-core=3Don|off`
>>> > Include guest memory in a core dump=2E The default is on=2E

