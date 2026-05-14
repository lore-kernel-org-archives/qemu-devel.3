Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6814CD4851
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 16:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNYvS-00023A-R7; Thu, 14 May 2026 12:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNYvQ-00022O-Qy
 for qemu-devel@nongnu.org; Thu, 14 May 2026 12:28:40 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNYvP-0003SG-FG
 for qemu-devel@nongnu.org; Thu, 14 May 2026 12:28:40 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-65e15fb394bso1136798d50.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 09:28:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778776118; cv=none;
 d=google.com; s=arc-20240605;
 b=kwh7ygRGD48Hirv+LYAj3mJDJJTNBbM5PQfKQFhNPcuciyLX2JW76W2brefGvXhWm1
 54/+uK2Qi4r+maVXFWyc/FNcws0hmIylHvb4MjOLhfidWMlqmWJ/7xYYihfs0VsE962F
 w6ddzE89JaR+BVBtBy+jt1wV7qKEOG3tVn0EWdtFyg3lwyZSlG60ijqyN8Qpkvzl9CWs
 92v4C3TBYEcYZ4gp4MTQrSalHmUij80LQgPS3KmUZDByqWHRtrvnu0n8FpTfy91YGO4q
 8PzWeiziGZlN7JoNmKbx2rdJXmwSf/LojCdab2xw518aRtrDWLYbzKv2g92IEmDdAEMG
 duTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=acR8u1v5gCE88y/9RHxz2KwQiTglC7M/T8tiKVbbbiI=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=kdIKxxMUEBTX/U20XGlP07eNZeVolMRpZ2EqmqRHneZ94jVuvZVPi0cd7DlluWYhqK
 +2PC/H16M/nQa+9eXHXTTRgP65GuUDu48q8KQbV7dkg82Lsu+jGfC3xYhGKZxSh0PK6K
 QaRwEyGeQB/A7skLICaWVKQTcOVmKajRWYf7ZWZ/8vouRGmu7/7KpRytvg5Vthwo9ZRu
 KbaVRn5jlXqwy69vwxEYdogp5UQWjPMzY5NfCUWF8/Qer9G3fiM4wbTyl11OUdXQyz7d
 HjZFI1Ym0ldBAAGbsCJ1g6Tlo3kpHu5hn4niU9mcLpqHo9cjV/WLotvPz+Th8UshbSTb
 587A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778776118; x=1779380918; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=acR8u1v5gCE88y/9RHxz2KwQiTglC7M/T8tiKVbbbiI=;
 b=Fkj9nmtcsRGxB9iK+ktgjDO+vCRj+za4kucjwvdQEv1O/y46mMZZqWktDz4m5eOe0c
 K8d6/jhQbZcB5HqD010+hids98ULf4lSg8vNrqzMwwbIGL2NXT7eida036/CKvApX7X8
 nW8/vJcUPLve6IjietQWVY3Z6n4ZZIbRxd+Lao50C2lnQ0Hx6K1uHmPqOdyRgX1r41r5
 6eG42WllkcAkgfwwI+OtcCE/AFnn6ryGBqUg61/xQfLYX5JuoW3QcfYEhrrNc63nCBSj
 V7zwPjDxS+lQgzSiUzSbi39U74VmRJ9eHLllsBLxtbq9Nkr8TMSSJWYnR5eynIoZl50t
 xflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778776118; x=1779380918;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=acR8u1v5gCE88y/9RHxz2KwQiTglC7M/T8tiKVbbbiI=;
 b=DuLlUqJfnp6ler4ehICaYXPqkr6g8w3Z8gP+pGUP65dargQSCMIFhvrXcKuRx6092E
 NI0p4kMP55wgGF18VpGwi8n2blS/BYAJD4bqfhAPdQqLYazrWSvCaOPUOCqvG3nqwJaf
 4aEDaQdsSbvHiHKRQMVPqeNZ6neXuBpsNBqI/hvR6TfjYjbrXes1NZt7qhVxLsHaiVGp
 Xsrt/h+RKnynqhv9NvHxTefPbDiMYt6ZVvAkUCsxqu39alySjeOLYwtD6KXggDGkeVbz
 os7IT8trTwC14tGfQnsCzTWsQsX3cxvU72kSShqNONUWCekMV34aufpKxwTfbkig++KM
 7JoA==
