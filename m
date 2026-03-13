Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E69105F787
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 10:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0zJy-0005uY-GW; Fri, 13 Mar 2026 06:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0zJo-0005u3-Bw
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 06:00:33 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0zJk-0002vX-9r
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 06:00:31 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64ad9fabd08so2511549d50.2
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 03:00:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773396025; cv=none;
 d=google.com; s=arc-20240605;
 b=LD3njKKJvW9tIJi9jVrDsApZc1eV4MXh0IlSLQ1Vl9kEVNyeq6Kt6RH/XnAwgqtf0a
 zCpiicXbdZs6vGreIxg4S9cxkI6brWsFinU+MtCB0FrH3Wmplmw2Zy/ZrJjSt2oF2IaA
 JUWxlQu2xZ4Tym3o4iMbXgomf3xnEnRcCUje12KPm0ntz6liayhDZJ8IOcqVTSekpjUS
 mQJr+sdr/ws0ebJ5iOO6NWeFt1WREKuj6tgFl/q/gB5qdCrwq3dMCuzMAYuuPoKC+s4K
 RmE6aLRu5j+LfoPtDIi84NWWA2Hqc+SWGShvL7m1K3nFgJt/QGCplMorSKjF1q345yGH
 xcyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jaetzaU41Uc2nilTU+E4SHhU4sPTBnFvc+ZjCcQ2Pzs=;
 fh=gDkueT+7etTbYgMqvbm+CxUpmmvemB5VJaRcqDRkLr8=;
 b=LXhZ5okuemKpijC3u8sFM4cexyk2nyGXjD/Aj3PEdSlP3wB3E1fnRqvFSOT+FgbAAE
 Fy1QjXJNRFCWcCSQUAbbHtodrJ4ho3m8NZPN88vreqn7pVuGjd4a0Jt8r7WQT3a+wOVD
 virKQgfI0EVX8Pxu5KkNKDeyhefcI6N64zvmarp0UKa3QqUF1pwZi5PNSIuWKael9fmS
 GEZ+2sRe3yj4UH3RsjSLmCmNyRDRk9Yl5M8Nxmn38slcZObU1UGF2ASrZwiLch63ewY4
 6FLQQgrz7EOYfUoNT1lzCi5kwUQXz65+98tJePUKHHSJzNHpB36FUgqQOKVu03DatyRx
 sq5Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773396025; x=1774000825; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jaetzaU41Uc2nilTU+E4SHhU4sPTBnFvc+ZjCcQ2Pzs=;
 b=lhqXuq2RpmbmQjQIwn0ZYnnFykZwLfVB3mM6b+DxpqmUS8hd9nPJq2NiqzZ8N0MQ7P
 UbEEzrMJQksxQDKyZtZ9M4dQ//7gGUYwwLpM0BYZjZinDDTPqjwCJ3ziNJlGxaJkDRPd
 wpdRSLffpMmZU6rts2d3Rt5Jy2BRSNejmWEiGUJ7/8XbHbe3z6v2LyeVUO39TJ32VjyG
 04xBwxymlMLCRMPccuUQHFIG08uBSAgbKJwKpDcepg5bTjKbS+9PkyuzP3WAkEzh/9et
 qIWUGnQqGzGb8IZTsv9qGrYe1/kp05DFP5bpLMwAUw6yHR11FsioUxQkF5m4dgC0K1MK
 43hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773396025; x=1774000825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jaetzaU41Uc2nilTU+E4SHhU4sPTBnFvc+ZjCcQ2Pzs=;
 b=J4m3oMklX16zK2MfLficIb4dpTSuh4xqynEoXCXjowO46D0oWCaTEytU64SBPP9Slu
 VXzUFU+y78M5f0iVqkDtr8zRhTIJGSti/1mxccD5zMyj3aGxrpVSLXz6IIvB9XcFx7Dg
 fK7aCI8Ym43TZ6EDmfiiPV5+HCWDJHBeeZrAZ2Ahc4jyyeTGLtdXr9LpGEKdfn7bPW4O
 73T0nTaVearzCAaBcNEFNZLMBG0ARCjPPcroE1q2IhG1W0g93Mtiqg5IZ+qQSp0fBp30
 VknrBCA1PcWP+tUPyn+G1UFryTl2S25Ef+EBmAtKUV5tE5+KNRqqpgjctl0WHhc3esyQ
 zctw==
