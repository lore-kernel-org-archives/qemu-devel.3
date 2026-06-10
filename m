Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE6ACD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGaj-0000rh-7F; Wed, 10 Jun 2026 06:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wXGai-0000rQ-6k
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:55:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wXGag-000373-AA
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781088919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m0J+RJppz2U69gfioEgmnWduX6kml7jg1af9oTlbIFU=;
 b=QQ+uyKtuyIJwFqqRaWnAW0v5UUQTGJA/LxGmzY4/gmVEdTU5YU7Hxvu3AdCMjo18n8s8A5
 sIPLyxb9hH/DNQUtSfio6hxe+v9/bBLAPloR/lRhV/o8w8TDSDL/y7AcOib1m9cy7cCpBg
 mmn+Pw4N47VchOcHuqjb6YlKBI09Nvg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-Ru0Fjox9PkaFYon8DZbN3g-1; Wed, 10 Jun 2026 06:55:18 -0400
X-MC-Unique: Ru0Fjox9PkaFYon8DZbN3g-1
X-Mimecast-MFC-AGG-ID: Ru0Fjox9PkaFYon8DZbN3g_1781088917
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-36d97955899so6316853a91.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 03:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781088917; x=1781693717; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m0J+RJppz2U69gfioEgmnWduX6kml7jg1af9oTlbIFU=;
 b=hsX1EoLYVp3kpW2mUHbFZuZ7EsJB5ri19arIlj60upXzoxrQTl8/co/+hB0PiYl7eL
 LoWs/QJTpQ+S4swU4pDWVeY82afipW6Tnpg5/+sGP7PA+4pxJwq/reTmNjUlMHWSv5w+
 OvGzAAsm+5dxRHiPe6JW+LpYlXJS0Ha+NYiNqYHTahVQLvm9cgMr3+AUnezI4b7lH6e6
 k7NDDturJgBfrb/rt1ugmH5/Ngx6I+xOCtL6fIwnoDXB03Vh2EKKOihIrRsN9ly81fDL
 Q7FVsbjVIIIUK4vU2jL0pXLZLynv6Dm2ft/KjjBcj1SaJ80/INeCASZYpluM3IrE4spG
 jDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781088917; x=1781693717;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m0J+RJppz2U69gfioEgmnWduX6kml7jg1af9oTlbIFU=;
 b=EG0PZaGKq0vx2l6Pi1Igff6QC77JmTOwHcjqLaXcaMVIsXGERCZX8j36CsznPznB7i
 zNKjahoivCHpa/553bBI876BS7LQIYM4osb39PEhAHJzYvRAk+iEWKKYAFy0Nq8dbTaT
 Q2SY3ehTKrwFy+WBBX/ZAIP3LU+x2qtdZQpd2aOHgmHNVRIsJRHvkpDYTl+6S9JZZIhf
 Mn/GqTDLYRTV1FLE+Vi5jeCIAhghyrS7uxfssBN/0d/9AAAGg74KbL360mamouSD/7BB
 wfk2e33ceoyNzuLa3tRSMPIfBfY2QaZTGKPAs6ZFiCMEzFRpAnysuDtANU4t3BpYAGKG
 aGcg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+rdwDOjK7CY40p09WlZYmch0RG3eDVmjmn+iMpvoVmxrA4nlWrcjI/CMRTzw/G5u0ggq7oHmNAYvLE@nongnu.org
X-Gm-Message-State: AOJu0Yx7LgXdOgyM9mQx++ntLKydZ8vXvOu5pbdbcULrtthfPNCf1nOC
 7GrzZ74Tvw88iO6nc/G0OHoJp9Iru4dapetirJyXfMYTLJwhMDYPcpVXBijwxT/waTtz4Z7LzWH
 VzSE6cSF8cLAf6socd9IxW0UqYL0aLK9j7tRp3n6ofTkafMKUFh4rjSBn
X-Gm-Gg: Acq92OG4lhxEya94o9AGkZP5KcPN3Id+KDM43RSawWbpsoBO+F08eAB53FsCQ1nnh7A
 2KU+OG4OTcYx26hMrobd/M0wRjwmdu0HhSnuaifDVbaYBqYp07AvTIPUdC4Mp8wc8BYOl5nJ0Zh
 ZvtkKnEbPea6gTnZ/tnzAPDX1n4B/KavZ5i3uo44gtuan6/Rgmk2iZ3AC1eJ4NevMrO9mMlpiqm
 6BSulUEOWaJEKcksf/ABFEkV0exhCy9FpMkgh2tWqRpv1iSDA6nXgcbLgV4o0FDBJSAq3NyRcDs
 TDA0Aze2daQQ+n6sUlRtOJSbgjrPa+GFDmroRliYwxHrsebBLiL9vbqm9g8zY5SnRjohwpne9Z/
 JQ6Fel78yS9wIsr3YNk0ntXQoAqbRDNYrXdM9WrA6Aw960E2BNFSpzQZ1kEdhBLRvhNKEVMozf+
 0=