X-Gm-Message-State: AOJu0Yw2kxXDmwZjg+DS7+hVDjRRAg3MK1zfB6yX/6S0CEadBgE6Tzkr
 Ahfd3jE3Rvqyaj6UVdSgtHo35ST1OitutEorbQ0YgiJ5TZhg3AVB6+IoR6AQ5Z/aXUB92Kxd/AT
 1MokI5iHtDB0oBSXfocTeJKDtLY5h6CsMuVjgTRyZWA==
X-Gm-Gg: Acq92OHzNX3fY3kVKtzGx9NdB5T3m6w+jN+LsMw2iGo+GGnE+blrwgVlKOTjLphCvk/
 7fUjHgAMXkI8RTwtcehFAllo+jWL1dbxJpVNQcFDpp1xXafLymPFVMaYB1OXnxlojetSqRtdHmS
 5Afq3oS3QLB34jPBFh7EUYNvP72WBFY5IMlJbWhAKWss+zsYtrn7/VxdPCGuXSdpk8ghVTexnZd
 w4+3kEXbg3Ytb5g8L29bvHtsmY68Lju9JY4gp+Il989jlCw3g/4XdODPNKQxi/e7tbUmNyqkILs
 93JeclL5Nh4EyA2Yc36MEeYLlADYlxCqG2m8eVo9y5ewV8iCP8VmPOZz6qvmqw5JEvs=
X-Received: by 2002:a05:690e:13ca:b0:65c:1a0f:d8bf with SMTP id
 956f58d0204a3-65df82bfceemr6895129d50.50.1778776117940; Thu, 14 May 2026
 09:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260507234413.643512-1-richard.henderson@linaro.org>
 <20260507234413.643512-37-richard.henderson@linaro.org>
 <CAFEAcA8UpR-Q9oypm8v3CgwDK80+kXFcMkH9JCmUdc4=14HPCA@mail.gmail.com>
In-Reply-To: <CAFEAcA8UpR-Q9oypm8v3CgwDK80+kXFcMkH9JCmUdc4=14HPCA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 May 2026 17:28:26 +0100
X-Gm-Features: AVHnY4LLryXnwwrbc57DUWPcoIVxvBIJbLWtM64CXKT4Hl0Ijs6p_Xomovs21Vs
Message-ID: <CAFEAcA-N5e6CAgtCz6qBvLinjWT0sgDKR1bYUFv5SKo-iez38g@mail.gmail.com>
Subject: Re: [PATCH v4 36/60] target/arm: Implement LUTI2, LUTI4 for AdvSIMD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Thu, 14 May 2026 at 13:03, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 8 May 2026 at 00:49, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  target/arm/tcg/helper-defs.h   |  5 ++++
> >  target/arm/tcg/translate-a64.c | 38 +++++++++++++++++++++++++
> >  target/arm/tcg/vec_helper.c    | 52 ++++++++++++++++++++++++++++++++++
> >  target/arm/tcg/a64.decode      |  6 ++++
> >  4 files changed, 101 insertions(+)
>
> > diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
> > index 3231bb2100..f0dc11bc8a 100644
> > --- a/target/arm/tcg/vec_helper.c
> > +++ b/target/arm/tcg/vec_helper.c
> > @@ -3345,3 +3345,55 @@ DO_SME2_LUT(4,4,h, 2)
> >  DO_SME2_LUT(4,4,s, 4)
> >
> >  #undef DO_SME2_LUT
> > +
> > +void HELPER(gvec_luti2_b)(void *vd, void *vn, void *vm, uint32_t desc)
> > +{
> > +    unsigned part = simd_data(desc);
> > +    unsigned vl = simd_oprsz(desc);
> > +    unsigned elements = vl / 8;
>
> Isn't simd_oprsz() the size in bytes? The pseudocode for
> these ASIMD insns calculates the element count using sizes
> in bytes, with "elements = 128 / esize" (esize being 8 or 16),

I meant "in bits" here, of course.

-- PMM

