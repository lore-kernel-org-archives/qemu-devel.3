Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D4BC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Vme-0002FQ-Ld; Tue, 15 Sep 2026 12:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6Vmd-0002F9-6o
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:13:23 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6VmZ-0005vn-22
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:13:21 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 956f58d0204a3-66e4ab1ef11so688088d50.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:13:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789488798; cv=none;
 d=google.com; s=arc-20260327;
 b=PpF/YKgQlw92c6/AmZsOzVJhOgFFXVnITQTqT/bxga7dEmM59m59YrW9NIw1L+0KLe
 T0+IKM1imghdva99tWuW2e+Zbng98qqg1lEPTK29WEW3lSXoTRk1qkOHXzQSGwSA/MvD
 9lkGTdk6Hj6HXlmLHTmkFkKoj7r6AeNRpDMOLl1cHP4ILMZPdTeNF0kR1ylEWOvedjCA
 Lf0UrohMUipAn9MCVH7XmsyANZZiBGQ4khELouH1J0k6kuOe4ksKZqZs6DSxcxSc5FbT
 homnoXGlqv4ESGDx8+81avRMSjvmHt5jqcRr4uG1Wpzey6zeA6zF03A2B6YmVT804/9F
 q1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/5ul9R2d3z6fhjgPNwSZloyBYPFwCNFybU1JshNoOog=;
 fh=vLyh/WE3ox3WLHT0f+K3fpH+wWHyfJtzLiP5s/QNmtQ=;
 b=lsgiwD5KOZIg+DxK5AZrEUqLSmOrDrukCTdMxeBnPPbNtv5QkRSSFmJtrKSKaUS3za
 SqXZ4HdkqlyH9GAf0G4B7NWKOhIqYjjxdUscTMFR3kUSwjMH2GSOw8zLtxgK+kwKip0Q
 NGy0wdzLNx3gvBmEQ4aVmoxtjHhX/M/qRKRCQ1+ZKVAC9NZcbOUOMlKUpqcCbawDayHe
 iLGGzwLpXRW93Rs0mfeUiF4u9zBdg1cMNL+uu/quJ+ttm6zupHUAvDI5JrQMOhkisqsU
 ShxdFNTuxhosl3YEI4c6X5zLa9ZCuz5lxdHzF4T3STgKbmALD1cFcDk0AtHb1chYLnmq
 h4Dw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789488798; x=1790093598; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/5ul9R2d3z6fhjgPNwSZloyBYPFwCNFybU1JshNoOog=;
 b=nvNST2LiU+wcHyBParI3sgwD07pTlGIW4IKU+vYzLppbIbRoS3EApJsr0O1NqJ5Weh
 2cCQNU0e5CCB4Az6oC5dY/MfGm8jn1IDudkSDNrG7q2oJZS8XnOx0a3HpPFnbINJcTI3
 9c+YoPU0ZsgOB5v1SfES3X01poM/mhW2GNxazSspjPmU+Z1N56HK0wm3h8hYybRkoSxY
 5MZGlsYSucVsUDoFnutEP62TosotbyczVS0NBGFVcvQLP/GlJstcw/N9Ykbn0kGK52Dn
 xMNytimuBBwgF81viozdeSRYweZGhse8/H6aGkqyuAu95CoTuAFb12BKpcY6iq1i3qy6
 E21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789488798; x=1790093598;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/5ul9R2d3z6fhjgPNwSZloyBYPFwCNFybU1JshNoOog=;
 b=VVlBcQlyjDeGv15SntViCEoAIrOeVZ1x7frJmbx7qfyPhiTizBpB91olKqljHYK7O3
 OOeqlQMybIppGzyB76Q4QOVuUN/5H37U33vy70dmnTRn82Syl3eoADarYr/f97Xq1Ufb
 xcOux5aSiF679De7fQ0xIEkWkU3bGUzZ8Sn2UdicKJ/f+M9X0iGekAZQ2Yd14TdsA3Om
 QzottzMTmzBCSBBNoiNi7xmHsaWeY8WBvoRP7b0or0rUs/F4Y07QMxwEZ6ZB6EkMXEJc
 Pt5xsBMj3tPlSbHpFAfoyn/ZW07q3KJTnz3m3YRqwyYSZKOpG3OcWLlJynFjU38RZkXm
 8XlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfzGC1jk21vZ9JAJq1qIT/6a3JeVJUIiv8fmIjNGnydb8HppN+vix2HIIESaPqMBiF11yK1K4vtHhD@nongnu.org
