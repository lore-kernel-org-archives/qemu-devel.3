Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AF1FD7074
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 10:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ReS-00024B-GE; Tue, 17 Mar 2026 06:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2Re8-0001yH-HM
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:27:35 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2Re6-0006Z3-F8
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:27:31 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64ca6595c8aso5315580d50.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 03:27:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773743246; cv=none;
 d=google.com; s=arc-20240605;
 b=FWw+he2co8YI6MrlFwz+fsQTxQLtq7oey0/ad5BsqzbTfgQz6StnpghI9vOP62gEif
 0IlgQUALFiLcqlUvH/FSPmkRmptRT5JKReZm+EmksnQCMQXs/kD1vRBlZbdSMHiv7NFo
 /b0Z78Iq8V7GTMs/G6Ye1Nm7Wm4Z3WxI5bblvZ7BuGcjbaQ2xSOeq1UbhI8qhqCWSnu9
 ZFKMh8ykLxJ92q1gLNuaFc4l2AgJp56YZhETsyDHOSzYmj2qNKTc6OXUk5ievu2UPsZm
 BJRBaNc9wlK6Qheepn1Wh9jkIK3IQgb2N1lv+YonliWCzorgIYE+Jfk6gLUab1Cf6C8f
 sCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1JRJOsnQUQ/JjCHYNsn4QysP7v0/gRWr+MC6OtyqLV4=;
 fh=lSj/1hQsilLqqrIQB6s4Q1wh6081l/JyVKvt7e1AODI=;
 b=aPeSvj5FYE5UP/8bHDLZOrVJr8Tf+bTQgSOG2fAgX8r7//nKfd40T27pvB73LDQzQP
 JfF1nh+kMtXS1AztZ/QLwaPj1AWAPjue+Q7hZULemxzCzozBMIG4I1MVHQ54diDSxl5X
 Mlq3wJaBWViO/unYmU6yMAUGEDcT//1KBW4koWdVdETEU5hQJCaJ/hkMNC+6QAOMgIug
 7nPTgjZ+iIOMJTiVJKoP5Ymk6ODZqsmDo+9K1kT2sGK3rsk4EzF3MiyU4dp3M6ZIopWb
 PZn8Neh8AxS4BD7A9HDonOWP+ice7DsnTNfE2TeqcfwxCGWk7lAG/G1CkdDavSHYNa5D
 dSjg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773743246; x=1774348046; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1JRJOsnQUQ/JjCHYNsn4QysP7v0/gRWr+MC6OtyqLV4=;
 b=R6Ea7+wrHpPlj8bg3fi9ZsKR9joG+zEN4kmvi3awVOA1URJVSvbhEuS1u/my2Mz+Wx
 4Aj7Dkz+G9wugVe6Hzgk0hBAFR5ROsfBRAydJOoHl19AiS7VDlaZn5R3d2Ig8898Acek
 nrMVN2BrkT/Naw7IBkjuErjzRt47h0PB8NatnClQggdCyN5mf63o1QZSFNGGjxFaBntQ
 l5fNIRrkTELP5pBBDTbW2lqixar9zikUS03YE+EbrdgpIHmrNnerOi480ai36TYHDK5G
 xUsH2SVrxPkktxZgoDmFoBtnDckHxGvG46x16VEbGNbswzlBcT2Zg6P8QOguVuXbr0Nx
 F/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773743246; x=1774348046;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1JRJOsnQUQ/JjCHYNsn4QysP7v0/gRWr+MC6OtyqLV4=;
 b=s+zjA6Mrf2gKhopDVCGzlSOd9bJVPuKLbhb8KCwABGCeN4ljy3rEEJMfr20lWoOMMf
 xkjyJ85J1fvVahDT8zNK5BPyWPkeni27mGcYhF0NPq+ypEon4/9sBU++kLwmHgcyHDC2
 nLREPaks/6ImDnrXIh51DkosrcOYC3nyr1i+DV7QtPxPJ5Qf4W8wH4mQbgc6yTocD+hE
 XprPBT5oLQQ1URP4OCxECN+nKNebw2Hp3uScU7LP4irYU94ecDU4MGNI5go5AWauMLLQ
 2m0NebeUGjhUIi33KH4lip5j1yaheVqiNQNIK0iOQuYuHJqBsD/esQ3ouTeJjIjz8aim
 AumA==
