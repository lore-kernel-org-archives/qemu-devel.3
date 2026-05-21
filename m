Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69F5CD5BB0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 09:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPzHm-0002wF-OS; Thu, 21 May 2026 05:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPzHk-0002vU-Pb
 for qemu-devel@nongnu.org; Thu, 21 May 2026 05:01:44 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPzHj-00029L-25
 for qemu-devel@nongnu.org; Thu, 21 May 2026 05:01:44 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-65c3ea2ebf7so6720739d50.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 02:01:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779354102; cv=none;
 d=google.com; s=arc-20240605;
 b=OympT1ryrdD7iLKqZDNd6YFPoLtJgm4l4N6nThCXm8EBaLKqeGCtBYOgvYHdpvslhy
 v9optUiYrnitvzTPmZIWF5anRuCCJIeHGVrKsIe2iNCYwQSD37/2mInTk+NndxwgVSwL
 s0/1AeHGv6cM6n/gnkRaOmT4W6SJokjwRBcidxNGAItZr4PQt8dWoLLWSz6Hsh6gHjFT
 Lzysmtqqlrc5OqPEIPVkcTHgKwkxfx54AHXuJHhvtzyQlPU66CuvsXTcN2yvsg14cYkK
 MT15qQnOQs4bmi4FJP7UJ3w6d9byHmtDw0wf8WFb/HHqiCtTGryRYOOk2wamrN3RDhM9
 IEag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=q/ftZT8inunFniQ/SEoD05s/8z5qjIOgX4iEhTs33AM=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=YGIHBR7TDD1cf6Dzm7l/0WuQ/QiptoCXw22z1wUM8vJdOmOTDdGI9DodkY3g/PFCeP
 o7fKc/dhkJbiaxGDt3agF4U/oI2kC/K8GIaATQF8M8snHBEuf8gd3JkUHKzlVZ9XqPL4
 NhFThenM1nI6Wzi7CafYWcBFWKXLbFA3F6oZMAyBEfOCM4Mqf45aeNkKwyGaz++onnoV
 ACGGkej0ulmSPtwh83vzbdEtrK7T3vmISIUZAsBsnslvvTDblqO+DeEdWFdj2kWumQoB
 ltuAfJ7fwX1EbomiT2eJDbE4uWAcsjmwtBVZCAgN83nH7BdIci5mwMQ3yXlLQaONfr23
 nbiw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779354102; x=1779958902; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q/ftZT8inunFniQ/SEoD05s/8z5qjIOgX4iEhTs33AM=;
 b=l4+hnNLTV9hpvFZj0OUIBTMEizh2GtDAiHx/+4bNyMJxdnWJSuBywrXGVRAxiuyFez
 h8eESeWY2/nHw6Rcu/I5a+sjGQPVuA+toMNWvumkpUpCjnqIyUYuE1y/8jXKHqdJ62Mg
 Zd4u9Cn9BSuEhAdBZ6kFS2i51lUpj4hJNldtGXtuHsNfSE9Ssz5t/PfUBjSRrgcKhOF5
 6c4akxpxG5IMdKMvk1q/TDP6I+9eTY3LEkz0Wgs2K/eDjI5jMpYRaPAJ2WWCpGDLU51M
 R+vHaIMNN46b2mrvqC64zZSZ/NnvT6TSbE8d36pMAFU9WUW2rWvI6Ch7q4czbVDwEAbJ
 qFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779354102; x=1779958902;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q/ftZT8inunFniQ/SEoD05s/8z5qjIOgX4iEhTs33AM=;
 b=RjfRKtUlDFWxJKxtvDMB/wmXtn0IK5BXI6Pl510vvbdzKbOOLA8fuAzv943JkRYK4F
 YEZTPRtiMRuiZkCzHzGp7Sd/gC7CWK/sRI/9nA0IBSMIup/+aO6/H7x4BcK90KwKE4jo
 5oXp4Y5KB5BSGPsFqxCKDmN+sDIsDU8pwqh4mrU8taECEnbT+QZOXllfFD3Bt732KSQB
 9lruqTUc3VVjZYkxFtbzSFp5domcDqQ2W8B2v7qiEGkTIhtyqLsxXux/euyva54s80M3
 mUkrPk3Uc2wfLsmJJuQAx5/5mO354YKQSPo57KFTtT/5NsyPnFYr1v4lIP8HTzNNrB36
 d/pg==
