Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F162C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzkw-0004nR-Ac; Tue, 28 May 2024 12:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzkp-0004lS-0b
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:32:51 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzkn-0003oC-4R
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:32:50 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52961b77655so1259861e87.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 09:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716913967; x=1717518767; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F40v0iGHKnW7kzFJk3T7q0pi7LbEWuTXxZPYsYKUSMY=;
 b=mcz968U9z5qGAZRQVc0H5qMy9I6+lIjoFAQRh8VcIheQVg3VFUnZbFc+Zncyp5RkEx
 OVMNFgAlBUZh3hCOU6Wc8/C4DwwReO9BEseVky2dd/PtCSa2oJupx7qF2xq7Si7uZimP
 DstFMhgGJj9Ud1/jmURVVhQxZTyYgeKvu6KjxFZO0pXrU2Y+Fts8lS2GmAKUsbtceVsd
 04MWRcF1Z+y2dmQPDhAAYurX/EqXYHo0o7dN6E0pI6jT17C1AYWvccBVn4Kx4rS1Tv5L
 dKMWMZCWPOPjrJcpCP4sflXMN1CoeBJI+zigg8hkVmTNjsm8WpcsM6VUpJ8yRDfDKj0O
 KuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716913967; x=1717518767;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F40v0iGHKnW7kzFJk3T7q0pi7LbEWuTXxZPYsYKUSMY=;
 b=GXd29nD412uo2bD+pl3n6ddPp7Q3qHy3qiYbVNG6umkHs5mN34kmDFMKHlciagzz6J
 ggb7udnP58PuTwDeayzLb0sclqyTuIM1L8oPNtEpgbdgiLMdfGdomsAZe7MOUGS5tZZN
 +uEInUF1P7vkvqNIJbwGZp42R4egis+mIBBJftOUdniLAvSo3XEIAWo8RjaagFXBqiaY
 T9qc1Wce1n8ZRBOwK0QAmwGKkdzOE9K07sbTFAn2HRhzGZbF7d4b/wg4bH2r9rIjuNHu
 yxmg4KgC9U09FwJ+3y/EyX239Op68r/EzXS23Zs3JxUyVXIGOxMo3lR/PnRffNrAQi84
 lbKQ==
X-Gm-Message-State: AOJu0YyLR+mRTbOTux9us4v8KjkzY4zOsGUHUup0Ck3YvIFc8nL/Y+P+
 U23HbR5gMd6BgGykMS/shdwBS7QDeOmuIC76mhInrhrNObmHIS6Gof0ysV4x0CiEteT0yPRT0K6
 lIYiYyHPsPlq5uq4EpQbFrIGGAzBZo2AiiZTHqw==
X-Google-Smtp-Source: AGHT+IEg1+S284hwH+1x9MHDUkSozZZ/qLVGxVay4dCYi4PrNH64789XIJfptbj75aQSvrtZ9KTi0VNrSk8VLokXk58=
X-Received: by 2002:a19:f613:0:b0:523:ef21:8e2c with SMTP id
 2adb3069b0e04-529664dac67mr6827507e87.51.1716913966872; Tue, 28 May 2024
 09:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
 <CAFEAcA9aum5+z3sr-OpCHZRWxFtZGS_kGOjjmRh7H1TBTZuFRQ@mail.gmail.com>
 <CACBuX0Q3TMvmxuuAHfVY679wpKF+0N+-aw=A7PLiba7ndc5v+w@mail.gmail.com>
 <CAFEAcA9XvHOF22m-9ZFtKLAaShE5gVjsy-AxQyBwVAkRZ2QW6g@mail.gmail.com>
 <CACBuX0Rzh9g4BEei8=vk0vOr7BwEZqom4LBGLcqH_omnBy9fLQ@mail.gmail.com>
In-Reply-To: <CACBuX0Rzh9g4BEei8=vk0vOr7BwEZqom4LBGLcqH_omnBy9fLQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 17:32:35 +0100
Message-ID: <CAFEAcA9V1J4w00PJB+Ct_3z2KGHcfGs_C8OqX8mdnW_bLxbUiQ@mail.gmail.com>
Subject: Re: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
To: Cord Amfmgm <dmamfmgm@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

