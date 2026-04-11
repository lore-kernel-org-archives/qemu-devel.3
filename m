Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0B9F36BA7
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 07:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBTCy-0001zv-9R; Sat, 11 Apr 2026 03:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wBTCx-0001zb-Fh
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 03:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wBTCu-0000YH-VK
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 03:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775894203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=u3GA70hj4p4LL5c8Uv+bm+kbx2+3axZjdM+dDePyOxo=;
 b=IpEvX944Awxhdgg3oHaASrndkRZtiUEr/GScV+6JKjZddaWLM5pAaqWNDWFiJadERIm0f8
 ys2ItyZ6DfzR1asGk6HroMf0VT0V7tTbHk1ci9biVTYGYsI6kPYUSkVOZqXqgQ+4S7/6FU
 nKC9hC41jEtUQYzEKuVcHFeiB7a0gUY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-OJmjro01NUKBY3TP6roK7A-1; Sat, 11 Apr 2026 03:56:41 -0400
X-MC-Unique: OJmjro01NUKBY3TP6roK7A-1
X-Mimecast-MFC-AGG-ID: OJmjro01NUKBY3TP6roK7A_1775894200
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43d03065782so1621932f8f.0
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 00:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775894200; x=1776499000; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=u3GA70hj4p4LL5c8Uv+bm+kbx2+3axZjdM+dDePyOxo=;
 b=Pr+ak126JubZDOGRpj4/KXC3FFYByEhrWoEtO7l4jzXDdM5NyNMrcA+zkl0i1bEEUG
 7AwHYtUfy153o+9FSBx1OaeSm42vT5tl1SEWw+J8A5KVB7mC4zyvkrobpU2R7VJFSBMd
 ZY0DTd0QxvPd1KkbdtsNvvXynpFy2MTwxK27YbaH+ksBpQk35Av8O/B/UptMPucSpSi2
 ya3kxm1tLSz/KbRAfzHCI/6clJH6LOAx21NWvBfqKkMk1MQGONYb33bnio8a1VF10lzx
 9x9d8WZFP4Nj+q1CJDjOepuKRDov8dfFLW1rFMcyaUEWy2z7S2V0wkOUKpbKeeLvtP6a
 IHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775894200; x=1776499000;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u3GA70hj4p4LL5c8Uv+bm+kbx2+3axZjdM+dDePyOxo=;
 b=JD0B3/C29bq/gi4SsMi+ZV19yiohNAs+qUrIZuplv0h26mbVpro6wyq9iyuTABjrHo
 +aLURspHHal1+q0Nngbf+i7aFK8W2U/7R156Wgqr+tfIBZnpCsFu3vKHKcRlKeZ4JVqz
 6GOln108XGFpV5SwPrK3jwNUK0tGC+1OCsGt+zKVtkvEImEyhVI+LHcCOIrkizMHXUAW
 PWdBs+DhG8gTCfAV1L0apv5eVu2VdtZoRdvU2WIzLlzr1Xpf52DiudmkuDH8fvW1grRY
 vCOebtSpoq0dyvdG5IE5cV1ILiEWbRgHJi1vs2aguJ30mquwVc3cQilKQnu/B2yNX3d8
 x+5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbi77BygbkXsKhtXk2CeO4EsecGwRtEe1ku9bBBJ4XK8kc26ja5kOWUp2UN0FvLe+dvXYqERSbQXJA@nongnu.org
X-Gm-Message-State: AOJu0YyYkcI57PKAN1HcFqRhzgMub0Jdfe0hMURbaF5hLg07m50ijFom
 1HrCAHSgB/T3gHI/VenC9X+S2STKdNUrjyU3x4sSDkJN2o5gbN8MbEZxMRcuDN9SeDDc00mEZyY
 wfnnkN1Ob5fmxLSBhmUQauhrgeDo4SBuwoo2XeqHclPe1XDvxy22a1AJx
X-Gm-Gg: AeBDievmTGzfz4ayu1XLa7zStmXXQu8UD3Co8ZMxFu/uAPlO9epEKSOtcbUNnAz2Fjf
 zlmSQimdzP359/PuvFIgaBwtjMe5/Yhb+EPSzgOqAexMyL/TLduUSGzXN9Sd3hfK7xINkVKyhYa
 /EDJpIWmD7MTrPYrG06F1LVd8wSzgAqg8D658ujKDQ4ktc7dY9h+K0X4edB35zfA8/rV6mP0GEK
 lpo25L27Xqe+r8dgvLcXuYR5P1WV+TuurY5UVho+VEvI/mD0gdrW4x5woM9F60tc/URSb3XPyNb
 lGSjsDwnX3g82bOIQmmBktW3D+3G7Uhz+tzC5ocITCaD4EPu3yi7vc/EQyTfW927gKz5glAgcsv
 7wO137+cMUEDM0PfOitV10By3bKS6OlkgnjVkYrdG9W9hDLT4XScnDnJ833uT
X-Received: by 2002:a05:6000:2383:b0:43c:fd4d:2409 with SMTP id
 ffacd0b85a97d-43d642c9421mr8666420f8f.46.1775894200330; 
 Sat, 11 Apr 2026 00:56:40 -0700 (PDT)
X-Received: by 2002:a05:6000:2383:b0:43c:fd4d:2409 with SMTP id
 ffacd0b85a97d-43d642c9421mr8666396f8f.46.1775894199850; 
 Sat, 11 Apr 2026 00:56:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e46713sm14873801f8f.21.2026.04.11.00.56.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Apr 2026 00:56:39 -0700 (PDT)
