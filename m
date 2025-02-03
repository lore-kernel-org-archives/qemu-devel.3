Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B12EC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 12:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tevyi-0005I8-Bz; Mon, 03 Feb 2025 07:55:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tevyg-0005Hm-QA
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 07:55:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tevye-0006Tc-MH
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 07:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738587298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3RE23XOU89dX7sGbdsjSm8F/k2wXABGQdwK5yUIlprM=;
 b=IO0l4uNd+lvdbujf5qwpyz3lGrSKhTTkPzY/JpnoKZ7Oxi574PWRgaS6bdrLg/twb3pvqp
 DdzF2HVvGBGcgZm+S4o3rn5LOc0VmntrShpv+o682GxnmDxwyMNNWalp5xrIurnwGx2qYE
 FituiDWJKIvenBwtIbp9mfL2ZhO73RE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-mcy8I52EM6KlpuJ5d9Y4Zw-1; Mon, 03 Feb 2025 07:54:57 -0500
X-MC-Unique: mcy8I52EM6KlpuJ5d9Y4Zw-1
X-Mimecast-MFC-AGG-ID: mcy8I52EM6KlpuJ5d9Y4Zw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-436379713baso21543885e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 04:54:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738587296; x=1739192096;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3RE23XOU89dX7sGbdsjSm8F/k2wXABGQdwK5yUIlprM=;
 b=gWZbV3m+fPjypN340YmaxMaY8yOguOX4CKRGeZIg/ukxHFqDYfjDnTOJsW6gIllQCg
 71ahByCgXBeRHM9lT2bwQw17opS7+LMOrlku+Iw/d7ToyN8tyQbKIF/UdUY99fJ6/Gp6
 /nkwgjKrhmRSvogh75RA/Gxlm92peNYl5Vu6VDpShQ3b2sm+Swgs4yQJwZd/PylEcGI6
 VAkB0iGIjT4VCwpP29B0/If8e7ZozYZedZcVO1mE9ZmIh1zqAHNGOdni4E0PHtJDyF4g
 jetl272f0CNZsvbmPuNoBT1QZFgjf/JCuOEg8JHTFu2KbZFIxTugoRe3t7Vh4giGDaeT
 4CtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPrd1DQP0J22ayCODHHaSS8WhTjgjb5niUm7dySWS5h43ONZBsSjUYPEBifK4U+NtBqrdzj/O48xET@nongnu.org
X-Gm-Message-State: AOJu0YwMyubaF4/9L772p3IHy53fPV9zXwStkcx4+ZCYbQcGRCCcgtD0
 cckwUpfIwPKG/36THaWX6oML4XWBSucvP/dQt3YerPuGM0a+pLVFp+TcRuiA1V/7YJ9CTUtLDBN
 JbJAh2gguEnLwlWCNz5GY6pBwvKvLFPuhgvCnR3xfZZX0kkqJlkGr
X-Gm-Gg: ASbGncs7/cTo1VpcPWRsdEW/wLygMPHDAd6vnlkdw6aF373LaEi7pPuHPuV732Wv/4U
 ESSRclOfVndAMtkucXmCQ/DWSUd8YfrHRDdf7+R3J1azU4/N0YkUagQ4FVNpZqvIZw4OCCDuHOE
 bN3qdGf5rdG6h6jq+2pSYmJvRjnPzY4F/i1Tbt28BS6urW8NRa18tFpIi+gWa3EnQd4rRXuY7WT
 0SefvFimwvmMVgf7o6AALS1jRqdt0XCxNirPtFD/srRPKsRvh1ftGzua8tjzh0eTMgb0dBJ7AhU
 xpJlLw==
X-Received: by 2002:a05:600c:350b:b0:434:f623:9fe3 with SMTP id
 5b1f17b1804b1-438dc3cb955mr200430285e9.16.1738587295952; 
 Mon, 03 Feb 2025 04:54:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7JpGMm5RZgYQ85fLD57CP3fcvsiifD8d5Fvw0fu2P265ORoGreopMMH9M+ZQ+Hqu7NTFQyQ==
X-Received: by 2002:a05:600c:350b:b0:434:f623:9fe3 with SMTP id
 5b1f17b1804b1-438dc3cb955mr200430115e9.16.1738587295595; 
 Mon, 03 Feb 2025 04:54:55 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-438dcc27130sm188857345e9.16.2025.02.03.04.54.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 04:54:55 -0800 (PST)
