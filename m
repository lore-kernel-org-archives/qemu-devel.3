Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A2DC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD0to-0007eb-V0; Thu, 08 May 2025 09:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD0tn-0007cV-OQ
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:02:51 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD0tm-0007g2-00
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:02:51 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2d54b936ad9so488311fac.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746709368; x=1747314168; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qA1vncVNbExTdrFsEz+MOpDLGhtoDokunG6HR7YcMKQ=;
 b=XYGmfxqtcXB8aqbd502TYMFxXiHKbe+xFYSeOAPVr372wEDw3ld6s1DhtMqzlmsZxv
 N08sxIELx3xr4wS/qglB02bBg4MXqDIAdRfoHGL8un4SY/4a+aN5RfCU8aeFdaltCPFR
 lVSdGoKtb3QffZMJmE+FSivUJu7DzTCGq7WzqI34zCm7TR/NYQg3yyBvXqupnImiswcr
 f78pSrtvIFh7VEFV2IUKjZKE7uOpyKdS3UZejU5XxEECfrEtN4LOxiOvqTjvWAAvSu12
 r1El5nJKuk2gqeN09p3nx91bfWspXB61jKH2/yNBZp5Yg2mSRmDUNkF4Br5QWDUbK1Vu
 gfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746709368; x=1747314168;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qA1vncVNbExTdrFsEz+MOpDLGhtoDokunG6HR7YcMKQ=;
 b=eiTN5CM1a6ZawAj6baOK3oVJp8Ucu/QTMGJGFZpCZi+OH9jNvYQZpeQh1UUVZ4hTpn
 3jdH74/uK7ilC13k9n5thw7C+jIuZlMgVxJjeKRVXJLKQ0NY0Og6TTAAn7IXA8JOjyI7
 r/FnQ1q0oTH+lWXb0AS7Mr67E8Wt0Yv488N4eCMVXpGw+5Yt1acrBzZQrVe9sTVXync+
 Z36s7eMAGk2WPOHsaq4UWINMO8MKul6ClvEAFbjlojXlQ6BDqhkBotWrd+/e6K2i5rQX
 yR6B7zNGqdNWlWVbRm0eoYX4MGImWuwSX9MvereL0qJ6/W53w/zMwMDzjNg/NfITq2F0
 /t2g==
X-Gm-Message-State: AOJu0YytZBrIlFlqtA3/JOcIDFNMJFXWHBqrE1U8E4snBmxxMUlhrukE
 B5G7rK2UcwbdFiFEU5Tk0JodysL0P2z4f1+FLHAzt3YF2ON6qyFO0ACozbjqFZCPQel4IlzWJ3c
 lujKPyw==
X-Gm-Gg: ASbGncur5RMcdYCcfeEYWD9U+Uprhxk1uacN2tYysFRcc2KPb8VnXzbH/UElsvrg+7p
 r6uIryGIIZXbJspHOdk8kZYVT+NygFoQ1Tb/HtRGt+dw9Djo6Nh8iondmkaTP3PJtDwLW6CqhTp
 o17Z1TMS09wznJVnAX/fq/1GXBRMaxKBr15vgF9T7RXQ4ozhwVCYaVqPoJKJtkypOm1mDwG3AqE
 ca5Pw9tBeuADWfoHmYwqUaluRn6exrKa2SfMug6TLHyuZqR/Upg/LnA89+KNplCOEXxRsWthjng
 UP9cgpVdyTQxU18xqZnWvQG9RSMfJXstbK/EbWla0u/PTSsb5AM2+Rp4E1ucyMSO6DTa3rTewvn
 j2ieiSkxp
X-Google-Smtp-Source: AGHT+IFGi9KKWLTJSGelkBNr+B0RQn4nXILJ941fddjvdQfwnySHriAeM0GFeky9bGuV6MF5oAAWzg==
X-Received: by 2002:a05:6a21:1645:b0:1f5:9cb2:28a2 with SMTP id
 adf61e73a8af0-2148c221f55mr10380136637.19.1746709354134; 
 Thu, 08 May 2025 06:02:34 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3b62502sm11251540a12.32.2025.05.08.06.02.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 06:02:33 -0700 (PDT)
Message-ID: <55b19265-b5e0-44a0-b5fd-ac6741f6667a@linaro.org>
Date: Thu, 8 May 2025 15:02:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/19] hw/i386/pc: Remove
 PCMachineClass::legacy_cpu_hotplug field
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Amit Shah <amit@kernel.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
References: <20250502185652.67370-1-philmd@linaro.org>
 <20250502185652.67370-3-philmd@linaro.org> <aBr8Zknwle47ljOB@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aBr8Zknwle47ljOB@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=philmd@linaro.org; helo=mail-oa1-x2a.google.com
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

On 7/5/25 08:23, Zhao Liu wrote:
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 3fffa4a3328..625889783ec 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -1465,9 +1465,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>       }
>>       aml_append(dsdt, scope);
>>   
>> -    if (pcmc->legacy_cpu_hotplug) {
>> -        build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
>> -    } else {
>> +    {
> 
> Why leave the {} here? for clarity?

Exactly, the diff-stat contains already more than 200 lines, too much to
my taste. If we de-indent this block, per our coding style we also need
to declare 'CPUHotplugFeatures opts' earlier. If you really want the
braces removed, I'd to it in a follow-up cleanup patch.

> 
>>           CPUHotplugFeatures opts = {
>>               .acpi_1_compatible = true, .has_legacy_cphp = true,
>>               .smi_path = pm->smi_on_cpuhp ? "\\_SB.PCI0.SMI0.SMIC" : NULL,
> 
> Otherwise,
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Thanks!

