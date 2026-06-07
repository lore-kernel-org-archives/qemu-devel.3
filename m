Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF76BCD8C90
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 20:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWK4d-0003pJ-UK; Sun, 07 Jun 2026 16:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1wWK4c-0003ov-Bp
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 16:26:22 -0400
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1wWK4a-0004nM-Qe
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 16:26:22 -0400
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-91591f19c30so583397285a.1
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2026 13:26:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780863980; cv=none;
 d=google.com; s=arc-20240605;
 b=R7w1zxzoMNFTpHcAPm4AXAsVlcvQAWgsEFwRfpqvVj72/UqRU87C+3om8Qf1teZgZ8
 5P1bjoBymsaiDBHdRjvJa5DcsRh6rhUX7Q6ckFUnVRcyQAiKNuJSJiWTsRQDlnSd5sWY
 qew56izXdotOIkEPhqBNSyqQjgTNmzhE3nn6ZUxIQQb9NXwYOOLLurd0gPNVU1qBLvKE
 ntzmEs9jpaDjVasVb3ukB629olslVd5EtbyUgk9GyHAyy7+Fgqt8f7Tv4tUy/n7TiTI4
 1iZj8+pv65N3wkfRI0BdFz8SKHP4zsr3WONE/W1T/ESNBxMYX9+lsc+RJuF92hLVtE3j
 H+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GAvgp/P+SqUGNC/n/hLLMNwvt3d4s+S2E0ptIXDY+qI=;
 fh=FpVn51f7DcT5MzflneaVHJ9yKzeMunHRcwvV5jfuaAo=;
 b=Nv1VrBX/jUCUAeKBLlsWgEqYfIjm1jOH09E9PMU7JuFiF1N1RI3d5iwRhf1sxT+ScK
 O/PKOsJjbD7B6aGP63DmXvL//TQeu9hBEh2zgy8u6LlgTpNmiIn0aXcQaTDudbylKYx+
 6fJQ/phcQCppuordoE8yC2Zd1FN8HxH8tVR9XPVvxp5LybdGA7wV/RLPJ9p/wOr8/41U
 lafvDGA5wTiP9cUBAuVj9kp0qhYpVHHcoXCOeX9A2FdrZ2+k5+aFVhXXKQmWmOOzfvAP
 XMeOPxGU60OEukamJsue6AIpdMy4KMYV98DrmqHzuoqLdOi+gGq2x9oE+eBz+nbBJ44K
 cdDg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780863980; x=1781468780; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAvgp/P+SqUGNC/n/hLLMNwvt3d4s+S2E0ptIXDY+qI=;
 b=i8jnRp/YUTgmSORCOCwkVxHmMmz9DVpthleZyX+4ZB1QZ3YfoLYPTJ2Ln6pHPIp3gO
 Pyh6k4oqDV9IeRBxH+jpkPPyXvTs7JDZduplDlbyLxDetjCTjfNbGaEfgmM95nVKQMlA
 eCAgzo/rE5Sh6/hu6hdFY+OmYWjoEVulKWST/xcOA/I5Lj2ihsYJpabNMjY4CUrRX9BT
 ADIaUGeNIWmyce/5yoIq6zMykkNj1XZnUSvwzj2R4WrzLfRiFI6tNWoFr4yxe2qO+4Ps
 Fa282DJ6OOg6yw0Bytt7c6/niAWyERzGjXEd/GiW0ALRwNjC9uoSxj/dXheV2c1UGBJA
 eRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780863980; x=1781468780;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GAvgp/P+SqUGNC/n/hLLMNwvt3d4s+S2E0ptIXDY+qI=;
 b=etvzEEWKN7qSvGX0UQFIZTsZdtv/hnlOkBKuKfuSq5sc05jIvkpx7DQAXkwdi2gg+u
 ot3BeMr010SKby262gKcSI6zImGIRgPf/SNebw46elsF1L8f/V7YLjV05LYNGUy6X6lb
 WSUva42EvLl3zA/4wf4+ZDaf8hjUCd5xGVPtPKDUoXeRSWCUquJqGyzp+88yIeFTs1FR
 ol5IGlL8Zyo/JSr6Wt2YWoIDNaEA9hP/Fibk+oGOh2oNigMV0nGvJrFiSukO1dTt2vhU
 ol8MeMocqTfM+Il23BRt9yxmqL4n2KD6N1hKWFv38jYgGzsje16y1jLx1gheLvtx4f+T
 auSw==
X-Gm-Message-State: AOJu0YyMuJfVolz7KvOm4jfBv5z6r51VtYG46DrBea3Cut/uMJZ2otcs
 k0XV4PB+rafV8SqkEVnu56Y1AovXTXmB0AFB6FG+b3098RiTT3CZMUfgZtQYa7/V5UdC/QiPQJ4
 Rw+Oa3QlvkHhp+EH/535VWp5G95WvdIs=
X-Gm-Gg: Acq92OHVqGoMvTq/U3lpBVlmRMMqmkywKZFXQTMWrEmQ6H2y8sHEeIJcVST9wEqh+lV
 A9ttwugSuqkLgY8Ur6otzgp1W8Tz7wWwrPosbTUNuuFHW6cIu1WyHa0+rlXimZ0s9fGWDQQL2x4
 YaVpiOQLPnveSWKmEZ+PK7QdJHfBj4rJCKapZBeg316iGH7l3MBwMyZVdUAn7/7/bOqYQj8FZv1
 7AljvG+MXiOYVmS3/BQ1l+so7nBNRBHc5pLS5+ByPIhLuepyUvMurWI2m1LvEShPkCbj3FcKTeL
 yzgTsku8aPDHfR7DazHGzv7CWcA380U7uVwRz4U8zFhkCQ+0FXdoBqGGX3esK1+WWQj2uycKUXU
 R4eJrkam3dHUD6zcWKIEJflb9DiyKgTf5FrMS