Message-ID: <467a5a58-952e-4930-8e91-744eda6d87d9@redhat.com>
Date: Mon, 3 Feb 2025 13:54:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] meson: Deprecate 32-bit host support
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: mark.cave-ayland@ilande.co.uk, berrange@redhat.com, philmd@linaro.org,
 thuth@redhat.com
References: <20250203031821.741477-1-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250203031821.741477-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/3/25 04:18, Richard Henderson wrote:
> v1: 20250128004254.33442-1-richard.henderson@linaro.org
> 
> For v2, immediately disable 64-on-32 TCG.
> 
> I *suspect* that we should disable 64-on-32 for *all* accelerators.
> The idea that an i686 binary on an x86_64 host may be used to spawn
> an x86_64 guest via kvm is silly and a bit more than niche.

At least Xen used to be commonly used with 32-bit dom0, because it saved 
memory and dom0 would map in guest buffers as needed.  I'm not sure how 
common that is these days, perhaps Stefano knows.

For KVM however I don't think anyone cares.

Paolo

> Similarly for mips32 spawning mips64 and ppc32 spawning ppc64.
> 
> But in the meantime, jump through a couple of hoops to keep these
> kvm and xen cases building, while disabling tcg in the same binaries.
> 
> 
> Richard Henderson (14):
>    meson: Drop tcg as a module
>    tcg: Move stubs in tcg/perf.h to tcg/perf-stubs.c
>    plugins: Uninline qemu_plugin_add_opts
>    meson: Introduce CONFIG_TCG_TARGET
>    tcg: Link only when required in system mode
>    plugins: Link only when required in system mode
>    accel/stubs: Expand stubs for TCG
>    target/mips: Protect objects with CONFIG_TCG
>    gitlab: Replace aarch64 with arm in cross-i686-tci build
>    configure: Define TARGET_LONG_BITS in configs/targets/*.mak
>    target/*: Remove TARGET_LONG_BITS from cpu-param.h
>    meson: Disallow 64-bit on 32-bit TCG emulation
>    meson: Deprecate 32-bit host support
>    tcg: Remove TCG_OVERSIZED_GUEST
> 
>   include/qemu/atomic.h                       | 18 ++------
>   include/qemu/osdep.h                        |  7 +++
>   include/qemu/plugin.h                       |  9 +---
>   include/tcg/oversized-guest.h               | 23 ----------
>   include/tcg/perf.h                          | 23 ----------
>   target/alpha/cpu-param.h                    |  2 -
>   target/arm/cpu-param.h                      |  2 -
>   target/avr/cpu-param.h                      |  1 -
>   target/hexagon/cpu-param.h                  |  1 -
>   target/hppa/cpu-param.h                     |  2 -
>   target/i386/cpu-param.h                     |  2 -
>   target/loongarch/cpu-param.h                |  1 -
>   target/m68k/cpu-param.h                     |  1 -
>   target/microblaze/cpu-param.h               |  2 -
>   target/mips/cpu-param.h                     |  5 ---
>   target/openrisc/cpu-param.h                 |  1 -
>   target/ppc/cpu-param.h                      |  2 -
>   target/riscv/cpu-param.h                    |  2 -
>   target/rx/cpu-param.h                       |  1 -
>   target/s390x/cpu-param.h                    |  1 -
>   target/sh4/cpu-param.h                      |  1 -
>   target/sparc/cpu-param.h                    |  2 -
>   target/tricore/cpu-param.h                  |  1 -
>   target/xtensa/cpu-param.h                   |  1 -
>   accel/stubs/tcg-stub.c                      | 24 ++++++++++
>   accel/tcg/cputlb.c                          |  7 ---
>   accel/tcg/tcg-all.c                         |  9 ++--
>   plugins/loader.c                            |  7 ++-
>   plugins/stubs.c                             | 49 +++++++++++++++++++++
>   target/arm/ptw.c                            | 34 --------------
>   target/riscv/cpu_helper.c                   | 13 +-----
>   tcg/perf-stubs.c                            | 26 +++++++++++
>   .gitlab-ci.d/crossbuilds.yml                |  2 +-
>   accel/tcg/meson.build                       | 11 ++---
>   configs/targets/aarch64-bsd-user.mak        |  1 +
>   configs/targets/aarch64-linux-user.mak      |  1 +
>   configs/targets/aarch64-softmmu.mak         |  1 +
>   configs/targets/aarch64_be-linux-user.mak   |  1 +
>   configs/targets/alpha-linux-user.mak        |  1 +
>   configs/targets/alpha-softmmu.mak           |  1 +
>   configs/targets/arm-bsd-user.mak            |  1 +
>   configs/targets/arm-linux-user.mak          |  1 +
>   configs/targets/arm-softmmu.mak             |  1 +
>   configs/targets/armeb-linux-user.mak        |  1 +
>   configs/targets/avr-softmmu.mak             |  1 +
>   configs/targets/hexagon-linux-user.mak      |  1 +
>   configs/targets/hppa-linux-user.mak         |  2 +
>   configs/targets/hppa-softmmu.mak            |  1 +
>   configs/targets/i386-bsd-user.mak           |  1 +
>   configs/targets/i386-linux-user.mak         |  1 +
>   configs/targets/i386-softmmu.mak            |  1 +
>   configs/targets/loongarch64-linux-user.mak  |  1 +
>   configs/targets/loongarch64-softmmu.mak     |  1 +
>   configs/targets/m68k-linux-user.mak         |  1 +
>   configs/targets/m68k-softmmu.mak            |  1 +
>   configs/targets/microblaze-linux-user.mak   |  1 +
>   configs/targets/microblaze-softmmu.mak      |  3 ++
>   configs/targets/microblazeel-linux-user.mak |  1 +
>   configs/targets/microblazeel-softmmu.mak    |  3 ++
>   configs/targets/mips-linux-user.mak         |  1 +
>   configs/targets/mips-softmmu.mak            |  1 +
>   configs/targets/mips64-linux-user.mak       |  1 +
>   configs/targets/mips64-softmmu.mak          |  1 +
>   configs/targets/mips64el-linux-user.mak     |  1 +
>   configs/targets/mips64el-softmmu.mak        |  1 +
>   configs/targets/mipsel-linux-user.mak       |  1 +
>   configs/targets/mipsel-softmmu.mak          |  1 +
>   configs/targets/mipsn32-linux-user.mak      |  1 +
>   configs/targets/mipsn32el-linux-user.mak    |  1 +
>   configs/targets/or1k-linux-user.mak         |  1 +
>   configs/targets/or1k-softmmu.mak            |  1 +
>   configs/targets/ppc-linux-user.mak          |  1 +
>   configs/targets/ppc-softmmu.mak             |  1 +
>   configs/targets/ppc64-linux-user.mak        |  1 +
>   configs/targets/ppc64-softmmu.mak           |  1 +
>   configs/targets/ppc64le-linux-user.mak      |  1 +
>   configs/targets/riscv32-linux-user.mak      |  1 +
>   configs/targets/riscv32-softmmu.mak         |  1 +
>   configs/targets/riscv64-bsd-user.mak        |  1 +
>   configs/targets/riscv64-linux-user.mak      |  1 +
>   configs/targets/riscv64-softmmu.mak         |  1 +
>   configs/targets/rx-softmmu.mak              |  1 +
>   configs/targets/s390x-linux-user.mak        |  1 +
>   configs/targets/s390x-softmmu.mak           |  1 +
>   configs/targets/sh4-linux-user.mak          |  1 +
>   configs/targets/sh4-softmmu.mak             |  1 +
>   configs/targets/sh4eb-linux-user.mak        |  1 +
>   configs/targets/sh4eb-softmmu.mak           |  1 +
>   configs/targets/sparc-linux-user.mak        |  1 +
>   configs/targets/sparc-softmmu.mak           |  1 +
>   configs/targets/sparc32plus-linux-user.mak  |  1 +
>   configs/targets/sparc64-linux-user.mak      |  1 +
>   configs/targets/sparc64-softmmu.mak         |  1 +
>   configs/targets/tricore-softmmu.mak         |  1 +
>   configs/targets/x86_64-bsd-user.mak         |  1 +
>   configs/targets/x86_64-linux-user.mak       |  1 +
>   configs/targets/x86_64-softmmu.mak          |  1 +
>   configs/targets/xtensa-linux-user.mak       |  1 +
>   configs/targets/xtensa-softmmu.mak          |  1 +
>   configs/targets/xtensaeb-linux-user.mak     |  1 +
>   configs/targets/xtensaeb-softmmu.mak        |  1 +
>   docs/about/deprecated.rst                   |  7 +++
>   docs/devel/multi-thread-tcg.rst             |  1 -
>   meson.build                                 | 47 +++++++++-----------
>   plugins/meson.build                         |  5 ++-
>   target/mips/tcg/meson.build                 |  4 +-
>   target/mips/tcg/system/meson.build          |  6 +--
>   tcg/meson.build                             |  8 +++-
>   108 files changed, 241 insertions(+), 202 deletions(-)
>   delete mode 100644 include/tcg/oversized-guest.h
>   create mode 100644 plugins/stubs.c
>   create mode 100644 tcg/perf-stubs.c
> 


