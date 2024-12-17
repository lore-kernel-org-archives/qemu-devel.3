Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023FFE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 18:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNcDO-0004rB-NH; Tue, 17 Dec 2024 13:22:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNcDG-0004qq-Du
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 13:22:31 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNcDA-00015i-Ng
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 13:22:28 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-6eff8289d0eso55990347b3.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 10:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734459740; x=1735064540; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2KlVJUlAkH0bB0a1/WZiu0eCP+a/ffW0431lgZmTL00=;
 b=UutZt8O5ZSukOwGwAFUzWasFPLv24VI7sNrYnW7ZO1Oy3LfK78m0ZqUuLuhXywi8fn
 lk9HSrfW/W7B5qQCwvn1zWTXWiz8I7B301nLIpIT2ocIgFF0hO3l0YvSQjvw7u7rZXFt
 324Xv543vlk/i1xez7mIeW/xcXinvI5NQzDkzqm0z+g2RqJM4kfPUNrrcxJPEyDvQ7Uy
 X3Y3So4HAnyIrZQMtGZHIiefSMEOOCEu7iRZ9QTR27Xq+mSuXKtsVNaMBL9wswa6DL0P
 WZQneLoDxUsgxSPdYQrWbb3PTDRgeNIiqIt+Qxeb2Wuz1+bnGx7bPwikOLarnGR2S5zM
 7ePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734459740; x=1735064540;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2KlVJUlAkH0bB0a1/WZiu0eCP+a/ffW0431lgZmTL00=;
 b=IbuzX03eoblKh2M5+OzHxF6cJ/pDCf+piS6xHxE4wraiPqdIs+eycTwCJFhiZZcPYz
 Ss1vV3H+nbDbpWRp2coIyFOtOnpNOgmMHtEeanpD/Msr5D9lAeL55NY21QBpf7wb/8vb
 Bua27+ITeYl3qookvsJH2A0jh7TTi1pCueEMcEsvvE/bNEHkpqC8HVOdF3ZbsC4gy97R
 QMF8tmOLXojOxJemdvF7LO1gCOHfDNDJLDQCY9JqVjFl0ifDa47vYOSWo0kYGxFw8P8l
 GGFULfgKd/oZyUXvaJDA4pIakvKM0N1AjjFspEr2/cCbinVOGb6blJqq/Jm5AG2nJXQp
 Tq6w==
X-Gm-Message-State: AOJu0YzE1fl3lfwSReAK/tsop6NR3Vt3mSVVhsXzQX3jqH6m3+8leVBT
 JltC1nEOQzl1OI1IB0oR0wqs1oKjQHLkZHaw4ujYO5TtjRoh2lciVbG0MaCDY5lALyRlOZTI2/2
 MLnQrlccDVc0ZgRHRlpgjgkgp7wkJ/IIS/x1hBA==
X-Gm-Gg: ASbGncsDBxmrEb0YIegmZhfnlRL1bl2EaWYCB2+M6NnV2EOOMQL1nHAc/49BQq5hukV
 1dWHqAzN6O0ST37B8uzrg3E79LyRxJKdnXk8AbyA=
X-Google-Smtp-Source: AGHT+IH0dyXkL8iQ6t3SZrJ5M4264DKduFPCwm/nw59fGvobsWGrABnVGUFqmjq+A32BdnQpYZKZRVWfiM/BT/q2klU=
X-Received: by 2002:a05:690c:3813:b0:6ef:4ba4:ec8e with SMTP id
 00721157ae682-6f2cc13ca32mr7389487b3.4.1734459740677; Tue, 17 Dec 2024
 10:22:20 -0800 (PST)
MIME-Version: 1.0
References: <20241217174442.3914177-1-peter.maydell@linaro.org>
 <0f9d4f78-88dc-46da-b987-2929758b5d6f@linaro.org>
In-Reply-To: <0f9d4f78-88dc-46da-b987-2929758b5d6f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Dec 2024 18:22:09 +0000
Message-ID: <CAFEAcA_7qAMb4id01vEyYh4aeCtTYx7eDK43Sadj60T8JEf6sA@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Move minor arithmetic helpers out of helper.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Tue, 17 Dec 2024 at 18:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/17/24 11:44, Peter Maydell wrote:
> > helper.c includes some small TCG helper functions used for mostly
> > arithmetic instructions.  These are TCG only and there's no need for
> > them to be in the large and unwieldy helper.c.  Move them out to
> > their own source file in the tcg/ subdirectory, together with the
> > op_addsub.h multiply-included template header that they use.
> >
> > (Ironically, this means that helper.c no longer contains
> > any TCG helper function definitions at all.)
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > One last tiny cleanup for the end of the year...this is a pure
> > code movement, with no changes.
>
> Because of pure code movement,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> Ideally op_addsub.h would become tcg/op_addsub.h.inc too.

Yeah, I did think about that but decided to be lazy :-)

> > +/*
> > + * Note that signed overflow is undefined in C.  The following routines are
> > + * careful to use unsigned types where modulo arithmetic is required.
> > + * Failure to do so _will_ break on newer gcc.
> > + */
>
> The comment is out-of-date vs -fwrapv, which we use.
>
> There are a bunch of other saturation related macros/functions hanging about.  We should
> probably unify them.

Mmmm; this is all rather elderly code from the A32 decoder,
though. I'm not sure it hugely merits much effort. My
aim here was really just to do another little bit
towards slimming down helper.c.

-- PMM

