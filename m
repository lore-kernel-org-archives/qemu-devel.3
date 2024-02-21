Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11DCC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 16:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcp69-0001fe-5T; Wed, 21 Feb 2024 11:05:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcp67-0001fP-Fp
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:05:27 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcp65-0007uY-N5
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:05:27 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41279488d3cso2906155e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 08:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708531521; x=1709136321; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zx6plqljoQIbboKQEAZwb0SuHhChAF9JKzhiTrcSu5E=;
 b=dxqYnga4pMPCwsuNdQjdTt/5AaWOT1/kC4z5SZ+Im+7wAIbVckgy0dpms46uoa7rNF
 WpsCyceHEY0tZPfti2fYk4bFiez59iHv63I6YitS74/vLM0V17D48GuvCIoe1lBySXe1
 ydSomL0+b85UGtiWhUma6UJyVcxtfPX/7FFuRnfy+fRhX5JyfAVC6O5YS7prShdHkzPy
 b++ujKupqJ6d58kH0cI3bM7gcL6uT9Q/0TalJd6aVirW9IbHEriCnMbTsC1Ox+kifqkV
 VcuTUYIslhhwumeoDaSt34Kyq4UjZZiRM6EFHA2RFiyRdfW0KMlakHjf5TQBFVVmC9BA
 T5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708531521; x=1709136321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zx6plqljoQIbboKQEAZwb0SuHhChAF9JKzhiTrcSu5E=;
 b=CqWEij8fsgJ1AFW7SHYAhPG+8idP1HU8fsaDo1twiFNKGVYkm7MnmsvU2Mw8E35I3S
 9ct/ECc6Lym4pyRaUEaw2E/M3Gm/81PYfmDh95zYYgZgmgOafvRBbAFYOEhS03SqrfpQ
 cAT1M+JiPhOw+TEQ8ZEpbAbf2VvpkpLzHqZwNNv2sM1idteeqUNplhho2D9/pElrVHHc
 kcWPVYVlcTLVKdD1jtwzii560PgOOjKDpp00EuY/3+59Oid5ZeCQXItbv1iSj3C5qgRL
 5BaIew8g1RQq6LMVF9RmzLEIaMJHWHyau2ymyHHvoGgyQbkZ5ZR3bWuyYl1nDdf2yo/I
 z33A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh0geKVirFRmNYuGLEBdbzoB5Pvm7PD/DXYuFH7VOUbSezqJiNKWaMrV0ZQF9RUjp28Q6CYJM555tBgyhL/W5togfZAkw=
X-Gm-Message-State: AOJu0Ywk7Vk8vzSkji5noA3RBpCGIDhjXpxyqVnXWY4NXGTLd2/tONIT
 2iReD+eYXjK2DuyvuU4VROePJlPzpVbKrG4uaOAqYZ5WgYZjD1vkl2t/DjKYZUsx+u9VXIOthAc
 /LozGrAVDMhISPuSA8hdjw07aGAMsTWVSYKsKGQ==
X-Google-Smtp-Source: AGHT+IGfhCdpOx/T5zL4Y1q0+cH2gGIyW3X8x2K+1VwX/BXhVqs/CW1lgmueHSkxW0I+EN+fyAJjSMIrPL/fr3749dE=
X-Received: by 2002:a05:6000:1f89:b0:33d:4bc3:e786 with SMTP id
 bw9-20020a0560001f8900b0033d4bc3e786mr8636848wrb.23.1708531521217; Wed, 21
 Feb 2024 08:05:21 -0800 (PST)
MIME-Version: 1.0
References: <20240207050308.3221396-1-tong.ho@amd.com>
 <CAFEAcA-JnKM9TCbp5=_Ogsnz+GSO96CcP1T-_5jTrSEXAyXc2Q@mail.gmail.com>
 <BL0PR12MB488255D9C3286058E51CBC3AE6572@BL0PR12MB4882.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB488255D9C3286058E51CBC3AE6572@BL0PR12MB4882.namprd12.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Feb 2024 16:05:09 +0000
Message-ID: <CAFEAcA-fMAuqvw_-asbXrrHLpsh+iC-0u405LJwjCJbxpdD5cw@mail.gmail.com>
Subject: Re: [PATCH] hw/char/pl011: Add support for loopback
To: "Ho, Tong" <tong.ho@amd.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 21 Feb 2024 at 06:56, Ho, Tong <tong.ho@amd.com> wrote:
>
> On Thu, Feb 8, 2024 at 3:36 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > This implementation will send the transmitted characters
> > to the QEMU chardev and also loop them back into the UART
> > when loopback is enabled. Similarly if we receive a character
> > from the real input we will put it into the FIFO still, so
> > the FIFO will get both looped-back and real input together.
>
> > I think we only have one other UART where loopback is implemented,
> > and that is hw/char/serial.c. In that device we make loopback not
> > send transmitted characters out when in loopback mode, because
> > the 16550 datasheet explicitly says that's how its loopback
> > mode works. The PL011 datasheet is unfortunately silent on
> > this question. Do you have a real hardware PL011 that you
> > can check to see whether when it is in loopback mode
> > transmitted data is also sent to the output port as well
> > as looped back? Similarly for input: we should check whether
> > the UART continues to accept real input or if the real input
> > is completely disconnected while in loopback mode.
>
> Hi Peter,
>
> Here is what I found using hardware I have access to.
>
> When loopback is enabled:
>
> 1. Receive is disconnected from the real input and
>     only accepts transmit from loopback.
>
> 2. Transmitted characters is sent to both physical
>     output and loopback to receive.
>
> #2 is also collaborated by commit message for
>    https://github.com/torvalds/linux/commit/734745ca
>
> However, the same message also suggested that
> #2 may not be the case in other implementations of pl011.
>
> I will work on v2 to address you other comments
> as well, with a property for customizing whether
> transmit will send to both in loopback mode.

Thanks for checking against the hardware behaviour.
I think that unless you have a need for both behaviours
in loopback mode, I would be happy to just implement the
same thing as the hardware you tested, and not worry about
adding the property.

-- PMM

