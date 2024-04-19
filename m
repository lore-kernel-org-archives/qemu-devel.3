Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D188BC04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 09:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxkPK-0002bP-BC; Fri, 19 Apr 2024 05:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxkPI-0002X0-2j
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 05:19:44 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxkPG-0004PW-9t
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 05:19:43 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56fffb1d14bso3100003a12.1
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 02:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713518380; x=1714123180; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U4yR/ixG2Bqx+rd+yot+dvg+2eECU92Q+kJ9MbSDjVw=;
 b=YyVLfIRYi41v8yFgrKS9Xh1xM9nRBUZqN9j9fmc4PLyQpxM9CexeuDHY1PFiv7sbjl
 W9A+DL7Rb/zntqofZxa544saHuI7j46DKhi4RrLX+voDzZoxKMbz8Al8a9DP+wX1zraL
 Z4ASvdQE8nVdLT968dYWJpcH0dEW2SI0v41fKdLJM5yvIZihpIy2021jsvKaRZaudU9i
 wH4SEwC3tF4JXA6IzrusCw9K5xHrRNFX1gzEoyR5AX6SQ0rhig3ZMoaBF4NVQLNYUWpq
 K05J+wfEsiIh5QXHNSgqoiIc3GEeE46HpaoNQesoNvsV8qnqYrSicN0e17JQGpoppCCG
 VdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713518380; x=1714123180;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U4yR/ixG2Bqx+rd+yot+dvg+2eECU92Q+kJ9MbSDjVw=;
 b=okjJ/+nEDTBll32KT1SqgK2NpyoyJ5rRhB2LyR+qsgyZs/ooLwhWgPxjwonl+L9ki8
 OVrDHWtSZG5BDvukyUbENSC/54wAX7h7CMwXXIw3BHTBCsu2BhfQGbNozYwm6RI4SMxP
 lIlU8NfRu323VFMZDyGuGXODlmgEwC/lff+37Hh1CT9UtdS6yXCmDMVUKoa1AMOYeJtk
 oRWyn5h7ddxkiu6raPlgfr9yURL1B5Fd1SZe/NFIsAkXVaQhfdJKIV9Edv3Pbm0C7jyp
 6kFmL4xhtMUxDuZr5AN06eqlIomnGY7HJYREVcjv2yR6s0EzgDgrFT1RDRndrs/zXylv
 rV0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBlr+NZi/e/jlMdHt/28lifgWTq/EE4KbdexD8FYsV7S3u54ZcvuJIMrUHpDf9qoTpkSKWWs2KSTriqCF3LUVZIKM8I7w=
X-Gm-Message-State: AOJu0YyDt1Q68T81KQc9UMo8qowvawiQ85wNkND9Y1uqn8ZAdMM5uTqS
 8tolFM3vml4DOEjRJdDI7KwoXQdqP2lRrz7PZuXo6tYENvHtXiZz4b8fGJHPhGBIMR0+DlyD+WZ
 dItMb7dtd29zNc83xMHIbdLuv16qguO6ggnsauj6FIAlq705y
X-Google-Smtp-Source: AGHT+IG65jIqKk4rEH/xvHUKuxFW93vW6uRbPHc+jpyTMoiAoqBJTmPP6njprImap+ne0FyOE7M6jRlUJbpU+DN6YiU=
X-Received: by 2002:a05:6402:b53:b0:570:3490:c9d0 with SMTP id
 bx19-20020a0564020b5300b005703490c9d0mr4006458edb.12.1713518380403; Fri, 19
 Apr 2024 02:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <7c3b9a13-b503-47dc-ae02-ac9da8142605@linaro.org>
 <19458f9d-5833-418a-8665-80ab786102d7.jiangzw@tecorigin.com>
In-Reply-To: <19458f9d-5833-418a-8665-80ab786102d7.jiangzw@tecorigin.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Apr 2024 10:19:29 +0100
Message-ID: <CAFEAcA_Q86TH19xZMT=gtRwL-ABook5NAFTgcGjfnfcqhgnwCw@mail.gmail.com>
Subject: Re: [PATCH] tcg: Fix the overflow in indexing tcg_ctx->temps
To: =?UTF-8?B?5aec5pm65Lyf?= <jiangzw@tecorigin.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, pbonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Fri, 19 Apr 2024 at 04:49, =E5=A7=9C=E6=99=BA=E4=BC=9F <jiangzw@tecorigi=
n.com> wrote:
>
> > On 4/18/24 03:27, Zhiwei Jiang wrote:
> > > Sometimes, when the address of the passed TCGTemp *ts variable is the=
 same as tcg_ctx,
> >
> > Pardon?  When would TCGTemp *ts =3D=3D TCGContext *tcg_ctx?
> >
> >
> > > the index calculated in the temp_idx function, i.e., ts - tcg_ctx->te=
mps,
> > > can result in a particularly large value, causing overflow in the sub=
sequent array access.
> >
> > Or, assert:
> >
> > size_t temp_idx(TCGTemp *ts)
> > {
> >      ptrdiff_t n =3D ts - tcg_ctx->temps;
> >      assert(n >=3D 0 && n < tcg_ctx->nb_temps);
> >      return n;
> > }
> >
> > >   static inline TCGTemp *tcgv_i32_temp(TCGv_i32 v)
> > >   {
> > > -    return (void *)tcg_ctx + (uintptr_t)v;
> > > +    return (void *)tcg_ctx->temps + (uintptr_t)v;
> > >   }
> >
> > This will generate 0 for the first temp, which will test as NULL.
>
> Hi Richard:
> You can reproduce this issue on the latest upstream QEMU version. Using t=
he RISC-V QEMU version,
> if we compile a test program with the first instruction being '.insn r 0x=
f, 2, 0, x0, x0, x0',that is a RISC-V CBO instruction,
> qemu will crash with a segmentation fault upon execution.
>
> When the first instruction in the program is a CBO instruction,  temp_idx=
 in init_ts_info func returns a very large value,
> causing the subsequent test_bit function to access out-of-bounds memory.

I feel like this might be a bug elsewhere. Can you provide
a repro binary and command line?

thanks
-- PMM

