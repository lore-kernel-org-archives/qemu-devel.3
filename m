Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901E2C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 21:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjlxr-0003zN-SY; Sun, 16 Feb 2025 16:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tjlxp-0003yx-CL
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:14:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tjlxn-0000XO-7D
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739740445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RdwvMVqqbnk+QrffSV91gnEiof/mB/U9rGjqxfE34A0=;
 b=VlkWdTpRWVpbk9eADrjc5KD7eiySH2me2GhqMc5IJmvpww09uzDdIRKG+z0H9HzSoxycYQ
 khT0OqetLi5y8xAQOT+z0ixX5AzxZPUjddVFDjZpZgfI+RJ2TgmuQUEgFqUHLU41ZIPYrX
 GkGL0PEGp8/CNNS8QCFAS+s0YHpXcj8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-6Iq6ZLHfNPyakPpTjuAolQ-1; Sun, 16 Feb 2025 16:14:03 -0500
X-MC-Unique: 6Iq6ZLHfNPyakPpTjuAolQ-1
X-Mimecast-MFC-AGG-ID: 6Iq6ZLHfNPyakPpTjuAolQ_1739740443
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38dca55788eso3265068f8f.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 13:14:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739740442; x=1740345242;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RdwvMVqqbnk+QrffSV91gnEiof/mB/U9rGjqxfE34A0=;
 b=mt12tN1pPkVUpeWIhI0kEKdIKJf+wisW5r/bUuzsWH54aDwt/3E1gthVSBb45gDeg8
 ya9eGCWmw22036Npn5X5L+ALF+Y6rZz9ggAr1MnYbumwSQ9M4SdWa3uSuAj7gFlaAcnY
 wxY4rtRFlPtj28dp9TX2onHnpG8QRxHl1rlio0G1BXSw/ewghBDou2767EjSqfdzInPX
 tUxKCZOpxdBw4LIOyQhRbNVPoeDJd0X9wc/TOJrHln2ONxIP7lAUpMemSt6QN+GXamV+
 kj+YZtPWwLoyhq2kS1xcYZ6kyogne4UtvlGnynOc6QpFWJMHzAgtcJWEuuS8T0XAX0Df
 CQuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlzO6DygX6rbKaBjiIm7o3zINtWMMp6HZPpcZZNyeZTFRwfCY+ZhK3wIiqyi2kqTYiAseF5HYojHDt@nongnu.org
X-Gm-Message-State: AOJu0Yxv0PlavuWv/2JtfjzrIfAn3ZzSFefxLBrThIzNxI/qCNkyvYKo
 Tr5Z5wNvTv652CSQpXw7oRZqNmqPDPfOqH2J3yAVcehGuoJZaGAKE2vjiVNP+nJFa2CiwEBrOOz
 kJ1k4E2/EnYUDYiWBDGbgkHvsNqARJz67YIQnzG/o+oQZ4qRZ38aY
X-Gm-Gg: ASbGnctayYjLHpjXyVyi7aeeAijGacVuqM5PGrJiXjg1BPR6NED2giUktsEm0BVHmk0
 56AkJ0jnKFxFORUks9BJr38NW8y8+/wgGptBT2rfp4jbXNqG2nHTcaL53VquKFNqXtBFRLkRIAs
 MFgI/9anl8Zggo7brJT6HnZlokmog1DQ4S3spRha9HuQyME48IbqXOhZUOdAx9q53Vs7udsJ59J
 tjw6nX3u49fT0DMxyKndbkF7xJXCZEH0sGnJKWeg6+uDp5jI2TqXAO7mTcQWjaJOHPOqZZ+murn
 8E0HoKKkemw=
X-Received: by 2002:a05:6000:1f87:b0:38f:31fe:6d4f with SMTP id
 ffacd0b85a97d-38f33f4a92emr8117844f8f.34.1739740442527; 
 Sun, 16 Feb 2025 13:14:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCcfk/rQnIeANVPdFt9RiLeoMu7rNZEDAwaP0w18u5jvLsAckUJBoSVENo9Nk/lbq5mXdRQA==
X-Received: by 2002:a05:6000:1f87:b0:38f:31fe:6d4f with SMTP id
 ffacd0b85a97d-38f33f4a92emr8117825f8f.34.1739740442081; 
 Sun, 16 Feb 2025 13:14:02 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38f25915719sm10579620f8f.60.2025.02.16.13.14.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 13:14:01 -0800 (PST)
Message-ID: <2af835ff-e93f-4674-a6ee-9e697109651c@redhat.com>
Date: Sun, 16 Feb 2025 22:13:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/28] x86: Improve operation under QEMU
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Love Kumar
 <love.kumar@amd.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Philip Oberfichtner <pro@denx.de>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, qemu-devel@nongnu.org,
 Tom Rini <trini@konsulko.com>