X-Gm-Message-State: AOJu0YzkwizZrDi2TOt50rtCRf/yafE6MgqjQNYunmz7l/RjRUFhra7n
 CH1lIl1EhbSdNHf/UWQMTqUkfUetguq75+FLiatnqSb4RHlm05/Xla2jtns1s9NAi+2VhwmPZl/
 hVZcmSu9gCanm0X/q2gpi7np5qSrtVAXOi78vjeQw5AxjRBufbjt6
X-Gm-Gg: ATEYQzxSomEVlcUpHODI4UZrtVErMSZlLKB7iz9pjMQhtnUjeaKvNfB3yXfIk9exhoO
 X3y+eI3Px7EAAk1AVcC6Dy+g/VKZH42tgw1+0kQGm2BdYV1KWtM83VLoO5FrXiBOFVwGXfm2320
 FYHLgrV0A6TiUK6URRQ2Dig9zbZRP89gYXrXc6PffwKPVHMkFF38oU+RweMFzAFQaWhnSoNSfss
 twr74zy8TUG6q1UTGcUU2c5eBG7JshYC35m7HVaoEbz4IePyylhZLqfU8zNKzUi1cLoj4ozAWoA
 CTSvrZV+/MEKHMAOOTQpXp7NHcp3e8Sg4m4TH/23gwjut6JYNxdMV6sYiDKmQKqZdco=
X-Received: by 2002:a05:690e:24c6:b0:64c:a516:de8f with SMTP id
 956f58d0204a3-64e63048f8emr1980606d50.47.1773396023040; Fri, 13 Mar 2026
 03:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260309114651.18825-1-mohamed@unpredictable.fr>
In-Reply-To: <20260309114651.18825-1-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2026 10:00:11 +0000
X-Gm-Features: AaiRm52MzBnKzqF5nCr001-EVAuRE2lULhV6b3Qj67qJOZLrL6AUrolnPaI_XhM
Message-ID: <CAFEAcA9GctVQo_Xc7EyfhinXza-8Kw0SOxwrwpyB1=Br+XjHpQ@mail.gmail.com>
Subject: Re: [PATCH v2] hvf: arm: fix Windows boot with kernel-irqchip=on
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Mon, 9 Mar 2026 at 11:46, Mohamed Mediouni <mohamed@unpredictable.fr> wr=
ote:
>
> Apple headers say:
>
> > When EL2 is disabled, PMU register accesses trigger "Trapped MSR, MRS, =
or
> > System Instruction" exceptions. When this happens, hv_vcpu_run()=E2=80=
=AFreturns, and the
> > =E2=80=AFhv_vcpu_exit_t=E2=80=AFobject contains the information about t=
his exception.
>
> > When EL2 is enabled, the handling of PMU register accesses is determine=
d by the PMUVer
> > field of ID_AA64DFR0_EL1=E2=80=AFregister.
> > If the PMUVer=E2=80=AFfield value is zero or is invalid, PMU register a=
ccesses generate "Undefined"
> > exceptions, which are sent to the guest.
> > If the PMUVer=E2=80=AFfield value is non-zero and valid, PMU register a=
ccesses are emulated by the framework.
> > The ID_AA64DFR0_EL1=E2=80=AFregister can be modified via hv_vcpu_set_sy=
s_reg=E2=80=AFAPI.
>
> That documentation turns out to not be so accurate, with the determining =
factor being whether the vGIC
> is enabled instead of nested virtualisation. If ID_AA64DFR0_EL1.PMUVer =
=3D 0, Hypervisor.framework doesn't
> give us the luxury of having PMU sysreg accesses trapped to the VMM when =
the vGIC is enabled.
>
> As Windows really wants at least a single counter PMU, give it even when
> using the kernel-irqchip with nested virt off.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>  target/arm/hvf/hvf.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 8aa59a1f77..136761b429 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1187,8 +1187,12 @@ static bool hvf_arm_get_host_cpu_features(ARMHostC=
PUFeatures *ahcf)
>
>      clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar);
>
> -    if (hvf_nested_virt_enabled()) {
> +    /* Windows really wants at least a single counter PMU... */
> +    if (hvf_irqchip_in_kernel()) {
>          FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
> +    }

This comment and the code don't line up. We say "Windows wants a PMU"
but then we only conditionally enable the PMU. If the irqchip isn't
in the kernel then presumably the PMU is still disabled (or at least
not advertised to the guest) and Windows still falls over ?

-- PMM

