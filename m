Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AACFCF45A8
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 16:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfKwG-0003jR-3M; Mon, 12 Jan 2026 11:38:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfKvo-0003ft-A2
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 11:38:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfKvl-0002Go-8e
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 11:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768235889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UCdicQ4IiQLJbeqNLr0zJJkHs4wRmA7lDvSe7G5gVaM=;
 b=SSN/U9P2BEakCiRbtMhTA3IE8tQJY+K9rh0meYcJRTrdnoNIs+RjyM0HrcXuu3qFrFsWqv
 P1MGotwDLysJpHChH/VanUH/ZlbG3MLLSt7tNdCVNECFXUzpHNfYD4EdzR344T30c70i/9
 /zPZ5u9HxCMrFTuoSEE+GzY/KeAc5Ec=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-ws5LBynfPxiAlycstyoQeg-1; Mon, 12 Jan 2026 11:38:08 -0500
X-MC-Unique: ws5LBynfPxiAlycstyoQeg-1
X-Mimecast-MFC-AGG-ID: ws5LBynfPxiAlycstyoQeg_1768235887
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4779b3749a8so55031205e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 08:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768235887; x=1768840687; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=UCdicQ4IiQLJbeqNLr0zJJkHs4wRmA7lDvSe7G5gVaM=;
 b=rShVi7WYh4qNYLIq++Wu6e7EdT+IW8AauMFRFj081e7HHv4peguwBMuv3zcsky2Jgz
 yBtOnLZMYDBQjPRwnOUaPlbVvsktnSby7B8GAD2NSwz/VHtlPozJML1Em0QGTpIWZdv8
 YaE2fpEynrCZAn3V+CCOYhGSaPj2W5SGEc41el4OTIp2qQH1p13AEzTfXi5eC/D2ORZC
 bTROOmnoKbab2jSmnfsqECNZIPX+AqvwG7kSked7hOGfsUMdha8u61Dd3oBCKIVHZP98
 nZ6Ff7V6NGOINXZXkp+LM83CMq27hiCS5L9/siFkw2AMI28151JksY78IGhlD5RgIBL3
 xrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768235887; x=1768840687;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UCdicQ4IiQLJbeqNLr0zJJkHs4wRmA7lDvSe7G5gVaM=;
 b=CqX8ikBVaODil2/rlnWwboC/XG4iCJh1nuSmS744SLbTdBZIXn1iXsvDFTY7pTG6nO
 elIAViqTK8gQ+5aJ4kKvOYC7De9+mRZKTAnn3coYA+CMhWrkChhb2FRJWWaiDPQO27Vp
 cm7GjaKHnsuBSh8lhtCIxV5tqUbaoJbeY+ZECLwxiGFoj+lK04jwNdE7g9b2S1IQytBe
 EBcp+gAnGgRrUSkZBugspAr8EeJgR/IgCXME9ztbowxk7T2Q16lUGkPiX5lmg67AAVW4
 1H3rh96j2zohAa3QVS1uThnrTZa897tyM6/pM9HLI2DM4HqZwc2QTAt4DEqtzl/oXuSe
 ZpbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS/JoDmnfdUJVbfuKvoC7G/p4lcS1OVC3WDCBLfBZAVopviUuYUz3JNvMhA1SsJdyq5QRhZ6aaiT9p@nongnu.org
X-Gm-Message-State: AOJu0YyKvAvYnC/qZUCt9dLJwrPNjhLWdCvwrhprWiE+6N7aN+8EYwKo
 u4EQy1+9iR25V0xmIBc+U0fYjdwUHsfDivuoks4Z8kygPpevz4cTfq+PBwtxHhZJ7u9gdzxhPaY
 iCs049qZqnaIJtrfoSa69iwh8/WhOcsa1oB9pPXq0847ERTaAZNeX0cge
