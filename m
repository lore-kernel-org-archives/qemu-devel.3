Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE62CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWyn7-00053N-TK; Tue, 09 Jun 2026 11:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWyn5-00052l-RU
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:54:59 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWyn3-0007lR-Fq
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:54:59 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bebbc325000so735194266b.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 08:54:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781020496; cv=none;
 d=google.com; s=arc-20240605;
 b=dLbUe+EySwuNj8nE7kpLQRDQAith0DzpDJeIyWqbfzfT9PJwMl66aAVIeVgaSFhghr
 uoKzCUkV17HwBoCJ4wMSuF4MCPHRkXtYdFZcEUmYUEC5RrsWYP/dJsTsWcwUFY69yvpz
 6NTyiZc1OB9XsnywVXLxAdpFisdhlsh/W2DpBatAsfVBgb+KkiBoz3xS50RxMLDh5gX3
 rfzn9f0OKgaF19MOd62ixUdjhAB22dE0RRAJQ9NbjNz01DpW2EX3ycfg17aR3+0tmpDq
 dtRB9yHFL96ktYZ1/fcqeKC8gTCCI+XYn9vaevjIjtCP9sKMUMp6TzIsZegHYmv4I4iJ
 RMSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ByLWAy5t3hncFFGF/gnIjagVZZ6PIW3TT14Zn3l0Mys=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=OtEcUzykjr5zdjb4IeW1wSIuYPClqurwINqV5XdUHnYFI4kWolB6eKCUM7l6j10k+g
 CRaA/YeoqCezUpwIZlGrU8X0xrcwmj2brbqQUaQHZpZcjGS29ZMBHlg+i4TYoKtMyADq
 hNZb8XVa8WlbvHPcjx0i1jgEp+AuY21i5UHSkvrTra31rKgXSgouI2M6DBTBmIsSe6zw
 dVJDSsSu8ku720xpe6x54PFqRkdAgukzZbYgBiHYNlhRnm6d+6qjdEVBVvSKQUNqZEdn
 ckSlseiCbE4KVI3hJ9/FUObahOkdH1tZFGIwiiVa273S7IIImi4BkJujEEXh+L4UXkBE
 a7Eg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781020496; x=1781625296; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ByLWAy5t3hncFFGF/gnIjagVZZ6PIW3TT14Zn3l0Mys=;
 b=dKyc39ENP6zR8Ji15RDAdWuRYjvAEBZNXeEKM6BHGZJsOzvlFMncUEv8DE3Ij35mm2
 hKvCaumhnj5sGvQeWC3wFGZxpz/yGjahIaWVz87phU1gD6TLM5F6guwI3JMIUz1Wmzmq
 IF9nE73S1FnAAL9EXtFXOq3u0lf3WlQ+R0czzdA4fTfH4+C1vOi60x/xTm/rpymVn1rX
 V/mV5XVUTxG6S2qLJhww36fS0fpW9VTVYkqO6nDf+VVVmNMXK42395pIzBeUUuGMzoBZ
 aJyzT4SpSGaQeRFrH1jLq0yDWyz8hd/0Q1rnvE6dGSDcSUAfGmFvrzAHr6Y/d5h5Y3I1
 X51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781020496; x=1781625296;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ByLWAy5t3hncFFGF/gnIjagVZZ6PIW3TT14Zn3l0Mys=;
 b=WEkKNNu0oSzTAoiVfbdcSbvdl/GlLVffGrY6qqh3RDHN+gNQHnswxXnfltsbqFVKqI
 GHfX3lPpWGESgiCsIjBXIcHFCiUsXZSBUF9dYof/Hq62VjRW81RIllO7TzB4/srrnsPj
 nIzgvWcrpqMwuqvtUvp7JDc1S/4XO0dNkBZA5KjZHqm89kha5PaihLIjJqWFQNtSkMJM
 ibyP/MnjQ0Lp7Qdx4+D+npm7mapSKoQl+yTm3E7BJHcGFghUvgjdhlVT0qEnUO2d2Sfb
 6gENqS0+FmiHN0R2ok1DIFHG+pqtn6fU/WZLYvwooc8LlD9mIt1QVlXrRu23s0zaA/oO
 bfMg==
