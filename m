Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EBCE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 23:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUww7-0004Mo-UX; Mon, 06 Jan 2025 18:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tUww5-0004Md-V4
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 18:55:05 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tUww4-00019V-Bu
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 18:55:05 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2165cb60719so220365815ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 15:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736207702; x=1736812502; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n/iFhgUSm8/8XlLzLN81XPOf1KOBl79CC0AIjsyKUCU=;
 b=RGP7epl/H5wVkbl4wY7ey3NNiNQAzX8NKpcqEaT8Uqt0okWdivnWUGzLT3kIhDGdV1
 fzGwkslRmVh3lXtWWKvaeWLFzWFVK3PXMQOXs+7tlTG1I+Dw2nsAUr/mczWPCO6OJWfJ
 HhrDnH8lec0AO+GmcVq70zdBLqpG3kA65F/4VyR3SAiYl1tK8RF2xfQUnK73YUpOXyT+
 QE/72jh8xafTzMsE94M8ZkEfHpzlY1JWQ00qttK9fOVjqe8K3kdP71MIZcaL/0gFAEq1
 oIzbzPfbUovrAD4FjCH404sFXczSH+Nr9Vv5mTC7plvEDVLdIDwTxR+q45E8murBYAf7
 n2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736207702; x=1736812502;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n/iFhgUSm8/8XlLzLN81XPOf1KOBl79CC0AIjsyKUCU=;
 b=XSVUyEHEhmFPc5p3Ri52Crc8/XjLBfNgbIDmg+NImx+vaWr/pQP5KzR2L69y5TIXN8
 TzZOK88x5/rJXS2vZ1+iCZauCDGaeXcKJM7z275jv/4csy+2thfKBGdQVq1LIUP08Kce
 IUOEEXMJezyjHQNuoIlzZh/I62wUYrcgHM+ZWl5rIOvGgvYJ8ZnqWQiuG4bOJY20E+KM
 3TowVr/D1IdtCWEBUR7cXKLcj51AimEjTwzcOh3KLH4sSqUyF6vg3SvryiEwMAgr98hg
 5JqmVi7PhPr5dqj8McoqMAKZjEYyV0onvfARldjCpCL52QrunakycJ2w1W9CNkNCuvqY
 e9zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoBsXJ7KhZ+2XqooiiNPYJXjb/O3R3q/eInbCnqaER+TbyKtv9qQfDtdCo9GPOAxavwYhgbi9JYxPO@nongnu.org
X-Gm-Message-State: AOJu0YwnnpAjqkjGHGJboLbbkjyzqsZh17jilpBfFvdJZurcywxAT+PH
 VkOoCH2S1dYAzixOAtyf89s2wiZzZyr9XatXbapoBNXUFS+vCyiK3iMKefBPj9s=
X-Gm-Gg: ASbGncsuecYbi6D3YQwJUvISuClJEQyp6PFFKwlE2uHKHfMXEEAnne4S5frmC6Cghhp
 iCvipj+GJhoeuJZ1jlZRPbUvJQaYeUKmgF5kGfrS/L0ny472dJRIzwbcus2q0SL4mFX2bM0wGu+
 A8BOnP70evtpqid+kaV7d/DGt5FTiCJvh/Zc8ntIG4C8ZWV5hERicz9UCdr8RsH+4jpd7ElBRaj
 QoVlJUNfBKHHq6uKSrsDguPKJRMphW0JUe1etASEL1blka0eyEQpwn/7YlIfPTU4wOWcPR1SI9i
 yPWbBsYtNXVSmt5cR7thfK4xmzdGLEU=
X-Google-Smtp-Source: AGHT+IGZYABRFVqvA+z98m5CZzS85tYWDRRfmPaH7z4Mxd62VIPF/aE2+fxkRwBUiqYxq+bnrGC9YA==
X-Received: by 2002:a05:6a20:4394:b0:1e1:a716:3172 with SMTP id
 adf61e73a8af0-1e5e04609a8mr86807517637.12.1736207702454; 
 Mon, 06 Jan 2025 15:55:02 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbb5asm31928139b3a.93.2025.01.06.15.55.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 15:55:02 -0800 (PST)
Message-ID: <26ae11cb-af99-4ded-b2d1-4638279db944@linaro.org>
Date: Mon, 6 Jan 2025 15:54:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/73] tcg: Merge TCG_TARGET_HAS_{div,rem,div2}
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-22-richard.henderson@linaro.org>
 <9342a208-5a9c-4737-ad9d-1b115b66ed47@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <9342a208-5a9c-4737-ad9d-1b115b66ed47@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 1/6/25 13:49, Philippe Mathieu-Daudé wrote:
>> diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
>> index a6c7cdba5d..6734fd63e7 100644
>> --- a/tcg/ppc/tcg-target-has.h
>> +++ b/tcg/ppc/tcg-target-has.h
>> @@ -16,13 +16,14 @@
>>   #define have_altivec   (cpuinfo & CPUINFO_ALTIVEC)
>>   #define have_vsx       (cpuinfo & CPUINFO_VSX)
>> +/* optional integer instructions */
>> +#define TCG_TARGET_HAS_div(T)           1
>> +#define TCG_TARGET_HAS_rem(T)           1
> 
> Can you explain this change?
> 
>>   /* optional instructions automatically implemented */
>>   #define TCG_TARGET_HAS_ext8u_i32        0 /* andi */
>>   #define TCG_TARGET_HAS_ext16u_i32       0
>> -/* optional instructions */
>> -#define TCG_TARGET_HAS_div_i32          1
>> -#define TCG_TARGET_HAS_rem_i32          have_isa_3_00

Bug.  Fixed, thanks.


r~

