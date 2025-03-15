Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0897C28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 12:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttR2V-000816-Bl; Sat, 15 Mar 2025 08:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1ttR2H-000805-M2
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 08:54:43 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1ttR2F-00023Q-2j
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 08:54:41 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e6c18e2c7dso5219630a12.3
 for <qemu-devel@nongnu.org>; Sat, 15 Mar 2025 05:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742043277; x=1742648077; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pnvnH8wVO5qHVr2rZFQVhxu42KjZs1lkGcg4CXpA0S8=;
 b=A6ETj7asFi8dh8lr7MndhDqcKK90GzDrWFR221mK/WadW3a+YMXZc4tbrXqJzl32s3
 ixyS1o7eSaU5x1f2Na04Ya1JAdw06FTz8k2StnORsSS+hSF6v4UgI/cyCfnCb+laCvyG
 riJcx6a9D4/GLb1AaDJcCcWa/Q6kijaPNLPMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742043277; x=1742648077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pnvnH8wVO5qHVr2rZFQVhxu42KjZs1lkGcg4CXpA0S8=;
 b=c/M+ywNc5DteveCeaE1ok0XnYD/Wv3x1ePIfBc4k3Wjr/w+f3Ccu9Mg+Z+0Dv4RRcT
 LzfnHYGMTzVvHe7vR2RahUXeWxKTYpFoXEtfQ1EdSPMv/4k1oVIVzeOPpNQthsTcqvrX
 Clqfx4O8ZcahXjQ3fdNKMSOOGhWDkUMBctPvm0XzdGvEeiiJo85Rr4V6NrPv7uWppLtb
 fJlfCm4Dc5T+Gb84+j0AK4a6DCIApD8I/7DnLRX6mUEpw+faIoEeYmXFDALYcWQ8sGCZ
 yKGJpuPe3sYLAmjB1TWpr3mRBMwxHCqAZUCZCEpOhHEY4FV+8HKv735Lsc/cjZ9cfo8L
 bw0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+vVXd5UEb0INQHMDNFTiwk0BURFi2lC8KqG4QREeh/ItiGq9IVXXnjIrGZHXnIsG2Who8RXaWL4wZ@nongnu.org
X-Gm-Message-State: AOJu0Ywrb6Vu6qhETXahTAfizbZKB8mXai2XxnU04P5QKOZporEdIA6b
 a/vaDLMMcqVBlBjnzqgrDIe4Z3dApMtm0eWem3n0fFnwKeOzzSEke1eFotWGh5yLnMeGnqcaJoY
 vQcsA7FS1C31Th6b3DSP/UIdn+zW2W5NWMHQd
X-Gm-Gg: ASbGnct2PfA1DuedrO4+Klu/JIJ1mR+kkFIRcGqqOujyhmQ0JzzeJcrjMXqDPL15ZTy
 0FTHdh1CcjZhtNDje+ruAQbFFMFX9gOaEA0ynOU4ND9wX9n7o74IV40Tq5A/T81ZJaYhrR58N8V
 m2LAlKRcJEGKxIUsH5fa3c7Tp0rSU=
X-Google-Smtp-Source: AGHT+IGHtf/RIdoLdPwNDeUFMCRzB2uZlLj6Fl+EBeeS/Dq58EqE3BXSNRTnmEwdzYxqbtin/vSy0XdXkTatKYRh1Pc=
X-Received: by 2002:a17:907:94c7:b0:ac2:1c64:b0a with SMTP id
 a640c23a62f3a-ac3301940d2mr573914966b.14.1742043276881; Sat, 15 Mar 2025
 05:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250306160428.3041057-1-sjg@chromium.org>
 <20250307142255.GL2640854@bill-the-cat>
 <CAFLszTgtYsVQW-kETzUAdvJvAT6fN_53TeoN7o8wu52Ze3u56Q@mail.gmail.com>
 <20250314160652.GS2640854@bill-the-cat>
