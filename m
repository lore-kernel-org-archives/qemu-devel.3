Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BC5FC5900
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 06:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvVHB-0002jm-Fc; Thu, 26 Feb 2026 01:55:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vvVH9-0002is-9Q
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 01:55:07 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vvVH7-00049l-KR
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 01:55:07 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-82728e5680cso295253b3a.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 22:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772088904; x=1772693704; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JY/VUckVnKE6ESLECX0Wd/SX2Je+hH6pZD183ZttAN4=;
 b=ZqrRDSze9tRvqLC8fY0Gftf7QbxK7RhEEFvlredqIoDXlSwGBXGZZgIMxtTmjrRkwa
 oFdisE7kWlL/JTg/ejaC0BsfTccXWFd/axU5v8I916MWyKX1ADU4qP3qvBd8swgUdZ9l
 v8H6JNI9VNCy+6Wxf5wN0OFIWtxcLmItfBqCIkbsvNTwXLna42YmQbzYAgvBzYqglv54
 mplTPkhYcha+vQ+wBvuOhv2vVQV5/9J3rOvdCojnl8VUgM4wKDn13gSrX9Z3b3KRw8TT
 PLF60NWdRtSyV0uq4Nrdx8t6K79igp8QN0S1Ls1NO+yKUBAnLOtq2CTxfBFID2o94WrT
 UEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772088904; x=1772693704;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JY/VUckVnKE6ESLECX0Wd/SX2Je+hH6pZD183ZttAN4=;
 b=N/YgkexuuQ0YW9P6o1uaU8L3JtpvU6D+UIVJrUIXInmTqUcRUYvJnOfrAKe3ErkTxe
 zMdH6KFYt79cON9sct/tOrszLc1EKMxkFgZ7qspjZL/2OgUlVoODd8U3dEu/GVejwjWP
 XIFAWGSYwkotFmpdKhmMKRVuQeOkYI51zUl4xtm4dU12UEQxpYdTxaW0pCgPsqFz4yYS
 zQmvdn+MTLMaeeVbx+YRpVjlObBC6ISD+GOqs39ed+ZAIWhlSIysgPaKDhBTttqdMbgJ
 Nvnwswnp1BKLxxdquQ/Wm9Ej4GKl9/g7pNivMkH6oYewsE9hFvRFxTJAfugxrnm62QE9
 z/TA==
X-Gm-Message-State: AOJu0YyD3oUsADUXOR6giwzPDt3BUy+TypU9KhsJPQgEzEfv3eH0k4+0
 IPogbCh55saPox7BlM1GTm82tH+xBgkjUJn2U0nUGLyLjAhtJcOTzB/9zKYPsVZWsFs=
X-Gm-Gg: ATEYQzyfLkzM7FpkvCWtXoNOTOl8XyIf2qfWDSVEYWuj0WdBH9Ff0IFRd/fwu44tY7K
 IQwfMl4kzAPOizryjxyJRe2UBBIAgOFN3no9Jx03vRkLsY88tJ6W+P+Kc7d1HcJDoUOI2gzYYTM
 +I1+lYr9ctAKvWL0RRltuif5QucjeJKuLAVfu2HwL9px/yOTrzwfyP9t8CdLgZsF0Qa65206K+c
 2f+bCd9OB+6CM/wFSmwfcYCQheslgc8FLjyTskPGTVgHTF/p8t2Q2okZ7lcVgVIEDQvyYaB5Jer
 lbeYR9MX8njerEkD7eAUqpKEaXjMYq7Yzz5uLqKcYuxkBdwHjfrQZm2S3+2QOZwgniXALUjoUJI
 eymJcIroCktsMuW5SargCFlbuIwngZPrTdYyYKGyyIJg4rtwlyz7t3PxVFA1cEgTmXNGXvfaA0p
 yY5xtHlTyYwJqR4eIofwzrCEAbWv3BLYReqm+MkN4bpeiSVDOaQBfE3RnHh56YBMGb
X-Received: by 2002:a05:6a21:4782:b0:394:f8cb:262c with SMTP id
 adf61e73a8af0-39545f7ae20mr16853252637.40.1772088903917; 
 Wed, 25 Feb 2026 22:55:03 -0800 (PST)
Received: from sifive.com ([136.226.240.189]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb5b2268sm13571605ad.6.2026.02.25.22.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 22:55:03 -0800 (PST)
Date: Thu, 26 Feb 2026 14:55:00 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 3/3] fpu: Simplify OCP FP8 E4M3 NaN classification in
 parts_canonicalize
Message-ID: <aZ_tdQO2cHUu6hRv@sifive.com>
References: <20260225110802.1217946-1-max.chou@sifive.com>
 <20260225110802.1217946-4-max.chou@sifive.com>
 <bd43a2b1-2e79-4238-8d11-8f58de1c189e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd43a2b1-2e79-4238-8d11-8f58de1c189e@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x441.google.com
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

On 2026-02-26 08:06, Richard Henderson wrote:
> On 2/25/26 22:08, Max Chou wrote:
> > The OCP FP8 E4M3 format has only a single NaN encoding (0x7F/0xFF),
> > Replace the indirect check via parts_is_snan_frac with a direct
> > check of no_signaling_nans to make the intent clearer.
> > 
> > Signed-off-by: Max Chou <max.chou@sifive.com>
> > ---
> >   fpu/softfloat-parts.c.inc | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
> > index 3c323c0cec..5ef7e2d921 100644
> > --- a/fpu/softfloat-parts.c.inc
> > +++ b/fpu/softfloat-parts.c.inc
> > @@ -245,8 +245,8 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
> >           case float_expmax_e4m3:
> >               if (p->frac_hi == 0b111) {
> >                   frac_shl(p, fmt->frac_shift);
> > -                p->cls = (parts_is_snan_frac(p->frac_hi, status)
> > -                          ? float_class_snan : float_class_qnan);
> > +                p->cls = no_signaling_nans(status) ? float_class_qnan :
> > +                                                     float_class_snan;
> >                   return;
> >               }
> >               /* otherwise normal */
> 
> But parts_is_snan_frac also checks snan_bit_is_one.
> 
> 
> r~

Hi Richard,

You're right. I missed that parts_is_snan_frac respects both
snan_bit_is_one and no_signaling_nans flags and I just assumed that user
will use no_signaling_nans flag to define the E4M3 NaN.
The current implementation correctly allows targets to control E4M3 NaN
classification through either mechanism, and this change would have removed
the snan_bit_is_one flexibility.

I'll drop this patch and send a v2 series containing only the two bug fix
patches:

Thanks,
rnax