Message-ID: <1ba6e7b2-5b5d-4ebc-b9bb-c5a3d68bcb56@redhat.com>
Date: Sat, 11 Apr 2026 09:56:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hw/vfio/ap: Callbacks for migration of guests with
 pass-through access to AP devices
To: Anthony Krowiak <akrowiak@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, mjrosato@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, farman@linux.ibm.com, borntraeger@linux.ibm.com,
 alex@shazbot.org, cohuck@redhat.com
References: <20260409141352.997844-1-akrowiak@linux.ibm.com>
 <20260409141352.997844-3-akrowiak@linux.ibm.com>
 <be428e83-258e-407f-ade3-e1d48a80b074@redhat.com>
 <d57069a5-ac2a-471f-a955-bf9b2169be8a@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <d57069a5-ac2a-471f-a955-bf9b2169be8a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/10/26 12:50, Anthony Krowiak wrote:
> 
> 
> On 4/10/26 4:19 AM, Cédric Le Goater wrote:
>> On 4/9/26 16:13, Anthony Krowiak wrote:
>>> From: Anthony  Krowiak <akrowiak@linux.ibm.com>
>>>
>>> Implements the callbacks used by the VFIO migration framework to migrate
>>> guests with pass-through access to s390 crypto devices.
>>>
>>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>>> ---
>>>   hw/vfio/ap.c | 43 +++++++++++++++++++++++++++++++++++++++----
>>>   1 file changed, 39 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>>> index fd68983702..49947b18c3 100644
>>> --- a/hw/vfio/ap.c
>>> +++ b/hw/vfio/ap.c
>>> @@ -32,6 +32,7 @@
>>>   #include "hw/s390x/ap-bridge.h"
>>>   #include "system/address-spaces.h"
>>>   #include "qom/object.h"
>>> +#include "vfio-migration-internal.h"
>>>     #define TYPE_VFIO_AP_DEVICE      "vfio-ap"
>>>   @@ -47,6 +48,7 @@ static const VMStateDescription vmstate_ap_device = {
>>>       .name = "vfio-ap-device",
>>>       .version_id = 1,
>>>       .minimum_version_id = 1,
>>> +    .unmigratable = 0,
>>
>> unneeded.
>>
>>>       .fields = (const VMStateField[]) {
>>>           VMSTATE_END_OF_LIST()
>>>       },
>>> @@ -66,17 +68,44 @@ static void __attribute__((constructor)) vfio_ap_global_init(void)
>>>       qemu_mutex_init(&cfg_chg_events_lock);
>>>   }
>>>   +static int vfio_ap_save_config(VFIODevice *vdev, QEMUFile *f, Error **errp)
>>> +{
>>> +    VFIOAPDevice *vapdev = container_of(vdev, VFIOAPDevice, vdev);
>>> +
>>> +    return vmstate_save_state(f, &vmstate_ap_device, vapdev, NULL, errp);
>>> +}
>>> +
>>> +static int vfio_ap_load_config(VFIODevice *vdev, QEMUFile *f)
>>> +{
>>> +    VFIOAPDevice *vapdev = container_of(vdev, VFIOAPDevice, vdev);
>>> +    Error *err = NULL;
>>> +    int ret;
>>> +
>>> +    ret = vmstate_load_state(f, &vmstate_ap_device, vapdev, 1, &err);
>>> +    if (ret) {
>>> +        error_report_err(err);
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static Object *vfio_ap_get_object(VFIODevice *vbasedev)
>>> +{
>>> +    VFIOAPDevice *vdev = container_of(vbasedev, VFIOAPDevice, vdev);
>>> +
>>> +    return OBJECT(vdev);
>>> +}
>>> +
>>>   static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>>>   {
>>>       vdev->needs_reset = false;
>>>   }
>>>   -/*
>>> - * We don't need vfio_hot_reset_multi and vfio_eoi operations for
>>> - * vfio-ap device now.
>>> - */
>>>   struct VFIODeviceOps vfio_ap_ops = {
>>>       .vfio_compute_needs_reset = vfio_ap_compute_needs_reset,
>>> +    .vfio_save_config = vfio_ap_save_config,
>>> +    .vfio_load_config = vfio_ap_load_config,
>>> +    .vfio_get_object = vfio_ap_get_object,
>>>   };
>>>     static void vfio_ap_req_notifier_handler(void *opaque)
>>> @@ -251,6 +280,10 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>>>           goto error;
>>>       }
>>>   +    if (!vfio_migration_realize(vbasedev, errp)) {
>>> +        goto error;
>>> +    }
>>> +
>>>       if (!vfio_ap_register_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX, &err)) {
>>>           /*
>>>            * Report this error, but do not make it a failing condition.
>>> @@ -287,6 +320,8 @@ static void vfio_ap_unrealize(DeviceState *dev)
>>>     static const Property vfio_ap_properties[] = {
>>>       DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
>>> +    DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOAPDevice,
>>> +                            vdev.enable_migration, ON_OFF_AUTO_ON),
>>
>> Why not ON_OFF_AUTO_AUTO ? This would enable migration only if kernel
>> has migration support. If not, the VM would still start but migration
>> would be blocked.
> 
> Will this allow the vfio-ap device migration patches to get merged before
> the kernel/KVM patches?

It's possible. Several reasons could explain the lack of migration
support. The most obvious is a lack of kernel support, but it could
also be a firmware support issue, an incompatible hardware state of
the adapter, adapter model, etc.

Do all CEXxS crypto cards support migration ?

Do you expect kernel support [*] to be merged in v7.1 ?

Also, I think the QEMU support lacks vfio_migration_exit().

Thanks,

C.

[*]  https://lore.kernel.org/r/20260407205100.331150-1-akrowiak@linux.ibm.com