X-Gm-Message-State: AOJu0YyqS/PqzusbL5svmbQJsgPbyQnw8rkr8LTud6pvBnc9FHlQY4X+
 r725T7fzARDbkyw5MbIdIykVdyYxm+8QE+3oNN51DtAqCswdypn/GBySh7m4XceI8TZces+0Mpf
 OS3dLmcSVsdccLC1ampSHO+aADBej12S0dGvJPtRbc4/hom4+YGP7edE=
X-Gm-Gg: Acq92OEgDSuJ/iI/Fs4BfVJyzF/IMLXmsBMVxjWhsNH721mj+kMV0VKytA9TVtQIlcw
 +yViJOjvsOBRel7moe2pGFEnKdG6cxR/Ulc1aWcHNXR/HNZKAz7yizbdqWz3Q3whVLoD2rWo1D/
 ABtebkXMxugZl0qOpbbYXS8ghgU64s1wbSWMQ9Ip1t3npW6OjRckx5B/d9TcfXN0NV2H3tkDpXO
 8j0mKWRRojpryH48X+gVXEyqIh8u1a9/A5lX52McqxZvb8MObb6TpGBRj6NhRZ8VUnHzrloYbPU
 Gz9yxru/K4Z5OtSDLto/gzWO72BrsU5pLC4rJInk26hkf+FahEZJRQl4S+hFeZz41xsSvV7i1QM
 mgA==
X-Received: by 2002:a17:907:a44:b0:bee:1e36:876c with SMTP id
 a640c23a62f3a-bf3748d7bfamr1091447166b.41.1781020495385; Tue, 09 Jun 2026
 08:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-30-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-30-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 16:54:42 +0100
X-Gm-Features: AVVi8CfbR0tI_-6-sfiGP1TvTIUm9jB3KKTGQqLfcEFJDRseSzjLkt9RmWzpvnw
Message-ID: <CAFEAcA-JMfOMt8qhtXHb-brs-gLUnzL1JuBPNidY0ej-rRoHMg@mail.gmail.com>
Subject: Re: [PATCH v9 29/45] target/arm: Implement FMLALB, FMLALT for AdvSIMD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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

On Wed, 3 Jun 2026 at 04:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

> +
> +static FP8MulContext fp8_mul_start(CPUARMState *env, int scale_mask)
> +{
> +    uint64_t fpmr = env->vfp.fpmr;
> +
> +    FP8MulContext ret = {
> +        .stat = env->vfp.fp_status[FPST_A64],
> +        .fmt1 = fp8_input_fmt[FIELD_EX64(fpmr, FPMR, F8S1)],
> +        .fmt2 = fp8_input_fmt[FIELD_EX64(fpmr, FPMR, F8S2)],
> +        .scale = -(FIELD_EX64(fpmr, FPMR, LSCALE) & scale_mask),
> +    };
> +
> +    set_flush_to_zero(0, &ret.stat);
> +    set_flush_inputs_to_zero(0, &ret.stat);
> +    set_default_nan_mode(true, &ret.stat);
> +    set_float_rounding_mode(FIELD_EX64(fpmr, FPMR, OSM)
> +                            ? float_round_nearest_even_max
> +                            : float_round_nearest_even, &ret.stat);
> +
> +    /*
> +     * FP8 multiplies don't update FPSR.{IDC,IOC,IXC,UFC}.
> +     * Since this is multiply-add, DZC does not apply and only OFC remains.
> +     */

I think this comment hasn't been updated to match the code changes
following our previous discussion about what fp status flags
FP8 multiplies update:
https://lore.kernel.org/qemu-devel/CAFEAcA_4wU+wndbAqjnObpvnLit11OVDZvTZ1RWy_q0cNfH7uA@mail.gmail.com/

We ended up concluding that we don't need to update any FPSR
flags, but the comment still talks about the OFC bit.

Perhaps something like:

/*
 * FP8 multiplies don't update any of the FPSR exception flags,
 * so we do not need an fp8_mul_finish() to propagate status
 * changes back from ret.stat into env->vfp.fp_status[].
 */

?

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

