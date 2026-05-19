Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1905CD5BA4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 13:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPKhH-0002yw-5d; Tue, 19 May 2026 09:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPKhB-0002yL-Ml
 for qemu-devel@nongnu.org; Tue, 19 May 2026 09:41:18 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPKhA-00029L-7x
 for qemu-devel@nongnu.org; Tue, 19 May 2026 09:41:17 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-65d071aac6eso2944711d50.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 06:41:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779198075; cv=none;
 d=google.com; s=arc-20240605;
 b=TYnrxNnoLSelJ96bo+3VbXqDPkDPklB7FvSG2+Hqq4DUkFmXrrNWxN55RYhnscWMn9
 un33bKvJ/O88I54LD2xwARUfgEebOCEiTHKj/29wNn0Wyt2BpQJNrAEXEM8LvPP9vgEU
 FhnZTTINamxpjhMRDKPrkRMh1xAph1ypA0oaextW/ulayCQd0uewJhDIqLRg66QYFKi5
 0CDAKsjSSwFv7GWjLqBU7qOY/Iby4fTSfqXLzPgf9KjqXCWUHtYP9c6cHXTtlcCKof0r
 dGAwLlTr2TAUdTfUwghrW2y65eibLTGc/ptB0FizgzzL3eoV270kxik5G7Fkkdu6VMOY
 KThg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kNP6oY9itOPkE4pxOHCVKOdRO8IRPVCfs/wkn9O+vO8=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Pk1PDf7MBT0dAwJAOgwds9kr2+5pctI+0O2Tx3dKgge6D/jV+kzKO2zppV0MXMDmeq
 ElV0+UK1NFXc2yQJmkYkmSE18Oep+uNCpajJWeIZmLp3My5iO3eKPMJtY5KpyUzjBZWs
 zDbhfThy59zQAzOJHo8AD9ht7HWhs+wLq2K/CyfC/QPg9OYsFCOBrNin3NKbk3UlCWsM
 wRzPkLGTP1Ntx2CABeMOGpd1EVledw07w+rPrBP6Jm3ml4V1v19IkZVwb7ymjL15fZG/
 1palpPvKAYEqLjbWoMHYxn7H6yxPthuGLUOTe5+q7eaQuxMvYVOrt5L/3pnfSvTVqBZZ
 NXGg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779198075; x=1779802875; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kNP6oY9itOPkE4pxOHCVKOdRO8IRPVCfs/wkn9O+vO8=;
 b=dtRNg4lxS4Sj9eyXaHm5cMmWOXTWF7vvrzCnBTNWDn8jkvuctg9TtY8em8e4XIfpIV
 uPf5XnsVKqb7vDCUcpcRF4eZbBh3wFnZcy8/WpXFkFujNUCY8oMVbJYBguvN8C49o9nA
 938wiRv7SMS9G5ftYszlQdPERbYxYtfsKgu0R5LdGbdqKGl1N+EC2ASsUX5bx3PdT3tH
 rRtw7lqzTQEcme6aCs08Pw/UQJiXgFBx/GzLPLgTaLThYjXLFsM03mnbv4ZXYUM20Xla
 3JpjWSHAkWbCp49U9tohbsGxC336UOgL8FZB9gS6R2xpavncZosB/4MihBmIApHwd+OT
 L+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779198075; x=1779802875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kNP6oY9itOPkE4pxOHCVKOdRO8IRPVCfs/wkn9O+vO8=;
 b=MdiPZyR4o1rLi1fWphAlX5fBR4vu+9vMuXPYMt8rC0y1SEpMJGwvSzJj5whVJLniVl
 UmMP6WtgfVe0uc+6QWaV0IV8GiS4/PyIngvziMtSW/96NeE4yogO5p3vXomrsrffKzBR
 LJi8L6ZyKUcnJZfITa4cM4XGQeTh0HKeJkKCt8IVVUUgyMPT9NI6dSrY50UiVo8/iPUJ
 gM2Zr1+QLmwHPO7kLCvOsB/ns7G787do3Ep91SVKM5AGxKzP98rExwtdOeJhTjGw1gkC
 6+2GPnTsY9qKDqUCfs7OMZOdwUVeW1QTbMgcqT8xRtPb9/mP+oASRjkQsjKeEzzdqXaJ
 gXKg==
