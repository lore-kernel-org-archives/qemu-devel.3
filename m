Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E804109B497
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 04:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7nCs-0007f0-Rm; Wed, 01 Apr 2026 00:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w7nCq-0007eO-Rb
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 00:29:28 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w7nCp-0003s6-Cj
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 00:29:28 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b9c01854477so237386166b.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 21:29:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775017766; cv=none;
 d=google.com; s=arc-20240605;
 b=VpIgQHRiWcHHZ1kOq8Po9iOLmBxkvbvQWpZuM9bQN8LpAy/zWegE5N1z4z/cDj+B3g
 BRa27GHkl8UQ5BJ6KhatxH4iTJdS/9KQ0T/q+rrPQWoAr9cpQtri7xjOQMKWiIxsm4SF
 0Q8kOrqpX18j2QJQp9r+7WKL+UBxBJfu+BoxUMToDV+JfAsxl2j1Fit3mtH5YWIadQSa
 EsjxPpcMY3GhtSvM4FMp0O9Q1ipVS8UcZZbw84TyOlToeESWPreVIgfffXlAqtEmKSic
 o8qY/73MvO6j2lFyuoZkJLwSpa4CT3iFak4lZKYOok8bWAob42vBMrcvygFh23u11n1w
 5OGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YPqA/bUASXpZG25XwMokmmQIn7QQguULiGVdIOsz/W0=;
 fh=kBrIrNwBnT3YwSaF6VkOq2fpPMC+LCt3YygP7Akx7To=;
 b=hX7gaI7WmE+Ov4KMpNOn3v4CnwrraPxH2O/Qdz3fseRqCf9HvCcMmijuQmrDw8TEoX
 V+rjk+SKR/Zod9a3kodb6vRsJRLoNhbqAiN4XjmHxrmmVDTIGk/wYnoAw+oeao4sXISI
 WhfzN+C7tvl1ORpD8hZPdb3xWXh7cmwCI7uT51I1x7OFnFhkJtZOT+M1CxE/uQhIX+5K
 peXIi8AmUhnsI257gGPZ8OduZKQXjQSothey9aUUj/9tv0vuIS73rZV90EdUqv9zCzb6
 OtjcTSmGT44+q6yFHooFvIboYokYdL0KTCKfKrVBDXlRf54gC6+2jh/yHjiU33ya9VKq
 wWpA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775017766; x=1775622566; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YPqA/bUASXpZG25XwMokmmQIn7QQguULiGVdIOsz/W0=;
 b=aDp8ianiBrj7FWpRV5ybp09iMNnEgBD0sPHlLuTOSB02Mt5iFiikLZWCUrVHjyM/W/
 XdmICt5WMTcEH43TUtlOd/jE0wbfxlYAJqro0h7+8lo1O5YzpIoD6DB2Oc+nZXkhYHlr
 l/G/yvlzrW4mdYRECIWM/ORiK1QbrhKzlvEZqsK7zF6HYf3hndRwIKmgOV8dvf81xhck
 0krfYBL5wYBuSxxG6xwUbHDzCWQOEd1UF2+VBxC4oA2PhS+Y+WpYs2Rv/MENqTaKv4RM
 CauKj2OGGxG+Au+RA2CnZdKQD/rpqF6QCkT6zZYAMtRWC6btN6RxgKuxwzNW9mEmcWPF
 5qMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775017766; x=1775622566;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YPqA/bUASXpZG25XwMokmmQIn7QQguULiGVdIOsz/W0=;
 b=tBv0mQg1h2j9KK9dTc6PPyAt/ETd4gVyQQDib2gYJVicug5IupS9hpQtEXVkqWqh8x
 LG/bcjzxLH1nkwUc2Ur1ar4VThWL8fEV6z8AwQHi0Ky8LXhOE134UczFGoXP4tsii4GQ
 olCoh0eOR0E/12/F4mqjTK+4Kntu0BgGTpiTNZy2hDJ8/6tMFVwzyGh3QR7XwU/0lKEw
 8bLoUg1HxeF3VI+Sv5TrUc/8ToesuygPUBRbEegi/C2sqevIWqdQP03w8vgX8uFOmqWH
 xiAOmRYA9HMnKEaWJABZq5t/6ILEALeCjDo4164nJNDuyzyaCmaItrMV0dMPanIa0XMt
 KLhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsEvBwgmvjGoqa95MpASGVP2V+u4dWxYSHTICs++FVl3JMYRD5EyW/jeD01SzBII7/VnCYkI7MFnOY@nongnu.org
