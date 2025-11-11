Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F60CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 04:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIfjG-0004Qe-9a; Mon, 10 Nov 2025 23:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vIfh1-0001yD-G7
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 23:09:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vIfgz-0000P5-Us
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 23:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762834157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SzXhYlHXujNxUnW1WIoZlma35wUBWrfLZEYpSxKCIMs=;
 b=YGOb0DVL3wMJk7J+N3mMM/qCVXUEBz+izQ9eT0clna9HKWBnyuxGDquB8DlUNt0UD5TJJW
 Yjs7gllQHchnVRAniqAKUuZG0eSZLxnxeAYUTSdLFV5KRTrZrplp80j/mJBTROt5erZffD
 2SOlZX0OIoMitqQgGeLaFvDaLFuuNjA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-NoD2QWg-O8qoBbtU1BdcGw-1; Mon, 10 Nov 2025 23:09:13 -0500
X-MC-Unique: NoD2QWg-O8qoBbtU1BdcGw-1
X-Mimecast-MFC-AGG-ID: NoD2QWg-O8qoBbtU1BdcGw_1762834153
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3436e9e3569so6412987a91.2
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 20:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762834153; x=1763438953; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SzXhYlHXujNxUnW1WIoZlma35wUBWrfLZEYpSxKCIMs=;
 b=ldDJAtEdx3rP6crvHJvg3LH7nv0G0AXxLd3zRXHB7uWy62qQM006ZFriVCOnWLe/ct
 zV4qrI6T7iJKIOLMCeQU7MdAiJzwoNvrSqGHlqhw9ahq/kktiFBQprAhxMbRJcsa7bfZ
 T3MtJrkJdzDuY2YYEid13JTPWMUy/yhcxGbY6gC98KFqtqG8btLRSpMUeGDPlwuFqVVt
 1Z7IF0/gjpNqe7hzads2kkEnQmTi5TmqFcLiYW0TcCfkiBP6xmkBY6v9aJT1yvspBa0h
 vHnA3Px7d6bhCsrW2y6MdwarVfEtjGglZQXArcONHIBbpYSUN9dLqj9g79hH6a/8BFpA
 nrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762834153; x=1763438953;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SzXhYlHXujNxUnW1WIoZlma35wUBWrfLZEYpSxKCIMs=;
 b=FhiNwKAUXEpirnj0lrzY+QzKqj1XPBYKRFgNtvHbUHseNWkcFkbl2kehQp8iE+VGdg
 OK7VP9/8MNlVn1usapvgQfB2LOSmSiCzUJijhBdhzmI0gsENtp/nKQ6NVtj70UYbNEsy
 TElUT3Y5jKU84cJI9Wb/EJVE0s84/ynb5/j75G3Y678AQWp7akrPkzGsovpS9HJXiwK1
 abKqLtkN8PtKncbpjC85/1XQyDxyNw55YMTBtd7C2eC7Rc7lsGyECQZWVAUqpJiVICMf
 H3EnaZOuRfZbZI2o8b5iie4Lmswiu9T+38iw2VNvX7hDveZ1p/N9FarI4914Ba3/b1eH
 kCmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWssJSikt8DMGhezxX8L9z7ALvf5fCk6FWQI8KiofTgnMqE6Xf3MHhVPxhBu7lhN+kkGlj2JnGkzt6C@nongnu.org
X-Gm-Message-State: AOJu0Yz6nW7Z1/ISFJlb+HhBgaS0Ne1ownm0KkkY2NCgNPMbuPVFpqke
 NWv8Kh9o1+2wOFWYT0w7HYDBcWLwbyOIMgiaEcUkKNxmyKUkApEEZomLl+CqilJfXYS7nElptN5
 BnpIKzE9gZNPmceXPOusKjPpvA7fPQerTUXOS1aQcs7uLAtRLkG/g9jSJ
