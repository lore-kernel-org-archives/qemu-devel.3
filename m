Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D071D68B26
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 14:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBalt-0003Ag-PS; Thu, 14 Nov 2024 09:24:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tBall-00039O-SR
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 09:24:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tBalj-0001pT-BB
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 09:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731594262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bmHpPj0PFvBmwTEYf629JEXX6Kt4FKOtY/9rNxP2cHo=;
 b=gchoQu5o0bK5QnjZcdRDiAZebWlVsZNSfkLFY+orJYQ5DrIYrE+tNX3vLx5MDwS7DdMZBq
 PEs3hyRKIowi4vA9p2qoCVeBtiJRNS4BdB3n+T1OttviH5IhNnL/1WNaFiDu0cAAqN36M4
 ApqFZfrJXA6eVCrPCwP2xGOsFJqh2kk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-7pZNZiSHPCmymHzM-vd_fg-1; Thu, 14 Nov 2024 09:24:20 -0500
X-MC-Unique: 7pZNZiSHPCmymHzM-vd_fg-1
X-Mimecast-MFC-AGG-ID: 7pZNZiSHPCmymHzM-vd_fg
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d3f7d22b30so2621206d6.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 06:24:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731594260; x=1732199060;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bmHpPj0PFvBmwTEYf629JEXX6Kt4FKOtY/9rNxP2cHo=;
 b=CYrbHzEBIpIgbN/ofVPxAihArsKaP6nQGHQ8Hm+KM/StrqGpGWiOjrdHjn5QP8qigc
 k/pnzZd1omGcblmnmz4H1qeEr2Rv16eZXDaaXLFxaFPzkTkmXXJgQSYdsb/pYf4cZxlw
 avra97x7pbPh0S1MNyXbQ7Umm/PKo3uURZA5QMSO8d62jVYr09r2LGXjtQc7dh/Z4mux
 wR6tulEUgDK4fFuWQv7VjEpjgNb4bSpj+fO7HUwuHbRhzXujjW1+JHAQuLcErwZQ4JFx
 0ZzgoSXnLTZiGBGNdAeyUJeL/6YsaLBGHycP3Tg8/mDT2M56V7L8PPEfigSE9sA+8MdA
 9L+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS3H6JiipBFomaXt//3dLerHd/3apmyyq9LaniL5UD/HIqk6PN2EHocrlM2uIs+XbkjqZPBLZ90qKs@nongnu.org
X-Gm-Message-State: AOJu0Yy2YVUi5U+1Ldo3bT5K69cMmTo2ZqaKbvVrYmIJjRCRx7ZCu2Ji
 4UcSRQ+kxR8seDGOKyX8MoQMtNa0+hcMMp5eDYCR4dYPKdgdiZN2xFoxo3sWg73Z8xx8n2pPmFq
 n5Tx+neu0JTHaXT7fdZSqvPeoLT7XG/MEKXHuCDNmms7Ul2AAYnEu
X-Received: by 2002:ad4:5cc7:0:b0:6d3:e740:4b67 with SMTP id
 6a1803df08f44-6d3e740500emr52211096d6.36.1731594260149; 
 Thu, 14 Nov 2024 06:24:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMC3NeDvxGjHnxxL6NzYduh8kfm90c4xKkUxEnmZu9HhImuS2vw388RDt5AZOhGUDd7DkjXQ==
X-Received: by 2002:ad4:5cc7:0:b0:6d3:e740:4b67 with SMTP id
 6a1803df08f44-6d3e740500emr52210836d6.36.1731594259820; 
 Thu, 14 Nov 2024 06:24:19 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-115.web.vodafone.de.
 [109.42.49.115]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d3ee9044b5sm5819326d6.112.2024.11.14.06.24.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 06:24:19 -0800 (PST)
Message-ID: <a4fd1c66-49ff-4a49-8eb8-290fbebf30ca@redhat.com>
Date: Thu, 14 Nov 2024 15:24:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/mos6522: Fix bad class definition of the MOS6522
 device
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-ppc@nongnu.org, qemu-stable@nongnu.org
References: <20241114104653.963812-1-thuth@redhat.com>
 <2b8a7ab4-3295-4b9a-b383-5be680e9d5df@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <2b8a7ab4-3295-4b9a-b383-5be680e9d5df@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.69,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 14/11/2024 12.29, Mark Cave-Ayland wrote:
> On 14/11/2024 10:46, Thomas Huth wrote:
> 
>> When compiling QEMU with --enable-cfi, the "q800" m68k machine
>> currently crashes very early, when the q800_machine_init() function
>> tries to wire the interrupts of the "via1" device.
>> This happens because TYPE_MOS6522_Q800_VIA1 is supposed to be a
>> proper SysBus device, but its parent (TYPE_MOS6522) has a mistake
>> in its class definition where it is only derived from DeviceClass,
>> and not from SysBusDeviceClass, so we end up in funny memory access
>> issues here. Using the right class hierarchy for the MOS6522 device
>> fixes the problem.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2675
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   include/hw/misc/mos6522.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/hw/misc/mos6522.h b/include/hw/misc/mos6522.h
>> index fba45668ab..920871a598 100644
>> --- a/include/hw/misc/mos6522.h
>> +++ b/include/hw/misc/mos6522.h
>> @@ -154,7 +154,7 @@ struct MOS6522State {
>>   OBJECT_DECLARE_TYPE(MOS6522State, MOS6522DeviceClass, MOS6522)
>>   struct MOS6522DeviceClass {
>> -    DeviceClass parent_class;
>> +    SysBusDeviceClass parent_class;
>>       ResettablePhases parent_phases;
>>       void (*portB_write)(MOS6522State *dev);
> 
> Ooof. I suspect I started using DeviceClass first before switching to 
> SysBusDeviceClass later to implement reset functionality. Anyhow the patch 
> looks good: thanks Thomas!
> 
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Thanks!

By the way, fun fact why this problem was likely only triggering with CFI 
enabled: SysBusDeviceClass just extends DeviceClass by two function 
pointers, second one is connect_irq_notifier. This one gets called from 
sysbus_connect_irq() (which is called by q800_machine_init()).

But MOS6522DeviceClass is directly derived from DeviceClass, that memory 
space is filled by the ResettablePhases struct instead. So instead of 
calling an irq notifier, the sysbus_connect_irq() likely called the 
ResettableHoldPhase() function instead! It likely did not crash without CFI, 
since the parameters are similar enough, but with CFI, this got successfully 
flagged as an illegal call via function pointer :-)

  Thomas


