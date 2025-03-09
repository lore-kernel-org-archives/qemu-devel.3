Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70944C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 12:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trFaP-0006hs-BO; Sun, 09 Mar 2025 08:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trFaM-0006gx-RP
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 08:16:50 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trFaL-0001MF-20
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 08:16:50 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so19237215e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 05:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741522607; x=1742127407; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r36St+rnaojSkYk5+iSomygtCQfeEMh2+rNy1K3V6bc=;
 b=t7FlIhErAvsvD3ibAKyzbD3ry8aHZ5KZkiErj3o9Ot+RbUMB+NrFJ6GydqAVspo38A
 qGrqGbqQXpxvakigVh3M1SPjIB5tVV2h+v4JYIS+s3hQT+KuUPg7SMy2PEoBRZfrQ6uw
 JCA39WbOs/GU8gFSIU3BqFmYr33pyEAi/IIMSjkveKjkd2RpcnGWtNWXmqiyOr1KzYNq
 VolFk7HjffTr/xR9f9vS1hzZZjd+zr8ccySlrxMwqmiiYgYDU8FztalZP9wligUaB9zi
 +WwjqsBpaTk78giSJyTOxmllsnay+uHlVjLDUmx9CEBA3A0dWVeADQRRuQ21W9Sn8cZi
 mPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741522607; x=1742127407;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r36St+rnaojSkYk5+iSomygtCQfeEMh2+rNy1K3V6bc=;
 b=qq0Udx72hQxwdcnscEaYDx2sym/EgdhRVb7waIAMTUpuh5JokpC+5e+Q3QQrYrO5ef
 H6Wi/S0/4v/D3nVykwdc1FZh3POufKTZG00BB+JRfRRmvph61ScXJIfTafe3yqq9ZkTc
 cZjNpf3JkAILE/tBt+ur8gBDfBhx8/Rc1vndY4ZqDvBjyRQF/S2LM9PXHyBk+J9Y8Pbu
 aSmyHeSDmF86HKWBUz6kz2DKAVtNBh41ZAd8lsoVbdVysJ0w5w1Pq6HzINWEZbUXC8OC
 vK7hbJAz8XRNUzKpRqWxCFEJhpPCu1I8Bv5x8XUQ94GhuODWchwlw+LkBbgUTy306CX8
 v9AQ==
X-Gm-Message-State: AOJu0Yxgn10Dho3BhOzv6Frl1G0MG+Jl8VkelFMTDyXz4C2iGJL/npJT
 98mJ5KqidwtMcQuMAXKAOPyE6y0cSnIMp3UOo947KD3lHh+I3P/C9zSdUXeDhsQ=
X-Gm-Gg: ASbGncsB6UC/B4CPib+yjS2bPp/QXw7Ioc0DQ3HYzpMglIjbXFnMxmMHr36oQl7en8/
 TzlWoCFE6SaX+zDlnR06MCLzsR8hyrSKgHPMJZQboKT2j5Xh6DbredDQgII3DSxk6Wz82tg6vsO
 MRgR9OcyxTtriuD9z2vvkyPsr6vt0dUQuigKusoJyfQ3unwQyN5EVsQFkDQxLs+VC5U81C6ajej
 h9YH16U9gtoc7PsNiTcR2tr5p4aQAh2ZrncQWGESJdaGgtVGO6+LbgSG4EcusIY7n0j2QMBX7Z2
 aL2uZWuxnbN5imvosHdAA7mf1M2fNuG+vyv6sf6pp1WFRBymU3T4U4Rm0iYHTEqoI5TkgODHw5T
 5dFOGeeukC5+S
X-Google-Smtp-Source: AGHT+IGDQ6kkVJVuB8BhZf/33+0k3GqhrDwCRgF89x4eBfhOIfXY7ti4vGh4Cghau5RHIDV/AsEyPg==
X-Received: by 2002:a05:600c:3b1e:b0:43b:c965:954d with SMTP id
 5b1f17b1804b1-43c5a5e92f3mr53387315e9.1.1741522607104; 
 Sun, 09 Mar 2025 05:16:47 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd426c56esm149167225e9.8.2025.03.09.05.16.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 05:16:46 -0700 (PDT)
Message-ID: <9d032d3b-7929-4a7f-b5a7-5338a0fc16cd@linaro.org>
Date: Sun, 9 Mar 2025 13:16:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/14] hw/sd/sdhci: Implement Freescale eSDHC as
 TYPE_FSL_ESDHC
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org
References: <20250308213640.13138-1-philmd@linaro.org>
 <20250308213640.13138-14-philmd@linaro.org>
 <9eb8f1a0-75c0-526a-869c-53d01551c97b@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9eb8f1a0-75c0-526a-869c-53d01551c97b@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 9/3/25 12:04, BALATON Zoltan wrote:
> On Sat, 8 Mar 2025, Philippe Mathieu-Daudé wrote:
>> Per the MPC8569E reference manual, its SDHC I/O range is 4KiB
>> wide, mapped in big endian order, and it only accepts 32-bit
>> aligned access. Set the default register reset values.
>>
>> Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> include/hw/sd/sdhci.h |  2 ++
>> hw/sd/sdhci.c         | 37 ++++++++++++++++++++++++++++++++++++-
>> 2 files changed, 38 insertions(+), 1 deletion(-)


>> -/* --- qdev i.MX eSDHC --- */
>> +/* --- Freescale eSDHC (MPC8569ERM Rev.2 from 06/2011) --- */
>> +
>> +static const MemoryRegionOps fsl_esdhc_mmio_ops = {
>> +    .read = sdhci_read,
>> +    .write = sdhci_write,
>> +    .valid = {
>> +        .min_access_size = 4,
> 
> Does this need max access too? Maybe it could work with 8 and likely 
> nothing would try to access more than 4 so probably does not matter.

Per the reference manual (chapter 16):

   All eSDHC registers must be accessed as aligned 4-byte quantities.
   Accesses to the eSDHC registers that are less than 4-bytes are not
   supported.

There is no precision on max_access_size.

> Regards,
> BALATON Zoltan


