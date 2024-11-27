Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BADFD5A6DA
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 04:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG9jf-0008Q9-Je; Tue, 26 Nov 2024 23:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1tG9jd-0008Pm-Jo
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 23:33:05 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1tG9jb-0001Fd-0e
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 23:33:05 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3ea49cc8b88so1459795b6e.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 20:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1732681980; x=1733286780;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KuyV35kDHBuCE/NOASw5LnaCOMCBbNtEhwel8NnzjQU=;
 b=oEB8t4WeLJH5RSpf9utvajZlaQ4YD9WDNkmW3ykQiTsMN6x7gypoRDjb3axHjCnQOA
 uTnjE5T4tTl2hB7bYG0pxNb8IHDTHbwktwADkHQ9z08iHAWOlSdIDMup+MuQxAfcF3Fi
 Cqo9MYZCn8gjYzAZ7bJa8quoPbcVgWtvIz2buYodb/VmHzTb2rug+6fJ2PyfBlJPcMnd
 j/E8NahF6JUphry1O3YgoH7L0T8IbMb30tLdauNA7N1oWk9+CQjdw27isprrK+izK0Ym
 nITPxUI6ecFOfZCLSlnBDnsDIvw49k+od+3mW5q/bE2c/WZ9JiteCjKYWiT8fP8loWMm
 Jpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732681980; x=1733286780;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KuyV35kDHBuCE/NOASw5LnaCOMCBbNtEhwel8NnzjQU=;
 b=CZNbSNZTyo6WEMJ7YDeG5RnGv6IDYQg5o/ZN1x7ND6uGyWDQzhSq3DyNGIrcjHIH/W
 l31veRT3uCQPEFemJVyCIfp3ICM5RMoV79ZI7Sg8bejziSzPOzwx+C5NeQfHjhRvVrqe
 yekO1Q6Lolgh+76eBjB5xKEfGd/re+OIWXjLXNRvG/2K46hskUMOLlKuRCAFEejvOM/N
 p+czahBUTdXUuX6wjCmOsLlfw8BmEdp22U5MG8vQLrkpBtvpLL09rkz6zpUiTu/AQCXx
 tI1JKoKJkJYBasNcUCg96NtOtE5L94DVI0vfsjS6Kz/yFg+DdtWrsxZ+pKGAuUe0n1hP
 nEBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPSRUSarC2TADxVYNP/CNtxyyAxNAmH/YMeSWWJHpk+fH5MV4khAmnbbrCtAVtNcgo1gargVVzBdN6@nongnu.org
X-Gm-Message-State: AOJu0Yy1//EDStgCGZKrIYat+sRuVawTUy0CPtsmYnXeZ0F5rbodiDdA
 ZRp82QoTZsctwp49WLUqbAz09oUDS0w/1BOgjg3f/BU2nM77T4jSDSwHe+2Jm+8=
X-Gm-Gg: ASbGncsYrNLgX2LT9vk2WaDuF5xyjYhpYqkOL70A1OJOUrjf0ZsmDedQbqkWz8iI0dQ
 R7Py3iMOlGkS4ICYeys/oxwRO1tlxoG/XMEIUGveZA2vcnzieA4jUNzmrY1OuJhqBXUx0Nz18tf
 /2WB5fPFN2fm8wo1T0ONst0QDqBiLClRo3JY8SFQbhnPA8WuLvVtZYmECJuNxomRhjVaLahXYFf
 is4g7mooO/OwkmCAaib83z4YxgZqZMTpcVtkJLG6dF9cyhROvPEgcNxgOYMdROpC/3PEbidCjA=
X-Google-Smtp-Source: AGHT+IFmCZMbAATAzEArfZNJqBbBX0mVmrmgAgPukR4leB13vSLplOL9UurZZNslGZv8y4Am13C6Uw==
X-Received: by 2002:a05:6808:181a:b0:3ea:44ae:a65 with SMTP id
 5614622812f47-3ea6db8720emr2111073b6e.5.1732681980690; 
 Tue, 26 Nov 2024 20:33:00 -0800 (PST)
Received: from [10.16.166.2] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724de454bd4sm9533130b3a.26.2024.11.26.20.32.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 20:33:00 -0800 (PST)
Message-ID: <0ace2747-efc8-4c0a-9d9f-68f255f1e3a5@igel.co.jp>
Date: Wed, 27 Nov 2024 13:32:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] support unaligned access to xHCI Capability
To: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>, qemu-devel@nongnu.org
References: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
Content-Language: en-US
Cc: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it,
 qemu-block@nongnu.org, pbonzini@redhat.com, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org, farosas@suse.de, lvivier@redhat.com
From: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
In-Reply-To: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

I would be happy to receive your comments.
ping.

On 2024/11/08 12:29, Tomoyuki HIROSE wrote:
> This patch set aims to support unaligned access to xHCI Capability
> Registers.
>
> To achieve this, we introduce the emulation of an unaligned access
> through multiple aligned accesses. This patch set also adds a test
> device and several tests using this device to verify that the
> emulation functions correctly.
>
> Using these changes, unaligned access to xHCI Capability Registers is
> now supported.
>
> During development, I required a lot of 'MemoryRegionOps' structs with
> its own read/write functions for tests. In the QEMU project, a large
> number of similar functions or structs are often written in '.inc'
> files. I followed this approach for the test functions but would
> appreciate feedback on whether this is appropriate.
>
> Tomoyuki HIROSE (5):
>    hw/nvme/ctrl: specify the 'valid' field in MemoryRegionOps
>    system/memory: support unaligned access
>    hw/misc: add test device for memory access
>    tests/qtest: add test for memory region access
>    hw/usb/hcd-xhci: allow unaligned access to Capability Registers
>
>   hw/misc/Kconfig                         |    4 +
>   hw/misc/memaccess-testdev.c             |  197 +++
>   hw/misc/meson.build                     |    1 +
>   hw/nvme/ctrl.c                          |    5 +
>   hw/usb/hcd-xhci.c                       |    4 +-
>   include/hw/misc/memaccess-testdev.h     |   42 +
>   include/hw/misc/memaccess-testdev.h.inc | 1864 +++++++++++++++++++++++
>   system/memory.c                         |  147 +-
>   system/physmem.c                        |    8 -
>   tests/qtest/memaccess-test.c            |  598 ++++++++
>   tests/qtest/meson.build                 |    9 +
>   11 files changed, 2842 insertions(+), 37 deletions(-)
>   create mode 100644 hw/misc/memaccess-testdev.c
>   create mode 100644 include/hw/misc/memaccess-testdev.h
>   create mode 100644 include/hw/misc/memaccess-testdev.h.inc
>   create mode 100644 tests/qtest/memaccess-test.c
>

