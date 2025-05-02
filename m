Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EECCC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 11:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAoMb-00057v-GA; Fri, 02 May 2025 07:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAoMY-000528-TK
 for qemu-devel@nongnu.org; Fri, 02 May 2025 07:15:27 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAoMX-0005yO-1I
 for qemu-devel@nongnu.org; Fri, 02 May 2025 07:15:26 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-acec5b99052so311233266b.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 04:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746184523; x=1746789323; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/wDY96Mo/oW2XDsRugGi1hBYln+aaBy3TnE6cPG5DZU=;
 b=M3HzXxD6hKww5xp51ZrqqzvGI+bJX0XkCjoVw6XGbFI6c7PyyvfsecTfntRBPeJIng
 62x8ir7TGVszTit5K9KrKmeLMXpuE/b+rZO0izM7Gs47lztj4e2iGZV4JaYCm+ZksiQw
 6dOMPi/Sa4QKtJF2tWDVm0iCLwNz1li6ZR9RadXBvNKsJay8OwxVvo8LEMyqi5XcZ7IK
 /y9BRE/0DQ+yDv0pOVJTfrjOHdjA+dgG5VEkDQVVjzB2ZDsuLTLCWtirIjBnEwDDDuGt
 +Yjf9lffwEdxlA1H56+qcQRfCY1/SEuWKP4XhQVkGv1Z57PtkzdMwKQr7gfWGsvpaV8x
 hScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746184523; x=1746789323;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/wDY96Mo/oW2XDsRugGi1hBYln+aaBy3TnE6cPG5DZU=;
 b=dROh4nSJmvoEUvK8hx7h7+Kmhr6Nr0OWyj7hG2rqEOWCks2FYOqWIWGGDHvNofQ0fR
 LSpYtACMMEN8Nif3nEDT9p/MhSyrcjgzO/mEmdUX+gSaruxZUSVWRngukPCgFv4tRYr+
 H+IJW0UHKGPm4qc0ZtGBjSrXODqVMOGVriFYZHRpA3215V2MwPWx7luYwcG9G8w7W8fj
 7UFlyNjsNIozhwIYqWySa6+H1hEMfs89lrJCNzPzg8vNQYdzwtcsXOQnkN3wIta/50+4
 YCvkiPrAgSJX/BA4ORWNsxBieNIMsicex05+/AKxTNDT7babj5P8BZyyjQDccZWG1fIA
 EleQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTvB//I8F3b59wRTi8Rv7Bg7sUb9TQheHp96mYL2f2R/Axefw5rH8b9LYGZSs+yr48xZyJo2ihczt2@nongnu.org
X-Gm-Message-State: AOJu0YwFfyqATqHXoeYi//CZVWsJ3ZauJp30hWO28t44rQSLI/GImV4Q
 f3HkDqNxiXpUNAn/YIYpw35gTclEJiicM11gbGAxW4Mud2Dm6FD/nnqcVtjAlJ3DUuhoyJXJ+5/
 c
X-Gm-Gg: ASbGncvGtZpX5uPAHlsQ+a5aZjXBTBncvKdn267Zume0mOpuUP4Kg3Ur/WpQiXQZ4J8
 f9/CBWl/R3ncJcLZWFBZlPIqvhlXt86EmoE/tMOxA9e9fQeuKcv1HhKbANbZzf5Nj0ck3TCJ/Vt
 5WYXbV35WzV1Uc6qlZqUrZ/WQRyaA8NC5gR2agFwxPPKaBTFW9lrps3qIEb7BsOd7cAoW0UKHni
 uthO/xM7U92FM/wC34xy+eed0hTQJ4iSgPmh0TRfaFry7li6dFfC9tA6OkAP3GIP8TnjCij164j
 pL8cV3izH/4ewrjdnhv5LDOyN59MKzcVH/zb68O1XXtnJdAFf6/lbTMKsGRGLUNtm6TEj2bQpk8
 lEE88dlS5qvUqw+2PR5k=
X-Google-Smtp-Source: AGHT+IHIKtngSsk7K+2DTrht0vJLTqaCM3PcOWs6VB5ulkk/VNu8ldKcsh1R6JXH6kOfqp75sn1cOA==
X-Received: by 2002:a17:907:3e9f:b0:ad1:7858:a769 with SMTP id
 a640c23a62f3a-ad17adaeca2mr294580166b.26.1746184523195; 
 Fri, 02 May 2025 04:15:23 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891a2bd8sm35481566b.57.2025.05.02.04.15.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 04:15:22 -0700 (PDT)
Message-ID: <2fc7686d-2feb-4cca-97f8-0bf5c8be7987@linaro.org>
Date: Fri, 2 May 2025 13:15:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] hw/intc/apic: Remove
 APICCommonState::legacy_instance_id field
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20250501183628.87479-1-philmd@linaro.org>
 <20250501183628.87479-6-philmd@linaro.org>
 <5c1c0533-190b-44b7-8dba-39ffc2041cfc@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5c1c0533-190b-44b7-8dba-39ffc2041cfc@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

Hi Mark,

On 2/5/25 11:14, Mark Cave-Ayland wrote:
> On 01/05/2025 19:36, Philippe Mathieu-Daudé wrote:
> 
>> The APICCommonState::legacy_instance_id boolean was only set
>> in the pc_compat_2_6[] array, via the 'legacy-instance-id=on'
>> property. We removed all machines using that array, lets remove
>> that property, simplifying apic_common_realize().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/i386/apic_internal.h | 1 -
>>   hw/intc/apic_common.c           | 5 -----
>>   2 files changed, 6 deletions(-)
>>
>> diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/ 
>> apic_internal.h
>> index 429278da618..db6a9101530 100644
>> --- a/include/hw/i386/apic_internal.h
>> +++ b/include/hw/i386/apic_internal.h
>> @@ -188,7 +188,6 @@ struct APICCommonState {
>>       uint32_t vapic_control;
>>       DeviceState *vapic;
>>       hwaddr vapic_paddr; /* note: persistence via kvmvapic */
>> -    bool legacy_instance_id;
>>       uint32_t extended_log_dest;
>>   };
>> diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
>> index 37a7a7019d3..1d259b97e63 100644
>> --- a/hw/intc/apic_common.c
>> +++ b/hw/intc/apic_common.c
>> @@ -294,9 +294,6 @@ static void apic_common_realize(DeviceState *dev, 
>> Error **errp)
>>           info->enable_tpr_reporting(s, true);
>>       }
>> -    if (s->legacy_instance_id) {
>> -        instance_id = VMSTATE_INSTANCE_ID_ANY;
>> -    }
>>       vmstate_register_with_alias_id(NULL, instance_id, 
>> &vmstate_apic_common,
>>                                      s, -1, 0, NULL);
> 
> With the legacy_instance_id removed, is it now also possible to register 
> vmstate_apic_common directly via dc->vmsd instead?

I don't think so because it still uses initial_apic_id, but I'm not sure:

     uint32_t instance_id = s->initial_apic_id;

