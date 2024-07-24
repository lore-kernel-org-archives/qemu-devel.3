Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FCFC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 08:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWXEe-000857-AP; Wed, 24 Jul 2024 04:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sWXEW-00083d-Oy; Wed, 24 Jul 2024 04:20:25 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sWXEU-0001JT-V6; Wed, 24 Jul 2024 04:20:24 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5a88be88a3aso3174596a12.3; 
 Wed, 24 Jul 2024 01:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721809220; x=1722414020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zdEriAdQ9gRNNGOvo+KxKI5p/Cvd9dPG6br1Mq6SSf0=;
 b=NAM/w8m/LRbnD1hzKtYye9OHUesRnfS8/1tqsBsW5D9kU/iNfCiQm6FXAQ4Lsctdzc
 gUKWyx4WFdcoWU+2A/VWbDvwSk6vDZ1xn6Za12ltN2HCYoi7Cf0zL6KNhAn7inJ6h72c
 xmQcWXjvxsw4ddula1OBf20f30114kv6w/gIsVNvcvRXiIjCAVcY3GsrUuEqDqk34Rdz
 wkkswpQdrOBuCq4q01XmGmiIBetnCwStgUkt3EeLrAbzO+r95lIVMZF7bnMqJ2HYKrzc
 WIoe0TXKm6YW+ZQe9Dst2mBalf0JeBUP3eGSwVN9+JIflX7JevL9J4rMWie6IK5uGI8u
 p+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721809220; x=1722414020;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zdEriAdQ9gRNNGOvo+KxKI5p/Cvd9dPG6br1Mq6SSf0=;
 b=AcfaaCPKH96jojC/Psz/0R5hnIl/d6krnxhudZl7Vp0/1Ze++kshHRpGGRBOcN6SA7
 DObqzk7dgxi7RlnvhL1YdhuLm8VHb640pFG2U+3BwbW0gE3nezF6Y2ZJiJU6IBSI30nL
 6c1IDnHa3dt975kHMxulmXuCT3Lr965IZknKzp0pjQINMGL3ZBcNRibQw0uAgfiBxVSg
 p5NbUeDoM8wz2Bp406G4dqafHEHAHNUZHiS4JeWKAfL0IFsCv5Ccn12IQkJrV5J4hMR9
 RrUKSjPbVUNjExxBKcJwDVJaLNdQ4cuuoFXHPOLzfG2EnbF9uplAFTNphrbtIBdFWdGs
 OiDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7ut3e/4T6X4kPNv4UOqa5N69oHjRGoNBwR2lqAkG9A3yshwboA2Kv6MUqmOQyHQS0Vw2w018MvnzchjJVKr0R/V9W
X-Gm-Message-State: AOJu0YzDw76xWjZwLYwL9j7R277wOs+edFioqQCkK2Vf2dnxNntLPVlC
 5MDloJhztHxk7VlvwFJeF5TReslx87I1ObYb10Y5vcoZOnJ7O8k2
X-Google-Smtp-Source: AGHT+IGQ62H1oysHwploIw/Cs1c6bwfgj0dNjVFGLlKtf6x4qlvZTJtyaxOMW0G/hWIfViJS/g8oNw==
X-Received: by 2002:a50:d697:0:b0:57c:6d1c:3cee with SMTP id
 4fb4d7f45d1cf-5a478f6b024mr8496398a12.14.1721809219491; 
 Wed, 24 Jul 2024 01:20:19 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-011-098-248.77.11.pool.telefonica.de.
 [77.11.98.248]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a7f5349cc5sm3991624a12.13.2024.07.24.01.20.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 01:20:19 -0700 (PDT)
Date: Wed, 24 Jul 2024 08:20:17 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH 0/3] Resolve vt82c686 and piix4 qemu_irq memory leaks
In-Reply-To: <20240722202107-mutt-send-email-mst@kernel.org>
References: <20240704205854.18537-1-shentey@gmail.com>
 <20240720143745-mutt-send-email-mst@kernel.org>
 <184E18CE-C4DF-4DEA-A20A-84B31833093F@gmail.com>
 <20240722202107-mutt-send-email-mst@kernel.org>
Message-ID: <8EA0DE3E-ACC4-4164-BAEE-C1AF2FB0F9A0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
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



