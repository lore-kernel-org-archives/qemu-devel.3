Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C5DCF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 08:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st0zM-0002lS-Mt; Tue, 24 Sep 2024 04:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1st0zJ-0002aO-T5
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 04:33:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1st0zH-00027U-Gz
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 04:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727166814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Otjy7gqwp3DyWtSWvucIPdY6jcaz552jth+hDo280lY=;
 b=OlDQRyWK8sSgclTXdtBVGcqRJLQfDa35TR6b+/+cLZual2wP5Hv0xw5K/dOQud4K5BddaA
 3zVnl8GSq9PPbbIgeQRSsq9kOjvmtR1IDm0dyelR8EiHAP/pOyr8wR2HPt3az0p3+KPEnF
 SlwxZeNTx6LBMRBhGzXjH+EJmDNmC44=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-tPJ6yfWLMjK_FkmiTVFRjg-1; Tue, 24 Sep 2024 04:33:30 -0400
X-MC-Unique: tPJ6yfWLMjK_FkmiTVFRjg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a7d2d414949so396764666b.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 01:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727166809; x=1727771609;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Otjy7gqwp3DyWtSWvucIPdY6jcaz552jth+hDo280lY=;
 b=Lh3rP+bQa3xBlC74UxFpnMxiPVUnTAlAiUuCThpID8vaVt1sU3svoV3/CQ/cbwMqzP
 cDDN2yI+l9EC/EjP5F4+Hg1ThJ5agZJ4sLbaUxiC2721H43pckxp1za2yI5jZgl6Ix+Y
 1ONdGPxqvsJ4d2f8ZWTJmGI5hLsndTI/r68ooAyxWmq9jo4AL+BCdBLHbdz3+HJiYc5d
 4IO1dlyNDq9HFwk8MbSRt8EmbJTY0LE4M/H1w7AfDCLdnbl059iaHBp6kg7FZ4bxM/5t
 uVCe/LDHH1tQg6r0IRsgHGVH5CMe8UpSxK3xo1f5vSKIA02zXM2xG6ygX033rr7UGG/o
 e3yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj1lMCcgQHUhH4zV1o9vsscC6zqReWN5ENwbFF+6x69dQyeXiWuQeFdzNqqShIMsXeiAl+Ir914Avz@nongnu.org
X-Gm-Message-State: AOJu0YzxM76qT8pBAEk0u4qwW0d81hew26GQ1/WogIK4eEQgSFy3Epb9
 mVU/Ze5ZVPvPnNkwy2NrOz5rojU4J2tDDMHeR0iy0qs8jmUn6rAzyo1CNWtb3lAEOXAsMhbI19M
 twQYJRpgJO6Fz4eeORKEIReq3jYvWCwpbOS4fgWGjkW/A8EmPh0se
X-Received: by 2002:a17:907:f725:b0:a8b:154b:7649 with SMTP id
 a640c23a62f3a-a90d55dd8b2mr1332727866b.15.1727166809587; 
 Tue, 24 Sep 2024 01:33:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiHzdhOzuVuUPJq78tl5OkiR/kJhd7Xtjew12hUXgnBlmGhlWFcJfO98wbKg0ZmnrejtLbjA==
X-Received: by 2002:a17:907:f725:b0:a8b:154b:7649 with SMTP id
 a640c23a62f3a-a90d55dd8b2mr1332725166b.15.1727166809166; 
 Tue, 24 Sep 2024 01:33:29 -0700 (PDT)
Received: from [10.5.51.18] (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93931343cfsm55994966b.193.2024.09.24.01.33.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2024 01:33:28 -0700 (PDT)
Message-ID: <2a7c68aa-e493-44e9-8e9b-7c91088ad0f2@redhat.com>
Date: Tue, 24 Sep 2024 10:33:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/23] E500 Cleanup
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
 <cbc6d0f4-ab9d-46c5-862f-aac83c91af3a@redhat.com>
 <E8877813-B07A-41A7-AF76-2564ECC02336@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <E8877813-B07A-41A7-AF76-2564ECC02336@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/23/24 23:25, Bernhard Beschow wrote:
