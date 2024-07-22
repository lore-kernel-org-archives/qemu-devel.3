Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACB2C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 22:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW1Pb-0002LY-C0; Mon, 22 Jul 2024 18:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sW1PZ-0002IB-2v; Mon, 22 Jul 2024 18:21:41 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sW1PX-0002jA-Ab; Mon, 22 Jul 2024 18:21:40 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a7a9185e1c0so15015366b.1; 
 Mon, 22 Jul 2024 15:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721686891; x=1722291691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mlZflGXKhWR3xad+GP9v97GbjDPoqysSj/tIl6ZuNq0=;
 b=e2AEdqZzfTo9IPE5qnH6lxgckYhAIMEUxCQ+eGx3iZPtrbLQ7YReL52eLKm86n6ALh
 KwpvFdLtE29qPOMdxjU/GKzX3EFA9VRcE/n8BaMnwbKp3H2YEHA99A9CoF35RhM9uGwf
 R8Gt9tCTzMrL8Yw7mLAfsfNiNWBX4yfHi70IvAqQPy5Xm5G+1N1qLm7r9rQ9xlurP6tA
 +d7tvBB9/k3iqJcXkBqZa08P74wgaXRHtC1gv0o9mTqmGNFBPBW+lKpqGyX7Igb0x01g
 VXyOYJDFJBhCwBlChI97pYs+PBCRKG3yCviXQWO3epFbaoB6Mc0CEtcOJ55tnGW/5ctw
 eZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721686891; x=1722291691;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mlZflGXKhWR3xad+GP9v97GbjDPoqysSj/tIl6ZuNq0=;
 b=cAq2SVRAyHd0cJ5uBZ24mQpm/i5zH8jjL32D+vRLe0Bb2uJVKwQMmY0MDpnXlLBjdz
 6PG7UDHjz586J25LobvP3r/+J249SqqlxdWtAWPON0LCa/RpFwCMg8VTgRuGLwhQTBPI
 WqgMvEih6soZONWly9aYIjObhT0de/YHd1rLqRvQ3IxuWhhZnlT12WJSD+D/gtW6VPTB
 9gb9cDocDkcIHSJ8hlNq/0dT8usuO9Zaj6SDnsUqug5jTOW5LBmsfI1daRCwJHkvwRZt
 VKwjmD6q1A/IhGp/xogRvSVoYapFiEgVdRzSEYk4vf+f25oyiVWlLHjL3sEYB0dIaq+r
 yh+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBLtGkv2BEayyKytlPF9t0UAOGatNeqg5j3BAYgWqh38xuBneXks8pF90TQ2py+AxLyYD32N1M6iSfUShjLmxxS3jL
X-Gm-Message-State: AOJu0YyYdPUAWOtZdJ+cFgIDbCWjFsnBD3VfLMmbmdfupz4ozaQIRpe9
 o72ZJcJxn93zh/ibV7QfsIg2oK7f7EPc/y+syeXi4kh3DvqFt07t
X-Google-Smtp-Source: AGHT+IGKgsUYnR64zdCpMtWv7RqLEmUfl/KU7B0aQWky4Yj1NHnzDm6WwNMjxKl//EUAoPrdVcm6PQ==
X-Received: by 2002:a17:907:9802:b0:a6f:501d:c224 with SMTP id
 a640c23a62f3a-a7a885c0000mr89302066b.57.1721686890264; 
 Mon, 22 Jul 2024 15:21:30 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-078-055-096-080.78.55.pool.telefonica.de.
 [78.55.96.80]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c95101bsm467238866b.209.2024.07.22.15.21.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 15:21:29 -0700 (PDT)
Date: Mon, 22 Jul 2024 22:21:30 +0000
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
In-Reply-To: <20240720143745-mutt-send-email-mst@kernel.org>
References: <20240704205854.18537-1-shentey@gmail.com>
 <20240720143745-mutt-send-email-mst@kernel.org>
Message-ID: <184E18CE-C4DF-4DEA-A20A-84B31833093F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
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



Am 20=2E Juli 2024 18:38:42 UTC schrieb "Michael S=2E Tsirkin" <mst@redhat=
=2Ecom>:
>On Thu, Jul 04, 2024 at 10:58:51PM +0200, Bernhard Beschow wrote:
>> This series first turns vt82c686's "INTR" pin into a named GPIO for bet=
ter
>> comprehensibility=2E It then continues fixing qemu_irq memory leaks in =
vt82c686
>> and piix4 by connecting out IRQs of the south bridges before they get r=
ealized=2E
>> This approach is already used in the pc machines after it had been disc=
ussed at
>> KVM forum `23=2E
>>=20
>> Observe that out IRQs are callbacks such as an INTR IRQ handler in a CP=
U which a
>> south bridge wants to trigger=2E If, as an implementation detail, the s=
outh bridge
>> wants to pass this callback to a child device, such as the PIC, then th=
is
>> callback must be known to the south bridge before it gets realized=2E O=
therwise
>> board code had to wire the PIC device itself, breaking encapsulation=2E=
 This means
>> that qdev_connect_gpio_out*() has to be called before realize() which t=
his
>> series implements=2E Another way to look at it is that callbacks appare=
ntly are
>> resouces such as memory regions which are also populated before realize=
()=2E
>>=20
>> Please check if above paragraph makes sense=2E
>>=20
>> Best regards,
>> Bernhard
>
>
>Bernhard, do you intend to resolve Zoltan's comments on this
>patchset?

Hi Michael,

I was hoping for some more comments on the last two commits=2E These resol=
ve various issues in one go, some of which have been addressed in the past=
=2E Since this is apparently a new style to handle out-GPIOs, I'd like to g=
et an OK from the community=2E

As Zoltan writes the ideal solution might be to qdev'ify the PIC=2E This i=
s a bigger task which is more than I intended to do in this series=2E

Best regards,
Bernhard

>
>Thanks!
>
>
>> See also:
>> * https://lore=2Ekernel=2Eorg/qemu-devel/0FFB5FD2-08CE-4CEC-9001-E7AC24=
407A44@gmail=2E
>> com/
>> * "Remove intermediate IRQ forwarder" patches in
>> https://lore=2Ekernel=2Eorg/qemu-devel/20230210163744=2E32182-1-philmd@=
linaro=2Eorg/
>>=20
>> Testing done:
>> * Boot amigaone machine into Linux
>> * Boot pegasos2 machine into MorphOS
>> * Start fuloong2e machine and check that it doesn't abort
>> * Boot malta machine with https://people=2Edebian=2Eorg/~gio/dqib/
>>=20
>> Bernhard Beschow (3):
>>   hw/isa/vt82c686: Turn "intr" irq into a named gpio
>>   hw/isa/vt82c686: Resolve intermediate IRQ forwarder
>>   hw/isa/piix: Resolve intermediate IRQ forwarder
>>=20
>>  hw/isa/piix=2Ec       | 13 ++-----------
>>  hw/isa/vt82c686=2Ec   | 12 ++----------
>>  hw/mips/fuloong2e=2Ec |  2 +-
>>  hw/mips/malta=2Ec     |  4 +---
>>  hw/ppc/amigaone=2Ec   |  8 ++++----
>>  hw/ppc/pegasos2=2Ec   |  4 ++--
>>  6 files changed, 12 insertions(+), 31 deletions(-)
>>=20
>> --=20
>> 2=2E45=2E2
>>=20
>

