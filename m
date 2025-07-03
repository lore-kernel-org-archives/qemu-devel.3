Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7482FC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXH3X-000806-3Y; Thu, 03 Jul 2025 06:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXH3G-0007ym-HB
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:20:26 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXH3B-0004Aa-Ci
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:20:22 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e7d9d480e6cso4149872276.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751538015; x=1752142815; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rBLeovshoD+ZCFSZgZz9QHS7HmFVNwQ8FXr1pu4DzU8=;
 b=SJ5CBfJ612wWgG2yQbhZeVsQixjK4FeAwPdwyGX2RxnBxJQEuXO/uaRlAGk28duny2
 yzNdPy0CoAPM11Gzm0TrsFTurEUzR8ofuSUWiaNlekmvS09dySYLvAFLmsEhYwqQCMiv
 3Sr9eZl4/+/E9atNne5b5gCfyknYmO5hVChJ5eRVe8ZTkKgFUGR+CPzSiud/5vMiQPUK
 XF9RZXAzhXELRBfuXB0dyL0HfwHGnP+MQboVpjbZpVW6X4th7s64f766Xw++mY+SdnKN
 DX6nYKEDwZjswDGhJ3/8smgSaXtjdmTxfOA7aIN7ObbYAaPEo2pBzL3640B7LM+/YRhF
 Uyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751538015; x=1752142815;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rBLeovshoD+ZCFSZgZz9QHS7HmFVNwQ8FXr1pu4DzU8=;
 b=iwsA5SIFyWW3nOSTWqVerUUdSyXsA4QWmBMipaDciqxwTXnmfNXq8KTdv4uTFDrFzC
 IH0pQPNt+sV+8e+ZrPYaRiIqSIDY4JMmtzvogvtccUj0Z1cELWsiW2eGbb1mMAVmmSif
 aaZdB+tpVKT/tIai7RkdWgmP7thzRDwsad4odffaf0k2FTPUgo/K6YaHZmfB9UJiYQrH
 NMh0TVjyZqMsCszvJ0qq59QL+rThdWeq5R5Vkmssc6yBCkEDMez2DSV/wotw3y/lgm+2
 UucJI6TbfnCiT2Y8R63OMYVv7KS4z3aqCs2yxSW9zxOfJR63JCg5xghKNRwvT1e9wrUU
 BZGQ==
X-Gm-Message-State: AOJu0YyhzndSdv8ZM+Sgramc/621CwURGT2kzQ2CIzVTFBBo6T4MwUMP
 tcBtB8R6qLCKEczaos2/bneJRxRz1tFAYkF/MfSgvt9RRP22W2jAJ3jyCgf6M+0T7p8p/SlpbsY
 lfzMtWjTn8T8COGa5fTkFOw+Q/2SvDBHfhm1yE/LSxg==
X-Gm-Gg: ASbGnctyG8/XWOYKe6jnIJYWLlK2/O+oRk3EmZ4JQxEmK0qSygggdsdQjjpuviY6y+y
 nt7QXA+DY3z6QnTGUuLxIZ+RnJsGpf87gPXlZmUchVp9TGiZQlbgWFN/02F2RorqvEvlVh+qxQA
 DWqzAyaHCkeEHKWGsO1fY0ITprBTmRGHV7a1rPqwW+YIpO
X-Google-Smtp-Source: AGHT+IElWI9qsj1R4Ft8UAFZj+hQu1pVpT4T+3RzcbI74ejj9YZfM+wvvZ5GncAiJlOO4mqYMieTMKELGaZbmDrRe6A=
X-Received: by 2002:a05:690c:7344:b0:70c:c013:f26 with SMTP id
 00721157ae682-7164d4b3031mr98128737b3.33.1751538014535; Thu, 03 Jul 2025
 03:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-50-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-50-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 11:20:03 +0100
X-Gm-Features: Ac12FXzt6fZkMZ-XYKnDqIecQesdrQLiFZasRBXfGk69lw-sc9D8NTBzgj8H5Rk
Message-ID: <CAFEAcA-Qj5Vv6x08epwiWs0ihDLa4=mihMvrx=D+xOLkdYFvYQ@mail.gmail.com>
Subject: Re: [PATCH v3 49/97] target/arm: Implement SME2 SQCVT, UQCVT, SQCVTU
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sme.h    |  20 ++++++
>  target/arm/tcg/sme_helper.c    | 116 +++++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-sme.c |  35 ++++++++++
>  target/arm/tcg/sme.decode      |  22 +++++++
>  4 files changed, 193 insertions(+)


