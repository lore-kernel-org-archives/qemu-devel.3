Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A843BCD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 18:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZBkm-0005Vd-Qp; Mon, 15 Jun 2026 14:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZBkl-0005Un-Kb
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 14:09:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZBkj-0003s5-Kn
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 14:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781546980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I1p7SdAykWPa/iK/jSi6h3hOisQznNzvN0QEdCegvn0=;
 b=GBcoYffSEjAlPt59AeM9Y8mkLH82cxdx73b4LS9rtSjvXYsVtXeR3MnOhGcsiOiowhplo9
 NbrLHY22qJDdoo+YzXS4l+oucxiYTkHRbKvE/1Ax0LZItuD5dv1pTEDmMP5AwZXRNQXTx7
 g6AkQGje5PDCQm655BuFUsjW9+XE1Pg=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-8xtDFjQxOYGRP71kUJbepQ-1; Mon, 15 Jun 2026 14:09:38 -0400
X-MC-Unique: 8xtDFjQxOYGRP71kUJbepQ-1
X-Mimecast-MFC-AGG-ID: 8xtDFjQxOYGRP71kUJbepQ_1781546978
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304ea42b025so2083555eec.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 11:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781546977; x=1782151777; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I1p7SdAykWPa/iK/jSi6h3hOisQznNzvN0QEdCegvn0=;
 b=JcV8mFfDIqZHuNNxHFW6J5r3l4H66YbLff0D9PbQLlwAM+jI7N7v/e6u5eoSlCCb2Q
 9nPtaaAqVg1V/WFFBmZCj6XL6m8ql01G2JeYqTIy5X/CA3mmWrksG2ydgcOxweIFrxwb
 ozUAaM6MeLyubEWcAAXYvSfE2aOck7ebU1mqz/9wjzjx86I/qKuw2/0/zTKtK2JgAK+b
 WnI7Pl509Pa4myZDdSW0WzKykU+oqgd8UexgaoMU+zHu+g04MiuZ05TwBHWCVOEnVWAd
 YHBuLOaTsSQgeK+Wg39nBkIkqfWpE3djZnM/MPtQUeZJNYhMy2XCNmL+lUqf/88pnYGq
 6rQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781546977; x=1782151777;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I1p7SdAykWPa/iK/jSi6h3hOisQznNzvN0QEdCegvn0=;
 b=PTqTznmPpipumUn9f2Cri7ckTVlXGes5HH+LFiWkMBYCuSivROSF6IO9mUHvWGFQEu
 iyEZhRZYHwg/+Iu3AH9dc+f0uRZedXfE3cWTtVoE7ZyaF+WPJvfdL5ObKGLaJlAJyVN2
 La2/5zA3iSNAuSg9FCMkLo4ENk+W+T1HI7aefEbODRpK3kvYKNBr+ZGDNE6y4Q7Xkw59
 AkURy37k/XbGgedGvV/zTVTZxJNWBTixD2LxDf1zZ+fYQareCyUPvOMH2panNdED1580
 2ooUvE4pnVGgUUuxVD2LLgUviF4jMP1wiu+kqVNf3e/9pnzQdSpFUkqgFvZ38yrRPIuU
 iE1w==
X-Gm-Message-State: AOJu0YzbZa3t0irfEdznewrpMza3vgQIitRvml3cTHwNvcXtAirAYRTU
 U0EFbPhro4Pmh9yM43b5QPTnfChNK5nG7QOJHM619jZal6WUBIT+2CwQKB46531AewvY0tRHXVI
 5ezlvfjqFvrqVggHwsDt/MBHVbBXo6jkjABHR477X4OI7akqTkmMkAF2+
X-Gm-Gg: Acq92OEgEgswjRfxvK42uT80h+I0yeT969k6LGuvWolvQpGBwyf+Jb26J3ceHPCB1r3
 pcS2eL3gQn9wcV+JH+3s/R8f0CMa13H+YFOqkpRF/C3Q53hGdzbZNxnd3JWeObBClIST3OB8PvV
 wHz0cFSV56VHaeZ6DHOS4yNHxxdQIgU7/JhFbr61uSziCBZHrxqbOZQji0yYBjNbes9yhf2uQaW
 Iq+hLMneBDZ938Fos2gxxk/dXllPsn33OmU6xZGhm3fccFL3W/7TJIXuVveJGadmj4GiZMxIADo
 I9jBifVV712reB3mjFbQQ94jJwJjJZs0u03xnyvQ+fEra7QYYoOZV8xlgCaP0NKwbDZBFT0eOD4
 4i3/KGKTiaxNRt5jMi1qzCJ6BbW1MGUhjWO1Ek0N7U5fWUnwqDfh3of2X2sNfq0WW
