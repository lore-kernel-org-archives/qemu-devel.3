Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E0CFF8864
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 02:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHYJ2-0004h3-2b; Mon, 27 Apr 2026 22:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHYJ0-0004gF-FE
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 22:36:10 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHYIy-0003xQ-RM
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 22:36:10 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ba7a1cc0380so1801885766b.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 19:36:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777343767; cv=none;
 d=google.com; s=arc-20240605;
 b=i/ph0T4N8KC4K5xodKBYv7rrbuiEjOpkcNKnCRhf/UyqHaRoans0yMcpoyYoNw3M+U
 0nyd7tiDbPQzjdXYdro4Gu4IVEHXRq11mu6+4TkNFlLdqfuhNbJYZ7tCxsSC+HzwGVHz
 TLGocwi227/9fkNihJQfUm5EA5PW36PMhavVGs9s318/l8xvcNCQqJuagellrXV8oURI
 +ig37cqhw2HgxfPQpQazw+6Ll/sBAxjwEpBGTwQPKgSfosrkDrFA9ZUfKsa5DKBGfBit
 6EBX1z513dD6S9qjQGpR9w3gWfyHBoYZdBrYElki2vewVe8o1lEYtKJxd0JpveEPMP6x
 FPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jG0Y4wFgl72gA/gCs/7dJrAzHseJfY33FNGt5ks1dTc=;
 fh=0dOTIuTyzEIiTjyFATP6u7C827gDBi300AxH2fVhHVY=;
 b=UbWu2bYMxOXF+Uk+wy3p0LHRp5mt7+Hjyz49kWw2vfFf/qoj727XPFPj5f2czHMRri
 oVGdv7hXJ3OAn68sJ/aze/aWtWW5hr3+WSBXT6uAbEoBPDR/XtDawcpDeK+aicrpfnp3
 a9nKNwXlBLutEX/lWp8Or+Gc1xix18fV0wYkOmLKctXmwhcHygPgT5O7zApe4/5FCaA5
 BVWO7lVYkKX1aXR4sQEdz6C+hHmnDNw7Qu6qTDmMpI6NkhnNEVsusCfkBQLjimGjD685
 Wvmgb8JwodFQhC5Nop8FRTiJT4+UO73MzLyc7duIlyvIJZZQzBCK12ioMRSdm07MnssW
 KkrA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777343767; x=1777948567; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jG0Y4wFgl72gA/gCs/7dJrAzHseJfY33FNGt5ks1dTc=;
 b=icCHEXLvBDaDZZKaUpcEJW9vp7bWjnzbkFYhfM777RChpNXRP7fQ9p77DluirIA0F/
 pvYyToxaF7itEVV5qDDwCftYzkspYOH3B6Isrc4o5KCwQGxaFr6cIAfE8f3TJyCgixLc
 nrJ66tKBMj9pXkrsmUTbjmADxKIdF9eEiWzdALQx5jayuhmobILqMcJ2hIo/EgQuvnzD
 u5YnEHG7KtO4pfieqHvMGzFiDWwL1hlyKuFKsHoNSC813lHTaqT/Ns24bN//CmhrbdZ6
 2XES55zYSdW40BOF3PTUm7W4CCQ0DIAjGtBu6CGxPDAXM9d1CAX1Y9pSe//MlWjhzJZE
 PIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777343767; x=1777948567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jG0Y4wFgl72gA/gCs/7dJrAzHseJfY33FNGt5ks1dTc=;
 b=qQnn92Pq0rocQiqo4mJMOFmSmkQlKrDTkjvufcMWta8JFqVVKW5h1eGVA5k4EHsYxh
 iP5SbxnKa560Zn4BvtWwkWpDPt9mnIesvt7+jErROq+T2QxLim2VBQVLWkoqEwKoFQwp
 wLrxCT5QH/Nclb8ybQewhZ6f0cVQfEA++g0fz1MmFPL+0zibWIKS5P97UmzG5xtkBfQ0
 NSB3TCuzYOs4BYIP7fRDJa6YmefiTcrq7khngWaFPTLkHkwJO8NBxkacGi5j75kwiEg5
 PlK14/2P2r5cMocumpLN0/phGJ6kXPJz03KiCNgHA7d9BR0TnPKrla8JofoTB/b4uWL1
 DRzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ZE6qRIQbUp0FHsWmcRMSQYFpK9WCdgZes0qLo9T05wBUhnDUqjv+h32EZ4lJe8wLTVhypjS4SzYey@nongnu.org
