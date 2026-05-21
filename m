Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FDECD5BAF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 15:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ54r-0006qs-06; Thu, 21 May 2026 11:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ54p-0006pt-GL
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:12:47 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ54n-000873-IK
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:12:47 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65c21049dafso5607389d50.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 08:12:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779376364; cv=none;
 d=google.com; s=arc-20240605;
 b=ffsGfuzhG58gCeBdj+KfcBMIAL1pJLdhHW+lwaj8KIw+lkCL+KTKMvxNE22HIDg5zD
 R6x9zpNqkke0ZF7v4BMr7bh8iz8Pv+l/MXnmXQzyz+oZknuxuKYKzDzroc4SqoWlQT8Y
 aqQq3pBR0OPcH9EbzrqxLJPbEzTwD6eR/58oqWHfDIn+G32P3lYrwiHA/jrDMn0Y10D2
 T+fLLzZajY59etAgDGO9tGLdd2d2jdixv+JsP14S5tzL0HMbExvZ0mthwrYyGCGnGvZZ
 Jwo+2zr8dF06hSmj+98y1Q72hxHr/M2rzKaeZWPx5qRzAVHd0EfiGW4Q63mE+bPfIdcJ
 VN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9OAadUeLy3H2QW23jDPFfpyo6cNr1U8V3TIXlbNjzsE=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=ISlxawkl6Y3bZxeXlKNBUC1El+bdPqdThGvo3IeCzTTmfzWZiRrduVIhbdwjKHQgk6
 76cL/RwZgxdyxtoW/ycBln8BOgavSWDROhDUeXApXErK4nZlvrz75STzboogfik4sY/a
 mJheeiuri4rpwzA1usfcLvf26KSqi1E56e/h1WwOnzqVwb7JeN2Vi0ExMeXQR7WuMRiP
 h+cp3TfsmY5RdQWOYS3EUyY53jjQcTYIhI/VJjJf8o6E8EfswIK5VZo+ppi/3D+ot0AQ
 sJagziTYXR+/Di69LCphU8gacMI4Ii+moD6L1sVsXWD+iK5K2WcV+JsIm6roBl/8gAOf
 wzEw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779376364; x=1779981164; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9OAadUeLy3H2QW23jDPFfpyo6cNr1U8V3TIXlbNjzsE=;
 b=zvwGce6immyr4sNtJjz5nLhAqf7Ty2ruomCDHhiyoMkaPRfY9o4jHaj9rV2uKmLhd+
 hme0cWJY8KJXTkHJUINpYzUtTgVeXcfL/NpPRy3stX6aV9/PqZDrUNKpSkZHCpm0SdSl
 ZBv7XT9iJtzmaLuI3DIJSu74Vlkv+5PR09UsUANbY3PvsjIsVvYwsrAu4pIs75VSumZf
 DkXzFS0qoEqofgOSIiLnILbuv9Kj3MsPD5pcqaopCFUwcLpCzOKALP9f0oPnpLRcX7JC
 yJNK10i1GkvtpP1Z62Awd4np3V/W5DUmc2hdrfdwH4k+mMeFn4LFoHd1zkUOPWitYPAj
 Pokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779376364; x=1779981164;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9OAadUeLy3H2QW23jDPFfpyo6cNr1U8V3TIXlbNjzsE=;
 b=a0r3ZsxOBELDXT0/6TDwBbdu7+tjaR6q+n6SlpdpOprETDy4J1YUiND5QBAgf7g/RW
 JoiR+h5IcZAdPlfX8sV7GZ6Q1Avx4K1iCiYI0gnYBWxdKA+jOlOW46yLPo4Z4tgSQIOZ
 oH6A3BWARZI/vbIelCvsTvcu8pfoeAjykfq56d9/YoutVNbw7Ut0VK04RejmHLzrnbcK
 JoGQUnjZTvtKXRRdqfI7+wxSBknjPDw9z5gkSl9vvxiQkaeTjoAPSoJRXWAQpqxJbs0Y
 eQopcrpMxAWwRSkfncC9PEbqpt2HJHmv0AmgloZiZt87mz+/gQtd+JhDelscOepzee1o
 7UuQ==
X-Gm-Message-State: AOJu0Yz/pXbvcWK+gLcE+7ZO4Gdle+nEk6d0e5+r3ojnVmpCuWTBkCGL
 dQRkHSY53xvBPsuk1JXkz+EMFkM2lRwsia3uFH8PPR3fsKGwshlc4hRurI3273I0ZqEkypU3o+L
 SGG/uiCYkX6V2G+gAuvibPdDs0vXsSR7A71sWYh5H2w==
