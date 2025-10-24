Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29261CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 21:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCOtb-0007kX-67; Fri, 24 Oct 2025 17:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCOtY-0007kH-9V
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 17:00:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCOtW-0005g9-Ff
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 17:00:20 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-470ffbf2150so22519225e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 14:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761339616; x=1761944416; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XcIxaQ67a8jVVOfKmnTa9SFKmogMi3dQET10JvoF3/M=;
 b=EUgdgC1JhQPN4MuiS8vlrk6dQFtAsXhUUPqda+3cdIjk17t12R5f2Br8i8ZXnqqei+
 gMqfveGwFOH8xRvtOG089QCGQ/Uay37/5g10mgVTKBCmoH1bQKHmZr2OCGoo8/H5lfr2
 fkLIsF3xUygb08hg02Q8nz+MKiL4CyXjQi8JKQQYR/mUVDMpUkdIbsgZHKERTT4t8x8H
 mVLE9UlC14UmpM2QkYnv8bukeV4q5YtRH0ZFgWi34kUBuX0OjREC8gSEEcMnseu8K+PB
 tkY1CNl/xjPMGOikRRQcCgTQGf8AeSctYJ0kJ0mpUeXrqeU/YoLTerLNrfyJIoPoHl2Y
 a1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761339616; x=1761944416;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XcIxaQ67a8jVVOfKmnTa9SFKmogMi3dQET10JvoF3/M=;
 b=OlLU4FqiQBVAp0SWnHaFIkomau3Wa88aEUu/J0Te5sjtU12J2COPVlVKYD3dOfPTNR
 Q7knKhgYczdcp+BI3KdEqUJSMhwIgCyy1pScm1cYk1xVgHa8zp2u8lrMSg3b2K/DiW59
 +c1BMdLQ30DMIjxxnUKT1MLFdfTDjHAU8M8dQfHarGsyuuXbyuIRynIRgrEefBRpb3R1
 vPOAlnspTK7fZZJWyHF/NWcJh4t+O1Xu5i1IU8Qc6OvZV8pXQExcU7l+xSu9tkvZlFEs
 kYF1CfuaUWuet3NdROdSUM3dj52HlMvVAFlI9Tb98DO4X7kpdYizrwlCQcyEK79rcjWO
 TsNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkUCUCQpqLOxCSAYoMQHf5JRSc9A0firKGn0H/dP2zKu41Hrp3ImIC9y4W1iznhh6G85/16+/0z+4W@nongnu.org
X-Gm-Message-State: AOJu0YxJXYppvAIq0BXeQZMp5/gHxu0jWuId/VqbrUIPYiFOOZUKBUVT
 VyHlvmHzDMgACti5npJANinGxVM2fKBm61CL3y69+zzZ3oBf1gENSTXn579Mpp+f88k=
X-Gm-Gg: ASbGncuH+foOvcrBEhuCjFgw4I+V+U3jdQkhKzBstPT9YZFs+GIKMsy2NHO+0hoPqyh
 fuATuB29TIwC7NQfHmNrD2FudafsQ6ImYrKmyZHF71+wQ3MzGadU/oOFWe+m8eeWXWyurvfaH4O
 DSFK6Bmd/aM7qaYAIPvOGr7NzGdz4Z3MCnt6CTTA+I2uGhHaKnBbBgTIid9h+jS7hg952V24v1z
 3mn12Kw7lrLARPJjLf3WO8oO8IzACN3xc+X4DJAU90N8vEo6xYesjHJUZNtlbm0uAxXmMtQnXWY
 n/poqstIqAtoXHc84exoi3B5iO5k0MTwceZSMG1EHeAswASNAHhWXNUrfvtOo+L1t63WDRJnlsm
 WjTttTjuf4l4CVTVrDRpLgbFtSgeOEbrH30adDbNlVhVqT670LqHIOzZlTlt76TUzzIjIOilCe5
 ZX90ZiUtCU+SzdTM/KvYRd4wFJsWnQjsXFMBHdMtEsbjiSnw3ySsCdeQ==
X-Google-Smtp-Source: AGHT+IH3C5fpFaNOpwEIrGKdP2Ewlswyv/5J1kKxz9xjLgB9bCb5iiYTPpa8ND6AlvQNTLgxF4fyFQ==
X-Received: by 2002:a05:600c:3495:b0:46d:1a9b:6d35 with SMTP id
 5b1f17b1804b1-475d242c75cmr35087015e9.14.1761339616380; 
 Fri, 24 Oct 2025 14:00:16 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd374e41sm1195045e9.12.2025.10.24.14.00.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 14:00:15 -0700 (PDT)
Message-ID: <7f0180ec-c08e-48dd-8b46-fc70ffbbe49f@linaro.org>
Date: Fri, 24 Oct 2025 23:00:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/27] hw/sysbus: Use memory_region_name()
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20251024190416.8803-1-philmd@linaro.org>
 <20251024190416.8803-4-philmd@linaro.org>
 <1201fe45-f822-4e1e-8cd7-84b23eaa2bd0@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1201fe45-f822-4e1e-8cd7-84b23eaa2bd0@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/10/25 21:40, Mark Cave-Ayland wrote:
> On 24/10/2025 20:03, Philippe Mathieu-Daudé wrote:
> 
>> MemoryRegion::name is kind of internal. Use the proper
>> memory_region_name() accessor, which might return a different
>> name.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/core/sysbus.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
>> index ae447c1196a..d33be6b2b52 100644
>> --- a/hw/core/sysbus.c
>> +++ b/hw/core/sysbus.c
>> @@ -154,7 +154,7 @@ void sysbus_mmio_map(SysBusDevice *dev, int n, 
>> hwaddr addr)
>>   int sysbus_mmio_map_name(SysBusDevice *dev, const char *name, hwaddr 
>> addr)
>>   {
>>       for (int i = 0; i < dev->num_mmio; i++) {
>> -        if (!strcmp(dev->mmio[i].memory->name, name)) {
>> +        if (!strcmp(memory_region_name(dev->mmio[i].memory), name)) {
>>               sysbus_mmio_map(dev, i, addr);
>>               return i;
>>           }
> 
> Interesting. I'm mildly curious as to if you discovered anything that 
> broke with this change (even though I agree it is correct)?

I'm working on having qdev to absorb sysbus features (MMIO, PIO
and IRQ links); what is left is the qom parenting on the main
sysbus, only used during legacy reset; I hope to convert the
remaining as a cripple reset tree.

