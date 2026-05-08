Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1D3CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 16:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLNxy-0003i9-PR; Fri, 08 May 2026 12:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLNxy-0003hY-0U
 for qemu-devel@nongnu.org; Fri, 08 May 2026 12:22:18 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLNxu-0001UH-TK
 for qemu-devel@nongnu.org; Fri, 08 May 2026 12:22:16 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-7b6ae2ea4a1so23450477b3.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 09:22:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778257333; cv=none;
 d=google.com; s=arc-20240605;
 b=Rigl4ZfgPaCy0hqDbiXyr2Zg6cgu8E2Yizw9JnHSrdJ5+PNljLsmqUW7XOHMi8yT7D
 i3AyNoJ3RP6qrDUTO7yFVpM49VBdUhty8y3sSVcjfDjMfZ2A2PJyJgLLzVlUN5X3IeXk
 iE88ALKBzzGOm/uOfaGeSftEWbgz6aCoTtJekUhvzjz4a/Ck10X1NFavDoy6dWyRgduW
 4iKNyeqUNPFHnTGXuLvdqmGwQ3B+OAcwdpzW1y4pymUaJKCu7tIKw9AYc6x7o2vi8rjG
 ONW7cJ8VXmQvPZkuO5IjlYuDtNbnZEEoSO1m5uK4wy9c3C+jwHr9PBsO+9hYeRZd6VDs
 SiJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UrmdB1BRJvGcVEgG7o6JW0bqINOVKN9TEf/PzBnLMgY=;
 fh=X0hnS57OutvDn80UIpZYh+UDDjnK9EdeaA1mTqz8XzM=;
 b=XpFWNR0lvarVhrN4znnfw/+eb/9ndlo8qQfI7vVC9aIbinjrxsbvS5zzojVUOXRK9K
 N/Y0FIRal0ACs9uNKV2UVXNrC9OWygPmyjBIxTbsECzuiRRUz5vlA3hAkkqqh/0eezQT
 UUYgtZ4TFhiKQI8mxx52pK75DuT9Fveh6Bmx5ZOljlzlm2Ujz3tOsUxlQkxu0/BEEwNF
 kjxSCUMtYICzSzkBD45E+CCzqsZnPWU9uLcgVwmJWQY1ju+5oyBNXH8Kfk/zrUxOmwvF
 Qa3a/OeLu2rIm44MkzrYqlkEiQ2GR2bGRv9wceYB2ezUQGcz3NJEbc0Vm0XLZauRu76w
 jjIA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778257333; x=1778862133; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UrmdB1BRJvGcVEgG7o6JW0bqINOVKN9TEf/PzBnLMgY=;
 b=zl4HHXEr/tqRGabghBZD55FBp5vFnQLHFXiPMOa/olbYpmAO8czEhPHSjECD37LrNe
 pbdQWqbUy7UYG/BXB45WzQsvZKMjY1Wp+x+cEsFJrM6i37TJfvIi7H5KXcVYqdUz93EC
 /d2ZM+TB3oqK5KJysXFpDHuWg1z8feaZ6pZ04qCje7Zdihde67vNpSEqPp0VW+zrLTGX
 kPoJ9ITShLXhROpFJK0tpI24ISWPXXGyhUmyRB1PIn2HrK9wxUovNwxwtQmOrN91J1ni
 fDgifoW4XCZ1P/royLDF2DJspefIh1+Z3pRYWDp1KnIOvaGMg1YJ6NxC5BwCJK27UagC
 xIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778257333; x=1778862133;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UrmdB1BRJvGcVEgG7o6JW0bqINOVKN9TEf/PzBnLMgY=;
 b=SjSYXrZUV6vhtjMbdYivOf/RWvosCMzulBKObuGufKfoBXXPi/iHZBF7kD+Itg+1LO
 kklmI3CzDvTm3981pe8vWfNj1DLuz4XqH3By+Z80ZXQAwLMQTIGb2YTgkGyDU6GMlPAr
 Z6yprhhlFkQdzi9RoP7AFEXZmCyjjyKvRRSHRrK7RPZfQM6uSNkmledlDw1KZo28WvG/
 FQXCKmslaxZHjYa6WFcZ19qu5i7N9Ni4nQ09EbL6Gy4vLPxCEjTHhJ9xNsQW5lV1ZL6+
 Pa1lfOHsinJ2bVuQflnRUz+phUJLEo+vvR1nh1gbpG995yt9jJr+nj2uiVgmsv+H85Js
 VnxQ==
