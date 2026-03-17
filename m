Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13C1FED9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2W9J-0002QV-3c; Tue, 17 Mar 2026 11:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2W95-0002NL-L6
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 11:15:48 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2W91-0004VO-Vb
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 11:15:46 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-486507134e4so9623735e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773760542; x=1774365342; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZK0ZuIqS+0vu2uyeySmF9TrLmKycGq69W76uKDHS5/s=;
 b=qzXuItFpcHWrq9Dfe2zDpCCcN7OH7yzPQ0OBq8BnAF5YD809MmI6/CBkafP8G8tYLr
 2k8xX+E3zKVYJV+WXUwdTFwIWF7DC8KJYjUPce0GSIvxzf+QjP7r0fR7DIJb/LvsFlx0
 18AEcABBoUIQoesXUN3zeO1Sz7YldkvqdYdPlToW97C2BQdhpqVGrdvHWxihUWVb3hFc
 BQmb9MrNmNtVYf3EeRcxW5UcEiF2a98MYGas3VK9yJoNRWmQvSUwlfUyw1hpRndsZDNF
 HnHJEEp1UK2VpC38SDkLVGwbm5tuYpf+R1DM5qvstk1nDs97HQQ/Aie2JXkfVpUxjv7f
 9oxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773760542; x=1774365342;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZK0ZuIqS+0vu2uyeySmF9TrLmKycGq69W76uKDHS5/s=;
 b=Xi5U0+Zv/sJXTxjlopbUj6q2rN0kGZU67mZK56dsvSYCkxEoq9pDMZJC2dZmy3M3Oq
 Wm+nv+c/YzyeeH439qPEgadJh8PX/OQSL35oxiFlDmaahDwdvbhvwmoDVQdIsV6Sc69q
 ktSTEW0A/m8bdC5Bb/HmAW+W9dUgtZEH81tj3/8rnqfUin/NF+awsvS37WkCd0awTYr+
 6bmhY9d8iyLsq8LmbzzcxlJNjO17a/zP11StEkJf4rvZjMo3HDCRqcri2o0nZz8xKvn/
 dPODfHUNJvhUxPdVOam5mC8x2FZmElaDlEL0Sa2w61+5vF3VEVoNBlphlzOTBrBEKK8k
 EI0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAPkwFNE9qIgqUOOX3Ij6G5jZayx1gyIb24NzAeFjhYQVkX9K7QtsRJas7X+8CAk/IB5oov7Flsu5F@nongnu.org
X-Gm-Message-State: AOJu0Yy6Mrwn+WYhRbE+wnIP5g9xKbDndhrstxvLqHVNvnoFA2RxKEBj
 bHKy32xwwN15Wf5eSsgTjFgVQUjYOOgZ2kvVKvdu696B805tQw8D0Yg+ke4H/sPrsYQ=
X-Gm-Gg: ATEYQzxqM6PdXWSQeSl1D5SEE3/HgeYhFwpgWokSjcUh/DIrc68CCWMmqWr3fMFUoXw
 VxQfVlwZeZsTAwPsDrZFWleObUxdAtlYUrU5JQqlifEKqYKqo2zft504rdpRw8358ZOr38YPIed
 NTw3rvG+2WxU0djX4uMKSRQ13BR4DHWyeixPzVQ8qWo2jSrZkukOHkyjrDU6cfTzVTmeU7lbqWd
 t4NqC2gSmHmwsuqn/gr6u3NUfmj/+sRYHhgiMZsI9HAjaTiT20lCI6t+Uog0Yf8WvV3Y3Vpn2jh
 8WUVBWzQktMBnWL8CyYQ/+5h/v/8QmDEWcxH3bKVB7HtFAuHABuGNJqaaIyJH7bGInZi26H8E13
 Pb2w4QYl9ShRNHMqI7In7aTYi8ih8lPq1Ka8EQnctlcCFTSCak/fFaOqZiLmK0NKx8Lu2np2/xI
 WHapPfNZpTa40irsD/ACMD9ucZ+pCCbPjt++BTz7Hk0HyHbT0T6AtjjUBJTXzMiXdQww==
X-Received: by 2002:a05:600c:a009:b0:485:3b00:f92e with SMTP id
 5b1f17b1804b1-485566c6a8cmr302309595e9.2.1773760542020; 
 Tue, 17 Mar 2026 08:15:42 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ea96828sm124356425e9.5.2026.03.17.08.15.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 08:15:41 -0700 (PDT)
Message-ID: <f183d32a-f1b9-48fd-ba5b-678945a87831@linaro.org>
Date: Tue, 17 Mar 2026 16:15:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] hw/tpm: Add TPMIfClass::ppi_enabled field
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260317120241.16320-1-philmd@linaro.org>
 <20260317120241.16320-3-philmd@linaro.org>
 <c20e2bf9-6856-49e4-84a7-4e9e1745b503@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c20e2bf9-6856-49e4-84a7-4e9e1745b503@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 17/3/26 14:17, Stefan Berger wrote:
> 
> 
> On 3/17/26 8:02 AM, Philippe Mathieu-Daudé wrote:
>> Each TMP derived device has a @ppi_enabled field, itself
> 
> TPM?

Finger crossed =)

> 
>> exposed as a QOM property. External layers (like the ACPI
>> subsystem) wanting to know whether a device implements PPI
>> has to check for the QOM property available. This can be
>> simplified by declaring a single field in the TPM interface.
>>
>> Here we add such field to TPMIfClass, before converting each
>> TPM devices to use it in the following commits.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/system/tpm.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/include/system/tpm.h b/include/system/tpm.h
>> index b90dd4e8cb0..9458ad6668a 100644
>> --- a/include/system/tpm.h
>> +++ b/include/system/tpm.h
>> @@ -43,6 +43,7 @@ struct TPMIfClass {
>>       enum TpmModel model;
>>       void (*request_completed)(TPMIf *obj, int ret);
>>       enum TPMVersion (*get_version)(TPMIf *obj);
>> +    bool ppi_enabled;
>>   };
>>
>>   #define TYPE_TPM_TIS_ISA            "tpm-tis"
>> @@ -84,6 +85,9 @@ static inline bool tpm_ppi_enabled(TPMIf *ti)
>>       if (!ti) {
>>           return false;
>>       }
>> +    if (TPM_IF_GET_CLASS(ti)->ppi_enabled) {
>> +        return true;
>> +    }
>>       return object_property_get_bool(OBJECT(ti), "ppi", &error_abort);
>>   }
>>
> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> 

Thanks!

