Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD199C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 16:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqatN-0001wM-M4; Fri, 07 Mar 2025 11:49:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqatL-0001tR-UT
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 11:49:44 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqatK-0003HE-9O
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 11:49:43 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-390f69e71c8so1221460f8f.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 08:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741366181; x=1741970981; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CJUdgya2w7yQZLtfC0YiV9Ry29qx6orhN0hYRb1ThvU=;
 b=ysFBe83wbXyo5eGNHe3st+GhyiSn5H9Se/UkPIfSSWkHxHUvk4QNdNBVPdlk6j3KEo
 g/LCuIKqBOKD/voNtlfKywcSMX2IBKlNKxgm+5cabodvs1pVlRAvLyjbUdIqLTeCKOWJ
 jltq9A2V/hFmWfcvOFERZY/2gBx9tSj7IAlaV73aIO9Es/uau981zzvPRCppSC7K2chx
 Rl9l5eUeWiuN+xrl/6Jssn6ZurgrfN0NyNHNA66qMZkruuGTH/0CN2xdyqOuJOSif0aE
 3yoKnkvMvPHN3kBP4KdOhKZ99DfcF9Xd9Kdwd04oItRSK2PeP7t7drkOPXTRkq39q/mj
 kp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741366181; x=1741970981;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CJUdgya2w7yQZLtfC0YiV9Ry29qx6orhN0hYRb1ThvU=;
 b=OIDSqqHLRWtZnrOG6Pz3PwgI8Nhz258GHhDdwV17N67Y824B2YFe/17zaSFQ9WWHbU
 gaFz7Yqj4IsE8niz9QvV/3AxyqglyLbrm5/rZSu/+5ve2lSj8l9yWo/MDXKy/UurX1ax
 Gvk3n0onMXCE/QbLv2ohWmUiDoVBZEbXxrZ52RnSg1VBS0d9QMEaFQ6cmQNqz7RKBs2J
 TFQIfyBYxKpstKdtMxNuAp9U3GwAEGK8uit+3n9o5oWK6v5I5QiZczSTgrGXxe5yYcHa
 d1sxBmOBL2e1Nmj6r2KFmT9fwehHJki988WcJBjpnOKCH3aaIoZNzmq/9EtcvI/3/b61
 IgMw==
X-Gm-Message-State: AOJu0Ywute//2tr3fZXiguVzlJ7SSBmPRxx1D1xhdGyeKbgMf4K3Z1fC
 rHk2onK7DY18nZVhKhocv+RNGibjmPl39nujajJQxguWUvNY21e2OpxYdlNXxvU=
X-Gm-Gg: ASbGncuTbl9//qAydblUgM38gbX7G1ZetfZ9rDpkOzQksGATSrHG6/eV8xPDngO+JCw
 hc49VEd6ivyQnetEZBlyGrfoTpPdLSRwsKab2Gy3m4kuONBfjlftyHgQ4b/GW0Ac/sUSew3WKYn
 ltfc6QF1G3gf6Q1K603U2XnlR9D+8ikAuljdX+yV96uapUk6r5Lte+IrQd3JEPc/Y+IGaYhpkt3
 w/sRfTvZSh8JLHmzfiHBpiTo3lFa4yHaXgtE4QYrKzOKa5na+oMXEOG0d1csi14WJP3TFLpbPQY
 uSR8vHb08JpYZ9qLg8qRi/QikC3hM1aShAU1yVvtpOxo18YTSvmx0EW70BP48vkIYAu7A6dp/4x
 3lqN2DvIMQiak
X-Google-Smtp-Source: AGHT+IE+7FwQ16SRlQkm2JtIfdImcaD45ZogXBWT6cWa2+p/K8x/4RdZdaxgHg3WjYHWtw3qWNKLog==
X-Received: by 2002:a5d:47cb:0:b0:391:21e2:ec3b with SMTP id
 ffacd0b85a97d-3913aed7e68mr203678f8f.3.1741366180456; 
 Fri, 07 Mar 2025 08:49:40 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1037b4sm5908371f8f.92.2025.03.07.08.49.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 08:49:39 -0800 (PST)
Message-ID: <a7126584-00fa-42ed-8e5c-d27d9933ac2f@linaro.org>
Date: Fri, 7 Mar 2025 17:49:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] hw/virtio/virtio-mem: Convert
 VIRTIO_MEM_USABLE_EXTENT to runtime
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20250307151543.8156-1-philmd@linaro.org>
 <20250307151543.8156-6-philmd@linaro.org> <877c503ie6.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <877c503ie6.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 7/3/25 17:38, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Use qemu_arch_available() to check at runtime if a target
>> architecture is built in.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/virtio/virtio-mem.c | 20 ++++++++++++--------
>>   1 file changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
>> index 5f57eccbb66..8c40042108c 100644
>> --- a/hw/virtio/virtio-mem.c
>> +++ b/hw/virtio/virtio-mem.c
>> @@ -15,6 +15,7 @@
>>   #include "qemu/cutils.h"
>>   #include "qemu/error-report.h"
>>   #include "qemu/units.h"
>> +#include "system/arch_init.h"
>>   #include "system/numa.h"
>>   #include "system/system.h"
>>   #include "system/reset.h"
>> @@ -170,13 +171,16 @@ static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
>>    * necessary (as the section size can change). But it's more likely that the
>>    * section size will rather get smaller and not bigger over time.
>>    */
>> -#if defined(TARGET_X86_64) || defined(TARGET_I386) || defined(TARGET_S390X)
>> -#define VIRTIO_MEM_USABLE_EXTENT (2 * (128 * MiB))
>> -#elif defined(TARGET_ARM)
>> -#define VIRTIO_MEM_USABLE_EXTENT (2 * (512 * MiB))
>> -#else
>> -#error VIRTIO_MEM_USABLE_EXTENT not defined
>> -#endif
>> +static uint64_t virtio_mem_usable_extent_size(void)
>> +{
>> +    if (qemu_arch_available(QEMU_ARCH_I386 | QEMU_ARCH_S390X)) {
>> +        return 2 * 128 * MiB;
>> +    } else if (qemu_arch_available(QEMU_ARCH_ARM)) {
>> +        return 2 * 512 * MiB;
>> +    } else {
>> +        g_assert_not_reached();
>> +    }
>> +}
> 
> What happens if/when we have multiple arches available? Won't we want to
> know which CPU the virtio-mem device is attached to or do we take the
> minimal value over the whole system?

"per attached vcpu" is how I was previously considering this problem,
but IIUC from the discussions with Pierrick, we should consider single
binary as a first step before heterogeneous emulation.

If you think the minimal value is good enough, then that'd be my
preferred choice, as the simplest to implement.

> 
>>   
>>   static bool virtio_mem_is_busy(void)
>>   {
>> @@ -721,7 +725,7 @@ static void virtio_mem_resize_usable_region(VirtIOMEM *vmem,
>>                                               bool can_shrink)
>>   {
>>       uint64_t newsize = MIN(memory_region_size(&vmem->memdev->mr),
>> -                           requested_size + VIRTIO_MEM_USABLE_EXTENT);
>> +                           requested_size + virtio_mem_usable_extent_size());
>>   
>>       /* The usable region size always has to be multiples of the block size. */
>>       newsize = QEMU_ALIGN_UP(newsize, vmem->block_size);
> 


