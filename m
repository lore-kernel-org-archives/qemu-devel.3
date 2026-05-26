Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C09CCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 10:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRp8D-0003sx-QZ; Tue, 26 May 2026 06:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRp8C-0003sS-4P
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:35:28 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRp8A-0004mK-9u
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:35:27 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65c21049dafso9361504d50.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 03:35:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779791725; cv=none;
 d=google.com; s=arc-20240605;
 b=XeSu1hdNZIMxBAOV37l7rZvHqdXpIMHuxf1uAEhHmupNVHlnhvXCdnfKF7UPpQR6Re
 YUgvGFxi5YTdeq4orwdlPQEnYx2ouD+jsHWoZQtS+YdTYImmaD5HSwub4848k3NXt1ld
 5gmlXXZ3c04XXgASKWfMX4ZuNzFHPe9kzbaG2xWIYIygfAd9gYLQp+Jw8TZ0NdXqorkC
 kMNK5m0FITsMzLn9Lm3MfEBrYoJaKYm4rTBDonMTz5b2G2YitQE2XbvQ5/NF5MnRx1+y
 uSsZ85Puhzzs6JyulFRDcvJ5VUQ9xjVavqbj80AREK6ratrSM2NMon1j+yUr9TfYtsro
 FjAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8FBtHS86zxEDYAxC8eP7pfGIMxW6VLBRn2QKCrqcg70=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=GbcSv4vFAKo+/JC9YKITm6soozTC3jbibAnKgVGKznSEEGdTeSsfPUjQkrfDTlSUHY
 omtLTE2fD+3P96OtZHS0S5OhzIUI03ImqsIO+XSvjymsjb0ZqK30uVMRmXmaYZ2mb7D4
 w8Ccb1uhbhUL7Fiv7m0E6r9ko6NKpVRIDseLeBRX84nNXjQwocm8srFClgbGM2z42nVf
 YbAIpSLG+YLKy6G2gLaiVh1JTVAx+i+fJoOEYf8lLUyzKbvmjpRKH5GkIegbhOjWgEAQ
 EPpT3sZAKi0AXaCOtEcVTCE2qdJfvcCcNDxzJ5UcoXkREcyfqNgHB5nj33mc0Vn1uGeT
 H0Zw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779791725; x=1780396525; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8FBtHS86zxEDYAxC8eP7pfGIMxW6VLBRn2QKCrqcg70=;
 b=pvNOQvPYGJx7CylZz6N3v0gnzQm+DTI5ufzKmTvMrwj3wPtrYO788RXM/IIKCaVd4H
 qKsuDG3Znyh7kyBZAOgYa8zVjXjJA1p4AhplSC7BvKBJddfh2L7N3wm76Q4iJUjVmsaU
 q+6tTWNDwSEcBcSUftgVE5nzh+h/lUtXq+pYq/DZlW4QctRhGNNRe8Q5/hWuy2xJvQ/8
 F3FpsBxp82TigKWaBY0IG00GC+f8L24xEzui2pB7ubYrKRs0mHDyYqsMArGgDMq+Umk+
 6x+GwAePecirdjYmda8KU1i/6AjHNDmeEbYKf3PszVtiobBaBgcRstBFVrr/c8NVWEyW
 AQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779791725; x=1780396525;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8FBtHS86zxEDYAxC8eP7pfGIMxW6VLBRn2QKCrqcg70=;
 b=aZvTv0DbUSnW9w4C2TRAQ4Azftq6sK9QDP4gaa9jp51fUSGOkq4muyFRCaJJKvm3y6
 RTTvJ9K6yH8lw7jioCCTFxpZJx33sZITh4cbcPoHI7UdwJfpV4dX17MGcHqTbisB/i2u
 i2UfYVStq4fOwCSSLQ2LiaSX49AguoqN9knwr0y7czew25npwa6L4vI1M5/vsyY/7qYC
 xZDW5TopX2J7FXUX423bKH6G4/k4F/rJw9VU0XsjWJfcoyP9E6LTw4W2CHkn+qNN/Xum
 bXSA2AsPC9HWTVG2M/GSUu8ciXmVfFlo200LwaSnBPVg2mU37SVNf3FpI+5zYC4EjJfk
 4N8g==
X-Gm-Message-State: AOJu0Yyazs7QPpx9V9gRABfeywg5SiSuukpZaeqn4ngFgSzXxXEKUkSU
 sJmMgnUHO4v6lHhTh3rlVrn9aDYPAD2HSmh5l70oXTufM+NV3KmOgJqWaM2e79w0vEaBVXjjzuV
 E9yXQJfV+bYU3yOoTW3i1R4QJjrN2ltcjkqCKQ6wgjA==
