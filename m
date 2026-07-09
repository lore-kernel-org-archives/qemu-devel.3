Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975DDC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whl8S-00067W-OI; Thu, 09 Jul 2026 05:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1whl8R-00067M-Hs
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 05:33:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1whl8N-0005Hb-IF
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 05:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783589610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ryfw9TZ2jwkSFUct7aoemZMWyFdznY7n809aUAoTIRQ=;
 b=DIspywBwNgZfTtNm0G7UbGMpWmhjaiQEa/SXbKfLBJFg3ZstuhJlhY2BCltr788dedwhiK
 ZNa1FzT6uqliJ95PyYK2wl+J3iUEIGoUjEpXpmJjRNfgVQEnF0ljGvYZ/AgGdL1sZt5jvh
 0i9g3LX0g5svP9l0L6IIcs+A8J3B2S0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-WrlWlvQONzu0HZpLqk2BXA-1; Thu, 09 Jul 2026 05:33:29 -0400
X-MC-Unique: WrlWlvQONzu0HZpLqk2BXA-1
X-Mimecast-MFC-AGG-ID: WrlWlvQONzu0HZpLqk2BXA_1783589608
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-472c330e555so714339f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 02:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783589608; x=1784194408; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ryfw9TZ2jwkSFUct7aoemZMWyFdznY7n809aUAoTIRQ=;
 b=pXqoHk9Na8yOQHOBDUeoDBnSzl6Zgk5Zm+aRL8V6FktBOc/0yq0+BYptFjM4IBPZAs
 YJZlUhRbYzVOgDmGpOr5Bwrk+7hdFBwKZQo21Xu20iobTQ1UjK7vxpGWC3iX0q7mA2zW
 SZR/Qo0wTUQOxrbhRWO1x2a850o0zzuxR38Zi12aHQNxgBGhZsZ0fYE7mN7RzsD0ybr6
 ad1YOZGUxvmVf1AiULgpRDSxbU/4sfftT/U05OLHvFijpEjpAlRBcVVFtF3eALcXzYek
 cMQcEraDmiS+pCywlgLfIdk2TC49t/Jo8O0I+6kM15iOXhJf2wTmAMaeJ4QPr7Ckk1wu
 DuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783589608; x=1784194408;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ryfw9TZ2jwkSFUct7aoemZMWyFdznY7n809aUAoTIRQ=;
 b=bpecEh0jedewWlm5SJFMexZ4QR6F0mFr3H1wEfAwCJsCYP4h7G698NfC1uZAeIxB5a
 oKeBP12b+kKTLe0q9r1+tQeLnFneEqRwlqORkvHcaa6jgCeVoF6EATdWVVaMZu7CHfoT
 Eaygq9E0Xi3jvMDAurq1+kWYCB8pzzR7+0xLxZjV/VRXEJtSNCJvlWi9X21P5XJOhkC6
 2vmwWCyEJuEu0HRa1iNA8r6KUU+KUgv4UVVfT2hHOf3VkqFaM1FGeaA9LJJ0hE0k9/L8
 q7FKUmlclFYgsJ2HP7CWSdcKRL7QwPq7qEFRPRJ1yfYu7jm6J6+NNz0aCeXaOzmSwFdk
 gchQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLdEvjxrgu0iyoWIFfrs20JTPxFC13aTo0G6KZwUzEwZb3w6wXQ5iR9Y+TlsGiBjzClLkVohRUkzpD@nongnu.org
X-Gm-Message-State: AOJu0YyoB91ydpN7FvWgCyvxegdaZABJTgJvquq0mxsJa9+DyukXwalG
 71doDu4wTlGP6mEiAnqUSAj0c5fGZA1kcBCjjk0apsytdgI/DuHYdVvhoEZOk00hHKd/jUnvVPC
 TOrv15P234Kd8sGFf7hfhjahRDNGGdDpt9KGTGEteLpH4aj4pH9rsy2vw
X-Gm-Gg: AfdE7ck+3BLGg/XmpVkK3fNwpUiRvPRZPrDmYH5q3GUJ61Ec3ntIylFua0VB5IaBLfZ
 UQO6lcX/TR9bDmwRMVwh3uu9amFWwggROUi+6xiMlNw0i0dDVwQHIksIPoCYhKGyyd5m+xXyRNH
 k0IJZEjCmWMKWKF/z7IE6iVrnEB3Lw30ysqlX8l7m8N+BWHTxHBArzQTYqOoe32gE0iTA2YHRVZ
 kxjB5PtuilLW1ui9/1KQRXBqSc4NE44Ra/9v8Op9al9gmOG87qKx+cOn8O2YF9It7s8cpAsAtgm
 itoI7qPX+jLfm46X8ylvIl5YUlL6vBldG/c91HoYeJ36j29FS0uj7oQH3ewn9rjlO1iIPKIf8A1
 QdJ35+Ljj
