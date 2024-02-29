Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DA4C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 12:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rffu2-0007AZ-Ks; Thu, 29 Feb 2024 07:52:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rffu0-0007AC-EC
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 07:52:44 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rffty-0005SX-QP
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 07:52:44 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6e49518f375so338588a34.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 04:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709211159; x=1709815959;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oHTVTTDri3Dv7ne75aSXP/TxxAgMlWxOwcQ4Dft0o6c=;
 b=r+2I9QLf2W1WTuckD+JB3PyHJ51V0rhe6+CeY5LpyP7w8tR26EULD7iKqDBMNyrQxs
 4GjqwvXEZX+V5UxHz4VbU3JzfDvsVzi2YwZKBRzhhIZEXkHmgv+sGovH5B0SrHFIffVb
 6oU28bbok7yIq3LzbWfCVWVVgwokQpiV574Lye3c1fOUAKcKv5TjM85GmWV3vti19Ax5
 k2Xx56G9s9ataUrG3WW5cAQAzTlYgLBlQ+P4IPEL7WGaZepPhGUhf/4ZHoI2CtC7VKem
 Bn5rK+pSe5db7eAfkoJRQGec9Kb29tTYLqkOmKnOtNZtskIGXXXqj4f0LSah6Lm7D23A
 kTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709211159; x=1709815959;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oHTVTTDri3Dv7ne75aSXP/TxxAgMlWxOwcQ4Dft0o6c=;
 b=EpU3n7I+Cwa5PUAiuqGTuSuq9NvAz90HMq7B4Ke+cGS4TLKQ0XSOC6zZU/2L1zmlCV
 2JdITgzs91mZf0SIHKakvnHcEJD/MZAeTlsLe1kNx/BZjZn8MwjhmF6q0dgZlDhX/brS
 aDRuXiBa72mPhIXsYJbKqqZYXPPOQWe8F343XkXgI3z1NDrvRN4lMQ1nso8A1qp8Mao5
 ppjavD4e4w0xlFAS6V8mXhYBp+MV9Sl6P/LY+DLY7lxj3Tor/Cq7rf8x91OJp3/1R5tk
 2VTwoCicegi8b08EBN5eY5ThewajvFfPKU9owlC9eWUYPA+fWGdy+TE/bEvFmljtzQgc
 yFRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFjCBhtqSke6DeYhfufeheQm6QeqS9gU9gMq9gG1UZ3HCy0SatevomIlUYS/PvsLPx03b82wYkmP6CguIMLzGrk1KROnM=
X-Gm-Message-State: AOJu0YyedT52jpMscelax2MJuGOpJ6pDbEHKHLGNuMl1rDAjDr7J8y1w
 /AFQqYe4XOJ80hOBptWG2JPMnjmfwfXs68kWgWYCUbo/dwIa1FbjP5Y+tFylAxuKXNTEokSFdS+
 OrwR6JMeWeykGzeVcXLedybu8dZ28rmBNxhdcUw==
X-Google-Smtp-Source: AGHT+IHNopRgw+xQyI6kWsZiMeHj/6D/OSVhJ0jG5RxP44GxhUlCzzcRpmKKr+y9FURachF6TjLhs9a7tk2ajXaWEtQ=
X-Received: by 2002:a05:6870:b601:b0:220:8d0d:e25e with SMTP id
 cm1-20020a056870b60100b002208d0de25emr2050143oab.47.1709211159314; Thu, 29
 Feb 2024 04:52:39 -0800 (PST)
MIME-Version: 1.0
References: <20240228125939.56925-1-heinrich.schuchardt@canonical.com>
 <fb6ef90d-4a3e-4bdd-8516-8b15c1f2329f@linaro.org>
 <b9937680-8c0b-46f6-86ef-55139562e2c4@canonical.com>
 <CAFEAcA_Bshua2BQTfOb3D1aF27ayELEt9TcQM8hkQdKaih3xHw@mail.gmail.com>
 <9c64be5c-25b8-421d-966a-bdac03dfe37c@canonical.com>
 <CAFEAcA92s+3Q3ud=zOjsyvuqZ=BjwXt3OY0n5mO_iDXovQpoRQ@mail.gmail.com>
 <20240229105900.0000490e@Huawei.com>
 <CAFEAcA_O2QPwCPE0HS9g0saEA3XbuVS_UGtRpe_o4tLRrc6Ksg@mail.gmail.com>
 <bf3e44c8-a6ad-48b6-8825-ba8ce0dd19f8@canonical.com>
 <CAFEAcA85nwJ-qfzFVYBY0kiD7mEtr5UHRD_X_s=Vv7eaoHD_bA@mail.gmail.com>
In-Reply-To: <CAFEAcA85nwJ-qfzFVYBY0kiD7mEtr5UHRD_X_s=Vv7eaoHD_bA@mail.gmail.com>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Thu, 29 Feb 2024 13:52:28 +0100
Message-ID: <CAGNS4TbE8dyUv0OkwwY=g2=qea_mxj07=0W4macVRXsBMicgCA@mail.gmail.com>
Subject: Re: [PATCH, v2] physmem: avoid bounce buffer too small
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=mnissler@rivosinc.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 29, 2024 at 1:35=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Thu, 29 Feb 2024 at 11:17, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> > > But yes, I'm not surprised that CXL runs into this. Heinrich,
> > > are you doing CXL testing, or is this some other workload?
> >
> > I am running the UEFI Self-Certification Tests (SCT) on EDK 2 using:
> >
> > qemu-system-riscv64 \
> >        -M virt,acpi=3Doff -accel tcg -m 4096 \
> >        -serial mon:stdio \
> >        -device virtio-gpu-pci \
> >        -device qemu-xhci \
> >        -device usb-kbd \
> >        -drive
> > if=3Dpflash,format=3Draw,unit=3D0,file=3DRISCV_VIRT_CODE.fd,readonly=3D=
on \
> >        -drive if=3Dpflash,format=3Draw,unit=3D1,file=3DRISCV_VIRT_VARS.=
fd \
> >        -drive file=3Dsct.img,format=3Draw,if=3Dvirtio \
> >        -device virtio-net-device,netdev=3Dnet0 \
> >        -netdev user,id=3Dnet0
> >
> > This does not invoke any CXL related stuff.
>
> Hmm, that doesn't seem like it ought to be running into this.
> What underlying memory region is the guest trying to do
> the virtio queue access to?

FWIW, I have seen multiple bounce buffer usage with the generic net TX
path as well as the XHCI controller, so it might be either of these.
Bounce buffering should only take place when the memory region can't
be accessed directly though - I don't see why that's the case for the
given command line.

