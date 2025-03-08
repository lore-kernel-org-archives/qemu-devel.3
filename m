Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C3CC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 06:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqnVO-0002Cr-Eq; Sat, 08 Mar 2025 01:17:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tqnVK-0002CV-7z
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 01:17:47 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tqnVI-0006H3-7c
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 01:17:45 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-223fd89d036so53374495ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 22:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741414662; x=1742019462;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L/KK2VCzW+LoNrIPtwvxc8GN267lZu2Qux8YYpQhYnQ=;
 b=VpvZYznzGsVUVyiT9wAmAhxMm65roOyVU5TlrzHWuqCu0uLJHQJ8ZODyQp7B9ySiHL
 k4ZDR3sHwIOaZPcy/t5sqMeVr19vov0idc0yC+ah53VvoBwsfUqg6kN0aIqnwAIO1IoH
 CB++LeEKf8L88SAGWkx5Q4H90/vKA+XGsqhRAAU0pCPRImwcq86j1da7md0ircFqzhv9
 m/lKhcAqK9Eh1mBv7c7TtwPe1AKkM38iuCbIs+6gwee3dM/OsZOdiV1x4+FsoLsYHPsD
 4H92SkZyJmW2GwSHncicQ3d5J0Abo/GzjX+1rx9bCJRG9UZ9AbaoXeZ7TTR+eco4yWYc
 k76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741414662; x=1742019462;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L/KK2VCzW+LoNrIPtwvxc8GN267lZu2Qux8YYpQhYnQ=;
 b=Nh9adekdPqEv3X6QNYtlDUiFTR9dKWTcSDtyQ97nz2T22cNW0zu+Bt0PbSVqL99FCI
 fBZYB4x/UhWGYofNTAVPAXOw3NXQnvfC4/fjjkDDkITy9jngTqumIN6fgSxeVqRM4fRW
 blBvQcwod9lr3Vk/a0JWskaTLUyl6HymDOSB4COT5iw/6k75N7oIuJZfrvNZBhkGpWV8
 SfyF+D/klctElnUJ8HAlOu957ADDpgOuLhAPde9apqXmU+accVP8I48vtu2GcAh2qF3C
 7JXAlFuez1jS6jeiXrYdUetqFXEXiSd/AtwpRagyxQxXUzzrj8XOrKb7bD0eac6LXXf5
 +yuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8xwFjRGiCGa00V7BpBDGmtJ/snMmWgpQX6wtpLiaSfVPqMHDJqVaG2uh72bFdSvBjK3NKL30Q3hi3@nongnu.org
X-Gm-Message-State: AOJu0YxKbwGRnoopGBCBLfecZ1FfLC0uK1KRu7U5ufjNE/qJo/x4evps
 GhlXIRZlPpCqmxQ4Dgm6QuLqH/u2Q6qwbVDEYhBccHy8R8I6u1vG16/kc8wW49o=
X-Gm-Gg: ASbGncuaRzxqSDQwHfGix6UZUClK4Ofmne4UlolTkqhr0n8XsLjGBpJ0rMPivBt8Gkx
 PsFPjq0vBkCqP3aFQEtISxWm+yShuW0bONGO9D93kCfqB/U0pa7UUWb5u56Vs2oWREUoHD536jq
 tgojCycyjbEysZPVRC1zYoBGPaTGfTINRsCHDKl+fJb890Q/mSvEUhLNGplzwuPeMYGQpLsIslt
 2rYRY0+yfy0jru35yUqjB8iTrGG9CxJtfdfWhVpPnmImA/D9eyGWjsbuom9CVK2kj1huu4X9bl4
 CeyDto9oLpr4SHyVFr4dwnsB1dZKL929j4shC1nq/X+lJCcgMoV9VWBwGQ==
X-Google-Smtp-Source: AGHT+IHd7kUJWuglMlilC3pRCX5D2U6+8e75dr/cgyKEMRQHTyQdcRUGub+1TxgYDGkuEnSIZ2WxEg==
X-Received: by 2002:a17:902:d48c:b0:223:5de7:6c81 with SMTP id
 d9443c01a7336-22428aa193bmr93541855ad.27.1741414662385; 
 Fri, 07 Mar 2025 22:17:42 -0800 (PST)
