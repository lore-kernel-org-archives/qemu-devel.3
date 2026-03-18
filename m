Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA161FCD0BE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ku3-0003ZH-55; Wed, 18 Mar 2026 03:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2ktn-0003YT-CE
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 03:01:00 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2ktk-0001wa-3s
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 03:00:57 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso5089335e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 00:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773817253; x=1774422053; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xCVokCm7YwmRHt6zOU0wQ0XcKj2XIvvneyn90BhQRpc=;
 b=TlQBNeI2aWPI3D7XR8TndZYrJeVYnNHq/pi4vsST2xmSssEaSZIvUWvK1WAfCJwQw7
 ykvpAQ4XYU5kMJ4qYhM/JpKNH8SQh3GyTxhQl2r7ebHeR7WIyDCfORrC0a4E7erj2MO9
 jsmAJ7zQkcXF8R8cK437dCNXa+ww/RngmrJJVWWqNi9yWxDnoMuBw1dODitMAmrS9aUb
 nCAeQ18ZGIFzmfU5pmnDV2kZ9KDtf39DVqSIgLnX2dL9FMz0ZsesuEQpE6XxhNT9Chnm
 YtnI1360vY/zuqqFGEp3LihhwX7eEgRl2ETaKitXB66/vcqyRsJ3ajLn3AICxIJGqRV2
 jTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773817253; x=1774422053;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xCVokCm7YwmRHt6zOU0wQ0XcKj2XIvvneyn90BhQRpc=;
 b=s7ZiMQJxHhOisiAi7EdgRB7nG+AtDTCu54PjWXhnKk4QQMhusT4jdfcI2knC/TX516
 c9zeokDpfcSbTe2ynEM/RnHkK48hPoLRIo9NRqedmapTgOgfYRAVCtqExISA+S6UUc64
 iQbkk/wsTq1eLDApBAXSHSpaf+9n2K2yXrEtCZZ8/zSWR1rl4aN4PAVa/IVQhao+dGac
 IpcaLeI8uwtXxSb1Z3gOacauMm70KFDTLEnUvKZB8Vr9bgksmCT/obpskvFqu/aQVHUT
 d+YFJOaR14DW9yS32ZjSnMz/jaGe8p99r9vTsObI11rHil6CjkbBsxykDaY/Br6/Rtir
 M/9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6+f97YEhqMmFkJmSkYTtsUQmow5S8QV/n8DOxKD30yTW8WfaEVT444TgszDr70s93grv8MkXz6DfR@nongnu.org
X-Gm-Message-State: AOJu0Yw46iwhFkAb6Z9akmjKp2+DrLrAsrxyqFW04a8GGI6cOSyLC/oz
 cwxKBu0UX8qOMzA/NrI6NTnd5k3JnOLjIFZ5mfzvHDXhtCDdBmIlSp5Z4KItePqZkwM=
X-Gm-Gg: ATEYQzyoWq7ZQrSfR9pyPFGtKOHVS8LFgTFoHgowMilHyn23RuDwRPedTiObzr4SGkI
 YTxzbCUxQewoTkbd874owtnLod2cKPaNk8XYsTuQUfriKuvDvl5Q0+fhXcPT4cGgJeAxBbuswSe
 967Z7t8gngWuqdf3vEzkRVdnb1DasUo68TCMFP8CUn5aTh+vvlnFOI7wdQ6Udcbe9quoByAgt/C
 sgaTI0mEMleX6UuTGBGsCwIl9/sEZs7Bxw2yEs78ePkLzWY60Hpb1XgVJqYkUFHT9fAITpIHHpA
 GUpLSocWY5cSfRARhM6ipmr20lxEDZq6Yy3xgA7r9broqWFc8HQgXZzDuibljMAO1smMwbjcSWH
 hqxGEoBg852AVgqFAymup8irSIDd92DianDG8u+87Oj1woIq1o+3e0EWeLAozL9JqBnERJVU92y
 40SmffXofjuzmvRNYYNfzgAsBKZPooqQFH/f/h83NB5pMT4szJhcDyw4yRJTzr7fPcCarnpj49V
 5Eb
X-Received: by 2002:a05:600c:4ed0:b0:483:6d9e:e4f5 with SMTP id
 5b1f17b1804b1-486f40a60f3mr38061225e9.5.1773817253165; 
 Wed, 18 Mar 2026 00:00:53 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ea9dc46sm131597445e9.8.2026.03.18.00.00.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 00:00:51 -0700 (PDT)
Message-ID: <75a7d8ee-9b5e-429d-9d40-f6b3c4ae0cfb@linaro.org>
Date: Wed, 18 Mar 2026 08:00:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] system/memory: Fix subpage endianness for
 big-endian targets
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260311115910.564481-1-djordje.todorovic@htecgroup.com>
 <20260311115910.564481-9-djordje.todorovic@htecgroup.com>
 <10764d13-1e18-4ee8-9a6e-64eab71d1305@linaro.org>
In-Reply-To: <10764d13-1e18-4ee8-9a6e-64eab71d1305@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 11/3/26 13:19, Philippe Mathieu-Daudé wrote:
> On 11/3/26 12:59, Djordje Todorovic wrote:
>> The subpage memory region wrapper dispatches MMIO accesses through
>> flatview_read/write, which re-enters memory_region_dispatch_read/write
>> on the underlying device MR. The inner dispatch uses size_memop() which
>> strips endianness bits (effectively MO_LE), causing adjust_endianness to
>> apply a byte-swap for DEVICE_NATIVE_ENDIAN devices on big-endian targets.
>> The outer dispatch's adjust_endianness then sees matching endianness
>> (MO_BE == devend_BE) and does nothing, leaving the data incorrectly 
>> swapped.
>>
>> Fix by changing subpage_ops from DEVICE_NATIVE_ENDIAN to 
>> DEVICE_LITTLE_ENDIAN.
>> This matches the implicit LE semantics of size_memop() used in the inner
>> dispatch, so the outer adjust_endianness correctly compensates with a
>> second swap, yielding the correct net result.
>>
>> For little-endian targets, DEVICE_NATIVE_ENDIAN already equals LE, so
>> this change has zero behavioral impact.
>> ---
>>   system/physmem.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/system/physmem.c b/system/physmem.c
>> index 2fb0c25c93..5d917482eb 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -2929,7 +2929,7 @@ static const MemoryRegionOps subpage_ops = {
>>       .valid.min_access_size = 1,
>>       .valid.max_access_size = 8,
>>       .valid.accepts = subpage_accepts,
>> -    .endianness = DEVICE_NATIVE_ENDIAN,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
> 
> NAck, this likely break big-endian hosts.

(see also 
https://lore.kernel.org/qemu-devel/20251224152210.87880-4-philmd@linaro.org/ 
and Paolo's response)

>>   };
> 