> 
> 
> 
> Am 23. September 2024 20:23:54 UTC schrieb "Cédric Le Goater" <clg@redhat.com>:
>> Hello Bernhard,
> 
> Hi Cédric,
> 
>>
>> On 9/23/24 11:29, Bernhard Beschow wrote:
>>> This series is part of a bigger series exploring data-driven machine creation
>>> using device tree blobs on top of the e500 machines [1]. It contains patches to
>>> make this exploration easier which are also expected to provide value in
>>> themselves.
>>>
>>> The cleanup starts with the e500 machine class itself, then proceeds with
>>> machine-specific device models and concludes with more or less loosely related
>>> devices. Device cleanup mostly consists of using the DEFINE_TYPES() macro.
>>
>> Since you recently took a look at the machine models, would you
>> be willing to take over maintenance of the e500 ? It shouldn't
>> be an enormous amount of work.
> 
> Are you referring to the machine and related devices or the CPU? I'm somewhat familiar with the P102x and could take over but the CPU would be a different beast.

Please take a look at the MAINTAINERS file. You will see it is not
that large and the CPU target models are not part of it.


Thanks,

C.

  


> 
> Best regards,
> Bernhard
> 
>>
>> Thanks,
>>
>> C.
>>
>>
>>
>>> [1] https://github.com/shentok/qemu/tree/e500-fdt
>>>
>>> Bernhard Beschow (23):
>>>     hw/ppc/e500: Do not leak struct boot_info
>>>     hw/ppc/e500: Reduce scope of env pointer
>>>     hw/ppc/e500: Prefer QOM cast
>>>     hw/ppc/e500: Remove unused "irqs" parameter
>>>     hw/ppc/e500: Add missing device tree properties to i2c controller node
>>>     hw/ppc/e500: Use SysBusDevice API to access TYPE_CCSR's internal
>>>       resources
>>>     hw/ppc/e500: Extract ppce500_ccsr.c
>>>     hw/ppc/ppce500_ccsr: Log access to unimplemented registers
>>>     hw/ppc/mpc8544_guts: Populate POR PLL ratio status register
>>>     hw/i2c/mpc_i2c: Convert DPRINTF to trace events for register access
>>>     hw/i2c/mpc_i2c: Prefer DEFINE_TYPES() macro
>>>     hw/pci-host/ppce500: Reuse TYPE_PPC_E500_PCI_BRIDGE define
>>>     hw/pci-host/ppce500: Prefer DEFINE_TYPES() macro
>>>     hw/gpio/mpc8xxx: Prefer DEFINE_TYPES() macro
>>>     hw/ppc/mpc8544_guts: Prefer DEFINE_TYPES() macro
>>>     hw/net/fsl_etsec/etsec: Prefer DEFINE_TYPES() macro
>>>     hw/intc: Guard openpic_kvm.c by dedicated OPENPIC_KVM Kconfig switch
>>>     hw/sd/sdhci: Prefer DEFINE_TYPES() macro
>>>     hw/block/pflash_cfi01: Prefer DEFINE_TYPES() macro
>>>     hw/i2c/smbus_eeprom: Prefer DEFINE_TYPES() macro
>>>     hw/rtc/ds1338: Prefer DEFINE_TYPES() macro
>>>     hw/usb/hcd-ehci-sysbus: Prefer DEFINE_TYPES() macro
>>>     hw/vfio/platform: Let vfio_start_eventfd_injection() take
>>>       VFIOPlatformDevice pointer
>>>
>>>    MAINTAINERS              |   2 +-
>>>    hw/ppc/e500-ccsr.h       |   2 +
>>>    hw/ppc/e500.h            |   8 +++
>>>    hw/block/pflash_cfi01.c  |  21 +++----
>>>    hw/gpio/mpc8xxx.c        |  22 +++-----
>>>    hw/i2c/mpc_i2c.c         |  29 +++++-----
>>>    hw/i2c/smbus_eeprom.c    |  19 +++----
>>>    hw/net/fsl_etsec/etsec.c |  22 +++-----
>>>    hw/pci-host/ppce500.c    |  54 ++++++++----------
>>>    hw/ppc/e500.c            |  61 +++++---------------
>>>    hw/ppc/mpc8544_guts.c    |  32 +++++++----
>>>    hw/ppc/ppce500_ccsr.c    |  67 ++++++++++++++++++++++
>>>    hw/rtc/ds1338.c          |  20 +++----
>>>    hw/sd/sdhci.c            |  62 +++++++++-----------
>>>    hw/usb/hcd-ehci-sysbus.c | 118 +++++++++++++++++----------------------
>>>    hw/vfio/platform.c       |   7 +--
>>>    hw/i2c/trace-events      |   5 ++
>>>    hw/intc/Kconfig          |   4 ++
>>>    hw/intc/meson.build      |   3 +-
>>>    hw/ppc/meson.build       |   1 +
>>>    hw/ppc/trace-events      |   3 +
>>>    21 files changed, 285 insertions(+), 277 deletions(-)
>>>    create mode 100644 hw/ppc/ppce500_ccsr.c
>>>
>>
> 


