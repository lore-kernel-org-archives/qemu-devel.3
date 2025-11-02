Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046C6CCF9E3
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Nov 2025 23:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFhbk-0003dB-V5; Sun, 02 Nov 2025 18:35:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vFhbj-0003ch-Jm
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 18:35:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vFhbh-0000DZ-9T
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 18:35:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762126530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tz2PMP+lz7aSaGrHSeGWvnQdh2x/UuV2hRpx5VAZWo4=;
 b=LA/7YkcMweC/J0LmLkl8kU8j5KyEagKry9REgZmYRm5Ph0ksEf6tMvNBON/wyYmBiqT/BX
 R9TMhG4L766u4/jxAlSmJN62NbUX9JICtTyG4osWrsHhA0/pqbbYr9QGR6h2I8/SKm9nAJ
 JzTNE0VUhyNVRKlU2O3TLE33ariiX/E=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-NQ6XCwbrPhC2EFmdWyT7vg-1; Sun, 02 Nov 2025 18:35:28 -0500
X-MC-Unique: NQ6XCwbrPhC2EFmdWyT7vg-1
X-Mimecast-MFC-AGG-ID: NQ6XCwbrPhC2EFmdWyT7vg_1762126528
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b6ce1b57b9cso3459295a12.1
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 15:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762126528; x=1762731328; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tz2PMP+lz7aSaGrHSeGWvnQdh2x/UuV2hRpx5VAZWo4=;
 b=fzXTuU6cBigWI3O7+9VeSmLGALF6qVTcVqV56SSWe0kW/tkJFq5HNkWhTadm8KsO2M
 HTcNwmNgKXvDFWUBfaR+0C428m2Jsj5v+iA9WwTmZqyPtETnKSDTjuXAJ6xS6uRJgiXk
 Z+LqnjYsZhalHTRBjUdc79GyMxuhteSeY4yprPVleYEU8acsJm8TImwWuBy8dX+nMdXd
 xSoJB8ckTixydC9m+cEj0fvRjfyaa4grwOqVj0f2CzrEy5D9GaIp8kC5hBmcxSEY8Swa
 vJJ1kBLiOI0TXiPInAPr+TdJUqVjsrd4YPFJn1n9rFMLDEL9XS/5cgh8DHpHzKQL82VP
 Hvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762126528; x=1762731328;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tz2PMP+lz7aSaGrHSeGWvnQdh2x/UuV2hRpx5VAZWo4=;
 b=UQfZW1jUdTZZj4TZIDaQnUsPD0JGgtJ1KLKrEvqAZ4Xhbvoe2FCDtLM4pt9qwCqOd9
 EA0nuWLIulC7homzPSTTVyb+BLYOiBeRMcKYd9fxaYo+nsrxWabjLznu8fPcJaJXpqZ/
 iMGjid/XjKs5l8Iw3bKMh7mvGEpXeuOxR9n+mBlUGM63kzlErvmciBm/558m8SklfeIx
 UdialWtPsSY0af9yDyoKWAPHnGlU7w5yUedg8Y2Q8k1c8j6YekZdFl64XxrwnaU9wuU9
 3/afgdO15QMcaQu8w35fJWpOISUGG/82cwWshYDQBDyRbIVHh6pLwSxy7BGieL/MGh3i
 0rzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW43PrwOKB+bD2OyHlNUP6XG28h/WX1/GLTeLU4l+ZNzv7YEPjMAUmHK1BNumfKa/nf8chR8KQnJLS@nongnu.org
X-Gm-Message-State: AOJu0Yya3cO7LE5GSbhysaRuRXoXWBsuusw2Wjdrxv9+X5RaqvYqXI2a
 hJjfErqbKJdsIj+9etLbwvhrZpigzgbI+s6JVE3pTPoHmBFXPL1efZGbvOwIuiayHKKDyVEab/D
 9w/eYmFiiywWa9j3rst4IQRv8GhVcHIpA6y4C0JtqwLOotU5XPw6yV7nB
X-Gm-Gg: ASbGncsmrBeqebMfd7ERKHQ/+ftLtykxdcr6aCYeFPpbnjlCUPlZ0s6G+Mkt8IA80dR
 necUy6xy6JFkgxC9S17P4B83W2nnvr3DwfwjC2qBUL/CSJW7XMRyaU8hBQsXdf9Kb8ZZ6Ke8Ply
 JJnNCIYwkyGAY3XPKg554qIsMeTNiJ+UaxiLUjNnvjz3JPvbRJsa8Une2GsDR7tqnSoIzgdfevY
 t7P57pnQvUKJBNJYFU/ixIZotZBywdtHUBYDst1GIPgL8hKzqq6taz3QJVcJWpeDVDsr61RWgqT
 Igfo1T4mYrtHyuQtfd3T/dH5ij0WD7bhCn2p1/ktV1jBjKUHti7rekY3LnPEiepQjZ3c/vNa1fa
 1BExF+re4FKp88JDeGdvno/80ErLojsiRoUlcIzw=
