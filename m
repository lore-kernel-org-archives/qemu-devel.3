Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98962F36BA6
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 07:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBSde-0007nL-SK; Sat, 11 Apr 2026 03:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wBSde-0007n5-0h
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 03:20:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wBSdb-00042o-It
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 03:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775892014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mdioEZK1ne1OQdrnhqV3pcA9l1MGi+4tJIw4FV9vRj0=;
 b=CzwJ6LNDPigKflfGgF1wlPSVctve57avTKw1pZs5wKIHhNj+gJEpA51TMmtaXbYsGC78Ms
 Ed0NZqNdqtEdieHucNfuA1pKZvY57IPrr1wWNmUzI7kCZldQp6vLQSf1CrA9KCLkhfa1d2
 u3UfJ9oabTTkIevtr94djHDa4M5mx8M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-2JtEs4-BMIiod5j70PT-xQ-1; Sat, 11 Apr 2026 03:20:11 -0400
X-MC-Unique: 2JtEs4-BMIiod5j70PT-xQ-1
X-Mimecast-MFC-AGG-ID: 2JtEs4-BMIiod5j70PT-xQ_1775892010
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-488ba2919b9so18482555e9.1
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 00:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775892010; x=1776496810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=mdioEZK1ne1OQdrnhqV3pcA9l1MGi+4tJIw4FV9vRj0=;
 b=cm1tyOteLkblA/04xgcr9AexYAO3mymm8Ic8zqhRxkfbmKxlU3KzLf6Y+NGY+5EUYH
 ScP8YgbP6uJ6FcofvPtXZA1CpACSgOvnyPC3HelbQtGoI4d5AZb1989QZSQ7OAmc1UaV
 wWibSLfTg3LUV/vUqxlmFl50TF8Dbft5CGGrfC9frEBaeEzRW8EIYHQJ7TILFCpf3vq8
 AaqoVPDzCFetmVnVus1h68OO1YtmMJH2SYg/1tJdkH4giTB6X1Lwrq0kt+e63KVWdIjW
 ryzxVXQqcbnJFXlgUWelHv8F8Kj1W7p1zQYUqbrvhDFHg4XahN1HhCYqMxUPXCAHnLql
 t+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775892010; x=1776496810;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mdioEZK1ne1OQdrnhqV3pcA9l1MGi+4tJIw4FV9vRj0=;
 b=P9tljAXnq0Mpl26v68BmiTDxwOaesxBKN/DGY6aAXPIEUNXzcVTcOdxNjptstOQ2CX
 grkUor5pAPUCrlVa+vRUuPJ1yT7rGIld9Sxm8qTsRQuLTAbBgZoLkBjk6yf9rwWNhVf0
 wGtOH0GYbCZqG7bflfBQjjJpE3lAJ2PiqNeO0eypQulDIv4chys85MWkXvC9NMfEzePX
 m0u/0Sj/KSqlATvBqNa3/Biz1to2o3tUtUyLzHC5u3+DUFVcjCpB3Y5nFXFHM1YqAe/f
 wkjW2TSKEiEFlpN4k1NsgjopRZ68Qm4jH+ElAARgpJh/Cer5qhE0wzUSqHyzRYpcRAAG
 ZvOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVaPGOFY18krnPkFjJ6DpgiheZJQ2uz/xcHOiV8DNp+Q01ses54bQmaX1C3FpRcWIXpnkKROS2dy3q@nongnu.org
X-Gm-Message-State: AOJu0YzxgbjExWe3XjzYQoQ6XswWXkZQD4EZvr7zFl4LlFDQsFx7QyrJ
 vDhhuqt4/hvIItGAjDOE214p7kjLP7SaT+JXkd9B1fNTdF0s75e+REoAIG+JJ9tovtMMbCszlp7
 0ndRaUQ/pejGg31cpSV5jHqnKjjQqOcY7Caw8esADif27c43BkIkpM5Wf
X-Gm-Gg: AeBDieutqUr28HQzNEYRV+Ag6JIzCXXSC5S+1DJjGQ3zrP7C6aMW4oC01a9uitIkY04
 wxXoHhubI1xHqdeFCVHDj5e2ua4WpPPGb8wEIg+SjXqud5bE7OHEzCXiliz3RMkzLd4hzRGFCV7
 rtVNaCiINoTl8Pah9a+U03d8KiBmY9I4pWkasJK8gJczlzeHljvLkDisEsAuRFvuvof2WY+aEty
 as3AZUB2BlgAOnh3jnRKIIIIq2IwiQ3KoeM2yNjolAl0o/zQobawqhAyWd0kUB+gV299inVl4ps
 hhlgmmxnNeiYpmMYAwcPw51vo1zNVj5KTEXKXfPuAun3NA7f2o47qaQiSRGU3TJYVf4W5H7NamA
 R9+KypDk+2OIN4vumu/SOua6VqRmbWvem+zOA3EQ/4F1HTBb64DVXRbVIFo1o
X-Received: by 2002:a05:600c:45c9:b0:488:bc6a:5285 with SMTP id
 5b1f17b1804b1-488d689d277mr75817285e9.30.1775892010044; 
 Sat, 11 Apr 2026 00:20:10 -0700 (PDT)
X-Received: by 2002:a05:600c:45c9:b0:488:bc6a:5285 with SMTP id
 5b1f17b1804b1-488d689d277mr75816845e9.30.1775892009507; 
 Sat, 11 Apr 2026 00:20:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63deb904sm14642197f8f.9.2026.04.11.00.20.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Apr 2026 00:20:08 -0700 (PDT)
Message-ID: <6e9e2f9e-529d-4754-ae4a-c291a46489be@redhat.com>
Date: Sat, 11 Apr 2026 09:20:07 +0200
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
 <74bec63f-a251-4493-a2bb-f40675bad3c5@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <74bec63f-a251-4493-a2bb-f40675bad3c5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 4/10/26 12:47, Anthony Krowiak wrote:
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
> 
> I'll remove it
> 
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
> I will make that change but I'm wondering; how does QEMU know whether the
> kernel has support for migration of vfio-ap devices or not?

vfio_migration_init() will probe the kernel for migration support
and install a migration blocker in case of failure.

You should see a message like :

   VFIO migration init failed: migration is not supported in kernel


Thanks,

C.