X-Received: by 2002:a05:7300:6405:b0:304:13f3:ecdd with SMTP id
 5a478bee46e88-30ba2b02bd5mr364039eec.0.1781546977501; 
 Mon, 15 Jun 2026 11:09:37 -0700 (PDT)
X-Received: by 2002:a05:7300:6405:b0:304:13f3:ecdd with SMTP id
 5a478bee46e88-30ba2b02bd5mr364008eec.0.1781546976912; 
 Mon, 15 Jun 2026 11:09:36 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e48e412sm16818367eec.4.2026.06.15.11.09.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 11:09:36 -0700 (PDT)
Message-ID: <32c4a353-1cbc-4d3e-b05c-a4324e985426@redhat.com>
Date: Tue, 16 Jun 2026 04:09:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
To: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, mst@redhat.com, peterx@redhat.com,
 alex@shazbot.org, peter.maydell@linaro.org, berrange@redhat.com,
 philmd@oss.qualcomm.com, philmd@mailo.com, david@kernel.org, clg@redhat.com,
 pbonzini@redhat.com, phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com
References: <20260615100200.266968-1-gshan@redhat.com>
 <20260615100200.266968-2-gshan@redhat.com>
 <93fb3b41-1543-4e3b-922b-043b774f57bf@linaro.org>
 <d0d18a5b-1178-416d-81aa-d6d5f56ae3a7@redhat.com>
 <fc1213f4-1500-4282-8c98-8ddf10d4955a@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <fc1213f4-1500-4282-8c98-8ddf10d4955a@linaro.org>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/16/26 3:03 AM, Richard Henderson wrote:
> On 6/15/26 09:33, Gavin Shan wrote:
>>> Either assert n != 0 to start, or use while not do/while.
>>> Because the body of the loop won't handle n == 0 correctly.
>>>
>>
>> I will change this to "while (n > 0)" since we're not expecting
>> "n < 0" either.
> 
> size_t is unsigned.
> 

oh, yes.

>> Could you confirm which stores need qatomic_set()? There are two sets
>> of stores as below. I guess you're asking have qatomic_set() for (a)?
>> Could you explain a bit why qatomic_set() is needed?
>>
>>      // (a)
>>      *(uint64_t *)dest = *(uint64_t *)src;
> 
> Of course (a).
> 
> Using qatomic_set prevents the compiler from merging the stores, kinda like volatile.  Not especially likely with the way you've written this, but if you had exchanged the switch and loop,
> 
>      switch (lsb) {
>      case 1:
>          for (; n ; n--, dst++, src++) {
>              *(uint8_t *)dst = *(uint8_t *)src;
>          }
> 
> then the compiler is quite likely to "optimize" the loop back to memcpy.
> 
> It's also self-documenting what we're intending with the store.
> 

ok, thanks for your explanation.

> I guess it's also worth asking if this copy is also used for copying *from* device memory.  The commit that added memmove (4a73aee8814) suggests that dma from the device uses these paths.  In which case you'll either want a separate function for that, or both source and destination must be aligned.
> 

I think it's a valid case. Lets handle this by limiting the 'step' based on
src/dest/n, something like below. atomic_read() instead of ldxxx_he_p() is
used for loads. Please take a look if there are anything we can improve
further.

// Not compiled and tested yet
static void qemu_ram_copy_unaligned(void *dest, const void *src, size_t n)
{
     uintptr_t test, step;

     while (n != 0) {
         test = (uintptr_t)src | n;       /* alignment enforced by source */
         step = test & -test;
         test = (uintptr_t)dest | n;      /* alignment enforced by destination */
         step = MIN(step, test & -test);

         switch (step) {
         case 1:
             qatomic_set((uint8_t *)dest, qatomic_read((uint8_t *)src));
             src += 1;
             dest += 1;
             n -= 1;
             break;
         case 2:
             qatomic_set((uint16_t *)dest, qatomic_read((uint16_t *)src));
             src += 2;
             dest += 2;
             n -= 2;
             break;
         case 4:
             qatomic_set((uint32_t *)dest, qatomic_read((uint32_t *)src));
             src += 4;
             dest += 4;
             n -= 4;
             break;
         default:
             qatomic_set((uint64_t *)dest, qatomic_read((uint64_t *)src);
             src += 8;
             dest += 8;
             n -= 8;
         }
     }
}


>> Another unrelated question: why 'int' value is returned from ldub_p()
>> and ld{uw, l}_he_p() in bswap.h? They would return 'uint{8, 16, 32}_t'
>> values?
> 
> A bad choice 20 years ago, and the need to audit all uses in order to change it now.
> Newer functions use uintN_t as you suggest.
> 

Ok :-)

> r~
> 

Thanks,
Gavin


