Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51CEC3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 21:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9sHJ-0006Yz-Sf; Tue, 29 Apr 2025 17:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9sHH-0006Vo-2O
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 17:14:07 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9sHE-00057V-Pe
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 17:14:06 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22c33e4fdb8so70214895ad.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 14:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745961243; x=1746566043; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hOHQaZoxZ7UbKQya7ht8bDTHCEK26P6Ba+yTQsPhO10=;
 b=ujHPdu+pkZIAb9sPsVt11XQWsNJ7oPr/BnM/wDh3Z1sBl86WhvVPdG2QU2Rpj5mh4T
 3ElU31MSSAu7Yk4xkZLIrQyho2yiET7z7jM/IgpqztJmrp4YNa/F8fFOgPcZbp72g4Bn
 IpbhJb38tnJsbKP0PbNIMVvKnVMJUVG9VKF7rebVMsw3jGUOBtiwfn8maJaZ3eZDp2jt
 sCXloYpAeSOd6B80psPH1FDp94G1js/Adfa7QP7862a+v4JXQomV7cnNuBNg0a8yWogp
 8RnOhJoR1E2POdAUS4h+X839s+xFDtddGukASIpa3QZGO2/cADGPBMubbiA1lzTzFm/k
 3w7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745961243; x=1746566043;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hOHQaZoxZ7UbKQya7ht8bDTHCEK26P6Ba+yTQsPhO10=;
 b=b6LQwYtd4mYt6RVbN4HMkl8DMF5c5BgXGTEugA8ZzoxbE0ZR8ES/QrkLjn2dpMzrB9
 Zpsd9zpMJ8qhasoDUB+xyN7EG/qiNUtZW6NtjQmlmXICN/KZTAL9lgem2knymSGfGfDm
 11e9N3GcMT2mU+Xcfw9CvNzOheMaPZs4ymzotyMnjUEShpWnzr//IJfFIRUEULMP9R0W
 Tj10r5nNtOWc7INcyYomjs7v3GoRnKnFn+0dlYM9d/eK5ZVMRih2Wnm+hQW9SXAKorar
 efLBNtTXAiZVEWCdNjgFWezfa1AM+4KvftoB9Tbp10vctGKN8g0qFKl5E4pCWhXz8ZRO
 IXHg==
X-Gm-Message-State: AOJu0YyRL6+/uQaTEnAEewvh7L4erUEGOZ9sH6Askis1boXQ7Jcm2hq4
 MeeWHD3Zx9S/nOO8hnoPhL6v9As15+0QnxzRp2rpPLCM483fIEQSlTvwFwIo3k8=
X-Gm-Gg: ASbGncstv0NE104GMOixQnZTBWsjYkdYzgwFzWepUgUf+tU1gUgI5nerBz0kBbaLqua
 DmRk3iNB51n5fClGWQSJQ58lqF4qriLqD9tMxQ+5p7Z7IF5lqcffkmX/aGzncCB77Mp+Fig3h7G
 IVbTa4YEt9p5dpMit8crF/97ITjo0nrGLCoj7gkBs6+wiT9LX/krE6OlZHSKVHk0m0W/a1jDJHc
 R3XgNBioU1kzRQfMTEomwMQlaJ4+bFS5agDrQTGrjFvFzZ996CFD3lbK9aKcT55zV7fhtnJsZ3J
 RrBStcvbc3PvMcfEZfsA/RAWYoNh51sPch9MrVolMuosDUx+gQvyCGb72yL6fStk
X-Google-Smtp-Source: AGHT+IGVp4+1Bhotq0d4aremIqEwnPUtzY6snkcOfYlsGofhxa81gl1LdUI7VT6xUzXDUNe4F7okDg==
X-Received: by 2002:a17:903:2f43:b0:224:1943:c5c with SMTP id
 d9443c01a7336-22df34d33edmr13219515ad.15.1745961243059; 
 Tue, 29 Apr 2025 14:14:03 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db50e7b50sm107997675ad.130.2025.04.29.14.14.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 14:14:02 -0700 (PDT)
Message-ID: <d455055c-a13b-4e00-b921-5ede2be08e89@linaro.org>
Date: Tue, 29 Apr 2025 14:14:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] target/arm/kvm_arm: copy definitions from kvm
 headers
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, anjo@rev.ng, richard.henderson@linaro.org
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
 <20250429050010.971128-6-pierrick.bouvier@linaro.org>
 <87msbz45y6.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87msbz45y6.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 4/29/25 3:28 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> "linux/kvm.h" is not included for code compiled without
>> COMPILING_PER_TARGET, and headers are different depending architecture
>> (arm, arm64).
>> Thus we need to manually expose some definitions that will
>> be used by target/arm, ensuring they are the same for arm amd aarch64.
>>
>> As well, we must but prudent to not redefine things if code is already
>> including linux/kvm.h, thus the #ifndef COMPILING_PER_TARGET guard.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   target/arm/kvm_arm.h | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
>> index c8ddf8beb2e..eedd081064c 100644
>> --- a/target/arm/kvm_arm.h
>> +++ b/target/arm/kvm_arm.h
>> @@ -16,6 +16,21 @@
>>   #define KVM_ARM_VGIC_V2   (1 << 0)
>>   #define KVM_ARM_VGIC_V3   (1 << 1)
>>   
>> +#ifndef COMPILING_PER_TARGET
>> +
>> +/* we copy those definitions from asm-arm and asm-aarch64, as they are the same
>> + * for both architectures */
>> +#define KVM_ARM_IRQ_CPU_IRQ 0
>> +#define KVM_ARM_IRQ_CPU_FIQ 1
>> +#define KVM_ARM_IRQ_TYPE_CPU 0
>> +typedef unsigned int __u32;
>> +struct kvm_vcpu_init {
>> +    __u32 target;
>> +    __u32 features[7];
>> +};
>> +
>> +#endif /* COMPILING_PER_TARGET */
>> +
> 
> I'm not keen on the duplication. It seems to be the only reason we have
> struct kvm_vcpu_init is for kvm_arm_create_scratch_host_vcpu() where the
> only *external* user passes in a NULL.
>

I'm not keen about it either, so thanks for pointing it.

> If kvm_arm_create_scratch_host_vcpu() is made internal static to
> target/arm/kvm.c which will should always include the real linux headers
> you just need a QMP helper.
>

Yes, sounds like the good approach! Thanks.

> For the IRQ types is this just a sign of target/arm/cpu.c needing
> splitting into TCG and KVM bits?
> 

I'll move relevant functions to target/arm/kvm.c, so cpu.c can be 
isolated from this.

> 
>>   /**
>>    * kvm_arm_register_device:
>>    * @mr: memory region for this device
> 


