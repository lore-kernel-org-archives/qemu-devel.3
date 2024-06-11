Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B680CC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 10:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGzAU-0006Nn-4l; Tue, 11 Jun 2024 06:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGzAT-0006NJ-1R
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:55:57 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGzAQ-0006eT-Qv
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:55:56 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-35f123bf735so642318f8f.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 03:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718103353; x=1718708153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=45/8m+bcuOne4YSUQngAvVGqDUrht2EzGOpy58xJNqs=;
 b=XNDnAGmzbGwwb5+r6+HqTbKmOVnxmzw0FIwlwqzX0nDrtU5L/uTaDRMfRJI4K8YwGc
 f8HmGbJRfTDt6STuveT5edf5fiwn6PO9Ov9rzN3XHKen2thQTT7MIegMbofontByzRl/
 4KRlkcIzgYTJqCGdtXZETrHsY+OrTPvdIY92K1bRS8iLqzhUwBAc76dEpzgIPB2weUp9
 zfaKhU3FLtiC0ojTXBw+o3KqTL+4F0IfI+xl91BH7i/FfsGAEmy2FuAMdHPxz2168UgP
 Fc+e0vbvzXP6nQ4gvOvmxn2h9yGbVaX9XetMMsl6ilg84KNqXR0D0EsdFpXdNxVKGHTk
 EpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718103353; x=1718708153;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=45/8m+bcuOne4YSUQngAvVGqDUrht2EzGOpy58xJNqs=;
 b=RSi6j5Sp05zJT3FhepIGaYiUYxKRyZho+tclwvHZbf851To5DIrlJzXP0IPSy0YO8f
 VB5tlHqpN9ckpu88cZfcf4+Df6o4aGGlbISC/1qozX7qf0Zy57CNeOBITFopGdW802Cd
 7MsOnzUGxZhjn+4zyjfMyi7Bm3ynbhIh41bSM3AOrcWudpbyC9Wwratbch1VpHOy5pEH
 ay94AoNCI1O/Rh3d+bFr2G6FNYI5qWboXXThQ2bR+BzfufCaU0gt1uzcT8GGaO6+l9AV
 dbTB3Zt9P3sP76sWzSfpczJ/5RscMtZieI04FgZLQEtZaFO1UVgDAIRsSuezVhvxdgen
 LhdQ==
X-Gm-Message-State: AOJu0Yxo/Fua+SCo4IEi5GcrdmkW2mgh/v7/eDxnsn1x2IPKjZH6Rdlt
 dzi4Z3YLhuUa8f4fYFzvOnfATOEIW8qect5hLrb+dGqTtoUQrYSaHNv90PbWFok=
X-Google-Smtp-Source: AGHT+IGnvwtK8TV7lPDd38/JdD0kn33yfhqHUPuyYzNOHgKySnflq56SR3INnNwrR+4KFXi0/wDUlA==
X-Received: by 2002:a5d:5f55:0:b0:35f:2a02:6038 with SMTP id
 ffacd0b85a97d-35f2a0260c5mr2884434f8f.47.1718103353052; 
 Tue, 11 Jun 2024 03:55:53 -0700 (PDT)
Received: from meli-email.org (adsl-33.37.6.162.tellas.gr. [37.6.162.33])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f24ebfbbbsm4997918f8f.61.2024.06.11.03.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 03:55:52 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:50:41 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
User-Agent: meli 0.8.6
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <ZmgIUfqDjJuw2Chl@redhat.com>
In-Reply-To: <ZmgIUfqDjJuw2Chl@redhat.com>
Message-ID: <ewx13.l5xehpejawbf@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 11 Jun 2024 11:18, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>On Mon, Jun 10, 2024 at 09:22:35PM +0300, Manos Pitsidianakis wrote:
>> What are the issues with not using the compiler, rustc, directly?
>> -----------------------------------------------------------------
>> [whataretheissueswith] Back to [TOC]
>> 
>> 1. Tooling
>>    Mostly writing up the build-sys tooling to do so. Ideally we'd 
>>    compile everything without cargo but rustc directly.
>> 
>>    If we decide we need Rust's `std` library support, we could 
>>    investigate whether building it from scratch is a good solution. This 
>>    will only build the bits we need in our devices.
>
>Re-building 'std' for QEMU would be a no-go for many distros who
>will expect QEMU to use the distro provided 'std' package. So at
>most that would have to be an optional feature.

