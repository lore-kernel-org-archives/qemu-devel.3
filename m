Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766B0C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 11:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAoG2-0007BF-8P; Fri, 02 May 2025 07:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAoFp-00076o-H9
 for qemu-devel@nongnu.org; Fri, 02 May 2025 07:08:31 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAoFm-0003nk-F4
 for qemu-devel@nongnu.org; Fri, 02 May 2025 07:08:27 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-acb2faa9f55so236737266b.3
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 04:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746184105; x=1746788905; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FJOKCGyQaTtnCq+FWEvKU9YbgS0xsGfmFfLd2GnUrwY=;
 b=ZvEcrshLsB/syuHfIKiv28nHnBjZwU9vy8kZOH6pBGyNEl0Kfa1pCUOh7LAjr4X77m
 k56h8qnxsAZtnQtfrX29SiCq1XgndqivBOfixZ1bQ3KVX+Zz0XmwDNuLXRVv6YCuJ+KU
 kJXNM3TF44wrDLsuCKEluZxUh+EgmaHmZMLcFuq1jDn7DUskTrQfF1MKviuCnyu9ObQr
 HHA9MsKNorlnk8gb9poOgViz0GVWZ5/kU+wlgRCHBSg20XniiCV1MUl/JcQuWmI2rMkd
 LcxUSqmz4mPcKSBsl7PXlxOVfhmOhVtPaueLcsN/I6WepBBy6gDriFHQe9xj0j7uMA6K
 UPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746184105; x=1746788905;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FJOKCGyQaTtnCq+FWEvKU9YbgS0xsGfmFfLd2GnUrwY=;
 b=Kn0KMKy9cC0zfsA+Zu8EgkgDNDgbNuAkAwJ4XXjWpFBftrJxluVzULgwfIbewgBQT0
 zSpyuqji8zZj+LjVIj9uz1zl2UMgJ/NubeHCIbqbodyIN4auRXT6qR9vAwlGHlYftXR9
 Rjefa92p9boWd8yYzGUkCKV+rcr3UQ2+ODJ1YrR9BKr3Ax6ndU7OuMyDvaSwzQJXuyta
 gobIPFhbaYTIvbfidFedUvFZvq94pP0CAPPnuBGV0SJKTdzeCJ9jpmKimBPXLje72aDR
 oMnrGcLU9P1Y2w9dHIk9F6XJbgHBtmzbFKfg63lm9En0nDiLuJHEu7VjUFyK9BjMsPqX
 k5/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD68rwgWY3GKhwZbilyLhjM+U57YGoAYLYXD9P/1iP8TuVukz4hu0+JzJ0KEyUBAzOgc9VDuHgmkwJ@nongnu.org
X-Gm-Message-State: AOJu0YwV6os1FxF85t1SXrGABNfo7wb1pzFZAZYMaCZDMV1jYSoKuxPw
 j0VJawtZ0SDA+3Nec3hxwQVNzAM6ZzJb2pRtOPWquZ+UTGt+ndBbihHWzkEWp74=
X-Gm-Gg: ASbGncuD2rDR51MJ32eCARTv4xeghf0YFBNWt2xzLKVsKPYsls5gNHqPxooqowT/bUF
 rYoJkrUrz9OFpW2IdTS0JMhelYxp/UQu+F0Syl5Jj0pjL2BFpThzPSTKlZQK4o0hfy//Az4lVJl
 jphbd1ZQDLXz1RQQHDn+8JjlguSJINQhGgarNWwmWh5U1Vt5irM4yA2IG/OOUybU6Y3M68/k01b
 lnKxVzDgAlkKxKEnIaQFy1nSqq/3oqPcbLEViN0BtNikFGThKbqeEjYhf6qpIm1hxjaB+aRhE4j
 aKUQ/AettTOj/8NpXFJH5ERziCOZU8sHKdK5/ZqOldHS4LmNBnx8IzF9kIWakIYYcpLxq9iIj7I
 01pWrJIfm
X-Google-Smtp-Source: AGHT+IHox4o0id8rBPMXLuNWO5hX8oj/NSNQQw8UwS1QOxAi9eEKypWL6qZ9OmqXof29Zh3mubT3pg==
X-Received: by 2002:a17:907:930c:b0:ace:68ad:b4d8 with SMTP id
 a640c23a62f3a-ad17af8f50emr259434066b.38.1746184104838; 
 Fri, 02 May 2025 04:08:24 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1894c02f3sm33651466b.92.2025.05.02.04.08.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 04:08:24 -0700 (PDT)
Message-ID: <15d822fb-10af-4c5a-a0c1-97533ebeae07@linaro.org>
Date: Fri, 2 May 2025 13:08:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/16] hw/char/virtio-serial: Do not expose the
 'emergency-write' property
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
 <20250501183628.87479-16-philmd@linaro.org>
 <c0543716-30e1-4251-9e24-2e9f331ff08d@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c0543716-30e1-4251-9e24-2e9f331ff08d@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 2/5/25 11:41, Mark Cave-Ayland wrote:
> On 01/05/2025 19:36, Philippe Mathieu-Daudé wrote:
> 
>> The VIRTIO_CONSOLE_F_EMERG_WRITE feature bit was only set
>> in the hw_compat_2_7[] array, via the 'emergency-write=off'
>> property. We removed all machines using that array, lets remove
>> that property. All instances have this feature bit set and
>> it can not be disabled.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/char/virtio-serial-bus.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
>> index eb79f5258b6..31bd1b7535d 100644
>> --- a/hw/char/virtio-serial-bus.c
>> +++ b/hw/char/virtio-serial-bus.c
>> @@ -1019,6 +1019,13 @@ static void 
>> virtser_port_device_unrealize(DeviceState *dev)
>>       }
>>   }
>> +static void virtio_serial_instance_init(Object *obj)
>> +{
>> +    VirtIOSerial *vser = VIRTIO_SERIAL(obj);
>> +
>> +    vser->host_features |= BIT_ULL(VIRTIO_CONSOLE_F_EMERG_WRITE);
>> +}
>> +
>>   static void virtio_serial_device_realize(DeviceState *dev, Error 
>> **errp)
>>   {
>>       VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>> @@ -1155,8 +1162,6 @@ static const VMStateDescription 
>> vmstate_virtio_console = {
>>   static const Property virtio_serial_properties[] = {
>>       DEFINE_PROP_UINT32("max_ports", VirtIOSerial, 
>> serial.max_virtserial_ports,
>>                                                     31),
>> -    DEFINE_PROP_BIT64("emergency-write", VirtIOSerial, host_features,
>> -                      VIRTIO_CONSOLE_F_EMERG_WRITE, true),
>>   };
>>   static void virtio_serial_class_init(ObjectClass *klass, const void 
>> *data)
>> @@ -1186,6 +1191,7 @@ static void virtio_serial_class_init(ObjectClass 
>> *klass, const void *data)
>>   static const TypeInfo virtio_device_info = {
>>       .name = TYPE_VIRTIO_SERIAL,
>>       .parent = TYPE_VIRTIO_DEVICE,
>> +    .instance_init = virtio_serial_instance_init,
>>       .instance_size = sizeof(VirtIOSerial),
>>       .class_init = virtio_serial_class_init,
>>       .interfaces = (const InterfaceInfo[]) {
> 
> You could also consider removing vser->host_features completely, since 
> it is always ORd into the host_features list in get_features(), plus all 
> remaining mentions are of the form:
> 
> if (virtio_has_feature(vser->host_features,
>          VIRTIO_CONSOLE_F_EMERG_WRITE)) { ... }

Good remark, thanks!

