Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35BBC19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnf6A-0001pS-1J; Thu, 27 Feb 2025 09:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnf5z-0001ns-4P
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:42:40 -0500
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnf5w-0008SD-Ks
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:42:38 -0500
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e589c258663so1183171276.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740667354; x=1741272154; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ocn/d1/FX1YV6bfS7ORusoHXK2VvAcMUIDGKps4AlVc=;
 b=HNPFpwcV+MYen3EEVvhCzp7gTPT/I8YR/ZTvZhqQJjP1z2Z0Ob7ROT7MRmcl07fExu
 5DigGZulpBx8C3gymxcCm1Zkskc7AA85GQwxLei3xGxB9kIN5D4vk2Q8+tVl9TEhCH1/
 wsKWjwZmfWwIvd0Pk+JZKYhDrhHza7cKU/GeogfTB8zveTJLPOieK3al3gwgdS//qawa
 X9repq6FrjrQBTWm/fOMf4/7FKqg/iDFi7DAIXH8wF8frziX4D1unRLXn8JRyTOotdWi
 k5pb/UTz9XS297iaTQ37LHouZhWdHUkhJyWgOaLN76r4NvOX998MEobpn10rLCSRpmD7
 PqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740667354; x=1741272154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ocn/d1/FX1YV6bfS7ORusoHXK2VvAcMUIDGKps4AlVc=;
 b=QKcf8QDrNbwGloxCl0kMIcuYP4iGanR/geJ+OUx3Z1ixwuAPF7UklXfrVFKxzYpHeZ
 /kCBvCRK6OB1HLAlE0sCnR5F7e97rTVdEBJ2QfwL39jqFztjK5DicxVlFnymvENtqtfz
 TSApTyx7SSbpTHvCGv0w/oKQBaxu/Dhu1xk6ozGRfwY4Qp5xVCrYAJ4uIC9vtRSIiT2y
 JkecJdhx0SAjGAh1ijVZqf7/ehpYqVOx2ODPVjU4QLO1B1wjSFP4+j9jOl0Ysno1X1Dg
 yVj3xOCS6cLl2apIQK6oSlPLSacsrvAkHoUsdvV9MSvoBjXNB0PDQ5tANAKNyH8cXeGe
 O43A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdQLDPUGFKZ3T+as94v8r4M3w+ZDj92BoBI8wcVmFnIs4RcmsYU5Grmcv2YwQJouEgZs7QwVq9pmsJ@nongnu.org
X-Gm-Message-State: AOJu0YyOoC8VKEix6Ofi1skbXGKXASJMudVwlBuBlN3h2Z8X10A4lrF5
 4l9x6iffCtqvIi77TF6NP5L5zOeqiZ6EnX+ULf628fMq/6MSN8GlB1PhOZufTGpctS8xqXYUtRn
 b71epXAD1j4cJwTKSNytDlWLzrZBLt6w15N7mRg==
X-Gm-Gg: ASbGncuxFtdb5KmYdG/ZZS72BA7M2TCtesC8LlcZUL2xSYKXbhWSwO6gw56RZST/lZP
 2LHRjeE08L0ZzeiJFEVBdcYpcmXsJKgZAbKOrcrXhpVPdWl66WQBrYJPkPPzqld9e44OdjkxjKG
 wJB24fyMba
X-Google-Smtp-Source: AGHT+IFIRR3f6DmHEJ2oHU4ZtUHQvlaf5gTLwKiy/iDcsV3ujyM7+NShp5NZLygXCMw/ywuyiSa3pbtBae/jqubfa80=
X-Received: by 2002:a05:6902:150e:b0:e5e:85:a9f0 with SMTP id
 3f1490d57ef6-e608a6a09c0mr7332624276.6.1740667353910; Thu, 27 Feb 2025
 06:42:33 -0800 (PST)
MIME-Version: 1.0
References: <6866d6b6-24af-4743-8407-26ae2998dd21@gmail.com>
 <CAFEAcA9B40F21r9RgeDd7k09juy35k9QWewzgkmyNkYVK_K0-g@mail.gmail.com>
 <CAFEAcA-U3QTWKhNr4Nd39hX7e+i+HDEyu8EZfSOm37GvvaH-hw@mail.gmail.com>
In-Reply-To: <CAFEAcA-U3QTWKhNr4Nd39hX7e+i+HDEyu8EZfSOm37GvvaH-hw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2025 14:42:22 +0000
X-Gm-Features: AQ5f1JqPj_GeB6VHJUzEIepiQLN3FpontCJ0wn56yXuIhxbHnGaNgJ4jOfCz6TQ
Message-ID: <CAFEAcA8SFHQGdhSo0UGtSPFyuuJZWPDRMCROQHMBvLSVtQ2mBQ@mail.gmail.com>
Subject: Re: ldrd implementation issue?
To: Stu Grossman <stu.grossman@gmail.com>
Cc: qemu-arm@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Mon, 17 Feb 2025 at 13:03, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 11 Feb 2025 at 10:46, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > (added qemu-devel to the cc list)
> >
> > On Mon, 10 Feb 2025 at 17:26, Stu Grossman <stu.grossman@gmail.com> wrote:
> > >
> > > I've been getting SIGBUS cores with a bunch of user apps running under
> > > linux 5.15 and qemu-system-aarch64.  These happen to be 32 bit (T32?)
> > > programs.
>
> > > The fix is to defer the register stores till after both words have been
> > > read from memory.
> > >
> > > Here is my fix:
>
> [snip patch]
>
> > Yes, this fix looks correct to me. Can you provide a
> > Signed-off-by: tag for it? We can't accept it as a patch
> > without that. (I can do the other administrative tidying
> > up of it into a commit, but the signed-off-by is what says
> > you have the legal right and are happy to submit it to QEMU
> > under our license (LGPLv2.1+ in this case)).
>
> Hi -- this is just a nudge about whether you can provide
> a signed-off-by line for this fix. I'd love to take it,
> but can't without a signed-off-by. (Otherwise I'll have to
> reimplement it from scratch, which I'll do at some point.)

I had a closer look at our LDRD code, and I noticed that we also
have another bug where we're not implementing the "must be 64-bit
atomic if the address is 8-aligned" requirement. So I wrote some
patches which fix that, and also will fix the page-crossing bug
(because they mean we now ask the memory system to load 64 bits
and then split it out into the two destination registers, rather
than doing two separate 32-bit loads, so we will take the fault
before updating either register).

If you're interested in testing those patches you can find them here:
https://patchew.org/QEMU/20250227142746.1698904-1-peter.maydell@linaro.org/

Thanks again for reporting this bug.

-- PMM

