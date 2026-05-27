Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE32CD5BC9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBiv-0007bv-0l; Wed, 27 May 2026 06:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wSBit-0007bc-9T
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:42:51 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wSBir-0005Jq-KH
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:42:51 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4903997fcb5so60733655e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779878568; x=1780483368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBZPSB/Yj/ayi0IgH3V5as1qAK4wfKZ+qn+MumQvJyk=;
 b=RkW1cBHZR+BNTwNL7ooK3K7/8IxrCmeUsARwK/DEyvm1p4ZApOc8iNkfzz1AmcCOoB
 CIP8rKAPy9j7XKnxbXNTItMX9z8IKkuXP4Pm8AfDpc3epjvvmGACyBMJSUB+lKL7gWCa
 f+M0aIrBlbGo3/lyR2DEgKWcosfw5951Qev0B5qodJsz+UcNgLC5aebQ2l8hD+gnfYn2
 Pdm3FnG8Z/TtavwUSaO3cYSMS0IvmApNqRZseTMiSfMUtj1i3zw41/kGLmpsOxe8pXlz
 I+/gdUgg2+9/oNkKkjNKcsl4ThCSdVA+jjEDHZ0u8CsVDFuwrTCkypUcEyXk/X8KBkao
 Idvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779878568; x=1780483368;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wBZPSB/Yj/ayi0IgH3V5as1qAK4wfKZ+qn+MumQvJyk=;
 b=nvqFU4SQGqdvIBziLuZNa1H5Kn58gkVNdBD2r2VeygSkhSJn61E4VoNQVDtbuuoHAC
 TjYbYoxKY6tp34zZh+/WX5IHFqocBzu70aNGug3bSG0+XhFs03gWpEVixtDJf6H2p0aM
 NgdYFTsZOYK7KX1mx9c4pg0LU9rbXWgOHCc6jjAZSz054hDfU8nxKQ2ZLJpUk9/HH3ou
 F4MtnirLmUeXY34cIxlP1zfuUJzv1Kr+34c2b/T8QqE4+CL8Z21WGRaZ7UWB20ymiChi
 9tFJiQGPBmiONlhvjjI2ycy+SRaTQbuQRs11a1x0KoIu8t6yWIAsf4YxtPTi+F2Buxpr
 43BQ==
X-Gm-Message-State: AOJu0Yw3D/Ks8tqXxTeDcXZTg6gUq8llnpZQCOTYUyuaRtl3EgLkt5Hv
 5oZHBaWu2Lxg8ViErUZF5JrdrJfNwzclr6Ialjw3cdqInMrR6c3JnSDz
X-Gm-Gg: Acq92OFe0oV80hCJi9jOeweKjOmlBiZuZyUxQtF6+iK0njfD2Kb5LMyImUQ4UJpdpW5
 hQkKyjRGWO8xlnOU0V10FGr1qcHTzzrVj7nh4FsaYNKqdMhmv5uPAfQSR8uupqgTbs814jZxGcK
 Gt8aZXixANziVaSzg14640PpxAVchLdb2tM6WB+8qu0J0vq2BTu1fdBocIY5NBa0qIG14PRMdW5
 zOfGfBGZNAlZg7SU38ZblMaNuAYUJoPhFuBB+jj4Qqz17Eof4JHlGgGKV9/KJ11MnLHM++KwqUf
 IxvoKi5thDHKxdaOzbgNiVaSdAK+jSQxwiOhyNfJuOUbirWKyw9jvjSvopokTdea3FxQOAz38Y6
 zhgxQoLWgi2FNxvEixeEecxD0JphVb+FpccF/hiXo85VSSq5vfKXoIX88B4LNbOcvHclWbVZ0BQ
 4GTMsAzsdnOYyni4BAUP9gWIGMLN0Z
X-Received: by 2002:a05:600d:6447:10b0:48f:d5b8:5b07 with SMTP id
 5b1f17b1804b1-490426c5b1emr271376255e9.20.1779878567601; 
 Wed, 27 May 2026 03:42:47 -0700 (PDT)
