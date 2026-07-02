Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A794C43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 06:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfAhG-0004CV-Ll; Thu, 02 Jul 2026 02:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wfAh8-000469-Ec
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 02:14:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wfAh6-0006yQ-JN
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 02:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782972878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0e+A6IJ8GlqWZg43ZGGl4ELT79+D3X0r+2HPToiqUVw=;
 b=LP0+M5p6wELMpfgqiLbT2lTl3X66T7RSmy2vvPwaBnUoEDvh1DbMwg3jFCXqji86668dSX
 A6A2juBSqkJqxtqcBlYZ66DCE2VOoNprcLP+Pwc1gCOoE4gljZ7zhXA8zxc0g1RfaIO5If
 Asfr5swKByAUpfMTppkEi/5+aLdErJ8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-OapMrnwAPtO5gc5l1hfSCg-1; Thu, 02 Jul 2026 02:14:37 -0400
X-MC-Unique: OapMrnwAPtO5gc5l1hfSCg-1
X-Mimecast-MFC-AGG-ID: OapMrnwAPtO5gc5l1hfSCg_1782972876
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493c20d0468so20008785e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 23:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782972876; x=1783577676; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0e+A6IJ8GlqWZg43ZGGl4ELT79+D3X0r+2HPToiqUVw=;
 b=mE8l4JfX5xieU/ouf/Hxu+yBkQCOFw8eODichsiK1hmtdrKiM58pk8KTa1HEn1mL2t
 YT+3wQb1cfgBhBtOsbiXFcpacoWQo4EpbKl3poCz75yE8WWCVWwlU5ysiHP99Y+aHHdd
 65EHfwR2bbZ/HgYnhNCy3k6FOtF3n3EEJ7INj4iyul+it0VJoG9lqpoXW31TKGHqbsyw
 GP4aO4M4/ZdyNzZRw7guJqnL+rWOZfSvr85Uwzi4bm6KffEL3EkVw+ZG/fMsz8XkiB0z
 J9DE1JfOVtOx5laOYFEny4K6AFl8y8hK3u67FJFpNL53lxvcGLyz2VI+GiT1ghjsA+a3
 tD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782972876; x=1783577676;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0e+A6IJ8GlqWZg43ZGGl4ELT79+D3X0r+2HPToiqUVw=;
 b=Bq0EQC95J8okkICU1WPaoXKEXoX6TicvaoU58P0uRnZvvIKS2OieV7ODNht6HjgbTn
 ArhA8OlT2Zo6HlPhsBsyzvKSyZflbqE+cEXWsoVI9TtUqfzpSS5WqW6XSaYqVCh32Pqf
 b+fczhV//VghgHFJsQhDVLHHWtxH5AqBbuqZxPEwzm50LbJiSNAufC3NSwC9IQS1e7G6
 Sbk5Z7STtRcHH56/naiACb5qwhmkeFmWjxCGufB43wjWF5/ZTYlNDla/ZzUuPSVdziYl
 hIuvRqlWlKme1KKcR71G/+2ojJz5QQ7LLwnoLMAYDbBQfG/lLMMUTpz0ICmkOy59wdoa
 aGAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xYVfYq+cq2DSaGYTizPG+UxUtdc7loWf53PQUHvErlt3H62hgJrSMNF8p2LDbuRykX9jKkjTMjaMe@nongnu.org
X-Gm-Message-State: AOJu0YyNLGeIJRqHdKKWLQPHzpTWLa0jqIACHYanuEllHWoCMptode1c
 EpXgZ38G85JeOiwf7p1hRdntnTCe5cKflZPbI2KlbpR2E9UMkN90PfFVSQ3ZxOsl4cD9qejmj75
 EAaZiVlGVBNKXod+NsL2H9fkg7IigINJE3kBqZj/mVZnk0XhURTQpLC6b
X-Gm-Gg: AfdE7cmQlvCxFwrWnp1WpKzJm4bJvXdXZDYHssOyGirB9fjgGtREp2E4XnSNuNlCSVj
 QooWw3hyVgNyDCrDBBBbAj6FgpXHoBH7Lqwe4TNYvCDIV57gVjyoXJ0KYnvb5f8gsneUY52s2+K
 omicUAiqvJ2VKLSYTfSHyxpixmbUNdwWfusItTdOW1Y4ZEsd5Tm/3kXwd+7N+6diSdePal4CA1I
 mMl1AryUTBJWQW73vX9cmR+nomjAiDYM9/RLfxPmShLMGN+CndIxksOxRbZIoXNohW4fhBNlIQ3
 U62NZNz20F/e4lxkOx+Dg3MPx/NoVbfAJ59fGDvPKfkiqU4ROHqG7JnpreHgm+9ChWFZu6gotmJ
 ojsfJJuBzMPTNogwr96TyLPtcsydB9d4vp+8i/3f1+oI=
