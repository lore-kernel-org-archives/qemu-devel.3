Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8D8E6815D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 10:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsHyV-0003CA-Jl; Tue, 17 Feb 2026 05:06:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsHyU-0003Bj-8j
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 05:06:34 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsHyS-0003Rh-GQ
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 05:06:34 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64aea64bf15so3530747d50.2
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 02:06:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771322791; cv=none;
 d=google.com; s=arc-20240605;
 b=QCIVF2qLwKsZjg687m+k8MpiHCf/cJ5Xload2x6mOtpSQ2dtY8XP4MwID2fdYORLDU
 SA7Iv9Dgxh1ojs6MYY06PZBxRUUd0L3joN9b8RD6Mk9WJZiyyP3KVlaUX2p64K49Ee/Z
 BWVfUj+elcNUZmVNUF9JzqSAOn5uLhCctrqhHGeKxj1Bse9POCDfKWX/nzlHNALhgVK+
 aVetCvWe191RH8OVlBrMPqtcmmh1lL9vn8+NKMbkgBO6hHRWCWPkJ7qoUyepKgW6B8kj
 05yres5Lz7vpmoecRAltsWnoMgMeJ2jG9Wf1JYKSES7/1aOT6cpUy+5FH+FFbnamqsXW
 85HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=m8aeJnZSgw1CdsQNMCFpN44P+ckLvjs2d5Yaiasb3SA=;
 fh=4YEAmHJ1oJ1nri56ewJY6WKp1CuRG6BIjnLs8LYxu1s=;
 b=JQuXKZaeSHMgnMU59cwjhxMJVB3t57busqAZMsM7jvhwosvKpQbJLs+QlghJTjgSut
 0gwKBvd2P9I217Yjj+U8OhQXefO9Qn61gx6P8PIAcCb1qjKvhjNJiV4hdSrOrz840X6v
 zlbDiS4452rLudDRwZZPAh32WiykvrNHkWc+eePf1EmQ7tuC3witS5m6dSjemBJDO8bo
 8q/M7ZiBjbRbdy2PI5lL5dn6ZHEmhqADRtShjTlmBUQJfSc4UAJ8/v/EUmuObRgy3tMd
 Xe4TKVc+xZW1CSnySt/+qfylJ3cdHHC+r/CI39j5BOSijdRrPJMUQNOS1m96uhMazfC/
 wbtQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771322791; x=1771927591; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m8aeJnZSgw1CdsQNMCFpN44P+ckLvjs2d5Yaiasb3SA=;
 b=Plvp5M3J86v5yHCl6o3qRGUB4076mk6l8//ujojoVdhx6jz+1ZaonOyGzczroFPDw4
 dOKdzAvSs15pEvERW2W5rV4dGZxFIH/IebqZcMd1EwQSRS1ss64cgLBvVcVh/eH6twTb
 oB+Doy2M890LmfQ14j4oDl00THgZtx3C13xlClJO8c8Cs5GSna34rAgHcWpUsy+kONH4
 7Fyju3odU89bNV3sQK2zm6j4h/ZER73wQwKkversSBE3Ben6YEW3/mdQ8wVOPyIbJT2B
 di3RMZaUDYg0rZarWLUQOk11jy/7NCqwohtv/dmQMz4e9R6maruJWmgQ8a+U3k7cK4Sn
 /3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771322791; x=1771927591;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m8aeJnZSgw1CdsQNMCFpN44P+ckLvjs2d5Yaiasb3SA=;
 b=ICkbBEJ0tFnsPlR7CTKq5xNeKmWiLZzq5ThOJbZiXYpi8is+aUFpu85655VxLYC9Pr
 XDnXwnsFPVdcARLxRvnXYFfnTVzbMDEQLl+VZAmdxbC3V6mMIn9JG9BB8VmrEMxs0kGq
 jw7S+GpsD5colW6z+ZCHC9Ln1rCAHu6U0+LL0nFLulMXTdC+OAwPNrtX7kINLbBL0EbX
 Fr3naZ/8T9xBUv3Jd4+S+7vPpCy+Ivqu0TClapIy6rYsn9S2vCLT6xE9Klcm/piKIIWN
 WGGKBDDjYiUeS1dO1wjefDNo61TaDIzs9rP3E8K+qTiGCLnYZb7CUxuB/XvPQofbsjWJ
 vIXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY1xt3nf3htl3lRaSos5udEtaxmH2JNuoT91Ztf5AnXEDEucpsLoVwBmdZGbUQPrCLp6uV+WK4KQvi@nongnu.org