> index d69d57c4cb..906d369d37 100644
> --- a/target/arm/tcg/sme_helper.c
> +++ b/target/arm/tcg/sme_helper.c
> @@ -1561,6 +1561,64 @@ void HELPER(sme2_fcvt_n)(void *vd, void *vs, float_status *fpst, uint32_t desc)
>      }
>  }
>
> +#define SQCVT2(NAME, TW, TN, HW, HN, SAT)                       \
> +void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
> +{                                                               \
> +    ARMVectorReg scratch;                                       \
> +    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
> +    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
> +    TN *d = vd;                                                 \
> +    if ((vd - vs) < 2 * sizeof(ARMVectorReg)) {                 \

Does this do the right thing if Vd is less than Vs?
Pointer differences are signed, I think, so for eg vd == 0
vs == 16 we unnecessarily use the scratch reg.
Maybe clearer to write
   (vd >= vs && vd < (vs + 2 * sizeof(..))

(Similarly for other use of this condition later in the patch.)


> +        d = (TN *)&scratch;                                     \
> +    }                                                           \
> +    for (size_t i = 0; i < n; ++i) {                            \
> +        d[HN(i)] = SAT(s0[HW(i)]);                              \
> +        d[HN(i) + n] = SAT(s1[HW(i)]);                          \

Should this be HN(i + n) ?

> +    }                                                           \
> +    if (d != vd) {                                              \
> +        memcpy(vd, d, oprsz);                                   \
> +    }                                                           \
> +}
> +
> +SQCVT2(sme2_sqcvt_sh, int32_t, int16_t, H4, H2, do_ssat_h)
> +SQCVT2(sme2_uqcvt_sh, uint32_t, uint16_t, H4, H2, do_usat_h)
> +SQCVT2(sme2_sqcvtu_sh, int32_t, uint16_t, H4, H2, do_usat_h)
> +
> +#undef SQCVT2
> +
> +#define SQCVT4(NAME, TW, TN, HW, HN, SAT)                       \
> +void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
> +{                                                               \
> +    ARMVectorReg scratch;                                       \
> +    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
> +    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
> +    TW *s2 = vs + 2 * sizeof(ARMVectorReg);                     \
> +    TW *s3 = vs + 3 * sizeof(ARMVectorReg);                     \
> +    TN *d = vd;                                                 \
> +    if ((vd - vs) < 4 * sizeof(ARMVectorReg)) {                 \
> +        d = (TN *)&scratch;                                     \
> +    }                                                           \
> +    for (size_t i = 0; i < n; ++i) {                            \
> +        d[HN(i)] = SAT(s0[HW(i)]);                              \
> +        d[HN(i) + n] = SAT(s1[HW(i)]);                          \
> +        d[HN(i) + 2 * n] = SAT(s2[HW(i)]);                      \
> +        d[HN(i) + 3 * n] = SAT(s3[HW(i)]);                      \

Similarly I thought the Hn macros would need these to be
HN(i + n) etc.

> +    }                                                           \
> +    if (d != vd) {                                              \
> +        memcpy(vd, d, oprsz);                                   \
> +    }                                                           \
> +}

> +#define SQCVTN2(NAME, TW, TN, HW, HN, SAT)                      \
> +void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
> +{                                                               \
> +    ARMVectorReg scratch;                                       \
> +    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
> +    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
> +    TN *d = vd;                                                 \
> +    if ((vd - vs) < 2 * sizeof(ARMVectorReg)) {                 \
> +        d = (TN *)&scratch;                                     \
> +    }                                                           \
> +    for (size_t i = 0; i < n; ++i) {                            \
> +        d[HN(2 * i + 0)] = SAT(s0[HW(i)]);                      \
> +        d[HN(2 * i + 1)] = SAT(s1[HW(i)]);                      \

Hmm, here we do do HN(whole expr)...


> +    }                                                           \
> +    if (d != vd) {                                              \
> +        memcpy(vd, d, oprsz);                                   \
> +    }                                                           \
> +}
> +

thanks
-- PMM

