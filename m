Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83928D5E368
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kwy-0000o1-3V; Sat, 09 Nov 2024 07:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9kwv-0000no-I6
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 07:52:21 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9kwt-00012g-GD
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 07:52:20 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a99fa009adcso189153666b.0
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 04:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731156736; x=1731761536; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8VhMlyb1PEfm6xmMm/ce+z6MJGnI6NIJGXv2xr/3Nc8=;
 b=u9BhAm290eFD2/VdX6VhDZxnWEadsHATANz5aQMMB1P52JfhLS7QEAWWVe0xW8TXIc
 AaY6Ii5MP8gojm46vobR0qWpDq3qIMD8oln4OwrFwNUm/Tnl2Aj4MGuy4CogN5Cx7l2I
 NQT2B59BMQ2cQERpi3Cuql9tcnwBTb607xeXaW8KHptwi629ceArDc69kzHGm1Futxxr
 A+QkWFNlJo5+P5ULbFgv9bge5Tv8b7/M9A6qMZvj0m4RGbRzWrOPy9WDnRS6u2ft+m0F
 S0hbCOJCGgM9NoOCtVE16FtXnEc/brDVufN7zRbK4kMh+nUFm6/1XpYQto6/J/ekIMLd
 3Yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731156736; x=1731761536;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8VhMlyb1PEfm6xmMm/ce+z6MJGnI6NIJGXv2xr/3Nc8=;
 b=MfU7QJwcNsNWG8TFEssx6zbGOorypenoq7C4lHegBlrM450tntBhG/CNVmtiA8op4e
 4oVZw/9F++oFdKFrWXbU88rExl5tiQfa2ChZtm63W0nb6Lt5N04DeQZ3yW2paCnmirD0
 TrPGYoIiG0uxR85St5wv7+PD3sW1DMUJbLQFf1rkYf8FXGMxoEKAVqRRgcXM/2X06yYq
 A9UUA//3kvQ845q1eteVIpJ/NGQCto5Iwwe1fG+7hED17y7IuN2CiscbyD4U1aQYcv/a
 CvfEsDL8CQB/IDMvnzmu2R+yh3t4YEiJjSn3cttyHxLOLf1LY9KC5JH7Rx78I95ID0Xh
 7rBw==
X-Gm-Message-State: AOJu0Ywt5Ah+laXk2O31kB6Aymnn+/kmTVw0v+MaYzFTlba6b3XZZYY+
 KRiWiKdXP08rRtVONypxjx0GTEjnlYPgejbklkrIqGTSusypTEmF6XK5Ofyc4GbAXsVT/LCu5LJ
 94lrP7tYB98lmYATkmkVu7hOVsBB7OkMO6RruEg==
X-Google-Smtp-Source: AGHT+IFTWyPUilgZQszjyRxOtIPHJhpabvLqiRiBBTzY/qTIx5ZXNa2BonLg0AO8nh6DeSef0Pq7U7c24Ufs1eXzWQg=
X-Received: by 2002:a05:6402:1482:b0:5cf:14fa:d24d with SMTP id
 4fb4d7f45d1cf-5cf14fad2e8mr5225851a12.22.1731156736109; Sat, 09 Nov 2024
 04:52:16 -0800 (PST)
MIME-Version: 1.0
References: <20241109073555.162151-1-pbonzini@redhat.com>
 <CAFEAcA9+7h6naG2zCGPu16Yxk+Xti95WwnR6N1HBcfv80Fv8xA@mail.gmail.com>
In-Reply-To: <CAFEAcA9+7h6naG2zCGPu16Yxk+Xti95WwnR6N1HBcfv80Fv8xA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Nov 2024 12:52:05 +0000
Message-ID: <CAFEAcA8i5VYWkf44R8-XTrkUdRHBtRtctMMp9nYKR=5RrmPeNA@mail.gmail.com>
Subject: Re: [PULL v2 00/13] (Almost entirely) bugfix changes for QEMU 9.2
 hard freeze
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
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

On Sat, 9 Nov 2024 at 12:35, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Sat, 9 Nov 2024 at 07:36, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > The following changes since commit a1dacb66915eb7d08a0596cc97068a37c39930d3:
> >
> >   Merge tag 'for-upstream-rust' of https://gitlab.com/bonzini/qemu into staging (2024-11-06 21:27:47 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/bonzini/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to bd0e501e1a4813fa36a4cf9842aaf430323a03c3:
> >
> >   hw/i386/pc: Don't try to init PCI NICs if there is no PCI bus (2024-11-09 08:34:07 +0100)
> >
> > ----------------------------------------------------------------
> > * i386: fix -M isapc with ubsan
> > * i386: add sha512, sm3, sm4 feature bits
> > * eif: fix Coverity issues
> > * i386/hvf: x2APIC support
> > * i386/hvf: fixes
> > * i386/tcg: fix 2-stage page walk
> > * eif: fix coverity issues
> > * rust: fix subproject warnings with new rust, avoid useless cmake fallback
> >
> > ----------------------------------------------------------------
>
> Hi -- just a note to say that although I've just kicked off the
> CI process for this pullreq I'm off work for a couple of days
> at the start of next week so I won't be able to actually merge
> it to master til Wednesday. I plan to do that before tagging rc0
> (which I will also be doing Wednesday).

PS: feel free to keep an eye on the pipeline and hit 'retry' on
stuff that looks like the usual intermittents due to k8s
or s390 flakiness:
https://gitlab.com/qemu-project/qemu/-/pipelines/1534706168

(one of the container jobs just failed because docker.io
gave a "429 Too Many Requests - Server message: toomanyrequests:
You have reached your pull rate limit" error but I'm assuming
that's an intermittent...
https://gitlab.com/qemu-project/qemu/-/jobs/8315557677 )

-- PMM

