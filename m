Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C48C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 18:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX29V-0000ug-QT; Wed, 02 Jul 2025 14:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX29S-0000tf-3H
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:25:46 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX29P-0004ec-2b
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:25:44 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4538bc1cffdso45776745e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751480741; x=1752085541; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vbbsCtKiihSxcvSRHHDVP6sy4C+cCApajjABE6XxvWk=;
 b=yufXrgpdHZipliAI7z+V8JmbmhSuC03Kp6r5+h1cVb1v+uhcC0qwaCSA2sYceFRil7
 oUC5hjKTznA3ckELIm5TMiIPDH/aV1NLHu66TH5yidMY9AfGs0iaoMVW5l0IEcEqqEyT
 cj4NRffMVXcsWgQ3Sw8zMawiJ4SX+FIaKR+ffkMoljoUIamdWRnNU9jeZp9WgSAlTaVE
 9XdsiFFN942s6O7p2jHrNzuzt60jVCNMJvQktaIvoWvUyNLgB+aL2gtlJXt6pJUT73pj
 FpRLfN03wuk4w6oHDqX9Xu4uEG7bFQ8WJqzWDm2pV1I+MaN3ax7udirOBA0PpPlFjIkZ
 72vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751480741; x=1752085541;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vbbsCtKiihSxcvSRHHDVP6sy4C+cCApajjABE6XxvWk=;
 b=NpcqiVfiERjqKxbkjoUELbX9W7fh6Jt5sIG8cpIU7W1QYvMfdE/zvsY/4rNNOmwZCS
 zRXE96VmmN8eeXNBAlAnTr/nfTYCOShGomsT6kYwVpFJEB3bJt/qH2mQCGgloSyeglGa
 fBSIupvyiI76BfMxgpQv14q6F8jylxoqE1YiI6rlxhjOQ7knflQqP7oYQZEl+L1oSa8c
 1RI0fY3imJt/DyYztCkbnlRBXEPOg7yLHDqjeWZI+g7Ch11R6U24ahwza+yome4E5Bi1
 3mEazoqVxImY4aIXSpSWDxbW7LNJm9LdtkwXB06EiTSXlwgVfhWW69GGZm6/W/Cg+84b
 4LwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVADTN59VXCnzBEiY5CdJlDM75+YHQ/lHLSvRECM4+9nVr80aRLkvCqf9hRCf56X1+pYBgtsEzpE8PJ@nongnu.org
X-Gm-Message-State: AOJu0YzkE3ReahmDq9OzfE4LOzS87buZtJsGx1MS3furELGbdZ9d5bkQ
 BI8fOXnViuKRbHZK060LA0NuwdX/eHR7yCd+blxM5uUk8u6HgHKd9644VN77SUI4x9Zc0O5NJSS
 wAMr/
X-Gm-Gg: ASbGncs8HYQqumhn/bP+xMHo7EIDAy5cCfkdc70/dj/0j20po39pmuIkWcbn+itcKB8
 dCQgO6Pc46X8nypv17xvINgqEgZYqqI8FGe0e/BpLViLDtuewpA59qxEeKKMpXrVN65PLGqt8Is
 YrUdQKucteClq+vtj+SBPb87YdiM0HP7pjw4kKos/Svr1M5R+kkYITQlQ0VeUyvppNv4vX3UZ32
 K6PA7EMRZ59HHrMm+BNYdBpHL7ri0u7HM3Hav0qzWEBePDD8GsMK1z5G4q0T4vwRHB8ytsJX/Ir
 a5GXzJ3ExKqdlWjtlNpkBDxdCuwMEzOWq0BilVM3b6/Vr2cv2nI/VuJG0kyRgjydI60ctJvU8qZ
 hQIkqRTTZ0+59KOnBTUCOekRYskXPBdgs2WKFltJj
X-Google-Smtp-Source: AGHT+IEi8GFzY854Wcqq8YpQ2kXxUKbuGICSouF0JMXmpKzKVGQtTM/CctHFc/coIYFL95yis3t6xA==
X-Received: by 2002:a05:600c:4752:b0:43d:878c:7c40 with SMTP id
 5b1f17b1804b1-454a36e2baamr50970215e9.10.1751480740970; 
 Wed, 02 Jul 2025 11:25:40 -0700 (PDT)
