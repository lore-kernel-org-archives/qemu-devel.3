Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF395C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 23:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj4O8-0005AP-Ei; Mon, 04 Aug 2025 19:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uj4Na-0004mI-Na
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 19:14:06 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uj4NY-0005g6-VD
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 19:14:06 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2406fe901c4so31639115ad.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 16:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754349243; x=1754954043; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yhGZwTRAmb4pNODzDAWvsXPfqa+Suxj/tcgxhILJfjs=;
 b=FxH4Pfx/AgGecgCcTD/7R+oUfOrzIIII4Y74X2Zaw1AJPRHHXXQd4+l8IV46i5TIbu
 3PjqvGmkERzJY9cGOnR5i41TPnui0VuwooqScnjr5MLXxgx3vlCMOLfjl3+0Pt9zfu90
 umLVNLYfae4Znn2Qdl+cCSTReMR3OgFDMuo9Lmz242Kf5nnoS2X7o8bZ+Do0/dggTvhf
 6r44ksnPga2pcjQrSaeGIhIVOqhkOL6ACs5/WqvU5StVACLc+C6YngmvmWfd86o66Grx
 DXbtC2WA8AVUT5fYuFG3rv4jNaOwi8glNdFZmtluEu1kxGynPiADaElkYahaEmWhlHWg
 yXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754349243; x=1754954043;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yhGZwTRAmb4pNODzDAWvsXPfqa+Suxj/tcgxhILJfjs=;
 b=A0LsFBEt4e2AaiPus3FhlK5O9BOSh97Iq3zgwa88nr9xvnd5n7Mb88BNFI/1Ult3Gt
 7zvLj6atAs3gkRa7cBgtiU6uQHI8vEPaTSWS4aO1KA1F3StrUZj4Aoj+TrQFDI2w7WSL
 bwr4aCpAv7irCXA8Hy7Pgxn8KHexx5pC48UAeFrLIlZL2JRFRKCVvCl2k5N8M6wr4f8r
 ybGcO7eyQAiz8iJUUcCtiutoKhJauyJeFz8LwFuYruGT43SuP2LCE1LBKrVaFZ8zf5ru
 YZ+JRD8WTmu7cSoPxr4bwAcXobozq7g3M3lzqKryW+PBbhKGAhT3XwYSA8mEnXOROX67
 eZZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuET5H8QH9lnlkZ30aazv0NExHOfdrc4S+Pk/VYVlbdKVZujpGZlJZ5kUbDDYLZSqSybJ/y9vG+9Hp@nongnu.org
X-Gm-Message-State: AOJu0Ywnz6T9aTuWUQazJGCvsnPF7dAwa7Un8H/ww4dBtMCnsyGTQloS
 f+7Mb4V+rtP4X6JI90ez6ZkvJC9dBLvK54Ct7kvVswMEnmpmqPZ2p8ziKaCXsdSlZB4=
X-Gm-Gg: ASbGnct7a4cpKavDNDKB3Mai9MOGt6ttCJqCnidXBt94iCWljmDm4uCbQoTp8n/uiSY
 zcCqkIdL1PKmv78DkejATk0kgkgmXuY2oMAKxgFhBcI2M5KjoOw+RG/au2DUlVqsJEhQM4s/5nZ
 KBQaZ5UwFMxZ+X4i27i0xOD2cZOXmsGgLCN7kCX3VSh5yM71QpuzqsfXLiUwW0c7hvy49AjvEJp
 TApYdgvZd9p5TrrmS75uOCS0xiid+F+7G49QMJ4mt6QajSnpOLM+60/4kxuvC5AjZRPgyVH2FPc
 zqRSCqOD2+Oj8KjxjE3B0xXH6lARyWSgLmOQriB+8yQFbQz1Hho1k4tMP331XFkxUPZNNMD0ddC
 L6Oi8U+vhyQMiYRd0LSfwsK0FvMwa8X/C3xRBxZcdvuOs2TSbQgg=
X-Google-Smtp-Source: AGHT+IH+CTxF2nCVh/2YB+SpKUh++dJQ3VlHTf5l2k25U9cOTTXlEoW8FYdYFCyf1C1zDU94EOlunw==
X-Received: by 2002:a17:902:c951:b0:240:25f3:2115 with SMTP id
 d9443c01a7336-24246f66529mr165124555ad.12.1754349243310; 
 Mon, 04 Aug 2025 16:14:03 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899b6casm117017975ad.127.2025.08.04.16.14.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 16:14:02 -0700 (PDT)
Message-ID: <cb5aa557-aab8-4a6f-977b-b9d15a5c6799@linaro.org>
Date: Tue, 5 Aug 2025 09:13:58 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/17] hw/arm, accel/hvf, whpx: unify
 get_physical_address_range between WHPX and HVF
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-15-mohamed@unpredictable.fr>
 <e5bfbc26-de3d-4f4c-b15d-6c7ea1b29e49@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <e5bfbc26-de3d-4f4c-b15d-6c7ea1b29e49@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/5/25 09:03, Philippe Mathieu-Daudé wrote:
> On 4/8/25 16:23, Mohamed Mediouni wrote:
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>   accel/hvf/hvf-all.c        |  7 +++++--
>>   hw/arm/virt.c              | 41 ++++----------------------------------
>>   include/hw/boards.h        |  4 ++--
>>   include/system/hvf_int.h   |  2 ++
>>   target/arm/hvf-stub.c      | 20 -------------------
>>   target/arm/hvf/hvf.c       |  6 +++---
>>   target/arm/hvf_arm.h       |  3 ---
>>   target/arm/meson.build     |  1 -
>>   target/arm/whpx/whpx-all.c |  5 +++--
>>   target/i386/hvf/hvf.c      | 10 ++++++++++
>>   10 files changed, 29 insertions(+), 70 deletions(-)
>>   delete mode 100644 target/arm/hvf-stub.c
> 
> 
>> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
>> index 818b50419f..fa06e3b815 100644
>> --- a/target/i386/hvf/hvf.c
>> +++ b/target/i386/hvf/hvf.c
>> @@ -225,6 +225,16 @@ int hvf_arch_init(void)
>>       return 0;
>>   }
>> +uint32_t hvf_arch_get_default_ipa_bit_size(void)
>> +{
>> +    return 48;
>> +}
>> +
>> +uint32_t hvf_arch_get_max_ipa_bit_size(void)
>> +{
>> +    return 48;
> 
> These don't make much sense on x86...

They don't *not* make sense.  x86 does have two-stage translation, though it has both 
48-bit and 52-bit translation.

While this is only invoked from hw/arm/virt.c at present, I can see that by piping the 
path through accel/hvf/ means that x86 needs to provide the symbols.  Though perhaps they 
should just be g_assert_not_reached() stubs for now.


r~

