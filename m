Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C6CCD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waZ7I-0002gk-PK; Fri, 19 Jun 2026 09:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZ7H-0002gN-ON
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:18:39 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZ7F-00080Z-5P
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:18:39 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-662bf1dab83so2557360d50.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:18:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781875116; cv=none;
 d=google.com; s=arc-20240605;
 b=AFngmXDRNdVTAyCdE7VR/i5DuC9mtYLHflIPMf4pE9fK5UtrfToubueFcdQCo/wEl8
 UgosLR7i24alUScInm4qJ6C8sHa4LrYc9YTqLxRKQ6sgEMRs2vgEvJOfw1bxrr5cnvTE
 7Zzx0JvM/3sF7DRXbM5FkLfpoYaiJSplxvJCTmjH35aNlfcG7GJD5rtlqzvMxlXVFubi
 MEiixt+ZNH/uPRI74aTfAZWS9FKV4fLFBTQLalzJdWVeGtIjprrZgeYbReWvHBw5pF64
 G2ZSngNB/QvqnBrEA+m2KtBHNBfqHmSURGp0OJBKy0TGM0Ho6XU0dWkcWCMIWE3OT+43
 aeEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EmEY+cjbJNIBkK9rxxbzV7Ux6b6JpIZ3d2sXR3Gm4OQ=;
 fh=xI+f3cV0+eCVjWmeQZ75vTRDgvX17Dd5Ehccp5/eVJY=;
 b=JT0PGDWeSUAArmcuEI1RRbnZLa/m6WkG3WsxTVzjBPyGmgGz2OejFDhhQMBUW0IOZZ
 Anz7TftX4YLsMBYnvbmwI/du5yrrO6ptJxvH0guXMQeNLiAzIqMuaR6sY45iod6WtA5N
 ZxM+nzeIo1fMK1wqpUkP0KQM+ChvyJdnyi42Hh8wkS+I8DXe63n5rhdTiGbVRL54cCrk
 n9Q6Y5Eg7dyCSsY9zVhKJB8PN5RkeY2eLyv9LfQMEHXa6nYh+cq/5RK75G25lWd7jld5
 OfhkaHXMqSlPY7vsep5GabOtOYbDrn895wiABqpVzc6CI72mLUsLEYHYttvZggiB/yQt
 IySA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781875116; x=1782479916; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EmEY+cjbJNIBkK9rxxbzV7Ux6b6JpIZ3d2sXR3Gm4OQ=;
 b=EtorxWMBeWwR9o0NiesfehG1x+7IogrxwNr7hOVJUinVzWnoj5r4vVVbVqYhjarCQa
 o6GQ9s9+ExLVn+7+WZ02gA7z3JeLF3nat8sXSI+eW+WwS5LYU9CuVt5i6ARvOQzYgIh4
 6deCJao6IqhL9DfXprxmQnSqifrcPotaDa1kBfmGpOPmK1I58nrRdjJJ8SHBMeSzR/e4
 qAwOlzAI4DvjIsBGZ2rxiyewnHVfowekmS1Hta1gqv0wg18V4ViNd7KNg6E3CTRIQK63
 PMTLDRebEh0eV/EiLo8woHIWTcG20TEzxoaWm3rV1x/4W5c+iSxRcZaF67Z2R0yTAYx6
 gKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781875116; x=1782479916;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EmEY+cjbJNIBkK9rxxbzV7Ux6b6JpIZ3d2sXR3Gm4OQ=;
 b=ZZ9ehbBqUA3aDzwelfybm5BV5cMroh+CKcghppm766GqLdOK/YcFUfTyV6KIb7ZIhY
 nZNiVOk76Y1YD2z02FA9FxpKsr2GcK30cWwMteTQOKwKC3sQ83KZ/w73BMuRla9XVNUI
 b+YTm289XVy11LLq9dfVF2i60BejHL3G/L8WQwvCD0Yytzqr3U0R29Knl06pUy1WWeD9
 zRYEqc8qYG4RdEn5kM7qRITW2GFWIdDY9eekfLpNc6QVSxQafwMiS/3zQpK9LWdbsfQp
 cWPpqUazMgmmdJoYFroiUvenZLCWIi0I6lHEK4rZJVMrExBnrOjiaSvJr5sigNJ/hSvd
 DNoA==
