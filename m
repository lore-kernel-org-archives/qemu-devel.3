Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D8CCD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWdMV-0000Ig-1q; Mon, 08 Jun 2026 13:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wWdMT-0000I1-I5
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 13:02:05 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wWdMQ-0002OO-Eu
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 13:02:05 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-46015dc517aso3714394f8f.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780938120; x=1781542920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Xj+SKmjFc6s1UJlgY0hUfGaxYukZbxmJSQ4x5M+AHw=;
 b=KIHR+hXFvv9GzQN+/WBXV6kAH1IOcANYlDu7zO8xnuECHEoIa4EIRx5mHZ39Y0LTg1
 t5a8nLx0XhE9BtAp9Imw0UXc8WNmS2D3nKMc2bzckusUctW+ANP+O+iiEREbm7YRE070
 yF250OsMx8rFhnf2yq09yczdlP+lpEwKcCLvtV9USgvoOZxOA8OwMb2B+ipS8S0j5n+Y
 U2XiGHSD6lUyMFqVOpv6albTvNGuJY8MRPXqpUgfh4K2iveVN9KK7OUSu7J7usS2ueVP
 yNrzWvt+65/3qJ9NVpIShHvuQ8etnyOr6HIEamm7x8glr+1XCWeJVhdWltm4uLpSWemz
 BKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780938120; x=1781542920;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Xj+SKmjFc6s1UJlgY0hUfGaxYukZbxmJSQ4x5M+AHw=;
 b=hjXgPyPSHjORdDR5g+/WotiSwfZNUXfqhDLMNrFWrGKwy1jolQoUBuVyVPWfFGVqiY
 PCZ/1P8YzZ85ue6anr5zqFzKmf7L7Vup2QPkGzRnB/RX52yMYlfosVXSjag0xoGB+O4r
 ytAarkhPqlr4BaA7OGoRBnkGyk62uNveDGyfrztvinFBY/hPbuLfWTuimEteSn7fQ0qb
 CIRkTJLgTHfps5cBRh4H9pQ2TfK/fHEOGV/PHmSHcb9+7QZ/UPsH77w+GO+TKrRDwolq
 7lmvcI5uHKnQN3NHK9X2q/Itk9F9ciJRbAdZy/mY1TbOA62vXx3IheTZDPTACyrDR256
 TciA==
X-Gm-Message-State: AOJu0YzSADJRqRwltUOAVilLeF/dve3bzsWN9h5WtPb1DViX2e38ASYr
 bnZd8GfZh+iV9fhwKS6Cdq65zJxAtPXmAPjgD7pDE4ogyp9/9sU2qyKabKcAGvsWLuA=
X-Gm-Gg: Acq92OFWvYyx0sTx+L3/Yzpl5BaRosEWkV1c3bMLSV/D8fxw3EOWHU5xVWQtF1D25K9
 bv4giBoxiPvRsCkVRUIxIW/+HX0byIgcGgMkHyOFEpG7OdMcFDWPmFGmBZRVj32A3Y2rE1O0C1C
 qJ3iHYedkUQLQuA+JYET9lFP+sR4aTKrbATJEZyEf6XwqYlR8ZuW98dgy7dH9s4NFe2rVubtFMd
 MRC1huvtRDIvCPyLYxsH9T2qnFt4R4oZdY7ZznKUVP/72Gy/DKFJn0DrcCqLsNFPaoSAy9yfL/A
 e2C7MS+2x6iAz/c3rrr8z4bvVKMpGum/moYAGSgwop0ahj+G/KXPAyU65rVEGmsJRJljl6Kg0Ry
 AlYrvqkHTk9MK8cnnezA01nRbDdre6ylZsJ4UbVy5G+RYlqh6AJ01qbTMFhAfVyEyk79B0Y2MjI
 Hy4aLQQ8TBsny9itu1YUUz20On8cztoI2EQg==
X-Received: by 2002:a05:6000:184e:b0:45d:77f4:1ac2 with SMTP id
 ffacd0b85a97d-46030183b8cmr26123425f8f.0.1780938120382; 
 Mon, 08 Jun 2026 10:02:00 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcde3sm55826031f8f.1.2026.06.08.10.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 10:01:59 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9E0755F7DE;
 Mon, 08 Jun 2026 18:01:58 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Alexander
 Graf <agraf@csgraf.de>,  Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,  qemu-arm@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH v7 0/8] target/arm: fully model WFxT instructions for
 A-profile
