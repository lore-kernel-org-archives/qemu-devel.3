Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EF9D5C0E1
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 14:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9QQn-0005I0-4J; Fri, 08 Nov 2024 09:57:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t9QQh-0005Gd-H8
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:57:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t9QQf-0006qf-9y
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731077858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GRPlznnubeR15irlmXdcFr8p9Fcm02Ip9Vx0uGC19lw=;
 b=amPngT6kU0W7Allt7mO6lW2IYPqBMvFzfbvNyvqnSu0OIE76RPCr1TDrj7HJWBb9S+qAUB
 bJ6KQ7QzpfWmUU5maeHnGP/2bpzNSLRA9DwA5RlYpnn5JgRaKICIJcxAbn/Lmov0Abn26R
 UBFkLo9JVF89Ss/4y2kW76lpG9lACPY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-0AfquZJWOp6O4i_NEWAEIg-1; Fri, 08 Nov 2024 09:57:36 -0500
X-MC-Unique: 0AfquZJWOp6O4i_NEWAEIg-1
X-Mimecast-MFC-AGG-ID: 0AfquZJWOp6O4i_NEWAEIg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43159603c92so15293745e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 06:57:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731077854; x=1731682654;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GRPlznnubeR15irlmXdcFr8p9Fcm02Ip9Vx0uGC19lw=;
 b=k57At/sWdqOTXqDcuVZtOaXsegbECUNhFmqY/AaOQgU7mFB4CtTD/XBgIUo68jr5PJ
 SAsy3ecTuPBaYJplJwRnJk6LwAen8GfioYOokPXQD1KohvZ6vsYGKlmdum6pcMKjsZ97
 jlk0gmVu+Az7KGRjSxH/h5RUTyHEZPXg4nC2VYZ1uUNWwI2/4OTWrfRSJNlJGjFKUmyB
 L9wWwyto/7duodWjGzJB2Q9dGTX0AclFsuci0023vwOVyTgGih3UsnrOnK/bvVikykWW
 sRfTwnKJc+kKnpToZFHsomv0uIwOxWfH9J4JI2K2DixrI+xKqVSBz3ZBdpzP+NAHZEuS
 J1uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvR9xr5pCjiIfyX0RSiVwuCFB9WBfssRycbggsTbOL4BXOmI+Buq6/Wp6AhjQPhd9cSSWQKvVlmODE@nongnu.org
X-Gm-Message-State: AOJu0YwDUVFnNUsWKhQ8G+XVFLxnujIEyHDm32ssOn0TSQoBDkR0Z49w
 afKqvWVJH+7IOVMYZYGjDnug875YlB8NipRAbLFdTmggBgMoCabKI21X2/4mTb89ny/tNHFp2K/
 7/bUG9wYppMjiCuGvzgWwVq6zMcvg19ST+jmg0ke13m6I3VBrjmgwORfY/Vjh
X-Received: by 2002:a05:600c:4f83:b0:42a:a6d2:3270 with SMTP id
 5b1f17b1804b1-432b7517aa4mr24537235e9.21.1731077854126; 
 Fri, 08 Nov 2024 06:57:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSG9W7J4LokiVVBJz973na8tNazwgMz236aVXrFR2NJWZZ/uehUVbOa6iepKzF6ap8X33QWg==
X-Received: by 2002:a05:600c:4f83:b0:42a:a6d2:3270 with SMTP id
 5b1f17b1804b1-432b7517aa4mr24537025e9.21.1731077853738; 
 Fri, 08 Nov 2024 06:57:33 -0800 (PST)
