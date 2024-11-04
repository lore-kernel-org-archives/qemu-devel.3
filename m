Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A729D1BDC4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 16:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7zyO-0006ds-4k; Mon, 04 Nov 2024 11:30:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t7zyM-0006dL-CG
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:30:34 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t7zyK-0002at-Cd
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:30:34 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37d6ff1cbe1so3200797f8f.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 08:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730737828; x=1731342628; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=81MEKb96Xf23UJSyBQxdF8diKY/hHJyzem6vpJzEVks=;
 b=jmGiyE3xCblrqwkoocKsaj/lErpOeb01YQoSeI8EWMHPPsJCJOQcBYSj7Otek6bS8f
 4khd1jeSKwTagC8d6adEegd11Em0pxdt9crAhVXlPTLIrgAYsxLgBEKlZSNMBgavYGd1
 P+S00r1sLdaEiexoa07JZxnNdQvZ3/JhohXMQNyQkaTGv0Q1M5bhjjj/VFwHio4iXrno
 oHVJM3iO8FLU1vLGeaV6sn3NRW94T89YeRVNwi9PoqqYqdM0nadSL8v4sWewpMARLMV9
 SAPFkulm/nDX7YxggwGKgubKPQb25Ju1Zb8Bmmrds926OJplbwuHP8NGRYSqtaONc0rN
 EiOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730737828; x=1731342628;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=81MEKb96Xf23UJSyBQxdF8diKY/hHJyzem6vpJzEVks=;
 b=IMBTw/a/2ixxrrQnQsMiukiwgdFkHMl1d/SJCg+MaTiL0eUXWX0p7k9G2ykveG8ANk
 6Q/tKRIVCi7cwkFJKkCmkuRPiHNhuTngc5YqCxDPRyIcN9KekkL/RBOdkYqmw9dgH4Xb
 2Sjc6v1FAHPWc5t4gxyQbS58LjLtEc8Zty+bz1g8acSejhsw3DwZcRng9chiBRh/gQel
 A9jqjDx8TYZJVwWCY19Y9mdNlJcGbEx2iT1rBKgNFG7woSKkPcZreHRF2y4Q6osXXYJM
 W3aPD3xhUGknWH7F9wWTewze+rvObeMYrtm1VQJ/HRLmKmmIWfCXrqA1mXGr6V/lq3Kn
 0OcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA5lkZj4lE8K4VTN1fxaV8abwvYF7d06BitRvYh0g/htORUt7a/kNNyYdCbCr0TGRxfUq/FVOuAhW5@nongnu.org
X-Gm-Message-State: AOJu0YwWrMSFA2ygaRkRsOBrAzM5XWD6IWo2yXHvvw/x1vp22LtrmOIv
 pDXm4TQVEdfMgCYDW6kudDyR6QS7biRBckTwb+81So69meWeyncxJyA2GKFglmaoqMPRcwjipcQ
 un2kQ0lHXOXtrPzjNqvafL2Iulzq00gGSn4ozuQ==
X-Google-Smtp-Source: AGHT+IEju2LhnIlbLomjmkieAVQZclJMFur7ko24mfBkDSRB0/zezLDP4oMRlXLwj9h5AjtXpFCyqKny28HPJkpERnQ=
X-Received: by 2002:a05:6000:1569:b0:37d:3777:2ac6 with SMTP id
 ffacd0b85a97d-381be7d9781mr13788713f8f.35.1730737828579; Mon, 04 Nov 2024
 08:30:28 -0800 (PST)
MIME-Version: 1.0
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-22-eric.auger@redhat.com> <Zx__Zi3Zpg1AspnE@pinwheel>
 <52690aae-55b6-47d5-a308-dd75475f8377@redhat.com>
