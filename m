Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA48C369D1
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 16:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7d3F-0007Xh-2Q; Wed, 23 Apr 2025 12:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7d3B-0007WU-IP
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 12:34:17 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7d39-0003ps-Iq
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 12:34:17 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-3105ef2a071so1232151fa.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 09:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745426053; x=1746030853; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6b0EFos6IZUzXOYTm+UFR8FmN+5ZGIjrB5Hf40bTDrQ=;
 b=eWOwtzSvqD+nl3GOQUitqx9VlMpURq01EDn0lrub7MwqdA5c50IPpPhX3oxxAZIuvy
 zoin5vU7UaQUsHhaTbaEsQ+9Cmn7ST8FUtFHrXVbqzTUPwMnh/YeLZbnviRG7D0V1jV3
 Up0JfgR6ZQ2oMFjVrSg22TxuYRbTlkOuForaBu6JHFqLhJ9iKL6EVhVk/s9K9G4BdlWR
 IuUJUkouSNQZ8lg7HV5pZ3rJPzymOvATUxxVLMgaFsARmL/9Xa/tAQw3HmJHppxc4p0F
 bfmKNYEWF9qt/ThZbIj7HiuMDr2COvfzN9Md6MyaMxEkCHwhK4QzCWU/YPdReklpfKHu
 pfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745426053; x=1746030853;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6b0EFos6IZUzXOYTm+UFR8FmN+5ZGIjrB5Hf40bTDrQ=;
 b=MKccWkT8V3PneZVATOyMMYMIqFqcW/I0Vru0bEtsoggLqpbTlf/DlsFv7Tmrx2xiVv
 P2ci8JzbQSdLDVBWLLGiooiY5mEGFvF1WSzmRDqXUdvFFs+Av12R0RPRlq/GEwbeXC54
 nvmE7WxgAe2oaMy+cc7ZKdhcDG8oE8QwWUUw33UL1BJlBywZQx6Ybrq841Jc5p2Mt6El
 d5fK3QugJXaRgNS/MjvRWrwFmxGN+tDdXwM2ynEIVRD9TTfs2NOra0xR3bNV0JwzEQIe
 dXmDPgYupQ1348e31oNDQHrGMHSrKTTS86X/1tg3bpRXxM2r17+5HpvUFvvva67XHF/Z
 C/CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF4w4jlmfxMtuSa5gaHgZEZeL/9t3x0q4xIPYLemcx4VNTfk2acetrsxX8QXHRSZji9XwgtOV1ab+4@nongnu.org
X-Gm-Message-State: AOJu0YxdQiIgF6OJWevWN0RhReC/vmDfY/lJrPcaU6COxvhvpNdSrKhM
 WYWmI4dHx5TnO5hISDRolRIGmhYHpDUx/YG9jzMqG3t8CdWh6GAyg8IGNgh5mrk=
X-Gm-Gg: ASbGncs/AoLTZlPh/trPsqXebZEjapERPsuBHvkydllP/NaKOtAvpuSJ9sZrHR0Rt8R
 zzS8juGlHjPF1u99DEcAjqGTPreF8G14oPeUNhisoIGJ121ZxJCpQnyjaaPjIHBm2g+7P3+JX36
 nSd/N2/Pacg41E+phGiTahEp1FnAYOpmu4cyiuqiZogzG4DtI8YAjX0XS8r/MKikLvN/PJIJZ+p
 IPHSIgH6sYMerv4716FAi9oyM2T3DXSBRu+ysQC9VrpkW0h3HD7xoEsH4O2/ulkkPLpJA3ugXEf
 +kJi+uMubAYKG/5ETTKPN8WkoRSf9bnqQL174/9Kdi7+oUOGtGtiPkliWbjKe+suwwzpIFOAZ5u
 FKR2YBtG8
X-Google-Smtp-Source: AGHT+IGUIDsd8q2uhj9Sb27zyYP5NZ3MHRrclXBU8xlUoaWHMXhjr81qr3dvmQRAvUuhzVXKLTmWAg==
X-Received: by 2002:a05:651c:1471:b0:30a:44ca:7e74 with SMTP id
 38308e7fff4ca-310904d5530mr64129111fa.12.1745426053333; 
 Wed, 23 Apr 2025 09:34:13 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-31090782710sm18642991fa.29.2025.04.23.09.34.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 09:34:12 -0700 (PDT)
Message-ID: <0d3d3209-4513-4366-a105-6b71aa9caa88@linaro.org>
Date: Wed, 23 Apr 2025 18:34:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 06/19] hw/arm: Filter machine types for
 qemu-system-arm/aarch64 binaries
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-7-philmd@linaro.org>
 <a4a65446-07b7-4048-993a-6d0d7848b163@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a4a65446-07b7-4048-993a-6d0d7848b163@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

On 22/4/25 19:40, Richard Henderson wrote:
> On 4/22/25 07:54, Philippe Mathieu-Daudé wrote:
>> Since the qemu-system-aarch64 binary is able to run
>> all machines indistinctly, simply register the
>> TYPE_TARGET_AARCH64_MACHINE interface for all
>> existing machines under the hw/arm/ directory.
> 
> "indistinctly" is the wrong word.  I'm not quite sure what you're trying 
> to say in order to suggest a replacement.

I want to express that qemu-system-aarch64 is a superset of
qemu-system-arm machines.

> 
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index 82f42582fa3..ce4d49a9f59 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -15,6 +15,7 @@
>>   #include "hw/arm/aspeed.h"
>>   #include "hw/arm/aspeed_soc.h"
>>   #include "hw/arm/aspeed_eeprom.h"
>> +#include "hw/arm/machines-qom.h"
>>   #include "hw/block/flash.h"
>>   #include "hw/i2c/i2c_mux_pca954x.h"
>>   #include "hw/i2c/smbus_eeprom.h"
>> @@ -1760,91 +1761,199 @@ static const TypeInfo aspeed_machine_types[] = {
>>           .name          = MACHINE_TYPE_NAME("palmetto-bmc"),
>>           .parent        = TYPE_ASPEED_MACHINE,
>>           .class_init    = aspeed_machine_palmetto_class_init,
>> +        .interfaces     = (InterfaceInfo[]) {
>> +            { TYPE_TARGET_ARM_MACHINE },
>> +            { TYPE_TARGET_AARCH64_MACHINE },
>> +            { },
>> +        },
>>       }, {
>>           .name          = MACHINE_TYPE_NAME("supermicrox11-bmc"),
>>           .parent        = TYPE_ASPEED_MACHINE,
>>           .class_init    = aspeed_machine_supermicrox11_bmc_class_init,
>> +        .interfaces     = (InterfaceInfo[]) {
>> +            { TYPE_TARGET_ARM_MACHINE },
>> +            { TYPE_TARGET_AARCH64_MACHINE },
>> +            { },
>> +        },
> 
> Don't replicate these anonymous arrays.
> You want common
> 
> extern InterfaceInfo arm_aarch64_machine_interfaces[];
> extern InterfaceInfo aarch64_machine_interfaces[];
> 
> to be shared by all.

"common" was my first approach (not via extern but macro)
https://lore.kernel.org/qemu-devel/20250403235821.9909-5-philmd@linaro.org/
but Pierrick said on offlist review we want this array to
be verbose.

Pierrick, are you OK with external symbols?


