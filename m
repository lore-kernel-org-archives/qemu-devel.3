Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709F6CA5FA1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 17:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBFbT-0003YG-Nr; Mon, 28 Sep 2026 13:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBFbS-0003Xv-1P
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 13:57:26 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBFbQ-0002hJ-0M
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 13:57:25 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66fb93aee5eso3580716d50.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 10:57:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790618242; cv=none;
 d=google.com; s=arc-20260327;
 b=hmHSNEqlChL2Kn/cxBvC5oGKXgcB8lzwMLcAjSNOzfqtf0gYggFmCov3W2FJhg3xPc
 WA5zS/y0Q+RSFWQMtzuQv8gbUzkfMRVU3PcC5+nEcDhXLiqrgaVJx31AY4xXuB9NovnJ
 RkajDcRVHWou+PDnaCH7bTXkis+VH/Alll8Lm8Z+VsuWslGKieGn+dQKyXPlGozwIkdS
 SbCu5nVSb5IidjRiHHKXVbKgVOVfrwowXCGYNWew2o8YQUMB1wxQTRr1dbuFY8Y0/0Tb
 8uatOCK1QafXv2Yu7WsdKYaB1GduBUIkmlcca9Inpc8F7dAnnDxUf0QMce/+QSIn9Aay
 qeWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eru0LST9w3Lbh59JKh8rLBU/sUB7p6jjByIWRWRE7Ww=;
 fh=ub/zH6y+WPJijJytJEhlCd5PKbYleOIQ1GJXfRlIPlM=;
 b=MkcieqcZ5hzuqDpyT8ogAi5IMAntagdXAiOySp69MzRB1PnhxhnA4X/oW17S68OFDN
 37JFgqiC5wRbV9RlH7Nj9DhATdUwF/csyBdN4rZ9bXE3BNsO659GGXzwyc1qhVacHo2+
 nrG6OqugTkPrPgo3D7MOxUnpMwk1W4fT678p3S5XDbkpC+cIDfzxzotV1SUDnnvpYcCI
 eTfZQQoO5n8z/a/LTOX5VE25j7KAWWePtYBcxGpYiovX5SBZ8rx3LdFDMrsxU1YLzfVi
 wUNIhexjScpLtFOg+oqNyfDkN2c3vrlaXT2V2WieSuJanxs3mkxYljGXbRT/89Z9HrVv
 5hNw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790618242; x=1791223042; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eru0LST9w3Lbh59JKh8rLBU/sUB7p6jjByIWRWRE7Ww=;
 b=rNBW+woPt6lHeMZMqakptyWuxQpBkHK6FNN1y/r3yo5ue0z8UHw/ByIz2hBwwPhxCa
 3pQeMxpEpdmZyaZgewJkAmyRZ2DLYDUI68FstQ+56hYnPMXtcf0ALXvfjMjRXNzGuBlS
 G1iQBQ4/Qo3XwoOXp/qNXOUA2xgLMwc9yxB6VGqLg8AoVtyplPTt5/a53LlnBiCv7BxT
 cTXBhMHGnvpfsdDOP/1pc9tjXJmAhM5E21aTSa1UDEndL+IKUQOY9msi8CRqw+3F0Lc8
 MUv4y234rso13qv5SZmQGOT/z7N4C09cZK3HYAAuvjP5iTjkmvhw+6jm0QamfrnzqoOM
 BA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790618242; x=1791223042;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eru0LST9w3Lbh59JKh8rLBU/sUB7p6jjByIWRWRE7Ww=;
 b=iuT+2jZ4UyFz82cVBmnVXaKJa5hDw+a7DWD0F6zmeOPYZs0cV6Rn0TaWY6z9piW5Ie
 WlkIBxIVtzWQi7vV5QXkQezQduYTEQUzhqpetEARjjNh1RJWz1tZCdBMGzSkI6XdGTnl
 vC9k8k8EWqGV5icAjX3v1uAqQSYn2J4R39G1ehBrRixxv6dkthHeeeY3tPdFPwFAUxaf
 PIPPuJCgj+QkryWVkLaLQk2kEuYKZDI9CzZDmhaHam1YLJkiC2zu6HMITo8ZMsVctOZ6
 GWSXbL/Th30i97wMRvhMKWTlYBjpIS8j64KkYcAMUXj12l4McyKJuz8QEN57SVfBR87W
 lK5Q==
X-Gm-Message-State: AFq9FYLE1o5JMYdJWyQk9OKkDy66Z2mpuwCWtk7MsRd03DRjepbA/32T
 lgNhmApdw3HMTUndA931rijJEyBCAXIV9yQh7vV74Y/k4M0YkxnGx8xO0fCdemrWgOrUFSBqcWd
 kQNBTQxIY8c8Txl4ptFVfEoFZdVj3etKmcMwZSC+WTw==
