Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43B9CD98E3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 08:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZPKC-0005JL-1q; Tue, 16 Jun 2026 04:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZPKA-0005Ih-6b
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 04:39:10 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZPK8-0006B9-P0
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 04:39:09 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6605859ed83so1035753d50.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 01:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781599147; cv=none;
 d=google.com; s=arc-20240605;
 b=ItuLImlXG2HxX8MT7qqNXlrE0LR+2T8/T5r4PWt6+rakYIR3bAtwxJ+GYJe+3KYe1T
 QT/UN5MdDPl+wWvuiLkLHvp93gY/FSRlNFVraIPjV8q1VeQPPjxu+FSyWWKxqz5mwOhd
 iMOMqYMh51r+BAPAH5IDs5TPvAUs5AwJk+ZQSzk+u0zDzFZ1hrNeBZ+YMY0WkspXf7Qc
 6ykIG3jWKS/RFp85C6w/n6Ld2sbn6WDt1q8bxWE9OrGmMTzEY+Q3xBPfQ9hwDQUzuvAm
 jCDmypSBrTXCnTUhEb44A2HSN5sVQzAZeJrXxeCAuYJsNwg7CEsaN9WEphlya7BQImm1
 lWMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=N/MzDZHrzQwAaBrdyKTl6mbJ8PrjnugzPWBeKnXXafk=;
 fh=OwYFBL65Din92tpHXFu1nP6pn6YPr5LFIlwd2G78oFM=;
 b=EQ151r/eaj+XF89w3QqQaScI4mRKTRFcBjysTotqvmNsH0klU3dx6cXGD9x3ow4fwO
 /sS5PrCf7zoNLEdEH+iPxOfJ1T8rATGUQtDmwdYrFPU4HnNKKI2GnX6TKxr7hYu7DwsU
 2dm2VCbxZRq9XFfivRsu1SpEYGO1A4gZyiAEBNf6vb2DxyLURf89GjHsdkNW9PYXzr58
 cfRuWlnK8LA8NOD/qQDUxMPb3VBsq3LLJKgHGpD3+4g4fQ8Wdzk6EKKAAsLA/DJ1l5uF
 TToGXUPYB45M2Fk2y/9rF+MWI9zjfHmsFgBRUUPKOR8VOYRzSH8djMblMi/3wKdlELca
 oxrA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781599147; x=1782203947; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N/MzDZHrzQwAaBrdyKTl6mbJ8PrjnugzPWBeKnXXafk=;
 b=JnRtlJ7AB38RweHAI6grnGGzh7OtSQUWlbIfnw9MnqUI7Bt0NTj4fpJrRtRcnzj6x/
 AlGARyBrrMwUc9scBQS4JCSm072xv9xfhm8I5m6crcYSihsTY3Yck1KEOgK3AqfNysuJ
 pz7FtCrzgwpc0LpSyCKfvLiyjDCySEwbKehrg5vMzUMTXALo0Mnhf4fRADasQDr+xadV
 MUW4W+qwa4b3GXLodicIvPsIwU5iOl/8Vw0vPdEYKpzbRT+NrCytJm2zFN1B7Vv8zLqZ
 VPSASw4MtOlKpH+TNAZixMC6Dyjt148HWYTBUTy/Ma2pGNLujWejWK8x6Chd8OkeHAtB
 BGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781599147; x=1782203947;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/MzDZHrzQwAaBrdyKTl6mbJ8PrjnugzPWBeKnXXafk=;
 b=n7gbxqQ7Nz0PZkJ3Y6Irv/LxoseTWFDdr1wfFlWszUhYmtXFh6AmpbUh7NAZZG77Vn
 4pSbYPKcqC+akljY4ZU9HNfGbeN/dRO3ssVXAUIxRX8X8WOqtLJYAzaStXuT4d/vlTC+
 HW3vUNRUJ/CQhC2PtRb7hTQTJRtDIrrFTHICzIjisDrXlIuEmw1sYRVWObMzz743OGwL
 QUR6wZ7wrjIOMaQq3YZ6Oz3IV1nZS6Z8qLgq3RpRFCfWozG203AJxAF2cAZd77GrFB5i
 RC97jdAilb8d/zKecyaNvuIQe/VBj7gV3ymRQHvEHhZu9qqW1KOF2EmoNBglYnNieCaM
 7Aqw==
