Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D5DC28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 14:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttSf2-0002g2-8u; Sat, 15 Mar 2025 10:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1ttSey-0002eo-Vf
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 10:38:46 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1ttSew-0005As-KW
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 10:38:44 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5e677f59438so4684242a12.2
 for <qemu-devel@nongnu.org>; Sat, 15 Mar 2025 07:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742049521; x=1742654321; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TVbtizlVjyZk3wsqRuH5bDpwtK5POmwHDxT89XS3p1g=;
 b=FAciDXwsRXut3Ya3N3X1kFANuVk+Bv3e4HSLeQQzQtF8WIq023oW6YzuprVyLcFH/s
 6GsrKKfK479Kpqh8YgGPIcYyBdUK9YI1eoeHjefqqg63C3LAOFnbBIrXLacptCHeUNqU
 UwKeJDnKtR4Qa6J1s3uass8sD4FqfgMf7501A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742049521; x=1742654321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TVbtizlVjyZk3wsqRuH5bDpwtK5POmwHDxT89XS3p1g=;
 b=aE3HL3RDA7SGRZFYHcVLujSVi8/b3R7BRW5pLUkVaRKZV3N2ut2kzvMFQZb9UDd9VJ
 CMhVNsDMw7R+QUY/fqtY5TEQKgwVQVGhFFq1Xoo9spi9gQKRPmajFuGc2IlMnb9A3Z2R
 WnMKxHDPXzAgpnPbHspo97z/DW/wW1yiONEkpSVPUUHV6VBHR5cAAUFqNf931BU4sooE
 ceYqcMOBGGS+5AJpX4e3xODOpS/PjixKta0bYEcrPksJO9nOd7jFyyx0A+G944AtPcfX
 kvSUKhkocDMlGIEAUBcPs6Hmo9Ztcd2ud7aZCy42BcW/p0MJ9luM9BhQz0jLagN7z5BM
 wWtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4+lI8qLdVUPd6/lW9YczbORLQvzd+blPDISHCjOYh7XGeta2yRI8Hvknqi0nKmq5ku2AIVss4m50e@nongnu.org
X-Gm-Message-State: AOJu0Yy/VQ1ItfXxPyLHAKxwNExA0ApvgyfBf4xmvXJpzD3TbxjRHgk4
 MhvIzdHg06oOu2N/9lQy4W+/wnrXTz0D69jth2RYJ5polGe187uMHMg+S3wrOVBjfZrBpCoV5sj
 vyFU8/kdnqei3t8qUbbblSoCxMXExjCVlc2s3
X-Gm-Gg: ASbGncv6YLo8BwVBbpW26LaLdyku+Xm4bfW8Tw0UlTBNJhMbfvw0H7290y3AvnLwh3R
 uF3dhDYeaQS4fncfTtffbDFW08GttH+1IkjcmH4mpu+jbZ1vEVte8mS9aXIcStEzycgqjbn1aIV
 rw3dFDiJdFieoENHYkIi4v2EovDfIheZTryXcRCQ==
X-Google-Smtp-Source: AGHT+IHJaF9e0zV3ssuT+IiVhzCmNBte73n5CcXuKYJjrLmbw2arKls2ZPF9rh5JhvxJGOeh6TDAYLeE7UrzFjB3HCk=
X-Received: by 2002:a05:6402:2793:b0:5e6:1996:7902 with SMTP id
 4fb4d7f45d1cf-5e8a0c0d26fmr6916482a12.32.1742049520664; Sat, 15 Mar 2025
 07:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250306160428.3041057-1-sjg@chromium.org>
 <20250307142255.GL2640854@bill-the-cat>
 <CAFLszTgtYsVQW-kETzUAdvJvAT6fN_53TeoN7o8wu52Ze3u56Q@mail.gmail.com>
 <20250314160652.GS2640854@bill-the-cat>
 <CAFLszTjGV==WftDU6C=S8VB28QJLvFJGS0H3=PKwTCjkZvNibQ@mail.gmail.com>
 <20250315135749.GI2640854@bill-the-cat>
In-Reply-To: <20250315135749.GI2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Mar 2025 14:38:29 +0000
X-Gm-Features: AQ5f1JryOCU1CPd9qV8swCUkqyaT5LDarLbQvIYJbFTEBjjncUyBQewbAE2hkI4
Message-ID: <CAFLszTjEONSErVbE0O5E0+izUDO8yFNZ+hwzvHjvx-nTczzeSQ@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=sjg@chromium.org; helo=mail-ed1-x52e.google.com
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

