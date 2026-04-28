Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE87FF885D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 09:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHeQG-0004qy-9Q; Tue, 28 Apr 2026 05:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHeQC-0004q9-Rc
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 05:08:02 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHeQA-00064T-LP
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 05:08:00 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-65492d097acso4265459d50.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 02:07:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777367277; cv=none;
 d=google.com; s=arc-20240605;
 b=TAQbIGZ4vaZ9nsP0Yclb5K+phYe01+hgDW7mIwcqB+rup+IHvluaFQawgAJzFpQiQD
 b6aqWhvxGrOgFDRulsyd3rbPjsBNvRQMX+3TXwqNpVSry+y92TxnK5BAodaFr+zShbNu
 +e2Ne7qpXJh5S25DXfQiYHEf8PPDthPtoLIB+kzU8/ZPDzTL6AuscAgBbofxIY49U1vu
 IOAhicTWT59lThAXyysCYXdp7pVroC1zOJQLdcOQECYwOJ7k+peaFhfHAeMgy/6dRD0k
 DRW3+D7XNe13Qk+GbUPn9Jb+9ZdJ2U9VpyWGTX225hgwtNvHniP4h0WL4OJopoH/gDad
 gKKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DThF0XUL4dy9R6fRsfQztI3lmJ5+02kga/scEtudiAs=;
 fh=3Nd3mw0zDQF5Tv/7iMILd31jXeg5H2sRXNpFJQZKP5Q=;
 b=jNJP09NxiJgiawIYS3f66WJJvKUiobsG4P43ET8zCMHwUWuTMSg9xYDj50NamtrHSe
 cF5I+uYKbZvGrEslgMZmRl6hHzhgTULZxYS7zOAyvFZvadrPJWSpmhy9+KZzwRnmaOz1
 bFSdRFB4lnn1U63X+3Qzaawd3iA6G495HauxRGWYILNQZBCfL7jxRHfcsL61RB7g0DMV
 X/5t69i7ZQ7IiDoH/llv0meWEdC3awnFFw1mkbnssVxXzNLQbe6C0boLRG9dbmizdJTy
 pD5bgok2LR0x8Di7+hpl8hiUNv5kmWWMa/LJO+Q4Vpv8HoVApG57Ms91Qhuv5pJQD2wH
 X+Ug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777367277; x=1777972077; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DThF0XUL4dy9R6fRsfQztI3lmJ5+02kga/scEtudiAs=;
 b=Ba7XyxvtssUcifAhCHTNjymztDGxM+isa02pVd1I7I1K+Rc0CtJcTPzG3Y7Z00vcKH
 PZIVZZ9dSPdo7XDv9f/uVJE3N48RJPCASv668cSEreko/K+vkmLN7r1UBkF1zQZy/zVb
 51y9/KpKcdn44SzH1PhqZOM6Onniq/oXstPaWhrNpyhIn1HHiQKPwUxSWJQu+XZBaZIS
 a3nyM0asmGQGGWVge/3T2/A2XRkfQbdnNZo0Pmbg0OrMDunGoHaRwIJHfLwqRWRGxHUm
 8ke36JIWJP6QDN0QjHWDvgo6LA6bCpd/tFZw4Yo7+G78md6kKOWooDP3IQ76UG6mVu9i
 r98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777367277; x=1777972077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DThF0XUL4dy9R6fRsfQztI3lmJ5+02kga/scEtudiAs=;
 b=RrvnzHvYepfC/eDg6Ueqe8fsi7+vR2enswFfj3l3hTGi+DgW4ulzANsSchRs5HDUNK
 VimASDvrVBuj6lB1LvwJCqsiojrY72z2q7UNENFc9xsKfP5+X+FTu/HjndnOu/GwRoZ4
 hkoQ3hfZV7E2/Ew3grM7CPmX4cJWc2YlBYOmKlBeCsz7Dh3b+rgpj3xj5gnNI3ZABfkx
 MErWaV3t4maq2AOKKNj1anr0FKHB5BzhnsVBgZrEVL4SJWqXzcxZG/2XZMA1NKTBvJ4T
 0PcPM5bCfiSENiFKbPOZgZHvZ/vwdjrJ6xTzUDMbAqsA5bxwUFCnMXcmOEhKldpCKTDC
 wq/A==
X-Gm-Message-State: AOJu0Yw7SYZD9chtLyDO4dnyGfFm2fk4KHMMTicbYoF4Z3MhAPMKV9YQ
 EBPPwY5gk58XrdITkC8DCkrbQoEfLvc0TMjMczMDsIW17nGkLXAs79orvJCHg5FBDCgFIicOcIF
 d54sWJvAYcXu6dIltiqNnDp+mLfOUZ0uRVMQQzvq0WBNgfBzvk/9y
