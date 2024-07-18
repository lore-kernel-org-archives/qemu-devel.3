Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BA2C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 12:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUQXz-0008FE-6Q; Thu, 18 Jul 2024 08:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUQXt-0008EB-Iu
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:47:41 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUQXp-0002Dh-0D
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:47:38 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2eea7e2b0e6so12546281fa.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 05:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721306855; x=1721911655; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XdDrtQYVI7pRTfjiVCqeFj/FSqkdT7olrHwvukUpSgU=;
 b=gweQJ92YJzXKJFbYYqgKnk6+7jHQzQhLfsRdJC5dVKqTprvlfvgjaSBBC01juAVkQ7
 +SoaiG5eABoPss7Q0hUEY9DuBrGCugQxcgnsBrh00Zis+BFZwOzmYhtWaHs3tW7Of/0S
 MRfIneAspmyEfC/+Fa4hH4ka1D7X8CXQn16LXLKiX61mEsn/meZwsRk5O2QzdLlz393P
 EAGa8ILHlECj3mbXDrU2DmDK9yNlkAUmE+O9xcQKOi572g5qK98Hx7JgtMKVfw1Bk2fc
 xPQDsP3IqkRBth7NLfs8BQrDEzMJ5h3Xd/jUszcbumGhSud+BlD/lnUaEWDn9I0vN9Xp
 9wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721306855; x=1721911655;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XdDrtQYVI7pRTfjiVCqeFj/FSqkdT7olrHwvukUpSgU=;
 b=hy5mOXzyaQs0t4gZEmojPuJolQp9hSI5akNBoy2IC+zSWJPjA3rePUE2KIgJ1txcQC
 AW9ao4yqur7S+4I6sEbsCcykp+AeECjWKOxPQvjW6q8Ni17NEiKf3w5svxgZ6JEQ8EPA
 u6hE1Ekeixq2f6dHNDM2W3WECtewjJTUlQs9e4dcs86LwgGBuJDnRViv5LO/DFIl1ULy
 B9IXUOvhqO14dbp9wnShh56WVuIzoIhH+B1bfmMM4D7HWxb7B8X6nclPpS++AUT3Ztzb
 qTqdDK1j6JJl0cCtB8TqZ3QgL4EK52Ls0F8AvCz9t3Ub2XjWsyZCygHxJtRaTx6YxPTL
 v+FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOkfc3p6VlqRlQIpoS8BRLphXPepz9oJx+HzaVqefuW6sod1LWE31+2aqJfjvocd1kG3axHvAjkTG0Jcitpb7wnqRTMO8=
X-Gm-Message-State: AOJu0Yx5ngkys4xReY/m+2RPPTRAZaYQGhP7S1h7+V0D+kImcTbjaKPx
 RdZZX++ohMOCi+nLU1fL7ch7kK89gLB/Vcxtn/xJjC+pTxvXIqQ9UMC45990gr1rT318N84RNNe
 pnlTTtKDM1e1DFQE8urVZ3ceGNsUUbE0SY4M+PA==
X-Google-Smtp-Source: AGHT+IFlEazwPiZB9UTeJbZw8vjZNld/o9XaDSliiBOvCmLxSbAnSX0NDNY1z3CtPDZ7zmkSduLxVl2ArvlZrWg/Guk=
X-Received: by 2002:a2e:914d:0:b0:2ec:543f:6013 with SMTP id
 38308e7fff4ca-2ef05c798fdmr16433141fa.13.1721306854559; Thu, 18 Jul 2024
 05:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240716-pmu-v3-0-8c7c1858a227@daynix.com>
 <CAFEAcA92tB_Hf9AcYsnCSfzCu34RDOb1Mxf8QsQzV1Re9aGfDg@mail.gmail.com>
In-Reply-To: <CAFEAcA92tB_Hf9AcYsnCSfzCu34RDOb1Mxf8QsQzV1Re9aGfDg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jul 2024 13:47:23 +0100
Message-ID: <CAFEAcA_WWAe5bL+dJ=hwSKVKY0X=TskyoG8hFtRYgJAbZ_xoPw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] target/arm/kvm: Report PMU unavailability
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 kvm@vger.kernel.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

On Thu, 18 Jul 2024 at 13:14, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 16 Jul 2024 at 13:50, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >
> > target/arm/kvm.c checked PMU availability but claimed PMU is
> > available even if it is not. In fact, Asahi Linux supports KVM but lacks
> > PMU support. Only advertise PMU availability only when it is really
> > available.
> >
> > Fixes: dc40d45ebd8e ("target/arm/kvm: Move kvm_arm_get_host_cpu_features and unexport")
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> > Changes in v3:
> > - Dropped patch "target/arm: Do not allow setting 'pmu' for hvf".
> > - Dropped patch "target/arm: Allow setting 'pmu' only for host and max".
> > - Dropped patch "target/arm/kvm: Report PMU unavailability".
> > - Added patch "target/arm/kvm: Fix PMU feature bit early".
> > - Added patch "hvf: arm: Do not advance PC when raising an exception".
> > - Added patch "hvf: arm: Properly disable PMU".
> > - Changed to check for Armv8 before adding PMU property.
> > - Link to v2: https://lore.kernel.org/r/20240716-pmu-v2-0-f3e3e4b2d3d5@daynix.com
> >
> > Changes in v2:
> > - Restricted writes to 'pmu' to host and max.
> > - Prohibited writes to 'pmu' for hvf.
> > - Link to v1: https://lore.kernel.org/r/20240629-pmu-v1-0-7269123b88a4@daynix.com
> >
> > ---
> > Akihiko Odaki (5):
> >       tests/arm-cpu-features: Do not assume PMU availability
> >       target/arm/kvm: Fix PMU feature bit early
> >       target/arm: Always add pmu property for Armv8
> >       hvf: arm: Do not advance PC when raising an exception
> >       hvf: arm: Properly disable PMU
>
> Hi; I've left reviews for some of these patches. I'm going to
> apply "hvf: arm: Do not advance PC when raising an exception"
> to my target-arm queue since I'm about to do a pullreq for
> 9.1 softfreeze.

...and I'll take patch 1 ("tests/arm-cpu-features: Do not assume PMU
availability") too, since it's been reviewed.

-- PMM