Yes this wasn't meant for the distro case, you're correct.

>
>> 2. Rust dependencies
>>    We could go without them completely. I chose deliberately to include 
>>    one dependency in my UART implementation, `bilge`[0], because it has 
>>    an elegant way of representing typed bitfields for the UART's 
>>    registers.
>> 
>> [0]: Article: https://hecatia-elegua.github.io/blog/no-more-bit-fiddling/
>>      Crates.io page: https://crates.io/crates/bilge
>>      Repository: https://github.com/hecatia-elegua/bilge
>> 
>> Should QEMU use third-party dependencies?
>> -----------------------------------------
>> [shouldqemuusethirdparty] Back to [TOC]
>> 
>> In my personal opinion, if we need a dependency we need a strong 
>> argument for it. A dependency needs a trusted upstream source, a QEMU 
>> maintainer to make sure it us up-to-date in QEMU etc.
>
>"strong" is a rather fuzzy term. In C we already have a huge number
>of build dependencies

Rust crates.io dependencies tend to "explode" due to the large number of 
transitive dependencies and even different versions of the same crates.

Here's an example:

https://landaire.net/on-dependency-usage-in-rust/#what-about-dependency-explosion

This is something to be aware of in general when pulling dependencies.


>
> $ wc -l tests/lcitool/projects/qemu.yml 
> 127 tests/lcitool/projects/qemu.yml
>
>we would have many more than that except that we're conservative
>about adding deps on things because getting new libraries into
>distros is quite painful, or we lag behind where we would want
>to be to stick with compat for old distro versions.
>
>In terms of Rust dependancies, I'd expect us to have fairly arbitrary
>dependancies used. If the dep avoids QEMU maintainers having to
>re-invent the wheel for something there is already a common crate
>for, then it is a good thing to use it. I'd almost go as far as
>encouraging use of external crates. Our maintainers should focus tmie
>on writing code that's delivers compelling features to QEMU, rather
>than re-creating common APIs that already have good crates.

That was my reasoning for using the bitfield crate to represent UART 
registers.

>
>> We already fetch some projects with meson subprojects, so this is not a 
>> new reality. Cargo allows you to define "locked" dependencies which is 
>> the same as only fetching specific commits by SHA. No suspicious 
>> tarballs, and no disappearing dependencies a la left-pad in npm.
>> 
>> However, I believe it's worth considering vendoring every dependency by 
>> default, if they prove to be few, for the sake of having a local QEMU 
>> git clone buildable without network access.
>
>A local git clone is already not buildable without network access,
>given that you have to install countless extra distro packages
>ahead of time. I think its reasonable to expect people working from
>git to have to download rust deps. We should consider whether we
>want vendoring in the release tarballs though.


Sorry, I meant using cargo without network access. This requires setting 
up the registry index and caches on your $CARGO_HOME

>
>> Should QEMU provide wrapping Rust APIs over QEMU internals?
>> -----------------------------------------------------------
>> [qemuprovidewrappingrustapis] Back to [TOC]
>> 
>> My personal opinion is no, with the reasoning being that QEMU internals 
>> are not documented or stable. However I do not see why creating stable 
>> opt-in interfaces is bad. It just needs someone to volunteer to maintain 
>> it and ensure there are no breakages through versions.
>
>I expect this will evolve organically with people providing wrappers
>where appropriate to suit their development neds.
>
>> Will QEMU now depend on Rust and thus not build on my XYZ platform?
>> -------------------------------------------------------------------
>> [qemudependonrustnotbuildonxyz] Back to [TOC]
>> 
>> No, worry about this in some years if this experiment takes off. Rust 
>> has broad platform support and is present in most distro package 
>> managers. In the future we might have gcc support for it as well.
>
>Rust isn't going away, so if a platform wants to remain relevant
>to the modern software world, then people who care about that
>platform need to ensure Rust works on it. I wouldn't say that
>QEMU needs to massively worry about this, since all the common
>platforms are now covered precisely because Rust is becoming
>so wildly used that a platform cannot ignore it.

Agreed.