X-Received: by 2002:a17:902:cec7:b0:295:5668:2f27 with SMTP id
 d9443c01a7336-295566831dbmr78672025ad.9.1762126527833; 
 Sun, 02 Nov 2025 15:35:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBSqVSs7J8rf43lx8BnWbpvo3pP6s3xQ8DuaI1xDLz6cp1UOa55JFE78YSTn2/+khL9nSPyQ==
X-Received: by 2002:a17:902:cec7:b0:295:5668:2f27 with SMTP id
 d9443c01a7336-295566831dbmr78671815ad.9.1762126527463; 
 Sun, 02 Nov 2025 15:35:27 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29558f51f73sm59901965ad.32.2025.11.02.15.35.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Nov 2025 15:35:26 -0800 (PST)
Message-ID: <ea88cf53-c6c6-4ff2-b1fb-2e2d01841630@redhat.com>
Date: Mon, 3 Nov 2025 09:35:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 2/3] kvm/arm/kvm: Introduce helper
 push_ghes_memory_errors()
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, mchehab+huawei@kernel.org, Jonathan.Cameron@huawei.com,
 shan.gavin@gmail.com
References: <20251007060810.258536-1-gshan@redhat.com>
 <20251007060810.258536-3-gshan@redhat.com> <20251031142543.0c7d384f@fedora>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251031142543.0c7d384f@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/31/25 11:25 PM, Igor Mammedov wrote:
> On Tue,  7 Oct 2025 16:08:09 +1000
> Gavin Shan <gshan@redhat.com> wrote:
> 
>> Introduce helper push_ghes_memory_errors(), which sends ACPI GHES memory
>> errors, injects SEA exception or aborts on errors. This function will
>> be extended to support multiple ACPI GHES memory errors in the next
>> path.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   target/arm/kvm.c | 36 ++++++++++++++++++++++++------------
>>   1 file changed, 24 insertions(+), 12 deletions(-)
>>
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 9a47ac9e3a..c5d5b3b16e 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -2429,12 +2429,34 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
>>       return ret;
>>   }
>>   
>> +static void push_ghes_memory_errors(CPUState *c, AcpiGhesState *ags,
>> +                                    uint64_t paddr)
>> +{
>> +    GArray *addresses = g_array_new(false, false, sizeof(paddr));
>> +    int ret;
>> +
>> +    kvm_cpu_synchronize_state(c);
>> +    g_array_append_vals(addresses, &paddr, 1);
>> +    ret = acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC, addresses);
>> +    if (ret) {
>> +        goto error;
> 
> perhaps use &error_abort and use it right here instead of goto
> or even more cleaner: pass  &error_abort as arg to acpi_ghes_memory_errors()
> and drop not needed 'if's & return value
> 

Right, the second way looks cleaner with the assumption that abort is expected
on any errors in this call path. I will clean it up in next respin.

Note the error handling in acpi_ghes_memory_errors() seems already problematic.

acpi_ghes_memory_errors                   // Declare errp
   ghes_record_cper_errors
     ghes_record_cper_errors               // error is initialized by error_setg
     error_setg                            // !read_ack_register

>> +    }
>> +
>> +    kvm_inject_arm_sea(c);
>> +
>> +    g_array_free(addresses, true);
>> +
>> +    return;
>> +error:
>> +    error_report("failed to record the error");
>> +    abort();
>> +}
>> +
>>   void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>   {
>>       ram_addr_t ram_addr;
>>       hwaddr paddr;
>>       AcpiGhesState *ags;
>> -    GArray *addresses;
>>   
>>       assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
>>   
>> @@ -2443,7 +2465,6 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>           ram_addr = qemu_ram_addr_from_host(addr);
>>           if (ram_addr != RAM_ADDR_INVALID &&
>>               kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
>> -            addresses = g_array_new(false, false, sizeof(paddr));
>>               kvm_hwpoison_page_add(ram_addr);
>>               /*
>>                * If this is a BUS_MCEERR_AR, we know we have been called
>> @@ -2456,19 +2477,10 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>                * later from the main thread, so doing the injection of
>>                * the error would be more complicated.
>>                */
>> -            g_array_append_vals(addresses, &paddr, 1);
>>               if (code == BUS_MCEERR_AR) {
>> -                kvm_cpu_synchronize_state(c);
>> -                if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
>> -                                             addresses)) {
>> -                    kvm_inject_arm_sea(c);
>> -                } else {
>> -                    error_report("failed to record the error");
>> -                    abort();
>> -                }
>> +                push_ghes_memory_errors(c, ags, paddr);
>>               }
>>   
>> -            g_array_free(addresses, true);
>>               return;
>>           }
>>           if (code == BUS_MCEERR_AO) {

Thanks,
Gavin


