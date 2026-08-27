Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD6EC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 17:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wze4g-0004Pq-D3; Thu, 27 Aug 2026 13:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wze4b-0004PN-J6
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:39:33 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wze4Z-0001wi-NE
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:39:33 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-836c718715fso1072837b3.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 10:39:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787852370; cv=none;
 d=google.com; s=arc-20260327;
 b=BiaW96WrAHgqrruPrN9luQ0g/KvAfk9v9gp3kt7COHjKJHrBin9xMJPs5MINvez9o8
 o+nTeflUvhX4lIztqwgpRQSWfUScjw/ejCfZP8c4dOwi82dl5WpSFNyHdR6Ap4+s/+q/
 /dLxg64jP2uTd/LHz2T4HIUrEm1QcfyVM1jti+fmkDykyPEQr401dKr68K2zxWFzCdi+
 K3bAkIZBQwlP498CnX126yv20goM0ICEDuAL8jSw4zscd9oiz9U188dMPoDHoKsE91tv
 w2yGMiPN36vtv0asUOrFaZ5dvtWtPTFHg94xYNfghw39IB4wjUtyiUnaba4JlyytaEGc
 qgkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=J7agITm0jexYdXaMzCzLvWFVvG1YMjJmDccpyWcXkpk=;
 fh=ytIiRC87zLWj3w5SjkTrsqCVqPMZPrZ+0QAfrYuWimc=;
 b=b6NtQ5QfiO6R2MtJ7di1De3LMKwo9GsM7+kgspGogCJ4/veaf5xFFiXLfw31XdrHYP
 bFTRf87/gbrIhCVYJW32AQe/2xAOV6SX4Oz1CYroPzR19QMQeMNEb3qYKtA5KgBuvkle
 SPAV05doecPvIbhZppJYyBC2aV+02skWLJSzehXgqnXwP3XgJ9OdfRegr4KvFXg/5bbs
 uUM/ToWT6BoNuFrfevZC9v0EnwNdg7jZSs0d0vhK5gWE9pVqxKbwspnwzc7/LcDaoJ0v
 a0TEln/gV9mxbPP0LjXzkEJnps8aGPivPquYuTS4KwzdEyxTHo/pBeUlGIHZucbuDyug
 84aQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787852370; x=1788457170; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=J7agITm0jexYdXaMzCzLvWFVvG1YMjJmDccpyWcXkpk=;
 b=C1mZM8vEP2M6fyUk8wwusIsAHqo+Bl99jTaanWUGu/XEzoypc4GKHE1JU3yNEzQ/65
 qMaQ9UarNag3PznxhXDY52yQgohAecqSHX7OKnozD4SH73h2oAZYxBtIQ66CqmTCZuBL
 g2e8StP04VPGQqPtrCCdI5uS46vjO1dWLQNpgoTGZuV5XbxV3uvm/Q4L/nuVA2SgfGjD
 itEoAdsKr06kPa+Y3G8spL7YBZ6t+Y8kQS/H6AnMu4tBJB7YZkCwOEG3uZWc22IzJOOO
 pkXzDc3bBeI5jT1xUvWZQ4nLSy+DnH1jngWmcCdu8IRn/9ufnksO6KEaOAEJDFvBPZaQ
 Ao5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787852370; x=1788457170;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=J7agITm0jexYdXaMzCzLvWFVvG1YMjJmDccpyWcXkpk=;
 b=pPdATgaM1Dtk7BUrJodXXeYq09iyHCa0WxvAO56+lJcdyEpYXmw2ljfJVSVYz6aj/N
 Sj9dcVC8L4Ld4dAlP+K26DPYKNav/syJ0HQO+ov/SIMrGTNGSukLEJ0NK+NqWGlNz4FW
 7D6f39JAutiH0X+NyYKpOb9frGjZcOEh3V3aXresCbTH5XLlUYAfY0ctmurTpVVRP5js
 wYFNiK/l/h88Hq87B0wjXTKbAJ0co3O5d2wR7g6rN8mcEgncbalb1RGC2Xe9HTBT8rRg
 G5Z5uXzsWrEJouEoIpeb9TFO+oCJDDI7ikCxV7ibNHwEgVJQXmbVxdFwGlqSqIXBLD6C
 Wrkg==