X-Gm-Message-State: AOJu0Yy+/9xD9MWwe4hHHRFG0yV/8fPVaemiRfM2W+mY1PvGI4ukMf02
 8zEnHQZkwUdHJmiI9offO1JNam3ayTtat7//WzM9olyaeyHd5aGR6oWavrhY7FPEIv6bAtK93t8
 s8t3jGafx++sp31jqISpD/FedC40LckFsqxD3VeVA0A==
X-Gm-Gg: ATEYQzwFa0Lw3pcBNRGuRwtotSI5O/BTYWEXSl7HJtWSFWn3ZMVQJ8QrjJpEOrdN2Dv
 rojXKuYxV4pHJjW8VFjWt5b8haKdUITRbfyKTI+kQBH5k4lXrdtnjfWsOnVxEv4h9XeCG+uAzC/
 vpzo56pilOAF5DZ7jrmyJcEbVDe20ohnNhsy3nsCGlh0NSzxWD4igvznmfsdShn7LxMbSd3ZkhC
 3fc6oASd76UR1xPfLmCVrvUFwp1fRCkrYYTSh2CF0kqDLptBKlC8JEPzFBUXdUjXX4ncUILkOs8
 nPs7MO3brMzrlaA9/N70dLUYJY8RG6zDQ4NJ18D8Z8R8wmF7tJ6mE5ueaVuF4vegmBATb/5aK8T
 /UA==
X-Received: by 2002:a53:eccf:0:b0:64c:c34c:60ea with SMTP id
 956f58d0204a3-64e6306fceamr13426200d50.54.1773743246313; Tue, 17 Mar 2026
 03:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1773618848.git.balaton@eik.bme.hu>
 <0cc6620e1d15af6ef465e2322dce6d4c79ad0793.1773618848.git.balaton@eik.bme.hu>
In-Reply-To: <0cc6620e1d15af6ef465e2322dce6d4c79ad0793.1773618848.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Mar 2026 10:27:14 +0000
X-Gm-Features: AaiRm539sAoO2_cRCpbh821ddRuafLsBxwi0PVrbsU18H90JxW_hdumlNVwScco
Message-ID: <CAFEAcA99ZqUsaW+NWMHAWz88tuDx8-hj=u-k9mBpEQFLw=QJdw@mail.gmail.com>
Subject: Re: [PATCH 4/4] ati-vga: Avoid warning about sign extension
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 marcandre.lureau@redhat.com, Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Mon, 16 Mar 2026 at 00:06, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> Coverity reports possible sign extension error (CID 1645615) when
> reading DEFAULT_SC_BOTTOM_RIGHT register. It cannot happen because the
> values are limited when writing the register but change the code to
> match other similar registers and to avoid this warning.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/ati.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 1a6a5ad4fd..d194f15002 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -513,8 +513,8 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>          val |= s->regs.default_tile << 16;
>          break;
>      case DEFAULT_SC_BOTTOM_RIGHT:
> -        val = (s->regs.default_sc_bottom << 16) |
> -              s->regs.default_sc_right;
> +        val = s->regs.default_sc_right;
> +        val |= s->regs.default_sc_bottom << 16;

I don't think this is going to make Coverity any happier, because
we're still doing:
 * take a value in a 16-bit unsigned type
 * shift it without a cast, giving a 'signed int' (32-bit)
 * promote that to 64-bits to do the |=, because 'val' is
   64 bits, causing a potential sign extension
The rephrasing of the code doesn't avoid the sign-extension.

Indeed there are other (previously dismissed as false positives
years ago) issues in the coverity DB for the other cases in this
switch where we put together values like this without a cast.

But as you say this is a "can't happen" case for this register,
so I've already marked CID 1645615 as a false positive.
We should do whatever we think is reasonable and readable for
this code.

-- PMM

