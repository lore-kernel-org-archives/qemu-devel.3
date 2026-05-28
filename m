Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C152CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 13:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSbEq-0003ac-Rg; Thu, 28 May 2026 09:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSbEm-0003aA-SO
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:57:29 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSbEl-0006Mh-9K
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:57:28 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-7dc78af7371so9387757b3.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 06:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779976646; cv=none;
 d=google.com; s=arc-20240605;
 b=fLMgTVY1zxAFp+1pZ9U49PDwxTXUsmhMLZVT5oMkT0jXeGwIXNYiaqg+K1N9TwbHIW
 6XjNLln/9CKUSN0H043W+5tTe2hqHGiQBPGfdN9eQsBYRhq0S0g0zeoaCCk6fpBayibC
 wRT57ybdZYwkunifv7d2CY1RNAqIdSriScp/QhhxdyPiABA8zQC7PMN33KcRbOpm3kMF
 pm8punGXYxKEwzykD8XxCZ6JRpfqI2c0qbcevb4bi2T6sYKDN/09LZvFgY3oZK91bvx8
 2RwYinEBvyBA4s9diubphLjLnYF3CBVz+WeBwSQ743zI1fDwyW6mz9Ct5RQyUr6a9st/
 Idvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Liy7Gq0IPri9HWKoliqrhfLW/Zbh8XpFgMCBbrNLYSM=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=W0uNTWjmNWB0+X/OOXsfhsIeyvCuOxphIJJ9C/ItjGtpV2lGkxjrYXUVcz4pZStq4P
 jLw2/WI29i+TQ72IT/Rd9zNowia4eaqOSKY114gANnxM5GuzGSNpH1SpAM54FPybq2qb
 QLR4D0MbxbtLxVfZ5IqI+7f6ZrM6/5jLgfD+OVkNhzSOuj2hoC3/m10+bFHxolKl2Nng
 pMBvm+cnLglBbuDKT9tIITWDkh9W5UBAnTDOkIbusRTHWdF1bAFZGWcufY1EktVAdbaW
 vvczE90n/BInmgqotBHqoQLWCnjBp3VoB0Evpx+NecdE5+e2eLu2nb2MUaSELpBkWSqy
 4vJQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779976646; x=1780581446; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Liy7Gq0IPri9HWKoliqrhfLW/Zbh8XpFgMCBbrNLYSM=;
 b=NgHgdWpTSgMvBo0v+AmkC5mlk19YCxt0BU/JArCHjZ7Ic1agcYTufcZg+RZV21YTHZ
 LA2MO8QN74PyxZ0nOQxGvuDmWf8vy4nSuXr99U7Dysx4DOEh6f928t9/5Yrb+rzaBNhZ
 taDPj7BC/Ptv24TXBLcnxsard2/LUwu/+10KanWtwIvJcX7N/HiPbe7LAjR23YpGg7Tl
 CmYZ3QVLa0Hfq31YWhQLS/TiRh0SaIVMJwnDrfrdPDTV2+l5fOij6MLLn6BRSWzAEvTi
 1C6Rn81pNSaYXQuHcyjsci8dzp4hK8EFYoRCDprgt9YKwy007DJZeN0WIyehrRTqlyqr
 az2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779976646; x=1780581446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Liy7Gq0IPri9HWKoliqrhfLW/Zbh8XpFgMCBbrNLYSM=;
 b=UID8MiU0+4podzyDGvA7NaN2HacEyARKT6DsM215tDHw+0VDPBcRorwZw81dfi18qf
 WTJHnAH9PC03HkGjKqPiqM+bFNkrvoNYjFsMSYUWj2PK+mL7P79ChfQqxU97RCC2UHO2
 hxfBBRg3XnlMe/ZGhLoJmJgchMmlXBYCrLoJtSWZPFfE9/T+KonJKMhMrAE4xEX5yDDC
 itElrQC2XEd5G5gws8OaVMVzF2LdtRHnOnrZw7QXk5bmtgIK4QaDcN5leByCwP1jO61o
 KdoKxyWRgF6O5XCWvxTa4TfjJATvIU/ahW0zFFSjrTOMBEVlR83B+hTwcbff6QwgiZxl
 w54Q==
