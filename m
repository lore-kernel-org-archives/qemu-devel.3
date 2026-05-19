Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CE9CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNEO-0007ZP-09; Tue, 19 May 2026 12:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPNEG-0007Sa-7Z
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:40 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPNEE-0000uz-HA
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:35 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-65c52bb5dd7so3662364d50.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779207813; cv=none;
 d=google.com; s=arc-20240605;
 b=cssMdi1KMlFNoCd5f66uxwTdQ8UjgHmqeOTzrvXyd7Wez3XnXr+dCtWzLWN1Oo+XBf
 D3/VlWjCCBK771yONqGEcKv4t/7TNTy4Rl3EYihnHPuvHkCL3Q0/jf28KJ4oPYLFdfhl
 0cl74uNsnQGOArnJoaa/AwEnKwJvWRBfpD9Q/UjP4UxHtYCjNJZ5D51OXk1byj1q8VT0
 mnimKD8C1Fi4vQWf0MMAJWZV1pjykd0GdmK84h5fIFh5aNlQTfBzLfAJmMTZ4Hg9pISC
 UOuWEaYCgtOfh3fz2/9xizoftOnxxKl8xVChhQb+/msUlw1n83MRhhW+DP/YCwM0CeLE
 /L2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UVOTS9detdZpXjAXqbIcCRmu8qompijFIeK6Gt+RojQ=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=EzKO37/rA0hwbHPKHA1nEy7JNW8zuW3ygLoI8jP/rLVDKBJ+DlJVPRASplb3pTOrWy
 I2R9L8C0BbKoh7J8scds2GzfiIymPe2ikKpmtud6cxd7s9xSNBtC8oQpDclSexnrWnqb
 BYk0oHz/FPa8KV2dUx0EITrg4x75RSHsZL0+MIyQIbFzIc1f+/5flSECaJ8u/9li3PD7
 KfktX7r2tX6cHm9rwdOPsxAI3QgBHpchZkOxp9EDuAzbNmK9aOFUzuKIxPnoN0wzfiEA
 Rc5grQmmXCBJgITArly1WCxgsz224f3ZtpSxuiZhDBR3A1mOLypD131e/6U0w8FflcQk
 hrdw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779207813; x=1779812613; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UVOTS9detdZpXjAXqbIcCRmu8qompijFIeK6Gt+RojQ=;
 b=uBAGwAJrCDA6LC2f0YfJr8zOrBTA198IIwxzgwR618RCzcf3DPG33xnlf2/79Q5kKk
 mN9GbY3+IfPAJXPtdI7Cm9E1DToWpjcm06tPwhlneXHnQAKnvD/H3jeEFSByp4xjcNGY
 YmC/8YAc7wKLmrp61q1QQwhSOwDxwXFtlMBjihEBn4d0FeZclNl8HdOhuVspEhtXEA6l
 Ap+fUfw5nu68grSvi14EUb0LhRr3r1SBqL1tVayzr3wDbrCQz3TIanGA9AlY+DbJ2Zds
 fq0XNmtK1VVcyz82Z2It3YWvGnqKIfwou3JKf0PAtaoPMej9SNc54zvubhiJjyn2aj5W
 5ZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207813; x=1779812613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UVOTS9detdZpXjAXqbIcCRmu8qompijFIeK6Gt+RojQ=;
 b=nhtAS9JCPvRaRMmGqWDbem2wZsUQSSIcDcRuvAvpI86jKQ3LqeCHs1b2aYT+Eq8P+s
 wF3argmygHD82HhfYGZ91qk0yFmCYi5+pLcVqO+rZ+ZkXLbaq5zjotg76pPf6J5ELZIC
 L/eC7vBDbolnW/6VVWz2RZNiwWyVRWIA8QFSOoDvb4sgHmFYHhx3llWc32orHO2w247f
 Zyoa7EmHGObmTE2jO3LWDNB0TVOeC9k89A6/JpK/ioswokrkX9ffwHSdPxtHlDz3ek+Y
 Bd0uQfAGgpcZd1CGmU8Hnh7JzmzXWPwyHJ3qQN2VnNEkm9SyLKB36PWApiCBfqSr2x3w
 fnNQ==
X-Gm-Message-State: AOJu0YypnWYUUAD1h0CAkUSB4+uEkGerajyuBzudqIcL1fEJV7jhnSpv
 98qatz1/Tbbsz0RQqTUV4sLYnEC1oE4i4z5QLw+rhfM6ZV2tzZKeHeBYDmvzfK+TPcLiFiWGwHn
 LKKIC5S1TOaJtD40kEXblVuJ55ilLKY5FHyhbI2JXibttglNG45497js=
