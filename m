Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD502C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 14:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7xkL-0002Vc-NV; Thu, 24 Apr 2025 10:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7xkK-0002Ul-2q
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 10:40:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7xkG-0004EL-AM
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 10:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745505604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=e9+IzIw1toYW40X4FH8cW/7kZvVwglwHYrApGx3lCoM=;
 b=XPSXhz3g3uT7pxeeNzvhHvHwKwOBatoouSILARqfwS4y6FUY2ju+bgXVo6LrF29OPIhx87
 iNPQHjITZ20rVoXEOw0hUISP29S58GESdwQx2FIqkAiwdgaLu/xgUR8ioYkjZ1smIhZo0a
 SVRy8REAe5/YO87Zkf8F8d/lr4VoKI8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-bGoy218fNEqu10Y_JcCrYA-1; Thu, 24 Apr 2025 10:40:01 -0400
X-MC-Unique: bGoy218fNEqu10Y_JcCrYA-1
X-Mimecast-MFC-AGG-ID: bGoy218fNEqu10Y_JcCrYA_1745505600
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cf44b66f7so7894025e9.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 07:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745505600; x=1746110400;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e9+IzIw1toYW40X4FH8cW/7kZvVwglwHYrApGx3lCoM=;
 b=d6qEgXcQguyjAKsb23SYbAu3JbNN+9sCQCDX6WvyX6kU23jS9jL5gMlUZkNY0LGOdT
 rexqyDP4lXieew0C7W/qn9dVN+qF0nHH7AVNNGVzRjVVVlWVkiqa8npcnLJgvzDWktrF
 M3IE12lZia4+2qRuitk+R9TESpKCMkV6Zjzvo/H2Lr1rNgySvHuaDkHTzSk2eNV/ggn9
 GRwcRBZ6dMS7AMGkLa+tN9bz4NKLU6+kpO8UlY4Fdyd6OAFC6C4Of+XlWXTpCJPvWrDX
 hOG2HCpU5qCT6wQ9rmXIlMlVynq15AwHX0HzaAKnWRAiJbkPESn4S0LLkZsJxTIuy1rK
 rNvA==
X-Gm-Message-State: AOJu0YysKSpr6MTax6c4KH6LklURGHNz/U4Bt4rkHljGhZnOg8HUUwf3
 ywteLcpHi+Qaa+VwUCojwuHLcJXZv43iQVqnuDxUgnCd+B+AKDEqoZyskXX3iD9Dr6e3xJpe74o
 vGrhcWip/KCdMwDgLSoaQHpnD1Bk5BBwmVTDmU1B1qWORtpiCBKIV
X-Gm-Gg: ASbGnctolcQLuFEKkjznxdDE4gkJGHsDPZblIZzey+M1gCBzJW7IpBl6UhQXxJtW8No
 WiRObxPYsv/vPEWnWAOwMzkZ0GYX2QVISmONBP2InSzy20HKuJ85lgZvlqk4nwB+SaaodTbl92r
 rLHOOmhdMbG9JG10jEJxIGqMWbiLn7g/LM4PrThFkfN3ft1h/VxoetqRui/H9CHLggK7Kkz98Fb
 WwqAxoKSEPLNRcUGCy3yEVkkeLoNpZ0vOWZZshN0Sqnm4gozaZd9avvoPt1zaxUoh/FYsI9veTr
 aZ3BAI7BS8Co
X-Received: by 2002:a05:600c:4f8f:b0:43c:ee62:33f5 with SMTP id
 5b1f17b1804b1-4409bdb19ffmr26944625e9.27.1745505600059; 
 Thu, 24 Apr 2025 07:40:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENTDFuoN/24yRGkkzf5BvP6q3SDaf0Wa/EHWAkg65fsLqB8VvZc1KJVDgkZ8ImY12OzwGtJA==
X-Received: by 2002:a05:600c:4f8f:b0:43c:ee62:33f5 with SMTP id
 5b1f17b1804b1-4409bdb19ffmr26944325e9.27.1745505599553; 
 Thu, 24 Apr 2025 07:39:59 -0700 (PDT)