X-Gm-Message-State: AOJu0Ywz6KamY95o/G5oPU4B8AKy2x/yYNCSgRo/XMwIuuMKajFtv9K8
 /3ZDmK31LumMMoFy7K1FZnUf8T5SvoxdBDf2P9LlbDMRqp9ZMiodRHLtvbPEnOArGUitRzy7Mh1
 SIBgbHltdAhTDTG/xjsqFQC/F4PkMT6DXbcUcg8LQHA==
X-Gm-Gg: AZuq6aK0FI/y0pDBySxTAF0DpL4mn/eC2dPCLhNAf217rBZ0Sc5+gOQAvqont+ehTdx
 QuPUaqaOy78UaPDQfia3lYCW7QhKIMd01YH3xDRnAHIwGqHvt/q5tUk08Qq0Kdl7Ah5vXR5v/0o
 kBvo6sBMZANzjE2ijhSxOqdPN/wNonlZZmA96ZsBsMc6bD+jwX6HBmXGq2vI6VeYmT7KNlIS2xW
 asjqv61YhTsJTeAb/V+gs5F1x5fG1sz+hFYY8IZTn22n0z/WPBDW7yahIDe2fn5cM2a4/4SALza
 3PdNFNd+UtaV41pD2nPYgNot11X/UCN++woPgGPKldbVYzv5mDCsyv2Yvy1SoOefmlM=
X-Received: by 2002:a05:690c:6e12:b0:787:e3c0:f61f with SMTP id
 00721157ae682-797a0cde022mr212003707b3.57.1771322791011; Tue, 17 Feb 2026
 02:06:31 -0800 (PST)
MIME-Version: 1.0
References: <20260217052740.114117-1-heifetz@yandex-team.com>
 <20260217052740.114117-2-heifetz@yandex-team.com>
 <CAFEAcA9y-QEaiRZMrYadQWJ1KgnHxT8Fkqt1uS0PkbY0Sb-_3Q@mail.gmail.com>
 <d09950dc-dd3e-45ca-b54a-cbdff9f71e0d@redhat.com>
In-Reply-To: <d09950dc-dd3e-45ca-b54a-cbdff9f71e0d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Feb 2026 10:06:19 +0000
X-Gm-Features: AZwV_QjDNAhWQXxVj2gHhGvD93YrwNbScB0Ea8hrObvy5OvFH9YsbzLdCwS9QiY
Message-ID: <CAFEAcA_Q78GwXS0Uia1fFdPoDwkofD4Wr080EkG01gGD-d8Pgg@mail.gmail.com>
Subject: Re: [PATCH 1/8] audio: add `audio` build option for meson and Kconfig
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sergei Heifetz <heifetz@yandex-team.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Tue, 17 Feb 2026 at 09:42, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 2/17/26 10:31, Peter Maydell wrote:
> > On Tue, 17 Feb 2026 at 05:29, Sergei Heifetz <heifetz@yandex-team.com> wrote:
> >>
> >> This patch adds the `audio` option to meson_options.txt. It is
> >> propagated into Kconfig as AUDIO. It is enabled by default.
> >> The corresponding `--disable-audio` and `--enable-audio` options
> >> for `configure` are also added.
> >>
> >> For now, this option does nothing. In subsequent patches, it will
> >> gradually disable audio in different places. The final goal is to stop
> >> building sources from `audio/` and `hw/audio/` and other audio-related
> >> files (except for some stubs). Note that this intent is different from
> >> `-audio none`, which mutes audio but still compiles the audio subsystem.
> >
> > Not building audio/ code makes sense, but do we really want to
> > stop building hw/audio code ? That's the guest facing audio
> > devices, and if for instance a machine type has an embedded
> > sound device that would require us to stop compiling that
> > machine. I think it would be very confusing for users if
> > --disable-audio meant "we will silently not build half the
> > Arm boards that have a pl041 in them".
> >
> > Maybe it would be better if "--disable-audio" meant "don't build
> > the audio backends, and everything behaves as if the user
> > passed -audio none" ?
>
> The problem is that "-audio none" uses a silent backend but still keeps
> all the audio/ code around.  If you prefer to keep the Arm boards
> around, the solution would be to disable the audio code in the
> individual pl041 devices with "#ifdef CONFIG_AUDIO", so that the
> "depends on AUDIO" for pl041 can be removed too.

This seems weird, though -- why would we put in a lot of ifdefs
in every single audio device, when we could instead say "if you
disable audio at build time what you get is something that presents
the same API as the existing audio backends but does nothing" ?

Also, I think we should be consistent here, not put ifdefs in
some devices we think are "important" but skip it in others.

thanks
-- PMM

