Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE4FFF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHGoH-0004mV-Cg; Mon, 27 Apr 2026 03:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHGoF-0004mN-In
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 03:55:15 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHGoD-0004sB-Ii
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 03:55:14 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so118212545e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 00:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777276509; x=1777881309; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kp87esz6qXRzyktumHSMZ5IAp0zHZWl0HhszIb1l0zc=;
 b=tSZJ4zshL/GAWCceLM03pw4LqvR1K6Wg47/m4f8B47VEU3zVWNqm5g4LYBDIaXeusQ
 ZDOIbyc29/pRhMusqnS6GvUbM56IkZDjwpCEfXLnKarndOQxA6+5Ji32/vSLGZdWJwht
 gyoW01qCo09HLXOJcSgT2psojGHGReJMXup5bpm/GYhamWL1BJZBICHZv0g1BmDDGjp+
 pHout+JAHViaNI2eRFD0Vk1UpZGeu68NywuJwr83JbZohfJm+GPQRWyj4vW07rWPrxB3
 502zclfLXlkGAGV4RBYQdLbPK8MqfB9o4MmMDeo1O9t4YDeUHxqyjQp/fuV0+eqvhooj
 f0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777276509; x=1777881309;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kp87esz6qXRzyktumHSMZ5IAp0zHZWl0HhszIb1l0zc=;
 b=qPgibQgJT+23THtD4IVi2sY55D6jPrTMb2Tmqjfpoe+A9QwfQzVU2FPSpPCo10RiZC
 DOecw9ey9y83NLwBsELR4urcspHzkAnQyoG22p0A1a1AZilH6A/VJZT8kfHdqTw1Zdf4
 YSbRaB3SSHpUMh66Xs6RWKtPq00fQYYjXBYI3bfSTGoz9KefQR5R5ciOJl2b/2QCPTnc
 BtDHxy32XnNJ/P/cnjp/AzoTgZUkPmCvYasXMct0wHW9VibVJjfttNpgpPe7IlTlZbmn
 XaEu0yXfu9FcD5VFxPk0vIN5sYkAv2/O9Da42H5khzpEliQv00re8up8twR/4CZ/qsgw
 4vbA==
X-Gm-Message-State: AOJu0YxxZE78SQcaHi1voh8pqSGPmfXRweF1JYkzALvXhclfPctyLvGr
 X6XlowxTHTYEMcyk5AHXQerKD17Bs5UFeeD59CMzC7cn555m24pxUeTmjX3mV7+adxA=
X-Gm-Gg: AeBDievFtQnIWJMwD8Der8RjN81QGKB7lQ9OjKYi+fbpZ53VCYey1cQCQWfwzbGtmhG
 Ykc8QoT+/9HolMVWw5I4lqa3kyKO2wwhjDXvW1U5uMBPBen6b1xuaaZT8sOuuBzrovtGCYtshZH
 O0t8edYTsvxjP/CMnX5dGLXx0Qvw4Lh+zgjaAcggwmoeUiBZu2THb1zPzMFqfywzIm7IKJSYznS
 mUvP3elvIpb/zx5Hmhs9aoB0qZxjhiN26EhPSmrMvbTna3fhHSw3xBoFlQnG1MWsl7mREViBFgy
 PgUQ3PJ1TH4puiCILP1WionG4URAKJfWWPn6/DNfImdaLmjCGTM3acwJAv4hHZpP4GtqlmW9u9m
 jxHAMyCEamUBr4mNbqqA21AyTabg4o060IGeJCT522zqDS/5NnZnm8rd7zPJo10IqHJTQpC3UNO
 3o9DCb0EnIX3B8g0FQbFgbjGEGBhrK1G1re/gBuwH5ZKmQNgXvIadEpYoooOD48hHg0B42BM8Tu
 MyJ4x0zA4NRsM0=
X-Received: by 2002:a05:6000:2087:b0:43f:dfb6:78e1 with SMTP id
 ffacd0b85a97d-43fe3dc5506mr64797913f8f.8.1777276508501; 
 Mon, 27 Apr 2026 00:55:08 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4dc24cfsm78077739f8f.16.2026.04.27.00.55.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 00:55:07 -0700 (PDT)
Message-ID: <d93c651f-3976-4fa8-afae-0361ff876134@linaro.org>
Date: Mon, 27 Apr 2026 09:55:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 v6 1/6] target/sparc/monitor: Dump all registers
 as 32-bit
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260320091019.59902-1-philmd@linaro.org>
 <20260320091019.59902-2-philmd@linaro.org> <87tsu5s88d.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87tsu5s88d.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 24/3/26 13:49, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> All these SPARC64 registers are 32-bit since their introduction
>> in commit 3475187dd81 ("sparc64 merge"), see target/sparc/cpu.h:
>>
>>    511 #if defined(TARGET_SPARC64)
>>    ...
>>    515     uint32_t asi;
>>    516     uint32_t pstate;
>>    ...
>>    519     uint32_t cansave, canrestore, otherwin, wstate, cleanwin;
>>
>> Set MonitorDef::type to MD_I32 to dump them as 32-bit.
> 
> What are they dumped as before this patch?

target_long, so pointlessly unsigned sign-extended. I'll mention.

> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/sparc/monitor.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
>> index a60671a60a4..e9300ded4ad 100644
>> --- a/target/sparc/monitor.c
>> +++ b/target/sparc/monitor.c
>> @@ -41,13 +41,13 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>>   
>>   const MonitorDef monitor_defs[] = {
>>   #ifdef TARGET_SPARC64
>> -    { "asi", offsetof(CPUSPARCState, asi) },
>> -    { "pstate", offsetof(CPUSPARCState, pstate) },
>> -    { "cansave", offsetof(CPUSPARCState, cansave) },
>> -    { "canrestore", offsetof(CPUSPARCState, canrestore) },
>> -    { "otherwin", offsetof(CPUSPARCState, otherwin) },
>> -    { "wstate", offsetof(CPUSPARCState, wstate) },
>> -    { "cleanwin", offsetof(CPUSPARCState, cleanwin) },
>> +    { "asi", offsetof(CPUSPARCState, asi), NULL, MD_I32 },
>> +    { "pstate", offsetof(CPUSPARCState, pstate), NULL, MD_I32 },
>> +    { "cansave", offsetof(CPUSPARCState, cansave), NULL, MD_I32 },
>> +    { "canrestore", offsetof(CPUSPARCState, canrestore), NULL, MD_I32 },
>> +    { "otherwin", offsetof(CPUSPARCState, otherwin), NULL, MD_I32 },
>> +    { "wstate", offsetof(CPUSPARCState, wstate), NULL, MD_I32 },
>> +    { "cleanwin", offsetof(CPUSPARCState, cleanwin), NULL, MD_I32 },
>>   #endif
>>       { NULL },
>>   };
> 


