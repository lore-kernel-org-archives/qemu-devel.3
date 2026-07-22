Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02AAC4453A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 17:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmal6-0005ue-EZ; Wed, 22 Jul 2026 13:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wmal4-0005u8-VL
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:29:26 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wmal3-0004bc-AX
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:29:26 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-80a123ef90aso87940707b3.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 10:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784741363; cv=none;
 d=google.com; s=arc-20260327;
 b=qrAbFBjpyinD0d/ZfaLLM4JAgQ6d224ViMacj7bdcjAAfFgquYzrPWGMH32GuAc1sk
 7Khgj5esI9Ny4f5ae6EwKdqoKE/fxgSYAEZelicVj11iC5d8De28710hOh2mQo3IRWDP
 LCOiXuh/5M3/uSyQDFG+ah4k8V7xc40MDZIpdrkjFQWFZkutmUZBi7xInR+B9oq0kbi+
 at4nz0akYrt0C+KAZTSaukikOyzwb2kYmvivV7bmXFuvVghAESLmTU+9JwoM9fJAHFV3
 RUOxaqd7Gq2N7tYvMrg/mvziuQeCZ3v434fuPdlFyelxZJxxLnii/HBdNPTlK5ljiyFZ
 zIzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8nQBuyxIThiBME9+27d2sMEQM93l7vLfV75zjkDF8Fg=;
 fh=SqoUJT2B5IxldjjUFCOeJt1lQj0U4YA9iTmsEfj5fag=;
 b=HlkVnn/78gWdFyRec9mCu6wYoykExACVPEzIpESzPOSGA73qhJz87WGLJWQvOjQrMg
 mx6qOJ2qYN8vgSXH6bq7alcs6CDwdwhJ8BYukqwPU7mdZg1CasNZ9exNZwcAIhsTgYmo
 AwbQIGsybaRd1s/L9couQ1a01I4VYlQIYVNWuXChFQ5wDE6vyw1cAGRL+NaiyiJ3rbsq
 6ynPDxGpbReVb3VbS03uzaHDjbXuR/65VTq09RvBRDPpVebcKkPiE7AD3e8DAr7ovo8I
 jih/OWkp4/FzPshsL06xUOZhsTmUuwnweBsUqT3YVTaknrRgbD3WSwKZXsNBkVCjRB1O
 xcIw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784741363; x=1785346163; darn=nongnu.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8nQBuyxIThiBME9+27d2sMEQM93l7vLfV75zjkDF8Fg=;
 b=RtkzbTwNuL2RiQQnjsiUgOP1C4HIeTZ+to/HBvthBUqRqpZ70ADnkes3ctq2yU289s
 dt+OqADoaBF/WO0Mu5attF5oNpCWM84pDcMbKg1dIxfmVY8QbPivLawmhFIjiRRZvVCn
 vBb/A95uqnDxI8187wbrZgEORGmnyCQ0DOSwOvMy7JSRu+7ku1i9uVqqJskMgjMSGGQJ
 nFNoGbFSb/afpd8zVfIxcGvRwswaOmh9FMma7oRLE2k6SN/VgpARiRbEtRSqoAe79A8C
 zjxsEahsQoneAn7rbAcg9j4MnClaUZ3wV2/cMr+MKgpXVQM9uV8usr1ai85x0WhwZzvb
 idVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784741363; x=1785346163;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8nQBuyxIThiBME9+27d2sMEQM93l7vLfV75zjkDF8Fg=;
 b=ZODODv+pkZGvQ8kL7nP9SxA1FX4PNcywR22vegTYhROlRi/bw5oOD1GA8HuR+pHIc4
 6jgtQjSXbLnZsQDss9y6rzaM/ccZyd7vgMf47KK2q/XgirkyugXE4IbSrTMR3edZjfLT
 KWCoYu/9VVV5B+9/EqF/IX9HMLICK/WLC2jnH2ik42lvB76svzKcJXveU0Um2jxH8Y+0
 4+98d+rxcYxlcGKsPiTWulo33PCILRFygsqdzUvPQIvEeXH0vvh+aHEsuBPZDNPgbeTg
 F5sQg0jBjAWqU98adShyxxkztfdDVLhMRe7sO6Kdjsd2PEOHiUx7ns3SQfhGG74/hS0h
 ZEyw==
