Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97D7CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 04:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulgxe-00035e-Kn; Tue, 12 Aug 2025 00:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulgxZ-00035H-Ue
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 00:50:06 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulgxV-0004Wf-0h
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 00:50:04 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b7823559a5so2354614f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 21:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754974191; x=1755578991; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nKO/btB8sgwjdTI9Kz/mOI1judsHVR/Ol8FXze9Q5lQ=;
 b=qJdaOUDl0ELw6B00Rm2nPVjEC+K9lm14uLC9qQ3tBgLTG4YCui++kTa+9Vufmoc9Y/
 z/drFNPVfolLfGpntsOZbzNTVEvM+OeyN5Xh8M+HigEUZdo7w9JERIntzz2fQwWv12hd
 iOKXR3iFt5cRwLiwyFv9qNyC+OnHnSdHIMmee/cti3XItoUWvV0B5ZYwNX6m9ZcdF9B0
 ACKLTyiChkBQjH00XQtHu+fDgKCOF6PlC1Y3XpZ8z9roN3LhkebNh/fxr/InWOSlyHMU
 B1xbJXZ4JLhdO6L5e258TlZvRz1+sJ8j9zB+Zj4diy11OoG74F6kwkqgxm40r64SabvV
 6jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754974191; x=1755578991;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nKO/btB8sgwjdTI9Kz/mOI1judsHVR/Ol8FXze9Q5lQ=;
 b=EEu3nY24SheuQEZ3bcOJsiyVCEjFugnHWrOyBCTo2jGm83Ed/k/ZMLkOGrFAD2wXqn
 ICWgB8cvbcw4Wmdm1itcQNghbG2Q+hP8LAyHkCsWzHKEYMaeaPTAUSWpeamTiFISN5Vz
 aNokGEjDq0f0QC2TvFZmpP5Ng5AFPxky4C+x2QagMieDOYVmUDI4n9t6TSgEv3JV/mBs
 htpUP4+HFO34Kp1Rme+/kptZ0uzm80pn/X5KA448L5C4hAYqHk9uQucwJ1tTrLCYT+r5
 CURWixousrni1H3SVBXlrPR84ImMyOOrW9XT21zWcMTzRjaUZLDIgMizlITnjBZvbpmZ
 wHZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+FCbi2M1ti7Gaxgjs6si3ALiycF+MRJSFDUw6UPfb3qwEsvJu93mLr9FpS6J1DNqmDVHLBlnkT0jx@nongnu.org
X-Gm-Message-State: AOJu0YyEva5paLrrZbBfn8DYH/zz65LYgb+awW4hmbyPOEgk+UWHef7O
 rRFVqjMoUhQnpe1I3tM7+7Ac+mNaXQT4VQizE8ZjtSjvNPNLkET5ecrQXJNUmi7LNc4=
X-Gm-Gg: ASbGncv89wxLoiNiwuE2KL97CVChtSWb1ex3RuYxzlk5yiHrMAaJsWNmWUU48uOG0Vw
 iBS4pvGE4vgLzqGJu8uEpK5vODQLZSyI2JILGFwkUvDQxqQbVMnrUM4IVK5jC9AsqcmG4MekDWb
 geby7k+fzxeaOaw9B+w23RPk2h9Gxa9QNo9WZacYdw5LMeQ8qRxmIiGjVZYsdnvO+++rUncfDEJ
 BQNJmFV48MlpMp1f5Q9sU1BKomwN7BFvy7uTtLmoJbiBEPADO8L1p37wY2mM2tZfdnhXi/qnyjE
 kxJGAUiHkkBVclIcUXJgDIwhUQ1v3xjfnrRRwBL9jxJPwhnSeYs7MUG9gQAJ77ig0/pMNE589DC
 soZG3NNi3GNzLttCQmoZwk0+O/LGBemcJBrdfFQMMMgMrH4MisAovTuo3O6MpAHilmTr+dKuOZN
 80
X-Google-Smtp-Source: AGHT+IFzSLCrFfOChpFZBEIxi3PmTUayS0Ee8wnnNgXG4m8ADogf3URL6YowrkJcbp3tQmtBfLy4LA==
X-Received: by 2002:a05:6000:2010:b0:3b7:95bc:a7ea with SMTP id
 ffacd0b85a97d-3b910fd9b71mr1537054f8f.22.1754974191512; 
 Mon, 11 Aug 2025 21:49:51 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e58400f5sm274704575e9.2.2025.08.11.21.49.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 21:49:50 -0700 (PDT)
Message-ID: <14d7d948-e840-4ae7-ae93-122755d6a421@linaro.org>
Date: Tue, 12 Aug 2025 06:49:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/11] target/arm: Replace kvm_arm_pmu_supported by
 host_cpu_feature_supported
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Miguel Luis <miguel.luis@oracle.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Haibo Xu <haibo.xu@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Mark Burton <mburton@qti.qualcomm.com>, Alexander Graf <agraf@csgraf.de>,
 Claudio Fontana <cfontana@suse.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>
References: <20250811170611.37482-1-philmd@linaro.org>
 <20250811170611.37482-8-philmd@linaro.org>
 <8efcc809-f548-4383-b742-e435d622da73@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8efcc809-f548-4383-b742-e435d622da73@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 12/8/25 02:48, Richard Henderson wrote:
> On 8/12/25 03:06, Philippe Mathieu-Daudé wrote:
>> +++ b/target/arm/kvm.c
>> @@ -288,7 +288,7 @@ static bool 
>> kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>                                1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
>>       }
>> -    if (kvm_arm_pmu_supported()) {
>> +    if (host_cpu_feature_supported(ARM_FEATURE_PMU, false)) {
> 
> Why is false correct here?  Alternately, in the next patch, why is it 
> correct to pass true for the EL2 test?

I think I copied to KVM the HVF use, adapted on top of:
https://lore.kernel.org/qemu-devel/20250808070137.48716-12-mohamed@unpredictable.fr/

> 
> What is the purpose of the can_emulate parameter at all?

When using split-accel on pre-M3, we might emulate EL2:

        |   feat            |    can_emulate   |    retval
        +   ----            +      -----       +     ----M1/M2  | 
ARM_FEATURE_EL2         false            false
M1/M2  |  ARM_FEATURE_EL2         true             true
M3/M4  |  ARM_FEATURE_EL2         any              true