Am 23=2E Juli 2024 00:21:32 UTC schrieb "Michael S=2E Tsirkin" <mst@redhat=
=2Ecom>:
>On Mon, Jul 22, 2024 at 10:21:30PM +0000, Bernhard Beschow wrote:
>>=20
>>=20
>> Am 20=2E Juli 2024 18:38:42 UTC schrieb "Michael S=2E Tsirkin" <mst@red=
hat=2Ecom>:
>> >On Thu, Jul 04, 2024 at 10:58:51PM +0200, Bernhard Beschow wrote:
>> >> This series first turns vt82c686's "INTR" pin into a named GPIO for =
better
>> >> comprehensibility=2E It then continues fixing qemu_irq memory leaks =
in vt82c686
>> >> and piix4 by connecting out IRQs of the south bridges before they ge=
t realized=2E
>> >> This approach is already used in the pc machines after it had been d=
iscussed at
>> >> KVM forum `23=2E
>> >>=20
>> >> Observe that out IRQs are callbacks such as an INTR IRQ handler in a=
 CPU which a
>> >> south bridge wants to trigger=2E If, as an implementation detail, th=
e south bridge
>> >> wants to pass this callback to a child device, such as the PIC, then=
 this
>> >> callback must be known to the south bridge before it gets realized=
=2E Otherwise
>> >> board code had to wire the PIC device itself, breaking encapsulation=
=2E This means
>> >> that qdev_connect_gpio_out*() has to be called before realize() whic=
h this
>> >> series implements=2E Another way to look at it is that callbacks app=
arently are
>> >> resouces such as memory regions which are also populated before real=
ize()=2E
>> >>=20
>> >> Please check if above paragraph makes sense=2E
>> >>=20
>> >> Best regards,
>> >> Bernhard
>> >
>> >
>> >Bernhard, do you intend to resolve Zoltan's comments on this
>> >patchset?
>>=20
>> Hi Michael,
>>=20
>> I was hoping for some more comments on the last two commits=2E These re=
solve various issues in one go, some of which have been addressed in the pa=
st=2E Since this is apparently a new style to handle out-GPIOs, I'd like to=
 get an OK from the community=2E
>>=20
>> As Zoltan writes the ideal solution might be to qdev'ify the PIC=2E Thi=
s is a bigger task which is more than I intended to do in this series=2E
>>=20
>> Best regards,
>> Bernhard
>
>
>ATM I'm just looking at whether we can fix any bugs for the coming
>release=2E

Yes, makes sense=2E Both Zoltan's and my proposal qualify for bug fixing I=
MO, and both are an improvement over the current code (fixing memory leaks)=
=2E I'm not too attached to either proposal, but I'd prefer a third opinion=
 on the matter=2E @Phil: As maintainer and one who worked on the very same =
issues before you look like a good candidate=2E Though I'm not sure if your=
 time and focus allows for that right now=2E

Best regards,
Bernhard

>
>> >
>> >Thanks!
>> >
>> >
>> >> See also:
>> >> * https://lore=2Ekernel=2Eorg/qemu-devel/0FFB5FD2-08CE-4CEC-9001-E7A=
C24407A44@gmail=2E
>> >> com/
>> >> * "Remove intermediate IRQ forwarder" patches in
>> >> https://lore=2Ekernel=2Eorg/qemu-devel/20230210163744=2E32182-1-phil=
md@linaro=2Eorg/
>> >>=20
>> >> Testing done:
>> >> * Boot amigaone machine into Linux
>> >> * Boot pegasos2 machine into MorphOS
>> >> * Start fuloong2e machine and check that it doesn't abort
>> >> * Boot malta machine with https://people=2Edebian=2Eorg/~gio/dqib/
>> >>=20
>> >> Bernhard Beschow (3):
>> >>   hw/isa/vt82c686: Turn "intr" irq into a named gpio
>> >>   hw/isa/vt82c686: Resolve intermediate IRQ forwarder
>> >>   hw/isa/piix: Resolve intermediate IRQ forwarder
>> >>=20
>> >>  hw/isa/piix=2Ec       | 13 ++-----------
>> >>  hw/isa/vt82c686=2Ec   | 12 ++----------
>> >>  hw/mips/fuloong2e=2Ec |  2 +-
>> >>  hw/mips/malta=2Ec     |  4 +---
>> >>  hw/ppc/amigaone=2Ec   |  8 ++++----
>> >>  hw/ppc/pegasos2=2Ec   |  4 ++--
>> >>  6 files changed, 12 insertions(+), 31 deletions(-)
>> >>=20
>> >> --=20
>> >> 2=2E45=2E2
>> >>=20
>> >
>

