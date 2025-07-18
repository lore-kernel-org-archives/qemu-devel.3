Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D965AC83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 19:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucqvp-0000q3-13; Fri, 18 Jul 2025 15:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucqV0-0003KL-Rs
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 15:12:02 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucqUy-0001Y3-8r
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 15:12:01 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e7d9d480e6cso2043800276.2
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 12:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752865918; x=1753470718; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v4xwvNtll+Pk7RSVpzpPc2Cr5zO+kbm6v/0CLrk5xEM=;
 b=Km3sa2el+zkuQNYcQjq6NDe3S1mbkgXRIMCsvAYTVuWhXYe9wezt7RmOc8i2aTiOAX
 g4JaJcaVXrdxsnO1qjO6ififvMR9fSTU+Uu4RjhOWMgraLM1aABBl9Q3Tfrom8C8uJa+
 CcMNScPuJcmiX9DnV4dhWpGlErdbSO+wS+/1lz21lMCbpefmZ/UVNqQbo6x7kQKfcFW4
 Y0QmgFMb/JWUtxsfc3jSHcjscb+LIpH+e+IFiUzhyG2+xFfrzZ8fE1uZvv9zeoDV8ffu
 g8EqajBLPrJSE6ulsMZ4PpJW2PK0vop/iRKI7ZMMz2lKpGpOVRWfn1m/Qx6VXglQhW1d
 EfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752865918; x=1753470718;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v4xwvNtll+Pk7RSVpzpPc2Cr5zO+kbm6v/0CLrk5xEM=;
 b=DAzywKX4aoK7U0b/eZalgn/9FymMAAYchlD1nFuZWPoKxv36EuDJakD4cYMoM/FIum
 2cO0zOx4lbxfG5S2zl8KlRj2flXtWN/09fDYylyk+uTwB6nLxL7wHbqIyZKKHed1ceBR
 c0sO9iL5BpJz41Da/c/X3VAlVdmsMg7aN5nGQlstlu+9hAyPAgJT5joOR4A5PeFHt3px
 66egP8vxvhbGW4Hb4gkoU/EcMyjOAEvwX17mejqxEdBu4L52OE+rmYzfZq35o+m49QO8
 dxpkv6gtgAiQU3FThjxVL8GJliJVyH/zFBdzmmKf9Q1L1bgzUoWUUpJ7nHyUoTEsadRM
 l0UA==
X-Gm-Message-State: AOJu0Yzb/XuhpHMPVKTVYeJn/7VTYRXaPut+DRXE42zOgsuXH2zN8VB9
 PiKuVOpgv5rWcb6RvOzfI5cehmjvZuTu/3NmMd2WkjiGfWJ04ESxsg1IvnonAXZTl8JSrgjb68z
 XCaR2LddPAd1mlBSSjdl0D3IScIvkp65+U8OaEKKhtw==
X-Gm-Gg: ASbGnctxAXP/MHLXV8ZAi1RN33VgoQxGMxGTK3oNBUo5Q4itgJ2Q12EbDYThzAILQzI
 /yn4rq98REkFiN5xNiyi8HrzIV5wOriG2RKWNr/d5Txc0RnamZNZNi2nNN0s8RYqZJiSj0kKnS9
 rUj4FB/7mWNLVkA3smOfTvxNHEZUSHgEuNcUEI1AqT9slfqgD4Gt1VnlTF6MBW3hnWBqrgRtZYC
 YJp2pUvgg9+DCTKxlc=
X-Google-Smtp-Source: AGHT+IHEnO196Q40JvjD+4c+YcezdYKcxNXc8bQMu3SkDGYcy0kq0PtvCB5zX831NkbegeuHi0TBMr9j7oBip3xZQsc=
X-Received: by 2002:a05:690c:6408:b0:70e:2d77:3cfe with SMTP id
 00721157ae682-71836c6aa9bmr186419967b3.2.1752865918309; Fri, 18 Jul 2025
 12:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250718173832.47820-1-richard.henderson@linaro.org>
In-Reply-To: <20250718173832.47820-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jul 2025 20:11:47 +0100
X-Gm-Features: Ac12FXzdc0aNY4_eAmrcTGCDdJaJR9F8OObI0O5mBWMPAaoHXTQMafM-LGYr5H8
Message-ID: <CAFEAcA-nY-2YrZQg6seKzhqYvKc7Adu_xZVsa380KL1XJ4AuJQ@mail.gmail.com>
Subject: Re: [PATCH for-10.1] tcg/optimize: Don't fold INDEX_op_and_vec to
 extract
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Fri, 18 Jul 2025 at 18:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> There is no such thing as vector extract.
>
> Fixes: 932522a9ddc1 ("tcg/optimize: Fold and to extract during optimize")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3036
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/optimize.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 62a128bc9b..3638ab9fea 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1454,7 +1454,7 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
>      a_mask = t1->z_mask & ~t2->o_mask;
>
>      if (!fold_masks_zosa_int(ctx, op, z_mask, o_mask, s_mask, a_mask)) {
> -        if (ti_is_const(t2)) {
> +        if (op->opc == INDEX_op_and && ti_is_const(t2)) {
>              /*
>               * Canonicalize on extract, if valid.  This aids x86 with its
>               * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcod


How does the fold_masks_zosa stuff work for vector operations here?
The masks are only 64 bits but the value we're working with is
wider than that, right?

thanks
-- PMM