On Sat, 15 Mar 2025 at 13:57, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Mar 15, 2025 at 12:54:25PM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 14 Mar 2025 at 16:06, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Mar 14, 2025 at 02:44:35PM +0000, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 7 Mar 2025 at 14:23, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Mar 06, 2025 at 09:03:27AM -0700, Simon Glass wrote:
> > > > >
> > > > > > U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but it
> > > > > > is not perfect.
> > > > > >
> > > > > > With both builds, executing the VESA ROM causes an intermittent hang, at
> > > > > > least on some AMD CPUs.
> > > > > >
> > > > > > With qemu-x86_64 kvm cannot be used since the move to long mode (64-bit)
> > > > > > is done in a way that works on real hardware but not with QEMU. This
> > > > > > means that performance is 4-5x slower than it could be, at least on my
> > > > > > CPU.
> > > > > >
> > > > > > We can work around the first problem by using Bochs, which is anyway a
> > > > > > better choice than VESA for QEMU. The second can be addressed by using
> > > > > > the same descriptor across the jump to long mode.
> > > > > >
> > > > > > With an MTRR fix this allows booting into Ubuntu on qemu-x86_64
> > > > > >
> > > > > > In v3 some e820 patches are included to make booting reliable and avoid
> > > > > > ACPI tables being dropped. Also, several MTTR problems are addressed, to
> > > > > > support memory sizes above 4GB reliably.
> > > > >
> > > > > Do you plan to rebase the prerequisite series' this requires so that it
> > > > > can be merged?
> > > >
> > > > Here's my understanding of where things are:
> > > >
> > > > 1. You rejected the membuf series and my replies to try to resolve
> > > > that haven't gone anywhere yet. So your tree doesn't have any tests
> > > > for that code and still has the old naming.
> > >
> > > https://patchwork.ozlabs.org/comment/3473898/ is a well thought out not
> > > gratuitous summary of why the series as it stands is a step in the wrong
> > > direction. Tests are good. They're not a reason to pull an otherwise bad
> > > series. This series should be rebased to not depend on that series. The
> > > tests from the other series should be split out.
> >
> > It's not a bad series, unfortunately. I replied with my own comments
> > and I stand by them.
> >
> > I don't mind if you want to drop the #ifdef (which shows how a flag
> > could be used and the code-size impact). But other than that, I am
> > firm on this for now. I've already applied it to my tree and a membuf
> > implementation with tests and without a power-of-two limitation is
> > important for my current work on distros and expo.
>
> Well, you need to rebase this series without that then as I'm not going
> to take something another long time project contributor said was wrong
> and offered lots of constructive feedback on.

It doesn't affect this series. It is for future work.

We'll see if the LTPC replies to my concerns.

>
> > > > 2. I sent the first part of the PXE series so you could apply that.
> > >
> > > Yes, I should be applying that next week.
> > >
> > > > 3. You rejected the second part of this series because it didn't
> > > > include support for lwip without cmdline. I offered to handle that
> > > > case later but I'm pretty sure you rejected that too.
> > >
> > > That's not how I would characterize it, no. I said you should probably
> > > focus on sandbox + lwip, since you're the sandbox guru and ask Jerome to
> > > do the net_loop-alike thing, since he's one of the network custodians
> > > and the lwip person. I was trying to direct you to where your efforts
> > > might be most useful but if you insist on instead doing the
> > > net_loop-alike part and Jerome ack's it, that's fine.
> >
> > As you know there have been many arguments from the EFI guys about
> > sandbox and you have already rejected my sandbox-focussed EFI-memory
> > series for your tree. If I were actually a guru, that wouldn't have
> > happened.
> >
> > I see that Jerome has created some tests, which is good.
> >
> > So really, you should consider applying the full PXE series so that
> > Jerome can build on that and add support for non-CMDLINE PXE in lwip
> > in a way that you would like.
>
> I saw that Jerome posted sandbox for lwip as well and was pleased. You
> can pickup whatever is left and move forward once both your current
> series and his have been merged.

For now I've just applied it to my tree. I believe my offer of adding
non-CMDLINE lwip immediately after you applied it was a good
compromise, but not good enough, so for now I've decided to just move
on.

>
> > > > 4. This series is now marked 'changes requested' but the only feedback
> > > > I see is in the RFC patch.
> > >
> > > Yes, rebase to something that can be applied is a change I've requested.
> > > Because my feedback was "Do you plan to rebase the prerequisite series'
> > > this requires so that it can be merged?". I would have otherwise merged
> > > it by now.
> >
> > OK I sent a PR.
>
> Eh? v4 as-is needs to be rebased to mainline. That you didn't make it
> against mainline but instead your tree is why this wasn't merged
> already.

I sent a PR for the test series, to try to get that landed in your
tree. At least that will help reduce the diff with new tests. The PR
is the only prereq for v5 of this series (Ubuntu test).

>
> > > Patchwork reflects mainline status.
> >
> > OK. I am finding it more and more slow and painful. Since we are
> > talking about Patchwork, I noticed some patches assigned to me in
> > there, so I've assigned them to you. I'll try to look there more
> > often.
>
> I guess you missed the email where I told you what was assigned to you
> in patchwork and could easily be put in a pull request by you to me to
> get to mainline.

Well let's see how things go over the next few days.

Regards,
SImon

