Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA355FA3726
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 11:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbdA3-000364-RU; Fri, 02 Jan 2026 06:17:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vbd9t-00034a-Ir
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 06:17:31 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vbd9q-0006VE-Hi
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 06:17:29 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-430f5ecaa08so4884712f8f.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 03:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767352645; x=1767957445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S9NPlN2SV3AAX5O8IHQIGFCLTeWHuSC+hJP+FsC2uh0=;
 b=awPym7WmliBOvNz91DOBm6GvQsUYzrBQ+EirIOi4PUGOYVFafnQFN47hWJJ4fFwuvR
 GtjErK7WUgyd3B3nXMDIp6w1UprHDmHjp4y7buACTP9sEjBIIpLBMigs8eiXDT69lDMa
 8UgWU/97zNJuL/GR83xSHoLnE7moakMmVOMnSF7oMiIsDC2jQI2zYY8FLrlZ+xHQiWOY
 WXPQ5Dg1s0iaiDp3GyTkov2du8x+lcwB/eitMDI4UxB+dYUXnY9g38fA5WEhrLEfhE28
 cQn0zzyyBzsqa/Vwyslksc9K9a9yhcP30RVWlfRFZVRJYRRGJzOa7yTiSemQu4WME1Kc
 VNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767352645; x=1767957445;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S9NPlN2SV3AAX5O8IHQIGFCLTeWHuSC+hJP+FsC2uh0=;
 b=Gjr0Aokh3q4EKSFKUzqQnDLYViJSk/25JVAqazD8qjP/eyFmiJ8jlcfikJ69+1nfBt
 w+NlYgHoAird2Dq8qHieUP8if/yXRENYcwr/YKjfIORtsp1DsgHY2lPQ66KAxXiNzIMW
 wg4ucy0/GMgMpa83IPLDLvPKKRAAqGD0gXL1wRnrgWOF73jh8j4H7rsDfc/ZJo7CSj/V
 +wS3KDb6f5JSZ0cbu4kSr1xbKKqc3eUWzD5ii1Mc3ofYYdwZ9q0R8Aesa+KcorFgvu4p
 BBEYkErOdvtU9hxWv08DDBuCiVsioszFdKjj+VrIhX/XTKPL16dY3V1nXfecSV9K6VQr
 Chag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyHHqG/hkN2Hk9PhxnZpcMM4CPmr6tIziE6J6gTdNFj8zU6iAmPJr/uhbNZzOSm7gnWTG9xNfzAU7J@nongnu.org
X-Gm-Message-State: AOJu0YxSskn+TL+LaQyftWM0+vwMA9AYHI0LSjBgkX38oQIEWgdyrBfo
 qHXMEvgtha0SApYfILYJrtJDD3RIt63eThL/29zQ4dp+TToZqmHqf4PAmvT4udI4AsJxS2QHKKw
 r3qmt
X-Gm-Gg: AY/fxX7K8T8cdnNQgwEpYsLyOjkgcZZeMEkJ0ZS0IqzMEbYlhZO8KB0V0rwFoN7cWtb
 BPKhRY4SufQAdWeHG19ys8kKiSuJ0SO4CN0skYk5epsnaDRt084bChVdZoslxbPbIdSH96fLbe3
 vVSeAzm7mKNze/MHXoK6KSqbfPoIeJnGxFnIZrxMjDL0s+Q3LFzrt3yi3z1vxVXUNmjBIwBIqUM
 A4R1rP4KwI8hGXMqYU6vmhFaehmbpH31P346X4RnACYyh91my+SZXmcFA9yT7x142JkxjhLKp65
 2JwAELu3S3nGiyXgUkJ26rP2k4mW2VGOPe1OPTQrd4oGIpVR2A6rV4EUdN35A3FfCXr7WvQ3+go
 f+Jh+7wsuQIYPA9J4ZG3azplAla4LItZscRHzvawW8yJaZUkylCYPdkVq+1Z9CTJv6sMTWgJpcb
 lucAVaH+fQnkGlluwb7mk3Bg==
X-Google-Smtp-Source: AGHT+IHNmoiGBEhAT5kQ/0UUMTinucUCHMs8OhKefOsFjOdg/kIu8/2JnwD8NFeXurSB5HPfrN/QSA==
X-Received: by 2002:a05:6000:26c3:b0:430:f40f:61b9 with SMTP id
 ffacd0b85a97d-4324e4c68e1mr45366727f8f.4.1767352644511; 
 Fri, 02 Jan 2026 03:17:24 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1b1b1sm83486027f8f.3.2026.01.02.03.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 03:17:23 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 284255F7FE;
 Fri, 02 Jan 2026 11:17:23 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [PATCH 2/4] target/arm: Correctly honour HCR.TID3 for v7A cores
