Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F49C27C44
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxQk-0000Rm-QE; Tue, 28 May 2024 10:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxQi-0000Rb-Ff
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:03:57 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxQg-0006EF-RG
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:03:56 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57883b25b50so1030742a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905032; x=1717509832; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+mJJ9KRbOi6yXGkWEMga4XC9YzRrIKnUkrfuNGlnj+w=;
 b=A1O3E6igY752S9RB+Lb7Jei14pJlOhEC9yeCzFdY6amXnIxixAx2ISjaBdHibCVlLI
 WDEv44hnwgOqnyTFN7g2D2B51fs9tYIrnRFMrotx3vG8DPYQzYDThxRpWwzmaQAWADpD
 yNH00vjfg1SoN3MplpOL5y6hSwywkZQgGnMVUV9VoxTfbcJ3rCQOIzszoPB/CbQ2muUM
 Hb8Du0ga0xYhC7uUtbIKSM+1TP8Dy0/W0eKqsDQmqXaXArQZqrhzMdBNQT2Bc0uVJzhy
 +eG5d4pJw76h74uxV7O8Ts6/L7ct/SAyipmgLHqVkJ0M8z5/LIjjcHxtGZSCQqSCzq+i
 TG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905032; x=1717509832;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+mJJ9KRbOi6yXGkWEMga4XC9YzRrIKnUkrfuNGlnj+w=;
 b=IxX6n2Qx4ze6r2UHGoY5lQmg9do2Aq5X00KKbYf3PnZ83oMsTzIYhm4RowKAV/dzh6
 9VtQUmLNyQqPUkQczAYx/hrkiPir6I6T/24wl/r9U0EmPumPOfgKuchcIDc0bCI6wDQ0
 cIX5Vtj9vtJTuQuwPoUqsfRStbURA1asnuL7Rs0ximzR6Ftad8ciClT+ec9vjNnzTZ60
 fifNZSAQxoAuepvXYYMWfhPJ5eyqnE1VMQzJNxsceFqsy+KUIPgZnntgLqyx7DKxGFJS
 PyHLw6XvRf1emjE3GJt3qOHtCZJdYRE6BbEWxSyH/n4oCW8JQEbr5QkJ8OxYaHSGnsnv
 8sxg==
X-Gm-Message-State: AOJu0Yz5VY6RtZwLKuUaSwZ+MMkl3qhic892zKsHXS4kVu7ItpNJLNkN
 MAtwV9eEAtcYB4PzBT5ZdtkvPsQlJhK1KKi/MqTvrymU9xLnZml/sjrfJT5WpkFQ/NEfr45Rkaw
 20kpuXU2p8vQxGjAQ0sRPPggL7Sw5SnOiK+CvWA==
X-Google-Smtp-Source: AGHT+IEdjHhJEGHHCsWT32GTtPtxW/JBR4qgKnO/z6EZ+w+7T6cP0HMaoeQhqrMD/Q0ZWN04lk8AkRFYQ5EGrXaZBM4=
X-Received: by 2002:a50:9e67:0:b0:578:5f58:80a2 with SMTP id
 4fb4d7f45d1cf-5785f588378mr7165076a12.7.1716905032626; Tue, 28 May 2024
 07:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
 <CAFEAcA9aum5+z3sr-OpCHZRWxFtZGS_kGOjjmRh7H1TBTZuFRQ@mail.gmail.com>
 <CACBuX0Q3TMvmxuuAHfVY679wpKF+0N+-aw=A7PLiba7ndc5v+w@mail.gmail.com>
In-Reply-To: <CACBuX0Q3TMvmxuuAHfVY679wpKF+0N+-aw=A7PLiba7ndc5v+w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 15:03:40 +0100
Message-ID: <CAFEAcA9XvHOF22m-9ZFtKLAaShE5gVjsy-AxQyBwVAkRZ2QW6g@mail.gmail.com>
Subject: Re: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
To: Cord Amfmgm <dmamfmgm@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 20 May 2024 at 23:24, Cord Amfmgm <dmamfmgm@gmail.com> wrote:
> On Mon, May 20, 2024 at 12:05=E2=80=AFPM Peter Maydell <peter.maydell@lin=
aro.org> wrote:
>> For the "zero length buffer" case, do you have a more detailed
>> pointer to the bit of the spec that says that "cbp =3D be + 1" is a
>> valid way to specify a zero length buffer? Table 4-2 in the copy I
>> have says for CurrentBufferPointer "a value of 0 indicates
>> a zero-length data packet or that all bytes have been transferred",
>> and the sample host OS driver function QueueGeneralRequest()
>> later in the spec handles a 0 length packet by setting
>>   TD->HcTD.CBP =3D TD->HcTD.BE =3D 0;
>> (which our emulation's code does handle).
>
>
> Reading the spec carefully, a CBP set to 0 should always mean the zero-le=
ngth buffer case (or that all bytes have been transferred, so the buffer is=
 now zero-length - the same thing).

Yeah, I can see the argument for "we should treat all cbp =3D=3D 0 as
zero-length buffer, not just cbp =3D=3D be =3D=3D 0".

> Table 4-2 is the correct reference, and this part is clear. It's the part=
 you quoted. "Contains the physical address of the next memory location tha=
t will be accessed for transfer to/from the endpoint. A value of 0 indicate=
s a zero-length data packet or that all bytes have been transferred."
>
> Table 4-2 has this additional nugget that may be confusingly worded, for =
BufferEnd: "Contains physical address of the last byte in the buffer for th=
is TD"

Mmm, but for a zero length buffer there is no "last byte" to
have this be the physical address of.

> And here's an example buffer of length 0 -- you probably already know wha=
t I'm going to do here:
>
> char buf[0];
> char * CurrentBufferPointer =3D &buf[0];
> char * BufferEnd =3D &buf[-1]; // "address of the last byte in the buffer=
"
> // The OHCI Host Controller than advances CurrentBufferPointer like this:=
 CurrentBufferPointer +=3D 0
> // After the transfer:
> // CurrentBufferPointer =3D &buf[0];
> // BufferEnd =3D &buf[-1];

Right, but why do you think this is valid, rather than
being a guest software bug? My reading of the spec is that it's
pretty clear about how to say "zero length buffer", and this
isn't it.

Is there some real-world guest OS that programs the OHCI
controller this way that we're trying to accommodate?

thanks
-- PMM

