Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F14CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 17:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utqvM-0008NN-2n; Wed, 03 Sep 2025 13:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utqvG-0008Ml-4X
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 13:05:26 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utqvE-0004Qg-Cg
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 13:05:25 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45b8b2712d8so1793665e9.3
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 10:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756919121; x=1757523921; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KKg3T0VzkyNGt9Y2ird6rFs/+P4V8YZDNFyw3M3VLFA=;
 b=QhVU6BQdqYr+/T7QUNAITMmYU9rWaerky4YorUl1ZavcVgLttyNmbHf6YjYD4+O1DL
 E02tRV8EUgit7XNoP7Gcy6ueOvLg9uJWZD1UOKn2W5GPR+TuyxwEkTYLCMEnbAfylHid
 st8jajRcfP4Mujmy60KHeIsXnQJuKPTStVE4dfKlyez7XWH61oyCgDCT/B2iLDHj+MsQ
 pHwy3sWglJ3A9chWIP1z3HCkXh86+aqrNFT3CWnzaE0hUciNv6u9YWibgx+Pn19fjtzX
 8lMZQv9WYz9QUTakzezHkB9KWVawTD2b0hVSuL1c7SBB/Itgi0pZkp2gasOgwCj7rNpJ
 vgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756919121; x=1757523921;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KKg3T0VzkyNGt9Y2ird6rFs/+P4V8YZDNFyw3M3VLFA=;
 b=RbsT07g9NjaN+K+4aHLCepfVQEsTSvKK1w5Uph05k695Zq4y5bN06Cr3fMWcpxbfHr
 nzmXbXY1+9RXn9YesKM7u/gjDAwv/MMWglXpYKhejHRlrBp1H3X2/EpgwQtqWvtAN1vs
 X/l2dBA0GLiRLyF8KyiPK5udmO+fwxfv4UJ6ZLTxacRuiGXiFAWivwZ7CaaR1HFotBDD
 hEWOjLEMOb5A1mp7iLh+UFwJYMKMEKdd4hW3Gwzww4Xjz7nA1WuNzxpwIEaMDWLA/bOD
 5P7vI40u8yq0c0omz0zQysJBcWILNe9b2ibFm0Gqyy06EsNNLwl71bbM9fT59ta3WxPd
 MkOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD8Kp7wVkHRK/3QHmS6tz0FsCPE6y9Ci4h9tIp3MeJdLai3kWeGF8sSzYWDBTBS2xeGRvw2lvu8wFD@nongnu.org
X-Gm-Message-State: AOJu0Yx7tUmlXzJOyXwgVZicU+GXQrf0JfMRwRXWE1/bl2VsuqlQ4Fl0
 BLdDI7Q0CRC4Jxsc+KMA6yQ6b/rNq852yRgKWq9Nqcv/6HwXsDsuk1Z/KKe1mJ6XZsA=
X-Gm-Gg: ASbGncuCkDXQnZTrwYpEzZE7s/UTMnPuUcu59J4RRyzENMlAtYcNtw6LdebgmRWfDkQ
 b9E/u15maiozTX2ORToeuYQs9v11EzBcl3bpjH9ahtO0JiH7s+5OHweeIoOOb1ewyz8sIeFlR6V
 lUh+BX/7EtPCe3Br5vuVK9sFaarpsKZbsP2OhnQj/n5p5LD7piOVaqW7X8Aw7qJi2kpGSaDVteo
 qMqqpRHIasO628OxqoF4w/cU7kFQBIkY89NeGNPiZ96o+iHBuxKYHeYDEgtN7EFiQISuFBFjJw2
 jpG7eEiKVodtybdVQI+K6NmAyP3erSYrRHUHq3imZXPNcmgiqdSlVVyI53CEEfCJsSuovyhLpP2
 MHjpRCtGLBgsdlHH8j3MlBEmdn8Dk/7jUcPpSh4lj8xVD/xYKhzjwzC7SiNdyxy21ahzaL2v77K
 MA
X-Google-Smtp-Source: AGHT+IEFupT2dJ0aE1zSaVfQjDg/Gkk0/3bNAXi6jZ/7TwgMH6r27e/6Iy0oiJ2VIzjZXelUyoNmuQ==
X-Received: by 2002:a05:600c:4e91:b0:45d:5c71:76a9 with SMTP id
 5b1f17b1804b1-45d5c71790bmr10293985e9.24.1756919121337; 
 Wed, 03 Sep 2025 10:05:21 -0700 (PDT)
Received: from [192.168.1.138] (93-34-129-33.ip49.fastwebnet.it.
 [93.34.129.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d729a96912sm12172889f8f.8.2025.09.03.10.05.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 10:05:20 -0700 (PDT)
Message-ID: <2c4227ac-8f94-4599-a950-aef9a5110991@linaro.org>
Date: Wed, 3 Sep 2025 19:05:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/24] target/arm/hvf: Mention hvf_wfi() must run on vCPU
 thread
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-9-philmd@linaro.org>
 <c51382aa-070f-4441-a707-a29d87093b48@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c51382aa-070f-4441-a707-a29d87093b48@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 3/9/25 14:34, Richard Henderson wrote:
> On 9/3/25 12:06, Philippe Mathieu-Daudé wrote:
>> Since hvf_wfi() calls hv_vcpu_get_sys_reg(), which
>> must run on a vCPU, it also must. Mention it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/arm/hvf/hvf.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index d87a41bcc53..05fc591b523 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -1836,6 +1836,7 @@ static void hvf_wait_for_ipi(CPUState *cpu, 
>> struct timespec *ts)
>>       bql_lock();
>>   }
>> +/* Must be called by the owning thread */
>>   static void hvf_wfi(CPUState *cpu)
>>   {
>>       ARMCPU *arm_cpu = ARM_CPU(cpu);
> 
> How can it not?  Are all these separate patches and annotations helpful?

Well they helped me understand the locking issue in patch 15 in
hvf_arm_get_host_cpu_features().