X-Gm-Message-State: AOJu0YykZDbrFE7o0b4QMYlhSx9+JPblIgXEURiHgVihDQk/em8lX+La
 X+Ky2p4eYUVIJPI0u74dCP1e8tJ5UkEnHOdwqHewdCZUfIp8Nax2r7eWqFeAYepXjUA8QxsuWep
 EXqJrUCXD+r5p3zBMuf1o/Yqw/MWyRuR9C7dfOxgkzw==
X-Gm-Gg: Acq92OHWYhN6GnD8QSWeBhABkxkfjT6ufPx8QkYw7IVuL3cfY3MVjVN1E4dT0oKXbCE
 zGt0xkPP9OZZWJPyYiKpB7Aiyk0zwbQwvfVCWg8/yYNUmaOjZqaBS8tUxq4edLCNhHUTURCMm3E
 HhJRcMvDh3vgq/STaQKiy/v4ac4RdCx5/hcyuZpDjmxgd8mFFoEsg3YfE/iXppmKcMdF/CgWUww
 IsiUgDf3NV/sUf5ObOt3FZW4qf41bF+yVk8S9+PdburdUpNOuhAl6Gx+Tn4F0/+VM3m5QJpnrl9
 E5c5HIrfISXoYpcdVU8JWAPYxzb2pbc6d8HMjz0S+69p/RTp04rMsQK61MFHQzAForI=
X-Received: by 2002:a05:690e:168f:b0:65c:468:7b6f with SMTP id
 956f58d0204a3-662b61004cemr1820537d50.25.1781599147455; Tue, 16 Jun 2026
 01:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
 <20260615193526.2883349-25-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260615193526.2883349-25-pierrick.bouvier@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 09:38:55 +0100
X-Gm-Features: AVVi8CeBiXsaaP8WvsS35Gk7ZM6dJeweoMraRQ9-BFavj9JuBdA2ney85y5H91A
Message-ID: <CAFEAcA_-qwKp9tVeO2q1-uUzb+cSXgO+iZD0Rah-7jqemAJpiA@mail.gmail.com>
Subject: Re: [PATCH v2 24/26] scripts/checkpatch: ignore spaces required
 around some operators in C++
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu.zevorn@gmail.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Mon, 15 Jun 2026 at 20:39, Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> C++ has a different style when it comes to space around references,
> dereferences, so don't report it.
> Also, closing templates with >> gets wrongly confused with >> operator,
> so just relax this check.
>
> Some examples:
> ERROR: spaces required around that '&' (ctx:WxV)
> +                auto &[counter, p] = *static_cast<TbData*>(udata);
>                       ^
>
> ERROR: spaces required around that '*' (ctx:VxO)
> +                auto &[counter, p] = *static_cast<TbData*>(udata);
>                                                          ^
>
> ERROR: spaces required around that '>>' (ctx:VxW)
> +        std::vector<std::pair<Vaddr, uint64_t>> v;                                              ^
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  scripts/checkpatch.pl | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 2189db19f54..538e059e265 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2621,6 +2621,31 @@ sub process {
>                                                 if ($op eq '::') {
>                                                         $ok = 1;
>                                                 }
> +
> +                                               # Ignore * in C++: templates and
> +                                               # pointer types are incorrectly
> +                                               # flagged. Example:
> +                                               # static_cast<T*>
> +                                               if ($op eq '*') {
> +                                                       $ok = 1;
> +                                               }
> +
> +                                               # Ignore & in C++: & means a
> +                                               # reference, and this create
> +                                               # issues with some constructions.
> +                                               # Example:
> +                                               # auto &[first, second] = pair;
> +                                               if ($op eq '&') {
> +                                                       $ok = 1;
> +                                               }
> +
> +                                               # Ignore >> in C++
> +                                               # checkpatch is confused by
> +                                               # >> closing templates. Example:
> +                                               # vector<pair<A, B>>
> +                                               if ($op eq '>>') {
> +                                                       $ok = 1;
> +                                               }
>                                         }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