In-Reply-To: <20250314160652.GS2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Mar 2025 12:54:25 +0000
X-Gm-Features: AQ5f1JqMTvq23AjX0FBIPqJObIJ2yxF3ERff3cPnP9UqG8sdu7lJiadJYaX85z0
Message-ID: <CAFLszTjGV==WftDU6C=S8VB28QJLvFJGS0H3=PKwTCjkZvNibQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/47] x86: Improve operation under QEMU
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Angelo Dureghello <angelo@kernel-space.org>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, 
 Julius Lehmann <lehmanju@devpi.de>, Love Kumar <love.kumar@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Philip Oberfichtner <pro@denx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Richard Weinberger <richard@nod.at>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=sjg@chromium.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Tom,

On Fri, 14 Mar 2025 at 16:06, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Mar 14, 2025 at 02:44:35PM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 7 Mar 2025 at 14:23, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Mar 06, 2025 at 09:03:27AM -0700, Simon Glass wrote:
> > >
> > > > U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but it
> > > > is not perfect.
> > > >
> > > > With both builds, executing the VESA ROM causes an intermittent hang, at
> > > > least on some AMD CPUs.
> > > >
> > > > With qemu-x86_64 kvm cannot be used since the move to long mode (64-bit)
> > > > is done in a way that works on real hardware but not with QEMU. This
> > > > means that performance is 4-5x slower than it could be, at least on my
> > > > CPU.
> > > >
> > > > We can work around the first problem by using Bochs, which is anyway a
> > > > better choice than VESA for QEMU. The second can be addressed by using
> > > > the same descriptor across the jump to long mode.
> > > >
> > > > With an MTRR fix this allows booting into Ubuntu on qemu-x86_64
> > > >
> > > > In v3 some e820 patches are included to make booting reliable and avoid
> > > > ACPI tables being dropped. Also, several MTTR problems are addressed, to
> > > > support memory sizes above 4GB reliably.
> > >
> > > Do you plan to rebase the prerequisite series' this requires so that it
> > > can be merged?
> >
> > Here's my understanding of where things are:
> >
> > 1. You rejected the membuf series and my replies to try to resolve
> > that haven't gone anywhere yet. So your tree doesn't have any tests
> > for that code and still has the old naming.
>
> https://patchwork.ozlabs.org/comment/3473898/ is a well thought out not
> gratuitous summary of why the series as it stands is a step in the wrong
> direction. Tests are good. They're not a reason to pull an otherwise bad
> series. This series should be rebased to not depend on that series. The
> tests from the other series should be split out.

It's not a bad series, unfortunately. I replied with my own comments
and I stand by them.

I don't mind if you want to drop the #ifdef (which shows how a flag
could be used and the code-size impact). But other than that, I am
firm on this for now. I've already applied it to my tree and a membuf
implementation with tests and without a power-of-two limitation is
important for my current work on distros and expo.

>
> > 2. I sent the first part of the PXE series so you could apply that.
>
> Yes, I should be applying that next week.
>
> > 3. You rejected the second part of this series because it didn't
> > include support for lwip without cmdline. I offered to handle that
> > case later but I'm pretty sure you rejected that too.
>
> That's not how I would characterize it, no. I said you should probably
> focus on sandbox + lwip, since you're the sandbox guru and ask Jerome to
> do the net_loop-alike thing, since he's one of the network custodians
> and the lwip person. I was trying to direct you to where your efforts
> might be most useful but if you insist on instead doing the
> net_loop-alike part and Jerome ack's it, that's fine.

As you know there have been many arguments from the EFI guys about
sandbox and you have already rejected my sandbox-focussed EFI-memory
series for your tree. If I were actually a guru, that wouldn't have
happened.

I see that Jerome has created some tests, which is good.

So really, you should consider applying the full PXE series so that
Jerome can build on that and add support for non-CMDLINE PXE in lwip
in a way that you would like.

>
> > 4. This series is now marked 'changes requested' but the only feedback
> > I see is in the RFC patch.
>
> Yes, rebase to something that can be applied is a change I've requested.
> Because my feedback was "Do you plan to rebase the prerequisite series'
> this requires so that it can be merged?". I would have otherwise merged
> it by now.

OK I sent a PR.

>
> Patchwork reflects mainline status.

OK. I am finding it more and more slow and painful. Since we are
talking about Patchwork, I noticed some patches assigned to me in
there, so I've assigned them to you. I'll try to look there more
often.

Regards,
Simon