X-Received: by 2002:a17:902:fc85:b0:2ba:bfb5:9cc with SMTP id
 d9443c01a7336-2c2a1c87479mr86015925ad.26.1781088917159; 
 Wed, 10 Jun 2026 03:55:17 -0700 (PDT)
X-Received: by 2002:a17:902:fc85:b0:2ba:bfb5:9cc with SMTP id
 d9443c01a7336-2c2a1c87479mr86015535ad.26.1781088916612; 
 Wed, 10 Jun 2026 03:55:16 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16649ca4dsm240517215ad.76.2026.06.10.03.55.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 03:55:16 -0700 (PDT)
Message-ID: <674d5e21-88fa-4a10-a83c-eb6f7ce7032f@redhat.com>
Date: Wed, 10 Jun 2026 20:55:10 +1000
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
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <aiky9d9IwACIyKEC@phrdina-thinkpadt14gen4.rmtcz.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Pavel,

On 6/10/26 7:54 PM, Pavel Hrdina wrote:
> On Mon, Jun 08, 2026 at 09:11:50PM +1000, Gavin Shan wrote:
>> Hi Daniel,
>>
>> On 6/8/26 6:55 PM, Daniel P. Berrangé wrote:
>>> On Mon, Jun 08, 2026 at 10:18:21AM +1000, Gavin Shan wrote:
>>>> On the guest where a NVidia's GH100 card is passed from the host, the
>>>> guest system hang can be observed on attempt to compile 'cuda-samples',
>>>> as reported by Julia.
>>>
>>> snip
>>>
>>
>> Thanks for looking into this.
>>
>>>> By default, the max bounce buffer size is only 4096 bytes, even less
>>>> than one page when the guest page is 64KB. This tries to fix the issue
>>>> by inheriting the customized max bounce buffer size of the virtio bus's
>>>> parent through property 'x-max-bounce-buffer-size' when the customized
>>>> size is a larger one. With this applied, no guest system hang is seen
>>>> with '-device virtio-blk-pci,...,x-max-bounce-buffer-size=268435456'.
>>>
>>> "x-max-bounce-buffer-size"  is an experimental / unsupported property.
>>>
>>> We really shouldn't be expecting users to have to set this in a production
>>> deployment in order to stop a guest from hanging.  Even if we dropped the
>>> experimental marker from this property, users would still need to know to
>>> provide this magic setting, so it would still be broken out of the box.
>>>
>>> How can we  get a solution that "just works" out of the box, which is
>>> fully supported, not relying on experimental properties ?
>>>
>>
>> How do we know that "x-max-bounce-buffer-size" is an experimental or unsupported
>> property? I guess the properties whose names start with "x-" are all treated as
>> experimental and unsupported?
>>
>> For this case, the bounce buffer is inevitable as the memory region can't be
>> directly accessed. The memory region is initialized by memory_region_init_ram_device_ptr()
>> in hw/vfio/region.c::vfio_region_mmap(). So the question is how the allowed
>> bounce buffer size can be specified by users, and it's why the existing property
>> "x-max-bounce-buffer-size" is reused.
>>
>> I even thought of a new property for MachineState (e.g. "limited-bounce-buffer"),
>> which is set to on by default, following the existing behavior. When it's set to
>> off by users, the max (allowed) buffer size won't be checked at all. However, I'm
>> not sure if this makes sense at all.
> 
> Hi Gavin,
> 
> You did not answer the question that Daniel was asking, how will user
> know that max-bounce-buffer-size should be used if it's necessary to fix
> guest system hangs and how will user know what magic value should be set?
> 

Sorry that I missed to answer Daniel's questions. For this specific case,
user need to enlarge the bounce buffer size when seeing the following error
message. We can add an explicit one in address_space_map() if the existing
error message isn't obvious.

   qemu-system-aarch64: virtio: bogus descriptor or out of resources

   void *address_space_map(AddressSpace *as,
                         hwaddr addr,
                         hwaddr *plen,
                         bool is_write,
                         MemTxAttrs attrs)
   {
       if (!memory_access_is_direct(mr, is_write, attrs)) {
           if (l == 0) {
               error_report("Running out of bounce buffer size , enlarge it with max-bounce-buffer-size");
               *plen = 0;
               return NULL;
           }
       }

As to the value user should take for max-bounce-buffer-size, it is really case by case
and decided by user. User needs to try 4096, 8192, ..., 0xFFFFFFFF to figure out the
smallest value works for them. The worst case is to set 0xFFFFFFFF.

> Pavel
> 

Thanks,
Gavin