X-Received: by 2002:a05:620a:839a:b0:912:8fd0:4a5d with SMTP id
 af79cd13be357-915a9df27d5mr2172963985a.55.1780863979629; Sun, 07 Jun 2026
 13:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260607140356.10702-1-deller@kernel.org>
 <20260607140356.10702-11-deller@kernel.org>
In-Reply-To: <20260607140356.10702-11-deller@kernel.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 7 Jun 2026 13:26:08 -0700
X-Gm-Features: AVVi8CeO3_-iA8VxOwJp6iaMDrNwwyHtX3jZWVwtYU95P9yLijxHNYH29QN8dWg
Message-ID: <CAMo8Bf+1aafuR1EgtFSLD86TfyYwQ6Lq0O7ozoYySZ4TKk4SrA@mail.gmail.com>
Subject: Re: [PATCH 10/10] target/xtensa: add cpu_set_fcr/fsr helpers to sync
 fp_status
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Helge Deller <deller@gmx.de>, 
 Matt Turner <mattst88@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-qk1-x72c.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sun, Jun 7, 2026 at 7:04=E2=80=AFAM Helge Deller <deller@kernel.org> wro=
te:
>
> From: Matt Turner <mattst88@gmail.com>
>
> Factor FCR=E2=86=92fp_status and FSR=E2=86=92fp_status synchronisation ou=
t of the
> wur_fpu{2k,}_fcr/wur_fpu_fsr helpers into cpu_set_fcr(), cpu_set_fsr(),
> and cpu_get_fsr(). Signal delivery code needs to restore the FP rounding
> mode and exception flags without duplicating the flag-mapping tables.
>
> cpu_set_fcr() applies the union mask 0xfffff07f (superset of the
> wur_fpu_fcr mask 0x0000007f and the wur_fpu2k_fcr mask 0xfffff07f) so
> that FCR bits valid only on fpu2k configs are preserved while MBZ bits
> 7-11 are always cleared.
>
> v2: Use FloatRoundMode as suggested by Richard.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  target/xtensa/cpu.h        |  4 ++++
>  target/xtensa/fpu_helper.c | 42 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
>
> diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> index 75cfeee6e3..442e98bd1b 100644
> --- a/target/xtensa/cpu.h
> +++ b/target/xtensa/cpu.h
> @@ -642,6 +642,10 @@ static inline void xtensa_select_static_vectors(CPUX=
tensaState *env,
>  }
>  void xtensa_runstall(CPUXtensaState *env, bool runstall);
>
> +uint32_t cpu_get_fsr(CPUXtensaState *env);
> +void cpu_set_fcr(CPUXtensaState *env, uint32_t v);
> +void cpu_set_fsr(CPUXtensaState *env, uint32_t v);
> +
>  #define XTENSA_OPTION_BIT(opt) (((uint64_t)1) << (opt))
>  #define XTENSA_OPTION_ALL (~(uint64_t)0)
>
> diff --git a/target/xtensa/fpu_helper.c b/target/xtensa/fpu_helper.c
> index 5358060c50..9f1256f677 100644
> --- a/target/xtensa/fpu_helper.c
> +++ b/target/xtensa/fpu_helper.c
> @@ -64,6 +64,48 @@ void xtensa_use_first_nan(CPUXtensaState *env, bool us=
e_first)
>                               &env->fp_status);
>  }
>
> +uint32_t cpu_get_fsr(CPUXtensaState *env)
> +{
> +    uint32_t flags =3D 0;
> +    int fef =3D get_float_exception_flags(&env->fp_status);
> +    unsigned i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(xtensa_fp_flag_map); ++i) {
> +        if (fef & xtensa_fp_flag_map[i].softfloat_fp_flag) {
> +            flags |=3D xtensa_fp_flag_map[i].xtensa_fp_flag;
> +        }
> +    }
> +    return flags << XTENSA_FSR_FLAGS_SHIFT;
> +}

rur_fpu_fsr() could be reimplemented using this function.

> +void cpu_set_fcr(CPUXtensaState *env, uint32_t v)
> +{
> +    static const FloatRoundMode rounding_mode[] =3D {
> +        float_round_nearest_even,
> +        float_round_to_zero,
> +        float_round_up,
> +        float_round_down,
> +    };
> +
> +    env->uregs[FCR] =3D v & 0xfffff07f;
> +    set_float_rounding_mode(rounding_mode[v & 3], &env->fp_status);
> +}

Both wur_fpu2k_fcr() and wur_fpu_fcr() could be reimplemented
using this function.

> +
> +void cpu_set_fsr(CPUXtensaState *env, uint32_t v)
> +{
> +    uint32_t flags =3D v >> XTENSA_FSR_FLAGS_SHIFT;
> +    int fef =3D 0;
> +    unsigned i;
> +
> +    env->uregs[FSR] =3D v & 0x00000f80;
> +    for (i =3D 0; i < ARRAY_SIZE(xtensa_fp_flag_map); ++i) {
> +        if (flags & xtensa_fp_flag_map[i].xtensa_fp_flag) {
> +            fef |=3D xtensa_fp_flag_map[i].softfloat_fp_flag;
> +        }
> +    }
> +    set_float_exception_flags(fef, &env->fp_status);
> +}

wur_fpu_fsr() could be reimplemented using this function.

>  void HELPER(wur_fpu2k_fcr)(CPUXtensaState *env, uint32_t v)
>  {
>      static const int rounding_mode[] =3D {
> --
> 2.54.0
>


--=20
Thanks.
-- Max