X-Gm-Gg: Acq92OHhnF1TgSUb8kR+N5Q7PCdKY2WyM6Z8sTZepOW86lB7obtx9FasG04E00UL3em
 9fNG/9/Bz4Kv2wjp8HHZp7Jf7TRiQ7TahvGGxk+DGf/U6bsoCWBDUd3cviGuwDoyes5iNt8H8a9
 uOY1if8mChBJ01FwgPjLRc02E4P5gRxRzLhEsAeL30MU2et27TP9Aznb8TnQoEP8A/Xtvh5m1UH
 0saqdYgSMRJM8SqgSdChe5jrgWbHqAtefPHged8Cxjd8bQ/jGQJhx6SHuyIKa9z8WUDWxc6Vn1m
 u8YP9IgA8FYzO6S1rxGoGYdpEBty4ZmRKVY1DomwmJVtt9v4z+LWolUV9B9AMoxFzR6oOOLC4gs
 42w==
X-Received: by 2002:a05:690e:dcb:b0:65e:37bc:b72c with SMTP id
 956f58d0204a3-65e37eaf20bmr14121570d50.58.1779207813188; Tue, 19 May 2026
 09:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260517003002.321430-1-richard.henderson@linaro.org>
 <20260517003002.321430-4-richard.henderson@linaro.org>
In-Reply-To: <20260517003002.321430-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 May 2026 17:23:20 +0100
X-Gm-Features: AVHnY4JHay9qXKrKrztV8BRhyaQVC6xxJz2qMOluzbP_aQnhQ_SnIrpN291je7o
Message-ID: <CAFEAcA9SG47Nn=dijm8AHMFQzq7EG+=LyLkRL7UtYJsNBjfZKg@mail.gmail.com>
Subject: Re: [PATCH v5 03/63] target/arm: Implement FEAT_FAMINMAX for AdvSIMD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Sun, 17 May 2026 at 01:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> +/*
> + * Use float_minmax_ismag to get the absolute value min/max.
> + * Avoid float_minmax_is{num,number} so that we get normal NaN processing.
> + * If the result is not a nan, take the absolute value.
> + */
> +#define DO_FAMINMAX(NAME, TYPE, MIN)                                    \
> +TYPE TYPE##_##NAME(TYPE a, TYPE b, float_status *s)                     \
> +{                                                                       \
> +    float_status local = *s;                                            \
> +    set_flush_to_zero(0, &local);                                       \
> +    set_flush_inputs_to_zero(0, &local);                                \
> +    TYPE r = TYPE##_minmax(a, b, &local, MIN | float_minmax_ismag);     \
> +    if (!TYPE##_is_any_nan(r)) {                                        \
> +        r = TYPE##_abs(r);                                              \
> +    }                                                                   \
> +    float_raise(get_float_exception_flags(&local)                       \
> +                & ~float_flag_input_denormal_used, s);                  \
> +    return r;                                                           \
> +}

Because we use either FPST_A64 or FPST_A64_F16 here, this doesn't
handle the FPCR.AH = 1 case right. The pseudocode FPAbsMax squashes
AH to 0, so it always has the behaviour of the "normal Arm" operations
for things like what the default NaN value is and which NaN to
propagate when both arguments are NaNs. FPST_A64 and FPST_A64_F16
for QEMU both change behaviour when FPCR.AH is set.

I can't see an existing fp_status word that we have that has the
desired "ignore AH even when AH is set" handling; a simple fix is:

diff --git a/target/arm/tcg/vec_helper64.c b/target/arm/tcg/vec_helper64.c
index 2f481ac489..fc2566bddd 100644
--- a/target/arm/tcg/vec_helper64.c
+++ b/target/arm/tcg/vec_helper64.c
@@ -8,6 +8,7 @@

 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "internals.h"
 #include "helper.h"
 #include "helper-a64.h"
 #include "helper-sme.h"
@@ -152,6 +153,7 @@ TYPE TYPE##_##NAME(TYPE a, TYPE b, float_status
*s)                     \
     float_status local = *s;                                            \
     set_flush_to_zero(0, &local);                                       \
     set_flush_inputs_to_zero(0, &local);                                \
+    arm_set_default_fp_behaviours(&local);                              \
     TYPE r = TYPE##_minmax(a, b, &local, MIN | float_minmax_ismag);     \
     if (!TYPE##_is_any_nan(r)) {                                        \
         r = TYPE##_abs(r);                                              \

thanks
-- PMM