On Tue, 28 May 2024 at 16:37, Cord Amfmgm <dmamfmgm@gmail.com> wrote:
>
>
>
> On Tue, May 28, 2024 at 9:03=E2=80=AFAM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
>>
>> On Mon, 20 May 2024 at 23:24, Cord Amfmgm <dmamfmgm@gmail.com> wrote:
>> > On Mon, May 20, 2024 at 12:05=E2=80=AFPM Peter Maydell <peter.maydell@=
linaro.org> wrote:
>> >> For the "zero length buffer" case, do you have a more detailed
>> >> pointer to the bit of the spec that says that "cbp =3D be + 1" is a
>> >> valid way to specify a zero length buffer? Table 4-2 in the copy I
>> >> have says for CurrentBufferPointer "a value of 0 indicates
>> >> a zero-length data packet or that all bytes have been transferred",
>> >> and the sample host OS driver function QueueGeneralRequest()
>> >> later in the spec handles a 0 length packet by setting
>> >>   TD->HcTD.CBP =3D TD->HcTD.BE =3D 0;
>> >> (which our emulation's code does handle).
>> >
>> >
>> > Reading the spec carefully, a CBP set to 0 should always mean the zero=
-length buffer case (or that all bytes have been transferred, so the buffer=
 is now zero-length - the same thing).
>>
>> Yeah, I can see the argument for "we should treat all cbp =3D=3D 0 as
>> zero-length buffer, not just cbp =3D=3D be =3D=3D 0".
>>
>> > Table 4-2 is the correct reference, and this part is clear. It's the p=
art you quoted. "Contains the physical address of the next memory location =
that will be accessed for transfer to/from the endpoint. A value of 0 indic=
ates a zero-length data packet or that all bytes have been transferred."
>> >
>> > Table 4-2 has this additional nugget that may be confusingly worded, f=
or BufferEnd: "Contains physical address of the last byte in the buffer for=
 this TD"
>>
>> Mmm, but for a zero length buffer there is no "last byte" to
>> have this be the physical address of.
>>
>> > And here's an example buffer of length 0 -- you probably already know =
what I'm going to do here:
>> >
>> > char buf[0];
>> > char * CurrentBufferPointer =3D &buf[0];
>> > char * BufferEnd =3D &buf[-1]; // "address of the last byte in the buf=
fer"
>> > // The OHCI Host Controller than advances CurrentBufferPointer like th=
is: CurrentBufferPointer +=3D 0
>> > // After the transfer:
>> > // CurrentBufferPointer =3D &buf[0];
>> > // BufferEnd =3D &buf[-1];
>>
>> Right, but why do you think this is valid, rather than
>> being a guest software bug? My reading of the spec is that it's
>> pretty clear about how to say "zero length buffer", and this
>> isn't it.
>>
>> Is there some real-world guest OS that programs the OHCI
>> controller this way that we're trying to accommodate?
>
>
> qemu versions 4.2 and before allowed this behavior.

So? That might just mean we had a bug and we fixed it.
4.2 is a very old version of QEMU and nobody seems to have
complained in the four years since we released 5.0 about this,
which suggests that generally guest OS drivers don't try
to send zero-length buffers in this way.

> I don't think it's valid to ask for a *popular* guest OS as a proof-of-co=
ncept because I'm not an expert on those.

I didn't ask for "popular"; I asked for "real-world".
What is the actual guest code you're running that falls over
because of the behaviour change?

More generally, why do you want this behaviour to be
changed? Reasonable reasons might include:
 * we're out of spec based on reading the documentation
 * you're trying to run some old Windows VM/QNX/etc image,
   and it doesn't work any more
 * all the real hardware we tested behaves this way

But don't necessarily include:
 * something somebody wrote and only tested on QEMU happens to
   assume the old behaviour rather than following the hw spec

QEMU occasionally works around guest OS bugs, but only as
when we really have to. It's usually better to fix the
bug in the guest.

thanks
-- PMM

