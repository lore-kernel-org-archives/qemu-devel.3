Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEB7C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 09:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scM5i-00026K-SN; Fri, 09 Aug 2024 05:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1scM5h-00023G-Dn
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:39:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1scM5f-0001At-Q4
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723196358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=saM/xkfKcVoXunhXuQeDRUAo9xzzmY9xbqpMgYaXrVY=;
 b=ScaMPvOY+pZPp48ddKd1Cx9JL0NeJ8Q8DSOFVmgDe98EQUNnqimeDj/8xYLCSRw4RZ3sNv
 tpuQvdPvQoAShOu1ujO4ZujFhgfApVRuAlbwgj9Yr535pbSzMZ9+HNgoqBAv9bepnSksOA
 VmShtcfKm62VdFyfPzMDJulE4RoGWNI=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-feLpGqltPVGP2LHKcGgrfQ-1; Fri, 09 Aug 2024 05:39:16 -0400
X-MC-Unique: feLpGqltPVGP2LHKcGgrfQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-7b696999c65so1674789a12.3
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 02:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723196355; x=1723801155;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=saM/xkfKcVoXunhXuQeDRUAo9xzzmY9xbqpMgYaXrVY=;
 b=LUU+IZUEC5LB8fALTa1wYc556ob2mfvMPA7I6MuqasogfnmwIDv8Hdc9smOlBpsGX/
 fA0HHGIxFc0vR4cSyRlJAnaDLaQdDvO+mSDdDByx97dIWIHN6SFyADmYInwm3Oszb1bU
 oJMhDtcK6g73MfRVjAzFE6IT+OBITCT2REk6oOqHgPS3Ibn1ngpRP4a15SnZjK1Q8XDG
 YwPRPPScQKEQZMJsXc/xaFi0OJaeLs1dPq/9GqSc5FhdosfR/xOpJfW8GguUZUrCjpOB
 GVj4e4rTIMwXjg2Yy1R+5z2qTEml2DddnElIeKjcMgI9ovm1T3ovWO/QvA0hPIQXttZb
 27DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYRbTGDRaE3Ro+l0ljSpG6gmKLjxGSGOu1XXQrskuULS0tUBHYrcoh+DRvSOQvhqVXWOMxMV2cUil5@nongnu.org
X-Gm-Message-State: AOJu0Yxr4CPUhJVg/koCTN8tMk/98Y/JKcIGh88nGVg68kua3I6CNskd
 MIC5fy1qdw8ZwWARM2j/JxgjJV/+CI2GchjiAN8BXWU1aqRBkIIjOg8i5JeHzBN6CzOVILxbIMs
 g0RRY+jZmo8qDQHjJiREphOWEXvykT9jOqYqt8pmTCjLlTUuoOTsJ
X-Received: by 2002:a17:902:d48d:b0:1f9:f3c6:ed37 with SMTP id
 d9443c01a7336-200ae4f98a5mr9660895ad.14.1723196355669; 
 Fri, 09 Aug 2024 02:39:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/q8+8W54vxZ41aNud3M9TXzX/wwGZaI0vjSFGdHEFoQvPprH9olq9vkR0lSeTp5GucuyX9g==
X-Received: by 2002:a17:902:d48d:b0:1f9:f3c6:ed37 with SMTP id
 d9443c01a7336-200ae4f98a5mr9660735ad.14.1723196355262; 
 Fri, 09 Aug 2024 02:39:15 -0700 (PDT)
Received: from [192.168.68.54] ([43.252.112.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f5346csm138690485ad.66.2024.08.09.02.39.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Aug 2024 02:39:14 -0700 (PDT)
Message-ID: <eea906ac-0a46-4ce9-b81a-813e9f730548@redhat.com>
Date: Fri, 9 Aug 2024 19:39:08 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/arm/virt: hide virt_kvm_type() on !CONFIG_KVM
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 philmd@linaro.org, richard.henderson@linaro.org, shan.gavin@gmail.com
References: <20240809035134.699830-1-gshan@redhat.com>
 <20240809035134.699830-2-gshan@redhat.com>
 <CAFEAcA_KWo2fkiFJ4CrznNkti7bdp_QTXWEdc2nJtd-a6=SPpw@mail.gmail.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <CAFEAcA_KWo2fkiFJ4CrznNkti7bdp_QTXWEdc2nJtd-a6=SPpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 8/9/24 7:00 PM, Peter Maydell wrote:
> On Fri, 9 Aug 2024 at 04:52, Gavin Shan <gshan@redhat.com> wrote:
>>
>> virt_kvm_type() and mc->kvm_type() are only needed when CONFIG_KVM
>> is enabled. It's reasonable to hide them when CONFIG_KVM is disabled.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   hw/arm/virt.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 719e83e6a1..83be57db37 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -2991,6 +2991,7 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
>>    * for arm64 kvm_type [7-0] encodes the requested number of bits
>>    * in the IPA address space
>>    */
>> +#ifdef CONFIG_KVM
>>   static int virt_kvm_type(MachineState *ms, const char *type_str)
>>   {
>>       VirtMachineState *vms = VIRT_MACHINE(ms);
>> @@ -3025,6 +3026,7 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
>>        */
>>       return fixed_ipa ? 0 : requested_pa_size;
>>   }
>> +#endif /* CONFIG_KVM */
>>
>>   static void virt_machine_class_init(ObjectClass *oc, void *data)
>>   {
>> @@ -3084,7 +3086,9 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>>   #endif
>>       mc->valid_cpu_types = valid_cpu_types;
>>       mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
>> +#ifdef CONFIG_KVM
>>       mc->kvm_type = virt_kvm_type;
>> +#endif
>>       assert(!mc->get_hotplug_handler);
>>       mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
>>       hc->pre_plug = virt_machine_device_pre_plug_cb;
> 
> This adds extra ifdefs to the source code -- is there any
> reason why we need them? If nothing goes wrong, I'd
> prefer not to clutter the source with thme.
> 

There is nothing wrong in current code. Actually, it's preparatory work
to replace kvm_arm_get_max_vm_ipa_size() with kvm_arch_get_default_type()
in mc->kvm_type() in PATCH[3/4]. kvm_arch_get_default_type() is visible
only when CONFIG_KVM is enabled.

Thanks,
Gavin