Received: from [192.168.1.84] ([93.56.161.39])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4409d29b8efsm24526905e9.6.2025.04.24.07.39.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 07:39:58 -0700 (PDT)
Message-ID: <c0dd76b5-da8d-4193-9ea1-5fb5e55b35a8@redhat.com>
Date: Thu, 24 Apr 2025 16:39:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10.1 v3 00/27] target/riscv: SATP mode and CPU definition
 overhaul
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20250406070254.274797-1-pbonzini@redhat.com>
 <CAKmqyKO=-QhuKNAKJBXfGiwPdSt=uT6M16pgVJENLxgEiy5Adg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAKmqyKO=-QhuKNAKJBXfGiwPdSt=uT6M16pgVJENLxgEiy5Adg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 4/24/25 03:26, Alistair Francis wrote:
> On Sun, Apr 6, 2025 at 5:03 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> This is the combination of the previously posted series to store max SATP
>> mode in RISCVCPUConfig as a single integer, and convert CPU definitions
>> to a small extension of RISCVCPUConfig called RISCVCPUDef.  I put them
>> together because the first part (patches 1-6) is already acked/reviewed.
>>
>> As mentioned in the earlier submissions, the main reason for me to do this
>> is to remove .instance_post_init, which RISC-V is using in a slightly different
>> way than everyone else.  Whereas other uses (including x86, which is
>> currently buggy, and Rust) would prefer to call .instance_post_init
>> from root to leaf, RISC-V needs it to be called from leaf (CPU model)
>> to parent (DeviceState).  The fix is to move the logic of the former
>> .instance_post_init callback for the leaf at the end of the leaf's
>> .instance_init, as done in this series.
>>
>> Paolo
>>
>> Supersedes: <20250228102747.867770-1-pbonzini@redhat.com>
>>
>> Paolo Bonzini (27):
>>    hw/riscv: acpi: only create RHCT MMU entry for supported types
>>    target/riscv: assert argument to set_satp_mode_max_supported is valid
>>    target/riscv: cpu: store max SATP mode as a single integer
>>    target/riscv: update max_satp_mode based on QOM properties
>>    target/riscv: remove supported from RISCVSATPMap
>>    target/riscv: move satp_mode.{map,init} out of CPUConfig
>>    target/riscv: introduce RISCVCPUDef
>>    target/riscv: store RISCVCPUDef struct directly in the class
>>    target/riscv: merge riscv_cpu_class_init with the class_base function
>>    target/riscv: move RISCVCPUConfig fields to a header file
>>    target/riscv: include default value in cpu_cfg_fields.h.inc
>>    target/riscv: do not make RISCVCPUConfig fields conditional
>>    target/riscv: add more RISCVCPUDef fields
>>    target/riscv: convert abstract CPU classes to RISCVCPUDef
>>    target/riscv: convert profile CPU models to RISCVCPUDef
>>    target/riscv: convert bare CPU models to RISCVCPUDef
>>    target/riscv: convert dynamic CPU models to RISCVCPUDef
>>    target/riscv: convert SiFive E CPU models to RISCVCPUDef
>>    target/riscv: convert ibex CPU models to RISCVCPUDef
>>    target/riscv: convert SiFive U models to RISCVCPUDef
>>    target/riscv: th: make CSR insertion test a bit more intuitive
>>    target/riscv: generalize custom CSR functionality
>>    target/riscv: convert TT C906 to RISCVCPUDef
>>    target/riscv: convert TT Ascalon to RISCVCPUDef
>>    target/riscv: convert Ventana V1 to RISCVCPUDef
>>    target/riscv: convert Xiangshan Nanhu to RISCVCPUDef
>>    target/riscv: remove .instance_post_init
> 
> Thanks!
> 
> Applied to riscv-to-apply.next
> 
> Alistair
As Daniel noticed, I was expecting 
https://lore.kernel.org/qemu-devel/20250210133134.90879-1-philmd@linaro.org/ 
to get in before this series.

If you need a version that applies without that series, you can pull 
from branch riscv-for-alistair of https://github.com/bonzini/qemu.

Paolo