X-Received: by 2002:a05:600c:c043:b0:493:c00d:da59 with SMTP id
 5b1f17b1804b1-493c3cd5db0mr33987425e9.12.1782972876167; 
 Wed, 01 Jul 2026 23:14:36 -0700 (PDT)
X-Received: by 2002:a05:600c:c043:b0:493:c00d:da59 with SMTP id
 5b1f17b1804b1-493c3cd5db0mr33987135e9.12.1782972875748; 
 Wed, 01 Jul 2026 23:14:35 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-40-241-22.web.vodafone.de.
 [109.40.241.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef183e7sm126789235e9.2.2026.07.01.23.14.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 23:14:35 -0700 (PDT)
Message-ID: <d42c2c0e-0a2a-4b24-9143-c2c7bc9f7023@redhat.com>
Date: Thu, 2 Jul 2026 08:14:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/loongarch_dintc: Fix OOB access in DINT MMIO
 write handler
To: gaosong <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, berrange@redhat.com, lixianglai@loongson.cn
References: <20260701065454.1976188-1-gaosong@loongson.cn>
 <72f8e95a-520c-44ce-b42d-7bac6ce8db05@oss.qualcomm.com>
 <b057fe4c-6ec5-6467-c88e-4c94d18a5891@loongson.cn>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <b057fe4c-6ec5-6467-c88e-4c94d18a5891@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 02/07/2026 03.50, gaosong wrote:
> 在 2026/7/1 下午3:43, Philippe Mathieu-Daudé 写道:
>> Hi,
>>
>> On 1/7/26 08:54, Song Gao wrote:
>>> Validate guest-controlled cpu_num before using it to index the cpu[] array
>>> or pass to async_run_on_cpu(). Without this check, a malicious guest can
>>> trigger a NULL pointer dereference in async_run_on_cpu() and an
>>> out-of-bounds array access in qemu_set_irq(), causing host crash.
>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3616
>>> Fixes: 0d148eaf5a3e ("hw/loongarch: Implement dintc set irq")
>>> Reported-by: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>>> ---
>>>   hw/intc/loongarch_dintc.c | 13 +++++++++++++
>>>   1 file changed, 13 insertions(+)
>>>
>>> diff --git a/hw/intc/loongarch_dintc.c b/hw/intc/loongarch_dintc.c
>>> index c877a8003b..e40292887c 100644
>>> --- a/hw/intc/loongarch_dintc.c
>>> +++ b/hw/intc/loongarch_dintc.c
>>> @@ -19,6 +19,7 @@
>>>   #include "target/loongarch/cpu.h"
>>>   #include "qemu/error-report.h"
>>>   #include "system/hw_accel.h"
>>> +#include "qemu/log.h"
>>>     /* msg addr field */
>>>   FIELD(MSG_ADDR, IRQ_NUM, 4, 8)
>>> @@ -52,7 +53,19 @@ static void loongarch_dintc_mem_write(void *opaque, 
>>> hwaddr addr,
>>>       CPUState *cs;
>>>         cpu_num = FIELD_EX64(msg_addr, MSG_ADDR, CPU_NUM);
>>> +
>>> +    /* Validate cpu_num against the configured number of CPUs */
>>> +    if (cpu_num >= s->num_cpu) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                      "loongarch-dintc: invalid cpu number%d\n", cpu_num);
>>> +        return;
>>
>> Do you know how real hardware behave in this case?
>>
> I haven't been able to verify the exact physical hardware behavior for 
> writes targeting a non-existent CPU.
> However, I don't think this situation will actually happen,
> 
> but QEMU ASAN has reported a code risk, and I'm not sure if we need to 
> address it. Could you offer some advice?

I don't know, but I guess real hardware would ignore the write, too - if 
there is no CPU with the right ID listening to the write, it's unlikely that 
something happens.

So I think your patch is doing the right thing:

Reviewed-by: Thomas Huth <thuth@redhat.com>


>>> +    }
>>>       cs = cpu_by_arch_id(cpu_num);
>>> +    if (!cs) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                      "loongarch-dintc: no CPU for arch_id %d\n", cpu_num);
>>> +        return;
>>> +    }
>>>       irq_num = FIELD_EX64(msg_addr, MSG_ADDR, IRQ_NUM);
>>>         async_run_on_cpu(cs, do_set_vcpu_dintc_irq,
> 


