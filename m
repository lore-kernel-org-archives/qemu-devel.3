Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A77CCD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 04:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZLFw-0006hC-M6; Tue, 16 Jun 2026 00:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZLFv-0006gz-Lp
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 00:18:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZLFu-0000TF-2T
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 00:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781583508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gk2XBqHrPlVN0N+6mfNxhzPVX9fT/YRqcHVJ9e0I8sA=;
 b=Wk2n4r41/7Sbjy9l5Amkhs1QRSOQAFL9wFKjSwMK7V3JnUxbrleh0GLt4alib8M/CyG8wo
 3urFv8AIhJ7uZZaflP0XGT6aSnEZ+NUgyv4fSe+UMZENGzjVOwjUqw1q88+eqPZQHmwUqZ
 3rge4Lxkl4yEjSOnFxVPV+m0o58nghc=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-kix07guDNs-GkSs0YKeqVw-1; Tue, 16 Jun 2026 00:18:25 -0400
X-MC-Unique: kix07guDNs-GkSs0YKeqVw-1
X-Mimecast-MFC-AGG-ID: kix07guDNs-GkSs0YKeqVw_1781583505
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3080bb0267dso1077564eec.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 21:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781583505; x=1782188305; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gk2XBqHrPlVN0N+6mfNxhzPVX9fT/YRqcHVJ9e0I8sA=;
 b=aDXDcodgewoZTMzGWd9+1aLVlNngX94E/hjSlP0qz/xXeUGGGyRl66nm7KWlaMWjHL
 uRVuk7CV6qrqSe70zN8fzqWPL9yUaLtUDQYihdLkKKm/9DMboVwwd/YdZdjEGq4oqupw
 2dISdp6gRrNBVNWmDzVf2J9qSHHRn4JSv1AHdo7UQO2vHU3iYf5zXmrlh8VBpMPGJa21
 h1gdHMDQ3E9Mrz9Ac+IdQ6lxgq4mWNC9Xuohj6QSXsMZhaW2X+Lwe35klIyL45e6YP4Z
 bw26DGbk8Xd6Q1tZJGXNsoiamWJ1/2XGHeqpGzul7AG9tMw6e4tYiTeq7yEB1EW2/dz3
 aYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781583505; x=1782188305;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gk2XBqHrPlVN0N+6mfNxhzPVX9fT/YRqcHVJ9e0I8sA=;
 b=D4FyF3RSGJLE+qaxmqNGQI2q5g4idWUUPx0KVmaljgKTswH9rqAEZC2k8OeGh5QYAb
 18t3/Z4UH86VW0yIOZ8oQ9v8X8OZbnwqCOMsE/PmGUfn/IzFGeMjM7ky4WC68nB05zTS
 kRnHCW79iYHlkEATY/Jjs07JaRYpAQaI7QMVIIMFuBp+Yz6nXPdmxsKyNY11np8Bb0qx
 jIg4OzZ2+pqVj3S6edijMUJKlAkhI88ASDY6vfp9UwZ94RFNOwsA+jEYhk55YPKfsYKa
 6s6cx+J03gTAgf5GqvmwjksAKGmom/0s2N4NgKJieUdhincBXE15sCBVrH2nTYsLUJwe
 M7Vg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8eclzkXgotPhZTK1SXD+i7FgaHNyTLI+4CLbYOFu/jMa3n3ChrBLd8MqUxX0TaXidD5VBb4u5IR35P@nongnu.org
X-Gm-Message-State: AOJu0Yz+HYbENlaW8Q+MbLk2p7gV24bUeH8j7U4O1sLBFvsTOkxxHYLT
 8/ggzJdTQeWBDh9KUcoDPYRkDiJGhPrV05cD+UdZQVoxno/S6MSrbAng+8YdpvOYNN+hVDQ9Y8y
 1WlFQ2T2TpZCjhNEhCqiFyCf7MaiHDEyGvS83SlergjK+4gLx0mbnOHX4
X-Gm-Gg: Acq92OGCfqBrPaaTYF7ZB9LaroWSR1YZnxlCo7GZ4Uf9KhHFMWav4AUJ/KYzPEDtSJV
 v9ynyzUn6x+1GokzacRcjqMe/LKxwz+LTWAVVUjdTNkK1PrF2Kz1wNkKP4aPRVNj+9ClGbipVJW
 pU9ZtAhU9HXFfbj4voMdcqWGp75wDic084f8CxXYxMfRq7hqzKq46x51dI4UZF8bPMSb0bgOF0m
 bP/ShBSOqOnKhHUcMzoNMdPi4DaShSSVXe7/9qbam7MB5OMTs7uipCffoqlyQDuGtEZ2KuYJCr/
 a3IQNFET4w+Gw6D58tl84UcBdErZ4piZ667UdHjLvImnpZs+pIfwdtaJs/u4uSy35OeR0XrsnxF
 xeP0VgZp1fuCqqCGJgEajGLvQucwVXgrLq1zY+V5gXIoVd30+M2zp2pP79oYSFa3r
X-Received: by 2002:a05:7300:7485:b0:307:34f9:cc9 with SMTP id
 5a478bee46e88-3093551a1admr6985958eec.2.1781583504458; 
 Mon, 15 Jun 2026 21:18:24 -0700 (PDT)
X-Received: by 2002:a05:7300:7485:b0:307:34f9:cc9 with SMTP id
 5a478bee46e88-3093551a1admr6985943eec.2.1781583503880; 
 Mon, 15 Jun 2026 21:18:23 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e91f88bsm17658183eec.16.2026.06.15.21.18.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 21:18:23 -0700 (PDT)