X-Gm-Message-State: AOJu0YyC07Qq4wRJNpnHLAxkWXERh6Hqzv46HwiwDvlPQ3RWUV+VFVio
 sGLgwn9t/DSXu2NyadFa9zb4JO3Bo5S4qMdpGQoNueqVcygpMwnvhAbL566vYOBZbPCrYfVwkJZ
 y81WTDJ4PhtscwpZYy1G/DA/P4hrJ7GYr0usNEAhmJg==
X-Gm-Gg: Acq92OE3imtYVuSM+3PneHivXqyzzbPtRolzHcGuC3K4NJlaQM3AVOJFBdkEnbF+6sB
 hUqd5f4KAn5ppY9m25pJw/Ec0rzu3bblBZsms3c+JXsOHXlQAf1vqvNpN7NjqVIf1mWB0steTmG
 hO6pUYZwU9yIM1sIq8JpcZykQandj0IfcWCqTW6bsM53n/ib0sV+s1i5k9n2ogXfBupRGQDC4bv
 CqwfYrxUEG/7Xo/8POh130su66wH35nmg4cKJoiCELVV4xSGV+x+VWfi18lyEZc2UjOtX7AASs3
 q9w+tvPu5W7n3+s/wfo42G7HEhJa7icKyVNry2h3Umy/1wkMroqrc9HgHm6TFzuNgRPlzCyv81g
 xZbVjFnL17lrG
X-Received: by 2002:a05:690c:6a87:b0:7dd:489:b56a with SMTP id
 00721157ae682-7dd0489ba22mr13991667b3.25.1779976646016; Thu, 28 May 2026
 06:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260518174750.660258-1-richard.henderson@linaro.org>
 <20260518174750.660258-3-richard.henderson@linaro.org>
In-Reply-To: <20260518174750.660258-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 14:57:13 +0100
X-Gm-Features: AVHnY4IpfWu5Jtxb5GuKOgmGWTtwSeS9Lb1wRdfOEZk7IxnUchMbq_ul5pdAK_o
Message-ID: <CAFEAcA8DvDt7mt75bF=wTzQETopuvDaY0m3u8RYZy7S=_CrxQQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] target/arm: Implement CB, CBB, CBH
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Mon, 18 May 2026 at 18:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Compare and branch instructions, with various operand widths.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 42 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/a64.decode      |  9 ++++++++
>  2 files changed, 51 insertions(+)
>
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 9a27c4c6ec..293aa43cc9 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -1774,6 +1774,48 @@ static bool trans_B_cond(DisasContext *s, arg_B_cond *a)
>      return true;
>  }
>
> +static bool trans_CB_cond(DisasContext *s, arg_CB_cond *a)
> +{
> +    static const TCGCond cb_cond[8] = {
> +        [0] = TCG_COND_GT,
> +        [1] = TCG_COND_GE,
> +        [2] = TCG_COND_GTU,
> +        [3] = TCG_COND_GEU,
> +        [4] = TCG_COND_NEVER,  /* reserved */
> +        [5] = TCG_COND_NEVER,  /* reserved */
> +        [6] = TCG_COND_EQ,
> +        [7] = TCG_COND_NE,
> +    };
> +    TCGCond cond = cb_cond[a->cc];
> +    TCGv_i64 t, m;
> +
> +    if (!dc_isar_feature(aa64_cmpbr, s) || cond == TCG_COND_NEVER) {
> +        return false;
> +    }
> +
> +    t = cpu_reg(s, a->rt);
> +    m = cpu_reg(s, a->rm);
> +    if (a->esz != MO_64) {
> +        MemOp mop = a->esz | (is_signed_cond(cond) ? MO_SIGN : 0);
> +        TCGv_i64 tt = tcg_temp_new_i64();
> +        TCGv_i64 tm = tcg_temp_new_i64();
> +
> +        tcg_gen_ext_i64(tt, t, mop);
> +        tcg_gen_ext_i64(tm, m, mop);
> +        t = tt;
> +        m = tm;
> +    }
> +
> +    reset_btype(s);
> +    DisasLabel match = gen_disas_label(s);

Variable declaration needs to go at top of function.

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

