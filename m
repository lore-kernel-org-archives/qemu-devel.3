Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE52BCD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXJYe-0004To-N4; Wed, 10 Jun 2026 10:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wXJYI-0004Sp-Dz
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 10:05:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wXJYG-0006Lc-Eo
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 10:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781100302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VrXJxBItmcpIBW1prBlafln7Wk37YqgSLpAOIZaL8gQ=;
 b=TlHDLaQXytcYMEcXwqzDzEJNVpgOGT/bHJ27Wh2tP4ZC6EwUAzHERbLc/FYNee6bWMpguU
 0+jKo+6AL+JkFW+RuMHg5gQZLYCbds+Zp8YDCgb9onRT4TOCPm1iQG3c3CKYpS7Uf1n1sE
 1WjbazUBzYPKyHafmcdNfR/R/fHa8YA=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-aNisFd0tNSGKp3phUgKppQ-1; Wed, 10 Jun 2026 10:05:00 -0400
X-MC-Unique: aNisFd0tNSGKp3phUgKppQ-1
X-Mimecast-MFC-AGG-ID: aNisFd0tNSGKp3phUgKppQ_1781100299
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8423efdbe6fso4382248b3a.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 07:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781100299; x=1781705099; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VrXJxBItmcpIBW1prBlafln7Wk37YqgSLpAOIZaL8gQ=;
 b=DTXujg289JxnnqjSafStiMqDXAZOy+FqxRwPiP9em5OZKyy6a+jX2zzzGLOPWj1MJp
 /IPA5QW2ryXdRG8qZVidhADwgsjt/qu2+cH4aUQbYrmdUPCRTAjdO7o/IeI7UiSl2Ecg
 ifNBQ7g5hUQXL/9bncg5yvDxlSY1E/fodkT2yqkgv3MlpwUyK8pKrBg9efKymcNowbNP
 ZxCmucQzNfj7H2fwnl4sMroYN5KyThP8sm9VZdS34V7NEQ6Gy2d7EwPL74bmbV6/4i+5
 gM2+v86foZR4LLGb3TFLDQblb18fasP0CpjHsXGdL14CZKpGoJHSWTd4p1AEezzwAPpE
 pXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781100299; x=1781705099;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VrXJxBItmcpIBW1prBlafln7Wk37YqgSLpAOIZaL8gQ=;
 b=neZKCzccR+rHFvHQYjK2RiS2QT1l0T5C4YJl7aHSgoXbO2QlAv/SLjKImbw3Pvt8e2
 VcMqy8pS/VWciYzvmGidKRAlPn5cLH2BvYth/hH9kDNcujZHpeyojf/kJ4fkH1/52E7C
 df+Z2UZPd7MyZ5k/nspmYLr6kIn5g7E5D8ZFqDevTC+EJqdFJ8h8Tc6zoiYgTqeiFTLA
 bZZT/t7wuieKOhqGYlwyVYlirh88lzDGMu3SBQ09cD57g/Tlf9YtYHaltq+Bkc8OJZy0
 NLDE8XOx1F03dK12+I1FE+gpAYMPNfLA20A/40xIXygGltNPz5K2Uhfpfr7CuCzyncU7
 8CAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+LtrYmiqHqPJYZ6C8+6EC1Belt4DtRGfUwVrsgcW1ZxMBwyXdw5Jqo1iMj6Vz8hJDa7tQUEJieghYu@nongnu.org
X-Gm-Message-State: AOJu0YwgsIMgJQBcM0JEf35sn2w/W4zdAM/VQFocvyOpvVr57rGqnUk0
 JJ85gNj2iEtWuPccvJs3s8KTRbuUsKrnKhZoNDt18054nusxHifzRtCOJ2jOqu9S+eqd2nNcp+o
 HpucliCrbR+WPOER9BFP0G5n419pTv/STK9u/GuHG5BdFidck5BK0zDZc
X-Gm-Gg: Acq92OFUvsaoAgkNuah8csf6FBdRIMZ4BZzmyIrItk7bUHL8FlEqKolMoI6x60A/FMO
 cXzRGJCcQsHX4PUfN8TtEQArfxND5pITLi0/w51HIhnWaTongjMs7uHyFGqILPm8nw+QjaJvZTT
 3E4yHic0nz+lhwkqTrhyIb06p6JOV4owoTovxF04piwv2vAQpnaiqQJ8Ecg7DKlfDbKxfIjsrov
 UXNO/qmbs6jwS7mxQ2g8IhAoSngAe9ZT3E32eezshKVUZZPXkzahxvwDk+nOzvxlUs7rCULAgbT
 gPqXzSM1cpqQhtg5IQZSKAfC2N2tjK+cplpWm6JAC6iXpMs4kDm3L1QhJ4t37Vu1tLAIt9YSt+e
 0xqO8vjvegSfzn49hHkIEzk4DVAh+n85b0Nl46/urXWOUTEZXGxyZhXVRQ2gJ//KY6xGYYKv1GW
 M=
X-Received: by 2002:a05:6a00:1f11:b0:842:3801:47f with SMTP id
 d2e1a72fcca58-8430a672800mr8843573b3a.17.1781100299258; 
 Wed, 10 Jun 2026 07:04:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:1f11:b0:842:3801:47f with SMTP id
 d2e1a72fcca58-8430a672800mr8843509b3a.17.1781100298747; 
 Wed, 10 Jun 2026 07:04:58 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-842828fa877sm25270150b3a.51.2026.06.10.07.04.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 07:04:58 -0700 (PDT)