Received: from ?IPV6:2003:d8:2f3a:cb00:3f4e:6894:3a3b:36b5?
 (p200300d82f3acb003f4e68943a3b36b5.dip0.t-ipconnect.de.
 [2003:d8:2f3a:cb00:3f4e:6894:3a3b:36b5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed97ce27sm5140065f8f.29.2024.11.08.06.57.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2024 06:57:33 -0800 (PST)
Message-ID: <23850861-3600-4bdc-aada-ff36e3152372@redhat.com>
Date: Fri, 8 Nov 2024 15:57:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] virtio-mem: unplug memory only during system resets,
 not device resets
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Juraj Marcin <jmarcin@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
References: <20241025104103.342188-1-david@redhat.com>
 <9100ea2c-21e4-4f04-91fa-8b56986abcdf@linaro.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <9100ea2c-21e4-4f04-91fa-8b56986abcdf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 08.11.24 15:37, Philippe Mathieu-Daudé wrote:
> Hi David,
> 
> On 25/10/24 11:41, David Hildenbrand wrote:
>> We recently converted from the LegacyReset to the new reset framework
>> in commit c009a311e939 ("virtio-mem: Use new Resettable framework instead
>> of LegacyReset") to be able to use the ResetType to filter out wakeup
>> resets.
>>
>> However, this change had an undesired implications: as we override the
>> Resettable interface methods in VirtIOMEMClass, the reset handler will
>> not only get called during system resets (i.e., qemu_devices_reset())
>> but also during any direct or indirect device rests (e.g.,
>> device_cold_reset()).
>>
>> Further, we might now receive two reset callbacks during
>> qemu_devices_reset(), first when reset by a parent and later when reset
>> directly.
>>
>> The memory state of virtio-mem devices is rather special: it's supposed to
>> be persistent/unchanged during most resets (similar to resetting a hard
>> disk will not destroy the data), unless actually cold-resetting the whole
>> system (different to a hard disk where a reboot will not destroy the data):
>> ripping out system RAM is something guest OSes don't particularly enjoy,
>> but we want to detect when rebooting to an OS that does not support
>> virtio-mem and wouldn't be able to detect+use the memory -- and we want
>> to force-defragment hotplugged memory to also shrink the usable device
>> memory region. So we rally want to catch system resets to do that.
>>
>> On supported targets (e.g., x86), getting a cold reset on the
>> device/parent triggers is not that easy (but looks like PCI code
>> might trigger it), so this implication went unnoticed.
>>
>> However, with upcoming s390x support it is problematic: during
>> kdump, s390x triggers a subsystem reset, ending up in
>> s390_machine_reset() and calling only subsystem_reset() instead of
>> qemu_devices_reset() -- because it's not a full system reset.
>>
>> In subsystem_reset(), s390x performs a device_cold_reset() of any
>> TYPE_VIRTUAL_CSS_BRIDGE device, which ends up resetting all children,
>> including the virtio-mem device. Consequently, we wrongly detect a system
>> reset and unplug all device memory, resulting in hotplugged memory not
>> getting included in the crash dump -- undesired.
>>
>> We really must not mess with hotplugged memory state during simple
>> device resets. To fix, create+register a new reset object that will only
>> get triggered during qemu_devices_reset() calls, but not during any other
>> resets as it is logically not the child of any other object.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Juraj Marcin <jmarcin@redhat.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>    hw/virtio/virtio-mem.c         | 103 +++++++++++++++++++++++----------
>>    include/hw/virtio/virtio-mem.h |  12 +++-
>>    2 files changed, 83 insertions(+), 32 deletions(-)
> 
> 
>> +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(VirtioMemSystemReset, virtio_mem_system_reset, VIRTIO_MEM_SYSTEM_RESET, OBJECT, { TYPE_RESETTABLE_INTERFACE }, { })
> 
> Please fix style when applying :)

The long line? I used hw/core/reset.c and hw/core/resetcontainer.c as 
inspiration -- they surely can't be wrong ;)

> 
>> diff --git a/include/hw/virtio/virtio-mem.h b/include/hw/virtio/virtio-mem.h
>> index a1af144c28..abde1c4101 100644
>> --- a/include/hw/virtio/virtio-mem.h
>> +++ b/include/hw/virtio/virtio-mem.h
> 
> 
>> +struct VirtioMemSystemReset {
>> +    Object parent;
> 
> And add a newline here, thanks!

Make sense, thanks!


-- 
Cheers,

David / dhildenb