X-Gm-Gg: AY/fxX7FXaviKcyfUvGd+/UtAEw6hW948CgIRUwl8XmEZQ4bgE2lpgGld8U2WtT+I49
 +6IqvOofE4rsmAHvNw32HBatggRtsi1S+XHdIGcIIPP8HcNq2p25fJKEspXDGEque8IxawC+ygg
 TG03hhCQpqJ3W7Yzfxw5LGVESxYcMDz8RpBqFJ+wI48SLdnobuvrYs8HQd5yNYTUBcElXvHuXXs
 IJ3vvc2+Sk15Mt7eIYIQZHl7stHkPgyRgNh1fepZb+O81iYYwnMFJlRewXzA/gJuckcW+1KFfYb
 R1fVELFm8pjhI24Z7J8Xma7y/7kfcTayd59GpDJgG+fQ9seBdMiNEKckFiv3z9esHiC+USXtwkW
 WdTx9/EW/uSiwSeLCn5LMZrPhh3kf5CX0NtK/VeIkGT17mkRt
X-Received: by 2002:a05:600c:8905:b0:477:9a28:b09a with SMTP id
 5b1f17b1804b1-47d8c7ef6d7mr122577825e9.0.1768235887220; 
 Mon, 12 Jan 2026 08:38:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIhWvSbbz6E817xx/6UMIOPEf7wAXPTSwhB4mSHSbwKQ/7F7WeKrS/L1ymP6ePVjApd+QaGA==
X-Received: by 2002:a05:600c:8905:b0:477:9a28:b09a with SMTP id
 5b1f17b1804b1-47d8c7ef6d7mr122577515e9.0.1768235886823; 
 Mon, 12 Jan 2026 08:38:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dacc5sm39327295f8f.5.2026.01.12.08.38.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 08:38:06 -0800 (PST)
Message-ID: <c44881ae-76f5-469d-a62d-c7de8cac5ed2@redhat.com>
Date: Mon, 12 Jan 2026 17:38:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] update-linux-headers: Remove "asm-s390/unistd_32.h"
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260112155341.1209988-1-clg@redhat.com>
 <3b167280-ce21-42ce-8b7d-18c60ff39509@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <3b167280-ce21-42ce-8b7d-18c60ff39509@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 1/12/26 17:07, Thomas Huth wrote:
> On 12/01/2026 16.53, Cédric Le Goater wrote:
>> The "asm/unistd_32.h" file was generated for the 31-bit compatibility
>> mode on the s390 architecture and support was removed in v6.19-rc1,
>> commit 4ac286c4a8d9 ("s390/syscalls: Switch to generic system call
>> table generation")
>>
>> unistd_32.h is no longer generated when running make header_install.
>> Remove it.
>>
>> Reported-by: Shameer Kolothum <skolothumtho@nvidia.com>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   scripts/update-linux-headers.sh | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
>> index 844d9cb9f5e430dcb4833e6225b57173f4befb8c..d09d8cf4c6f0f6a109e899f5c8671f64373d9c6a 100755
>> --- a/scripts/update-linux-headers.sh
>> +++ b/scripts/update-linux-headers.sh
>> @@ -154,7 +154,6 @@ EOF
>>       mkdir -p "$output/include/standard-headers/asm-$arch"
>>       if [ $arch = s390 ]; then
>>           cp_portable "$hdrdir/include/asm/virtio-ccw.h" "$output/include/standard-headers/asm-s390/"
>> -        cp "$hdrdir/include/asm/unistd_32.h" "$output/linux-headers/asm-s390/"
>>           cp "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-s390/"
>>       fi
> 
> I think it would make sense to remove linux-headers/asm-s390/unistd_32.h in this patch, too, otherwise this will stay around as a stale file, I guess?

AFAICT, it will be removed at the first update of linux-headers. See :

   https://lore.kernel.org/qemu-devel/20251222135357.143339-2-skolothumtho@nvidia.com/

> Anyway,
> Reviewed-by: Thomas Huth <thuth@redhat.com>
Thanks,

C.


