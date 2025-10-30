Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD19CCF9FC
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 13:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vESdC-00087o-Ix; Thu, 30 Oct 2025 09:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vEScz-00084l-HG
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:23:45 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vESck-0005UL-RU
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:23:39 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-29292eca5dbso12743925ad.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 06:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1761830605; x=1762435405; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IxhqlppgkeEsrH/5ifHcqNydCp28051EXowoiym6UDk=;
 b=W8nZMi5+IzDBk4uH561RtkcX95gKRZ4xfOiOuoQMkAT7iqLZs2ILcp3YUCXd++6ZW7
 kvoNcZT+o4q0lyCI4ryGMkrtPLqdXhfEKdH6OQSIPClzoPhVTQFA/fo7InKStrBSrAHl
 xZ0Q8PkXfeGJSrWfxZBNI4NfefKtZ0ftO6H4NDrWawuh+zIoPqHv7UiNjA92UO9vOc5z
 qEo3mAy4Rz20XpuHYNi07vLibPgqmonlU63sjqGbXwYy0bmKy5luarukHxl8Be/1oxoX
 WB2rkbPVTQm3nT8pStSdFKAfqpphrYE4mz7FUCJJ1Fgi9XBUE5ogxPxDPFIaHskqkcR2
 l0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761830605; x=1762435405;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IxhqlppgkeEsrH/5ifHcqNydCp28051EXowoiym6UDk=;
 b=NlAxykUjrWal+NlcgPK6yhbQF9DZLflg+1O22Zrx/rfpayBkGqTh8lkGk6E2BtHhdq
 jzUKthaCawIztxElqOPDcbX1r/IeprUz9GvkHRsSYuv7G6NeEGLxlGOUXYw4QainadUj
 HRCK4D/4Io4hTCXEWXHVfukrKenj7q09ecm2R3WSs6ylMq0GUeJPN1w49iHGVvp7nDQk
 13vPXKS1GotRdzc5KAmbyLxhlbNAPNyim7ygW8kLzkf+p4MIUdDxZKhf3fkm/x3Nxg/n
 ys1H57lhsN8ut3nAW6UgqfSzN8Gq69UHVi7oMLG6HxVjYfcyJ8cPJIOSkPUlgIk4uiBQ
 0l3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXj+UlSIZn+DGP/hldx53C2lo7Rhm+QFmgsmRMlrN6NXuztYFE9nSB2PVs+yEX3an8Dh/Di6HdMKCf@nongnu.org
X-Gm-Message-State: AOJu0YzswaKdOKHTjUAFy5HljOK6LKlHjmSXRe14uf2pexbhLAw3GPQE
 QbrZ/+Kr0JHNnm5IzguctKfJ5eSt5w3vkl7vvHTKOzNUUj/XJtRfAM3bJAbibI1jqhk=
X-Gm-Gg: ASbGncvmBBAdph1h2hAf/4+ZLLbKXIC7aHLxmn/abSgw8wXj0J0Qw3D/Xq+1wou8du+
 xO5mtPahFwHKw1OePDJP7cESDKjs8vbnp9GXKXvtT3kWtWqAhGiZVv5Q1u93RVLhDnbtgJK0Og5
 PfUH1EZcDxjdq6oFf9gYT2w09Uf9/Cie9VwszgJPEkot+S20DLGUOHqfIgxFl9K1Z3n3+RlSGG3
 qK61Ex7lWH1SxbRCa/xjCoMcdqckcMemFAC/EFI4FG5JjJFQOxxxD+y31TZJLh3zd89cWu/mJxL
 28fiCv4Z7rae3CcP3VIh74RVb3k1XZZJnMdepZuCmDcvbkb14+dSypUp0wb5AKjt5e1sESg/v/t
 EYac59UJf5RuewADf/P3PZmX+jOA9XoueJyEbQVnT13n87UJ3/k7gTgnIyyJWJK0rQlyChOkZH8
 00UQGb+GerILa4