Message-ID: <09127e09-2ea4-4bbe-a4b0-5cf55a8b1c22@redhat.com>
Date: Tue, 16 Jun 2026 14:18:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peterx@redhat.com, alex@shazbot.org,
 peter.maydell@linaro.org, berrange@redhat.com, philmd@oss.qualcomm.com,
 philmd@mailo.com, david@kernel.org, clg@redhat.com, pbonzini@redhat.com,
 phrdina@redhat.com, jugraham@redhat.com, liugang24219@sangfor.com.cn,
 dinghui@sangfor.com.cn, shan.gavin@gmail.com
References: <20260615100200.266968-1-gshan@redhat.com>
 <20260615100200.266968-2-gshan@redhat.com>
 <93fb3b41-1543-4e3b-922b-043b774f57bf@linaro.org>
 <d0d18a5b-1178-416d-81aa-d6d5f56ae3a7@redhat.com>
 <fc1213f4-1500-4282-8c98-8ddf10d4955a@linaro.org>
 <32c4a353-1cbc-4d3e-b05c-a4324e985426@redhat.com>
 <20260615153757-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260615153757-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/16/26 5:40 AM, Michael S. Tsirkin wrote:
> On Tue, Jun 16, 2026 at 04:09:27AM +1000, Gavin Shan wrote:
>> On 6/16/26 3:03 AM, Richard Henderson wrote:
>>> On 6/15/26 09:33, Gavin Shan wrote:
>>>>> Either assert n != 0 to start, or use while not do/while.
>>>>> Because the body of the loop won't handle n == 0 correctly.
>>>>>
>>>>
>>>> I will change this to "while (n > 0)" since we're not expecting
>>>> "n < 0" either.
>>>
>>> size_t is unsigned.
>>>
>>
>> oh, yes.
>>
>>>> Could you confirm which stores need qatomic_set()? There are two sets
>>>> of stores as below. I guess you're asking have qatomic_set() for (a)?
>>>> Could you explain a bit why qatomic_set() is needed?
>>>>
>>>>       // (a)
>>>>       *(uint64_t *)dest = *(uint64_t *)src;
>>>
>>> Of course (a).
>>>
>>> Using qatomic_set prevents the compiler from merging the stores, kinda like volatile.  Not especially likely with the way you've written this, but if you had exchanged the switch and loop,
>>>
>>>       switch (lsb) {
>>>       case 1:
>>>           for (; n ; n--, dst++, src++) {
>>>               *(uint8_t *)dst = *(uint8_t *)src;
>>>           }
>>>
>>> then the compiler is quite likely to "optimize" the loop back to memcpy.
>>>
>>> It's also self-documenting what we're intending with the store.
>>>
>>
>> ok, thanks for your explanation.
>>
>>> I guess it's also worth asking if this copy is also used for copying *from* device memory.  The commit that added memmove (4a73aee8814) suggests that dma from the device uses these paths.  In which case you'll either want a separate function for that, or both source and destination must be aligned.
>>>
>>
>> I think it's a valid case. Lets handle this by limiting the 'step' based on
>> src/dest/n, something like below. atomic_read() instead of ldxxx_he_p() is
>> used for loads. Please take a look if there are anything we can improve
>> further.
>>
>> // Not compiled and tested yet
>> static void qemu_ram_copy_unaligned(void *dest, const void *src, size_t n)
>> {
>>      uintptr_t test, step;
>>
>>      while (n != 0) {
>>          test = (uintptr_t)src | n;       /* alignment enforced by source */
>>          step = test & -test;
>>          test = (uintptr_t)dest | n;      /* alignment enforced by destination */
>>          step = MIN(step, test & -test);
>>
>>          switch (step) {
>>          case 1:
>>              qatomic_set((uint8_t *)dest, qatomic_read((uint8_t *)src));
>>              src += 1;
>>              dest += 1;
>>              n -= 1;
>>              break;
>>          case 2:
>>              qatomic_set((uint16_t *)dest, qatomic_read((uint16_t *)src));
>>              src += 2;
>>              dest += 2;
>>              n -= 2;
>>              break;
>>          case 4:
>>              qatomic_set((uint32_t *)dest, qatomic_read((uint32_t *)src));
>>              src += 4;
>>              dest += 4;
>>              n -= 4;
>>              break;
>>          default:
>>              qatomic_set((uint64_t *)dest, qatomic_read((uint64_t *)src);
>>              src += 8;
>>              dest += 8;
>>              n -= 8;
>>          }
> 
> 
> If the length is > 8, I feel it's important to just use memcpy/memmove
> normally.
> 
> Because at that point it's a large data transfer not MMIO, and performance
> is important.
> 

Yes, making sense to me. it shouldn't be a MMIO transaction if the length
is 16 bytes or more, we can use memcpy/memmove() for this specific case,
to improve the performance.

> 
>>      }
>> }
>>
>>
>>>> Another unrelated question: why 'int' value is returned from ldub_p()
>>>> and ld{uw, l}_he_p() in bswap.h? They would return 'uint{8, 16, 32}_t'
>>>> values?
>>>
>>> A bad choice 20 years ago, and the need to audit all uses in order to change it now.
>>> Newer functions use uintN_t as you suggest.
>>>
>>
>> Ok :-)
>>
>>> r~
>>>
>>

Thanks,
Gavin


