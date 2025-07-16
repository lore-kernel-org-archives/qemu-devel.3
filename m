Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C19C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 12:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc1aW-0004fG-Mz; Wed, 16 Jul 2025 08:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uc1OM-0004Yw-Mv
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:37:48 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uc1OF-0007aS-QL
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:37:46 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-456108bf94bso25298015e9.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 05:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752669455; x=1753274255; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nrK4iocgR8I+t7k9B1GzeliTxnUhAvY/CKLGOKQIvlM=;
 b=kXNMSeLJ30WpBycYILtEuBPQWiLntKqWOhtDjNC9stv+PL7O0UWftlen0CW15JO+TV
 aIUnrMetkaVwx8sqGreobHMMEhYBOhgFNsLo+AH5TfXoaBK8wkZfvl2TzWj8o4BtayxW
 DhSsRecjDFvCO2D7rzlBlf4U7XK47tVECJ/A4W4YJWE+fho0fKS03xCGVBdRCrcCW1nM
 mVwLtQU4BOorlotYE9SpU0dfKKVX9NFW9+4HqjQYudiH5AZvGzEe0AhadNKtMNt7fNM1
 /32zh9zDfCvvJ8K/UdKm21qU59AaMLQrT5+8drZUU5yuDECcFtTeCCKNSBIo5gEo4JeJ
 mR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752669455; x=1753274255;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nrK4iocgR8I+t7k9B1GzeliTxnUhAvY/CKLGOKQIvlM=;
 b=uJhGywgpzY2NqRHtq3P5T+XNec08XCvV18AyQfkb7xhu/HprqRqACVfHkv/pfdPzze
 Kv9//iJnS4fZrhusHU0mRa56uj4t1BXDONodXC42l+G1Zz6n07hSAQBWVOgLbM6lkg13
 u1CHTGC3MMHBrCC3RHwFPJkX7JWB2gdmb4o2Z0qPIGKPNXcyPPIpEP27GBMqH5PPkBIJ
 1WfWfxw2uRknem5ibnhJU3InF9h/T99SsEeKxJGXMgkhzNB2GkfpSXFAoTcNK/0fEmBb
 K0wrsT3zYKofIfbBRElCXt7w2op1hEqJzsVgdvVMyeJp0nBJIYQTiNQTMp7wF4CWwHLV
 RxWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfLhL/5dZffy8CbyKG0H0rnuMYXecspTuE8hsxnbHl6la1srSgYcA7IhvMsHKX5OQcp484WgPzqEyZ@nongnu.org
X-Gm-Message-State: AOJu0Yw565+CeJc6/Eb6q4liEf9r7tFpAbmfeRA/BGcPYwN7x/HbcKCQ
 IvWwOR0e4YSD1bEHAEZwZy7MjmyGI+D1T6MPYJyQOxALTgC3vwlez8v/0RecWWvUp+Y=
X-Gm-Gg: ASbGncvLI5IfwO/RLRq4dFujl6qgjbHdIMAN5ndFLCcccwuZHMZUl/YwpvlScQA8VsD
 ebf4jgJOdFTAozP+s0nzha5G4VC8yazy168KYCJ6SFwPNan/FWgEN+7zFuMrDnl8zbi56M5OOqv
 T1458s3yv8+rPCkUKiSEosqGG18zewfOralihjHDeH+v9VK7bNS0oBwsQ4HCBYpWgA/1bU1lpSA
 pgG95Vq6jyERM5e+Hg48fp3xAIshMKZK9Lrn7ffwiolYyoPi+gJgMb5I4Isu+Bl8v9cY5twq+/W
 2mPWvKpY10MxQF5K4ZTjXdkvGl4XNWy5iFF6taGdovzrD8L1d1mZApkrDuEcsBIeqJ7eL4ZXFGG
 pz1IQe0gq54kzFu8rsvhVcS6urUCXjldXpmKn80sw3pGaKlmUzfRAL5ZVc1z+XI6I/uckLfYPrR
 cmbDXpUbLq
X-Google-Smtp-Source: AGHT+IFSLpIxWr8UeBCu45FkbQzKzaoR3Mx9dztfoMfAmya4W7NBeVC82f7VAs0WoLb93S4wizfMhA==
X-Received: by 2002:a05:6000:1acc:b0:3a5:3b63:58f0 with SMTP id
 ffacd0b85a97d-3b60e4ebb8cmr1848156f8f.18.1752669455085; 
 Wed, 16 Jul 2025 05:37:35 -0700 (PDT)
Received: from [10.132.103.213] (119.red-95-127-47.staticip.rima-tde.net.
 [95.127.47.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d5easm17607453f8f.48.2025.07.16.05.37.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 05:37:34 -0700 (PDT)
Message-ID: <6e56761c-64b1-43eb-9ff1-316b6de082e7@linaro.org>
Date: Wed, 16 Jul 2025 14:37:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] hw/i386/amd_iommu: Cleanups and fixes
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 eduardo@habkost.net, richard.henderson@linaro.org,
 alejandro.j.jimenez@oracle.com
References: <20250716073145.915-1-sarunkod@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250716073145.915-1-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 16/7/25 09:31, Sairaj Kodilkar wrote:
> This series provides few cleanups and fixes for the amd iommu
> 
> The patches are based on top of 56c6e249b698 (v10.0.0-rc3) and Alejandro's
> DMA remapping series [1].

56c6e249b698 is 4 months old, we are about to release v10.1.0-rc0.

What is the point of posting obsolete code?

I'm not going to review further.

Regards,

Phil.

> [1] https://lore.kernel.org/all/20250502021605.1795985-1-alejandro.j.jimenez@oracle.com/
> 
> The series is uploaded on github:
> https://github.com/AMDESE/qemu-iommu/tree/sarunkod/alej%2Bcleanup-v1
> 
> Sairaj Kodilkar (7):
>    hw/i386/amd_iommu: Fix MMIO register write tracing
>    hw/i386/amd_iommu: Remove unused and wrongly set ats_enabled field
>    hw/i386/amd_iommu: Move IOAPIC memory region initialization to the end
>    hw/i386/amd_iommu: Support MMIO writes to the status register
>    hw/i386/amd_iommu: Fix event log generation
>    hw/i386/amd_iommu: Fix handling device on buses != 0
>    hw/i386/amd_iommu: Support 64 bit address for IOTLB lookup
> 
>   hw/i386/amd_iommu.c | 217 ++++++++++++++++++++++++++++----------------
>   hw/i386/amd_iommu.h |   9 +-
>   2 files changed, 146 insertions(+), 80 deletions(-)
> 


