Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5798C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 16:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wglwC-0001ok-LZ; Mon, 06 Jul 2026 12:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wglwA-0001oI-6L
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:12:50 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wglw8-0005AQ-Jt
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:12:49 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-66771ded50aso1392371d50.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 09:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783354367; cv=none;
 d=google.com; s=arc-20260327;
 b=S2aqSu2EDMwFciA7wZNHNY9twHVDb2bJ9KeTdfd3vFbi7s0ZPJSs1BeLEQg6aWleeJ
 zZiF47hwAC9P7FWWY3AdACbITADC4lEH6W2HWEvQrdKx23IyMDtPmdO3a3+BivJw/8V1
 zqVXX5OQGRtlSjtGukDm67RZm5eEw4jDIsNY0hyBSootN4f9RZWcX94nxvTq9quX/rZE
 8jstDQyTL+MQDiYLsLXmZR/f+UypCu8kIGP/846jJ39FpMYBABiXBuMrtjnO0knwlvHq
 7G7TB43JgLbZiowB8qF4TMDXN40Ys+Nk20guzpKy4c0KCyzE3xbM1aunJGTI9CvWmJjO
 H2ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TOWUY/ws1tfjb+R5jQVl/SdbXEUMX+n+5fLD2DDaVz4=;
 fh=pTQO1MRl4VlG7A0kGKtTVKp3JhHF9Af4BMRl9yrgddA=;
 b=DHsrMT4sD65PQ1GMB3yMqE7rJ8MqO58tOlvYLIXBq8OM0dl/NH00c66ydM/IcXxA7j
 4Jz2IUbfc+FRBYoNqm9ueHIm3hZUp293NoQHhEtWIHSKMR5NV4FjqSPwLi0UpY3QeYr0
 D/G270yWpbg3lTlC3c7pZ6aigFUh2jxP4/fSi8215OfrzFUoBrsLpqb5mNh49CyOmpsQ
 shlrsgLsB+kRrsJ8VRmdsAIR63g0h2oZSb1D6R16zKmwSe1IPthcFBH3+68U+JSQjITs
 p2xmhQN0fMIWyfVa+koCy+Gm2zlAfdGWuZ4xHJXAuw8J/97ZJ54C8piaj/UdgVsVR8NV
 MssQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783354367; x=1783959167; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TOWUY/ws1tfjb+R5jQVl/SdbXEUMX+n+5fLD2DDaVz4=;
 b=uaprgL51J9A/t4jqPPxMVnKr9obyUJvy210X5Pt0UXqST8RqP6wxV6Jg09NwJox506
 WgHbPUnmSN0TGu+MVsuKPCSaBba1oD15A7ka0xkjALmJctDUwhUa/JLu+XhO5/g7ihFp
 xLLfWQduRMSl7GM7+Rh6/1k159CZ9kOHaxZJcBTwxtU05IuweI3IlN7e/P7N3O0aHdte
 p++0nCiI+654WcVMNcA0HdRDpNik3iobQxDmaHew6gcknUlfS076F/v8zQcoIr5aWPdU
 xaLu9wT8+5P3LAaJjhkiIWzn6QqyY6r8znlhFef1Z3/iznLayY6fzeeJ6B7BPHaQtyoE
 XucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783354367; x=1783959167;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TOWUY/ws1tfjb+R5jQVl/SdbXEUMX+n+5fLD2DDaVz4=;
 b=n0NuWl9ZoQ/o1fizV5nMVDdEj9T9n7/bNwUg6f5mAws2NHgAozQOgev6i58dAmKo92
 2qxhxItKAxEfUgpshQo8nnEF3l/YypJfGnFlbuvmggbhqNtvXc0+kfFRhKl2vmo0Q5Lw
 T4JLqkJn0bicPvjVr6lgtLKu5NfJvuEHSB1FTvQ9/iS4rXDoVMAUGLeuEZq2AINvthKB
 wsqVm+dkjzHpAf2Or/SGZJ0WgB8S+IBr91DYMeGzUuOA9wecVPO5GCB3e2+NRLLf9f1u
 ITOWDZI7ziwAoymnBQFEgELAcBIYPbGS4L+fz6nJxi2UFFKzamZPTFpJCd0QWGjsP/V9
 Bcdw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6uRGaKa2WBVUeee3e/vfBk7Pjtqbf6fil/YaQCZ77s1gNL6uZL+QBt3T8mJvvdr/pWAiebkLCPJQH@nongnu.org