X-Gm-Message-State: AOJu0YxtWxOLj2z94BGRNNURB5MP8Vz09NkulKUhgmmR+5A5cJO0thHb
 5zHh+apLySFgmEOB4SuW1N54avsSIhLZfEeeCCGok0ScQkeK6XUBlIzFh0uhXL91dTwu09SrFXn
 DYOafkVO96vwVU7F3Yy3aBOAUiKSTZok=
X-Gm-Gg: AeBDietzL0JwOlBX41LUpYuMVuHsY3nXixjllSHxou5+nJT5Ly3rJi3Vn0xupinyWub
 2g1RalyvmOTCP3A1xbg2E4xIo1MdHfrYl8UoNMjarPTj+zgyTb3EMy57n7eEItiQpfPCXYXtnmp
 jlmsFTzzLtNuN4w4t96wz2BANk2HjBYKdv2c9/CxHiljOZb6OmVVuhxhzeB8cCHb7Juh4auHqgR
 vPdBWQY36gFKygdBx96uEU9+0NjHzGOtyx7IDGmEBH4rk57pGfWs+nWbToIRPcfnfF3mZrKo1kp
 6mvd9o+wXHpsDZS7J+mvUagmWGVKdTsOhRShj43UYMuXA6+8
X-Received: by 2002:a17:907:6d1b:b0:b9c:3d56:e4ec with SMTP id
 a640c23a62f3a-bb8037784famr63528466b.24.1777343766983; Mon, 27 Apr 2026
 19:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <177618728515.4917.14466194789826252277-0@git.sr.ht>
 <177618728515.4917.14466194789826252277-10@git.sr.ht>
 <CAKmqyKOKNQwNtzX+wHepEX4OpVqAA2pkXfcP18k=8Wd+8ZM06Q@mail.gmail.com>
 <460c22c9-b9bb-4e68-a793-85ddd598a311@lowrisc.org>
In-Reply-To: <460c22c9-b9bb-4e68-a793-85ddd598a311@lowrisc.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 28 Apr 2026 12:35:40 +1000
X-Gm-Features: AVHnY4Kd8Phtwm5J_tqLyfN1o16kaW-xw8PC0dAFa3LYWGD-LScgYrRLstupINw
Message-ID: <CAKmqyKPJf9fV=pX2BSmy+trdQRGZeW+A+V9BOovtCqP8TEj6hg@mail.gmail.com>
Subject: Re: [PATCH qemu v3 10/10] ot_uart: switch from clock driven
 transmission to reg R/W driven transmission
To: Lex Bailey <lex.bailey@lowrisc.org>
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org, 
 Amit Kumar-Hermosillo <amitkh@google.com>,
 nabihestefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Apr 23, 2026 at 1:39=E2=80=AFAM Lex Bailey <lex.bailey@lowrisc.org>=
 wrote:
>
>
> On 16/04/2026 03:21, Alistair Francis wrote:
>
> On Wed, Apr 15, 2026 at 3:22=E2=80=AFAM ~lexbaileylowrisc
> <lexbaileylowrisc@git.sr.ht> wrote:
>
> From: Lex Bailey <lex.bailey@lowrisc.org>
>
> this commit removes the need for the timer by instead transmitting from t=
he TX
> fifo any time it has data in it and it is enabled. This case can only ari=
se
> from a write to one of the registers in the UART, so the device will stil=
l work
> fully without the timer.
>
> From memory the timer was included to more accurately model real
> hardware, which doesn't write instantly and instead has a delay.
>
> I also remember that if we don't have the timer and delay the UART in
> Tock wouldn't work, as Tock expected a delay between writing the
> buffers and the interrupt occurring. Have you tested that Tock still
> works after this change?
>
> Alistair
>
> I have fetched and built tock and run the earlgrey tests with qemu.
>
> I tested three scenarios:
>
> 1. Running on the same commit hash as runs in tock's CI.
>
> 2. Running on the commit upon which I based these changes
>
> 3. Running with all my proposed changes included.
>
> All three of these produce the same output, which comes through the UART =
on the opentitan, and I have checked to be sure it is using the new code in=
 the case of scenario 3.
>
> I'm not sure what exactly those tests do, and so I don't know if they rel=
y at all on any of the interrupts, Is that a sufficient test? Or is there s=
omething else I would need to test for this?

I think you would need to run applications on top of Tock with lots of
UART output.

Why not leave the timer in as it helps more accurately model the UART?

Alistair

