Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F3ACDE002
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcPce-0006nS-Hl; Wed, 24 Jun 2026 11:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcPcV-0006YN-T7
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:34:32 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcPcT-00066Y-B0
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:34:31 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-842307472d4so626657b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 08:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782315267; x=1782920067; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R0Pj1hqE0m1Rh9djYkM4GnP5bV55XrC3Am6L+pR13BE=;
 b=YKXJrXzGJ3IbWhaKrR3NNRczHdY7iVeCC5l9HoO+syy+HK9ImUr/E44kDM/lz5iOoj
 rMdYIiLCqaFV9qaPZDTxdHwnW7dkw/rqGuHjCvpnzh2HSWfiBLr6EwzjFGjA71TMMGAh
 00W87dnhS5NYP5NEGHb2JaQxzDRQbILbl9iePO09YdU6ROKGdUNzwYcA7kjFN++e0JnM
 BVxOejcsCaxXC7gUbBjqjpPLPS047GpkdSQXx3ZBiRsRVEFrX6kzxtRdjnYNcIu46ywn
 YOnpFY023qLaYiAIajXlpYtkULDJ7TpfmI/8C3MrSZL2do9FIFmvRea2CLTTsVbrbz7a
 O61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782315267; x=1782920067;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R0Pj1hqE0m1Rh9djYkM4GnP5bV55XrC3Am6L+pR13BE=;
 b=awz20g2DmYA7kzsn6fTCI+CawcygBvxMIftC6/FTIWjiDN7n8yKqRjwsD9as/qehil
 Dtx7iA4WHJ1u2bBhFtTJOjmcZC6Nki5Nz0jL/TteNkb8s6Kl0Ed+nYgR53DyapatwRFD
 B9LeRCJEGsYvkcpks6kKMnx552Jb/b+4Drd0bm+JL12dzHI+tepWsO2pHiE72xgaHvQL
 G3m1bv/DDfKNS3QzgSC5nWkhhph5H/grX7qXa2jeTtxlvZwJpMi44GYPKamblMcbqlMC
 sqII1BZgpN3py95aBAiQl4uYH+zZP5kqPEYusmv4xRNcCrrRpVgD+Peh1vlO+GutrgDv
 +cgw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrrQuwYGb3HCy+y5M9Q42fPPFysrVKZRw/yrdZYoKqVWX44n+ZCve44+3jAc/2qzx2zPLHgLFdiJtwX@nongnu.org
X-Gm-Message-State: AOJu0YwixzIV40OiNYmoU5PP4E1uDP1ntCXyyAcERBXgp5dAgGVN5Lns
 2vRdyDF8Ks/v7y3PPQEfdcpLt877xldEOkCg19PHUe+9+IeATL6FGHTVjBPM+w9y4l4=
X-Gm-Gg: AfdE7ckDWPqqWORrSoO7Gl3hFfAMCOLZDKANdTGZUf0+jMwjKUTrS+ItJ86y8rKCf5C
 QJVcVmayBsOFVmo441/px1g9HbxqjpdJKklGh+9Tw5ovE/RDuO5aVFMdvN9YA3fWWF+pSKahMqd
 fWjVhFfvzEA4OHgeuTbfWr4O1676HZSkz82whXT42dGXHcUFcvUmugjEKJm4/uI/0BV5OPxohIb
 8e11blpVSv8QW5TmLuC+aO8u1YljSOrOB6z8GXuVpc2BhdwQ9LnhSZv3Yy3lVFhM32y/WjemPOt
 CsycRpj8WOjjcUz0TbABHIdWjla20B4mOvs1+BECTCn+yPIThV/jFgt5XRdO6vuhS9L9eMEMdz6
 DGtmz4DmzUBSULt7fYnA/s0D5GdL5q9zk5oL6HKG9qB4FGlBz5DMM8ID6Bwj7BQTEM0uYFC8YHn
 E7+Z1kn1QAzetSKFrF4hg6Q4mO8Zm7fj6gcot8tXiWmGIb+vtLji2F91JV9Q==
