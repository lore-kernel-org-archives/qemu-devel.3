Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA55C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 12:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sThh8-0000cA-Im; Tue, 16 Jul 2024 08:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sThh4-0000JR-En
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:54:11 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sThh1-0005FH-Ti
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:54:10 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-59f9f59b827so426838a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 05:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721134444; x=1721739244; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sqljEqn1C9apKy4t0qCyw2u/x/yBR1Iv52IL5ilLhCY=;
 b=suOUfdRnh/R8trgJSSDxiCdNE2QIA/WRRwI8Ip1ezlZrXAyOWsKi7tjEJ/ghyKC6jA
 jUE48EXLBxkAVy6jerrM5e2SwVctjUZQqJ+fUzyTXoiJvgoDlynR0YCXmkyYYDgCigzB
 6Vv8/hjIpQ3D4MDfRHbwsZtqjdpLfYpUcOqMPQP/aRK0Yo5pv+X0dBJH+QU/fv+QszHL
 +mioYnxSPjAbjgjtjCzpZQXuqg8uXxIEJSLr+3KgbgY7mm1ccBTRgwEcsyRNSQ1lLskY
 aYseuCC6BhMN9KsKImDAYxwY+lNN96voKUcFIb2Vgr4DImY3FKepnpskDTHjv2+DNbtj
 oPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721134444; x=1721739244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sqljEqn1C9apKy4t0qCyw2u/x/yBR1Iv52IL5ilLhCY=;
 b=qn0GrGGjsIGffBSXv9VGmI3B2Hjg5NB6sb98k7r2gTFjOYQwKbD7bc48MVPe/cvyB5
 Wsd16jZJeO+FzBNSWgXXnoH3zu08InTAsZ+VdKeS5+DKk4tS6yuzdzvlVRhG75gaTAqv
 XbR2/g4JD5s5XVA7NKhuiIIeoC6o7yroPfHKj7oKExF5Uvpo250bDQ84GHdj73L42ocU
 /KBC3PmZlBWE5kJbjr5AmvUcIMWP9gwE0JMxvoCFA2Gxqe2KT47NU7V2Ofm2FtaZiTed
 DDnioqBsaEtLbOJeCI3+c/lOadn9Z6Vo6prcJl5hz5x4yA0XpYe57fTrHgr3DXhKoIa2
 qGwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT4Ib4NsQ0VqvKzkYYhqsJZFaFPx7fviNA+rzWgDSdR91djS3N9LS/glKsVYJcHgyh1SGbI8tgL1HMIcEp87WE0ev0FXM=
X-Gm-Message-State: AOJu0Ywkj3tSFp4ykfKAThD7/yUgPzkZ6aeEZ7kBfBNsySYqUurKUZAY
 u0Pd3hUnCSdvdMgATH6RvE0J5UxFmqvzRvJlblBDBmcUl74zSjGk5PIOZVWl8ss5W9/hfm+1VyI
 9gCGjvyAfGwC62IQzcSSKZmGPeu1XpjP99OEEBw==
X-Google-Smtp-Source: AGHT+IH2Eliu1efySAYYHAHGXrPaDZry8xEgFbC6jwNndsueWrJca5sZiNONC9zsXBngKhCtvNx4kLRoixRPSKjI86Q=
X-Received: by 2002:a05:6402:1ed6:b0:599:73cf:b219 with SMTP id
 4fb4d7f45d1cf-59eef45de4cmr1413426a12.21.1721134444289; Tue, 16 Jul 2024
 05:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240716-pmu-v2-0-f3e3e4b2d3d5@daynix.com>
 <20240716-pmu-v2-4-f3e3e4b2d3d5@daynix.com>
 <CAFEAcA9trFnYaZbVehHhxET68QF=+X6GRsEh+zcavL-1DxDB4w@mail.gmail.com>
 <cdd5ce60-230f-48a1-bcf3-9591b8bede95@daynix.com>
In-Reply-To: <cdd5ce60-230f-48a1-bcf3-9591b8bede95@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jul 2024 13:53:52 +0100
Message-ID: <CAFEAcA8qN3X2yaBjth=1a7kUCmYY32Ho9nG5e2tiL21QCw1DkA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] target/arm: Always add pmu property
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Tue, 16 Jul 2024 at 12:36, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> On 2024/07/16 20:32, Peter Maydell wrote:
> > On Tue, 16 Jul 2024 at 09:28, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> > Before we do this we need to do something to forbid setting
> > the pmu property to true on CPUs which don't have it. That is:
> >
> >   * for CPUs which do have a PMU, we should default to present, and
> >     allow the user to turn it on and off with pmu=on/off
> >   * for CPUs which do not have a PMU, we should not let the user
> >     turn it on and off (either by not providing the property, or
> >     else by making the property-set method raise an error, or by
> >     having realize detect the discrepancy and raise an error)
>
> I don't think there is any reason to prohibit adding a PMU to a CPU that
> doesn't have when you allow to remove one. For example, neoverse-v1
> should always have PMU in the real world.

For example, the Cortex-M3 doesn't have a PMU anything like the
A-profile one, so we shouldn't allow the user to set pmu=on.
The Arm1176 doesn't have a PMU like the one we emulate, so we
shouldn't allow the user to turn it on. All the CPUs where it
is reasonable and architecturally valid to have a PMU set the
ARM_FEATURE_PMU bit, so there (by design) is no CPU where that
bit isn't set by default but could reasonably be enabled by
the user.

Conversely, the PMUv3 is architecturally optional, so it's not
unreasonable to allow the user to disable it even if the
real-hardware Neoverse-V1 doesn't provide that as a config
option in the RTL.

thanks
-- PMM

