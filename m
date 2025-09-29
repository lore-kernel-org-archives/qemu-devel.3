Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2096FCAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3FOt-0007yy-5i; Mon, 29 Sep 2025 11:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3FOs-0007yj-8d
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:02:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3FOm-0001a9-CQ
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:02:48 -0400
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-3ecde0be34eso2971601f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759158162; x=1759762962; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m49U4isjpUkDcLUghbz7bVfqgnyaOW7WPHUnH/KfgYU=;
 b=bTAKrvR3TM7giDJcEeYnIsjzA0SzJrVbbkdB85+LjklwysyrdrLQ7YPOTTqM3oM57T
 T5VepqZQ/Ys2UN1YWPZtYURPxBleYT51Xbta3vxv1FUjvSn7V6+tLB+RkFEggkVaRipy
 Z82BmV/G5oYP3eWXYDJRkz72lU3WiAzObf1Hp/amLoWcByRMORmPCVG82YoKGwGsrttj
 5D4Y4srfMGeT/JT6Vf/VwNhI56JJiwigdcx/uaciwnqZrwyv/st0VkBIBJiuuEFO+IY6
 y5sP7neQW617r1AFXtL8II/7y4xn1ESIIqoKqns6kwZJXKCaAT4hbNPZK4+g8HKfrVFO
 5Xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759158162; x=1759762962;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m49U4isjpUkDcLUghbz7bVfqgnyaOW7WPHUnH/KfgYU=;
 b=w3Pp6Fj80EwPKZm8cYP3TgcxAs5K4LqQGzl/WpXLBGv+ggXzJ0QIqYMwNUxMuRbAMN
 od/+Ltqcjx2VNrDn2X1gIGZZ7gXM01FpDYYZZd53x3tQVPxxs+Oqb2EYi8dB+4hrGGPP
 B6tnaYjg217aqpfDGEu/YkyD5mqib4zHwJjeVcxBxRqTy8r2VcBcsV7G6yVZB1002Q+I
 vo/IeHbIyQpZ4h9IJhufNWURhO2mc5s6aC14rPbV4khqOSOa7eVcyUkBVDI49h8Q2syr
 5NcynhV1D1d/RA+4RYd87qSEsURJK5yMYLXyBSlRr18REsrbPeJ0sZOKz9MxLwDI6bY1
 nwXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjAfOSI53Y2xHo+6Y962HtFsKaJ+FShP/pSWzJcKpZP54YPQhc3TVAlUk8PVYKLa+hDof9hz46kQBE@nongnu.org
X-Gm-Message-State: AOJu0YyN6CLZzK47keUzuzDmFpr/C0qCjQh0zEnHWDvAgsHqelRARMaB
 elbkayTEmzkFcB0mMLR+Y/0s+lhs83FDYc4GYR0i35eNk2raSBQB5YzIekM5DCeQyv4=
X-Gm-Gg: ASbGncuRzjavkInkALcG0Ohtk2mgY57Ebd3/qgFEnR5JoDBXOcxCKBo8S+s+tKPVq27
 0VmkRl+X+DtQKT2bISKyNu3VH07z7vjZi3cHV2Ocyjxh7Ivx7qWNr7/5FWRF/S8ugrkIytPMMKJ
 lUNcmWf+5vmrd9Pkbqbs3bFc8hLi0ZxMOWu6nVXs2UL8pOYxTfubu3XxaId2ygUPNI0QXc1x11W
 ZoJEyzwi3gIpxev9HxQbDt8Ct8Mb8QhI3m/TiHHH1S/h9m4HTa/uxGa9HxgSMPOGwMf3ZvEq49v
 O0pFljN7xSrRST9/Cjlm24cyZjPb9mGckG+1zyzESDA/W8+wBZR3gZUIakC2UzoaZMv+1RhKeao
 GxscDwn6I61P3Y5rfOO3G3CXqupED8dw5Y/RVptETKS2aYMrhmuYaNJr9D2aWP8MbfUPujMzSZZ
 5L
X-Google-Smtp-Source: AGHT+IGoFcA7uigskLCUeIpbv8IdrNM2olVbn+dup0d1MNX3vkEvLbtw2j5usoWrgk8HV9PtKobxJA==
X-Received: by 2002:a05:6000:1862:b0:3df:9ba8:21a3 with SMTP id
 ffacd0b85a97d-424113fe1c4mr872340f8f.18.1759158161638; 
 Mon, 29 Sep 2025 08:02:41 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc6de90f9sm18773002f8f.48.2025.09.29.08.02.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 08:02:41 -0700 (PDT)
Message-ID: <e6d4526c-6b3e-4b95-9d6b-54823a219a47@linaro.org>
Date: Mon, 29 Sep 2025 17:02:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] system: Don't leak CPU AddressSpaces
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Salil Mehta <salil.mehta@huawei.com>
References: <20250929144228.1994037-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250929144228.1994037-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x444.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Cc'ing Salil for previous discussions on
https://lore.kernel.org/qemu-devel/20230918160257.30127-1-philmd@linaro.org/

On 29/9/25 16:42, Peter Maydell wrote:
> When a vCPU is created, it typically calls cpu_address_space_init()
> one or more times to set up its address spaces. We don't currently
> do anything to destroy these address spaces, which means that we
> will leak them on a vcpu hot-plug -> hot-unplug cycle.
> 
> This patchset fixes the leak by replacing the current
> cpu_address_space_destroy() (which has an awkward API, includes
> a bug, and is never called from anywhere) with a new
> cpu_destroy_address_spaces() which cleans up all the ASes a CPU
> has and is called from generic unrealize code.
> 
> Patch 1 is just a comment improvement to clarify that
> address_space_destroy() defers most of its work to RCU and you
> can't free the memory for the AS struct itself until it's done.
> 
> Patch 2 is from Peter Xu; we need to be able to do "destroy and
> free an AS" via RCU, and at the moment you can't do that.
> 
> Patch 3 is the bugfix proper.
> 
> thanks
> -- PMM
> 
> Peter Maydell (2):
>    include/system/memory.h: Clarify address_space_destroy() behaviour
>    physmem: Destroy all CPU AddressSpaces on unrealize
> 
> Peter Xu (1):
>    memory: New AS helper to serialize destroy+free
> 
>   include/exec/cpu-common.h          | 10 ++++-----
>   include/hw/core/cpu.h              |  1 -
>   include/system/memory.h            | 24 ++++++++++++++++++---
>   hw/core/cpu-common.c               |  1 +
>   stubs/cpu-destroy-address-spaces.c | 15 +++++++++++++
>   system/memory.c                    | 20 +++++++++++++++++-
>   system/physmem.c                   | 34 ++++++++++++++----------------
>   stubs/meson.build                  |  1 +
>   8 files changed, 78 insertions(+), 28 deletions(-)
>   create mode 100644 stubs/cpu-destroy-address-spaces.c
> 