In-Reply-To: <20251231170858.254594-3-peter.maydell@linaro.org> (Peter
 Maydell's message of "Wed, 31 Dec 2025 17:08:56 +0000")
References: <20251231170858.254594-1-peter.maydell@linaro.org>
 <20251231170858.254594-3-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.14; emacs 30.1
Date: Fri, 02 Jan 2026 11:17:23 +0000
Message-ID: <87zf6ww9fg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> The HCR.TID3 bit defines that we should trap to the hypervisor for
> reads to a collection of ID registers. Different architecture versions
> have defined this differently:
>
>  * v7A has a set of ID regs that definitely must trap:
>     - ID_PFR{0,1}, ID_DFR0, ID_AFR0, ID_MMFR{0,1,2,3},
>       ID_ISAR{0,1,2,3,4,5}, MVFR{0,1}
>    and somewhat vaguely says that "there is no requirement"
>    to trap for registers that are reserved in the ID reg space
>    (i.e. which RAZ and might be used for new ID regs in future)
>  * v8A adds to this list:
>     - ID_PFR2 and MVFR2 must trap
>     - ID_MMFR4, ID_MMFR5, ID_ISAR6, ID_DFR1 and reserved registers
>       in the ID reg space must trap if FEAT_FGT is implemented,
>       and it is IMPDEF if they trap if FEAT_FGT is not implemented
>
> In QEMU we seem to have attempted to implement this distinction
> (taking the "we do trap" IMPDEF choice if no FEAT_FGT), with
> access_aa64_tid3() always trapping on TID3 and access_aa32_tid3()
> trapping only if ARM_FEATURE_V8 is set.  However, we didn't apply
> these to the right set of registers: we use access_aa32_tid3() on all
> the 32-bit ID registers *except* ID_PFR2, ID_DFR1, ID_MMFR5 and the
> RES0 space, which means that for a v7 CPU we don't trap on a lot of
> registers that we should trap on, and we do trap on various things
> that the v7A Arm ARM says there is "no requirement" to trap on.
>
> Straighten this out by naming the access functions more clearly for
> their purpose, and documenting this: access_v7_tid3() is only for the
> fixed set of ID registers that v7A traps on HCR.TID3, and
> access_tid3() is for any others, including the reserved encoding
> spaces and any new registers we add in future.

I'm confused by the naming - especially as searching the Arm doc site
with the Armv7-A filter didn't show up an HCR register (although it does
show up in the PDF).

I guess what you are saying is these registers trap from v7a onwards?
v8/v9 don't change the trapping on this subset of registers.

>
> AArch32 MVFR2 access is handled differently, in check_hcr_el2_trap;
> there we already do not trap on TID3 on v7A cores (where MVFR2
> doesn't exist), because we in the code-generation function we UNDEF
> if ARM_FEATURE_V8 is not set, without generating code to call
> check_hcr_el2_trap.
>
> This bug was causing a problem for Xen which (after a recent change
> to Xen) expects to be able to trap ID_PFR0 on a Cortex-A15.
>
> The result of these changes is that our v8A behaviour remains
> the same, and on v7A we now trap the registers the Arm ARM definitely
> requires us to trap, and don't trap the reserved space that "there is
> no requirement" to trap.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 6a4ef4e5d1084c ("target/arm: Honor HCR_EL2.TID3 trapping requireme=
nts")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 146 ++++++++++++++++++++++++--------------------
>  1 file changed, 81 insertions(+), 65 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index ec82ea6203..c4f73eb3f3 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5835,9 +5835,18 @@ static const ARMCPRegInfo ccsidr2_reginfo[] =3D {
>        .readfn =3D ccsidr2_read, .type =3D ARM_CP_NO_RAW },
>  };
>=20=20
> -static CPAccessResult access_aa64_tid3(CPUARMState *env, const ARMCPRegI=
nfo *ri,
> -                                       bool isread)
> +static CPAccessResult access_v7_tid3(CPUARMState *env, const ARMCPRegInf=
o *ri,
> +                                     bool isread)
>  {
> +    /*
> +     * Trap on TID3 always. This should be used only for the fixed set of
> +     * registers which are defined to trap on HCR.TID3 in v7A, which is:
> +     *   ID_PFR{0,1}, ID_DFR0, ID_AFR0, ID_MMFR{0,1,2,3}, ID_ISAR{0,1,2,=
3,4,5}
> +     * (MVFR0 and MVFR1 also trap in v7A, but this is not handled via
> +     * this accessfn but in check_hcr_el2_trap.)
> +     * Any other registers in the TID3 trap space should use access_tid3=
(),
> +     * so that they trap on v8 and above, but not on v7.
> +     */
>      if ((arm_current_el(env) < 2) && (arm_hcr_el2_eff(env) & HCR_TID3)) {
>          return CP_ACCESS_TRAP_EL2;
>      }
> @@ -5845,11 +5854,18 @@ static CPAccessResult access_aa64_tid3(CPUARMStat=
e *env, const ARMCPRegInfo *ri,
>      return CP_ACCESS_OK;
>  }
>=20=20
> -static CPAccessResult access_aa32_tid3(CPUARMState *env, const ARMCPRegI=
nfo *ri,
> -                                       bool isread)
> +static CPAccessResult access_tid3(CPUARMState *env, const ARMCPRegInfo *=
ri,
> +                                  bool isread)
>  {
> +    /*
> +     * Trap on TID3, if we implement at least v8. For v8 and above
> +     * the ID register space is at least IMPDEF permitted to trap,
> +     * and must trap if FEAT_FGT is implemented. We choose to trap
> +     * always. Use this function for any new registers that should
> +     * trap on TID3.
> +     */
>      if (arm_feature(env, ARM_FEATURE_V8)) {
> -        return access_aa64_tid3(env, ri, isread);
> +        return access_v7_tid3(env, ri, isread);

This seems even more incongruous - we test for v8 but use the v7 helper.=20

<snip>

I think I understand whats happening but it is confusing to follow.
Naming things is hard.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