Message-ID: <7cdbbf7b-e245-4d62-9461-a18a680e1719@redhat.com>
Date: Thu, 11 Jun 2026 00:04:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
To: Pavel Hrdina <phrdina@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com, jugraham@redhat.com, shan.gavin@gmail.com
References: <20260608001821.850921-1-gshan@redhat.com>
 <aiaDgG26a6TUrKuM@redhat.com>
 <07ca74b4-52a8-4187-a57c-7c3277e574d3@redhat.com>
 <aiky9d9IwACIyKEC@phrdina-thinkpadt14gen4.rmtcz.csb>
 <674d5e21-88fa-4a10-a83c-eb6f7ce7032f@redhat.com>
 <ailU5beAUVJ1Fdpt@phrdina-thinkpadt14gen4.rmtcz.csb>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <ailU5beAUVJ1Fdpt@phrdina-thinkpadt14gen4.rmtcz.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/10/26 10:23 PM, Pavel Hrdina wrote:
> On Wed, Jun 10, 2026 at 08:55:10PM +1000, Gavin Shan wrote:
>> Hi Pavel,
>>
>> On 6/10/26 7:54 PM, Pavel Hrdina wrote:
>>> On Mon, Jun 08, 2026 at 09:11:50PM +1000, Gavin Shan wrote:
>>>> Hi Daniel,
>>>>
>>>> On 6/8/26 6:55 PM, Daniel P. Berrangé wrote:
>>>>> On Mon, Jun 08, 2026 at 10:18:21AM +1000, Gavin Shan wrote:
>>>>>> On the guest where a NVidia's GH100 card is passed from the host, the
>>>>>> guest system hang can be observed on attempt to compile 'cuda-samples',
>>>>>> as reported by Julia.
>>>>>
>>>>> snip
>>>>>
>>>>
>>>> Thanks for looking into this.
>>>>
>>>>>> By default, the max bounce buffer size is only 4096 bytes, even less
>>>>>> than one page when the guest page is 64KB. This tries to fix the issue
>>>>>> by inheriting the customized max bounce buffer size of the virtio bus's
>>>>>> parent through property 'x-max-bounce-buffer-size' when the customized
>>>>>> size is a larger one. With this applied, no guest system hang is seen
>>>>>> with '-device virtio-blk-pci,...,x-max-bounce-buffer-size=268435456'.
>>>>>
>>>>> "x-max-bounce-buffer-size"  is an experimental / unsupported property.
>>>>>
>>>>> We really shouldn't be expecting users to have to set this in a production
>>>>> deployment in order to stop a guest from hanging.  Even if we dropped the
>>>>> experimental marker from this property, users would still need to know to
>>>>> provide this magic setting, so it would still be broken out of the box.
>>>>>
>>>>> How can we  get a solution that "just works" out of the box, which is
>>>>> fully supported, not relying on experimental properties ?
>>>>>
>>>>
>>>> How do we know that "x-max-bounce-buffer-size" is an experimental or unsupported
>>>> property? I guess the properties whose names start with "x-" are all treated as
>>>> experimental and unsupported?
>>>>
>>>> For this case, the bounce buffer is inevitable as the memory region can't be
>>>> directly accessed. The memory region is initialized by memory_region_init_ram_device_ptr()
>>>> in hw/vfio/region.c::vfio_region_mmap(). So the question is how the allowed
>>>> bounce buffer size can be specified by users, and it's why the existing property
>>>> "x-max-bounce-buffer-size" is reused.
>>>>
>>>> I even thought of a new property for MachineState (e.g. "limited-bounce-buffer"),
>>>> which is set to on by default, following the existing behavior. When it's set to
>>>> off by users, the max (allowed) buffer size won't be checked at all. However, I'm
>>>> not sure if this makes sense at all.
>>>
>>> Hi Gavin,
>>>
>>> You did not answer the question that Daniel was asking, how will user
>>> know that max-bounce-buffer-size should be used if it's necessary to fix
>>> guest system hangs and how will user know what magic value should be set?
>>>
>>
>> Sorry that I missed to answer Daniel's questions. For this specific case,
>> user need to enlarge the bounce buffer size when seeing the following error
>> message. We can add an explicit one in address_space_map() if the existing
>> error message isn't obvious.
>>
>>    qemu-system-aarch64: virtio: bogus descriptor or out of resources
>>
>>    void *address_space_map(AddressSpace *as,
>>                          hwaddr addr,
>>                          hwaddr *plen,
>>                          bool is_write,
>>                          MemTxAttrs attrs)
>>    {
>>        if (!memory_access_is_direct(mr, is_write, attrs)) {
>>            if (l == 0) {
>>                error_report("Running out of bounce buffer size , enlarge it with max-bounce-buffer-size");
>>                *plen = 0;
>>                return NULL;
>>            }
>>        }
> 
> This may work when using qemu directly but users will not see this error
> when using libvirt or management tools like kubevirt.
> 

Ok, then an error message raised by error_report() won't help.

>> As to the value user should take for max-bounce-buffer-size, it is really case by case
>> and decided by user. User needs to try 4096, 8192, ..., 0xFFFFFFFF to figure out the
>> smallest value works for them. The worst case is to set 0xFFFFFFFF.
> 
> Doesn't sound like pleasant user experience playing guessing game to
> figure out how to make a VM work and again will most likely not work for
> kubevirt where users are usually not exposed to these low level properties.
> 
> I'm not familiar with the internals but isn't there a better way how to
> solve it without requiring users to figure out by guessing what value works?
> 

Not really. The worst case is to have 'max-bounce-buffer-size=0xFFFFFFFF',
which is to disable the check against the max bounce buffer size :-)

Peter and Michael already lead the direction to bypass the bounce buffer
for this specific case. It worked for me and no guest hang isn't seen when
the bounce buffer is bypassed in address_space_map().

Thanks,
Gavin