X-Received: by 2002:a05:600c:8119:b0:493:bed6:85e6 with SMTP id
 5b1f17b1804b1-493e686ad9bmr61139735e9.15.1783589607665; 
 Thu, 09 Jul 2026 02:33:27 -0700 (PDT)
X-Received: by 2002:a05:600c:8119:b0:493:bed6:85e6 with SMTP id
 5b1f17b1804b1-493e686ad9bmr61139445e9.15.1783589607290; 
 Thu, 09 Jul 2026 02:33:27 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.244])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ee2bcac0sm29192285e9.0.2026.07.09.02.33.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 02:33:26 -0700 (PDT)
Message-ID: <0c00bf25-b03d-4b4e-a642-01f55fca7f96@redhat.com>
Date: Thu, 9 Jul 2026 11:33:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/loongarch_dintc: Fix OOB access in DINT MMIO
 write handler
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 qemu-devel@nongnu.org
Cc: berrange@redhat.com, lixianglai@loongson.cn
References: <20260701065454.1976188-1-gaosong@loongson.cn>
 <2b0109e5-6495-8295-564b-fb057fbce108@loongson.cn>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <2b0109e5-6495-8295-564b-fb057fbce108@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 09/07/2026 11.08, Bibo Mao wrote:
> 
> 
> On 2026/7/1 下午2:54, Song Gao wrote:
>> Validate guest-controlled cpu_num before using it to index the cpu[] array
>> or pass to async_run_on_cpu(). Without this check, a malicious guest can
>> trigger a NULL pointer dereference in async_run_on_cpu() and an
>> out-of-bounds array access in qemu_set_irq(), causing host crash.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3616
>> Fixes: 0d148eaf5a3e ("hw/loongarch: Implement dintc set irq")
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   hw/intc/loongarch_dintc.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/hw/intc/loongarch_dintc.c b/hw/intc/loongarch_dintc.c
>> index c877a8003b..e40292887c 100644
>> --- a/hw/intc/loongarch_dintc.c
>> +++ b/hw/intc/loongarch_dintc.c
>> @@ -19,6 +19,7 @@
>>   #include "target/loongarch/cpu.h"
>>   #include "qemu/error-report.h"
>>   #include "system/hw_accel.h"
>> +#include "qemu/log.h"
>>   /* msg addr field */
>>   FIELD(MSG_ADDR, IRQ_NUM, 4, 8)
>> @@ -52,7 +53,19 @@ static void loongarch_dintc_mem_write(void *opaque, 
>> hwaddr addr,
>>       CPUState *cs;
>>       cpu_num = FIELD_EX64(msg_addr, MSG_ADDR, CPU_NUM);
>> +
>> +    /* Validate cpu_num against the configured number of CPUs */
>> +    if (cpu_num >= s->num_cpu) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "loongarch-dintc: invalid cpu number%d\n", cpu_num);
>> +        return;
>> +    }
> Here cpu_num decoded from MSG_ADDR is physical CPU ID, I think that it is 
> not meaningful to compare it with s->num_cpu.

Later in this function, cpu_num is used to index into the s->cpu[] array:

     qemu_set_irq(s->cpu[cpu_num].parent_irq, 1);

and s->cpu is allocated like this in the realize function:

     s->num_cpu = id_list->len;
     s->cpu = g_new(DINTCCore, s->num_cpu);

So the new check here looks valid for me, at least right now. Or what else 
would you suggest here?

  Thomas


>>       cs = cpu_by_arch_id(cpu_num);
> This is ok to use cpu_by_arch_id now, in later when CPU hotplug is support 
> with dintc, there should be self CPU search logic like ipi irqchip.
> 
> Regards
> Bibo Mao
>> +    if (!cs) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "loongarch-dintc: no CPU for arch_id %d\n", cpu_num);
>> +        return;
>> +    }
>>       irq_num = FIELD_EX64(msg_addr, MSG_ADDR, IRQ_NUM);
>>       async_run_on_cpu(cs, do_set_vcpu_dintc_irq,
>>
> 


