Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E13C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhatP-0000Rw-0E; Thu, 31 Jul 2025 17:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhacd-0007zh-Tb
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:15:31 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhacb-0005cj-Kq
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:15:31 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4561a4a8bf2so2150295e9.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753996527; x=1754601327; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lxyC96YJ32T5kM/PzD3nvJ4jJyZEPc/2DQdxz6XDevY=;
 b=ZehZYIowVF/d0OsK+KP4JfkgdqbeX6r25dUzKWHZgcQ0Cy0dLaBN7c5UzLJn3hKFsQ
 6QJEGDNlH9MssBdxc755PS55/hcsRdEyM7cqSjewpzKv1grfscw67JN2sKxvox/GTIaQ
 dYasX1/NDK0nf/s6r1JQSs3MUVPpQwSdkyaE0N0ENt1gNYsV1fqzcZSOB+t2jBW5wL0V
 xu/BANK9XwrMxyIZbHO+CZ3kIqxTbGNUH9Npp+CrSqdjlXmRPEj0f9ECcr4G1hhBAOZL
 5VNsX8PLIkF4qlnRxehvhV3HRGzQ0VLypO2MupHAWBqE64a03BJeCIoANg0/STnJOqrd
 lG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753996527; x=1754601327;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lxyC96YJ32T5kM/PzD3nvJ4jJyZEPc/2DQdxz6XDevY=;
 b=hkcm7gsljsaI5s1KO6uqWqKRKf7i/Hd+Juc6xSwN6ycsW+KZH5XsKmrnTxXhH/dcn9
 p9zeIg3ecMwJPbjiegqxQ9gU7SI9x2dvJpC2L4YTLE9tPzAJpNpfytpyFA0QfAb9dowL
 LO3Kd/O+0ZIi6+NoLely2MKXbw3Uus3pS5/He8LwyLbuA7020ONnUsQCmFguQcVZRfZd
 julGP2JtJLa2m/4OnyLG14InQ+Vh5EpoE3Owe0nhR3tAX0JVYw02z7R2mHB9HousijkG
 gYRA6o4x+5RI7rQ2vMD//YUdv/Dy6m3Y57HnlT3x7iNlBjR/4+Sw9CfoNWnD6pOC4VlS
 Z8uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsh52GvYIHsnc4C2Xg+u+RbNZM8S3mJQ/hBxt8a3S/MLa1ae0ZmNj22VGSb9DE8eHM/6AiZI75d23F@nongnu.org
X-Gm-Message-State: AOJu0YwAAHZmDPV9r1SADxz4FCPhc8cJUrp2KVo0EqdNdydNtbcUacso
 lRJ87jMw5OZ4KB2Z9PotSI7QxJYxnOVbz4V7TIqTPztxK6lT+7aCm2lNWbwIbJcQ7rBcpSWFb0P
 n5Mei
X-Gm-Gg: ASbGncv4SOIstYqKpUt2MPt+9tvwlV9teFsIz2/W3lwh8mj1LxpmrKO5lJU4o1jserm
 OwvZWHg5RuKdJ5Vc7CBGX39iZ+zLaS5ypZXaZOAj9fg7l4DqTANlTIM+ZPifg1DlJijQCdmuxSR
 9ca8OpVrqX7RF+TXpEXqcAZ7RHDl1KIRiljiB7Q8oxwg/kPWTZ4RS02WcVhu7nUOUjV3sm8u0Uy
 IclACsgUkuvWgtRh0vYqmE8L5mP/ULrAlQXTYcqAQs8gjN1tF2rFyC9l29lRLbp4KFhuGlVOP6s
 1tNWmnYFVhU6zDqW5jm4oqgmrZHZAmMzNQ8OUQEneVbzkBtTL0HRC5jGdZv0xM9CzacGmHYcxLG
 hi3PWkVTAqTaXyzrqpxsY+liJGNc5VSSHKzEY0AKATBe+91+9+MVmuL1mDxa1M8Mcqy4cCsEX77
 Lu
