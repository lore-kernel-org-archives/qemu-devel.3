Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE01CA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmTb-0003K1-Oe; Wed, 03 Sep 2025 08:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utmTJ-0003Gr-Iv
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:20:17 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utmTE-0005s8-MY
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:20:16 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3cdfb1ff7aeso3246055f8f.2
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 05:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756902009; x=1757506809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tYdbM6yd4V3eY5DQAneqQc/YGcbb1DVFfox825Cz89A=;
 b=EI56eHC2I6tj5NwplNSxbZtJqH8wi6j0UiXj3tdtBr4Ug3unRgJAh/C+NV88pSkxse
 QFhoBoEmnzD668ZZyh7pn9+AGckhyCCmSYOgkPNOLB4nUZGJt0W1O0bDyTMnTI5el5IJ
 eax9ucs8/4Q0CRMptKX+dORlz4GA4xLQXP1V/yCfR+uZ8XY64MvjhRVJGX9eijxc2uZx
 ubWtE6VCGuiJXPgTSrCNjC2r/H5gxTJ3p6hkKJ8ygOQnr9yZD5EUddr6AFD7AnnYHqjS
 P+iBhovNSaODTb8FxtIcPBm3KGABr4JMAsCJ4ssWSMsi/xWnzdnRF+iN1IXPcELtTrqw
 m+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756902009; x=1757506809;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tYdbM6yd4V3eY5DQAneqQc/YGcbb1DVFfox825Cz89A=;
 b=MzPahZ2lC2RKs8Cyjv6pS3ovvhS/U48dkeK8ulcvN8UEVhyqxNHH9fySTMXXVzsgk6
 hGTI5jpPnySU+HsP0ojDv7ZAaPnBy1s2fgcxoIormx58FMve3s32sW/OBiJE4kxeWF/m
 1+s1vt+mJTeq1tkkNmIfRD/ov5jveB7eC1A2pFsanTM0DbtgwYfUipR7Sgtq5pjcmQAq
 ZwADt5iF2+jYPwFlf8K3Ro3rWhwHVkTQCjXrVDIuLdv1Ic8KQ5TLpnz1GFJoU8X0MeY8
 aE8vbm6w0gWCNFcQANLVgh9MFYPEHqqtCBB/AhyL2JlaFBXu1Q/VbnkIW2H0uM/P+YGX
 Du3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS/kglVDFrfNdqOi+mXt8Wi66z9CSBJUscDjp4cr/CXm9ekJ8qxL8Q3dUQ3V0QpdvPEX2D5X2ZPC1Q@nongnu.org
X-Gm-Message-State: AOJu0YzUb0gDoqrHTyBSS6MvOQAeIm1gV++MqhtXpK4qIjKLlCd9XoOZ
 3v/79Sn4+wuWdbSHqDC+ukS9Irj4Y4ZZ9I1vsGwK6636UXbKr8mLCwC+jxLX7Fe6i0M=
X-Gm-Gg: ASbGnctZKFZLrQvclXfLc44jUEWh/lJQXc+VL0kJWOckUiBU7JtkVAqiPRAudylE4ta
 jBuVCrjt3AikoG7ghD3v7bJiT+hOMofXOsLm75EaO+NpQYQwWiI5EuFfRodtntlQ+bSKrk/cxIu
 4RGqlZyEPZoMJbum9K6eZrsZtUuXN0w9bVtqHGsFhbj8iZisLAK2ANytP7l+eEDQO3MJ45vUJCN
 GiAzd3eHXPRHMwOCFnDK0VbEdi/MYSRauGWFU7BW+OX3C1yGnoqLdBXF2YgF4vUSNZwpEE5zjAT
 Tv01/GWrNWEtSb6VrD0kQ2Cl5rVpuQX/ZoiX5hPG4WLxh16WzaM8evwnJ6IgrsJZhpVzkILWx6G
 8dU7PHeNSqzcZ5I0W7sP79XE8j/4FTKxbsFhiOCWmKBvZtfWXRn1MR/Bhtm6y3lnhrZva5kGE
X-Google-Smtp-Source: AGHT+IHPTmHkavFC+K5s8PwOvKTcOVKKhO5KK61SSe717xI5XE6+6bqKMDlEYX45tOpOpFlK5TCB5A==
X-Received: by 2002:a05:6000:2283:b0:3c8:e9d3:c392 with SMTP id
 ffacd0b85a97d-3d1de3bc74dmr10668789f8f.19.1756902008603; 
 Wed, 03 Sep 2025 05:20:08 -0700 (PDT)
Received: from [10.223.47.213] (103.163.185.81.rev.sfr.net. [81.185.163.103])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276d5816sm23255601f8f.25.2025.09.03.05.20.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 05:20:07 -0700 (PDT)
Message-ID: <b65e2f61-97ac-4482-bf16-75bf107cf4c6@linaro.org>
Date: Wed, 3 Sep 2025 14:20:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/24] target/arm/hvf: switch
 hvf_arm_get_host_cpu_features to not create a vCPU
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-16-philmd@linaro.org>
 <30d20299-1797-4e49-8dba-5ce3ed00162e@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <30d20299-1797-4e49-8dba-5ce3ed00162e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 3/9/25 14:03, Richard Henderson wrote:
> On 9/3/25 12:06, Philippe Mathieu-Daudé wrote:
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index 3039c0987dc..fd209d23c1e 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -869,24 +869,25 @@ static bool 
>> hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>   {
>>       ARMISARegisters host_isar = {};
>>       const struct isar_regs {
>> -        int reg;
>> +        hv_feature_reg_t reg;
>>           uint64_t *val;
>>       } regs[] = {
>> -        { HV_SYS_REG_ID_AA64PFR0_EL1, 
>> &host_isar.idregs[ID_AA64PFR0_EL1_IDX] },
> 
> Versus the original, I suggested that this should be
> 
>      { HV_SYS_REG_ID_AA64PFR0_EL1, ID_AA64PFR0_EL1_IDX },
> 
> etc, so that the data structure could be static const.

Sorry I missed the comment. Good idea!

