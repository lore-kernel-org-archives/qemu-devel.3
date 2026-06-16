Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC7FCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZVhK-0006YU-H6; Tue, 16 Jun 2026 11:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZVhJ-0006YD-EE
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:27:29 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZVhH-0002dI-TW
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:27:29 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-66077e888b2so4255493d50.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 08:27:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781623647; cv=none;
 d=google.com; s=arc-20240605;
 b=EID/3AECWUI00sVNf9NkcLK03UYNRRwvp8fA2G9S0bJIo9lkgKmfw7DzVM+CNEuXTg
 EXe2FwWcOmBTFcVk9z9RK3RX10WhCngU4EP376XLc6+RFP1s4igNoEthX6GoMN52fywk
 Saoca+pEsCMXJr84pFQSdQNOpYxZko+hp+dw5tKI1YYiwx1bBOAOWd89Qg9Npwkus6OC
 5H7o8rYpoSiwzai0+9SEngFscKGbqX4DQF5l7keU1yCO6fcW+su6LgtqYzP9f70dvNkU
 kj8IEkn3/dahKSoqTIFU8+U0Sq6yVS7Z0wjsubQelU3oepNKz0nZGxZ07W4SRoRB/n+2
 wEZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LRcWexWvCq49tDGQm28QFblr5Loyse8ziE19iwFcn3Q=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=We62ypD03BtZxrlJSMnXXqIePuNDj+J9t0PIIH/unB2+560a0C+v9Ylk/LdxvrSqjm
 BGW23ynXxy6EfIIzCVsXP1eR7mawXlSZkC5JmtKrLewewzCJA2oZP6pkflNjx/aEh/BA
 qSUKp8W8T4zqllCK7xu4aP8eMkTxNwQIoTbE6RJK3dqsuPmebPYD9T8cl/7oEis6ij59
 VjFLK8QqkQAimwwhj7raeL5N7uYYKb77ukcpNLPzxf5w8CvvC0Y+7bCtnwG+R9gFbpFF
 yUXtu8B1ePBhAK22TLCkz3yZjvqJYNrK21xbgbqXMRo76Fhv3UTFxZlZUFcBKSHmjjfS
 4gWg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781623647; x=1782228447; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LRcWexWvCq49tDGQm28QFblr5Loyse8ziE19iwFcn3Q=;
 b=cyAdvvc/fWaAWTcNjtSJatdGJT5fwfiVw4cuj6H0ECSCYCMkFmfgIbCn5Cvfva2Ar/
 jfY03S1EQ677tQg0c/OD5LPa3H2a+VUU8QsxkAZQlo4f/sscN+pCA9SuhfWO7m+mJfR8
 UXxDoOfkhuZTKO9KB7O4ku6I793gSgvpXh4+jKeTWgiOkIP0b27Ckbo8SckO5KJO17Z0
 Z8hxWUajWhi+LuUnev+XqT/lPms2ZAhqx64IjANPW1Kn63xGdXPDgYRreVr/Noo7pkBY
 b8sCquH0VG1pWqi4AeIUzGDr8EbugaO3Ru1pK7Jk+acSZUX2k/9/HlObcKmOUAflOvxS
 00pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781623647; x=1782228447;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LRcWexWvCq49tDGQm28QFblr5Loyse8ziE19iwFcn3Q=;
 b=jFraOnOwEAuNI1SDJ2FJnuvFQBtlZazPuz5U4XGUpDu1LXJFjYqu7OW2EXbBK8/7jk
 aMszfmx60H7KkUGWsU8O9n2HNw7axdWlMkENy624q1DhpLKXXX5hJdVg7YerQyavOu1S
 AcrwveFZAusAdYoNznyri9ufHSB6uveD+zuixfRF8t3BVgvW8WtsVqgZR+dHwOrHqFeQ
 TJkVgM6ubwGQMHjGVasnY3O5mXIvQoDMRVEUDiTlzXt9JjRDVUp1cOIi0irWESnhRCI4
 ZqM01Cq3jg1bavVe7uE2cfJB55PqGnIPX9CIq/NxQVd3WnWu9FOeSNuBkqngoR8K8SO+
 8Brg==
X-Gm-Message-State: AOJu0YxEyLVuUEeaw580BqO60iotMS2T42VXiSl+rupiC6SSLQcRT6+u
 u7hUahJaz4flLDdG9ZHfsr3jvIzfJUpHYSvRKznJjyWKXtGQM8m2Ox0uYYlblP8Wpvok/XEw5BX
 +6QncN9A/Cvo/LTj0jPJVX8sdmfShnhsGeofNRcQevw==
