Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED622C624D6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 13:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1lDL-00024j-Qh; Wed, 02 Sep 2026 09:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1x1lDK-00024a-Is
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 09:41:18 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1x1lDI-00013k-O9
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 09:41:18 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66f96418909so639198d50.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 06:41:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788356475; cv=none;
 d=google.com; s=arc-20260327;
 b=IzSyEW6fiyqxXjCc0NM1fTvVfZtEHYmW7Ers7pL2oGsD6Ry0Vz6j23HXNbTTDciGsB
 vmloMYScgzPp8xtghUKCBCnszXeh8Td+fxwnbjO+wHDH+uX6xxAnu2kK40ivqWIS1wxK
 Ipc8mhgekhULL30wSAiJ2eiOLvdSVwIYukDbm91TWQtoQEnknr+XRgTP2XIKxQe/d3oI
 jaOBarD/meEI0lHF8rRL5cLPNWnKItB+tbCVeHNBqwvU2dMZERNFPINuhwE6wfjXfPaW
 GPsoLwwremPgdbPSsKPxLtuPih5mw0DvIjpGVqUq1hUtNy4IzauIWI1xyt4UhCjaO5EA
 A+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VERsNWoynUHNETv9wjDRiXUAjSYkcWI6GvgebkmbrTg=;
 fh=qUOFTwWG+G+YmxTz+HxoQUPJX6AFWbaPYrnquSe1BBk=;
 b=kC34nnXlqmWrOc6HV250GjpT1Pz9kSF+8tY6zOxbwoSeCcG3fQ/TuMlkMZgJa8LQcX
 iBtPmTVXVru1j1aeOP1Ttu4OV1COTAF3XoLec0Tufz6M2q87oV+Sg8vmI1uRoFWa8itM
 Ef3uZBdWFMHGk9sMGKAK7z5xlZnWFhmjid6TPhVoyQVw59Uld0zIkNNoVStIVzTs82Bp
 A1TAB/b8oUgWw9AzpDJopSzqrAUk4kBlPwFl+xdRJZrzFwn/HYHxs6/kA2WOen4Chb5G
 GaxxL3kXzqqS75pNLYZxOFvznrwVpCe8s4f2zgQkLA+H9r0kjyA4VzW66uIpV9tc7Csl
 U9Wg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788356475; x=1788961275; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VERsNWoynUHNETv9wjDRiXUAjSYkcWI6GvgebkmbrTg=;
 b=LfIgqPUWhSAB/a307nGmFHm5vqyZukRJOh3LdF4GTuxZa+ZFwKX/k2qqNAA3sVGHn0
 VGs5CjzKWaj7eJwV2VpHJQ21aj5IHI+fELMNKAIb4p01fNGRm0mSOcDCzzKDccsvordI
 INlbUDjOfBfpoJdokpauaCTq+/HoWswYqxnZUpkqa6uR+JJHW/iX4BLv/4EV/w/FA5gk
 86MyZI+HzFAR/AtpGzwdd3WGlvkmBJR7NnvKzn73hNxHraXLESCZkpzSz/+bqq+8bPHF
 Xc5UcmMoEZO0XB17qfZlN6Ulp5BqGsCeV1KysvNd22Mmj67JrHJXDA+6s0eFkH7x2lGK
 6sCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788356475; x=1788961275;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VERsNWoynUHNETv9wjDRiXUAjSYkcWI6GvgebkmbrTg=;
 b=cwE0hZt+mvr2tZprITQPkVbgaevSgwwTRa53BN0OLR9Vk76yc8zN2wOLOyZyemrFLg
 +X8vALnb9DB4b4S+4RqpJJcF6tRPZpn9VNQ3ifO+xExcGK3TS0kodMkWNDurnJbjw2Ri
 vrrdjMiOZ5vCKIgEs4zv/E/dquT8rHUnE4bHSiv9m9okhEoBBQpI9TbUwOKj9UT9QvPF
 NPMHGYsaZAVSfFdQshiNRFEHJqFOLQdfjE7caebwGIoLFuL2telob6D2uMVHgN9gYJsn
 R2BfmKCiCN+bu6JY6bei0d3r/3zP59Al4msPxCUcKl2kfhNnqjhcKBke23wevVlgnslw
 ucfA==
X-Gm-Message-State: AFuF++mBB0Ni6gNcz/BUd+VUkBMLkZGa/h5Yq/v7zXYiIGg6RPrqNP5q
 5LN2NtHZ8a2EyDqA+rVY29TGp/7nOMFOUj5OgzvlkCvWKZQfiE7RiHc5Pt9Ge0Mi7EGPMv8Z+wg
 mfbuCLBlKEnJmadMvdRS16MLZPaMwxlfu8Lcz9/2+Zg==
X-Gm-Gg: AYBFou3BA4D7GDlTmsL2yGv0EAMJrUcW/79cPowvKzdauQBmrXxdC24fNOlN29lJD4h
 8X/DD4jUWl44dN5ifWKn/dFOCckxxAbY3S5gDJ2wuGQreDyyxhkTTaednJi/dPK4qkkZ9KNdH0X
 IeqOpxvDSzb8Onq/b0z+NWqd7sXAMrQc3DshB6GzVGCBGUT78FDnlRpP9AiuUkWwC5GV3F9blot
 dmxUA1tY3LKU0mmT6e5evGU9bG2YLYEN49YksImYAZf2d0Gvi8r/FBDMNLg6Ua+XWDDEX7K9T8X
 kSxM4erdQOwflMtT7vk1y1XcvyyLM3EDbJUeg146L7B0Yq3JmRMmXF42qsFc6a8xhzpYbcwjPxu
 6mwtzhCMP3MAeCcS75OP+So7CIjgUcaFRy2qamWy54g==
