Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8820ED2E9D5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 10:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tARzM-0000Tl-Ce; Mon, 11 Nov 2024 05:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tARzK-0000TI-P9
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 05:49:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tARzH-0007rz-Bu
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 05:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731322177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qqBWWa0TGqWAIwUik/jS7GaENETpjUX+Kzlz31zDDDY=;
 b=WCKccCJ0fuUyF65GGWJCWekhiJdmLU6hqdXwx9uqzzEiZl82a2BSNNbmDUOUzdK8HKGtRG
 k6VLOlOWXBZFiW9qxLXmLn3MbcqXfGmjmH3Jznr3SoxbkiP+Ob8CGyNW7+TVs3yfvRQNFs
 4iqgzhy4fp8YxZXVFHmO6FnCCb5iHwY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-DwpCHRMpML6SQmkHqRInTA-1; Mon, 11 Nov 2024 05:49:29 -0500
X-MC-Unique: DwpCHRMpML6SQmkHqRInTA-1
X-Mimecast-MFC-AGG-ID: DwpCHRMpML6SQmkHqRInTA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315b7b0c16so34025785e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 02:49:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731322168; x=1731926968;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qqBWWa0TGqWAIwUik/jS7GaENETpjUX+Kzlz31zDDDY=;
 b=psfoBnRZ4Jz1+paEB2sWsCHNmr7vxAWLpsqHK26bB+C9oWfYtr9g5Ws6FuuyeEenbN
 MW/WkeI+f7lzAAoHOid0YEbSnpYVkpmtzW6dnj25YBJiQgJcl1rtEs5VwfTWOTLf9WzA
 uUrQNiYqnhPqzLjCbfhO6dzXXy83x3FuOOyBg+IN56k/jnhkf+eBJ11dxiUcYjUCjZz+
 jZc/SahVyaJt+PJs5CXr9boQqPSlpH/NB0QBWE4EXZubRX+gDaG4jjEu3i7ThUlwxPnI
 LDW6j0uKCSZ79nSxOYzjyEe1vZPd0c49bCJBQhuOYI/Wvtfssgy4/V7VN/1Bo9z7BVYn
 XmCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7TBKSDZXWt0zqXs1qSlcFg0dJbGMSzqObaSIFxFby+SIYadhWTQ1bUVKX5Q2fPbDV4OjzqbEHxlgZ@nongnu.org
X-Gm-Message-State: AOJu0YyPtkTZ0PsDdQjTY32I/jrLEtL9W9rpRAsNnNU3KddrNYWEuR4U
 yVGK2y+vAIiwX2oVuItwegzXcZqtrif9wmrIZxr9FM2/mIGHACMzOE63ldRdpIJqK0PenCYsa7e
 xkWPZ9J0TxkGpQtNSNNyERAWZcxePNPMmW6iKWJwQ7AHeaMdDNf5Q
X-Received: by 2002:a05:600c:138a:b0:431:59ab:15cf with SMTP id
 5b1f17b1804b1-432b75061c3mr105666485e9.19.1731322168568; 
 Mon, 11 Nov 2024 02:49:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXkI5pPr+weqMNwwB5rwH24e+oVn0SHNeUsw/LLxWlGI3WqyCacnmj9Ex66UfSimAoDmlRmQ==
X-Received: by 2002:a05:600c:138a:b0:431:59ab:15cf with SMTP id
 5b1f17b1804b1-432b75061c3mr105666215e9.19.1731322168165; 
 Mon, 11 Nov 2024 02:49:28 -0800 (PST)
Received: from ?IPV6:2003:cb:c730:4300:18eb:6c63:a196:d3a2?
 (p200300cbc730430018eb6c63a196d3a2.dip0.t-ipconnect.de.
 [2003:cb:c730:4300:18eb:6c63:a196:d3a2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa73a2d8sm203014405e9.41.2024.11.11.02.49.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 02:49:27 -0800 (PST)
Message-ID: <5f8db586-cdda-4d00-be02-f9880a20e1a3@redhat.com>
Date: Mon, 11 Nov 2024 11:49:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] Initialize nr_cores and nr_threads early and
 related clearup
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Brian Cain <bcain@quicinc.com>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20241108070609.3653085-1-xiaoyao.li@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241108070609.3653085-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 08.11.24 08:06, Xiaoyao Li wrote:
> This series is extracted from TDX QEMU v6[1] series per Paolo's request.
> 
> It is originally motivated by x86 TDX to track CPUID_HT in env->features[]
> which requires nr_cores and nr_cores being initialized earlier than in

"and nr_threads"

> qemu_init_vcpu().
> 
> Initialize of nr_cores and nr_threads earlier in x86's cpu_realizefn()
> can make it work for x86 but it's duplicated with the initialization in
> qemu_init_vcpu() which are used by all the ARCHes. Since initialize them
> earlier also work for other ARCHes, introduce qemu_init_early_vcpu() to
> hold the initialization of nr_cores and nr_threads and call it at the
> beginning in realizefn() for each ARCH.
> 
> Note, I only tested it for x86 ARCH. Please help test on other ARCHes.

[...]

>   accel/tcg/user-exec-stub.c |  4 +++
>   hw/core/cpu-common.c       |  2 +-
>   include/hw/core/cpu.h      |  8 +++++
>   system/cpus.c              |  6 +++-
>   target/alpha/cpu.c         |  2 ++
>   target/arm/cpu.c           |  2 ++
>   target/avr/cpu.c           |  2 ++
>   target/hexagon/cpu.c       |  2 ++
>   target/hppa/cpu.c          |  2 ++
>   target/i386/cpu.c          | 61 +++++++++++++++++++-------------------
>   target/loongarch/cpu.c     |  2 ++
>   target/m68k/cpu.c          |  2 ++
>   target/microblaze/cpu.c    |  2 ++
>   target/mips/cpu.c          |  2 ++
>   target/openrisc/cpu.c      |  2 ++
>   target/ppc/cpu_init.c      |  2 ++
>   target/riscv/cpu.c         |  2 ++
>   target/rx/cpu.c            |  2 ++
>   target/s390x/cpu.c         |  2 ++
>   target/sh4/cpu.c           |  2 ++
>   target/sparc/cpu.c         |  2 ++
>   target/tricore/cpu.c       |  2 ++
>   target/xtensa/cpu.c        |  2 ++
>   23 files changed, 85 insertions(+), 32 deletions(-)

Hm. It looks like this belongs into the parent realize function. But the 
"bad thing" is that we call the parent realize function after we try 
realizing the derived CPU.

Could it go into cpu_common_initfn()?

-- 
Cheers,

David / dhildenb


