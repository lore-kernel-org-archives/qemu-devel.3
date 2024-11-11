Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BF1D12D6D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 04:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tALeD-00039s-QA; Sun, 10 Nov 2024 23:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tALdw-00038m-8C; Sun, 10 Nov 2024 23:03:16 -0500
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tALdu-0001Tp-EB; Sun, 10 Nov 2024 23:03:11 -0500
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-84fd057a973so1563185241.3; 
 Sun, 10 Nov 2024 20:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731297788; x=1731902588; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ztGyt7G/lk/IdphWSkD54uzddliF65o1hIUoaXDkWno=;
 b=H4/7aN0yjuwB5lC/RUK/R78OmKt5sx8OeoM0JcqhlomkwW9xFAGloyFJOeiBbLJyug
 Aut1gtfUyadIuOOoQzV+3vrz5OEMJ0NjJu6Qh+Ry8VzH9y3EMT5OdQvr5GeC9ahkTx+o
 XTuSO1i4kJ/EdnKbhna7Nljus8Vro8jojGw+oXzqgZldoZbhcJUYKXwpQkSwDJmyc+96
 yJ1uu44TxlhrMeliPFwMWiVic4Dx+hi8qeQPf8/qyt7JN6Ifo1i4Z4/BY6FQaWAchneT
 mNBhHPsHzr6ZKmKbOiu7faR1S7xahgZsV5K0h64eZ4wych6HeHPXbx8oJQ8asnhjJsIe
 vGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731297788; x=1731902588;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ztGyt7G/lk/IdphWSkD54uzddliF65o1hIUoaXDkWno=;
 b=TRMDO/b4GX+URG2vb4bDtmao7Me/sVGcRkIzI/sLI/rosjRlEUUFz09kc3QRDW2d/Q
 0Q2/dBAssTLQdTj/t9GSxH6ou2YGa2zla+1LeiEQ4noXNb+lmr3ECrABCAzuEPlzMRd3
 tKJtTnT7mHAMeM8fX6AyljQMg6fTffhZG10Nb2/HMbVwRDf6w+/fusrHrbtWFVG/yLDB
 G1VaPH5T8a2FMAgu1qbtcqac9w+6WlbQQzPwna/3mQH4nAcgJcnRzygM4d8BndUmQkwO
 9r+JA9M7/8IhpkGvJShQHSPGjg3kpvR3QkGIHocccO5cHPqb4cLw4lv4JM802sTFaUCh
 iOpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZMiIwp8ts9Vn0KJJ4yX28d9B6xyh4PnngMJheHn7lOmInt6ntjQ1pZ6S05oR7kEIlEnBwAYKSwdsJOw==@nongnu.org,
 AJvYcCWF5nn0Z+Rtx6LyGAAZZvoJhVvf85KHGL52O+joJT7bneIO/hOgT7c9USxYYOsWYZg/BLuYjMRERzrF@nongnu.org
X-Gm-Message-State: AOJu0Yyrh5B9m6u+7NZXJyxToA52/rAZK3WyaoGDRAyIspQOYI0oUx1j
 taewTv6HtInhP221ic3V47qTPOEeKt2Nn8F+SdgYGAyLVzBsOXOwbaAVQmgrOsgQrVYqlrEfm7g
 aDUxg4VGRFwjsG/LvzZflPVV0ee8=
X-Google-Smtp-Source: AGHT+IGMQViiQxtS4HIbiqaPwXhnvxtiBt3hnKkxGuV7IviDDfRFkvUG9wp6fovRGlTA/Pp4IQFgwQtfvBMUUeaKdvA=
X-Received: by 2002:a05:6102:4191:b0:4a4:7609:35f with SMTP id
 ada2fe7eead31-4aae1658c2bmr8317810137.24.1731297788561; Sun, 10 Nov 2024
 20:03:08 -0800 (PST)
MIME-Version: 1.0
References: <20241108230709.1466634-1-antonb@tenstorrent.com>
 <4e7a4a10-bea3-4f43-b091-6a30c400b8bd@linaro.org>
 <CAN7m+mCqXz1YaBZpA-TFWz_TX0HiRorzXbaadn+L3fnigWBR1g@mail.gmail.com>
 <1dc240cd-c35e-46da-959d-cf93783ee87e@linaro.org>
 <8c38c37f-2c86-498c-96fb-1999f546a497@ventanamicro.com>
In-Reply-To: <8c38c37f-2c86-498c-96fb-1999f546a497@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 11 Nov 2024 14:02:42 +1000
Message-ID: <CAKmqyKNkH=Pcakk-4QGgOqW0enukufk6akEG_XO+cNdzy1_2Nw@mail.gmail.com>
Subject: Re: [CAUTION - External Sender] Re: [PATCH] target/riscv: Add
 Tenstorrent Ascalon CPU
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Anton Blanchard <antonb@tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
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

On Mon, Nov 11, 2024 at 12:04=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 11/10/24 10:54 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 9/11/24 22:46, Anton Blanchard wrote:
> >> Hi Philippe,
> >>
> >> On Sun, Nov 10, 2024 at 5:21=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
> >> <philmd@linaro.org> wrote:
> >>> Generally speaking (I'm not objecting to this patch as is), for
> >>> DEFINE_VENDOR_CPU() it would be nice to have reference to some
> >>> documentation -- at least to review whether the cpu features
> >>> announced make sense or not --.
> >>>
> >>> For this particular IP I'm not finding anything on the company
> >>> website...:
> >>> https://docs.tenstorrent.com/search.html?q=3DAscalon
> >>
> >> This has some more details, including a 1 page PDF. Should I add the U=
RL to
> >> the commit message?
> >>
> >> https://tenstorrent.com/ip/tt-ascalon
> >
> > This seems a sales presentation, not very useful technically, so better
> > no IMHO.
>
>
> The link has a 'Download One-Pager' button where you can download a PDF.
>
> The PDF is a bit more technical and it mentions that the CPU is RVA23 com=
pliant,
> which give us an idea of the extensions that the CPU provides. I think th=
is is
> enough.
>
> Alistair, what do you think?

I think a link is better then no link, even if it is aimed at sales

Alistair