Received: from ehlo.thunderbird.net ([62.214.191.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4907e627b1csm23452065e9.0.2026.05.27.03.42.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 03:42:47 -0700 (PDT)
Date: Wed, 27 May 2026 10:42:23 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?UTF-8?Q?Maty=C3=A1=C5=A1_Bobek?= <matyas.bobek@gmail.com>,
 Pavel Pisa <pisa@fel.cvut.cz>, Matyas Bobek <bobekmat@fel.cvut.cz>
CC: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 0/7] hw/arm/sabrelite: Add FlexCAN support
In-Reply-To: <CAFEAcA95RcGhhN8ZqVeOgRyhRqSar23EnJhCjVgKBwoqXBJwjw@mail.gmail.com>
References: <cover.1777571962.git.matyas.bobek@gmail.com>
 <1B6ED5DC-6808-4A41-B8FA-B2C97C5C8933@gmail.com>
 <CAFEAcA9kQNdx=gwSd_Ec=R2nwegT1R-BEiC9yXvfr23VJHDZiA@mail.gmail.com>
 <936E6AF6-32BA-4236-B8A2-0A8E8748D9C1@gmail.com>
 <CAFEAcA95RcGhhN8ZqVeOgRyhRqSar23EnJhCjVgKBwoqXBJwjw@mail.gmail.com>
Message-ID: <08A7BC6B-7019-45C4-B581-0A26AD3AA554@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
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



Am 8=2E Mai 2026 12:10:21 UTC schrieb Peter Maydell <peter=2Emaydell@linar=
o=2Eorg>:
>On Tue, 5 May 2026 at 21:21, Bernhard Beschow <shentey@gmail=2Ecom> wrote=
:
>> Am 5=2E Mai 2026 18:41:52 UTC schrieb Peter Maydell <peter=2Emaydell@li=
naro=2Eorg>:
>> >On Tue, 5 May 2026 at 19:03, Bernhard Beschow <shentey@gmail=2Ecom> wr=
ote:
>> >> I guess the only open issue is the licensing of struct FlexcanRegs [=
1] which originates from Linux? How do we proceed here?
>> >>
>> >> Best regards,
>> >> Bernhard
>> >>
>> >> [1] https://lore=2Ekernel=2Eorg/qemu-devel/202603211316=2E18181=2Epi=
sa@fel=2Ecvut=2Ecz/
>> >
>> >Could you say what the problem is? In general there is no problem
>> >with taking header structs from the Linux kernel, as they are
>> >GPL-2-only and that is a QEMU-compatible license=2E The relevant
>> >source files or pieces of source files would need to be noted
>> >as 2-only rather than our default of 2-or-later, but that is
>> >doable -- we already do that for other things we have borrowed
>> >from the kernel=2E
>>
>> In https://lore=2Ekernel=2Eorg/qemu-devel/f3cb3166-c3f8-4ed8-8c9a-cbf48=
b071d1e@gmail=2Ecom/ I raised this review question: "The following structur=
e looks like being based on Linux=2E Does this affect the copyright of this=
 file?" I was just asking for advice and I'm glad the solution is that easy=
=2E
>
>If the struct was copied from the kernel, then it's GPL-2=2E0-only,
>and we should just note the license and where we got the code from=2E
>
>If the struct is just very similar to the kernel's one because
>it's the obvious representation taken from the datasheet, then
>it's not related to the kernel code and we can treat it as
>GPL-2=2E0-or-later like the rest of the file=2E
>
>Since Maty=C3=A1=C5=A1 says in the cover letter here "the headers (struct
>FlexcanRegs and flexcan_regs=2Eh macros) were copied from the Linux
>kernel" then we're in case 1=2E
>
>You can mark this up by having the file's SPDX tag be
>"SPDX-License-Identifier: (GPL-2=2E0-only AND GPL-2=2E0-or-later)"
>Then have a normal comment in the file next to the part that is
>2=2E0-only that says
>/*
> * [This struct / the macros X, Y, Z / whatever ] are borrowed
> * from the Linux kernel, and so (unlike the rest of this file)
> * they are GPL-2=2E0-only=2E
> */

Ping

Any news? With just the license issue remaining, it would be nice to get F=
lexCAN support into the upcoming release=2E

>
>thanks
>-- PMM