Received: from [157.82.205.237] ([157.82.205.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a7f8eesm40234105ad.112.2025.03.07.22.17.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 22:17:42 -0800 (PST)
Message-ID: <03baae4d-c443-43c6-a1d8-ef1f8461e07c@daynix.com>
Date: Sat, 8 Mar 2025 15:17:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb-storage: Allow manually adding SCSI device
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org
Cc: devel@daynix.com
References: <20250303-usb-v1-1-70f700a181fd@daynix.com>
 <0128cd62-b5d7-4aa1-b169-2a7717d33113@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <0128cd62-b5d7-4aa1-b169-2a7717d33113@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/03/03 21:17, Paolo Bonzini wrote:
> On 3/3/25 11:28, Akihiko Odaki wrote:
>> usb-storage automatically adds a SCSI device, but it limits
>> configurability of the added SCSI device and causes usability
>> problems as observed in:
>> https://gitlab.com/libvirt/libvirt/-/issues/368
>>
>> Allow manually adding SCSI device when the drive option is not
>> specified.
> 
> I might be misunderstanding what you're doing, but can't you do that 
> already with usb-bot?

I wtithdraw this patch.

I wrote patches for libvirt to fix its issue mentioned in the patch 
message according to your suggestion to use usb-bot and it works nicely:
https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/SVXUWW2426H73XBXJXDUMTDJM3YL37QU/

Regards,
Akihiko Odaki

> 
> Paolo
> 
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   hw/usb/dev-storage-classic.c | 33 ++++++++++++++++-----------------
>>   1 file changed, 16 insertions(+), 17 deletions(-)
>>
>> diff --git a/hw/usb/dev-storage-classic.c b/hw/usb/dev-storage-classic.c
>> index 
>> 56ef39da2e634d1639a07ac4636cdaa000989f5f..33e5a7cfc8bdf3f92b18014e885771aee6d32f5e 100644
>> --- a/hw/usb/dev-storage-classic.c
>> +++ b/hw/usb/dev-storage-classic.c
>> @@ -33,10 +33,9 @@ static void usb_msd_storage_realize(USBDevice *dev, 
>> Error **errp)
>>       BlockBackend *blk = s->conf.blk;
>>       SCSIDevice *scsi_dev;
>> -    if (!blk) {
>> -        error_setg(errp, "drive property not set");
>> -        return;
>> -    }
>> +    usb_desc_create_serial(dev);
>> +    scsi_bus_init(&s->bus, sizeof(s->bus), DEVICE(dev),
>> +                 &usb_msd_scsi_info_storage);
>>       /*
>>        * Hack alert: this pretends to be a block device, but it's really
>> @@ -48,23 +47,23 @@ static void usb_msd_storage_realize(USBDevice 
>> *dev, Error **errp)
>>        *
>>        * The hack is probably a bad idea.
>>        */
>> -    blk_ref(blk);
>> -    blk_detach_dev(blk, DEVICE(s));
>> -    s->conf.blk = NULL;
>> +    if (blk) {
>> +        blk_ref(blk);
>> +        blk_detach_dev(blk, DEVICE(s));
>> +        s->conf.blk = NULL;
>> +
>> +        scsi_dev = scsi_bus_legacy_add_drive(&s->bus, blk, 0, !!s- 
>> >removable,
>> +                                             &s->conf, dev->serial, 
>> errp);
>> +        blk_unref(blk);
>> +        if (!scsi_dev) {
>> +            return;
>> +        }
>> +        s->scsi_dev = scsi_dev;
>> +    }
>> -    usb_desc_create_serial(dev);
>>       usb_desc_init(dev);
>>       dev->flags |= (1 << USB_DEV_FLAG_IS_SCSI_STORAGE);
>> -    scsi_bus_init(&s->bus, sizeof(s->bus), DEVICE(dev),
>> -                 &usb_msd_scsi_info_storage);
>> -    scsi_dev = scsi_bus_legacy_add_drive(&s->bus, blk, 0, !!s- 
>> >removable,
>> -                                         &s->conf, dev->serial, errp);
>> -    blk_unref(blk);
>> -    if (!scsi_dev) {
>> -        return;
>> -    }
>>       usb_msd_handle_reset(dev);
>> -    s->scsi_dev = scsi_dev;
>>   }
>>   static const Property msd_properties[] = {
>>
>> ---
>> base-commit: b69801dd6b1eb4d107f7c2f643adf0a4e3ec9124
>> change-id: 20250301-usb-5dde4bcb1467
>>
>> Best regards,
> 