X-Gm-Gg: AYBFou0b+nMt3FrxCquMgqCf6+G7cajAKhEPKC3rZ3iWpmXrHzi7l50Ao/MXiZ2gdC2
 XnHeoLJR5RyMi4d7K3UhVC9F8xycnDB+L5+e8hroMNAMiUKAXV31dEzQ1l142t0HS7SP5ZoOhdx
 YIYPXis4A0OI7y9pyU/vu6Tl25zl8UnILDkgEtemPSHGchjXR18w1vbwZAimuFDzks1P7o3brFx
 iVVFtMGJlOj+2S1O/T4iZx4xt22LuiiqDFbqlDV7GYiq331xOkFv8UpVZPIyoEsSUt6oGk3ErtX
 Luu6jBdGyPMxJ/2+tAWRaZkcudYEHbqE24ATrGnr0LfxCw4xQjiB8MVFQ3Dwrubk5MnPoesehDZ
 i9OaH57NKO9SbfnWPK28vDBtusor9zGUoJdRvnvU=
X-Received: by 2002:a05:690e:34b:b0:673:1df3:84d8 with SMTP id
 956f58d0204a3-6731df4aca3mr3303803d50.103.1790618242206; Mon, 28 Sep 2026
 10:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260921142910.1462880-1-alex.bennee@linaro.org>
In-Reply-To: <20260921142910.1462880-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 18:57:09 +0100
X-Gm-Features: AclHuK_Nvl__Z2zn_qWyjTMlzHzSV-sBV5P3IHoAompVNR4gwPVZt1ThHbN5BVY
Message-ID: <CAFEAcA8E8hpWbr677yyaFkOioyDaLv8CaSiPxiDoOTP+YSbbNg@mail.gmail.com>
Subject: Re: [RFC PATCH] target/arm: fix user-mode emulation of
 ID_AA64MMFR0_EL1
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x11.google.com
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

On Mon, 21 Sept 2026 at 15:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
> Since kernel commit b130a8f70cbbf9 (KVM: arm64: Check advertised
> Stage-2 page size capability) the relevant Stage 2 have been pegged at
> 1 f(4KB granule not supported at stage 2) by the kernel. As a result
> the behaviour of the test differs when run on real HW compared to
> under emulation:
>
>   id_aa64mmfr0_el1    : 0x00000111ff000000
>     !!extra bits!!    : 0x0000011100000000
>
> Update the test with a new helper to explicitly test for fixed bits
> and update v8_user_idregs to match real systems.

Huh, 2020; that's not a recent change at all...

I don't understand what the above output is intended to tell me,
though. What are "extra bits"? In the actual implementation code
in helper.c all we define is exported bits and fixed bits. I think
we could stand to be a bit more verbose in the test program output
in saying what the test thinks the problem is.

> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4566
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  target/arm/helper.c         |  7 +++++--
>  tests/tcg/aarch64/sysregs.c | 31 ++++++++++++++++++++++++++++---
>  2 files changed, 33 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index c3f607e6d6b..7e65f072a4a 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6902,8 +6902,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                                 R_ID_AA64FPFR0_F8CVT_MASK },
>              { .name =3D "ID_AA64MMFR0_EL1",
>                .exported_bits =3D R_ID_AA64MMFR0_ECV_MASK,
> -              .fixed_bits =3D (0xfu << R_ID_AA64MMFR0_TGRAN64_SHIFT) |
> -                            (0xfu << R_ID_AA64MMFR0_TGRAN4_SHIFT) },
> +              .fixed_bits =3D (0xfULL << R_ID_AA64MMFR0_TGRAN64_SHIFT) |
> +                            (0xfULL << R_ID_AA64MMFR0_TGRAN4_SHIFT) |
> +                            (0x1ULL << R_ID_AA64MMFR0_TGRAN4_2_SHIFT) |
> +                            (0x1ULL << R_ID_AA64MMFR0_TGRAN64_2_SHIFT) |
> +                            (0x1ULL << R_ID_AA64MMFR0_TGRAN16_2_SHIFT) }=
,

This change looks OK: the rule for the ID registers at EL0
(per https://docs.kernel.org/arch/arm64/cpu-feature-registers.html )
is that fields not visible to userspace should have the value
indicating "feature is missing". That is:
 * for TGran16: 0
 * for TGran64 and TGran4: 0b1111
 * for TGran16_2, TGran64_2, TGran4_2: 0b0001

and that's what we now define for the fixed_bits value. I think
we could reasonably add a brief comment, though:

 /*
  * Linux does not expose the  TGRAN* fields to userspace and so they
  * must read as the "this is not implemented" value for those fields
  * (which is 0, 0b0001 or 0b1111 depending on the field)
  */

thanks
-- PMM

