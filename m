Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD357CF6499
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 12:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svFA3-0004lx-DP; Mon, 30 Sep 2024 08:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1svF9w-0004l9-8p
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:05:49 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1svF9q-0000cN-1o
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:05:45 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7db908c9c83so2611448a12.2
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 05:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727697939; x=1728302739; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FdQHNEbEV6iZhS7WMhVekTzkT1jHUG42T8B66/bwrSU=;
 b=OGSsFkgwkZgFhqiR6oSjHk91Zgnl01whKEv98Rrq6wQyrXhqXbssMPiWmZzcmS5brC
 rdyxR3rMUsLUUss7zk2UO4z0MwTd7DTfZO9Z+CMwI/wUHp84bGyNnfcXUc7/YYeGRZDp
 33nSb6zsl9LqiJ4RXFxxfVvteGUIPP0WuAIBqOkkh6FKWZFnaU+maEs5bVvsfK5XDt5g
 iNJqOXZHWAM/eWGNc0tKNd82FR11faBevPX0LrreKcz3ENb0uM1gtNTJi5kWB7yiPwuO
 JS8Oq/wwX1joLsVqwNSMSkboa7zhX7oyFghSNYyjHjapasqZ8cRTYbScqnWcLesArUiG
 XLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727697939; x=1728302739;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FdQHNEbEV6iZhS7WMhVekTzkT1jHUG42T8B66/bwrSU=;
 b=eV/JbfH6QUk1OfxkqZa7NIQ6Kol6Hot1IPewsGA03rzNn4/vOVdW5nez+/qWhDIQ58
 ifJlPrhZ1cRkROQrpcYglte12d9+2IYEGNN5iVHhNpEEa6XGvh1M/7ecU1rSiJutkrxB
 P9RvKdpjWE4n6CfPQELLRWty9P+WrdksfOK0T4QFgU1XTF8t7kALgQGVX1hLM/A6k9fM
 A+JQKtR7r52IP0HuxLRnIEirlm8gswA++lOs3WyOjuhzqqLB/x0GfA0EXBU/xRlwS/3D
 vk+1SpB/g8hXM82ULwpp5mrV5BP4Nn3xf20I591ObPLDd5DY/tsw30/B24qCZFfPmV39
 WSLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqKVnWhyjZsYSBGtfKqoyxsTH0yeRbFmAqwKzvbWn0+KkicqBxZOuUk8FbA+0hE0eb+8b9fCn6ycZn@nongnu.org
X-Gm-Message-State: AOJu0YyVDvwMwqlJQFCTcO0g2J8IOjfB+PcYfgV085rF2N+YSfaPE9Y+
 0R2+NORI3Q/J2ySMyclrqOu1x2Ar8Nah+BhaV2pQCPK2m9Mova0sIQGhtF0rZQk=
X-Google-Smtp-Source: AGHT+IHqZ+q6Csq6Z2iBLDwvmqXSgJExO0xDi/ZXeDrg/+1JE5FIovHy7Y6XdY4n1SBNafe0BBGCkQ==
X-Received: by 2002:a17:90a:644f:b0:2c9:9643:98f4 with SMTP id
 98e67ed59e1d1-2e0b89ac7a2mr13661068a91.5.1727697939415; 
 Mon, 30 Sep 2024 05:05:39 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e06e17208esm11201482a91.11.2024.09.30.05.05.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2024 05:05:39 -0700 (PDT)
Message-ID: <1321dbac-1b5a-41eb-9000-7cc09443fc80@ventanamicro.com>
Date: Mon, 30 Sep 2024 09:05:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/47] riscv-to-apply queue
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, Thomas Huth <thuth@redhat.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
 <CAFEAcA9Sb-fpNhm-6DPwss5zMpw=nEp31Wt6q1OA6DqCg3wKEg@mail.gmail.com>
 <13ee9889-b503-45ea-a074-ffafbd052c4e@ventanamicro.com>
 <CAFEAcA_nn2fUyo9Pkd8jW2NG1oJLbAJrfiC7sziuhGthqL3=4Q@mail.gmail.com>
 <096029d7-269c-44f8-88d3-6f0c52af58fa@ventanamicro.com>
 <CAFEAcA_ZYghG9QoefNnxGFd4Si=viyCWzTD=z19Hr6s+p5rQ1Q@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAFEAcA_ZYghG9QoefNnxGFd4Si=viyCWzTD=z19Hr6s+p5rQ1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52d.google.com
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