X-Google-Smtp-Source: AGHT+IGHkZn0JfcxoCAUrmcP8wrkmAfLOnAVRJCVARYZT6f5Dws6/qXV8m9tLSLCRssg1BZdlDi3Yw==
X-Received: by 2002:a05:600c:1c2a:b0:455:f59e:fd79 with SMTP id
 5b1f17b1804b1-45892b9d991mr74285595e9.11.1753996526943; 
 Thu, 31 Jul 2025 14:15:26 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458a22365c0sm37513215e9.3.2025.07.31.14.15.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:15:26 -0700 (PDT)
Message-ID: <0bc97509-430d-470a-99f4-54c7b4ae8bc8@linaro.org>
Date: Thu, 31 Jul 2025 23:15:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Reinvent BQL-free PIO/MMIO
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com, mst@redhat.com,
 mtosatti@redhat.com, kraxel@redhat.com, peter.maydell@linaro.org,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>
References: <20250730123934.1787379-1-imammedo@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250730123934.1787379-1-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Cc'ing Alex, Darren and Bandan.

On 30/7/25 14:39, Igor Mammedov wrote:
> v2:
>    * Make both read and write pathes BQL-less (Gerd)
>    * Refactor HPET to handle lock-less access correctly
>      when stopping/starting counter in parallel. (Peter Maydell)
>    * Publish kvm-unit-tests HPET bench/torture test [1] to verify
>      HPET lock-less handling
> 
> When booting WS2025 with following CLI
>   1)   -M q35,hpet=off -cpu host -enable-kvm -smp 240,sockets=4
> the guest boots very slow and is sluggish after boot
> or it's stuck on boot at spinning circle (most of the time).
> 
> pref shows that VM is experiencing heavy BQL contention on IO path
> which happens to be ACPI PM timer read access. A variation with
> HPET enabled moves contention to HPET timer read access.
> And it only gets worse with increasing number of VCPUs.
> 
> Series prevents large VM vCPUs contending on BQL due to PM|HPET timer
> access and lets Windows to move on with boot process.
> 
> Testing lock-less IO with HPET micro benchmark [1] shows approx 80%
> better performance than the current BLQ locked path.
> [chart https://ibb.co/MJY9999 shows much better scaling of lock-less
> IO compared to BQL one.]
> 
> In my tests, with CLI WS2025 guest wasn't able to boot within 30min
> on both hosts
>    * 32 core 2NUMA nodes
>    * 448 cores 8NUMA nodes
> With ACPI PM timer in BQL-free read mode, guest boots within approx:
>   * 2min
>   * 1min
> respectively.
> 
> With HPET enabled boot time shrinks ~2x
>   * 4m13 -> 2m21
>   * 2m19 -> 1m15
> respectively.
> 
> 1) "[kvm-unit-tests PATCH v4 0/5] x86: add HPET counter tests"
>      https://lore.kernel.org/kvm/20250725095429.1691734-1-imammedo@redhat.com/T/#t
> PS:
> Using hv-time=on cpu option helps a lot (when it works) and
> lets [1] guest boot fine in ~1-2min. Series doesn't make
> a significant impact in this case.
> 
> PS2:
> Tested series with a bunch of different guests:
>   RHEL-[6..10]x64, WS2012R2, WS2016, WS2022, WS2025
> 
> PS3:
>   dropped mention of https://bugzilla.redhat.com/show_bug.cgi?id=1322713
>   as it's not reproducible with current software stack or even with
>   the same qemu/seabios as reported (kernel versions mentioned in
>   the report were interim ones and no longer available,
>   so I've used nearest released at the time for testing)
> 
> Igor Mammedov (6):
>    memory: reintroduce BQL-free fine-grained PIO/MMIO
>    acpi: mark PMTIMER as unlocked
>    hpet: switch to fain-grained device locking
>    hpet: move out main counter read into a separate block
>    hpet: make main counter read lock-less
>    kvm: i386: irqchip: take BQL only if there is an interrupt
> 
>   include/system/memory.h | 10 +++++++
>   hw/acpi/core.c          |  1 +
>   hw/timer/hpet.c         | 64 +++++++++++++++++++++++++++++++++++------
>   system/memory.c         |  6 ++++
>   system/physmem.c        |  2 +-
>   target/i386/kvm/kvm.c   | 58 +++++++++++++++++++++++--------------
>   6 files changed, 111 insertions(+), 30 deletions(-)
> 


