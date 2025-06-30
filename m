Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D8DC8302B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGY3-0003zm-L9; Mon, 30 Jun 2025 11:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWGXz-0003nm-5Y
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:35:55 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWGXs-0000iU-RI
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:35:54 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4538bc1cffdso22521695e9.0
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297744; x=1751902544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HZB1cxdvqhbIS/BrUQCEpbRpV8YcIFl4ZtW21ogiZbo=;
 b=WJknmbxR0yGROFvHiRXaUHzyenY8upB11tH01JZnhaYzFCB1BrP4Pa+SHQle3Y/571
 9q3YTu09YUh38rnt4fBTN0rACFYTOgXdoKw4hqvtcbWMzCJouT77uSlQYfSKS3n8cLoN
 hLpGixzG1uh9SPgJAXs0L1v63XJMvX/ofMS40S5a+N7PHGu/rduqgcDA4PekYM864JMV
 EW5+8Qs2Hs+ihk+SsXD3bZM8xpVl0AfB/73AyUx9WaMxyG5OoVF0UZCj8mwciOpxhq3p
 ea1BaUxLXk0BsfzpQbBPazJV3AMPbYRJeeHWVJAC1lLEJj+5o5ILxUOf0u+LYIAg4fPM
 aVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297744; x=1751902544;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HZB1cxdvqhbIS/BrUQCEpbRpV8YcIFl4ZtW21ogiZbo=;
 b=wvj4hGu/25K9e2lvjiQOsMqsNO0UKHCy52SWwDJUcmYayw4wpn3MTyIPMGbBXiupbE
 koo7wL/Xx1m9V+Y2QeiZWHhUIV9NglzcETZgGxU5O1NVJ0Ow2+Fu15LIFYhEhKjoboUu
 AXEHsWrdfK39iHiP28Vc5/mpQt6fpVKZYvYaPfAkOj+C2oGXurgbaiITjRPIbDICksHn
 w/EweLwcqP1LIlxqVHeSiIu9umKHFwYUGN5nHkYvJN0d1UtpZvNkwEk2jJr2DOTalAp/
 R2JIk/NshzsDS9BSG/jqSr9Y0zcZL8JZhsynGTq/jz35ED2WRx7LvoBd+MWPrdmeJr4z
 0wyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0LpmK+XOLak92AUN1MIb6TFGVeietC0FYCTZ6Vewaj6i2EQYTnByeiE149yzJBDwQyXJyAW11StIt@nongnu.org
X-Gm-Message-State: AOJu0Yz03qKpH/f/GXrvC7wuWSQiN0dg51zpY7hRbn2n8vUhPadmyach
 z/ZcpDjQTYj1Us/CGKYiFqp6nxdlmmONlUAcERPWWLDd1xUsDG5Qg81SVmArTNjKjvOFa8Izyn3
 MAH/u
X-Gm-Gg: ASbGnct6v7KsGfyNi75VXcRgY5LkSMOqiLWz3JnNrkWMXVYzEX0rYfQv3lDGb0kTjVl
 Uz4iNl3tGQI1h37/AEYYTRN9ERy+EIjo5UQbDVgawFVyhs9Sld7jOghv+tiUtRzInnr/XHLiIvh
 X7Mp8tdj1uLGrE1P8Dh6cg7ZP1Uo54ugBKzdfpuc8VMckM4UAibMvEVhKahSAutuCDk7vQPflXu
 KSiaZqOObLz/J8nCe8c2W44DmQhS1OEk5vcO5SEu9O7ScwMtWnxHpedgiWOH3QNSguvnLtDqSpo
 ajqvx8ZOrHm36SBHdOTXu0fhUTrgUiJzYvM4M8tDMDQ1VRPIg+z9v4FuNP+XJxjHkwjKxhG0OnU
 A49CDYOC+rRnsX7DCGU3puQ8jTFtq8Uj1AhY5+/g6
X-Google-Smtp-Source: AGHT+IGA+/Ip1vJ7B9CXL83i06POlnqhoCFlxnXHGzSQNoA4rY23q2g/DgdDJGLhHxs9O3s7GW0ImQ==
X-Received: by 2002:a05:600c:3152:b0:453:c39:d0c6 with SMTP id
 5b1f17b1804b1-4538eea44a4mr133370855e9.32.1751297744497; 
 Mon, 30 Jun 2025 08:35:44 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52c8esm10832082f8f.55.2025.06.30.08.35.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 08:35:43 -0700 (PDT)
Message-ID: <4edfdda0-a627-48f3-a2fa-94d7545eff2c@linaro.org>
Date: Mon, 30 Jun 2025 17:35:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] target/arm: Allow arm_cpu_tlb_fill_align optionally
 set CPUTLBEntryFull
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250630130937.3487-1-philmd@linaro.org>
 <20250630130937.3487-7-philmd@linaro.org>
 <8141d048-42e5-4b79-a90d-0ef1857d5857@linaro.org>
Content-Language: en-US
Cc: qemu-arm <qemu-arm@nongnu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8141d048-42e5-4b79-a90d-0ef1857d5857@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30/6/25 15:56, Richard Henderson wrote:
> On 6/30/25 07:09, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/arm/tcg/tlb_helper.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
>> index 23c72a99f5c..df04ef351d1 100644
>> --- a/target/arm/tcg/tlb_helper.c
>> +++ b/target/arm/tcg/tlb_helper.c
>> @@ -349,7 +349,9 @@ bool arm_cpu_tlb_fill_align(CPUState *cs, 
>> CPUTLBEntryFull *out, vaddr address,
>>                                 &res, fi)) {
>>           res.f.extra.arm.pte_attrs = res.cacheattrs.attrs;
>>           res.f.extra.arm.shareability = res.cacheattrs.shareability;
>> -        *out = res.f;
>> +        if (out) {
>> +            *out = res.f;
>> +        }
>>           return true;
>>       }
>>       if (probe) {
> 
> Why?  There's no other way to get the phys addr result.
> Are you only calling this for the raise-exception side effect?

Yes:

-- >8 --
@@ -2121,6 +2121,25 @@ int hvf_vcpu_exec(CPUState *cpu)
              hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized(), 1);
          }
          break;
+    case EC_INSNABORT: {
+        uint32_t set = (syndrome >> 12) & 3;
+        bool fnv = (syndrome >> 10) & 1;
+        bool ea = (syndrome >> 9) & 1;
+        bool s1ptw = (syndrome >> 7) & 1;
+        uint32_t ifsc = (syndrome >> 0) & 0x3f;
+
+        trace_hvf_insn_abort(env->pc, set, fnv, ea, s1ptw, ifsc);
+
+        cpu_synchronize_state(cpu);
+        if (tcg_enabled()) {
+            ret = EXCP_EMULATE;
+            arm_cpu_tlb_fill_align(cpu, NULL, env->pc, MMU_INST_FETCH,
+                                   arm_env_mmu_index(env), MO_32, 4, 
false, -1);
+        }
+        break;
+    }
      default:
          cpu_synchronize_state(cpu);
          trace_hvf_exit(syndrome, ec, env->pc);
---

I see probe_access_full_mmu() uses discard_tlb, I can use a similar
stack variable if you rather.