On 9/30/24 7:48 AM, Peter Maydell wrote:
> On Sun, 29 Sept 2024 at 21:53, Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>>
>>
>> On 9/29/24 12:38 PM, Peter Maydell wrote:
>>> On Sat, 28 Sept 2024 at 21:40, Daniel Henrique Barboza
>>> <dbarboza@ventanamicro.com> wrote:
>>>>
>>>>
>>>>
>>>> On 9/28/24 8:34 AM, Peter Maydell wrote:
>>>>> The assertion failure is
>>>>> ERROR:../tests/qtest/riscv-iommu-test.c:72:test_reg_reset: assertion
>>>>> failed (cap & RISCV_IOMMU_CAP_VERSION == 0x10): (0 == 16)
>>>>
>>>> The root cause is that the qtests I added aren't considering the endianess of the
>>>> host. The RISC-V IOMMU is being implemented as LE only and all regs are being
>>>> read/written in memory as LE. The qtest read/write helpers must take the qtest
>>>> endianess into account. We make this type of handling in other qtest archs like
>>>> ppc64.
>>>>
>>>> I have a fix for the tests but I'm unable to run the ubuntu-22.04-s390x-all-system
>>>> job to verify it, even after setting Cirrus like Thomas taught me a week ago. In
>>>> fact I have no 'ubuntu-22-*' jobs available to run.
>>>
>>> It's on the private s390 VM we have, so it's set up only to
>>> be available on the main CI run (there's not enough capacity
>>> on the machine to do any more than that). If you want to point
>>> me at a gitlab branch I can do a quick "make check" on that
>>> if you like.
>>
>> I appreciate it. This is the repo:
>>
>> https://gitlab.com/danielhb/qemu/-/tree/pull_fix
> 
> This doesn't fix the assertion. This is because the test (now) does:
> 
>    qpci_memread(&r_iommu->dev, r_iommu->reg_bar, reg_offset,
>                 &reg, sizeof(reg));
> 
>    if (riscv_iommu_qtest_big_endian()) {
>        reg = bswap32(reg);
>    }
> 
> where riscv_iommu_qtest_big_endian() is a wrapper for
> qtest_big_endian(). But qtest_big_endian() queries the
> endianness of the *guest*, and so for riscv it will
> always return false and we will never bswap.

Ooops. My bad.

> 
> If you need to do swapping inline in a test you can use
>    reg = le32_to_cpu(reg);
> which swaps an LE value read from the guest to the host
> CPU's endianness ordering (and similarly with cpu_to_le32
> on the write path).
> 
> But it turns out that libqos provides already functions
> to read/write 32 and 64 bit values from PCI devices:
>     reg = qpci_io_readl(&r_iommu->dev, r_iommu->reg_bar, reg_offset);
> which do the byteswap for you.
> Similarly qpci_io_writel() etc. (The functions work for
> both IO and MEM PCI BARs.)

I'll convert the tests to use qcpi_io_readl/writel and friends. Hopefully this
will fix it.

> 
>> If this is enough to fix the tests, I'll amend it in the new IOMMU version.
>> If we still failing then I'll need to set this s390 VM.
>>
>> By the way, if you have any recipe/pointers to set this s390 VM to share,
>> that would be great.
> 
> It's a VM provided by IBM under their "Community Cloud"
> umbrella: https://community.ibm.com/zsystems/l1cc/


I'll see if I can get something going with the IBM community cloud, but I wonder
how hard it is to launch a s390x TCG guest with Ubuntu. The image is freely
available:

https://cdimage.ubuntu.com/releases/jammy/release/ubuntu-22.04.5-live-server-s390x.iso


But I'm unsure of whether we need some secret sauce/paid key to do the install. Thomas,
do you have more info?


Thanks,


Daniel

> 
> thanks
> -- PMM