X-Gm-Message-State: AOJu0YxVu3H9yLRlFGwBWY7XQ51LU2oQ5No39dwQm2dS3qTqSoG/i9Wk
 br/41sxqqSIzVqIxv3ARwjxQM3BKWBGGH76Og7jdSCSRYFvzkDDmRPf1ZHe63ZIpL7XQG0/Z+Hf
 SC2aeeHNSaJxy+QHX55L/Sm1W7muEtKGIn/YqRZX7Sw==
X-Gm-Gg: Acq92OEYtf64GoVJFz6YRX8GbFHTedQUGbgSaL6EolqJIEcItQtcQni5CnTMvcyeBXX
 U2ZhAIQKayROHnvH4LkuamTexS8PAWV44y7FdUa23zD/NUN4BRT0oz3tq+1ItZNLVoFKW9uerph
 QV094GA3dC0/7hxpHafhHNmoBGpSK3RwZO5FyKtcFR4kOcNkLttwGSrtkwmvUsSFSYk4lpHI09v
 qRuYPdzkOP9mc6yVChC6YosASvznibB2X+UM0mScVs3oSbgadBMFIxlAh3nFBHOYuyLy2DaAdrz
 eA6UHvIRUhR4hbg8OKywf838bvz+VOded/aQGkweQx7jFTVUL24SLzunJu0UghUw8hQ=
X-Received: by 2002:a05:690c:399:b0:7bd:9f34:59a3 with SMTP id
 00721157ae682-7bdf5debfdemr141152597b3.11.1778257333344; Fri, 08 May 2026
 09:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260508152428.2648560-1-peter.maydell@linaro.org>
 <735327c6-f23f-42cf-9b8e-a651d8ee7770@oss.qualcomm.com>
In-Reply-To: <735327c6-f23f-42cf-9b8e-a651d8ee7770@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 May 2026 17:22:01 +0100
X-Gm-Features: AVHnY4JN-6B2af8NhMUZ66ZZBrt03hqYDwUwEbyP7TI4HFa9yCTsMxe9UFiZ9e4
Message-ID: <CAFEAcA8eKM_DNK4kWX0DNudMiq__uZ-MQM0L-2CfWL39CgCyJw@mail.gmail.com>
Subject: Re: [PATCH 0/9] tools: Move more tools sources into tools/
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Gerd Hoffmann <kraxel@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Fri, 8 May 2026 at 17:00, Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 5/8/2026 8:24 AM, Peter Maydell wrote:
> > We have a set of binaries that we call "tools": they're built based on
> > the --enable-tools/--disable-tools configure setting, they're
> > documented in docs/tools, and they're standalone executables of one
> > form or another.
> >
> > Currently the sources for these are a bit scattered: many still in the
> > top level source directory, some in contrib, one or two actually in
> > the tools directory.
> >
> > As an initial attempt at cleanup, this patchset moves the sources for
> > qemu-bridge-helper, qemu-edid, qemu-img, qemu-io, qemu-nbd,
> > qemu-keymap, qemu-vmsr-helper and elf2dmp into the tools/ directory.
> >
> > The patchseries also moves the ebfp skeleton sources from tools/ebpf/
> > to ebpf/bpf-src/, because this isn't a tool by the above definition.
> >
> > As per my thread from a while back, I would ultimately like us to
> > clean up contrib/:
> > https://lore.kernel.org/qemu-devel/CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com/
> > But parts of that clearly need more discussion. So this is just doing
> > some parts that I hope are not controversial.
> >
> > Annoyingly, meson doesn't seem to provide any way for a subdirectory
> > meson.build to say "the foo.c in this subdir builds into a foo
> > executable that lives at the top level of the builddir". And we have a
> > lot of test harness stuff plus user muscle memory that assumes that
> > qemu-img and qemu-io live there. So the build runes for these tools
> > have to stay in the top level meson.build (and tools/meson.build
> > remains an empty file). The exception is that contrib/elf2dmp/elf2dmp
> > is now tools/elf2dmp/elf2dmp, but I think the set of people who were
> > running that from the build directory will be small.
> >
>
> It's a deliberate design more than an annoyance. It pushes users to make
> things explicit at top level, which is good to understand what is built
> and how, and hide details in subdirs in variables. QEMU's top level
> meson.build is over complex, so it may appear more as a burden than a
> benefit though.

Personally I think if the build system doesn't let you do a
pretty normal and reasonable thing that's annoying. Meson
annoys me because it has a tendency to be over-opinionated.

-- PMM

