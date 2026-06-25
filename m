Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93605CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:03:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wckfZ-0003hT-H3; Thu, 25 Jun 2026 10:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wckfV-0003gr-1r
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:03:01 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wckfR-0006AB-3L
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:02:59 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-662c360aa73so2441182d50.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:02:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782396175; cv=none;
 d=google.com; s=arc-20260327;
 b=KHHvczoF2Jv3zP94vPPcMeWSAdXl8nwbIuqISC0NCPplDvUB6vPPg+pl1ycauj/K8N
 YAP5Ly5CVSz3vw9KIka6ZrDdL2BWEv3DiXdDHw/kHH9QOlBFtS31nMovhlbRRUdu55X4
 /59hrgtiIrGT/6lCPAv9Dql9aLDbI/CA59F4KV++w/7H9vvpbSr6AjO3IEIlFJ00X64Z
 73HHhKLRwSb+b+Q+ghyqFkWXOMT9p3bUv/GHIsMUSHrLBJkM3POpSgrV1FK6cmA70dX/
 n40Zz6Wjgfa/N26OCaeLrfF6dVWgklD3LBn/jiuPspe14NFUpRwOYqF+CpWXogaXyYKF
 CxVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DYEqZxqgzUw2voQpVHyMaVq9iZjwv3lkabsgdLeERQ0=;
 fh=MXNBF9eTN0L5U8SKz17QWq4Ulc0nUK7lIjIvEuC8VY8=;
 b=BU4BGS7TerQsX1+OlxoSmcKDtq3ffeSpfx12s0Q2stF5P7u1bC5ImfIxEroXKoB9Vh
 QkWhg7zp8sQ5Najft5GfUFktthAJ72F1tDTJiCZLnMqkY0nWbvvFwQmnt9LRKv+jt+kI
 KFdeBALH42AgKJimY18cKIeZDMWo/UV2PEXA0xKSKdWJXXl5Lho/DB6pcLaQrIgZpo4O
 RUCHXlitQnySprmNeyIyGv0StAHbQVY6Htie7CY0r3e4Hx8HFCbe1r8HDvYGTot8j+5D
 ttFURTbiNsExPb3MOUKqOBp2AmpNRV+0ugvS+I3/JHr5dLj2fUwFoYluI5U06rwv4VbZ
 EZSg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782396175; x=1783000975; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DYEqZxqgzUw2voQpVHyMaVq9iZjwv3lkabsgdLeERQ0=;
 b=bINEAo5DoVartzyUheJmywUqsBDi/QgjW+G/i+fED1S1d1xm5vGRI2DiKOABmf2iKi
 kZ9vo0SGmWeog9VaAJaHQ+vl1CD/RKKyR+iMIXZVkpN3sTNT27qYGG/IN3rTfEVs5aqk
 yq//jytUyhmy1YEranON+hM05fgHW7ixg3JsZgM+nKhh+TR4gZboBCbhJYIlNpyOmwTC
 TqkTs3YKYqAvnqguqLQPXkl4wAegL7T0LqGeTU3bU8t7bUdoKGMzBDGFei2e8+D8H07H
 SLtHFjARjc+bqacz8h5aLebw9Zs2kAOka+evbwG+5ofNVPBpCcxGBgsLSrDs2Q27wnfd
 pXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782396175; x=1783000975;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DYEqZxqgzUw2voQpVHyMaVq9iZjwv3lkabsgdLeERQ0=;
 b=FXQogY2SV8kwa02j/YAi+vwZEdr7O7pfiCfsGKYtcRN6W7V1kJXQzD7FcyhZHaYmhG
 20sY8OmZ1gPZXFWwzthFowIPVrRqLw8Nu2L6sgl+E0jEjAlbPNiP58QO/z4ssu78dwRu
 ff4Noq6caNPKT3WCmJ9SZ2J0zIBSFCgiF/wICGyIoZ1IJ1+BGOoWrFc5O4feO1Lg1ZLz
 EB0nhfx3GfUA1MtLe+srFIdpjewuCN2m8HyI2b3isIzGGIF3OsdgdpV2zHyUbEZyfPwF
 kKV9TBejc252lVneoMPrYOM83y3cLpYlltpipdwAvB3+W2ow8WzvLNJttrwTsHCf65Bu
 bQxg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqH+wDyUs39uL1w8rr+64LbNGoCeiD2OgZTwZfjwV1TZpGYWTyh2WgCzujFgtJMpW6vXmTXZICXuw0B@nongnu.org
X-Gm-Message-State: AOJu0YyWFtGkHEjZGUoKKnTsEB8UjPidPhIW2uR1+zlypYIxFqPGi0wg
 Kf0Y/u43D6ZYCsjZVR78X0lDft3GecLahlAuvfq41TPMudmbGg+uYDDP/aawboxrTFnwuSyxLky
 7JZFAzxmEWxhbIcifFYUv1ZKF7qoWdUHQHF0vsNY3Yg==