X-Gm-Message-State: AFuF++n3qlacoYSGh6O5kQ1Ap/rc4LqgoK/b6R+7SGhEP6ec5k6x1RTY
 lG5wVhEqjP/jskBNBajNqIBU+O1mRo4CPM7UUyGohwGuwqy1IElyokWkTIF3jX/ikYPQ/odWhDl
 Wzk28JuVx6u89N3bh8FYF/NbDPT/eqxHt53pkR8YW1g==
X-Gm-Gg: AR+sD10UjlkvGSqa1ZAVNNDNi3H803hx+O9w/1QhUeiLLrS74hUd/qIyMjLFAKEHMN4
 xDVduQwUGsF7skBIQgZNJ8SWs+kpeuv05GER7KdPTSGk54d+wWtWaaG3sY3a+Eym3XcYPrVvSG7
 elcXdc5aOmBAe1Y5enezvfkmSCstaqsaMOdeqbI/31aqIiiQ/JrQ0RAN+d1iwYdjDOvmHC2mkfQ
 EbRq0mXEAmZX/A+WbmMPa+ncaeEllwFJu7IA/3cNRG/gYevko+VYNXZaeCibbp0wzzVysuuIV6m
 J748Ufrt8uYUW8gYjYWQmYWk4IhqEbEboRH2/CG8zQujfIVBGClNWxW3NQ43iAfmPh7rjAHyX7h
 kyTHkHS93XJIaYXeOa8nBUNnzUyijxLIQbom19j8=
X-Received: by 2002:a05:690c:4004:b0:855:1f14:402a with SMTP id
 00721157ae682-85d6a2e16acmr4641137b3.22.1787852370138; Thu, 27 Aug 2026
 10:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260822183900.110111-1-ombarkare123@gmail.com>
 <CAFEAcA-f-=gP2GZEtTE7x=0mNvk0xL=TvHYDOvK=8GfVybuMQA@mail.gmail.com>
 <e4341a01-1a6a-46e2-8666-ee25b977a154@gmail.com>
In-Reply-To: <e4341a01-1a6a-46e2-8666-ee25b977a154@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2026 18:39:17 +0100
X-Gm-Features: AcwNN1VhpmAqbUEhBUpUNJ-HqaOMlfkJt-vyG0sWvMSnt9bJmkuhJt5wXxGLrVk
Message-ID: <CAFEAcA9RTg0=-+eokt9kfdRog+Mjkq-8==+HZCcQ1XuYtX+Nug@mail.gmail.com>
Subject: Re: [PATCH] hw/block: Add migration support for pflash_cfi02.c
To: Om <ombarkare123@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@mailo.com, kwolf@redhat.com, 
 hreitz@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Thu, 27 Aug 2026 at 17:12, Om <ombarkare123@gmail.com> wrote:
>
>
> On 27/08/26 15:38, Peter Maydell wrote:
> > On Sat, 22 Aug 2026 at 19:39, Om Barkare <ombarkare123@gmail.com> wrote:
> >> +static const VMStateDescription vmstate_pflash_sector_erase = {
> >> +    .name = "pflash_cfi02_erase_sector",
> >> +    .version_id = 1,
> >> +    .minimum_version_id = 1,
> >> +    .needed = pflash_sector_erase_needed,
> >> +    .fields = (const VMStateField[]) {
> >> +        VMSTATE_INT32(sectors_to_erase, PFlashCFI02),
> >> +        VMSTATE_UINT64(erase_time_remaining, PFlashCFI02),
> >> +        VMSTATE_BITMAP(sector_erase_map, PFlashCFI02, 1, total_sectors),
> >> +        VMSTATE_END_OF_LIST()
> >> +    }
> >> +
> >> +};
> > Why did you choose to put this in a subsection ?
> These states are accessed only if an erase is ongoing or if it is pending
> which can happen if migration is performed mid-erase or when an erase
> is suspended. As they are only accessed during an erase, so I thought I
> would
> put them in a subsection

Putting them into a subsection means extra code complexity here,
and a little bit of extra overhead in the on-the-wire format.
We usually only put things in a subsection if we need to do
that for migration compatibility (e.g. we added something to the
migration state later and so we want to avoid transmitting the
extra thing unless we really need to, so that we can still work
with an old QEMU that doesn't expect it). In this case the bitmap
is 1 bit per sector, and e.g. xilinx_zynq has a 128K sector size
and 64MB total size, for 512 sectors. That's only 64 bytes for the
bitmap, which is too small to be worth worrying about not sending.

So I think we should just include these fields directly in the
main vmstate.

-- PMM