References: <20250216204421.3560012-1-sjg@chromium.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2/16/25 21:43, Simon Glass wrote:
> U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but it
> is not perfect.
> 
> With both builds, executing the VESA ROM causes an intermittent hang, at
> least on some AMD CPUs.
> 
> With qemu-x86_64 kvm cannot be used since the move to long mode (64-bit)
> is done in a way that works on real hardware but not with QEMU. This
> means that performance is 4-5x slower than it could be, at least on my
> CPU.

Do you have a reproducer for this?  It shouldn't happen... also, do you 
know if this is broken for both Intel and AMD CPUs?

Thanks,

Paolo

> We can work around the first problem by using Bochs, which is anyway a
> better choice than VESA for QEMU. The second can be addressed by using
> the same descriptor across the jump to long mode.
> 
> With an MTRR fix this allows booting into Ubuntu on qemu-x86_64
> 
> Changes in v2:
> - Redo commit message
> - Add new patch to rename the _D dirty flag
> - Add new patch to support CPU functions in long mode
> - Add new patch to tidy up address size in MTRR calculations
> - Add new patch with a 64-bit version of is_power_of_2()
> - Add new patch to set an MTRR for the RAM in QEMU
> - Add new patch with a helper to send characters
> - Add new patch to allow tests to be filtered by role
> - Add more patches to support booting with kvm
> - Add new patch with a test for booting Ubuntu 24.04
> 
> Simon Glass (28):
>    x86: Expand x86_64 early memory
>    x86: qemu: Switch to bochs display
>    x86: qemu: Enable dhrystone
>    x86: qemu: Avoid accessing BSS too early
>    x86: Drop mpspec from the SPL build
>    x86: Add some log categories
>    x86: Drop use of CONFIG_REALMODE_DEBUG
>    x86: Avoid clearing the VESA display
>    x86: Add 64-bit entries to the GDT
>    x86: Use defines for the cache flags
>    x86: spl: Drop duplicate CPU init
>    x86: Drop the message about features missing in 64-bit
>    x86: Include stdbool.h in interrupt header
>    x86: Tidy up the GDT size in start/16.S
>    x86: Disable paging before changing to long mode
>    x86: Use the same GDT when jumping to long mode
>    x86: Use a simple jump into long mode
>    x86: Rename the _D dirty flag
>    x86: Support CPU functions in long mode
>    x86: Tidy up address size in MTRR calculations
>    Add a 64-bit version of is_power_of_2()
>    x86: Support MTRRs of 4GB on 32-bit machines
>    x86: emulation: Set an MTRR for the RAM
>    scripts: Expand a few options
>    test/py: Add a helper to send characters
>    test/py: Allow tests to be filtered by role
>    RFC: test/py: Deal with timeouts
>    test: Add a test for booting Ubuntu 24.04
> 
>   .gitlab-ci.yml                   |  5 +++
>   arch/x86/cpu/cpu.c               | 24 +++++++++++++++
>   arch/x86/cpu/i386/call64.S       | 35 +++++++++------------
>   arch/x86/cpu/i386/cpu.c          | 41 +++++++++---------------
>   arch/x86/cpu/mtrr.c              | 12 +++++---
>   arch/x86/cpu/qemu/dram.c         | 15 +++++++++
>   arch/x86/cpu/qemu/qemu.c         | 20 ++++++++----
>   arch/x86/cpu/start.S             |  4 ++-
>   arch/x86/cpu/start16.S           |  3 +-
>   arch/x86/cpu/x86_64/cpu.c        |  5 ---
>   arch/x86/include/asm/cpu.h       | 35 ++++++++++++++++++---
>   arch/x86/include/asm/interrupt.h |  1 +
>   arch/x86/include/asm/processor.h |  5 ++-
>   arch/x86/lib/Makefile            |  2 ++
>   arch/x86/lib/bios.c              | 27 +++++++++-------
>   arch/x86/lib/bios_interrupts.c   |  8 ++---
>   arch/x86/lib/i8259.c             |  2 ++
>   arch/x86/lib/spl.c               |  4 +--
>   configs/qemu-x86_64_defconfig    | 10 +++---
>   configs/qemu-x86_defconfig       |  6 ++--
>   include/linux/log2.h             |  6 ++++
>   scripts/build-qemu.sh            |  4 +--
>   test/py/conftest.py              | 22 +++++++++++++
>   test/py/console_base.py          | 33 ++++++++++++--------
>   test/py/pytest.ini               |  1 +
>   test/py/tests/test_distro.py     | 53 ++++++++++++++++++++++++++++++++
>   test/py/tests/test_sleep.py      |  1 +
>   27 files changed, 273 insertions(+), 111 deletions(-)
>   create mode 100644 test/py/tests/test_distro.py
> 


