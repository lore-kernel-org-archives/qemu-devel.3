Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36115C87FDA
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 07:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulMcA-0007ZZ-0m; Mon, 11 Aug 2025 03:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ulMc6-0007Yk-8W
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 03:06:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ulMby-0003dN-T4
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 03:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754895982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TdMCxZL7eqQn1EimFSLdGW0XVJTz/mwvEabV8Hpj3E0=;
 b=StHMSt6k1BcNTViGcHjlFj00VX8g3oRm2+QkzTnsvHACdxYP6PaBLx+2yxtf1ZCWE4//vw
 +hVMcCqUdNcZiysyHEFD9MsuKL/jM4Dv9RUUGy8Pqoh/3F6azo+p4vyTpsMFm3hB0wkkU0
 5KUzquDQKE2KeAnRqO160ix3CAT4ou8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-OWNfTFaqOnmnhk4_HDsBrQ-1; Mon, 11 Aug 2025 03:06:21 -0400
X-MC-Unique: OWNfTFaqOnmnhk4_HDsBrQ-1
X-Mimecast-MFC-AGG-ID: OWNfTFaqOnmnhk4_HDsBrQ_1754895980
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3b780da0ab6so2039587f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 00:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754895980; x=1755500780;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TdMCxZL7eqQn1EimFSLdGW0XVJTz/mwvEabV8Hpj3E0=;
 b=rvtfD46LoG9wKOeMlkQwmIlzihtu22hzIbkldIyt6VP/cqSA3W4fLCwDesgvhbV68K
 SPvrtM5vVqyL6h9EGUjfH+QiyB0/ovS4ZAcrWXr3Bv5YwmlkCOaCJfPRa5x82K2YoOGr
 IyLOXPjc7yB8eM/s+VjAqVTXgoQkVl5N732T1uWgZCGs7GTxeFOY4aGbwRwrexm6u0GN
 QVHVQDUfasXU7EwBKCSGnGQs9cZda1WsUbMA6NKqmIkhxDSROL38DiLRiYJGW8R0Rx+v
 9lHmbYTNneMjBDRkluKKsLjRhtvoTzfnNLn+m+eVSGPNrJYqt9PF31uQBBnvWm87pW8m
 OeVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1o0naf2qkx5ikpPjKcy0oPf7v1YTU+vo4YQ/xUFM5Y6Pq0tjIGMFoX+F5rS05XJWDmR5CwbV5oIxu@nongnu.org
X-Gm-Message-State: AOJu0Yx2eBixrByKlhqR7OuD/fLmJIo0AyJng3TImPWmXCKB21JJZWTo
 m3qAjMZaMFo/nay8nNiz/LSUzWWA2Py3qmVJBYMjhqWgU7SPKJeYGCYs0ulpFqfVXoEPjCWxuVN
 +fwgANAAG1BXzIzcts3fWO410hXPNUGem8FLp9U41RDyos64meNpiTtDl
X-Gm-Gg: ASbGncsH7V9J0D7hcdxx38U3vdtTxreuEIndidEd52FhnCldBPzZO9zJZFH6Xr2TiE2
 pSInirKA0HBogSzQ295tVbFWSFg6aTgEg93/oggPaJOaXEj1Aw93nBN8NX/993j+2liZV42wOyI
 XL6JpCUPdA3C75ndoE+V82uP2POy9jHX5G9Zellh+4voN1hIXjOb9CfcLlfHn8xyCADXIdZrHsv
 ziKKhUWNIWIyslI6vFhmFPvDkmsASCvHxKWtciqnW7So2mmJaSgFxy1Fak6s3M4riofc2VlJkSk
 w4l0RDKwwpW2Lh/iuAofk+ykae4jg9RCWv8cKdVhstv6
