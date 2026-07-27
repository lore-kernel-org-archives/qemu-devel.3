Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3084C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 16:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woNuf-0006cZ-Co; Mon, 27 Jul 2026 12:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woNuN-0006PM-HW
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 12:10:28 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woNuL-0008MH-G2
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 12:10:26 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-668296d0ff3so3589243d50.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 09:10:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785168624; cv=none;
 d=google.com; s=arc-20260327;
 b=mwVeRVxwqzjECky5+55lkxWVe5dNiaH3AHiPCQkPmlDnJgntbeqNVGbbghPUM0T1g4
 Nxy0/pwJEF3Kfc+QroYGGtkwaliSfJm6dYsIxBMkDCvnW0TLVEDxB3e1q7IazqHz6NfK
 4BCgTbrn5ERrbkk8HLXkXPZo6/Jl3CrdiRwHaejQTkC4p3SBhfW5hJkZ5Axd68k6NB4E
 1pFJT4Bg92WyvX62SkRs0DVpoeHrO1Nm7SLQz/ECtg86RPK4sWEN7EKlG4HK+2zmt/8o
 9EEC4kFMxiQQsa8EUOZ+Y2xN9N5SJm1FkZR82Kry2yr6j6u4/zQLRbzUWMgKuc5uJRTZ
 iM0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OOsxF6EKGXLBykC9ScLiUIhGyadMeqkWsBstlwVytuc=;
 fh=sGBvXAL+5zle12kasPzOSbvFqIAYrbTT+z1vg9u5w4U=;
 b=nSXs+TWLtnIrFE2jXDIoGwDwXx+QrwMvRvHvNjufu5GRZOO5FNNJkpUsB1fWfaP4JN
 cay2KYBcNg7iskGn4V5E7G0KEzUV9zTaQHxDkQCe5LcT4qjrfEbvJ1OuSprvv7sKpXHq
 s+EmfAtsHTPokEDwYCbGtvTIg3Qji+JT1VhzjcnWfz3Cwn/JuVguu62t/NUPriw1MbS4
 awJw7K0pCJQACADzZRTW3q9QJrHxoZEivWIg/MAlhGTeaXce2cBUbOp83+M4bO0bRoqd
 MsjL0RFjifF4J8HLwJz9azM1lyj1iMNiENBZrBA+vY/tH83Jdz8/jis/BNgQD96DizTF
 3oSw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785168624; x=1785773424; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OOsxF6EKGXLBykC9ScLiUIhGyadMeqkWsBstlwVytuc=;
 b=ptlPXRXAiKvuvJeBUG0NiS4Ordkdc1fguUGcRPukmBO1QsLULciRNzlL/0V+hcHiJE
 1NME+VOCOitKPU+Nw0lkyFk4EBYoXFsiPe8F0wJceH227HlLLRg2arKV8MiwaPny6Ymq
 s7CzmbZliUnl04PIdzYK7DqYNqAJJoFwOGY1Z5gdQ4L3eoyl9nVkxdjX8IZcG3qodb6w
 JZO8AFi6JG2Bv/KMiZRVTqv+2LiGRyPm0zL6kfgeITMLnD4ue5RrsNDo9XBld1RUi0cT
 2gfLsNCYMEWkQK7JDPTvb2XjEsHGRuUCszlCiDePuy0rEp1kuyAAhQCKlMWQ67c2VrSV
 oz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785168624; x=1785773424;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OOsxF6EKGXLBykC9ScLiUIhGyadMeqkWsBstlwVytuc=;
 b=YZmSTGYqTw2egzhOJBBi9mupdFD2SRcGKW/1XwgtkfcrSuJRtJQUi1QMzBalZcNYen
 jhWI9XDGOS4kSZr6nDTfEHuw1LJPqdrGFHBSyyekz8IPwXfE5TVywjJdX0KiAbBRZU78
 B0of/x01owIic3ZSU1xxNPvsF8uD577VUYaxeObZRbXmXxggbm+VzvjMso4iH/KXvP+O
 Ngjcq5DUAUu9rNSS/9QXZqZ5vdaZlP4pa463HHedGDPw9uoLrzCD/IdfaewEgW3Z+M2N
 VptsJ+KanHlWoLFdU6Rjqzcl1DizBftxcy+YGWc+WlZUctp+f4qhqCu8NYOgRcEfq47G
 T+Bg==
