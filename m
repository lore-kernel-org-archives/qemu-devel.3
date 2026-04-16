Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBF2F8D753
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 15:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDOHs-00079Z-Ti; Thu, 16 Apr 2026 11:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wDOHr-00079P-6t
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 11:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wDOHj-0000V0-GP
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 11:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776351938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=21ZZeS43MTHuxp8Gt8OYHhwFrHS8FLAVEX+HWpUWFKQ=;
 b=CmllE53/3vJ0M5mOtebVyYvniuQH7M/Ra3nATM1vXRHK9XW5e8BS8CApc7CgQ1m67aMbs8
 iLes+x88Tg4+YMoKEebgkR7eW7ZOWvP3gfgz7Uv7E5KnVDF42/VUesAAG/cqONsM7DUECk
 7x/JzMpbPdIZAxS8AMjEzSw5nYEJQ4E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-dd7Zmxt5PqCHRh3ZAnLdTg-1; Thu, 16 Apr 2026 11:05:35 -0400
X-MC-Unique: dd7Zmxt5PqCHRh3ZAnLdTg-1
X-Mimecast-MFC-AGG-ID: dd7Zmxt5PqCHRh3ZAnLdTg_1776351934
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b938cb02038so92648766b.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 08:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776351934; x=1776956734; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=21ZZeS43MTHuxp8Gt8OYHhwFrHS8FLAVEX+HWpUWFKQ=;
 b=HXZv/FGelbtp0tWK0tgFFMV8m88l9uGhhHkD/K6UDTq1o9eAIUurwYPbBT8k7YXTQg
 mgbL8FqKT8nGfAOHnR1GWofRT73/Jd4vHGhiwLxaFZOSf3Ggpkkpn26rpkL8CurU+nwn
 GTc0oIfzN7cVuh1k6tsGveFN7h/A6d+e9DnTKUWfdfCqbEXOZaTC4TJ17q+3x5Qj7dXJ
 nkDo0/OQYNFdRT5HRe0lSWixmAaMc8D/YT9unEwOGtjx9UwfLFe3Hib0teIwwB16CTWB
 8WUsjew5TZ43L/75LoUjqAys/23wjDLEE3s8/57IDSKaM/hNfSTv51TUx9nWrvHmOB/D
 kaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776351934; x=1776956734;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=21ZZeS43MTHuxp8Gt8OYHhwFrHS8FLAVEX+HWpUWFKQ=;
 b=g9KjuqhonLUZAQ7F+jXnmDitLt9hlBi2aG34u4/uHQhVxDO09V0em6u/qH4aP2WVyF
 2qEonpBizIbb3e0L3HDsoXm1erTga+cOq2+KA7CWPCn2/fvYqZF5jl9+QUfKFkN0DRAH
 iyXnOl02SmZb8UORItrrWX8c321Z6iTKRv9pLDMK6nUXiIZRkOtgu8P97tUk4jMC300j
 X44pd/IqCdi11qgG5LiIxe+Vm5GWONZ6xKv67RaiMewZJ7k2zbOwCFKjFnXsrOaQaAbV
 x2+UjKVDIRysRi9+/rQFzk5iUOjbkSO/RUtRg8pxQdxpe0Hr71f0A/KCD0naoqHUbaPN
 7bvQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8W8l6S3yjX3+tVjn7UWAhxt82Cc2Endav37uPbT7AuraBE4cC9R7E7JhsQ1mcnD+If0GkSJ7XTnP2h@nongnu.org
X-Gm-Message-State: AOJu0YzngbwauQ1U7HnUDeqaNfbmva9gIMk607WbZU5S4B9n4+igs11t
 iYN+9WoiJuXrm4IDdN3WM42RPBiezzXio6FwGwIAlpDW76/u6uJGv/CjDS2Nto7L2no3ngIepu4
 WCNE1vOibF2EsSjhy+mJ/2nZeP1excK5O4yyRXAMUQyKpb0BsnfcIyFmh
X-Gm-Gg: AeBDiets1rONBXLzW666jiA1DCq7yUhYP30nMPbui23e/gDPaBgXhisszrGAlmKGHzS
 4Yjw9oH0rx5kMkL4HqAwI/w/0BHMGMo/EGaVQg0VPpC0xblPneoC03jhOYmHCXwj8lp4jAyqhRB
 OyMsB67rTrQc8Cku2tFHvFaaUanI/88ID4K167KuTc4BvSWC4UiIQgLxskZV8kY6dD2AvU7Sn6n
 Fsydwr3AgnrCH/l2xFF957BNMNAWNHBPwmCUKTJMw8fC5+XhER9+6O83ECzEuuOz1NukRPUkpGq
 RevsdRZc5g1tXU2HOJr0LopAiOS/i5xOGEOIDoFqaTT7WnAyXFCqBiCSIaJbpFA62wbjG2oOzFC
 aMNASxfZP/FB6y7UdOe7mz6DkUMnwo/kQJlR53jjHSfLoenR30RLFG7f0IwNC
X-Received: by 2002:a17:907:d27:b0:b9b:1ea2:e694 with SMTP id
 a640c23a62f3a-ba269ed06ebmr214657666b.31.1776351934277; 
 Thu, 16 Apr 2026 08:05:34 -0700 (PDT)
X-Received: by 2002:a17:907:d27:b0:b9b:1ea2:e694 with SMTP id
 a640c23a62f3a-ba269ed06ebmr214654566b.31.1776351933634; 
 Thu, 16 Apr 2026 08:05:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67237d842f6sm1325185a12.9.2026.04.16.08.05.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 08:05:33 -0700 (PDT)
Message-ID: <b6276aca-b979-430f-a2bf-1bdc2f1e4c07@redhat.com>
Date: Thu, 16 Apr 2026 17:05:32 +0200
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
 <aadd1d51-231a-4406-9543-ce258653ce28@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aadd1d51-231a-4406-9543-ce258653ce28@linux.ibm.com>
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

On 4/13/26 17:23, Anthony Krowiak wrote:
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
> I made this change and migration failed on the destination host with the
> following error message:
> 
> error: Requested operation is not valid: cannot migrate domain: 62177883-f1bb-47f0-914d-32a22e3a8804: VFIO device doesn't support device and IOMMU dirty tracking
> 
> This despite having the following property defined:
> 
> DEFINE_PROP_ON_OFF_AUTO("x-device-dirty-page-tracking", VFIOAPDevice, vdev.device_dirty_page_tracking, ON_OFF_AUTO_ON)


try adding dummy vfio_log_ops handlers in the driver.


static int mtty_log_start(struct vfio_device *vdev,
			  struct rb_root_cached *ranges,
			  u32 nnodes, u64 *page_size)
{
	return 0;
}

static int mtty_log_stop(struct vfio_device *vdev)
{
	return 0;
}

static int mtty_log_read_and_clear(struct vfio_device *vdev,
				   unsigned long iova, unsigned long length,
				   struct iova_bitmap *dirty)
{
	return 0;
}

static const struct vfio_log_ops mtty_log_ops = {
	.log_start = mtty_log_start,
	.log_stop = mtty_log_stop,
	.log_read_and_clear = mtty_log_read_and_clear,
};

See samples/vfio-mdev/mtty.c.

C.



