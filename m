Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DA9FD7075
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 10:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Rzt-0002Y1-OZ; Tue, 17 Mar 2026 06:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2Rzi-0002XD-V8
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:49:52 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2Rzg-0002jU-Uu
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:49:50 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-649278a69c5so4918344d50.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 03:49:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773744588; cv=none;
 d=google.com; s=arc-20240605;
 b=HTRyhuOyGrd4awA7Tb/OZTrDsz5VLqVkRT0AQRNS4wgn+o8rCqkv6iGmhkF2KkK6Fi
 vHJAPhPdUCTEHaRpia2ZAix4BnVJvyxaSfHOrq30wB5OMT44QGLRyQ74nmCcgUOrYCvy
 mvPNCLSp3thamA/jUhHfXKTaYgK8z0ChQKJ/eNLWq98fKPcaGiPZr3wB40ma5HrzOMhl
 rUgxiPYZ0JsFWyp3lDbXn3heEX7fdcyMy5cq4hnHno87hJQZ5FI0lpInY3wMYBY5ZF/m
 xCrL98vpcL+HflAAD3PN8HcPG6h/1bJC9e2OUMNRneW9q0lia7RXClnOeIzmhS6fy/t6
 bbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8wlzjznJXIac+iav3XAtgq8V2nFnx53+ZHyW4SgB54s=;
 fh=lSj/1hQsilLqqrIQB6s4Q1wh6081l/JyVKvt7e1AODI=;
 b=lFpL3HZmfyD1P3cF9SYm47oOgrjKPRXIBz1jeCFBFz9pTcB14SjMfs1SFCI+ogsprY
 bNBloLrYkk7ChnsULaXhdK4eWiJzcCzWdqWLfvMdus9dmEp07aw1D4e2dWh3prKQHHgV
 eLkKrKMf0oxWtutvWDn/rtMF3QP7zG7xwADD92nfipgKJo+WEaRbsQ7fLfgsrx5yBb2d
 8blWgogVcyR1Xc1J7UiVrQQx8i/auPxluMS3IRePn7dFZkclWLcX2O1Ao68I5nCRscgg
 LO+J6OQWDa2nVrOg//gRHTxIfJYV3a59riwsflE2xIVWK2zYBS3Qn+qtYRGaF7Flmd+4
 4rJg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773744588; x=1774349388; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8wlzjznJXIac+iav3XAtgq8V2nFnx53+ZHyW4SgB54s=;
 b=bAZw8pJp8bXcCI2F3uSOjVq4No6cY9bYfON4GGKOUFsLxr/dyIUYZdzChmzIeCybto
 5q+uIe/l5NASWZV2aPQz0B2S71VzC29pIVxvoIBkx8QSAX0ZuJFQzY2vXa89RIFU2N/j
 vCeC0TKSnJaRKt9YNQxMpExoa4zBL5JX0AbjznYhvOcvDhGuwcdupuTVltHIyhML268k
 chRJb+3s1bKe+iWEbGyB2Fjfvt2G7gBjto4h22Be0m9NcKAknw9iOo2kmfPlaavRIHzN
 2RF6UIDygSM+/2u6kKZkTc4T++JsZ1GFEVsQsvxIblaeX5pN52brV8jacdXmDRlPt3od
 T0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773744588; x=1774349388;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8wlzjznJXIac+iav3XAtgq8V2nFnx53+ZHyW4SgB54s=;
 b=kgmwSmY6v+k5Kz8BB5XGLRQqHnWssRZwvcxS9yXArwVp28XG2ykWDsnz1f/6l75QMl
 pVvbyAO5DuZT+Mub1xVwj94/Jra+r7NQ1AxsjCKJOFElfbMuc/DYc7mZLZHEnjrr14UY
 OJNcWVb4RWkL2oMo1HuGdeOO9RC21UinjsHx3iyK6YffM8+m2G817DioE+CUBnaAIzcQ
 EMGUZmdp06HTr/euM/D5Q9pBiDtIjslqe8h70SZgoJEron+hOKr8UqwlleMLoKBzExIY
 Uh82+EAIZbdBCD9SmGUlnn+mtpxlJRXus3aBXlLis6CFfH04LjvfXE77tACJBLz93e3g
 gN7A==