X-Gm-Message-State: AOJu0YwGWibVPom0m0JPyM1VNWGdH2OqU81j5bFGyCu/ka+bb0szLGlp
 klaey+TBaAAcfT+zvT+SdSLsYx3l46WArHZLaaNFw9BWEIqPrdac1jQvf7pks6Yqkh8ya9LDatx
 cOZ644kLPdJfWDO3L3n6Ei2qRgBRg65J9xcaHAj/xZg==
X-Gm-Gg: Acq92OHonDZgkF9DHB6+i4/UhKXcObcrB5z2Sw/3AXTn8wL71SdivnOZNoZTZ6uiqLf
 4tPbr0O0Z4Dh/JBvr9X4VhJwNDaZ5cfTPCGeplFNd41slGmFQCCcVhizCv1rSLO2/Mf2LhMOLNm
 fGAG6EVHsa3PzGzLmbzuRJSGh2ujJORrLNoD4XdYoGuNLMhQBZfj5vcOSHowWsp5Thia36HRqHA
 C5DWR+WLiuSmjUs3xGYjWd2oGraMjxP1eyuEx8sdtZadpKtNElCfRI9qE6JM19/EK3zi05GWQZ7
 +L9EgUkFfhnjINiCoWkcWBj0Sf3qQno/vSwC/+o0jWCwiNPcniA6LSj0IHli2VyeO2CVfzCFUHO
 tuw==
X-Received: by 2002:a05:690e:128e:b0:651:c6e0:6be5 with SMTP id
 956f58d0204a3-65eae0ad1dbmr1564652d50.18.1779354101533; Thu, 21 May 2026
 02:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-32-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-32-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 10:01:29 +0100
X-Gm-Features: AVHnY4JEid7LxaWbXyH4yconjQYRiqOwA-VL_vuuqWAOw_1DBLR7BR1FI_-P83g
Message-ID: <CAFEAcA_DbZ3m+P6g=+uEvVJCSyUCuTdzDN26xwXLPTRrZLBOwQ@mail.gmail.com>
Subject: Re: [PATCH v6 31/64] target/arm: Implement BFCVTN for SVE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Wed, 20 May 2026 at 19:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> +static uint8_t fcvt_fp8_e5m2_output(FloatParts64 *p, int scale,
> +                                    bool saturate, float_status *s)
> +{
> +    /*
> +     * Because e5m2 has an infinity encoding, we need to handle
> +     * saturation conversion of Inf -> Max manually.
> +     */
> +    if (unlikely(p->cls == float_class_inf)) {
> +        if (saturate) {
> +            p->cls = float_class_normal;
> +            p->exp = float8_e5m2_params.exp_max;
> +            p->frac = -1ull << float8_e5m2_params.frac_shift;

This value is larger than the maximum representable normal,
so although round_pack_canonical will correctly saturate it
down to the maximum normal, it will also set Inexact and
Overflow in the process. In the pseudocode FPConvertFP8(),
input Infinity is special-cased and returns either Infinity
or the maximum normal without setting any exception flags.

To get the exact maximum normal you want
             p->exp = float8_e5m2_params.exp_max -
float8_e5m2_params.exp_bias - 1;

Or we could shortcut the packing process and just return
the right value:

            /* maximum or minimum normal value for E5M2 */
            return 0x7b | (p->sign << 7);

> +        }
> +    } else {
> +        *p = parts64_scalbn(p, scale, s);
> +    }
> +    return float8_e5m2_round_pack_canonical(p, s, saturate);
> +}

-- PMM

