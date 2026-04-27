Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3209FF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:05:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHSCV-0003Mx-Dh; Mon, 27 Apr 2026 16:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHSAD-00026s-7p
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:02:44 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHSA7-0004Bh-Sn
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:02:40 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-651cfaa21e6so9255933d50.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 13:02:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777320154; cv=none;
 d=google.com; s=arc-20240605;
 b=L9gXxMnUg+E1wxJj5tM4fD4PwGtvLNhDQ2Bx6WM7vvdv95PcJnW8RbbIfNN0C4Y9jN
 FENZSwQSjIZwiwvqKQRFr0vIU3NFyJQjZhbS1cm3+Wo9zR+DX2x5CF4B9jbFcgJw4J2j
 FIt9jx5a65t6r6+ciOTJ/lodCDSVhYdZzBbDAPua4ju8Sy7JL5o0cJxxxOBDDuSAmMY8
 v7ixoIwX1b/s9HY3X+NwIPxfV7ngPyvJmx/JOPwJfGjCmvexUgbbbNjMscBH5wiseBTI
 sO+Moxs1lJ+G+L3uwsGIwgf/hCEjDFDuRwgB8t7ZnauRH65AgNv1k7blMFb/3X3RGW1S
 MguA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EKBtQ/dLFO51DyLLP19cb4OzrdwBTNELtwyyHCrLOnk=;
 fh=TmUHNVdypPJaBqqUu0dYMoHNX5nzLtkGFOPaQ0zDQ9g=;
 b=FuSDufYBYjCJIi7aqiJp/SFf5y01p/sWMA2RmvFO1DESiP+KzmEVuXVZeVQFzIdPgP
 uQFDZkdstddxm+4WAid3vMso3K3REHFyrC4W23zX8suc0RYYWhfkLefWXqxig3MgZuk1
 dlrSI0/PEQdy/kgJiov3DhE6wNzgr6TelrJsP9HsUCO1oYl6DF4M+7iJ2h5+1RjdIWIM
 UvU8W1qyNKzJV/AMaqiyH2X5ArtW2y80WFJ1LukAxm8sUP3vw6F6ANa8AzB/R/L9P61u
 ISc/bhAB01vsF9JL/QLwMR1M3xDx4QEUNT2Sk8y2aRGHObTvnPnQG1QzfS7cDPcqOZjX
 Y2Fw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777320154; x=1777924954; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EKBtQ/dLFO51DyLLP19cb4OzrdwBTNELtwyyHCrLOnk=;
 b=nGz7edE/F6jwnsRl32elAm7jx9qftqkpSDi2512neiwEHttCE5EM6k0ZQVlFKwH7XE
 8ZJ+pPh6x44pzbS7ekaXYdrcVl3JQ/1k7tQCby33bS6hzVB95IjadREinLKj3fe7lR0e
 AiIqcbs1+k+io3fPlf2yXr7BcN0g30GBV0vSYHdCjm47RyW97j9L06hz1baRzjvA1HcF
 6OX5CoDFqhOretlfX6H8bVNgz+XVD3FkH/VP/ON6J+G9YWdcVOxsBuSDHDMVe6IGqnNB
 B3rFc6mH/sIv/Gtf+xKp/mJMcfUKYCDGSNLE0yi/L7/Agy93EUayXvfH+HdQToCDovlB
 TBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777320154; x=1777924954;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EKBtQ/dLFO51DyLLP19cb4OzrdwBTNELtwyyHCrLOnk=;
 b=Ni2WrHhGnIf9fibEBJtn7n1s06Np3IzVA25+NkB762UOGMr6oM3G0fhMULVfY5NaWB
 2asNKL/oMVd1SFM2X91v8mmtwK81W9WHLSMHvwqdJdB/pcNRsa6xcJo5EbBJsNjNbm+v
 zOEgyxukMHDK9XF4qZIFCEmwl+gQj5fvpkb9bHpA5n1HBJ3nCPbzL+Gx5iMSYg+6opqg
 cZLpHT/7vDVSRXIsctAdTob8eGSHtgTNStT++pSXT7a0RDqXMZk0/RiSlLLwoA854/yB
 nS9UpDqOgzf3JJmzXHZUOJu1i8+/4V/h1i2J0Akxn+/Y0aLFLU52Hd2TW4D5Qb5OqyiZ
 CSPw==
X-Gm-Message-State: AOJu0YxjHd+P1uJZcPixzeJcktGeAALIpilSouIfhno9NGgim8butVHN
 AtPuXg9YYNvpfrn6EQaW9uxpdSiyLVS9TS0rSYvU3HXOOT0mx/UXIySka67VdbchAI8vtgbprxL
 SzOkAfOlaEjwYrMTaXmmlP6E2x9uhI+2R7YwCMrxbdg==
X-Gm-Gg: AeBDiesKkd5lTKGOP4lV1oe5hKzXHJ10RtgxjMr2FFklWEI6Xz1YT3jBDN6o3PyhEP6
 xfsLgEJkwBrQjGSnGZAtalIeBTYoYHgfX5vzFfJm2KYFLRnjE1npMnJs4ew1Z6Q2GtqsMFsv5JU
 xScgjN4C3j5a0zduZ3u9W94mdt+fS3Ut39fpR15MOhmnC3X+86Saj1MVk1LqHyGzy8E8zvuyIBA
 u68S8T+/1wOk9Mu7te5YzGA3eE8DAUR2p1p1FvH+qrxglp6XL5X7fQtO0qz9pFRdf5nfbL7Gv6R
 Xk05orG3LZgs5Ue8khqHtIvzOiP3Q2PqPseg+9u1FSN9/05G56hu6b4UcBuVrxTtrF+/RRrp/2S
 8GiaFTv/RSzzl
