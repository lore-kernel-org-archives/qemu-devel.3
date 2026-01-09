Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22200D232E9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6wt-0007f2-LR; Fri, 09 Jan 2026 02:30:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1ve6wV-0007VS-FV
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:29:58 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1ve6wR-0007eU-4b
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:29:53 -0500
Received: by mail-lj1-x244.google.com with SMTP id
 38308e7fff4ca-383010b77b8so20040771fa.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 23:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767943789; x=1768548589; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tw7He0vAIQtDRAho29c+8srwuRGz0f4QO1t4OL/3Yuk=;
 b=Pxbk3YwWECIlvIiHWqPbLWxXu1CALn9wbWtxQDF6GZmyjYhRumHjhJjn8vuQWFqsML
 5OS9NUx3jn/JlLkuDHiC5Pimi3qfuSIw+bXd5qYeJtYCrGApICvuKphKkLgSxDKEdbdm
 Fa+o9/PD7fv1HwlVMuMtnmxw3nOY2XRp2UJWaWIZj64wjiIHG8p0GM/7G9ohNSPGacJ2
 qLQeKNX9wxS8MJp6UIYLab4frAz5WnAbEV59q5eqfhtuC4ip5vaZFflKBVTlMSd1wc0O
 LbTp5lgH7V5GX6CA5uKVRWY1pGtHZ/OSKtFAgCdY/MZZqstT39CDFJyljtyFNvxEx9w5
 eXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767943789; x=1768548589;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tw7He0vAIQtDRAho29c+8srwuRGz0f4QO1t4OL/3Yuk=;
 b=wUWOlaODxZqMw7O14+WuZ0HO8D6UbZbPbSI6iqoabD2EbwsAgvK289uvZ0GqNk24RK
 5WZxVCWfmOdKuOruUoe6nhTYcfDWEE83ufjce4ntfIAjP/Yk042oH9rh9WnhaAjeWuf5
 4NIMy9lK74i8KXONAR3z6JZAr26aujyOU97NIyRdYb8eGs1Cxz/Mv/8+5XidAPD8Bs7v
 AI/uukH5MHlm6aAvgF2q5mUuNJxw8EZ+30sEvs4b8JbQebGdUCui7FUEPLg1YlyVZ24w
 8Ss+pKz3CzFst7zZ1UtDVXz5QkgIT+1F6sGxijYB/RQIwOL7RUVPvUgrUn9d29HTEicL
 p5Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6pW5wAcEPPHr+0dA9b3wJLO2Yg3p1Pqip276Iv9uZncOKOp37rD3M14ccSvd946Z3jt9GK0iSZ/I1@nongnu.org
X-Gm-Message-State: AOJu0Yw7Qywye4n6ruWPm9eVfL5jPDzgLHAWAKlHgchizn/CQ9VbMaDZ
 L2GRBDMRThewF0zwx3XUHvbiCAMqqsxVLmvuXFvA94GivCmDOJ7jspOL2PxX6TdItNFmSRHBMj0
 1PuRaAgVSAgMVD7M8eQXzyIcJYV1QuDM=
X-Gm-Gg: AY/fxX6QrPlvFVvj2M8oCn7VMXZT/R2EfHVltoEjBbdX9F0IHxvwdU/++g17ZEqkME5
 WoF18aTapoyjP0b4nvSxGZGG330mVYVFTqBTcsh6nSyIaxVXuX+lztjj74SdEhQ6NJOPaoMJTFO
 5hPyrIeIZV8HbaAcTk6SGtw+5RymXYc0dFu8AbcFUrET6PPRdrFGqLalu8e4hD7+aXtHNEwqV4u
 0xnpQqkbQZAI/7fQP3e6trujqyc015Idb4kAEp9dS8Jr7jZMtrGwUPI6od2NlI+PZ34iUPFyykg
 jPR8AzPaEzV+C39+8zEAVk0TRWI=
X-Google-Smtp-Source: AGHT+IHREcClpgOZYWkldUmEW1VeuIHBwN7FcqTiXW5RBfeNgqfuxGV8vxHYXejoW0ZSQb6RmXG6M8MWj2zaaQuUiPM=
X-Received: by 2002:a05:651c:1986:b0:383:789:3c3 with SMTP id
 38308e7fff4ca-3830789111amr25762661fa.2.1767943788890; Thu, 08 Jan 2026
 23:29:48 -0800 (PST)
MIME-Version: 1.0
References: <20260108151650.16329-1-max.chou@sifive.com>
 <20260108151650.16329-3-max.chou@sifive.com>