X-Gm-Message-State: AOJu0Yxb/oyKzkb7ZxIQrFdVxrBJfvQ+Id7kiEe1pZ+i/w/QKVqf8pQ6
 SII1IXA5GWNIVcemRhef/x5Kcq0ONzcS8FXf/XkrLoEurZSHCdhUNCHAE5z7EuBCV3Dj+Ny1Pht
 voz6Nho3oKV+d7itNBJDEPXMwScFH1JZCF004pw5z1Q==
X-Gm-Gg: ATEYQzw5rkCLxtrfflw4GX6ZADIJRbPQEbAe4UzPNoZeYaBkRB5vOC/rFSg6l0jUXDq
 /4tKVKQVhl6E7as98I/LJGU1BqbNmkfpAwOgHgJOXNGfDMHWTEswRWi0a2Mc6gP0ma0CI9+S91/
 s/D+n0Sf3Bv9J4ZAf09aGdRzmqwA8IYFOBk+Cf5DqNG79kPfpsYQ1LTmdqu8BkJLBSMUKmtT22k
 F4Fzt4q5KyAhIS5PyHtgvtgAPa7FrJ+zNYhbf/pkT5vKtG/hR4trt9DiCNOja3qVX0ad5jfIe5L
 iudYeldhwsCWZ86iX26JDYQHzg+kikUhTVUjdOdV7Fl0UW7pRAKIx5n8LkyrYESdJZo=
X-Received: by 2002:a05:690e:d09:b0:64e:8748:38a5 with SMTP id
 956f58d0204a3-64e87483c3cmr3560510d50.77.1773744587678; Tue, 17 Mar 2026
 03:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1773618848.git.balaton@eik.bme.hu>
 <0cc6620e1d15af6ef465e2322dce6d4c79ad0793.1773618848.git.balaton@eik.bme.hu>
 <CAFEAcA99ZqUsaW+NWMHAWz88tuDx8-hj=u-k9mBpEQFLw=QJdw@mail.gmail.com>
 <ba05fa2c-c3e2-de3e-1f3f-06c3296c4d05@eik.bme.hu>
In-Reply-To: <ba05fa2c-c3e2-de3e-1f3f-06c3296c4d05@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Mar 2026 10:49:36 +0000
X-Gm-Features: AaiRm53Wm6JnEXE9ue4wrHvgZ6Ru4c5fYCGK_E8xzTHkV3YluunzeUMdKWFVm8s
Message-ID: <CAFEAcA8-mLdtDxnBXDtk+wCBPnTZekU0BZJ4q8SEjptL=35p4Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] ati-vga: Avoid warning about sign extension
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 marcandre.lureau@redhat.com, Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Tue, 17 Mar 2026 at 10:34, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Tue, 17 Mar 2026, Peter Maydell wrote:
> > On Mon, 16 Mar 2026 at 00:06, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> >>
> >> Coverity reports possible sign extension error (CID 1645615) when
> >> reading DEFAULT_SC_BOTTOM_RIGHT register. It cannot happen because the
> >> values are limited when writing the register but change the code to
> >> match other similar registers and to avoid this warning.
> >>
> >> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >> ---
> >>  hw/display/ati.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/display/ati.c b/hw/display/ati.c
> >> index 1a6a5ad4fd..d194f15002 100644
> >> --- a/hw/display/ati.c
> >> +++ b/hw/display/ati.c
> >> @@ -513,8 +513,8 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
> >>          val |= s->regs.default_tile << 16;
> >>          break;
> >>      case DEFAULT_SC_BOTTOM_RIGHT:
> >> -        val = (s->regs.default_sc_bottom << 16) |
> >> -              s->regs.default_sc_right;
> >> +        val = s->regs.default_sc_right;
> >> +        val |= s->regs.default_sc_bottom << 16;
> >
> > I don't think this is going to make Coverity any happier, because
> > we're still doing:
> > * take a value in a 16-bit unsigned type
> > * shift it without a cast, giving a 'signed int' (32-bit)
> > * promote that to 64-bits to do the |=, because 'val' is
> >   64 bits, causing a potential sign extension
> > The rephrasing of the code doesn't avoid the sign-extension.
>
> OK then I'd additionally change val to uint32_t which should avoid it
> then. Would that work?

Yes, I think that using uint32_t for val would silence the
coverity warnings.

thanks
-- PMM

