Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69700C36014
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 11:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqWJX-0004Yr-4V; Tue, 17 Sep 2024 07:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sqWJT-0004Tn-Eb
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 07:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sqWJR-0007OU-Ox
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 07:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726572244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+Keu6x5euSv1fM+EoTYwh4hu8L2ff2jG4PFKGlX5Rv4=;
 b=ITxL62WJE2le7ow7DAHPf3Swn1JUL4/BGv27O8sR/WNh6sdD61D19vejc5hMjCKNxqKr4N
 6ZbeaKWoPMsREV31A5D+YTI7Cqi8doel11zoQD+jk2KpHQRTEh7CbADwgfS8CLkwtiAoqg
 nF5E5tpVkhpDY0juyIHFkOg+FmfOQgQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-uqJczrtAPI2Wv7T9tP6PYA-1; Tue, 17 Sep 2024 07:24:03 -0400
X-MC-Unique: uqJczrtAPI2Wv7T9tP6PYA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a8a8308cceaso632713066b.0
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 04:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726572242; x=1727177042;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+Keu6x5euSv1fM+EoTYwh4hu8L2ff2jG4PFKGlX5Rv4=;
 b=SVwFdKs+HNnHDzfYK9B/QyJ0aDgqvGDU7+ar8QuNrd7syeZmfnqIHnyjuB0nZvDJz2
 YskBj4FNqAr1qROXYhpP9tl/Lwks/ml6AOSPuIpSCQvC2fmkT3jXSlJkKR2AdRwUsW8j
 apxI67SRSl270WmfK+KPrDdtP40Hf11M5zhVen/0QbUiOqNA5l0Uhb3C9JM8CJxGb4PX
 h3Y9ZAYa2OusZTcJ5u8QxvYszbtzvJaW/bj3ffDi1Kagb+8vqGmsLo0iQyja/+nNSZjr
 DRgRtunXjUoqwlTrcp/EN7182F6hslBbaijZBQsqTVfbZ5e/KapEAAvaN6y0VkZ7iTsh
 rdUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJF0PCo7VrY+l9ARHfoRwHvm/SNSsmidD09IMmnEytEdhGDDFpiQL3v637cQMo3Tbf1Rhe1nTHVcQJ@nongnu.org
X-Gm-Message-State: AOJu0YwMiPsIHLszoUOgxruiuIdMXWKaY/YG7DlaP/hZ9+1Nbr+xNHB5
 iUy3Np32sjQqmQVZPH9t2zxeJUO9XGpK5qwUm/2e8HsGKTw1KoEyhQBMqnnf6Phk8vl0xOEdoBc
 pMtb2JFcoHANmRLzx4IfMGlR7l20B4xzdNMuYkl7YcUsEIGmCnJnv
X-Received: by 2002:a17:907:7b8d:b0:a8d:65f4:c7c6 with SMTP id
 a640c23a62f3a-a8ffae00183mr2591825766b.24.1726572241894; 
 Tue, 17 Sep 2024 04:24:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM3jVnE/0cmsQLAwDxcFCErBjetqjt6fhftWFfU/nLloS/nxX8lmBJ9kWM5aRhCGev+gpKTw==
X-Received: by 2002:a17:907:7b8d:b0:a8d:65f4:c7c6 with SMTP id
 a640c23a62f3a-a8ffae00183mr2591821066b.24.1726572241366; 
 Tue, 17 Sep 2024 04:24:01 -0700 (PDT)
Received: from [192.168.55.136] (tmo-067-108.customers.d1-online.com.
 [80.187.67.108]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9061331921sm429313366b.223.2024.09.17.04.24.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2024 04:24:00 -0700 (PDT)
Message-ID: <e91fa726-2a72-486a-a687-ec3a29100cc0@redhat.com>
Date: Tue, 17 Sep 2024 13:23:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/14] s390x: introduce s390_get_memory_limit()
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <20240910175809.2135596-7-david@redhat.com>
 <a2cb5304c1bf326455030f7d370155ecba3cd7d2.camel@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a2cb5304c1bf326455030f7d370155ecba3cd7d2.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16.09.24 15:20, Nina Schoetterl-Glausch wrote:
> On Tue, 2024-09-10 at 19:58 +0200, David Hildenbrand wrote:
>> Let's add s390_get_memory_limit(), to query what has been successfully
>> set via s390_set_memory_limit(). Allow setting the limit only once.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> 
> Comment below.
>> ---
>>   target/s390x/cpu-sysemu.c | 19 +++++++++++++++++--
>>   target/s390x/cpu.h        |  1 +
>>   2 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/s390x/cpu-sysemu.c b/target/s390x/cpu-sysemu.c
>> index 1cd30c1d84..1915567b3a 100644
>> --- a/target/s390x/cpu-sysemu.c
>> +++ b/target/s390x/cpu-sysemu.c
>> @@ -255,12 +255,27 @@ unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
>>       return s390_count_running_cpus();
>>   }
>>   
>> +static uint64_t memory_limit;
>> +
>>   int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit)
>>   {
>> +    int ret = 0;
>> +
>> +    if (memory_limit) {
>> +        return -EBUSY;
>> +    }
>>       if (kvm_enabled()) {
>> -        return kvm_s390_set_mem_limit(new_limit, hw_limit);
>> +        ret = kvm_s390_set_mem_limit(new_limit, hw_limit);
>> +    }
>> +    if (!ret) {
>> +        memory_limit = new_limit;
>>       }
>> -    return 0;
>> +    return ret;
>> +}
>> +
>> +uint64_t s390_get_memory_limit(void)
>> +{
> 
> Might be nice to guard/warn against s390_set_memory_limit not having been called before.
> 

What about the following on top:

diff --git a/target/s390x/cpu-sysemu.c b/target/s390x/cpu-sysemu.c
index 1915567b3a..07cb85103a 100644
--- a/target/s390x/cpu-sysemu.c
+++ b/target/s390x/cpu-sysemu.c
@@ -263,6 +263,8 @@ int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit)
  
      if (memory_limit) {
          return -EBUSY;
+    } else if (!new_limit) {
+        return -EINVAL;
      }
      if (kvm_enabled()) {
          ret = kvm_s390_set_mem_limit(new_limit, hw_limit);
@@ -275,6 +277,8 @@ int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit)
  
  uint64_t s390_get_memory_limit(void)
  {
+    /* We expect to be called after s390_set_memory_limit(). */
+    assert(memory_limit);
      return memory_limit;
  }


-- 
Cheers,

David / dhildenb


