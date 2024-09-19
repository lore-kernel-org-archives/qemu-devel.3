Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B33CE8D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 12:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srG3n-0001bo-9P; Thu, 19 Sep 2024 08:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srG3m-0001YH-B2
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 08:14:58 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srG3k-00022E-Iz
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 08:14:57 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c25554ec1eso1066494a12.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 05:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726748094; x=1727352894; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ITNzsVedTG0A9oh8mPcSnOgdo0s0QS2FVvVYwXjShG8=;
 b=KbLpfhSWAlYSKIpxyU/EDiWQzjy/L0+Abx5mTPVQMS5ot7nBIqA4IvjUdwIp8byui9
 lp0YarsHAjghkkQVk5+KykL2uYDZPsAJ1QWjdgqpY8XerPJUkX1DDuwJgOOrVyz4raUd
 3fkwvXR/KyEFPXlbk9fdpxq1Dhodn1ELG6ZpDRgJ6rmKes30pqHp5R7d1GvrFTV8WyQ+
 n3pNcQ+AA97RfRtV6eyAe4r0T4ZMRqGongfYDxaz/dwZqYd3wvxmR15pdD3ITOaN4KzM
 ygWyl67lhXniHkZ7LT4YJp5I+PS1aUoviPzk887UmIiniuDknfA1nfELdHBGiyKRDro/
 E1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726748094; x=1727352894;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ITNzsVedTG0A9oh8mPcSnOgdo0s0QS2FVvVYwXjShG8=;
 b=ipYOAieXgKTYdS+aVrMtWMHHoNc5wrN2d1elaHhmwPbSA+YWXkGdDDKQAxDtxGJ0A5
 nMOrdY+S/mR208hoRj6UYWCSRc1WA+CKbV+Xl9ZTPFt+U1FDalIV52KE4Bx7GwclP3wa
 JZcS4TdvbfDQ2l63mZksqPFj6ORddFV+sQPJKNLmfSK5l/kAYtzcdvjx4IlroBBVsKbY
 dlhrlUmWiCoHRe9iclNuDfS1fQqUY985lsKjcqSrTzUY2jjalBh9Ql/yrqEeZ7zdUk7P
 5wsEth5/4SR1yfsG6Wk6P6GPkYefwSC0LnerD5oueGqjZUcEQzQnv9lnQeP6ea8dsBIY
 DKVw==
X-Gm-Message-State: AOJu0YzGNrRuAkx1Jl84ugq3YBHX3MIOMVSM8hOKdmV5iO3Pk5xE5EyC
 8sMZV0CFDWts4me3OXoN8kOoOSNfblTZDCp1rYz460shd3WaGBZP2NYfKpXwajluv18yna2RcrC
 y46zyYaYFLanyOAGvmxz/ie8Wgzemxf0a4jLmUy8O63VtQyHZ
X-Google-Smtp-Source: AGHT+IH0uoWcbCWjdb1bXz7D4+O5temPBDkNrEnV+uxpPJQqI0+5uRP8wniNl/MnKz1xCcO4/Xg1dRgzGnZi6p8cd2o=
X-Received: by 2002:a05:6402:5204:b0:5c3:9fa9:1b72 with SMTP id
 4fb4d7f45d1cf-5c413e09477mr24012550a12.6.1726748093721; Thu, 19 Sep 2024
 05:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240815131206.3231819-1-peter.maydell@linaro.org>
 <CAFEAcA_cpkdKTvm5Sx3AwvMzd9+1umvwBpB=XLEO2ULj1wiHzw@mail.gmail.com>
In-Reply-To: <CAFEAcA_cpkdKTvm5Sx3AwvMzd9+1umvwBpB=XLEO2ULj1wiHzw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2024 13:14:43 +0100
Message-ID: <CAFEAcA9WamZDSsDStfRWWLmeCzUOy8xRUaDYJQH-u0DQVXewrA@mail.gmail.com>
Subject: Re: [PATCH for-9.2 0/2] accel/kvm: Fix two minor Coverity nits
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Fri, 6 Sept 2024 at 16:10, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 15 Aug 2024 at 14:12, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > This patchset fixes a couple of minor Coverity nits:
> >  * a can't-happen integer overflow when assigning from a long to
> >    an int in kvm_init_vcpu()
> >  * some unreachable code in kvm_dirty_ring_reaper_thread()
> >
> > Since there's no actual incorrect behaviour, these are 9.2
> > material.
> >
> > thanks
> > -- PMM
> >
> > Peter Maydell (2):
> >   kvm: Make 'mmap_size' be 'int' in kvm_init_vcpu(),
> >     do_kvm_destroy_vcpu()
> >   kvm: Remove unreachable code in kvm_dirty_ring_reaper_thread()
>
> Ping for review on patch 2, please?
>
> (I can take these through target-arm if you like.)

It's been two weeks, and patch 2 is pretty trivial, so I'm
going to take these through target-arm.next.

-- PMM