In-Reply-To: <CAFEAcA_5uw3z9ePV83Ni1fsVj_m3340i7E2X-DO0=st-ZDqxEg@mail.gmail.com>
 (Peter Maydell's message of "Mon, 8 Jun 2026 16:54:17 +0100")
References: <20260529082948.363931-1-alex.bennee@linaro.org>
 <CAFEAcA94+mh_pigFDi+tEPRJ416fSWfxsQ1Lj8Byemug9kBp6w@mail.gmail.com>
 <CAFEAcA_5uw3z9ePV83Ni1fsVj_m3340i7E2X-DO0=st-ZDqxEg@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Mon, 08 Jun 2026 18:01:58 +0100
Message-ID: <87h5ndge49.fsf@draig.linaro.org>
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 8 Jun 2026 at 14:51, Peter Maydell <peter.maydell@linaro.org> wro=
te:
>>
>> On Fri, 29 May 2026 at 09:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>> >
>> > This series fully models the behaviour of WFxT instructions. We
>> > already had support for WFE for M-profile but we left off A-profile as
>> > it has more potential sources of wake-ups. The main one is the event
>> > stream which includes events from significant bits of the timer
>> > ticking over.
>> >
>> > The refactoring from the previous iterations of the patch have now
>> > been merged.
>> >
>> > I've dropped trying to fully model the global monitor in favour of
>> > taking advantage of the architectural flexibility to have an IMPDEF
>> > event wake up for any reason. We treat the setting of exclusive_addr
>> > as such a reason because it indicates the current vCPU is in a ldstx
>> > exclusive region and we don't want the guest to deadlock. This does me=
an
>> > the system won't sleep on WFE enabled locks but people shouldn't be
>> > relying on QEMU to model real world sleep patterns anyway given the
>> > efficiency of emulation compared to real HW.
>> >
>> > I've written a test case using kvm-unit-tests:
>> >
>> >   Message-ID: <20260527111822.1563679-1-alex.bennee@linaro.org>
>> >   Date: Wed, 27 May 2026 12:18:21 +0100
>> >   Subject: [kvm-unit-tests PATCH v2] arm: add wfx test case
>> >   From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.o=
rg>
>> >
>> > All patches are now reviewed.
>>
>>
>>
>> Applied to target-arm.next, thanks.
>
> This turns out to cause failures in "make check-functional": some
> tests now time out. It looks like the patch that triggers this
> is the "enable event stream on WFE instructions".
>
> 13/79 func-thorough+func-arm-thorough+thorough -
> qemu:func-arm-aspeed_rainier               ERROR            36.17s
> exit status 1
> 74/79 func-thorough+func-arm-thorough+thorough -
> qemu:func-arm-smdkc210                     TIMEOUT          90.01s
> killed by signal 15 SIGTERM
> 75/79 func-thorough+func-arm-thorough+thorough - qemu:func-arm-raspi2
>                      TIMEOUT         120.01s   killed by signal 15
> SIGTERM
> 76/79 func-thorough+func-arm-thorough+thorough -
> qemu:func-arm-quanta_gsj                   TIMEOUT         240.01s
> killed by signal 15 SIGTERM
> 77/79 func-thorough+func-arm-thorough+thorough - qemu:func-arm-bpim2u
>                      TIMEOUT         500.01s   killed by signal 15
> SIGTERM
> 78/79 func-thorough+func-arm-thorough+thorough -
> qemu:func-arm-orangepi                     TIMEOUT         540.01s
> killed by signal 15 SIGTERM
> 79/79 func-thorough+func-aarch64-thorough+thorough -
> qemu:func-aarch64-sbsaref_freebsd      TIMEOUT         720.02s
> killed by signal 15 SIGTERM
>
>
> I've kept the first 4 patches, but dropped patches 5-8.
> I also noticed a problem with patch 5 which I've commented on.

OK I'll have a look.

>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