X-Gm-Message-State: AOJu0YyU/Z/fI8TbRvEghXDr0HFEPK7l/g6r0ow3+RU8y4V7hTDk4mRR
 Ogv77U32120yCke0Enqs5aUUhK90h7UbY0sD9/2afiuUBwxc75MfIY0W13YAIo72BTl2Atyuogb
 vB8q3+4EzHBn1lvCfY0RdIHRI3sa3rv+UPCGpZsNCqQ==
X-Gm-Gg: AfdE7ckZmZ7rXDuGpaxWSDL123s9IFS477/LCRg16SHqb/OkZayxJVYoqdlN6NUUxRp
 Q8/MkiffZUa12N6xc+rauqKRYatWecRnws9efb8tQMsmaIFVmBB+fQCH+AZpHy20B9eFF+22tBY
 x+3eHzX9e8/OfkSAJ2JrW0rxIoZPXj1jmx37cbjIQ5tHe9BNovvMKKHF3bzlfTKcVg81U+Y33/j
 HrHJXK312yH5L8F4zj4CoubNtG9az1wnhrEDgyJ9RNt5xroaMF60wocMtvP5Mwx2HiS1QYNloQz
 msgZsNCPEofiZgxDRnUNqHnKbFW92lzFABbP/JqvTxU4C4ZX6Q0mMO5I
X-Received: by 2002:a05:690e:11ce:b0:660:d512:46dc with SMTP id
 956f58d0204a3-662fcbb0086mr4092145d50.57.1781875115603; Fri, 19 Jun 2026
 06:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260619130537.820184-1-alex.bennee@linaro.org>
 <20260619130537.820184-5-alex.bennee@linaro.org>
In-Reply-To: <20260619130537.820184-5-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2026 14:18:23 +0100
X-Gm-Features: AVVi8Cf-7SRrv9WiiLBvbBYNyVc4TY8I_uOR2bV6pZJYEsQtlTzN9wdxrxv20oA
Message-ID: <CAFEAcA8QWor1P210Td1wHeot2npzga5_XfonNMpPSZeviYCTOQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] target/arm: ensure we create the wxft_timer for
 all modes
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Troy Lee <leetroy@gmail.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Kane Chen <kane_chen@aspeedtech.com>, Tyrone Ting <kfting@nuvoton.com>,
 kvm@vger.kernel.org, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Fri, 19 Jun 2026 at 14:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> We don't want to just use it for timeouts as we will calculate which
> will comes first. Remove the wxft feature test in favour of the
> broader architecture checks.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v8
>   - new commit
> ---
>  target/arm/cpu.h | 2 +-
>  target/arm/cpu.c | 9 ++++++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 31a5567c951..8aa7437a397 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -966,7 +966,7 @@ struct ArchCPU {
>       * pmu_op_finish() - it does not need other handling during migratio=
n
>       */
>      QEMUTimer *pmu_timer;
> -    /* Timer used for WFxT timeouts */
> +    /* Timer used for WFxT timeouts OR event stream events */
>      QEMUTimer *wfxt_timer;
>
>      /* GPIO outputs for generic timer */
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 597e0626e7f..61945b6e6cc 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2269,7 +2269,14 @@ static void arm_cpu_realizefn(DeviceState *dev, Er=
ror **errp)
>      }
>
>  #ifndef CONFIG_USER_ONLY
> -    if (tcg_enabled() && cpu_isar_feature(aa64_wfxt, cpu)) {
> +    /*
> +     * We use the wfxt_timer for timeouts and event stream so we
> +     * enable from V6K up. There is no event stream on M-profile.
> +     */
> +    if (tcg_enabled() &&
> +        (arm_feature(env, ARM_FEATURE_V6K) ||
> +         arm_feature(env, ARM_FEATURE_V7) ||
> +         arm_feature(env, ARM_FEATURE_V8))) {

This code runs after arm_cpu_propagate_feature_implications()
(which happens at end of instance-init), so you can rely on
the usual "feature X implies feature Y" stuff being true, and
just check ARM_FEATURE_V6K -- that is set for anything A or R
profile that's v6k and up.

>          cpu->wfxt_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>                                         arm_wfxt_timer_cb, cpu);
>      }
> --
> 2.47.3

-- PMM