X-Gm-Gg: Acq92OE/yKYjdNK7NU7n421X0IU23wVIlh8UBqIY0bHvTN65mS0Mm+DJ9KNRKdkVVwe
 CoYv/nG8H3RO/a981krWX5E+uXoHI/tESn2EQmXBXHPPBmjUKCaB6H7ENZRnmLQfHtjrAUrn/Nm
 prj0R9k9dyazzXO/NxzPW4uPOoe7azYhierUmDkCSNz6ODKjWXQKlLXuYlKbLcbh835aoi2Snl9
 OBV6kPR3IJUm5w/RbR3UMAYQD78Rc/YtjTM3TKU1H5qazD6QMZpJRZ4iGbtJpdGG+M5ZOLaTcFq
 u0fLRigZbqydLE9ViRxg9bzi+7CRuj0XVmky3bKZor/M1aiHIMNHmDtes+C65ldsBNo=
X-Received: by 2002:a05:690e:4847:b0:64a:ef61:188c with SMTP id
 956f58d0204a3-65eae151808mr2102040d50.47.1779376364154; Thu, 21 May 2026
 08:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-24-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-24-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 16:12:32 +0100
X-Gm-Features: AVHnY4L-_FP65oNPsdG7TpyNI0NqE9vOFpZbaMaz7RhQFSYixuI62ot41KZ-IOA
Message-ID: <CAFEAcA-KvaC0BVDFm6WPaGRLwHYVxF8UnPUa6SLK7utYJc8RXA@mail.gmail.com>
Subject: Re: [PATCH v6 23/64] target/arm: Set e4m3_nan_is_snan
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Wed, 20 May 2026 at 19:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The unique e4m3 nan encoding is SNaN for Arm.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/vfp_helper.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/arm/tcg/vfp_helper.c b/target/arm/tcg/vfp_helper.c
> index 8d3f6e3a2e..c10b085f08 100644
> --- a/target/arm/tcg/vfp_helper.c
> +++ b/target/arm/tcg/vfp_helper.c
> @@ -46,6 +46,7 @@ void arm_set_default_fp_behaviours(float_status *s)
>      set_float_3nan_prop_rule(float_3nan_prop_s_cab, s);
>      set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, s);
>      set_float_default_nan_pattern(0b01000000, s);
> +    set_float_e4m3_nan_is_snan(true, s);
>  }
>
>  /*
> @@ -67,6 +68,7 @@ void arm_set_ah_fp_behaviours(float_status *s)
>      set_float_infzeronan_rule(float_infzeronan_dnan_never |
>                                float_infzeronan_suppress_invalid, s);
>      set_float_default_nan_pattern(0b11000000, s);
> +    set_float_e4m3_nan_is_snan(true, s);
>  }
>
>  /* Convert host exception flags to vfp form.  */

These functions are supposed to set only the bits of the
FP config that change between AH=0 and AH=1; we call them
when FPCR.AH is toggled. Conveniently, up until now all
the FP config that remains the same across AH=0 and AH=1
has been the same as the default fpu config, so we haven't
needed a place to do "initialize float_status to the other
parts of what Arm uses", and arm_cpu_reset_hold has been
able to just call one or the other of these functions starting
from a zeroed-out fp_status, and then adjust the default
NaN mode and the ftz config for a few of the fp_status words.

So ideally we should set the e4m3_nan_is_snan elsewhere,
except that setting it on all 8 of our fp_status fields
is a bit tedious. Maybe something like:

/*
 * Fully initialize an fp_status to the usual Arm
 * behaviours. If you want the AH=1 choices you can
 * call arm_set_ah_fp_behaviours() afterwards.
 */
arm_init_fp_status(float_status *s);

and have the implementation be
   *s = (float_status){};
   arm_set_default_fp_behaviours(s);
   set_float_e4m3_nan_is_snan(true, s);
   /* We want 0 for all other settings */

?

Then reset can do
    for (int i = 0; i < FPST_COUNT; i++) {
        arm_init_fp_status(&env->vfp.fp_status[i]);
    }
    set_flush_to_zero(1, &env->vfp.fp_status[FPST_STD]);
    set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_STD]);
    set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD]);
    set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD_F16]);
    set_default_nan_mode(1, &env->vfp.fp_status[FPST_ZA]);
    set_default_nan_mode(1, &env->vfp.fp_status[FPST_ZA_F16]);
    arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH]);
    set_flush_to_zero(1, &env->vfp.fp_status[FPST_AH]);
    set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_AH]);
    arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH_F16]);

and the code we want to add for fp8 can init its local
fp_status by calling arm_init_fp_status.

thanks
-- PMM