X-Gm-Message-State: AOJu0Yynzg+NEhAdb3K9AqSDHyEwdz0MxfGxpGY95Nspmv3PUzcyB3Eq
 nnEBO/3v2N4mwxT66HcNpQzQswzgmc/zGfmJZnXC/GAy+0cDROJZcwc4iqsU8KN9yYspts44Em0
 RKfXRW5/Ze3RrrJx8s5Iiz0DriEk2t+EkJmhC20EP5A==
X-Gm-Gg: AfdE7cnqZRa7CgAAuhTDuoPvQTfWR/sawfYAstRhWP/1npuQnD8RzTR1A+EZxMT9GnA
 BpjJJ9N8ppeTxrINYWUg6oXV4840mJusy8Hp5PVkzC6WQBRS7s1vW2vA+4URiQ+QNj7TTJ6e0v7
 9HFhxa8NjFxKqlrj6jMS64I0CmOB9BM/L9y5AOK/Z3uGnaIEDNezcU7YyJDl5A9xRV2l9B7xfpU
 JdcSj1OsbQIgTzpxTnffRjieLU9LIQnxMct1gMg3FOKHCFmRovZNXJhPTSdBgpEeDhSlhs0tOii
 cyK4KssnVY+j3NEBctCYQQJP5LLr1KwcDBDCMNJXj8HAeHCgQcOoUh93a6tSeELyB28=
X-Received: by 2002:a05:690e:4842:b0:660:a41d:d175 with SMTP id
 956f58d0204a3-6677fcab813mr803228d50.55.1783354366988; Mon, 06 Jul 2026
 09:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260702160640.3875666-1-clg@redhat.com>
 <20260706082023.7ee830b8@shazbot.org>
 <3f799ad7-08a5-44c7-b6bf-b143da038593@redhat.com>
 <CAFEAcA9wOZhn41Twz9zzCBD4MAET2+gbF71kUKnr7r6TXfhjuw@mail.gmail.com>
 <20260706094241.1457bbc6@shazbot.org>
In-Reply-To: <20260706094241.1457bbc6@shazbot.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jul 2026 17:12:35 +0100
X-Gm-Features: AVVi8CevKa91_jD7TwgVELBjvx-JlSWy3750LucH265OMJEUBUd17FqgTZgMCgE
Message-ID: <CAFEAcA-d9CJhfJQ2B1h+mZTPphc7SKk8yjCuGH4RWYT9J=EATw@mail.gmail.com>
Subject: Re: [PATCH] vfio/listener: Only warn on misalignment for VFIO-owned
 regions
To: Alex Williamson <alex@shazbot.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>, 
 Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Mon, 6 Jul 2026 at 16:42, Alex Williamson <alex@shazbot.org> wrote:
>
> On Mon, 6 Jul 2026 16:27:46 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
> > It seems very unlikely that anything not page-aligned is going
> > to be a sensible target for DMA ops from a device: the main
> > reason to have a non-page-aligned or non-page-sized region is that
> > it's the way we've chosen to implement a device, or it's some
> > "RAM but not general-purpose RAM" thing. If there's a path to
> > warn/error if it's actually used for a DMA op that would be worthwhile,
>
> But for a vfio-pci device there is no DMA op, it either gets mapped
> into the IOMMU for direct access to the device or not.  This is the
> point at which that decision is made.

Why is small RAM different from MMIO register regions here?
Those also you're not going to be able to have a device do
direct memory access to.

> > but as it stands I think all this warning will ever cause us to
> > do is add more entries to its whitelist every time it complains.
>
> IMO, that's ok.  That's the purpose.  We're up to one whole class of
> device so far, we don't care about mapping failures to TPM devices.  If
> some day this does fire on something we care about, especially a
> regression, it'll earn its keep.  It doesn't seem like an excessive
> burden yet. Thanks,

The reason we're having this conversation is because it just fired
again, and the warning gives the impression that the right thing
to do is to somehow change the misaligned memory region, not to
add something to the whitelist. That's already wasted several
people's time.

You could add a comment saying

/*
 * If this warning ever fires, then it will almost certainly
 * be because of a legitimately non-aligned RAM-backed
 * MemoryRegion that needs adding to the whitelist.
 */

But I think that it would be much better just to dump the
warning, so we don't have to keep doing this.

thanks
-- PMM