X-Received: by 2002:a05:6000:1886:b0:3a3:7593:818b with SMTP id
 ffacd0b85a97d-3b900b2e15dmr9338787f8f.21.1754895979682; 
 Mon, 11 Aug 2025 00:06:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXYfrzatD1TrL9MOehcYM+aHU3f9Wegp7baxgpqgG7BLhnSqyfLNSRT1TY93R2JpJC3Ek3Pw==
X-Received: by 2002:a05:6000:1886:b0:3a3:7593:818b with SMTP id
 ffacd0b85a97d-3b900b2e15dmr9338761f8f.21.1754895979241; 
 Mon, 11 Aug 2025 00:06:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.234.144])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3bf970sm39271917f8f.25.2025.08.11.00.06.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 00:06:18 -0700 (PDT)
Message-ID: <c5dabb13-0817-44c2-838a-e89b380a8861@redhat.com>
Date: Mon, 11 Aug 2025 09:06:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] accel/hvf: check exit_request before running the vCPU
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>
Cc: imammedo@redhat.com, peterx@redhat.com
References: <20250808185905.62776-1-pbonzini@redhat.com>
 <20250808185905.62776-3-pbonzini@redhat.com>
 <e3f3a5cc-66aa-4e58-95bf-6f8648bf84ad@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <e3f3a5cc-66aa-4e58-95bf-6f8648bf84ad@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 8/10/25 01:09, Richard Henderson wrote:
> On 8/9/25 04:58, Paolo Bonzini wrote:
>> This is done by all other accelerators, but was missing for
>> Hypervisor.framework.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   target/arm/hvf/hvf.c  | 4 ++++
>>   target/i386/hvf/hvf.c | 4 ++++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index b77db99079e..478bc75fee6 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -1927,6 +1927,10 @@ int hvf_vcpu_exec(CPUState *cpu)
>>       flush_cpu_state(cpu);
>>       bql_unlock();
>> +    /* Corresponding store-release is in cpu_exit. */
>> +    if (qatomic_load_acquire(&cpu->exit_request)) {
>> +        hv_vcpus_exit(&cpu->accel->fd, 1);
>> +    }
>>       r = hv_vcpu_run(cpu->accel->fd);
> 
> This looks odd.
> 
> hv_vcpus_exit: "Forces an immediate exit of a set of vCPUs of the VM".
> 
> But we know for a fact fd isn't running, because that's to start in the 
> next line.  I suppose this must set a flag so that the kernel's 
> hv_vcpu_run exits immediately with CANCELED?
> 
> Does executing of hv_vcpu_run buy us anything else?  Is it less 
> confusing to simply return 0, modulo bql fiddling?
> 
>> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
>> index 8445cadecec..b7c4b849cdf 100644
>> --- a/target/i386/hvf/hvf.c
>> +++ b/target/i386/hvf/hvf.c
>> @@ -749,6 +749,10 @@ int hvf_vcpu_exec(CPUState *cpu)
>>               return EXCP_HLT;
>>           }
>> +        /* Corresponding store-release is in cpu_exit. */
>> +        if (qatomic_load_acquire(&cpu->exit_request)) {
>> +            hv_vcpu_interrupt(&cpu->accel->fd, 1);
>> +        }
>>           hv_return_t r = hv_vcpu_run_until(cpu->accel->fd, 
>> HV_DEADLINE_FOREVER);
>>           assert_hvf_ok(r);
> 
> This, similarly, I guess returns EXCP_INTERRUPT.  Is that better or 
> worse than 0?

The advantage is that you can reuse the code for when another thread 
kicks you out of the execution loop.  For x86, for example, the effects 
of hvf_inject_interrupts() are undone by hv_vcpu_run() + hvf_store_events().

But on second thought this patch is not needed.  The kick is handled 
completely by Apple code and that's where any synchronization must 
happen.  In fact, there should be no need for hvf_kick_vcpu_thread() to 
call cpus_kick_thread() even (though I'd leave it to more HVF-literate 
people like Phil to do that).

Paolo