X-Gm-Message-State: AOJu0Yx26UOsMDsrnSnrtluMjWXH83wko7oTehbWYkeYvhqcJBrU6i9s
 cCnZx+qCGbM+czPC3PXmciUVQYnBr9DY0j4Z9DO58UV1DHa40dL7HYiGzLjvFPoZBH+YrNVJUIC
 /yosHzHhAbksEygDerOVnTajfoHzVNCg=
X-Gm-Gg: ATEYQzxZHPE7oRrYqkySw5fPzSlRp2iV2EVJP3IMD1iZCO+yJXXlSB8xIT8WQFlC0Iw
 JEvXBF/gN1fWxRjsqK+pky6g3O9ksSrTs75v5jr0iRS5ZQJ8ZplHXGjKQUoF5jBmzl7FjHUyKdR
 iVmesOlkjj1IlU/iev5zqVPkEOL6+cOmpUyt4x2JiadB6OIp/siENqBVxjIkWMIP/x0kbtrajoZ
 Hk7GblacPYOKcf8A0OL9ho8VCLH5T0AjMehORGAiO9+bM8RpwH+QzV3KgPwbQxlWPtaHshDrNpX
 ThYF0vepevQLO/wB+5Nd4gYr3UKFci2+JhPGlw==
X-Received: by 2002:a17:906:af16:b0:b94:1df4:3525 with SMTP id
 a640c23a62f3a-b9c137a9cdfmr91702766b.1.1775017765654; Tue, 31 Mar 2026
 21:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <177393172713.10003.9577410064303581086-0@git.sr.ht>
 <CAKmqyKPPeHOoHoLJhcf85UPrE=sWxjTrW=njz_pQ-+h8+3nWnA@mail.gmail.com>
 <CAPhv3nrf1=miF_cwbAM2AZKSGkJCFgk=3crjaAJ3AwttvVBytA@mail.gmail.com>
In-Reply-To: <CAPhv3nrf1=miF_cwbAM2AZKSGkJCFgk=3crjaAJ3AwttvVBytA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 1 Apr 2026 14:28:59 +1000
X-Gm-Features: AQROBzCZAZAZo7Lemm6y9OxN3tFWE6iStM-Ukfn0P9-2DpiIfI2f4I8OIYZQfN4
Message-ID: <CAKmqyKOnHg-sFLyhUXNH_-ZgUW80fNKniudMKiBP2DD5hroGFg@mail.gmail.com>
Subject: Re: [PATCH qemu 0/1] Update opentitan uart (part of supporting
 opentitan version 1)
To: =?UTF-8?Q?Lu=C3=ADs_Marques?= <luismarques@lowrisc.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-maintainers@lowrisc.org, "~lexbaileylowrisc" <lex.bailey@lowrisc.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Mar 27, 2026 at 9:27=E2=80=AFPM Lu=C3=ADs Marques <luismarques@lowr=
isc.org> wrote:
>
> On 26 Mar 2026 at 02:47:48, Alistair Francis <alistair23@gmail.com> wrote=
:
> > So it's based on my original GPL code. So I don't think it can be
> > relicensed as MIT.
>
> Hi Alistair,
>
> Can you please clarify that?
>
> My understanding is that QEMU, as a whole, is licensed as GPL but some
> individual files have different licenses. Looking at
> https://github.com/qemu/qemu/blob/master/hw/char/ibex_uart.c it has
> the license text from the MIT license, which I interpret as being
> MIT-licensed. That was also the case when Lo=C3=AFc created ot_uart.c bas=
ed

Oh! Sorry about that, you are right.

I didn't include a `SPDX-License-Identifier` in the original code and
when I skimmed the license I assumed it was GPL.

> on ibex_uart.c. Is there really a relicensing happening here? I
> thought we were just keeping the existing MIT license.

Nope, my mistake.

Alistair

>
> Lu=C3=ADs