In-Reply-To: <52690aae-55b6-47d5-a308-dd75475f8377@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Nov 2024 16:30:17 +0000
Message-ID: <CAFEAcA9y5ooPNZ7JbGmRyTKbZn5XPK+5zZgVAvnER=++kWuBrg@mail.gmail.com>
Subject: Re: [RFC 21/21] arm/cpu-features: Document custom vcpu model
To: eric.auger@redhat.com
Cc: Kashyap Chamarthy <kchamart@redhat.com>, eric.auger.pro@gmail.com,
 cohuck@redhat.com, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev, 
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 oliver.upton@linux.dev, sebott@redhat.com, 
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com, berrange@redhat.com, 
 abologna@redhat.com, jdenemar@redhat.com, shahuang@redhat.com, 
 mark.rutland@arm.com, philmd@linaro.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

On Mon, 4 Nov 2024 at 15:34, Eric Auger <eric.auger@redhat.com> wrote:
>
> Hi Kashyap,
>
> On 10/28/24 22:17, Kashyap Chamarthy wrote:
> > On Fri, Oct 25, 2024 at 12:17:40PM +0200, Eric Auger wrote:
> >> From: Cornelia Huck <cohuck@redhat.com>
> >>
> >> Add some documentation for the custom model.
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >> ---
> >>  docs/system/arm/cpu-features.rst | 55 +++++++++++++++++++++++++++-----
> >>  1 file changed, 47 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
> >> index a5fb929243..962a2c6c26 100644
> >> --- a/docs/system/arm/cpu-features.rst
> >> +++ b/docs/system/arm/cpu-features.rst
> >> @@ -2,7 +2,10 @@ Arm CPU Features
> > [...]
> >
> >> +Using the ``host`` type means the guest is provided all the same CPU
> >> +features as the host CPU type has.  And, for this reason, the ``host``
> >> +CPU type should enable all CPU features that the host has by default.
> >> +
> >> +In case some features need to be hidden to the guest, ``custom`` model
> >> +shall be used instead. This is especially useful for migration purpose.
> >> +
> >> +The ``custom`` CPU model generally is the better choice if you want more
> >> +flexibility or stability across different machines or with different kernel
> >> +versions.
> > Does "more flexibility or stability across different machines" also
> > imply "live migration compatiblity across host CPUs"?
> yes that's the goal
> >
> >> However, even the ``custom`` CPU model will not allow configuring
> >> +an arbitrary set of features; the ID registers must describe a subset of the
> >> +host's features, and all differences to the host's configuration must actually
> >> +be supported by the kernel to be deconfigured.
> > [...]
> >
> >> +The ``custom`` CPU model needs to be configured via individual ID register
> >> +field properties, for example::
> >> +
> >> +  $ qemu-system-aarch64 -M virt -cpu custom,SYSREG_ID_AA64ISAR0_EL1_DP=0x0
> > If possible, it would be really helpful (and user-friendly) to be able
> > to specify the CPU feature names as you see under /proc/cpuinfo, and be
> > able to turn the flags on or off:
> >
> >         -M virt -cpu franken,rndr=on,ts=on,fhm=off
> >
> > (... instead of specifying long system register IDs that groups together
> > a bunch of CPU features.  If I understand it correctly, the register
> > "ID_AA64ISAR0_EL1" maps to a set of visible features listed here:
> > https://docs.kernel.org/arch/arm64/cpu-feature-registers.html)
> Not all the writable ID regs are visible through the above technique.
> But indeed I think we converged on the idea to use higher level feature
> names than ID reg field values.
> However we need to study the feasibility and mappings between those high
> level features and ID reg field values.
> The cons is that we need to describe this mapping manually. Besides
> being cumbersome this is also error prone.

You might be interested in "Arm Architecture Features" on
https://developer.arm.com/Architectures/A-Profile%20Architecture#Downloads
which includes a 1.8MB Features.json which is a machine
readable version of the "what are the features and their
dependencies and ID registers and so on" information.

But note that (a) it is alpha quality and (b) I am not personally
going to try to interpret what might be reasonable to do with it
based on the legal notice attached to it: that's a matter for
you and your lawyer ;-)

-- PMM

