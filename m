Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEECDC83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 07:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZu1-00032h-DX; Tue, 15 Jul 2025 03:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZpS-0000vF-Ed
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 03:11:56 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZpQ-0007TL-Bs
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 03:11:54 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a6d1369d4eso2861584f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 00:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752563509; x=1753168309; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=soLuh7uzjqz1LeLKlFTtKgHcxIuT3Hs89rPzmWxa8UE=;
 b=cpeESc7FTXraw49FaKVfm/e+TvMMdafxW11X7cdB36FDjbANQzai+O9YxLQtmJt5QB
 8G+MkrvAD89RugTYmd09mjWePnTRzilrQpJjA3UOdLjnpv5eAJSNmtC+yEL21xHbUeVm
 I/JWmMJOA+lYT/94HX8qgSlkBrhJro3XUw1k1d1Or6Q6C/qMTYWtiMAOkYIPwNMYDZTT
 hz3fy8QK/PovERiZFW2z6QB9Dj9473MQjdNhEyqw/xDk7vBmzPtpHEcWG8SQU1LHFHbP
 exkp8zDYhyw4mX/IW7p00VVM1KGGc2In/fxeeyLrtWq9k68nFJtNML48vNXYf2KM15vn
 B6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752563509; x=1753168309;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=soLuh7uzjqz1LeLKlFTtKgHcxIuT3Hs89rPzmWxa8UE=;
 b=VNaW3i8HRNRH5/d8DiF9ls/3EXvIZW8Pf4JKmEEQTv7sFktTloJVsr4c6FUKkzn1Vb
 eyaU+ua7Xk1N4cbFCOXoekilkOQVzg7bK4e+BR6weNX63t+2wUCZTCqTHdCPiLclgrUK
 r0nrAOSVyK64rN/6xoT+iYDf4ok4Wsb3AWXtI9HeJzWzRINzIwk+gc2i67QjvhGp9HMs
 suHVxpYIcfTy3MizeUm3lTJLWGmVGYVohitLdhOZt+AC+vNGLVB36YnQxGphD5ynskYC
 HVH4jNrHVtTJsJn/oT5fG/rBV5qlO/PEr8L5LuYGD41ZL2uaRed/7WnYOOcvDnsYhB6b
 Nsgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH/pjmDUcsFifQiAW56IEHEtWkZ58ASlSJeU1ZuZySsNspqDNkwcnXA2k5ARuTmTceRNCNDiLODael@nongnu.org
X-Gm-Message-State: AOJu0Yx8i1ZVm9B7uSJgWslZuP4bcBHsc7D74fU2Xw56FpYs31ELoi2s
 QVlqY6rY/+PdNj5LjNyhqOWvvlRX4McMHK8ZcYCkMVgYWcz5ZZwhRh/PmfKcjZsnjVo=
X-Gm-Gg: ASbGncu+eHRv0ueMH7lM0owwfpoDJdDg4/TE0caZek6kvCcx4D4Ci897iNEDv4mhhwb
 MUTwOASx3+sOYIJQXHZqOp2PoszT9XiwzpFjqSdTn6l2eIG/mRwpdSkTDJxZfBzDovxTd+TS6Cd
 OELyAzSqaAu9p4lnBvH414wHwEAymrk+8Rc+MyII0dETFEegAsTmKRw30OPwb0CgesWmIpXTk+i
 9PiyHpdHCPiUlCNeQ1PUbhsxyKzb5Cu6LIUMUa0WGdkHo36An0FqDp6iXI6YT7m5BQL4JyFsmDm
 5tcsxY9y/Kauxn5iTYphOhhR/3JYgArZwzpxHcDiFFKyAgy8Otwc+bfU6hdUEdhE9dOrCMMY6yT
 CzhreV0F5XUlaHLTkbXbuYrlFWd9BxEkpoBez1As9+Ef2tOsqC4NrhTH8sAmV69Ff5GWXqsI=
X-Google-Smtp-Source: AGHT+IHFyCzYH+0DxLsUP/xPrOFlK5HgT3QiKPgOueBoXHrHvXU68nzU5nEMixuadqWMODzTwaQyAA==
X-Received: by 2002:a05:6000:290b:b0:3b3:9c75:acc6 with SMTP id
 ffacd0b85a97d-3b5f359d08dmr11783752f8f.59.1752563508693; 
 Tue, 15 Jul 2025 00:11:48 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1647sm14215422f8f.1.2025.07.15.00.11.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 00:11:48 -0700 (PDT)
Message-ID: <7a40eccd-d77b-4071-b498-bb998149a069@linaro.org>
Date: Tue, 15 Jul 2025 09:11:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/xen/arch_hvm: Unify x86 and ARM variants
To: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Anthony PERARD <anthony@xenproject.org>,
 David Woodhouse <dwmw@amazon.co.uk>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250513171737.74386-1-philmd@linaro.org>
 <ae482293-80a0-4b94-9c34-4a8d5ce18b49@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ae482293-80a0-4b94-9c34-4a8d5ce18b49@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 14/5/25 07:11, Xiaoyao Li wrote:
> On 5/14/2025 1:17 AM, Philippe Mathieu-Daudé wrote:
>> As each target declares the same prototypes, we can
>> use a single header, removing the TARGET_XXX uses.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ...
>> diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
>> index 4b26bcff7a5..1a9eeb01c8e 100644
>> --- a/hw/arm/xen-pvh.c
>> +++ b/hw/arm/xen-pvh.c
>> @@ -10,7 +10,6 @@
>>   #include "hw/boards.h"
>>   #include "system/system.h"
>>   #include "hw/xen/xen-pvh-common.h"
>> -#include "hw/xen/arch_hvm.h"
>>   #define TYPE_XEN_ARM  MACHINE_TYPE_NAME("xenpvh")
> 
> This chunk seems unrelated.

I'll split in 2 patches, thanks.