X-Gm-Gg: Acq92OFXh6MgnlBg67+UC3KgSdm45qPhdWV/M41nuRKfo8riA3NGq1aULta6RCSbBH3
 iMglJ5nMKH/n4fAVmzWZvCmPGEd6cLvJksNadTE7k607NHP2iYROX2TnY3YyaUe+x/T0IklRDY3
 NfujbIr0Ggm9+Vf5PwXdZdJcGraxIkbE0r8r8ex/WMLkjguu0CERf9YgenuU6HYCNyjwWVld/j4
 6ZitU2ca+SFm74zXWPMrsWAGhXnH3gFGQ2UYtlu4dmsz9SOwxiep525nf7wZ/41bd8YO+khHkng
 RSrPU9vth9pWc9FDI9HVnlW1i4kbWYU3qWwuSZuISADlk1okyYY0Mc7TUSty68QowX0=
X-Received: by 2002:a05:690e:4813:b0:650:dbb:e79c with SMTP id
 956f58d0204a3-65ec98aa45bmr13146437d50.40.1779791724868; Tue, 26 May 2026
 03:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260522220306.235200-1-richard.henderson@linaro.org>
 <20260522220306.235200-25-richard.henderson@linaro.org>
In-Reply-To: <20260522220306.235200-25-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2026 11:35:12 +0100
X-Gm-Features: AVHnY4ImPTfzd7WilH9XSk5hs67h4n2rUMOGiIMO7YrSYpcWejmOZ5RCgPJiJFw
Message-ID: <CAFEAcA9xvc6BUY2LqAS1akZHpyouRchcmZAs6DVbQhkdoFsq8g@mail.gmail.com>
Subject: Re: [PATCH v7 24/64] target/arm: Introduce arm_init_fp_status
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

On Fri, 22 May 2026 at 23:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Initialize all of a float_status settings in one place.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.c | 45 +++++++++++++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 18 deletions(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index a13e6dae2a..4ea076fe4b 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -304,6 +304,22 @@ static void cp_reg_check_reset(gpointer key, gpointer value,  gpointer opaque)
>      assert(oldvalue == newvalue);
>  }
>
> +static void arm_init_fp_status(float_status *s, bool ah, bool fz, bool dn)
> +{
> +    memset(s, 0, sizeof(*s));
> +
> +    if (ah) {
> +        arm_set_ah_fp_behaviours(s);
> +    } else {
> +        arm_set_default_fp_behaviours(s);
> +    }
> +    set_flush_to_zero(fz, s);
> +    set_flush_inputs_to_zero(fz, s);
> +    set_default_nan_mode(dn, s);
> +
> +    /* We want 0 for all other settings. */
> +}
> +
>  static void arm_cpu_reset_hold(Object *obj, ResetType type)
>  {
>      CPUState *cs = CPU(obj);
> @@ -626,24 +642,17 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
>          env->sau.ctrl = 0;
>      }
>
> -    set_flush_to_zero(1, &env->vfp.fp_status[FPST_STD]);
> -    set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_STD]);
> -    set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD]);
> -    set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD_F16]);
> -    set_default_nan_mode(1, &env->vfp.fp_status[FPST_ZA]);
> -    set_default_nan_mode(1, &env->vfp.fp_status[FPST_ZA_F16]);
> -    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32]);
> -    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64]);
> -    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_ZA]);
> -    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD]);
> -    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32_F16]);
> -    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
> -    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_ZA_F16]);
> -    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD_F16]);
> -    arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH]);
> -    set_flush_to_zero(1, &env->vfp.fp_status[FPST_AH]);
> -    set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_AH]);
> -    arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH_F16]);
> +    arm_init_fp_status(&env->vfp.fp_status[FPST_A32], false, false, false);
> +    arm_init_fp_status(&env->vfp.fp_status[FPST_A32_F16], false, false, false);
> +    arm_init_fp_status(&env->vfp.fp_status[FPST_STD], false, true, true);
> +    arm_init_fp_status(&env->vfp.fp_status[FPST_STD_F16], false, false, true);
> +
> +    arm_init_fp_status(&env->vfp.fp_status[FPST_A64], false, false, false);
> +    arm_init_fp_status(&env->vfp.fp_status[FPST_A64_F16], false, false, false);
> +    arm_init_fp_status(&env->vfp.fp_status[FPST_ZA], false, false, true);
> +    arm_init_fp_status(&env->vfp.fp_status[FPST_ZA_F16], false, false, true);
> +    arm_init_fp_status(&env->vfp.fp_status[FPST_AH], true, true, false);
> +    arm_init_fp_status(&env->vfp.fp_status[FPST_AH_F16], true, false, false);

I think the use of these boolean arguments leaves this looking
less readable than what we had here before, unfortunately
(now you have to go look at the function prototype to figure
out what "false, false, true" means, whereas direct calls
to "set_default_nan_mode()" or "set_flush_to_zero()" are
immediately clear about what they're setting.)

I think it would be clearer to have an arm_init_fp_status()
which doesn't take any arguments and which we use on every
fp_status[] element, before then calling the functions that
override the necessary settings from that default.

thanks
-- PMM