X-Gm-Message-State: AOJu0Yxcrcnr0w/L7K5hfVEoQ1ZPovC7Sk+yMzkHgSh/J/uU5SMtji1F
 uhTQjCoOGjgtaQSvYl1zACO66VKqoxhCKPJY6WEx2ChnNJcuzJIL6Tt7d6WMvzLpe5UASwy22jP
 IHcOGetv8K0MfLie2GXixn9xZCJskm2a69hU6MgLbag==
X-Gm-Gg: Acq92OEtO89NqJoyrwGM6tb5EeHy36KOwCm4hHlMAobAz0jjN6F0TWjjFoRV7BgyAMw
 4cIVSTUR4am/PCz+jL9anPDeFbiRTP2h1WtG+I8f+MujGxXzlQNpph5GndueBISAX55Vpujtsl5
 Nql5GKqQCSKDsM5PHNshC69dKkMXj8ERj87BiDAPgIWG83JGXdrn+nPSWTo+wT1suTNPtll179B
 xMg5Re/HZmO+yQr/+AzKGD13Szn06qf44WypgU/q4eEHnxxj2cUg2wjILs+3MveuW71vRwv9CLW
 /a/r+0JP5xNo2S9kC/NRCSRNJmx4fs9KtIlO6rS7dXmxFnG+2RxkY7dWc2gtg2oUVaI=
X-Received: by 2002:a05:690e:169f:b0:65e:3c29:cb42 with SMTP id
 956f58d0204a3-65e3c29cc8emr12761402d50.38.1779198074745; Tue, 19 May 2026
 06:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260517003002.321430-1-richard.henderson@linaro.org>
 <20260517003002.321430-46-richard.henderson@linaro.org>
In-Reply-To: <20260517003002.321430-46-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 May 2026 14:41:03 +0100
X-Gm-Features: AVHnY4JgNbL-2cGA5hrOBFmqcQXwD3PiNqYiuVaWR4kNtgcgUelI7uIImC3qdN4
Message-ID: <CAFEAcA_4wU+wndbAqjnObpvnLit11OVDZvTZ1RWy_q0cNfH7uA@mail.gmail.com>
Subject: Re: [PATCH v5 45/63] target/arm: Implement FMLALB, FMLALT for AdvSIMD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Sun, 17 May 2026 at 01:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h        |   5 ++
>  target/arm/tcg/helper-fp8-defs.h |   3 +
>  target/arm/tcg/fp8_helper.c      | 113 +++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-a64.c   |  16 +++++
>  target/arm/tcg/a64.decode        |   8 +++
>  5 files changed, 145 insertions(+)



> +static void fp8_mul_finish(CPUARMState *env, FP8MulContext *c)
> +{
> +    /*
> +     * FP8 multiplies don't update FPSR.{IDC,IOC,IXC,UFC}.
> +     * Since this is multiply-add, DZC does not apply and only OFC remai=
ns.
> +     */
> +    fp8_finish_fpst(&env->vfp.fp_status[FPST_A64], &c->stat,
> +                    float_flag_overflow);

Looking at the A1.5.5 text a bit more carefully I don't think
we should propagate OFC either for FP8 mul:

"When the rounded result with unbounded exponent has an absolute value that
 is greater than the maximum normalized number for the output precision:
 =E2=80=94 Generate one of the following outputs with the sign of the resul=
t:
 =E2=80=94 When FPMR.OSM is 1, the maximum normalized number.
 =E2=80=94 When FPMR.OSM is 0, an Infinity.
 =E2=80=94 Do not update FPSR.OFC. "

If that's the only case where that an FP8 multiply detects Overflow,
then we should just squash it also here. If there is some case
apart from the "rounded result is too big" that is also Overflow,
then things get awkward because we need to squash the "too big"
Overflow but not the "whatever the other case is" Overflow.
Working through the pseudocode it seems like there is only one
reason to set Overflow, so we need to squash all fp status flags.

Also, I realized that this squashing mechanic means we can't do
the handling of invalid input formats the way we do at the moment.
The float_raise() operations done by fp8_invalid_input() will
get squashed for multiplies. I think the fp8_invalid_output() part
is still OK because we only use it in the FP8 convert operations.

We could perhaps have fp8_mul_start() explicitly check for fmt1
or fmt2 being fp8_invalid_input -- it has access to the real
fp_status so can raise Invalid and InvalidSNaN there.

thanks
-- PMM

