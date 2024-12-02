Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9F9D78333
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 16:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI9eK-0002AJ-Mw; Mon, 02 Dec 2024 11:51:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tI9eH-00029k-HW
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 11:51:49 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tI9eF-0006kR-HQ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 11:51:49 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-21539e1d09cso40303545ad.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 08:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733158306; x=1733763106; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i7tPo/7eScvhJZ+7Lg8F9pQOGhhIIbqqSlTSWArCK3g=;
 b=DyvTRQerICNaDrl4R22qgEBnD+tUGnW/77O3ti50ct7Visd4epvFvJ79E55jJiY8PR
 TxF5TBmVEB3DhyTQAZIWCReqLJBnJShmyvO76f0C7MZkC+V6QgzjGo46zpUeaonWMA1i
 W5FPITru3XAlCGKDiPV2FZWRJecdcki4YEniUUHGVI7c/7F9ox4qlx8HJplULcjf5KWM
 0sC1HNeM13s1YjXFr0QzsjIuIGtwpdvNq43HoWWl2AiJimSrwVuDOpWyyHm/+4o1+Gz3
 C7cFv2I8hKu/549WtzRIdcfMpvDgImK+Q0cOq/KBmnyACrmIIzJqFgnYufY1YGP5L70l
 TgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733158306; x=1733763106;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i7tPo/7eScvhJZ+7Lg8F9pQOGhhIIbqqSlTSWArCK3g=;
 b=JQbmg3IDGPgaGtZFL+vi5dX/jcgZi/ox0ZCc5tf0ucoGoBOlaejrlbIYz6HVyDZ/Ve
 Sy5ojt27Bb0kDvgSMYLCOd4+OIq6Cmt9MGG+WCM8WdmF7WJBYj/dVle6uie2C0tyV+9F
 E5XlV8Ay+ZfPU8N+DJT6g7z1uIW/U86M6QRkFQxR9vece3JMTdAUAzBFQhVqkg1M1z9V
 zwvNx/pfYyDGvjoTByRRwFa2fyeKC9SttEt67M8+4n7+aytpJooxcfuMTjayStF/XsVH
 6XDPSBAuU+Q9/9aytSara49ZaM2UJV59KLAGcKFytNOXlIigr9wxMcyOqHyJyfrLWKro
 0quA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpr29q7s1RqjBWwoxP55sciusY+T+xTOnp0F8P+Y+85PSHkoEJ0Q8ZL9gzil3caWI1eeX9yid+MLBC@nongnu.org
X-Gm-Message-State: AOJu0YwYBCzJEi40otSYop+aqZDodp/eZbxm8rq7tTCK9LdckEa0KAe8
 p1JcTYUWcCFxLSbKW8P7W/gLuQSzjZO6PWtvP5Mt1X9QtdlvF9k=
X-Gm-Gg: ASbGncuYIOmJ+BSrKnaZw+twuUtuw8VU3L4qPYvLv7NiEZh1MbQOgVjkBNR8hvCWjNS
 U3l8ybdj/pJ8kTbOKwBEmUd8FMPUmOEDOWM5XzsHVN4s70hsAOPQb0kOGgkSQJ/PbQb+77OXLDi
 Q3px+YnPuV0PxLRQjdjPF3tCxSl6hEDOLWMNeVVc2Od1JuaSxj7WskNnrggLmXqTNY1LwyY2gqd
 Pm2YcL2jkEiVzwz7PhIVlDhJgdHIcqV0ZURRSY4FK74NB/NoW6isQc=
X-Google-Smtp-Source: AGHT+IGF6TSml8lfxnc8Iqa64LaLXipSQ6TEqoY3sujyjRrCIgedxpMJNCsHTb7WyYCHTR7+91HK4g==
X-Received: by 2002:a17:902:c40f:b0:215:435d:b424 with SMTP id
 d9443c01a7336-215435db4c1mr206025775ad.47.1733158305856; 
 Mon, 02 Dec 2024 08:51:45 -0800 (PST)
Received: from [192.168.0.163] ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21521905f4dsm79173955ad.78.2024.12.02.08.51.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 08:51:45 -0800 (PST)
Message-ID: <d8c36da7-2126-4b18-aaf8-12e7c87e10fd@gmail.com>
Date: Tue, 3 Dec 2024 00:51:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] vfio/igd: fix GTT stolen memory size calculation for
 gen 7
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <C.Koehne@beckhoff.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "clg@redhat.com" <clg@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
 <20241201160938.44355-2-tomitamoeko@gmail.com>
 <91d12b8330698cd65ad2f24406efd34e8d5cd4a2.camel@beckhoff.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <91d12b8330698cd65ad2f24406efd34e8d5cd4a2.camel@beckhoff.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x644.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 12/2/24 16:54, Corvin Köhne wrote:
> On Mon, 2024-12-02 at 00:09 +0800, Tomita Moeko wrote:
>> ﻿CAUTION: External Email!!
>> Both intel documentation [1][2] and i915 driver shows GGMS represents
>> GTT stolen memory size in multiple of 1MB, not 2MB starting from gen
>> 8.
>>
>> [1]
>> https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/3rd-gen-core-desktop-vol-2-datasheet.pdf
>> [2]
>> https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4th-gen-core-family-desktop-vol-2-datasheet.pdf
>>
>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>> ---
>>  hw/vfio/igd.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>> index 4047f4f071..e40e601026 100644
>> --- a/hw/vfio/igd.c
>> +++ b/hw/vfio/igd.c
>> @@ -268,7 +268,7 @@ static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
>>  
>>      gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
>>      ggms = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
>> -    if (gen > 6) {
>> +    if (gen > 7) {
> 
> This seems odd. The commit message talks about gen 8 but it changes the
> behaviour for gen 7 only. Additionally, ggms_mb is still shifted for gen
> 8 and later, so it's still increment by steps of 2 MB. Shouldn't this be
> something like gen < 8?

Yes it should be. I think putting the change here is not correct,
as alex said. I am going to remove this change in v2.

>>          ggms = 1 << ggms;
>>      }
>>  
>> @@ -678,7 +678,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice
>> *vdev, int nr)
>>  
>>      /* Determine the size of stolen memory needed for GTT */
>>      ggms_mb = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
>> -    if (gen > 6) {
>> +    if (gen > 7) {
>>          ggms_mb = 1 << ggms_mb;
>>      }
>>  
> 
> Btw. you could consider adding a link to the source code of i915 too.
> 
> 


