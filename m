Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C63C77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 14:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU4uN-00017K-BH; Tue, 24 Jun 2025 10:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uU4tu-00014P-Hb
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:45:30 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uU4ts-00006d-8Y
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:45:30 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-712cba3c6dcso36168887b3.2
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 07:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750776324; x=1751381124; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EFnGkFkO+hdQTtxXsJn7OU+AILNYhDMFhyhNUzhm1LU=;
 b=Wqz7og1We0f3FAlDpxR/8hO6WkcE18Y0WPLFOOMqpPKbBUXzlStGSE2JQnzFWqdqz3
 4kipkjIprfGImV/z5kF9UIMdBknfADW/wELA118RzYRhPsItb8rLEjkEIWWvQNG/zHPs
 1PHNv6x7bjJ4IQzGgQDDHWXZl386QLgzRvBMbSbN8cBi9cAr61oC6P63zHmGeFnKKCw6
 2eIM3drqgTG1LDKKgRhPvgcJWIBhnVxgd1qrogKXr2gkifch4z/kvAXoS75tqk5vvZJk
 hx+CsZNIwSJUzVcryBzEGal3ZA7mPAM33oYfMNhjKfGWg1Opi7hc6mwyO/GtNDQwdUXg
 h5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750776324; x=1751381124;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EFnGkFkO+hdQTtxXsJn7OU+AILNYhDMFhyhNUzhm1LU=;
 b=s2PyeURLoSdtkBIP41dL1kZ/hJRqxHezuEMUGF6n0GWMqBgTc1pF+9Wb1fZl10JaQw
 jROd+7u/nU9v14zeVdZGUlKKlxIBHO9W68WHHW3zQcw9FLFQuzm0/+OZwcqgW6Q5764k
 xKJJVRp8Z/D99Y6odHqY+1I225/joKo5H314af4D3O0KAPbfl9hiSGhe7zVi05V9QEgV
 IRz1fAD2wu+N+ndC9PeRkoEyKI+xxm6kAd9S5zOdaRp+pNd/jcT2k4c9h2itPXqsvJS7
 V24XM9zASULPXgYBdScdG2YUQn98Bxgckn/BP8/gmzfq45daL13NIv2PTtj4qGRkp06M
 zvxA==
X-Gm-Message-State: AOJu0YxRf/neN9KI8y6LUX+B4h9Qm1wlkr1hOdsYzbC5thDlODNdTzZe
 FJH+4ob1PgY5Xkx7+GhPa5J8ycrvHbqpwDCHT9BBMMg2QPNjzdZ3HhRjSZWyuAzeAQbTGfhlm0Q
 PKMlqQT6UAgvpJZ8cdNQEm9SSyK6+yPN+SwmpS8+40nukZxayNuvb
X-Gm-Gg: ASbGncvWHF89tIXJRnItTDiWkb4LjTcBQuyB7TT6VJiQ31R1zPcpH+e/6fikFIPb3n/
 rHlz8f1zHpZQ7p27Hzz+DuzWHRpkLFlQgbuq9o4UpLby/orPQY1r0i5GJpTDhigAsTRBj+xVDjU
 tENHMVNDn+QM3B/kxhq42u+XXqmQltovdjtvwoJ1vPdtMd
X-Google-Smtp-Source: AGHT+IG0KXzgAmbk5Yk6HQS9xExxSAPyvNF2QeCpQKD2akVQGa0mbD4OCcphJBQlUmUULBWln7AVh1mLq8O+9ugYdG4=
X-Received: by 2002:a05:690c:9418:10b0:712:e333:d3a6 with SMTP id
 00721157ae682-712e333d882mr116150227b3.19.1750776323616; Tue, 24 Jun 2025
 07:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-24-richard.henderson@linaro.org>
 <CAFEAcA_+nS5jJxaOdoLD=mQSUatL01+NckO-dTZqrti3JqzYiA@mail.gmail.com>
 <8eb7082e-d125-446b-a14c-eaa9642178df@linaro.org>
In-Reply-To: <8eb7082e-d125-446b-a14c-eaa9642178df@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jun 2025 15:45:12 +0100
X-Gm-Features: AX0GCFtsnW60ZYSsd8ZbCnxJxWzNawB9zVMLNOyBXQSB-AdZ_lqxaAgAA2IozfQ
Message-ID: <CAFEAcA_YsNLMfDG5CtYyrWcfaOLMS_OenRhVBpnt+SsfipxQVQ@mail.gmail.com>
Subject: Re: [PATCH v2 023/101] target/arm: Implement SME2 MOVA to/from tile, 
 multiple registers
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Mon, 23 Jun 2025 at 16:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/23/25 07:20, Peter Maydell wrote:
> > Exceedingly nitpicky nit: the pseudocode seems to require
> > that if the SVL is < 256 bits because the implementation
> > doesn't support any larger SVL then this UNDEF should take
> > precedence over the SVE/ZA-enabled check, but if the SVL
> > is < 256 bits because software has set it that way then
> > that UNDEF check happens after the SVE/ZA-enabled check.
> > (The former happens in the decode-pseudocode, the latter
> > in the operation-pseudocode.)
>
> Gotcha.  Will fix.
>
> Not all insns seem to have this split. For instance, FEAT_F64MM
> ZIP[12] w/ Q operands only has the second operation test.

That's because all of FEAT_F64MM's insns require 256 bit vector
lengths, so an implementation with only 128 bit VL
can't implement FEAT_F64MM at all, and we get the UNDEF
from the IsFeatureImplemented(FEAT_F64MM) check.

thanks
-- PMM