In-Reply-To: <20260108151650.16329-3-max.chou@sifive.com>
From: Chao Liu <chao.liu.zevorn@gmail.com>
Date: Fri, 9 Jan 2026 15:29:37 +0800
X-Gm-Features: AQt7F2qREcIsxFADbn6hZy-AYEJqLKV0LsWe3_6ToBbvB-uP0hlc_irAxphb98I
Message-ID: <CAGL8uCX46bm9DsT2Tk=roW8VucY--G5fc10PuqJ=aQgo7y5+8g@mail.gmail.com>
Subject: Re: [PATCH 02/18] fpu/softfloat: Add OCP(Open Compute Project) OFP8
 data type
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-lj1-x244.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi, Max:

On 1/8/2026 11:16 PM, Max Chou wrote:
> This commit provides the implementation defined behavior flags and the basic
> operation support for the OCP float8 data types(E4M3 & E5M2).
>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  fpu/softfloat-specialize.c.inc  | 57 ++++++++++++++++++++++++++-
>  include/fpu/softfloat-helpers.h | 20 ++++++++++
>  include/fpu/softfloat-types.h   | 23 +++++++++++
>  include/fpu/softfloat.h         | 70 +++++++++++++++++++++++++++++++++
>  4 files changed, 169 insertions(+), 1 deletion(-)
>
> diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
> index ba4fa08b7b..3a3bcd22ae 100644
> --- a/fpu/softfloat-specialize.c.inc
> +++ b/fpu/softfloat-specialize.c.inc
> @@ -226,6 +226,30 @@ floatx80 floatx80_default_inf(bool zSign, float_status *status)
>      return packFloatx80(zSign, 0x7fff, z ? 0 : (1ULL << 63));
>  }
>
> +/*----------------------------------------------------------------------------
> +| Returns 1 if the OCP(Open Compute Platform) FP8 value `a' is a quiet NaN;
Open Compute Platform -> Open Compute Project

> +| otherwise returns 0.
> +*----------------------------------------------------------------------------*/
> +
> +bool float8_e4m3_is_quiet_nan(float8_e4m3 a_, float_status *status)
> +{
> +    return float8_e4m3_is_any_nan(a_);
> +}
> +
...
> +/*----------------------------------------------------------------------------
> +| Returns 1 if the OCP(Open Compute Platform) FP8 value `a' is a signaling NaN;
Open Compute Platform -> Open Compute Project

Thanks,
Chao

> +| otherwise returns 0.
> +*----------------------------------------------------------------------------*/
> +
> +bool float8_e4m3_is_signaling_nan(float8_e4m3 a_, float_status *status)
> +{
> +    if (no_signaling_nans(status)) {
> +        return false;
> +    } else {
> +        if (snan_bit_is_one(status)) {
> +            return float8_e4m3_is_any_nan(a_);
> +        } else {
> +            return false;
> +        }
> +    }
> +}
> +
> +bool float8_e5m2_is_signaling_nan(float8_e5m2 a_, float_status *status)
> +{
> +    if (no_signaling_nans(status)) {
> +        return false;
> +    } else {
> +        uint8_t a = float8_e5m2_val(a_);
> +        if (snan_bit_is_one(status)) {
> +            return ((a >> 1) & 0x3F) == 0x3F;
> +        } else {
> +            return (((a >> 1) & 0x3F) == 0x3E && (a & 0x1));
> +        }
> +    }
> +}
> +
>  /*----------------------------------------------------------------------------
>  | Returns 1 if the half-precision floating-point value `a' is a signaling
>  | NaN; otherwise returns 0.
> diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
> index 90862f5cd2..4e278a3ee3 100644
> --- a/include/fpu/softfloat-helpers.h
> +++ b/include/fpu/softfloat-helpers.h
> @@ -136,6 +136,26 @@ static inline void set_no_signaling_nans(bool val, float_status *status)
>      status->no_signaling_nans = val;
>  }
>
> +static inline void set_ocp_fp8e5m2_no_signal_nan(bool val, float_status *status)
> +{
> +    status->ocp_fp8e5m2_no_signal_nan = val;
> +}
> +
> +static inline bool get_ocp_fp8e5m2_no_signal_nan(const float_status *status)
> +{
> +    return status->ocp_fp8e5m2_no_signal_nan;
> +}
> +
> +static inline void set_ocp_fp8_same_canonical_nan(bool val, float_status *status)
> +{
> +    status->ocp_fp8_same_canonical_nan = val;
> +}
> +
> +static inline bool get_ocp_fp8_same_canonical_nan(const float_status *status)
> +{
> +    return status->ocp_fp8_same_canonical_nan;
> +}
> +
>  static inline bool get_float_detect_tininess(const float_status *status)
>  {
>      return status->tininess_before_rounding;
> diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
> index 8f82fdfc97..835dd33bf1 100644
> --- a/include/fpu/softfloat-types.h
> +++ b/include/fpu/softfloat-types.h
> @@ -119,6 +119,18 @@ typedef struct {
>   */
>  typedef uint16_t bfloat16;
>
> +/*
> + * Software OCP(Open Compute Project) 8-bit floating point types
> + */
> +typedef uint8_t float8_e4m3;
> +typedef uint8_t float8_e5m2;
> +#define float8_e4m3_val(x) (x)
> +#define float8_e5m2_val(x) (x)
> +#define make_float8_e4m3(x) (x)
> +#define make_float8_e5m2(x) (x)
> +#define const_float8_e4m3(x) (x)
> +#define const_float8_e5m2(x) (x)
> +
>  /*
>   * Software IEC/IEEE floating-point underflow tininess-detection mode.
>   */
> @@ -410,6 +422,17 @@ typedef struct float_status {
>       */
>      bool snan_bit_is_one;
>      bool no_signaling_nans;
> +    /*
> +     * When true, OCP FP8 E5M2 format does not generate signaling NaNs.
> +     * RISC-V uses only quiet NaNs in its OCP FP8 implementation.
> +     */
> +    bool ocp_fp8e5m2_no_signal_nan;
> +    /*
> +     * When true, OCP FP8 formats use the same canonical NaN representation
> +     * (0x7F) for all NaN outputs. RISC-V specifies a single canonical NaN
> +     * for both E4M3 and E5M2.
> +     */
> +    bool ocp_fp8_same_canonical_nan;
>      /* should overflowed results subtract re_bias to its exponent? */
>      bool rebias_overflow;
>      /* should underflowed results add re_bias to its exponent? */
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index c18ab2cb60..6f7259f9dd 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -189,6 +189,76 @@ float128 int128_to_float128(Int128, float_status *status);
>  float128 uint64_to_float128(uint64_t, float_status *status);
>  float128 uint128_to_float128(Int128, float_status *status);
>
> +/*----------------------------------------------------------------------------
> +| Software OCP FP8 operations.
> +*----------------------------------------------------------------------------*/
> +
> +bool float8_e4m3_is_quiet_nan(float8_e4m3, float_status *status);
> +bool float8_e4m3_is_signaling_nan(float8_e4m3, float_status *status);
> +bool float8_e5m2_is_quiet_nan(float8_e5m2, float_status *status);
> +bool float8_e5m2_is_signaling_nan(float8_e5m2, float_status *status);
> +
> +static inline bool float8_e4m3_is_any_nan(float8_e4m3 a)
> +{
> +    return ((float8_e4m3_val(a) & ~0x80) == 0x7f);
> +}
> +
> +static inline bool float8_e5m2_is_any_nan(float8_e5m2 a)
> +{
> +    return ((float8_e5m2_val(a) & ~0x80) > 0x7c);
> +}
> +
> +static inline bool float8_e4m3_is_neg(float8_e4m3 a)
> +{
> +    return float8_e4m3_val(a) >> 7;
> +}
> +
> +static inline bool float8_e5m2_is_neg(float8_e5m2 a)
> +{
> +    return float8_e5m2_val(a) >> 7;
> +}
> +
> +static inline bool float8_e4m3_is_infinity(float8_e4m3 a)
> +{
> +    return false;
> +}
> +
> +static inline bool float8_e5m2_is_infinity(float8_e5m2 a)
> +{
> +    return (float8_e5m2_val(a) & 0x7f) == 0x7c;
> +}
> +
> +static inline bool float8_e4m3_is_zero(float8_e4m3 a)
> +{
> +    return (float8_e4m3_val(a) & 0x7f) == 0;
> +}
> +
> +static inline bool float8_e5m2_is_zero(float8_e5m2 a)
> +{
> +    return (float8_e5m2_val(a) & 0x7f) == 0;
> +}
> +
> +static inline bool float8_e4m3_is_zero_or_denormal(float8_e4m3 a)
> +{
> +    return (float8_e4m3_val(a) & 0x78) == 0;
> +}
> +
> +static inline bool float8_e5m2_is_zero_or_denormal(float8_e5m2 a)
> +{
> +    return (float8_e5m2_val(a) & 0x7c) == 0;
> +}
> +
> +static inline bool float8_e4m3_is_normal(float8_e4m3 a)
> +{
> +    uint8_t em = float8_e4m3_val(a) & 0x7f;
> +    return em >= 0x8 && em <= 0x7e;
> +}
> +
> +static inline bool float8_e5m2_is_normal(float8_e5m2 a)
> +{
> +    return (((float8_e5m2_val(a) >> 2) + 1) & 0x1f) >= 2;
> +}
> +
>  /*----------------------------------------------------------------------------
>  | Software half-precision conversion routines.
>  *----------------------------------------------------------------------------*/