X-Google-Smtp-Source: AGHT+IHM+DvHolXrBzrpCrCFMSjdd3ZwFGceHuuW2PR4L+wnmCT3KiCV+6j65JPwf2YcK9FgtmmnVQ==
X-Received: by 2002:a17:903:2449:b0:25c:d4b6:f117 with SMTP id
 d9443c01a7336-294ee41d994mr40277285ad.35.1761830605202; 
 Thu, 30 Oct 2025 06:23:25 -0700 (PDT)
Received: from [192.168.68.110] ([187.101.65.79])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498e42afdsm184752255ad.99.2025.10.30.06.23.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 06:23:24 -0700 (PDT)
Message-ID: <570082ff-e762-49ed-ba2b-10b6263b8f8e@ventanamicro.com>
Date: Thu, 30 Oct 2025 10:23:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] hw/riscv/server_platform_ref.c: add riscv-iommu-sys
To: Chao Liu <chao.liu.riscv@isrc.iscas.ac.cn>
Cc: ajones@ventanamicro.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 palmer@dabbelt.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 zhiwei_liu@linux.alibaba.com
References: <20250528200129.1548259-5-dbarboza@ventanamicro.com>
 <9d373320-f90e-4a33-9d32-8a069046d545@isrc.iscas.ac.cn>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <9d373320-f90e-4a33-9d32-8a069046d545@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
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



On 10/30/25 8:40 AM, Chao Liu wrote:
> On Wed, May 28, 2025 at 05:01:29PM -0300, Daniel Henrique Barboza wrote:
>> Add an always present IOMMU platform device for the rvsp-ref board.
>>
>> The IRQs being used are similar to what the 'virt' board is using: IRQs
>> 36 to 39, one IRQ for queue.
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>> hw/riscv/Kconfig               |  1 +
>> hw/riscv/server_platform_ref.c | 78 ++++++++++++++++++++++++++++++++--
>> 2 files changed, 75 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
>> index f626774c52..cd70095687 100644
>> --- a/hw/riscv/Kconfig
>> +++ b/hw/riscv/Kconfig
>> @@ -82,6 +82,7 @@ config SERVER_PLATFORM_REF
>>     select RISCV_ACLINT
>>     select RISCV_APLIC
>>     select RISCV_IMSIC
>> +    select RISCV_IOMMU
>>
>> config SHAKTI_C
>>     bool
>> diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
>> index 5102286103..9740b395f6 100644
>> --- a/hw/riscv/server_platform_ref.c
>> +++ b/hw/riscv/server_platform_ref.c
>> @@ -31,6 +31,8 @@
>> #include "hw/riscv/riscv_hart.h"
>> #include "hw/riscv/boot.h"
>> #include "hw/riscv/numa.h"
>> +#include "hw/riscv/iommu.h"
>> +#include "hw/riscv/riscv-iommu-bits.h"
>> #include "hw/intc/riscv_aclint.h"
>> #include "hw/intc/riscv_aplic.h"
>> #include "hw/intc/riscv_imsic.h"
>> @@ -94,6 +96,7 @@ enum {
>>     RVSP_MROM,
>>     RVSP_RESET_SYSCON,
>>     RVSP_RTC,
>> +    RVSP_IOMMU_SYS,
>>     RVSP_ACLINT,
>>     RVSP_APLIC_M,
>>     RVSP_APLIC_S,
>> @@ -112,6 +115,7 @@ enum {
>>     RVSP_UART0_IRQ = 10,
>>     RVSP_RTC_IRQ = 11,
>>     RVSP_PCIE_IRQ = 0x20, /* 32 to 35 */
>> +    IOMMU_SYS_IRQ = 0x24 /* 36 to 39 */
>> };
>>
>> /*
>> @@ -141,6 +145,7 @@ static const MemMapEntry rvsp_ref_memmap[] = {
>>     [RVSP_MROM] =           {     0x1000,        0xf000 },
>>     [RVSP_RESET_SYSCON] =   {   0x100000,        0x1000 },
>>     [RVSP_RTC] =            {   0x101000,        0x1000 },
>> +    [RVSP_IOMMU_SYS] =      {    0102000,        0x1000 },
> This might be a typo:
>       0102000 -> 0x102000

Good call. I'll fix it in v4. Thanks,


Daniel

> 
> Thanks,
> Chao
> 


