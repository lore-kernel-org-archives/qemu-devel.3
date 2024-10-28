Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B9ED3399B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 16:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Sr8-0004br-JG; Mon, 28 Oct 2024 12:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5Squ-0004av-5G
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:44:26 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5Sqs-0001aq-Js
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:44:23 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5cb6ca2a776so6079147a12.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 09:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730133861; x=1730738661; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KVW3ua7sJWaIAit3EE0t5f2qivxeSre5gEdtobhzZ2k=;
 b=tp/STJCaOIGW7QQK0FIcuSH+adi8/yFjgqxrRn/JUhteqf0yUlx+dNzXmIUk0RI3YV
 ueSU9P/7N+Ukiyp+zZ7Nvzoi1s4qH5uBHjflJnDs416w5zHb5fiTttHczFEFZQX3fa57
 i3p4Baf1tw14xPaS3z1Zg0GPtbR6pUgCSfITkG19LUN7yKhF/gr6ZvI6cPJMVDDxCYuA
 ZUWCKSfOf2PyNc12sN+Zwv1rxDHUW1kF/Vsg7c1MRoYBAU+x+8APwHrGWqRepQA0yesz
 iFoV7JPwg+P1kCSU0AkNnbDz6gObE2e4eo3gmhyEh+fKwCAEltUecWtcKunzX0BBb5xx
 mPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730133861; x=1730738661;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KVW3ua7sJWaIAit3EE0t5f2qivxeSre5gEdtobhzZ2k=;
 b=KAsT/MFVjy9e2A1KMR0gqLKpp38d7rcg2Nb0PxI08Ci+iZRgJXez8VRkjcY10trJCH
 pxjQdRypBpDXp9R58pWsLk7v9m6s5REHeyBIHPvRD4gkj4VFVdvofJ0S9ZxqHXkUfmjX
 5YrnfHhvM9cMTNpXgCmSKpX80fTvoq49BQNAbqZN0TLy/y+hxHLKIYOs6YaPf07pICBe
 LLtL6P5lG6EW0Qa3rfqTLk9KivYIwxRtKNOzKuMCItA0McFeaGFWoT6NOEJrX9dygpAb
 24/INvdeVzhlwV2IsWfNIu2jloFmrziGUbJFya0kI8ZmINFQ+uVAl9aHDTHDVqMXOzic
 IQBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoN12AxJlGBbcMdBvLWiRlIWypYN7MFEeQrTiqEMtvmxDd/n8ZrAmu9nwcol8kdKGZq+prGyK8ED3T@nongnu.org
X-Gm-Message-State: AOJu0Yxs3rtUUizkq3aNHslaQqQtt5gerYmsu/37B1qiJYDBOXJ+6H8H
 hJ9nKFHdj9EN1kDdkf5oCfXLglPZTmnJgtMp2rjcg1OQsSEYeeRBkWUyXjD/fjTXBXf9saKvMym
 lVyacTA85OR63U/Pc+ii3JuiwOxyRpCiyjYxykg==
X-Google-Smtp-Source: AGHT+IHibvVnzv7R808yofL15SsQp9qWs+wpjwny1r44N3Tr9WhPaNu6tWT/+u4yguYgNE3Vex7W8x8V7/yGfguoMx0=
X-Received: by 2002:a05:6402:34cc:b0:5c8:8bde:a1d3 with SMTP id
 4fb4d7f45d1cf-5cbbfa548b3mr7619120a12.22.1730133860747; Mon, 28 Oct 2024
 09:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <ZxuwZw2plMI6dNyE@pinwheel> <87v7xcnqrs.fsf@redhat.com>
In-Reply-To: <87v7xcnqrs.fsf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Oct 2024 16:44:09 +0000
Message-ID: <CAFEAcA9qqGMduMC_yXm5Jzbpfy0RVEPkxMoN4q72japiHfRCsg@mail.gmail.com>
Subject: Re: [RFC 00/21] kvm/arm: Introduce a customizable aarch64 KVM host
 model
To: Cornelia Huck <cohuck@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 eric.auger.pro@gmail.com, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev, 
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 oliver.upton@linux.dev, sebott@redhat.com, 
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com, berrange@redhat.com, 
 abologna@redhat.com, jdenemar@redhat.com, shahuang@redhat.com, 
 mark.rutland@arm.com, philmd@linaro.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Mon, 28 Oct 2024 at 16:20, Cornelia Huck <cohuck@redhat.com> wrote:
> On Fri, Oct 25 2024, Kashyap Chamarthy <kchamart@redhat.com> wrote:
> > (b) The current CPU features doc[2] for Arm doesn't mention "host
> >     passthrough" at all.  It is only implied by the last part of this
> >     paragraph, from the section titled "A note about CPU models and
> >     KVM"[3]:
> >
> >       "Named CPU models generally do not work with KVM. There are a few
> >       cases that do work [...] but mostly if KVM is enabled the 'host'
> >       CPU type must be used."
> >
> >     Related: in your reply[4] to Dan in this series, you write: "Having
> >     named models is the next thing".  So named CPU models will be a
> >     thing in Arm, too?  Then the above statement in the Arm
> >     'cpu-features' will need updating :-)
>
> The currently existing named models are for cpus like cortex-a57; you
> can use them for KVM if you happen to run on a matching host cpu, but
> they only really make sense for use with tcg.

Note that those are a relic of an old and quickly abandoned
design direction in KVM for Arm, where the idea was that
userspace would specify the target CPU via a KVM_ARM_TARGET_*
constant (initially only permitted on the matching host CPU
but with some vague idea that eventually KVM would emulate
the specified CPU type on different host CPUs also)
On the QEMU side we feed the KVM_ARM_TARGET_* through for the two
CPU models we support in TCG which also have a KVM_ARM_TARGET_*
constant, which is to say Cortex-A57 and Cortex-A53. But none
of the other named CPU models QEMU supports for TCG have that
kind of constant.

Presumably now that KVM supports "pass the guest ID regs
that don't match the host" we would want to support our
existing TCG-modelled named CPU types (for which we
already know the ID register values, for TCG) by telling
the kernel what the ID register values are.

thanks
-- PMM