X-Forwarded-Encrypted: i=1;
 AHgh+RodSYKZ0SGi27G7eeRRwvEK1vZpKayPmBIrAFd7bsxo5yN183//xVBZDsIVGo98qpDzRzBKNXrTcoev@nongnu.org
X-Gm-Message-State: AOJu0YxDv0XCmDGKPStlXG3/V/53OqSBSM8kD5bVJC77DwC3vqiBjBve
 zrBmUu9KmfIq7mbI/YniNkydh8oonENd70qa+Y/F8RdYWRWZHF4+kDxcgnunzzkc1g+MrLatE9e
 JOcTGgjmJQxhp5Vc7G3ewVfJKw+r5vVRUGaIoYdL9mw==
X-Gm-Gg: AR+sD122147Lc4UqQfRpeMomFQwMt4ZLOGpSe9pgF3wX4c+QJQAxf7gILB/jZqfhQRe
 z2DL3vuNskS6586Ax9H9ec6LcMmDnncuFWUmrSZyXnZhUSrMhzWGUPiuygXGodPBDf9hDVY/Yrg
 4VFOOw3evpngJjtd3z3eOYBrIpTW6DOJGi/dV/5m8EVUysHBujpmsEozEl4Sws7+Ux5X5nIZk36
 Z8kIfp/WZnewCYNbC3dnWB1g1dj2ZgKlbI0rO18/oxypAiUF9JxATVabPDT5CxuFRVlnSFWtLTr
 9zfRH/N/kGPy2kA/BTOc9SUC2mSzeMrcOBqwCxvl5TtJU1p+szvxVsQQQPBcIokHTbRbCfTLilS
 8/ODZxCb/rD0+uzPLO2CYN1gM/tsS
X-Received: by 2002:a05:690e:58e:b0:668:482b:af78 with SMTP id
 956f58d0204a3-668c7a76831mr2025073d50.28.1785168623684; Mon, 27 Jul 2026
 09:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260629-pmu-v7-1-939518c349be@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260629-pmu-v7-1-939518c349be@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jul 2026 17:10:11 +0100
X-Gm-Features: AUfX_mymxx0UeI3zaYN-XNOKfFhNqx9ca_fv4qPFNtyAB8qHCBXWywBAQqhTdMs
Message-ID: <CAFEAcA-=u3ZgiAXRNWM1VCMv7FYG2YP=oirf40yGo--p0BSfbg@mail.gmail.com>
Subject: Re: [PATCH v7] target/arm: Always add pmu property for host and max
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, kvm@vger.kernel.org, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Mon, 29 Jun 2026 at 09:10, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> kvm-steal-time and sve properties are added for KVM even if the
> corresponding features are not available. Always add pmu property for
> "host" and "max".
>
> Note that we still don't add the property for other CPUs that lack PMU.
> This is because we do not know what a PMU version should be enabled
> when the user sets the property to true while it is defined as an error
> for the "host" or "max" CPU when the hardware accelerator is enabled and
> the host doesn't have a PMU.
>
> This fixes qtest-aarch64/arm-cpu-features on the hosts that supports
> KVM but doesn't support PMU emulation.

No, we should not special case "host" and "max" like this.
The "pmu" property exists only if the CPU has a PMU and it can
be turned off. If The arm-cpu-features test assumes that the
host CPU always has a PMU and so always has the property, then
that's a bug in the test, not in the code handling the property.

-- PMM

