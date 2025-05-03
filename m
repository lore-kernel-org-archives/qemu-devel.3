Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AE0C369C2
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 21:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBKFy-00037T-7p; Sat, 03 May 2025 17:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBKFv-00036s-7O
 for qemu-devel@nongnu.org; Sat, 03 May 2025 17:18:43 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBKFt-0005e1-Bj
 for qemu-devel@nongnu.org; Sat, 03 May 2025 17:18:42 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-224171d6826so47454345ad.3
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 14:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746307119; x=1746911919; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=45ezGvBYBHyKW+GUcBxuGvzarphaJYBNYk9QW0DXKLU=;
 b=gRbuyNA5c8IJERCmVwWYYS/2KsWGUxw3OcJ3zvfK3TP3VZmBbxZ0gt5EY7tUo3UY7E
 grKcYXpUSCsvtfEKnNHB81EoieEND9ecOIwvPrMkFJtzA4+ofh733b5PPiENL0w66TKC
 BmgN+pXUxyiW+anr44ey2DMGSH9pQGADEQXPWTJcRyeacBDTJ7j9c9Zcrt4/Bjswtr++
 VP13BjMcCYh2MBCha1EW61p83f/gsVYWhBnQugGTr/6k6ALFE8FBc0PJuKEm0WhLUDXu
 u3YyHAqn7CmqNMubnGA2YKWJv0ArLukHhmchKiEYQyL0/A4+1C+6TXOqsrqtNzdXMqZi
 ibUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746307119; x=1746911919;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=45ezGvBYBHyKW+GUcBxuGvzarphaJYBNYk9QW0DXKLU=;
 b=YkkazblOGzs+nB0+pDWu1pzdpQr7ITpTnTZ+qOdWyCKIP1T1iXoQlezu8l4HEF1BAo
 n72+0VFmitbc794mn0Rmdbr97tCLqNcqccT/5BwTfEeOyZKtDEu4KSJRxHQytaUP8L+P
 6phySLOU9TlWlfsMpLCJY3aKkzb7b4BDINfQ9lq0Oo4lBRpZT8e9BHoO9gS+ka7roaG9
 8SA1yfpOqONCYmTAQj+fAyL0XDPmd/WoApyrUrCNcu7tT1XdDY+G91tp7TVsrc1K+oTY
 SYzhamYEW9I9K0kSRUJ6bfQJavtURQD3SsGQj5lCl/Qr2B34sfkP57n3YIpxF9u6bvDV
 Gzog==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5/MVzShsJfFnqK5ggt54hNtABlBxdUCChA/duZfRjwNestqAHofoQvGU8vxwgRwsaN8ItD6u2gB6e@nongnu.org
X-Gm-Message-State: AOJu0YxtXBRDBRTy4t1xLPtJBmK/ymhvte18diiO4oyHTdxm9xyeUCsC
 W/ZLs2/GoKAGlOUWOiEgWMaTNC1TkkYmm79QrfqJKEUnoh1y5XKyPp28lHfMcJg=
X-Gm-Gg: ASbGncvwBHevkKY06+rdga3G5zy4N+150FDpGmtQQdchyGo0L4ZCT6Yl2zPvvikJT1b
 pZWAS0oZUjrzWcodUlVPGz+qbCGc6qL9yBmGet6ftSgCJupmw+InRpxj6Ck5dQ0QxMiTqx3B57c
 1k4I73ChEHbGzH24WDGjgl/ojWUTOq141jYvH3MvaXpjpqQ0pbQivzl44wJQnnzZGvvs3FCY2xg
 x83KP8oLPwkPgT/y9/DMRcCdIoa1qNSCX7Ee4FUzT5QnLLhKnYIFLA6Pgj+TeZ2TrgjZZFU+yM9
 h4CCF1AV9LS+vAet7xZkUvwLzHC4QNG8kykZTmqP28Ey5gHhLC7WTw==
X-Google-Smtp-Source: AGHT+IH3UsnAzBT5enZnNLGLoJsukEKh1TbN9yI/pnjynITTwoYoYrOIa5hc3zCcGSfsIbx5/+ChYg==
X-Received: by 2002:a17:903:190:b0:224:1ef:1e00 with SMTP id
 d9443c01a7336-22e1e8f8833mr32193285ad.19.1746307119511; 
 Sat, 03 May 2025 14:18:39 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e150eb21dsm28272865ad.40.2025.05.03.14.18.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 May 2025 14:18:39 -0700 (PDT)
Message-ID: <21893e4f-700e-4a9f-b877-98a863a47c02@linaro.org>
Date: Sat, 3 May 2025 14:18:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/33] target/arm/cpu: remove TARGET_AARCH64 around
 aarch64_cpu_dump_state common
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng, kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-10-pierrick.bouvier@linaro.org>
 <24662e56-d6cf-4c17-b792-e4d1ece6e241@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <24662e56-d6cf-4c17-b792-e4d1ece6e241@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/1/25 12:06 PM, Philippe Mathieu-Daudé wrote:
> Missing the "Why?". Answer, because it is guarded by is_a64().
> 

We are guaranteed it was not used because the whole definition is under 
TARGET_AARCH64 (and not only the code inside the function).
If it was called before, out of this target, it would have triggered a 
g_assert_not_reached().

As well, yes, it's guarded by is_a64(env).
I'll update description with this.

> Should we assert on is_a64() on entry?
> 

I don't think so, from the reason above 'If it was called before'.

> On 1/5/25 08:23, Pierrick Bouvier wrote:
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/cpu.c | 11 -----------
>>    1 file changed, 11 deletions(-)
>>
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 37b11e8866f..00ae2778058 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -1183,8 +1183,6 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
>>    #endif
>>    }
>>    
>> -#ifdef TARGET_AARCH64
>> -
>>    static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>>    {
>>        ARMCPU *cpu = ARM_CPU(cs);
>> @@ -1342,15 +1340,6 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>>        }
>>    }
>>    
>> -#else
>> -
>> -static inline void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>> -{
>> -    g_assert_not_reached();
>> -}
>> -
>> -#endif
>> -
>>    static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>>    {
>>        ARMCPU *cpu = ARM_CPU(cs);
> 