X-Received: by 2002:a05:6a00:2992:b0:841:dc85:1638 with SMTP id
 d2e1a72fcca58-845625b5631mr27929730b3a.42.1782315266485; 
 Wed, 24 Jun 2026 08:34:26 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a413d2aasm3009283b3a.59.2026.06.24.08.34.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 08:34:25 -0700 (PDT)
Message-ID: <4c5c2c64-34a5-4d60-a199-c31a837e38d1@linaro.org>
Date: Wed, 24 Jun 2026 08:34:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] target/arm/tcg: Implement new instructions for
 FPRCVT
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alex Bennee <alex.bennee@linaro.org>
References: <20260624-jmac-fprcvt-v2-0-dc6cf8e512b6@linaro.org>
 <20260624-jmac-fprcvt-v2-1-dc6cf8e512b6@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260624-jmac-fprcvt-v2-1-dc6cf8e512b6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 6/24/26 06:37, Jim MacArthur wrote:
>   /*
> - * [US]CVTF (vector), scalar version.
> - * Which sounds weird, but really just means input from fp register
> + * [US]CVTF (vector), scalar or SIMD version.
> + * Which sounds weird, but really just means input from FP/SIMD register
>    * instead of input from general register.  Input and output element
> - * size are always equal.
> + * size are always equal for the scalar version and different for the
> + * SIMD version.
>    */
> -static bool do_cvtf_f(DisasContext *s, arg_fcvt *a, bool is_signed)
> +static bool do_cvtf_f(DisasContext *s, arg_fcvt *a, MemOp src_mop_int,
> +                      bool is_signed)
>   {
>       TCGv_i64 tcg_int;
>       int check = fp_access_check_scalar_hsd(s, a->esz);
> @@ -9918,14 +9920,18 @@ static bool do_cvtf_f(DisasContext *s, arg_fcvt *a, bool is_signed)
>       if (check <= 0) {
>           return check == 0;
>       }
> -
>       tcg_int = tcg_temp_new_i64();
> -    read_vec_element(s, tcg_int, a->rn, 0, a->esz | (is_signed ? MO_SIGN : 0));
> +    read_vec_element(s, tcg_int, a->rn, 0,
> +                     src_mop_int | (is_signed ? MO_SIGN : 0));
>       return do_cvtf_scalar(s, a->esz, a->rd, a->shift, tcg_int, is_signed);
>   }
>   
> -TRANS(SCVTF_f, do_cvtf_f, a, true)
> -TRANS(UCVTF_f, do_cvtf_f, a, false)
> +TRANS(SCVTF_f, do_cvtf_f, a, a->esz, true)
> +TRANS(UCVTF_f, do_cvtf_f, a, a->esz, false)
> +TRANS_FEAT(SCVTF_simd, aa64_fprcvt, do_cvtf_f, a,
> +           a->sf ? MO_64 : MO_32, true)
> +TRANS_FEAT(UCVTF_simd, aa64_fprcvt, do_cvtf_f, a,
> +           a->sf ? MO_64 : MO_32, false)

Good, thanks.

> +/*
> + * Floating point to int conversion, but puts the result
> + * in a SIMD register.
> + */
> +static bool do_fcvt_simd(DisasContext *s, arg_fcvt *a,
> +                      ARMFPRounding rmode, bool is_signed)
> +{
> +    TCGv_i64 tcg_int;
> +    int check = fp_access_check_scalar_hsd(s, a->esz);
> +
> +    if (check <= 0) {
> +        return check == 0;
> +    }
> +    /*
> +     * a->sf should specify destination size (64 bit or 32 bit)
> +     * a->esz specifies source size
> +     */
> +    tcg_int = tcg_temp_new_i64();
> +    do_fcvt_scalar(s, (a->sf ? MO_64 : MO_32) | (is_signed ? MO_SIGN : 0),
> +                   a->esz, tcg_int, a->shift, a->rn, rmode);
> +
> +    if (!s->fpcr_nep) {
> +        clear_vec(s, a->rd);
> +    }
> +    write_vec_element(s, tcg_int, a->rd, 0, (a->sf ? MO_64 : MO_32));
> +    return true;
> +}

I had suggested that the same MemOp change be done to do_fcvt_f, for the destination.


r~

