Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE81CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 15:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqvJG-0003Nk-Hx; Tue, 26 Aug 2025 11:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqvJ4-0003Iz-2w
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 11:09:55 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqvIo-00037n-7t
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 11:09:51 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3c79f0a5c5fso2322713f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 08:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756220969; x=1756825769; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3F7DoM0/fqRai79lV3YnsGXtEm0VO5nUf8bvvVOY8xQ=;
 b=seGNfVYgQiMFN8mLULXcmI8COCtOou609r3Z1tAEAsOFKjeyu9XkcoqNERZeC9Yk43
 SOtiG+/tW6DIlJCsuVa1Co+UliutGsYOtv28bYNujiiViJVbrhpx4+ys+E/eWMwjMOMB
 SwtVuIsvv1bxR8nwchIqfk3vzCahjJS8yZ40pkEF6cwyc3nA6mUpvVrbwtszylL+tgx7
 Amkrh4AAnCxHphmOdj3zrP+KkDhwPZCwCCRqeWI5EuYRsy8pccR47CnOMuVKsjmxSTrM
 /kslLk2RhSjIHT9ORLwdRB19K9nb9uwPXhTQ9T2zTBDvQXDBzveiijDGnq8yltnMhbc7
 qowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756220969; x=1756825769;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3F7DoM0/fqRai79lV3YnsGXtEm0VO5nUf8bvvVOY8xQ=;
 b=h86EX0b0zmnzQsf46rr6d13CoqwWya2Yr5aiACABowvaFJVaEdQptLipLWDf/4N/T+
 w1NKJFd+dBWGgRASdv1fRV5/iNIUkxQm2+O1epJ6FFUZMjySjAHJEPNkaZkRsB/gRhzX
 XCULTs/t/DigxLdnvI+DdWK/r72yYR8IyVjy2pucmBaxIL+oIeVkV9sHQELEhNMugEuV
 WzY/eqURDZinkFufMsINm7E2VQdVGiFeOpRa1t2pnnBzRirOtyZBPvn4NurFtaIXXFeq
 0lZM65uvHssaZbVQjjLH/XN4cFnhHFtYlJIqhlbcv2mRAW71HYUdc8Bj+uL92XutUL71
 lKtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNHe+QzYzd0E3vxjepDXPQzTCY2/WnZMttIQLdd1/7vAEY5aDkAwMtWvFmO/yN2YLBEbyrbERU4J0C@nongnu.org
X-Gm-Message-State: AOJu0YwnimyU/9AKnSWEHWC1xbsvuW7+vYKtaEtqoZ9s/heWiGf9R0PT
 IYm2rujBA1HEHV++ww9ybq5N9BGcK6PaY2UE5ok7JoJSbK6uhSYgoh0ctfolNmggSKU=
X-Gm-Gg: ASbGncviXlVgVGK96VmaxJlSRhQirSG4DWv5sP6gkyPyhRDUewu0u6kaD6NZXeaFX53
 qZxEFPu+y/dYfFrcVBnJb59Agq2orS3Az+P+Ho5WIFpvMsAtk4Fvx3lpPCqJtw8g64wnjnGTGng
 9BKn9aGnvMDrbE9g8UTG4MSJ9zPE5IwZgmbb8A4wUZRwEuD9YlrOJM/SvfhqmM3qweMI9xvCTUU
 LAxfIt5jw7dk5WyyovQhKQ1NomVoPZKjo9pJspmcZkUsEQSWO+gfN0lINwX0DwOk79+fLmUpH/7
 QZ9mki5DgkU6poJNfWFotQ8NApQh+F2x7ao9sh9wOe910znpHJXTsp38gV/7n3O71yx0V/ye1XU
 EvTQZxAYndB0dbePuTBOVaofjmrlzDtA+ssLVBldCJhYCYr4Vxx5FkjbRtwarRZaToQ==
X-Google-Smtp-Source: AGHT+IGYKR71Mtn2F/27lVlxolmy51OwGQw49l2ku8pGm1iAjfhN/g7yA5mkqA2E7d9Kx4XtY1GiDA==
X-Received: by 2002:a05:6000:1881:b0:3c9:24f5:470c with SMTP id
 ffacd0b85a97d-3c924f54bfemr6994519f8f.42.1756220968895; 
 Tue, 26 Aug 2025 08:09:28 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70f14372fsm16510243f8f.28.2025.08.26.08.09.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Aug 2025 08:09:28 -0700 (PDT)
Message-ID: <d109215c-2b3c-46e4-9fb2-49fe70076a5c@linaro.org>
Date: Tue, 26 Aug 2025 17:09:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kvm/kvm-all: make kvm_park/unpark_vcpu local to
 kvm-all.c
To: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, richard.henderson@linaro.org,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20250815065445.8978-1-anisinha@redhat.com>
 <20250826132322.7571b918@fedora>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250826132322.7571b918@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 26/8/25 13:23, Igor Mammedov wrote:
> On Fri, 15 Aug 2025 12:24:45 +0530
> Ani Sinha <anisinha@redhat.com> wrote:
> 
>> kvm_park_vcpu() and kvm_unpark_vcpu() is only used in kvm-all.c. Declare it
>> static, remove it from common header file and make it local to kvm-all.c
>>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> 
> Reviewed-by: Ani Sinha <anisinha@redhat.com>

Do you mean Igor Mammedov <imammedo@redhat.com>?

> 
>> ---
>>   accel/kvm/kvm-all.c  |  4 ++--
>>   include/system/kvm.h | 17 -----------------
>>   2 files changed, 2 insertions(+), 19 deletions(-)
>>
>> changelog:
>> unexport  kvm_unpark_vcpu() as well and remove unnecessary forward
>> declarations.
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 890d5ea9f8..f36dfe3349 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -414,7 +414,7 @@ err:
>>       return ret;
>>   }
>>   
>> -void kvm_park_vcpu(CPUState *cpu)
>> +static void kvm_park_vcpu(CPUState *cpu)
>>   {
>>       struct KVMParkedVcpu *vcpu;
>>   
>> @@ -426,7 +426,7 @@ void kvm_park_vcpu(CPUState *cpu)
>>       QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
>>   }
>>   
>> -int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id)
>> +static int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id)
>>   {
>>       struct KVMParkedVcpu *cpu;
>>       int kvm_fd = -ENOENT;
>> diff --git a/include/system/kvm.h b/include/system/kvm.h
>> index 3c7d314736..4fc09e3891 100644
>> --- a/include/system/kvm.h
>> +++ b/include/system/kvm.h
>> @@ -317,23 +317,6 @@ int kvm_create_device(KVMState *s, uint64_t type, bool test);
>>    */
>>   bool kvm_device_supported(int vmfd, uint64_t type);
>>   
>> -/**
>> - * kvm_park_vcpu - Park QEMU KVM vCPU context
>> - * @cpu: QOM CPUState object for which QEMU KVM vCPU context has to be parked.
>> - *
>> - * @returns: none
>> - */
>> -void kvm_park_vcpu(CPUState *cpu);
>> -
>> -/**
>> - * kvm_unpark_vcpu - unpark QEMU KVM vCPU context
>> - * @s: KVM State
>> - * @vcpu_id: Architecture vCPU ID of the parked vCPU
>> - *
>> - * @returns: KVM fd
>> - */
>> -int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id);
>> -
>>   /**
>>    * kvm_create_and_park_vcpu - Create and park a KVM vCPU
>>    * @cpu: QOM CPUState object for which KVM vCPU has to be created and parked.
> 
> 