X-Gm-Message-State: AOJu0YzqR1wmGklKE0Cz1vIPoHyptiDgWywHGrd4Qv0sMxisGeB2p12j
 BjC9p0O7F9hu9Gya+shS/OHq4XszkxogZDy4zU7HXGVS25CFDZKm7OpJHevkjDLXHePsp7aVjRu
 wYJVHXVP4HtuUYN1HJyuT3P5r1v/TxoNmlAd95O6iu+N5vJr5EGolZkQ=
X-Gm-Gg: AR+sD10DLyjxmvYbgmaPwmBV71/B3tDde8XYlZKOoNua4O2a8cxYRwjwdxg9FN5KdDZ
 Wx9sprM3S50NBRmwTHC3DyWz9kNOft+DGUvgS8G3Gn1aZq/DCpqGMpGhLs4HhnGBIRUvcJyOjMI
 rrwOljmurAOW1fdI/yrEkrCyp/28DNtcTQBWiRpRSxSzMjExmCHroYfI9URsfCaTcLDuri7QEqD
 wzsS8yJsvjEg8/jWr4/Ex8K/HlbOrtEjmeg99g8bfa5v4sYdAfOgY8CY7e0KotVap3IglrqsPFj
 mlmH3YmYOBFwTN6mOF/ssyDprH+kZiRnirF/Oj5Y69+VFw==
X-Received: by 2002:a05:690c:368d:b0:81e:6563:72ee with SMTP id
 00721157ae682-81f33c16aecmr16565907b3.14.1784741363177; Wed, 22 Jul 2026
 10:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
 <20260610161202.2235298-21-peter.maydell@linaro.org>
 <CAFEAcA99VL1B57MsZ=WRjEw-vyPcxh_bw0Xj2DWQTydihWMyNg@mail.gmail.com>
In-Reply-To: <CAFEAcA99VL1B57MsZ=WRjEw-vyPcxh_bw0Xj2DWQTydihWMyNg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 Jul 2026 18:29:11 +0100
X-Gm-Features: AUfX_mwwGVEqnZzbN3R9Gi7J_Ehgz82234EsTBTjMWoTEDTRR-IYntURqwht40Q
Message-ID: <CAFEAcA_aXzZtC2XVdZOf1SyFR3imUoxpda91RuuMRF+2me5L3Q@mail.gmail.com>
Subject: Re: [PULL 20/71] target/arm: teach arm_cpu_has_work about halting
 reasons
To: qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Tue, 21 Jul 2026 at 18:06, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> cc: to qemu-stable as a late "could we backport this (plus the
> commit fixing a bug in this)" request...
>
> On Wed, 10 Jun 2026 at 17:12, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> >
> > From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >
> > With the advent of WFE and WFI we need to pay closer attention to the
> > reason why the vCPU may be sleeping to figure out if we should wake
> > it up.
> >
> > Create env->halt_reason to track this and then re-order the tests so
> > we:
> >
> >   - ignore everything is the vCPU is powered off
> >   - wake up if the event_register is set and we were in a WFE
> >   - otherwise any IRQ event does wake the vCPU up.
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Message-id: 20260529082948.363931-3-alex.bennee@linaro.org
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> I didn't realize at the time, but this is actually fixing a bug,
> which was just reported via the qemu-discuss list:
> https://lists.gnu.org/archive/html/qemu-discuss/2026-07/msg00000.html
>
> For M-profile, we already added SEV/WFE support, and that's in the
> 11.0 release, but arm_cpu_has_work() incorrectly checks for the
> event register before it checks whether the CPU is powered off.
> This only affects M-profile machines with multiple CPUs, and
> the effect is that a SEV on core 0 incorrectly starts core 1
> when it's powered down.
>
> Could we backport this change (commit 6fd2fcdc61b70) plus the
> bugfix followup (commit c2804566f654 "target/arm: do not clear
> halting reason in has_work helper") to the 11.0.x branch, please?
>
> (Earlier branches don't have SEV wake anything up so don't need
> a backport.)

We could also do a simpler version of the fix for stable
branches if preferred, which is basically changing only
arm_cpu_has_work() to return false if cpu->power_state =3D=3D PSCI_OFF
before looking at cpu->env.event_register.

-- PMM