X-Received: by 2002:a05:690e:118d:b0:66e:62cb:bb6e with SMTP id
 956f58d0204a3-66f9b934580mr1363900d50.11.1788356475228; Wed, 02 Sep 2026
 06:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260828082235.128360-1-scherer.simon89@gmail.com>
In-Reply-To: <20260828082235.128360-1-scherer.simon89@gmail.com>
From: Simon Scherer <scherer.simon89@gmail.com>
Date: Wed, 2 Sep 2026 15:41:04 +0200
X-Gm-Features: AcwNN1XbGT2FrgP17sf94TZJjvnVzZYJRIPOXa9bPfbd30xQBqTYhVvedmtuzrk
Message-ID: <CAEQwQtLhM0mgwtroE5UbK8fE3VHGzaRDRGdg8qFYRJiEVy+pWQ@mail.gmail.com>
Subject: Re: [PATCH v2] target/i386: clear C1 for all x87 compare instructions
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=scherer.simon89@gmail.com; helo=mail-yx1-xb133.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Update on this patch: I tested the C1 behavior directly on real x86-64
hardware again for all of these instructions, and it turns out the
FCOMI/FCOMIP/FUCOMI/FUCOMIP part is wrong.

FCOM/FCOMP/FCOMPP/FUCOM/FUCOMP/FUCOMPP/FICOM/FICOMP do genuinely clear
C1 on real hardware, matching the SDM and the
helper_fcom_ST0_FT0/helper_fucom_ST0_FT0 fix in this patch.

FCOMI/FCOMIP/FUCOMI/FUCOMIP, however, leave C1 unchanged on real
silicon, despite the SDM listing "C1 Set to 0" under FPU Flags
Affected for these too. My best guess is that this line in the SDM was
carried over from the FCOM/FUCOM description.

I will send a v3 that drops the
helper_fcomi_ST0_FT0/helper_fucomi_ST0_FT0 changes.

Thanks,
Simon

On Fri, Aug 28, 2026 at 10:22=E2=80=AFAM Simon Scherer
<scherer.simon89@gmail.com> wrote:
>
> The SDM specifies that FCOM/FCOMP/FCOMPP/FUCOM/FUCOMP/FUCOMPP/FICOM/FICOM=
P/
> FCOMI/FCOMIP/FUCOMI/FUCOMIP unconditionally clear C1 in the FPU status wo=
rd,
> regardless of the comparison result.
>
> helper_fcom_ST0_FT0/helper_fucom_ST0_FT0 only cleared C3, C2, C0 (mask
> 0x4500) before OR-ing in the comparison result, leaving C1 (bit 9) at
> whatever value it already had. FICOM/FICOMP dispatch through the same
> helpers after converting their integer operand, so they inherited the
> same bug.
>
> helper_fcomi_ST0_FT0/helper_fucomi_ST0_FT0 never touched the FPU status
> word at all, so C1 was left untouched by those too.
>
> This patch clears C1 explicitly in all four helpers, adding the clear
> into the existing fpus mask for fcom/fucom since fcom_ccval never sets
> bit 9. For fcomi/fucomi add a new separate clear.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4378
> Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
> ---
> v2: merge the C1 clear into the existing fpus mask for
>     fcom_ST0_FT0/fucom_ST0_FT0 (Richard Henderson)
>
> Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
> ---
>  target/i386/tcg/fpu_helper.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
> index b812125efa..aa6527b0f5 100644
> --- a/target/i386/tcg/fpu_helper.c
> +++ b/target/i386/tcg/fpu_helper.c
> @@ -531,7 +531,8 @@ void helper_fcom_ST0_FT0(CPUX86State *env)
>      FloatRelation ret;
>
>      ret =3D floatx80_compare(ST0, FT0, &env->fp_status);
> -    env->fpus =3D (env->fpus & ~0x4500) | fcom_ccval[ret + 1];
> +    /* C1 is unconditionally cleared to 0 */
> +    env->fpus =3D (env->fpus & ~0x4700) | fcom_ccval[ret + 1];
>      merge_exception_flags(env, old_flags);
>  }
>
> @@ -541,7 +542,8 @@ void helper_fucom_ST0_FT0(CPUX86State *env)
>      FloatRelation ret;
>
>      ret =3D floatx80_compare_quiet(ST0, FT0, &env->fp_status);
> -    env->fpus =3D (env->fpus & ~0x4500) | fcom_ccval[ret + 1];
> +    /* C1 is unconditionally cleared to 0 */
> +    env->fpus =3D (env->fpus & ~0x4700) | fcom_ccval[ret + 1];
>      merge_exception_flags(env, old_flags);
>  }
>
> @@ -556,6 +558,8 @@ void helper_fcomi_ST0_FT0(CPUX86State *env)
>      /* OF, SF, and AF are unconditionally cleared to 0 */
>      CC_SRC =3D fcomi_ccval[ret + 1];
>      CC_OP =3D CC_OP_EFLAGS;
> +    /* C1 is unconditionally cleared to 0 */
> +    env->fpus &=3D ~0x0200;
>      merge_exception_flags(env, old_flags);
>  }
>
> @@ -568,6 +572,8 @@ void helper_fucomi_ST0_FT0(CPUX86State *env)
>      /* OF, SF, and AF are unconditionally cleared to 0 */
>      CC_SRC =3D fcomi_ccval[ret + 1];
>      CC_OP =3D CC_OP_EFLAGS;
> +    /* C1 is unconditionally cleared to 0 */
> +    env->fpus &=3D ~0x0200;
>      merge_exception_flags(env, old_flags);
>  }
>
> --
> 2.53.0
>