X-Gm-Gg: ASbGncs79jV8gjMxuX/qVJ7F/rBX6W4fBwokMm/Ury51VUQLoqwwLH+pOyQ/dISFqkP
 aKkpsIFrlt99xgPcSkuwxz2mszlkmmJFdkk5MLR4gG3F6w3Forkxz9XB2bMuIO6yn9wJqUKBygm
 0P9fIa3eDYfXdd+dUgupzxxBuO7yT7Xw06ZnCoVtXcPgzsdpWnYWypVoUlIPx2cCePtka79X936
 gdsTtQf3h2gkHLZYzDdy5cDC3ie4sObIzYWczh2duaUV+HULkdmfz9YWmgEizPMaGSG5sLu2FGN
 eHdz5Y7RexlIFxh0w3lAmNUyhk3B8VA2OZFwbN+WhZWNqYngMIL51TTH5C1tBlw5TFA7f76HqU7
 lJzko5wlhnt24qv4IpM0xabEy92G+Wxeh0Q8Jxqs=
X-Received: by 2002:a17:902:c952:b0:295:21ac:352b with SMTP id
 d9443c01a7336-297e560ec1cmr135488885ad.15.1762834152796; 
 Mon, 10 Nov 2025 20:09:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtQE+rkcfJ31HVUsDH0lTUIt0v98+uT+XI1dMKxvvN7FT2lbHIraCe6DMiVgRhocfnLSKzIw==
X-Received: by 2002:a17:902:c952:b0:295:21ac:352b with SMTP id
 d9443c01a7336-297e560ec1cmr135488635ad.15.1762834152446; 
 Mon, 10 Nov 2025 20:09:12 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2965096b8ffsm162681055ad.21.2025.11.10.20.09.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 20:09:12 -0800 (PST)
Message-ID: <90d9eab2-a144-430d-ad4a-6764ad08344e@redhat.com>
Date: Tue, 11 Nov 2025 14:09:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] kvm/arm/kvm: Introduce helper
 push_ghes_memory_errors()
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 anisinha@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com,
 shan.gavin@gmail.com
References: <20251105114453.2164073-1-gshan@redhat.com>
 <20251105114453.2164073-8-gshan@redhat.com> <20251110155642.2bf8eca0@fedora>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251110155642.2bf8eca0@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Igor,

On 11/11/25 12:56 AM, Igor Mammedov wrote:
> On Wed,  5 Nov 2025 21:44:52 +1000
> Gavin Shan <gshan@redhat.com> wrote:
> 
>> Introduce helper push_ghes_memory_errors(), which sends ACPI GHES memory
>> errors and injects SEA exception. With this, we can add more logics to
>> the function to support multiple ACPI GHES memory errors in the next
>> path.
>>
>> No functional changes intended.
> 
> I'd squash it into the next patch
> 

Ack.

>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   target/arm/kvm.c | 19 +++++++++++++------
>>   1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index a889315606..5b151eda3c 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -2429,12 +2429,23 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
>>       return ret;
>>   }
>>   
>> +static void push_ghes_memory_errors(CPUState *c, AcpiGhesState *ags,
>> +                                    uint64_t paddr, Error **errp)
>> +{
>> +    uint64_t addresses[16];
>> +
>> +    addresses[0] = paddr;
>> +
>> +    kvm_cpu_synchronize_state(c);
>> +    acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC, addresses, 1, errp);
>> +    kvm_inject_arm_sea(c);
>> +}
>> +
>>   void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>   {
>>       ram_addr_t ram_addr;
>>       hwaddr paddr;
>>       AcpiGhesState *ags;
>> -    uint64_t addresses[16];
>>   
>>       assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
>>   
>> @@ -2455,12 +2466,8 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>                * later from the main thread, so doing the injection of
>>                * the error would be more complicated.
>>                */
>> -            addresses[0] = paddr;
>>               if (code == BUS_MCEERR_AR) {
>> -                kvm_cpu_synchronize_state(c);
>> -                acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
>> -                                        addresses, 1, &error_abort);
>> -                kvm_inject_arm_sea(c);
>> +                push_ghes_memory_errors(c, ags, paddr, &error_abort);
>>               }
>>               return;
>>           }
> 

Thanks,
Gavin


