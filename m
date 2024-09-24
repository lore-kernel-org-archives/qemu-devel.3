Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61DDCF9C69
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 20:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stByu-0003V3-Ov; Tue, 24 Sep 2024 16:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1stByt-0003T1-BX
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 16:17:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1stByr-0002gH-PR
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 16:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727209072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4Baxu8/kFI1cUAsQEGFmCuuknuPGb+SGsANa+tcheBo=;
 b=ck3G/L+64xb4TTid2I/AsVAe/YtFlzRNJlAThyYvp9LFKYg7CHAKKmZ4tU/AwZLlgp+5+a
 jPIigm2QvPfVJSiR866EdEdXNimd2YZrqbGiTqqFC3776WMUiOOVKBW221r3nfSph15O5E
 7b2MVR2fc+QefDa9+KTc8iZv/PvpDfg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-FYuN5P11O7y_JG1GlSiQaQ-1; Tue, 24 Sep 2024 16:17:49 -0400
X-MC-Unique: FYuN5P11O7y_JG1GlSiQaQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb08ed3a6so880555e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 13:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727209068; x=1727813868;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Baxu8/kFI1cUAsQEGFmCuuknuPGb+SGsANa+tcheBo=;
 b=pJmspPe/3u+1oYaiqYHQfm6fnH10FVeJn/fE5bALoSvuQ7C7oFhsgUkgOihXZjChcj
 ZDsLyjuOVsSOOrxWK6DJnp9Z6m2ez4ydolMtIgOqn5o4B0ibW+ge11k1hP2FIqN3nsbA
 pNVIecyXDx8tm3PkhtvfkYop2qhptDk61KM1MHA3kjg7F44QhszYeeQBmeHl2xH+ivHd
 Z53+chyUB0Mq/3vieXBJzIKxmszW5w+UYhzGRAl8sWR9dwHGYLmmFQ/m35+EkgBXX3bs
 iSuPt9TC273EWsw3tT3Biq5Xu/ui24o6R+JyzxOTGDwKo20G8pp8RfNIkvD1rTYY8E3l
 KHdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoo2DBruL0wBk8EDtL74o3sbOfI4BVPVcwq0ut95kLxKBwCmarvQWV/bi7pcwM4bUkDBrZIbI7i2Ch@nongnu.org
X-Gm-Message-State: AOJu0Yz3X0MajCzuRFxX/r+QNexcboCXkKl9E/DTZHrRmjLcbM5Xh9ZC
 G6MpYvU4hNDPd/0AO3j1gzbrDfm/kA1ZREe2HwrI/0jfRJQ9AxNYHfjv4cyELvuh15PfFIZfrk7
 G9zM/+9ULT6qUgT7LWDkKFd6s9PboVu30n5kwk1NXbai9A1V76QFG
X-Received: by 2002:a05:600c:4fc4:b0:42c:ba81:117c with SMTP id
 5b1f17b1804b1-42e95ff4001mr2035435e9.6.1727209068283; 
 Tue, 24 Sep 2024 13:17:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0zL2ZaM3cEMqHyF7Z+qlIGaPY38UFmV8TkzMQyGXrNU4Yx66mGSdqM+0m+fLB+IB+KQpGNQ==
X-Received: by 2002:a05:600c:4fc4:b0:42c:ba81:117c with SMTP id
 5b1f17b1804b1-42e95ff4001mr2035285e9.6.1727209067854; 
 Tue, 24 Sep 2024 13:17:47 -0700 (PDT)
Received: from [10.1.26.69] (ip-185-104-138-71.ptr.icomera.net.
 [185.104.138.71]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e9029ef36sm31657125e9.26.2024.09.24.13.17.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2024 13:17:46 -0700 (PDT)
Message-ID: <72e7a377-60ab-45ed-9136-327fa4dd9e4c@redhat.com>
Date: Tue, 24 Sep 2024 22:17:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/14] s390x/pv: check initial, not maximum RAM size
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <20240910175809.2135596-11-david@redhat.com>
 <c6d51e5a0bd3e222a1fb3354e31bf2edcc3a59d2.camel@linux.ibm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c6d51e5a0bd3e222a1fb3354e31bf2edcc3a59d2.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24.09.24 18:22, Nina Schoetterl-Glausch wrote:
> On Tue, 2024-09-10 at 19:58 +0200, David Hildenbrand wrote:
>> We actually want to check the available RAM, not the maximum RAM size.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Nit below.
>> ---
>>   target/s390x/kvm/pv.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
>> index dde836d21a..424cce75ca 100644
>> --- a/target/s390x/kvm/pv.c
>> +++ b/target/s390x/kvm/pv.c
>> @@ -133,7 +133,7 @@ bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms)
>>        * If the feature is not present or if the VM is not larger than 2 GiB,
>>        * KVM_PV_ASYNC_CLEANUP_PREPARE fill fail; no point in attempting it.
>>        */
>> -    if ((MACHINE(ms)->maxram_size <= 2 * GiB) ||
>> +    if ((MACHINE(ms)->ram_size <= 2 * GiB) ||
>>           !kvm_check_extension(kvm_state, KVM_CAP_S390_PROTECTED_ASYNC_DISABLE)) {
>>           return false;
>>       }
> 
> If I understood the kernel code right, the decision is made wrt
> the size of the gmap address space, which is the same as the
> limit set for the VM. So using s390_get_memory_limit would be
> semantically cleaner.

I wonder if we should just drop the RAM size check. Not convinced the 
slightly faster reboot for such small VMs is really relevant? Makes the 
code more complicated than really necessary.


-- 
Cheers,

David / dhildenb


