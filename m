Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3F5C04FF9
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 13:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwiuG-0002el-FX; Tue, 16 Apr 2024 09:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwiuE-0002eA-4X
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:31:26 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwiuA-0005jC-An
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:31:25 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41881bce4b5so12268575e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 06:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713274281; x=1713879081; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IQOUFHHCUDqPSl2g1+bKLAsz+J3VsSPSm9kqWJqyEiA=;
 b=Rw0ZtNe1SEz10p3Pw5gvpJ2dnWHIrqm2ryJ4PUW3EOH5SmTZR9hLMA67mnEiXxL2pe
 OLIoTe4ek7qFM2T6/dqheqe8EYvejEPQ/250FZ7bZi043vISddKsFTLSqTNX7F0O9Z/g
 d6C4S2VQ6M6DHbrxq4d3d/JcyX8g9yHY6FrIYxWnevb8B8GWPAFlyn9aHhbeB4xwp/aA
 avXYHWYN75rHYTLXeqERXEruakg35a9cAxQN8z7Dc5pbSwQhHaQAcPfXlQRC8GrGf2si
 p2U/NLc7FokcWZRy/PmsdNu/lIjOK2SK/L3mjAxCkcucKTRowGt5Nd0rbNXjzgkQ81mV
 CXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713274281; x=1713879081;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IQOUFHHCUDqPSl2g1+bKLAsz+J3VsSPSm9kqWJqyEiA=;
 b=ZvSwTHFjiGMXKWwPqA3k5DiN2k1WhyRQ1tnZsUJnrHD6dSeofeeoRl5vd5a25pjbDG
 hiMk+FmW1F1nxKDXHmvOQKqxsUqam06dW5TKGV3y6pUFk9Or5DYG1TVajPBkV/Gv+iNs
 X4lJ0s1oZoRNhSlS8E+UtOKiT5LZO8uaWWkINpSz+bRwKLt/2IQnXa2/JETDQOXf7rAx
 CWMrh3CgQ84UWVKK+voywS53bOLyoQ/qUNzkUtr8/yAtV9fi4wLp5hawyLfmRRAPKTWy
 EnLJMsXP1/NciDO6pis3CaPEc2BEKgYcyTFkPMl4EZrTmIVhKYANxJD9CavtPpqMPJv7
 IbnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYj452FxR+/bnXa3V8WOZPFKdDxgr0qlhSWyYZaPik5bZn8V/6netBZ/b9zGcPMUDMQWbGAPv3IOcrOqgK/y0d6eeMjww=
X-Gm-Message-State: AOJu0YwO62zwzH2wF9VrKDZRxJWJ8IPqfc52W9Uk/SJjN3HgyzUuzxKI
 B+mODkxg8PBuQjHWuA+D44ifNiDW6Bf7pT2ncNKSg58pkkZIWGwVQI8YLc2lCw8=
X-Google-Smtp-Source: AGHT+IFr2fTcAtOCG6eR99A6qB3bDuuap9O4gbpWvHobrtiCuNAZzYWW9qP7fWuc8N/rEHC9vKebbQ==
X-Received: by 2002:a05:600c:a4c:b0:415:6728:a565 with SMTP id
 c12-20020a05600c0a4c00b004156728a565mr12960812wmq.16.1713274280679; 
 Tue, 16 Apr 2024 06:31:20 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a1c7909000000b004167b0819aasm2036054wme.0.2024.04.16.06.31.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 06:31:20 -0700 (PDT)
Message-ID: <134a100a-adeb-47d6-b55d-ba8d2afb2969@linaro.org>
Date: Tue, 16 Apr 2024 15:31:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 12/21] hw/i386/pc: Remove
 PCMachineClass::enforce_aligned_dimm
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 devel@lists.libvirt.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Cleber Rosa
 <crosa@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20240327095124.73639-1-philmd@linaro.org>
 <20240327095124.73639-13-philmd@linaro.org> <ZgTby3L9623ofMWC@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZgTby3L9623ofMWC@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 28/3/24 03:54, Zhao Liu wrote:
> On Wed, Mar 27, 2024 at 10:51:14AM +0100, Philippe Mathieu-Daudé wrote:
>> Date: Wed, 27 Mar 2024 10:51:14 +0100
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: [PATCH-for-9.1 v2 12/21] hw/i386/pc: Remove
>>   PCMachineClass::enforce_aligned_dimm
>> X-Mailer: git-send-email 2.41.0
>>
>> PCMachineClass::enforce_aligned_dimm was only used by the
>> pc-i440fx-2.1 machine, which got removed. It is now always
>> true. Remove it, simplifying pc_get_device_memory_range().
>> Update the comment in Avocado test_phybits_low_pse36().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/i386/pc.h                  |  3 ---
>>   hw/i386/pc.c                          | 14 +++-----------
>>   tests/avocado/mem-addr-space-check.py |  3 +--
>>   3 files changed, 4 insertions(+), 16 deletions(-)


>> --- a/tests/avocado/mem-addr-space-check.py
>> +++ b/tests/avocado/mem-addr-space-check.py
>> @@ -31,8 +31,7 @@ def test_phybits_low_pse36(self):
>>           at 4 GiB boundary when "above_4g_mem_size" is 0 (this would be true when
>>           we have 0.5 GiB of VM memory, see pc_q35_init()). This means total
>>           hotpluggable memory size is 60 GiB. Per slot, we reserve 1 GiB of memory
>> -        for dimm alignment for all newer machines (see enforce_aligned_dimm
>> -        property for pc machines and pc_get_device_memory_range()). That leaves
>> +        for dimm alignment for all machines. That leaves
> 
> Just nit, better align it here.

Well, I wanted to avoid too much churn, but OK.

> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 
>>           total hotpluggable actual memory size of 59 GiB. If the VM is started
>>           with 0.5 GiB of memory, maxmem should be set to a maximum value of
>>           59.5 GiB to ensure that the processor can address all memory directly.
>> -- 
>> 2.41.0
>>