X-Received: by 2002:a05:690e:e8c:b0:64a:ce57:cac4 with SMTP id
 956f58d0204a3-65bee7f6ab0mr73313d50.24.1777320154125; Mon, 27 Apr 2026
 13:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260409220614.65558-1-lucaaamaral@gmail.com>
 <CAFEAcA-8BeBte6CxH._5F5Zsk3wvs0zJJW6+=8cNaroRTBegK-M5A@mail.gmail.com>
 <20260427184540.80415-1-lucaaamaral@gmail.com>
In-Reply-To: <20260427184540.80415-1-lucaaamaral@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2026 21:02:22 +0100
X-Gm-Features: AVHnY4Lb9mx6eC27k-lXV5h2U4iLlRGZ5z2s3Pq4pzUK3m14JNWgx1p8A7DzJUU
Message-ID: <CAFEAcA9yGmWq--JsyZpPnOQ74i=j7JeeO0Xf6be7wWxJGbXLdg@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] target/arm: ISV=0 data abort emulation library
To: Lucas Amaral <lucaaamaral@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Mon, 27 Apr 2026 at 19:45, Lucas Amaral <lucaaamaral@gmail.com> wrote:
>
> On 2026-04-27, Peter Maydell wrote:
> > looking at this I share Mohamed's question about how much of the
> > atomics/etc we really need. This is a thousand lines of code
> > handling instructions that in a lot of cases the guest really
> > ought not to be using on MMIO regions in the first place.
> >
> > If we have real examples of this being needed, that's one thing,
> > but I'm not very enthusiastic about implementing 'doesn't actually
> > have the atomic properties' instructions otherwise.
>
> Some empirical data first.  This series was motivated by an
> observed workload: the original Venus development capture (Ubuntu
> 24.04 ARM64 + vulkaninfo + vkmark) showed ~1.8M SIMD/FP load-pair
> (vLDP) ISV=3D0 faults plus a few thousand other ISV=3D0 hits on
> LDR/LDP/STP/STR variants =E2=80=94 guest-side accesses into virtio-gpu
> blob memory that the renderer had been forced to map via the
> subregion fallback (MAP_FIXED rejected as unaligned), trapping as
> MMIO with a syndrome that can't encode pair semantics.  Without
> this series, those 1.8M hits land on the assert(0) in HVF and the
> guest is dead.

Isn't the problem here that we're ending up in the MMIO
path at all? That seems to me to be what you need to fix:
taking 1.8M faults is a problem even if we can emulate them.

> Patches 4/6 and 5/6 (exclusives, atomics, CAS, PAC) were included
> for correctness against the ARM spec rather than to satisfy any
> observed traffic =E2=80=94 same capture had zero hits on LDXR/STXR/STXP/
> LDXP/LDADD/LDCLR/LDEOR/LDSET/LDSMAX/LDSMIN/LDUMAX/LDUMIN/SWP/CAS/
> CASP.  The intent was to cover every load/store class the spec
> permits with ISV=3D0, so that paths I haven't observed (different
> device, different driver, different guest OS) don't fall through
> to assert(0) either.
>
> I instrumented every trans_*() and the HVF data-abort dispatch,
> then re-ran the same workload on top of the MAP_FIXED alignment
> fix currently in flight:
>
>   https://patchew.org/QEMU/20260424000544.9617-1-lucaaamaral@gmail.com/
>
> Result: zero ISV=3D0 faults across the run (2.68M ISV=3D1 dispatches).
> The alignment fix resolves at source: blob now lands in mapped RAM,
> no MMIO trap, the ISV=3D0 path goes silent on this workload.

...so yes, that seems like the fix we want.

> So the question is what role this series plays going forward.  My
> intent was a defensive path covering the load/store classes that
> can legitimately fault with ISV=3D0 per the ARM spec, so QEMU degrades
> gracefully =E2=80=94 emulate when meaningful, inject a clean data abort w=
hen
> not =E2=80=94 instead of the current assert(0) the moment a guest happens=
 to
> touch MMIO with an instruction the syndrome can't describe.  The
> same wiring covers WHPX, which has the same syndrome limitation.

We also fail in this use case for KVM, and have done for years. It
doesn't generally seem to have been a problem particularly -- guests
don't do this sort of "needs hypervisor to emulate" access
typically, because it doesn't work under common hypervisors.

(Though for KVM we don't assert, we feed the guest an
external-abort: kvm-arm_handle_dabt_nisv().)

> I want to make sure I'm addressing the right concern before
> respinning.  Two readings of your and Mohamed's comments:
>
> (a) Scope: trim instruction classes with no observed use case.
>     Smaller series, less spec coverage at decode level.

This is mostly what I mean. If we don't need the emulation
functionality, don't implement it. We're not going to get
every load and store emulated anyway (for instance this patchset
doesn't cover SVE or SME loads and stores, which are a whole
huge class of memory accessing instructions).

I would like any memory access emulation to come with an
attached description of what the guest workload is that
is triggering the requirement for it, so we can check that
it makes sense to do so. (Mohamed mentions the Windows TPM
device, though I am still not sure what exactly is going on
there and whether emulating the access is the right approach
to it.)

thanks
-- PMM

