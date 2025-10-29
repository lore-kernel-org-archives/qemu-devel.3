Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA998CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 13:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE64n-0004P7-Tv; Wed, 29 Oct 2025 09:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE64m-0004Oh-CS
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:18:56 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE64d-0007Oq-HX
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:18:55 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47114a40161so81646365e9.3
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 06:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761743920; x=1762348720; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bbBhe7Jqme4xLw7q/N3DTDLYkblUqkjEodwvETnzT40=;
 b=j4uYM9/nRk5RqmYgsMCxUY7VR/1V1NBHs04eDhSRxgbP9Wq5E3pfXTZ2sBZf5KQxNw
 nNmnW73MrdM3fmAFqUKbYbVQLIbNRBLTpHeYqaqTSGlxh70RKUbLrFHpU/EYbcKqAZ82
 t2peRHdrFrmN/kn1x+ad1wNrDGWIo36iT28hrJ1GloIVg4o5JVjU58t/v6UmBSzhoAXz
 0OTKCmpquZULDb07h71NuXy+60w9YtIfFRDfbWvvtWlsyZPFJ/nx0ETw6XE6ghVy0u9F
 +APmWXXLQRF1b6v5+CYzWCPP/0MzNUwLGo1iYkbjKKGLApE608maZEmrUGq0FCOTXQhV
 cf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761743920; x=1762348720;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bbBhe7Jqme4xLw7q/N3DTDLYkblUqkjEodwvETnzT40=;
 b=fqyDkcJoMRSiMJAjgBeYUmPlzD4/PKlOlJOTLHT2R9fIOjX/drMsdfbDdFT0pkFvgW
 StfHTEYtmRJ1hTBKXwjGyaTc6MJjY9p/+FOI0Vce2iWDs1qBUKsE4GFv2KrAyS7GCuab
 MmNc0+L9wZxZvf/9eI3ngj4Qu6SrIUNhWOcL6F5nmTTMdoMKCh0LRmQk/PD4ZoF5lPH3
 l0x6ZisRLkmoPsgr6KMi/6u7o3mYVt7uiQP+u5F2AngT3Jm2IeTUL+S4pahp7T/fwWqz
 dSmqOZHQBlK1bMdusoOMR9b9glJxz5RfvQVYE3+SudglqzfwIifRdtUth/4GO1PD/ym9
 zDpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHolc7OOAczzVxnBQuQyiCLXeqCdoWEVvS8xeghohtwHfNAPU4ACb7R0ISe9WuFQz4njODYz0Zoz2Z@nongnu.org
X-Gm-Message-State: AOJu0Yyf69U0yCKXil9LHiNbb93wabZFPeQy5vC425MOXjEbpm/Lq6kB
 L4VuxL4fG3f0uFFVm8ppL7bnnPAmtaJ4LGAgdjLu8QGI2LH/ShFHLqaq9e9HiP3UcX0=
X-Gm-Gg: ASbGncvl2xC+b6i4GEGK1bQEAHLIYERV0PwEZagf9fhgmuti6tgUhjoGd0+XBOUdt9+
 DQcd9FIxCjyANfPtCquYY0uhxLTYGOaQwszUyuYBs3a3qMbScXx5QicsU7ZwzNE7M2KdliZWONf
 GbdejlRUYjeNElr+l1VWdmBBzeC8x420Kn3nNn9Ea4JT7gwQH/7WlU/z/TLwXJ+ISt/e+ZAAVtM
 JmNkkjqUIVyIeT/OA46+CzbAcZpWN+xenFpLFGiGtgmsM37iKMDPzGCiqyl5l/NJ+zkjQCp1JmD
 mtMTypq/dSeH5bYPL73YRc3fJtafYT5CuM5L6lRBAzWfCz6Fiyxw2golOvoCJfbJ1d6jDogTg/m
 /jiyNr9b2wHLdZ4ew9GnbVBASIuImgYT3VyWXxYG1xVyzSvPsZ5S7YTdoSBz6ubiIUf6UQnmOLj
 VfXFc12I4B8YXtcq7nWp8at9aebBddJEYYZZzRPpAYF+4=
X-Google-Smtp-Source: AGHT+IEMBHugsNYOma8f2/rsZ6jwMDfJvaKdC7qaYRPPFatsYFYUZNyqOyrnr5aU+Wuff07IpogmmQ==
X-Received: by 2002:a05:600c:6818:b0:46f:b42e:e3a0 with SMTP id
 5b1f17b1804b1-4771e3df22fmr24017395e9.41.1761743920557; 
 Wed, 29 Oct 2025 06:18:40 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952db9c6sm26820345f8f.36.2025.10.29.06.18.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 06:18:39 -0700 (PDT)
Message-ID: <99870dc8-830c-4ce9-a25a-5aa7c47e074f@linaro.org>
Date: Wed, 29 Oct 2025 14:18:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/25] hw/s390x: Use memory_region_get_address()
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-17-philmd@linaro.org>
 <f99989f4-88bd-4167-b9e3-fe4a249a2c99@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f99989f4-88bd-4167-b9e3-fe4a249a2c99@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 29/10/25 09:28, David Hildenbrand wrote:
> 
>> @@ -510,11 +514,12 @@ static MemTxResult 
>> zpci_write_bar(S390PCIBusDevice *pbdev, uint8_t pcias,
>>                                     uint64_t offset, uint64_t data, 
>> uint8_t len)
>>   {
>>       MemoryRegion *mr;
>> +    hwaddr subregion_base_addr;
>>       mr = pbdev->pdev->io_regions[pcias].memory;
>>       mr = s390_get_subregion(mr, offset, len);
>> -    offset -= mr->addr;
>> -    return memory_region_dispatch_write(mr, offset, data,
>> +    subregion_base_addr = memory_region_get_address(mr);
> 
> Any partixular reason for the temp variable?

To fit the 72-80 chars per line limit. Since various people
asked the same, I'll just replace in place, ignoring the
checkpatch.pl warnings.

> 
>> +    return memory_region_dispatch_write(mr, offset - 
>> subregion_base_addr, data,
>>                                           size_memop(len) | MO_BE,
>>                                           MEMTXATTRS_UNSPECIFIED);
>>   }
>> @@ -832,6 +837,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, 
>> uint8_t r3, uint64_t gaddr,
>>       S390PCIBusDevice *pbdev;
>>       MemoryRegion *mr;
>>       MemTxResult result;
>> +    hwaddr subregion_base_addr;
>>       uint64_t offset;
>>       int i;
>>       uint32_t fh;
>> @@ -900,7 +906,8 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, 
>> uint8_t r3, uint64_t gaddr,
>>       mr = pbdev->pdev->io_regions[pcias].memory;
>>       mr = s390_get_subregion(mr, offset, len);
>> -    offset -= mr->addr;
>> +    subregion_base_addr = memory_region_get_address(mr);
> 
> Dito
> 
> 


