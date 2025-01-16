Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CFBC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 08:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYLQx-0004ws-Cq; Thu, 16 Jan 2025 03:40:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYLQu-0004w5-70
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 03:40:56 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYLQs-0006Rv-3g
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 03:40:55 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-385f07cd1a4so578762f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 00:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737016852; x=1737621652; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iy7zTHR1DHpaeBWIJBrTxo+HvkmkcNJIGSRhTz2feFU=;
 b=gDSVdqwGapDfcauCg7UrsUPcmeuVh66cl3y/iA9xM8nVCL0wVP6J/W5opOtNouBVw5
 0GAC6IvX9xhfLdJHjRRvg2rrrxzUQ9dnisBnLqUSpwCf7qMrlAWAbi0kQLotEAF/ur+w
 0DW5+apd1dor75PvLcS1QxYMWyEpPWPAOgeKBefdpz86bkaV7s/GPZsljhVKiXx9qXNq
 T1atBMID+G+PgHMfrJtFOVG5PkA2KNqRLaswPwiqLnum8c7kBxi3ImOsBd+cKn1cZApi
 M2jY+7Iw+R1AIXDPWDOzlE0xBYc5q3o6k3qSOL+XmAM2sdG0Lm2z7CezmgvfLLzGrtLC
 D9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737016852; x=1737621652;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iy7zTHR1DHpaeBWIJBrTxo+HvkmkcNJIGSRhTz2feFU=;
 b=J0JelIEL5wYMNlHe2oHpoEezS0vEGpdXSy0JPVKYpigi9L5F9Jpf7Rq7hMoJGYdXxD
 IWuMaThf7+wBMne2FE6U3EG4w2XZyr+gs6usgIKxNHsKl65O0QMGNv4S9Vb+i2/Qtkop
 QY7OVT0YtBRX7vubTS/ljJeTZwkJ3TnICcNXdRHB0IwKrn+C5kryOPJ6pr5vYgFhaAK9
 naA2n/CXC3jlPDBPYmpTFXAwOUE+115ecWyxtTW9gtiEeFXjZRq/UhNUxSXPv9fIVPwM
 GPT3TToE03hrI5KPZXzepQtqKD2jwCVBv7nq4BViQ7TfhYIephtqLyRPMe05GOKYAOmX
 Kg8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUshG805Te2Jr9GoC51gUtbtOM+McKTH7mdXPQPyaOXxklwWpl7hPHOR14wPpMAe/Nl/m/JiPG1y531@nongnu.org
X-Gm-Message-State: AOJu0Yw/G7cCjkW8Sefw3DKAVM6ZofifJb6A9Dh+n6H47acciHqHglnI
 7UHgxRKmVhLAOlTGHeuYWuM//BNx2WJ3b3VmYfYw0SH3nwz5E6dt0MzCFz/gtgI=
X-Gm-Gg: ASbGnct0/ePe0r9USWsSdm+XzZkRvl412aXNQ4i4X5SGERERcMgnkR6vn3vB+rs18WX
 j0uYtpyJYxR4F6bsLiefrBs/lqfxQvuclxhsyw4xbTPIkaVhe439Fq+7sSvRNq7Hc/iaMch2zPn
 OEZu2eCssj86+ewDW7Rrn3lMtWwS+Cva9t3b3/Sq3ZURUuGF0hFuEYNdKMX2S1GqWhBw88A4bYM
 UmLFrQaitocLb0xJG5boqvYGyJpfEhUieDtVC3tG+B35nFTQO7w19g4bH0jQesackwY9WS8/7bU
 MQgA+S65eXmqUkM2e4mHbV9m
X-Google-Smtp-Source: AGHT+IHtQzEq0W15KSMEoOU1EAK98LiXbf1pFXn0qM6QBZ38ARBO8VJD0hw9j1ypO1u421k/+zbNIQ==
X-Received: by 2002:a5d:47c3:0:b0:386:3329:6a04 with SMTP id
 ffacd0b85a97d-38a8732c076mr32561710f8f.39.1737016851801; 
 Thu, 16 Jan 2025 00:40:51 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d01dsm19662039f8f.9.2025.01.16.00.40.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 00:40:50 -0800 (PST)
Message-ID: <529f4fff-a98b-4a89-b770-549af3029da1@linaro.org>
Date: Thu, 16 Jan 2025 09:40:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] hw/arm/virt: Remove
 VirtMachineClass::disallow_affinity_adjustment
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>, qemu-arm@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
References: <20250115171009.19302-1-philmd@linaro.org>
 <20250115171009.19302-4-philmd@linaro.org>
 <da2fe302-dae9-4f6c-8ea8-94fcc332e167@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <da2fe302-dae9-4f6c-8ea8-94fcc332e167@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 16/1/25 08:03, Thomas Huth wrote:
> On 15/01/2025 18.09, Philippe Mathieu-Daudé wrote:
>> The VirtMachineClass::disallow_affinity_adjustment
>> field was only used by virt-2.6 machine, which got
>> removed. Remove it along with the GIC*_TARGETLIST_BITS
>> definitions, and simplify virt_cpu_mp_affinity().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/arm/virt.h              |  1 -
>>   include/hw/intc/arm_gic.h          |  1 -
>>   include/hw/intc/arm_gicv3_common.h |  3 ---
>>   hw/arm/virt.c                      | 16 ----------------
>>   4 files changed, 21 deletions(-)
>>
>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>> index 27c5bb585cb..5d3b25509ff 100644
>> --- a/include/hw/arm/virt.h
>> +++ b/include/hw/arm/virt.h
>> @@ -117,7 +117,6 @@ typedef enum VirtGICType {
>>   struct VirtMachineClass {
>>       MachineClass parent;
>> -    bool disallow_affinity_adjustment;
>>       bool no_its;
>>       bool no_tcg_its;
>>       bool claim_edge_triggered_timers;
>> diff --git a/include/hw/intc/arm_gic.h b/include/hw/intc/arm_gic.h
>> index 48f6a51a70a..f5e6e5e70b4 100644
>> --- a/include/hw/intc/arm_gic.h
>> +++ b/include/hw/intc/arm_gic.h
>> @@ -68,7 +68,6 @@
>>   #include "qom/object.h"
>>   /* Number of SGI target-list bits */
>> -#define GIC_TARGETLIST_BITS 8
>>   #define GIC_MAX_PRIORITY_BITS 8
>>   #define GIC_MIN_PRIORITY_BITS 4
>> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/ 
>> arm_gicv3_common.h
>> index a3d6a0e5077..fff5e55a97d 100644
>> --- a/include/hw/intc/arm_gicv3_common.h
>> +++ b/include/hw/intc/arm_gicv3_common.h
>> @@ -45,9 +45,6 @@
>>   #define GICV3_REDIST_SIZE 0x20000
>>   #define GICV4_REDIST_SIZE 0x40000
>> -/* Number of SGI target-list bits */
>> -#define GICV3_TARGETLIST_BITS 16
>> -
>>   /* Maximum number of list registers (architectural limit) */
>>   #define GICV3_LR_MAX 16
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 0080577e1a9..2a2a0bd9154 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -1760,23 +1760,7 @@ void virt_machine_done(Notifier *notifier, void 
>> *data)
>>   static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
>>   {
>>       uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
>> -    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>> -    if (!vmc->disallow_affinity_adjustment) {
> 
> I think this change is wrong - disallow_affinity_adjustment is false for 
> newer machines, so you removed code here that is still in use on newer 
> machines?

Oops :| Thanks, I've be a bit overzealous here...


