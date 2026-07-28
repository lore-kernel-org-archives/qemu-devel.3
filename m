Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA99C531F9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woeyk-0004ER-G5; Tue, 28 Jul 2026 06:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1woeyj-0004E0-Az
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:24:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1woeyh-0005Bv-QT
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785234241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eb0F9fPTNxjGu53kmweUHKC7A+M3Yj3h+ht+6OfGSx4=;
 b=TBsrkK4m7xok3QgbI2MK0VFLcqSZ+SZw0QasD0Mmyc5pRBRXnFDNgeJWZd2cy845+pLOrv
 GwvV1y+k5TMKo9J8nQI5j8DTntWECLjwtyBxYeRW+oJPqB0POWhxYqf7DTmw7Ah4iU4vpu
 gGpBbWlCqGupcYdIJYR7FICCNIME4bs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-2S2mq7mZMBmNzvuyUvceTQ-1; Tue, 28 Jul 2026 06:24:00 -0400
X-MC-Unique: 2S2mq7mZMBmNzvuyUvceTQ-1
X-Mimecast-MFC-AGG-ID: 2S2mq7mZMBmNzvuyUvceTQ_1785234239
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d001671a54so33462935ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 03:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785234239; x=1785839039; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eb0F9fPTNxjGu53kmweUHKC7A+M3Yj3h+ht+6OfGSx4=;
 b=GRRYYd9ypZsZos4yFyCjz/6DqTfiLk5HQcSqbV5HfFxm6zVy/2Xuej38qszooUKjcw
 k5pLXQORNrNNK5FNNKLE3iwgwbDFIckooyk97+K7BdcdXBKTM5qk357HDTvwgojnYP1g
 dYLAwQSw+iKuv9wVdyNoYWLRvIANjtTokDfNqGr5jnwPBnfbFbl1mH10OclhBvv4fZ1r
 ov0iuR9hUcdowBPGMVuvxdY3TblnpThLV38BOZ/6QSmsVCllO+u5H/7/I0RhEtq/2KfP
 3lxJ7M+1f5kDK/U8PBXFkIOteOAS2zAnMrVPiQ5zvmBr7KRUFihvGJ+8tha835Q/rUUG
 l1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785234239; x=1785839039;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eb0F9fPTNxjGu53kmweUHKC7A+M3Yj3h+ht+6OfGSx4=;
 b=hQyuJzg+DotfriuIMP/ZWdg/2VR/mjK8sWCH5Cw6Pj4eulQRWOA3PFxoH1tcWPBYbX
 5fSfcWDmbkHhWkSNSAqsK5dzBqQe3yTJ2nKJgmfUOBE3CFBCQtf+7KbY6k4hXG32Al1U
 QbO9vhmuOx+qvLfOFu2zPPE2vR9HA7dEfC+2uTr4JuR1Zn6+eHfmd/gketg1EnwDm5el
 z098vF8+y5x1StH03wrvjozzge7jlFncl6mFF8GEUjnTGMtHDvIP2I14/t0ocGPxobbI
 1/rMAvN0ZYtlKW0BIv7duK9Gjx8Lcg9ksqyRFZH+91TZme2pGqPeS5Iy6clxxGmZjlcR
 nxag==
X-Forwarded-Encrypted: i=1;
 AHgh+Rry4J3aJm6khoZahMcHcVDcuu0disVRSV+ZMvSgrfsOad+5I5gnP/3kLSiuJpNbtiUz9BVB213ph+9g@nongnu.org
X-Gm-Message-State: AOJu0YwgWs/WyL6ZM3jic0uBkIH4MpyS1xqiFmf9UjRqEMEozHbCA6In
 7e6yHiZoVpQIc+cJ1ZZIJ9ML/UOZNKgE8dEoJzwwfnPSZz1DTSasrX/DM60iWyFETgCgV2FUZFg
 ADqQnhzy5ot2XbIQVcihtiHS/xFlXLQPSwjpYKAmlSl87GW7RzB4Wpved
X-Gm-Gg: AR+sD10YsRGWe0aiLfODPX2YqAkqYxL991C1MOYpDJKr3+hXwcS6axSH2xTmAzrIWbW
 75kepUQFkPY04H8MWCTynWDgVGKK0Ev1RiJYSvhva1Vj0QWZkn0DFFepcZkPcYRTX2r8oI+VBqT
 urbqd73FIfK9EJbFaoL8OW2dfr6gWrNAPoUAYL1nFQfZhvd2T/ztaIrXp47E3yijFLUcD9/jfNw
 eekco0UvEKb2czMbFRHkq/XBlnjwhXR/miph4Ye7qVUSMqoGX0/M9AoXXTk43y7f5PduOW/CgXd
 bzxmsocKonaGykUXcq4oW7GExqJadgxXsGLMPqVatIjgkQFMImeSJ8q6GC9qe7FAHDvkxZ37qDt
 oq2sCf0d/EA4Q/O+0Dgm8A/yKTuhNhMEnHAt2ET3pMl0=
X-Received: by 2002:a17:902:f645:b0:2ca:ecf6:910e with SMTP id
 d9443c01a7336-2d0159aff48mr22419625ad.0.1785234239183; 
 Tue, 28 Jul 2026 03:23:59 -0700 (PDT)
