Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AA8CD98F6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 14:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waECy-0004Sb-Hf; Thu, 18 Jun 2026 10:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waECw-0004SB-OA
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:59:06 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waECv-0001PM-0l
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:59:06 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-36b8d414666so571031a91.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781794743; x=1782399543; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PRUQcQhnQAI6zAyrr69hwMqSPPZ9s3F8m4p8vIly/wY=;
 b=ogpyqVHSWwtJBUT2eK8JqdXnTzYLMeAXR+cxm0VWYnvtNRnqEo4Ys/ZH1evuB2MNWd
 PQHOV+VB6zWOWPDJY7f7Nat/E1+iseTJhSkEBouTQ6MvIKnS0gsrTjoiTiom9YfnCSJI
 tV4GUevQTBLtWhHN4y0cK0O4+CL7aWfu5ZxKA4LN4dIcPZarsydzUfphBo9vraMYymTv
 HFl5fcL82q/mqMe3hM0o71vuG9F0olxdOL3DsmD+OJqsq1CwirwDzNLV2o8QwsftmYzf
 yp7aqCacHzon31na0GKA7C+9+4hKHh8hYmgngyqNsxknEFbAy/G5Iked+S3D05vEtnR8
 iPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781794743; x=1782399543;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PRUQcQhnQAI6zAyrr69hwMqSPPZ9s3F8m4p8vIly/wY=;
 b=s5HC0YOtHVWoV6FcEZSn47dm+Ka8BDvAEbJU48IUhIwxqNLepAdwBjvW0QFpcEU8Sc
 hFqjxsSy2pppqclMi/o4hraG5TE7fMKuWQQBuxTcwj5IqqOfQ3uIx9weFrKtpXRIynk6
 BQP4p7bHnJMN7YW2etxnlGQG4CbaIEZcOCvrZgYc2iJIDmb64Isv7/YVAEF6sMeb7b4x
 3UKp9phMTTvAX9+kPyqUtY2n2MDnj5B9cDbbGOMpohTsT8fK/ElHgG0b0gy8rlMvPB4Z
 gnRgnydLodVklOcb3gckKyT+DJOEQ+x2AQxeHgphgWZWlbQFpqD54sBb00q+b9Hanrqn
 bN9w==
X-Gm-Message-State: AOJu0YwrED2tW14NoPNQuRaXnJ0yLwfNeJaoFbEvCiabvLHRHULj4jHe
 FxcQixVyr1GRFprgteEM3ETa4m2uIK3XBJw7iphCfWX7WZ16B4jsc66jt+ys7i0fBlM0ICI8yzV
 bgNtH
X-Gm-Gg: AfdE7ckMFnL7xYHFJgH0EUjLtlZHB71XyfdN7pCyz7c6xX1u/fGMCXyER5gK5FCSqgJ
 aaW2yuXa90MeS7qZaZT4QbBq/nc5fnJO82hXCGFn2TiZ9hebu56GEG4NafagdYg9Pi2ldScXAS2
 tVC7pfPf/fnzvtt9OdbVuOZN1AOW77VNjeFtf1TIm0cwCb2Sk0YitfrBuwmNRYbkbKJKsx21Ivc
 oRJxCwkp1dLFdy4zhaA8Ushx58tetlM94wxl1mLrgDczR4YCGztb2LjSEGoR16eSIqiojTl4CxE
 RFSc1zw3QvRH403nqPGlz0NV3Hcfd2z8TOeVVL2HX5SOVra+rjyWBn9fmCuvwzguAqS9h866R9z
 OTkIGENMNFFNcd9lnBaLGzgo5qtAYgkd9CFNiB9cVE4/XMdAEuI+cVS0WwUYQC3+2C7PPE7B1cA
 74SgilelrYzVkv2DtF7Na/0mwuL9GB67qBco8Ppq7XLu7aeuC5Rd3hb3sqkg==
X-Received: by 2002:a17:902:d542:b0:2be:3434:4e28 with SMTP id
 d9443c01a7336-2c6f3465e4amr33942175ad.19.1781794743375; 
 Thu, 18 Jun 2026 07:59:03 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c6bb1297ebsm66524985ad.33.2026.06.18.07.59.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 07:59:02 -0700 (PDT)