X-Gm-Gg: AfdE7cl9ykfGy1wZSnkDVwj7iH0fba2gzEF1Ujacy2tDV4eOz535nrPf5UNvsg+vJ4+
 S3zjCaZ3WY+o7UFQpUSesJ6Q+SlIdIjbF2jgb3PMKvGmV1au6x0VPvDJVbUODpgQ6wjkbGszPzM
 JUuD+QsUFXNDMvUUARqK7JofPjXsi7yEOuAk/j9k81YloN5m+UWXgIzBAcrwJXOegTz20insOFC
 Jg+v1NqHC4dUgd77a8tfnjhRPctXVDxzpuPpK1WZ1tc3UVs6W2tZnfUJ3eYq83lfmJyPZCvG7jp
 QLWvSfdqdvsjPfeSDW5N9vwcOQecI+o2M+GdduBlxJ3uUE4zYEFWerbP
X-Received: by 2002:a05:690e:1443:b0:664:8e4e:6709 with SMTP id
 956f58d0204a3-6648e4e6a65mr1121989d50.7.1782396174493; Thu, 25 Jun 2026
 07:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260616052552.389021-1-gshan@redhat.com>
 <20260616052552.389021-2-gshan@redhat.com>
 <CAFEAcA-mf14=jpRFHarAbN6AbQwvW=Yu6WB1JiNMsECEdaxD3A@mail.gmail.com>
 <20260625070551-mutt-send-email-mst@kernel.org>
 <CAFEAcA8YJZq9TqrUd0zTnewAdVDm5y6UV7BJQZ0C60TZ=RT98Q@mail.gmail.com>
 <20260625091334-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260625091334-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2026 15:02:42 +0100
X-Gm-Features: AVVi8CeDStepglKbBtTEBQFKemwSayNCNcWYPpFnhlOw47hiL4XCycHAGem_uaQ
Message-ID: <CAFEAcA8xK+t3-prEphtkq-o9UY2mgS6cowhs880GOaxL9dKSGw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 peterx@redhat.com, alex@shazbot.org, richard.henderson@linaro.org, 
 berrange@redhat.com, philmd@oss.qualcomm.com, philmd@mailo.com, 
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com, 
 jugraham@redhat.com, liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, 
 shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Thu, 25 Jun 2026 at 14:23, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jun 25, 2026 at 01:48:11PM +0100, Peter Maydell wrote:
> > On Thu, 25 Jun 2026 at 12:07, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Jun 25, 2026 at 11:09:26AM +0100, Peter Maydell wrote:
> > > > This is still wrong. We should not have "x86 magically works
> > > > and all other hosts do something different" ifdefs. Define what
> > > > semantics you need and then we can figure out how to
> > > > implement them.
> > > >
> > > > My current thought is that we need to handle accesses of
> > > > 1, 2, 4 and 8 bytes that are naturally aligned by ensuring that we
> > > > do exactly one host load/store of that type, and that anything else
> > > > is "the guest isn't relying on specific semantics here, we can just
> > > > assume it's plain old RAM and do whatever". That would not
> > > > require any architecture specific ifdefs.
> >
> > > Well. X86 is special, as usual. It allows unaligned mmio so
> > > we really have no way to know an x86 guest does not intend
> > > just that. That can only be emulated perfectly on x86
> > > which is sad but I see no reason to actively break it.
> >
> > What actual hardware will rely on unaligned accesses
> > appearing to it as single unaligned accesses?
>
> /me shrugs
> any hardware that was only tested under windows?

I seriously doubt any hardware designer implements
registers that are not aligned, especially on PCI devices.
"Only tested under Windows" doesn't imply "hardware
designer did something nuts".

> > And if we do need this, we need to specify:
> > - what are the semantics we need to provide?
>
> match what happens on bare metal

This is too vague. We need to write down what we mean,
in enough specifics that we can then say "OK, we can
do this this way", or "we can do this this way on
some hosts, and these corner cases are not covered
on other hosts".

> > - what is the use case that relies on these?
> > Then we can see how closely we can match that.
>
> passhtrough of weird devices, first of all.

This isn't a use case, it's a vague hypothetical.

> > There's a lot of extra complexity added in here for
> > something it I don't think is ever going to matter,
> > and having the most common host architecture take a
> > totally different codepath from everything else is
> > a recipe for that other codepath breaking.

> Not sure we have to be pedantic. We have arch specific code and the
> world did not end.  It's not a lot of code, it's just for unaligned
> accesses on MMIO, which might or might not be broken anyway.
> And it worked already, so it's more about going back to what we
> did earlier.

But we should not have arch specific code unless we
have a reason to do it. And if we have a reason to do
it then we should say what that reason is and what the
cases the host has to cover are, so that when we can
implement it correctly we do that.

-- PMM