X-Gm-Gg: Acq92OEgFUvcpif4P7Jk+cxx26k5MccdzFqieCRQoPAZgSlTj/MffuwXARdDKOagN1y
 txwFt66WicS0F2m70AxvWQlm4tXAssUlyhrUNqyjU3J/H0B5b68MabCXVc4H648S1qTMv4O7I0W
 q8/8SHYlbZbjg+cnjmxKkpQIaLgQkVcOPJpkR1zuxMPIWZCJVHu8Z+YrMd659Vo36JuToP7x0s4
 8jkqNaC1H9kj5kqAFgvnUN6+dXTg3QuN1rfrVQjzXMETefJvwTBdYpev+4RIAKlpypmwiidtpQs
 1VEtiaFT6DtevxJVPKRMByl7d7Oa/NLVbqTdqGkptx2v9Du7R0UWMSRJ8Zw3NY+axWI=
X-Received: by 2002:a05:690e:4810:b0:653:f51:90b1 with SMTP id
 956f58d0204a3-66277f7dc8emr11755109d50.24.1781623646655; Tue, 16 Jun 2026
 08:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-23-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-23-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 16:27:14 +0100
X-Gm-Features: AVVi8CeOfLUvCvJL1ESWV0Fh97fxx7QZ9ayojxTG215XY2Cpra3EsHyIRv5zh9g
Message-ID: <CAFEAcA-HfpZcg6Lqsu+GO=h8i8wOYRB-0A37jdkfSgmbiXCfng@mail.gmail.com>
Subject: Re: [PATCH 22/25] target/arm: Implement FIRSTP, LASTP
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Fri, 5 Jun 2026 at 00:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sve-defs.h |  3 ++
>  target/arm/tcg/sve_helper.c      | 30 +++++++++++++++++
>  target/arm/tcg/translate-sve.c   | 56 ++++++++++++++++++++++++++++++++
>  target/arm/tcg/sve.decode        |  3 ++
>  4 files changed, 92 insertions(+)
>
> diff --git a/target/arm/tcg/helper-sve-defs.h b/target/arm/tcg/helper-sve-defs.h
> index 11342e1e59..440a868cea 100644
> --- a/target/arm/tcg/helper-sve-defs.h
> +++ b/target/arm/tcg/helper-sve-defs.h
> @@ -961,6 +961,9 @@ DEF_HELPER_FLAGS_4(sve_brkns, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_3(sve_cntp, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_2(sve2p1_cntp_c, TCG_CALL_NO_RWG_SE, i64, i32, i32)
>
> +DEF_HELPER_FLAGS_3(sve2p2_firstp, TCG_CALL_NO_RWG_SE, i64, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_3(sve2p2_lastp, TCG_CALL_NO_RWG_SE, i64, ptr, ptr, i32)
> +
>  DEF_HELPER_FLAGS_3(sve_whilel, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
>  DEF_HELPER_FLAGS_3(sve_whileg, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
>
> diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
> index 3f99a362c3..57c7823feb 100644
> --- a/target/arm/tcg/sve_helper.c
> +++ b/target/arm/tcg/sve_helper.c
> @@ -4302,6 +4302,36 @@ uint64_t HELPER(sve2p1_cntp_c)(uint32_t png, uint32_t desc)
>      return count >> p.lg2_stride;
>  }
>
> +uint64_t HELPER(sve2p2_firstp)(void *vn, void *vg, uint32_t pred_desc)
> +{
> +    intptr_t words = DIV_ROUND_UP(FIELD_EX32(pred_desc, PREDDESC, OPRSZ), 8);
> +    intptr_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
> +    uint64_t *n = vn, *g = vg, mask = pred_esz_masks[esz];
> +
> +    for (intptr_t i = 0; i < words; ++i) {
> +        uint64_t t = n[i] & g[i] & mask;
> +        if (t) {
> +            return (ctz64(t) + i * 64) >> esz;
> +        }
> +    }
> +    return -1;
> +}
> +
> +uint64_t HELPER(sve2p2_lastp)(void *vn, void *vg, uint32_t pred_desc)
> +{
> +    intptr_t words = DIV_ROUND_UP(FIELD_EX32(pred_desc, PREDDESC, OPRSZ), 8);
> +    intptr_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
> +    uint64_t *n = vn, *g = vg, mask = pred_esz_masks[esz];
> +
> +    for (intptr_t i = words - 1; i >= 0; --i) {
> +        uint64_t t = n[i] & g[i] & mask;
> +        if (t) {
> +            return ((clz64(t) ^ 63) + i * 64) >> esz;

Why XOR? Shouldn't this be the same kind of expression as
we use in last_active_element():

            return i * 64 + (63 - clz64(this_g));

> +        }
> +    }
> +    return -1;
> +}

> +            if (firstp) {
> +                tcg_gen_ctzi_i64(v, v, -1);
> +            } else {
> +                tcg_gen_clzi_i64(v, v, 64);
> +                tcg_gen_subfi_i64(v, 63, v);

...and we use 63 - clz64(...) here.

thanks
-- PMM