X-Gm-Gg: AeBDievxhcVjjRXZgp1F33yurJ6626KTlk4JVD/cHreFHeQnoyH1hXDeMcc8SX44XE1
 BP9qco8OGwNu/88oh9HMjiqCYx9B7tm6jkeTgtBIgSxelMd27rYeFHl7JCTRjc1ZnYioCTycUH4
 VteSxnT+n5SjrD/ewo574I3x0bWfxYWMomfTzzDHa8kZXIcoURCI+QLwjiWRIbljGE0/IyPW3uS
 AEqoh/gIqSmiimjvWKMG/n/HIiJ5ZYOtbirbbe6WhNLECC9BzEKWzEHE1F8E930lleySv0PLxp6
 CPUx3F558R46G9+vBkoMJILJOtFPLYqSCNTtYdnQkm6o0VlnGOiUHfVMIDFoZLaRvOHt7wuxviN
 Qcw==
X-Received: by 2002:a05:690e:4808:b0:653:f72:f482 with SMTP id
 956f58d0204a3-65beed7c943mr1462369d50.22.1777367276912; Tue, 28 Apr 2026
 02:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250822092410.25833-1-cjchen@igel.co.jp>
 <CAAMq-Y86UY7LNe-p2P_d8mw7FgTqLm=HQdqbMvV8xxTdsZmx1A@mail.gmail.com>
 <CAFEAcA_EZxgnSHOEwdF5QayAxsncYnGGe4RDPP-vwYTqwU+dNA@mail.gmail.com>
 <CAFEAcA_-XVMWr2ksaypuCiAZwU3GUKnvK26e35W-Tne8+BMNCg@mail.gmail.com>
In-Reply-To: <CAFEAcA_-XVMWr2ksaypuCiAZwU3GUKnvK26e35W-Tne8+BMNCg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Apr 2026 10:07:45 +0100
X-Gm-Features: AVHnY4KstMNquk6IryevfBCOQQnOKaiZM9BtwUkrtbTy2PKKRoLE1R2F2g-uOUU
Message-ID: <CAFEAcA_0Gw5oOV5_AVXSzCWOsqSJDWvDj=aP3aiwBdHJagA0pw@mail.gmail.com>
Subject: Re: [Withdrawn] [RFC PATCH v2 0/9] support unaligned access to xHCI
 Capability
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Tomoyuki Hirose <hrstmyk811m@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Fri, 24 Apr 2026 at 19:01, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 3 Sept 2025 at 10:47, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Wed, 3 Sept 2025 at 06:03, chen CJ <cjchen@igel.co.jp> wrote:
> > >
> > > I would like to withdraw this patch series.
> > >
> > > Sorry for the inconvenience, and thank you for your understanding.
> >
> > That's unfortunate; I think it's an issue we really do need to fix,
> > but I entirely understand if you don't have the time to work
> > on it further.
> >
> > I might pick it up if I have the time to do so.
>
> I eventually found some time/inclination to have another
> look at this. I have something that I think is mostly good to
> go, but I need to chase down the last few issues with it first.
> Hope to send a patchset next week sometime.

Hmm, this turns out to be a little more awkward than I thought. There's
a fundamental question about what a MemoryRegion wants for a case like:

{ .impl.min_access_size = 4, .impl.max_access_size = 4,
  .valid.min_access_size = 1, .valid.max_access_size = 4 }
i.e. "I only handle word accesses, synthesize byte and halfword for me".

Option A:
 * a byte write is zero-extended and sent as a word write
(so "byte write 0x42 to offset 0x20" becomes "word write 0x00000042
to offset 0x20")

Option B:
 * a byte write is handled by read-modify-write
(so "byte write 0x42 to offset 0x20" becomes "word read from 0x20,
deposit 0x42 to the low byte of what we read, word write to 0x20".

This series implements Option B, but we have devices in the tree
that want and assume the existing Option A behaviour. (The one
I ran into was the PL011, which wants to allow byte writes to its
registers, and those registers have read-sensitive behaviour:
the UART data register reads a byte from the FIFO or writes one
back to it, so a read-modify-write will drop incoming data.)

So I think our choices here are:

(1) say that we will never synthesize a write via read-modify-write;
Option A is the only behaviour we provide. This is OK for all our
existing devices. It also isn't a problem for the USB-xhci capability
registers that the series is trying to enable, because those are
read-only writes-ignored.

(2) allow Option B, but only opt-in via some new MemoryRegionOps
field that you have to set. (This is sort of like saying "my MR
is ram-like, in that neither reads nor writes have side effects
and it's really accessible at any size and perhaps any alignment,
I just haven't implemented all of it that way".)

(I don't think "find all the devices implicitly relying on Option A
behaviour and change them" is a feasible or desirable choice.)

For synthesizing unaligned writes where the MR doesn't implement
them, since we don't do these at all at the moment we get a freer
choice of behaviour: we can either do these as read-modify-write,
or say that you get two writes with the non-provided data being
zeroes.

Any opinions?  I think I would find it an easier decision if
we had a direct use case for the read-modify-write choice...

thanks
-- PMM