Message-ID: <33b05999-4f43-4bb4-b73d-1be62d116e8d@linaro.org>
Date: Thu, 18 Jun 2026 07:59:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/arm/tcg: Implement new instructions for FPRCVT
To: qemu-devel@nongnu.org
References: <20260618-jmac-fprcvt-v1-0-1b4475bacf51@linaro.org>
 <20260618-jmac-fprcvt-v1-1-1b4475bacf51@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260618-jmac-fprcvt-v1-1-1b4475bacf51@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 6/18/26 01:20, Jim MacArthur wrote:
> +/*
> + * [US]CVTF, scalar SIMD & FP version.
> + * Converts an integer value in a SIMD/FP register to a float
> + * in another FP register.
> + */
> +static bool do_cvtf_simd(DisasContext *s, arg_fcvt *a, bool is_signed)
> +{
> +    TCGv_i64 tcg_int;
> +    int check = fp_access_check_scalar_hsd(s, a->esz);
> +
> +    if (check <= 0) {
> +        return check == 0;
> +    }
> +
> +    tcg_int = tcg_temp_new_i64();
> +    /*
> +     * a->sf should specify source size (64 bit or 32 bit)
> +     * a->esz specifies destination size
> +     */
> +    read_vec_element(s, tcg_int, a->rn, 0,
> +                     (a->sf ? MO_64 : MO_32) | (is_signed ? MO_SIGN : 0));
> +    return do_cvtf_scalar(s, a->esz, a->rd, 0, tcg_int, is_signed);
> +}

It would be better to refactor do_cvtf_f slightly.  E.g.

static bool do_cvtf_f(DisasContext *s, arg_fcvt *a, MemOp mop_int)
{
     TCGv_i64 tcg_int;
     int check = fp_access_check_scalar_hsd(s, a->esz);

     if (check <= 0) {
         return check == 0;
     }

     tcg_int = tcg_temp_new_i64();
     read_vec_element(s, tcg_int, a->rn, 0, mop_int);
     return do_cvtf_scalar(s, a->esz, a->rd, a->shift, tcg_int, is_signed);
}

TRANS(SCVTF_f, do_cvtf_f, a, a->esz | MO_SIGN)
TRANS(UCVTF_f, do_cvtf_f, a, a->esz)

> +TRANS(SCVTF_simd, do_cvtf_simd, a, true)
> +TRANS(UCVTF_simd, do_cvtf_simd, a, false)

Missing feature check.  Combining with the above you need

TRANS_FEAT(SCVTF_simd, aa64_fprcvt, do_cvtf_f, a, (a->sf + MO_32) | MO_SIGN)
TRANS_FEAT(UCVTF_simd, aa64_fprcvt, do_cvtf_f, a, a->sf + MO_32)

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

Likewise, better to generalize do_fcvt_f with mop_int.

> +TRANS(FCVTNS_g_simd, do_fcvt_simd, a, FPROUNDING_TIEEVEN, true)
> +TRANS(FCVTNU_g_simd, do_fcvt_simd, a, FPROUNDING_TIEEVEN, false)
> +TRANS(FCVTPS_g_simd, do_fcvt_simd, a, FPROUNDING_POSINF, true)
> +TRANS(FCVTPU_g_simd, do_fcvt_simd, a, FPROUNDING_POSINF, false)
> +TRANS(FCVTMS_g_simd, do_fcvt_simd, a, FPROUNDING_NEGINF, true)
> +TRANS(FCVTMU_g_simd, do_fcvt_simd, a, FPROUNDING_NEGINF, false)
> +TRANS(FCVTZS_g_simd, do_fcvt_simd, a, FPROUNDING_ZERO, true)
> +TRANS(FCVTZU_g_simd, do_fcvt_simd, a, FPROUNDING_ZERO, false)
> +TRANS(FCVTAS_g_simd, do_fcvt_simd, a, FPROUNDING_TIEAWAY, true)
> +TRANS(FCVTAU_g_simd, do_fcvt_simd, a, FPROUNDING_TIEAWAY, false)

Likewise missing feature check.

This could plausibly be split into two patches.


r~

