Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941ECD68BF9
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 15:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tChTZ-00061w-Vw; Sun, 17 Nov 2024 10:46:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1tChTV-00061N-Vl
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 10:46:11 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1tChTS-0005uC-Vt
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 10:46:09 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9a0ef5179dso661213966b.1
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2024 07:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731858365; x=1732463165; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qt/fMxc6dzaFHqdOGIprWloj5gANdSerbQx5+PbZzHo=;
 b=NG5FISspK3tCKCj48jqcmS7kmug8gjXFygIbkVg5M6ff55txTfNLYq6PKTeHRNzL6x
 JV86fAXpj7DF1LmAdXV0JHNV+ry7p0F8ax0pDF+6Vrf7hk1n9Yh1n+VhXCsSn8J882cX
 LgSwEg0h5S/acDgvDqJjv9fLEk5v2EJJbSpmz0DTz1HZlxbReHP8cpT4kxkbLpxSAspL
 XI9QRwDMuBHpkC00fFcwgTb4Y1zRKuB4SqLF5IcNXUGcHcPe2xF47eB//GKTJMPe4ka5
 Q6hR3SbtWqvpR8AMheN52SHiV2eDQldPfRyZP6onESkUuQnXSo16cBiWIk7bE5CtgrIp
 qBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731858365; x=1732463165;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qt/fMxc6dzaFHqdOGIprWloj5gANdSerbQx5+PbZzHo=;
 b=UZGCG7jWslahlfgvwiYHaOc2h3AGNAOAu+mL1v72tlvWc0uBmIBGiVL32C+0iSNJy8
 lA0AaTLZGQClu31DS5PZviq4LcE4I4B6qN+Dq8+7s0gGc1QNekue2WBQVHkkITluPQby
 AmgmBZPVOKQ9uY2CjxIcG3KuId5JFn9Jtcv+qWdw4hTqOuz7/Nm5N45bajZ9+ChgArJo
 ah2nT7DM0JRu8l9Ug6HcvpwLG/ZyMOWsd5AUNhBVqgFYUjVnsndpt3G3Tac2m2PKO5bs
 nQg0wOqedo6xBBjrFKkSCzPe059/+PW3XwDQ1MO7xRAFOiEtZmeeISaclymQPVNcN8px
 XIXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu4tiwLhiHyG1ucCem3Lx+k2X7cSmtJ18zZKDcmvZ/fqL4OaIqZBObnem+qlMh2AOjyCHY0bCqc8I4@nongnu.org
X-Gm-Message-State: AOJu0YyXx9YUNqEIzafvlgSt/KqIPJ7grkBC/OiTLWe/zlbk0CQB9yvX
 WgTBzM7LQJAKysvrdxqbAtKpRC8bFoqn9BcHx3XCjHGKZv5hOydCpOb7csKDF20Whg9js+iMghs
 loFwc6fEBjKlpAEQ23HwFtgi8y+WuhJXURoa4gQ==
X-Google-Smtp-Source: AGHT+IE7UgFA1Lg9VieAvw9s0U+CVancl2jMf6S+VYWksBOKQIFdFI3OtC+3WKyAe0+BpsY5dkVzUJmYp2EC945omZM=
X-Received: by 2002:a17:907:608a:b0:a9e:c947:8c5e with SMTP id
 a640c23a62f3a-aa483552958mr901831466b.57.1731858364956; Sun, 17 Nov 2024
 07:46:04 -0800 (PST)
MIME-Version: 1.0
References: <20241116221757.3501603-1-manos.pitsidianakis@linaro.org>
 <CAFEAcA9m7EnMX+=T0TL2R_NCJqaPUPCUcoYzAo4P2oRUZbM6Kg@mail.gmail.com>
 <CAAjaMXZE+KKJnvcMpmpaH+dmO7MQVmJm7pD+i1yo_5Wb9-ERcQ@mail.gmail.com>
 <CABgObfadfaohQNf5AheVAUSL5G8i9+zeTOwXRPhOwC_6NpTvmQ@mail.gmail.com>
In-Reply-To: <CABgObfadfaohQNf5AheVAUSL5G8i9+zeTOwXRPhOwC_6NpTvmQ@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Sun, 17 Nov 2024 17:45:39 +0200
Message-ID: <CAAjaMXZboQ-4yxtUVtTWsweT0QXfS4FT5JgLMMr-2XjZ9uBWvw@mail.gmail.com>
Subject: Re: [PATCH v2] rust/pl011: Fix DeviceID reads
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 "open list:ARM SMMU <qemu-arm@nongnu.org>, " <qemu-devel@nongnu.org>,
 "open list:ARM SMMU" <qemu-arm@nongnu.org>, qemu-rust@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sun, Nov 17, 2024 at 1:16=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
>
>
> Il dom 17 nov 2024, 11:21 Manos Pitsidianakis <manos.pitsidianakis@linaro=
.org> ha scritto:
>>>
>>> This seems extremely verbose and rather obscures the fact that these
>>> registers are a set of adjacent simple ID registers, compared to
>>> the previous code which defined them as an array of values.
>>
>>
>> One could abstract them with declarative macros to reduce the line count=
. WDYT about that approach?
>
>
> No, this is just overcomplicating things. Like Peter said, just use array=
s. Copying from the V1 review for reference:
>
>      const UART_PCELL_ID: [u8; 4] =3D [0x0d, 0xf0, 0x05, 0xb1];
>      const ARM_UART_PERIPH_ID: [u8; 4] =3D [0x11, 0x10, 0x14, 0x00];
>      const LUMINARY_UART_PERIPH_ID: [u8; 4] =3D [0x11, 0x00, 0x18, 0x01];
>
>      /// Value of `UARTPeriphID0` through `UARTPeriphID3` registers
>      const fn uart_periph_id(&self, idx: usize) -> u8 {
>          match self {
>              Self::Arm =3D> ARM_UART_PERIPH_ID,
>              Self::Luminary =3D> LUMINARY_UART_PERIPH_ID,
>          }[idx]
>      }
>
>      /// Value of `UARTPCellID0` through `UARTPCellID3` registers
>      const fn uart_pcell_id(idx: usize) -> u8 {
>          Self::UART_PCELL_ID[idx]
>      }
>
> Paolo


Nope, it's not overcomplicating things. `idx` is usize where we have
just 4 registers.

I will submit a new version

