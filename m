Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC0CC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 10:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBseO-00033Y-98; Mon, 05 May 2025 06:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBseM-00032p-3p
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:02:14 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBseJ-0006Mx-S5
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:02:13 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39ee5a5bb66so2653324f8f.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 03:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746439328; x=1747044128; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DW0PY8etzh0qAvKOB61gLxlQilu6UikD+nFL9mm4qRY=;
 b=KMfuOWRmLSNFV22F503y759m8re31G5DDFMYnvFyLsTpBxj6L9vIFuky8pYHvI8eBW
 ZSGxdyFT0V0Rd0+SYqu4qXof8XhEU/S17nbgGhEDMUiQs9RnNG+RcFVrE3xwM1c0BlXG
 l4NQgrA1JJqrvPyJMe9G655X/W4NO0l9jtGIz0Hfcl9DFDsOSGEBAIH1wTZFKpPTVcR4
 jbukoGSFEAZovkLu3/FOHhkVviHfO3bMFzlUfLwVZe98dEfOnITLEQPuFlSxcX0EUThe
 8vvnwO1w+PKMhNhymI6o54EBiAy1f3x/CXJ1+2Qyta3oz/942zduJTb7SMYuZexnV+Vt
 amKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746439328; x=1747044128;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DW0PY8etzh0qAvKOB61gLxlQilu6UikD+nFL9mm4qRY=;
 b=k+GEoxDBIbSNhN94lWy3stCYFLqKW4+SBS4xD5scwiIwDorZ4uVrn9MXa9vWZ7jS3L
 eAv1IdcyAnzV2eqJGLxFzXiZVwdFDs/LvR6/Fo5KtjbiZYLPCth41o2Z1ZkW5WvaHEKZ
 GUOv/ioXS9ZhzL28CLM5Fk71KvxDVXBpsOtk2T75gzTjzuYXMABOxTPvkz3j3EVbtE28
 b8qQnxB9BELZW+iz+O1CdQPr5rH3LRNVCjjO3vyq+Zfnvy4ZpREo9VfXoAIjGi4BZBZE
 siIl0fBKBz946MSp3XYGjMLQd6X8Jl1KaCt/+HXEH1O5ig3VKI8hf9GGvWQrzDnNWAjY
 Z99g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJpuHa9qkUovY2vhN9Vi4lTAXmEGFDMlNo8Yj1fojZn1Nh4eBsokkSKDB80dc6madNR6BRR2bA1jFZ@nongnu.org
X-Gm-Message-State: AOJu0YwyrF6WRhfPSI8DERIf16zvl2UFs7vRriD4ZBkAC+HtF+rSiluW
 ZmzUmNdDteiAQBMpI4R3M3yw4Lest17SGGt6aH8XqJfDQDl/7IlktfPJOuupxxs=
X-Gm-Gg: ASbGncuxOWUPgVfoI67q6uTEmSy0RAqNKKXw/S9XZs7Uxc3FpE6LlDb62t16eblzrPM
 m43Uu+PrZg7BepFgYZC+vZ5Dszwgv1hfzBX/wzOvOWAesMZgV+6yL6d3Dpw6BaM0C+8BR1KfLne
 WUH9CRWD+q71mVJojWAXd2EvhIdhIO5KoCkNMsLXBt42izWHw5yIlEoWlLiwmAIrCleAwPCKdo8
 0fdiIOfFfB2QzEkOUoP7NCoa3/RgWgdCY1bXDPi7wmO4c3Un78k62hUIZE4GSomp7yVF+RupLYM
 3veebJ6P5NaZ5qvG7qczTYunADxCzImOj3toeB90jg7H1fEA8I8FXToLO/J8uiXmsrEMzyMa7f1
 XJyJMDfy+v4TyndYoi35x+/wSBhqx
X-Google-Smtp-Source: AGHT+IGXaFRpriWEaHA2ufbZURpkju/sstJ9Hz95fTZLvTlyU8TS8YNptdjYdPZxRJTYWf5o7IH0FA==
X-Received: by 2002:a05:6000:1867:b0:39c:142c:e889 with SMTP id
 ffacd0b85a97d-3a09ceba154mr6319387f8f.27.1746439328304; 
 Mon, 05 May 2025 03:02:08 -0700 (PDT)
Received: from [10.194.152.213] (29.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.29]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0c48sm9907648f8f.8.2025.05.05.03.01.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 03:02:07 -0700 (PDT)
Message-ID: <64fb62ba-3204-4b75-8538-8c4707261ade@linaro.org>
Date: Mon, 5 May 2025 12:01:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/16] hw/i386/pc: Remove pc_compat_2_6[] array
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
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
 Ani Sinha <anisinha@redhat.com>
References: <20250501183628.87479-1-philmd@linaro.org>
 <20250501183628.87479-5-philmd@linaro.org>
 <11bba95b-1e23-45bd-b2f0-31a6cb9c1c54@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <11bba95b-1e23-45bd-b2f0-31a6cb9c1c54@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 5/5/25 11:19, Thomas Huth wrote:
> On 01/05/2025 20.36, Philippe Mathieu-Daudé wrote:
>> The pc_compat_2_6[] array was only used by the pc-q35-2.6
>> and pc-i440fx-2.6 machines, which got removed. Remove it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/i386/pc.h | 3 ---
>>   hw/i386/pc.c         | 8 --------
>>   2 files changed, 11 deletions(-)
>>
>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>> index a3de3e9560d..4fb2033bc54 100644
>> --- a/include/hw/i386/pc.h
>> +++ b/include/hw/i386/pc.h
>> @@ -292,9 +292,6 @@ extern const size_t pc_compat_2_8_len;
>>   extern GlobalProperty pc_compat_2_7[];
>>   extern const size_t pc_compat_2_7_len;
>> -extern GlobalProperty pc_compat_2_6[];
>> -extern const size_t pc_compat_2_6_len;
>> -
>>   #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
>>       static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
>>                                                    const void *data) \
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 49632b69d29..7573b880905 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -251,14 +251,6 @@ GlobalProperty pc_compat_2_7[] = {
>>   };
>>   const size_t pc_compat_2_7_len = G_N_ELEMENTS(pc_compat_2_7);
>> -GlobalProperty pc_compat_2_6[] = {
>> -    { TYPE_X86_CPU, "cpuid-0xb", "off" },
>> -    { "vmxnet3", "romfile", "" },
>> -    { TYPE_X86_CPU, "fill-mtrr-mask", "off" },
>> -    { "apic-common", "legacy-instance-id", "on", }
>> -};
> 
> So you took care of apic-common in the next patch, but what about fill- 
> mtrr-mask and cpuid-0xb ? I think these could be cleaned up, too?

I'm not sure about CPU features, I'll defer the corresponding cleanups
to someone more familiar with the architecture and its real world uses.