X-Received: by 2002:a17:902:f645:b0:2ca:ecf6:910e with SMTP id
 d9443c01a7336-2d0159aff48mr22419255ad.0.1785234238691; 
 Tue, 28 Jul 2026 03:23:58 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde5e2a78sm50739545ad.26.2026.07.28.03.23.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 03:23:57 -0700 (PDT)
Message-ID: <2322668a-20a3-4a6b-8d7f-c04ddfef84f1@redhat.com>
Date: Tue, 28 Jul 2026 20:23:48 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] system/memory: Use qemu_ram_move() for directly
 accessible regions
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com,
 mst@redhat.com, richard.henderson@linaro.org, alex@shazbot.org,
 berrange@redhat.com, philmd@mailo.com, david@kernel.org, clg@redhat.com,
 pbonzini@redhat.com, phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com
References: <20260727032649.145381-1-gshan@redhat.com>
 <20260727032649.145381-3-gshan@redhat.com>
 <CAFEAcA9_tDRAd97z4UtNhFPK+fMbq37LJhWTSmD5cueo61hvvg@mail.gmail.com>
 <0a384d67-fc56-4a21-9d0e-25f218a45228@redhat.com>
 <CAFEAcA9HbTSj9cJfv8o=jYSuPhScr-RVKWCos4kpUJ+T1S6g5Q@mail.gmail.com>
 <13333e56-3725-4550-849c-9035f6925213@oss.qualcomm.com>
 <CAFEAcA9X7SNUvQpwXA2_xReUERB-eBETty3g32-PD=MVk536sg@mail.gmail.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <CAFEAcA9X7SNUvQpwXA2_xReUERB-eBETty3g32-PD=MVk536sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/28/26 7:35 PM, Peter Maydell wrote:
> On Tue, 28 Jul 2026 at 10:22, Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> On 28/7/26 11:01, Peter Maydell wrote:
>>> On Tue, 28 Jul 2026 at 04:01, Gavin Shan <gshan@redhat.com> wrote:
>>>>
>>>> On 7/27/26 10:51 PM, Peter Maydell wrote:
> 
> 
>>>>>> +    test = (uintptr_t)src | (uintptr_t)dst | n;
>>>>>> +    len = test & -test;
>>>>>
>>>>> What is this doing? I am not a fan of clever bit twiddling
>>>>> that isn't commented to explain itself. Readers of the code
>>>>> shouldn't have to go off and search for an explanation of what
>>>>> is going on.
>>>>>
>>>>
>>>> The following comments will be added for (v5).
>>>>
>>>>        /*
>>>>         * Maximal length of aligned access that are determined by @src,
>>>>         * @dst and @n
>>>>         */
>>>
>>> What I mean is more that it ought to say why "x & -x"
>>> achieves that goal.
>>
>> Hmm isn't "x & -x" restricted to power of 2? Here we have no garanty
>> @test is, because we have no garanty @n is. Ah, this is catched by
>> the 'len != n' check and returns after calling memmove(). Indeed not
>> very clear notation. Again:
>>
>>     ...
>>
>>     /* Overlapping buffers, unaligned or oversized access */
>>     if (!QEMU_IS_ALIGNED((uintptr_t)src | (uintptr_t)dst, n)) {
>>         memmove(dst, src, n);
>>         return;
>>     }
>>
>>     switch (n) {
>>     ...
> 
> I'm not inherently against the bit twiddling (QEMU_IS_ALIGNED
> on a variable length will do a division, maybe we care?);
> I just want that if we do use a bit-twiddling trick that we
> explain why it does the thing we want it to do.
> 

Ok, PeterM and Philippe, Could you please help to check if below code looks
good to you? Thanks a lot :-)

void qemu_ram_move(void *dst, const void *src, size_t n)
{
     if (n == 0) {
         return;
     }

     /* Overlapping areas, unaligned or oversized access */
     if (!is_power_of_2(n) || n > 8 ||
         !QEMU_IS_ALIGNED((uintptr_t)src | (uintptr_t)dst, n)) {
         memmove(dst, src, n);
         return;
     }

      switch (n) {
      case 1:
          qatomic_set((uint8_t *)dst, qatomic_read((uint8_t *)src));
          break;
      case 2:
          qatomic_set((uint16_t *)dst, qatomic_read((uint16_t *)src));
          break;
      case 4:
          qatomic_set((uint32_t *)dst, qatomic_read((uint32_t *)src));
          break;
      case 8:
          qatomic_set((uint64_t *)dst, qatomic_read((uint64_t *)src));
          break;
      default:
          g_assert_not_reached();
      }
}

QEMU_IS_ALIGNED() doesn't require the arguments are power-of-two values.

#define QEMU_IS_ALIGNED(n, m) (((n) % (m)) == 0)   /* QEMU_IS_ALIGNED(3, 3) => true */

I also need to drop "and the memory areas do not overlap" in (v6) from the
comments for include/system/memory.h::qemu_ram_move() as the check 'src == dst'
check has been dropped. Sorry that I sent (v5) too quick because our downstream
need a stabilized version to integrate.

Thanks,
Gavin