X-Gm-Message-State: AFuF++mJpJbbfPspxOxN+NFMSCZv0dHpP10hGxqp4VtiHICHjBnuHoAh
 jIHkDyqcA9NTFzSzC0rEU9DTRQdwDgNOvMzDtoXOO0zP6loah7rV9SdlfB1PWie2S/UA88pnvvQ
 bySLE7Rbyd3dkBuGEte69KlfC+Vvb826Qt071UDe8NA==
X-Gm-Gg: AYBFou3VX6lB9KlTc37gg7duwTyp/ImOMnI5AuR3G6dQ9pgj2leoAUWAreS/S3q2Izo
 KEVvm+s8zKfhStpyzu2ct6IZWXocRHjrZQlQj9CP9XLBKd/1nRQB+7GAnYdznca+lEahkYSVY55
 gXHte7tUFX7fLm2dJrjZ92BSbKyk+wyem14sxslQ2RPrT7ddsBuT1qOVzwYhYlh8/PN6Lsnshop
 sBbhppbL4KzwcAYu48ZzypcrfiWmiwCROcJeEEM/dokJm32XQatxX2O3IPz2GKrQv8Qi7f1X5AE
 EbI32xS/SpNiVbnkpGOfVzpUNjeJ7IfgLrH8YO3XijfC6bNafsS3yJfkzrs68MKVGQC8oZAW6OB
 K5XWB/MvOLKsV7gILOhoeIXHinBb5cEsPx8IBEPYM
X-Received: by 2002:a05:690e:1907:b0:66e:62cb:bb6e with SMTP id
 956f58d0204a3-6715cac005fmr850870d50.11.1789488797684; Tue, 15 Sep 2026
 09:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260904161438.3838261-1-bin.meng@processmission.com>
 <20260904161438.3838261-2-bin.meng@processmission.com>
 <CAFEAcA-p=UaNk-Qddid99o7zeGS4WqmvqAugxtjtBKZwv9ie8Q@mail.gmail.com>
 <CAEUhbmX3N2u732mUZ8wG0pdtN+vCrVf4rdX3TR+vHPeRunsGPQ@mail.gmail.com>
In-Reply-To: <CAEUhbmX3N2u732mUZ8wG0pdtN+vCrVf4rdX3TR+vHPeRunsGPQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Sep 2026 17:13:04 +0100
X-Gm-Features: AcwNN1WUGlOp62e_u77RKxrO6eBx6PeevZUeanHkFoo_G-SEvdJncJBh8x4Z6JQ
Message-ID: <CAFEAcA91O71cLf9ogos_xuTx+9fn-jdUGP5u80RD6hOxAQNQOw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] hw/arm: fsl-imx6ul: Add SCU compatibility window
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x10.google.com
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

On Tue, 15 Sept 2026 at 16:52, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Peter,
>
> On Mon, Sep 14, 2026 at 5:20=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > On Fri, 4 Sept 2026 at 17:15, Bin Meng <bin.meng@processmission.com> wr=
ote:
> > >
> > > +    /*
> > > +     * U-Boot's shared i.MX6 CPU identification code reads the
> > > +     * Cortex-A9 SCU configuration register on i.MX6UL. Cortex-A7
> > > +     * reserves this address, so provide only the compatibility word
> > > +     * needed before the console is initialized.
> > > +     */
> > > +    create_unimplemented_device("a7mpcore-scu-compat",
> > > +                                FSL_IMX6UL_A7MPCORE_ADDR + 0x4, 4);
> >
> > What is actually going on here, though? Why is u-boot reading
> > an address that's only here for the A9? Has this been reported
> > to u-boot as a bug? What does the real hardware do?
>
> I suspect the reason is that the imx6 family contains both A9 and A7
> based SoCs and it's a leftover when imx6ul support was introduced in
> U-Boot. I do not see a bug report against U-Boot yet.
>
> >
> > Whatever the answers are, I expect the correct fix is not going
> > to be "fake up this specific 4 bytes to ignore accesses in the
> > imx6 SoC model".
> >
>
> Apparently the real hardware ignores the scu access on A7. So IMO it
> could be accepted as a workaround for buggy software although guests
> should not do so.

Mmm, but I don't think the fix is going to be just this 4 bytes,
and possibly it shouldn't be in this SoC specifically.

What does the TRM for the SoC say is at this address?

-- PMM