Received: from [192.168.69.166] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9beb22asm4826585e9.36.2025.07.02.11.25.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 11:25:40 -0700 (PDT)
Message-ID: <72e2855d-4ba0-4933-826e-d38100e9a46f@linaro.org>
Date: Wed, 2 Jul 2025 20:25:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 57/68] accel/tcg: Expose vcpu_[un]register() for MTTCG
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-58-philmd@linaro.org>
 <89ceef1e-c4c1-45eb-a369-a17f711ef4ad@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <89ceef1e-c4c1-45eb-a369-a17f711ef4ad@linaro.org>
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

On 2/7/25 17:19, Richard Henderson wrote:
> On 7/1/25 08:40, Philippe Mathieu-Daudé wrote:
>> Allocate ForceRcuNotifier on the Heap.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   accel/tcg/tcg-accel-ops-mttcg.c | 30 ++++++++++++++++++++++++------
>>   1 file changed, 24 insertions(+), 6 deletions(-)
> 
> Please document the motivation.

 > [...] the structure is still not accessible from anywhere outside
 > of the function, and has the same lifetime as the function.

We need this to register the MTTCG thread in split_cpu_thread_routine():
https://lore.kernel.org/qemu-devel/20250620172751.94231-12-philmd@linaro.org/

Better to have AccelOpsClass::[un]register_thread_rcu() hooks?

>>
>> diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel- 
>> ops-mttcg.c
>> index 4de506a80ca..2d31b00ee59 100644
>> --- a/accel/tcg/tcg-accel-ops-mttcg.c
>> +++ b/accel/tcg/tcg-accel-ops-mttcg.c
>> @@ -55,6 +55,27 @@ static void mttcg_force_rcu(Notifier *notify, void 
>> *data)
>>       async_run_on_cpu(cpu, do_nothing, RUN_ON_CPU_NULL);
>>   }
>> +static void *mttcg_vcpu_register(CPUState *cpu)
>> +{
>> +    MttcgForceRcuNotifier *force_rcu = g_new(MttcgForceRcuNotifier, 1);
>> +
>> +    force_rcu->notifier.notify = mttcg_force_rcu;
>> +    force_rcu->cpu = cpu;
>> +    rcu_add_force_rcu_notifier(&force_rcu->notifier);
>> +    tcg_register_thread();
>> +
>> +    return force_rcu;
>> +}
>> +
>> +static void mttcg_vcpu_unregister(CPUState *cpu, void *opaque)
>> +{
>> +    MttcgForceRcuNotifier *force_rcu = opaque;
>> +
>> +    rcu_remove_force_rcu_notifier(&force_rcu->notifier);
>> +
>> +    g_free(force_rcu);
>> +}
>> +
>>   /*
>>    * In the multi-threaded case each vCPU has its own thread. The TLS
>>    * variable current_cpu can be used deep in the code to find the
>> @@ -63,17 +84,14 @@ static void mttcg_force_rcu(Notifier *notify, void 
>> *data)
>>   void *mttcg_cpu_thread_routine(void *arg)
>>   {
>> -    MttcgForceRcuNotifier force_rcu;
>> +    MttcgForceRcuNotifier *force_rcu;
>>       CPUState *cpu = arg;
>>       assert(tcg_enabled());
>>       g_assert(!icount_enabled());
>>       rcu_register_thread();
>> -    force_rcu.notifier.notify = mttcg_force_rcu;
>> -    force_rcu.cpu = cpu;
>> -    rcu_add_force_rcu_notifier(&force_rcu.notifier);
>> -    tcg_register_thread();
>> +    force_rcu = mttcg_vcpu_register(cpu);
>>       bql_lock();
>>       qemu_thread_get_self(cpu->thread);
>> @@ -121,7 +139,7 @@ void *mttcg_cpu_thread_routine(void *arg)
>>       tcg_cpu_destroy(cpu);
>>       bql_unlock();
>> -    rcu_remove_force_rcu_notifier(&force_rcu.notifier);
>> +    mttcg_vcpu_unregister(cpu, force_rcu);
>>       rcu_unregister_thread();
>>       return NULL;
>>   }
> 


