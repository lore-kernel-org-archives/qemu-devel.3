Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1434CCF45D4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 01:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfT2G-0001Ha-9j; Mon, 12 Jan 2026 20:17:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfT26-0001Bq-3D
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 20:17:18 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfT24-0001PL-Ki
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 20:17:17 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-350fe1f8ea3so125233a91.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 17:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768267035; x=1768871835; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WNIxp9+oIDhWbXbqZljoYOObsGQg/DyVvwPoYUgmhgw=;
 b=qgqjetGftw4YzcXlzoUI8+3LDda77s3kzmUf0+OpWoRvarqRvvfr9TOMKRcBJuLCBO
 tuAcxdSaSqAr5PCsvj9Y2wnF43Gzufj7z0q2euYMI9d3lOR9CGARAolf29TaL9I1O7Ln
 GwKiFBhZJ+GobUcs4DCDcFdC0zQx+Tv8Y6aEMM7OMAi7uAOoSgGd9x+UL/TKw/T7ZyTa
 CmuBB1ALdXzGZQaPxGvk1YAvnt/t6bW+fbWnwDw7Ao3xMqtO00OBrBA6vC0aODRyiENk
 Xuhin//edsAkBCCugDAa3FRlR+XPRBEwfdK1wMbk/DakG+WI0/dVQkfS66ywjSnMrSn0
 FO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768267035; x=1768871835;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WNIxp9+oIDhWbXbqZljoYOObsGQg/DyVvwPoYUgmhgw=;
 b=ulG2wRriaj3QiPl6Sm0L1Z1VYiNE52fD2lNcDSM0UBpD6JLFK4TTooSXKnPBRjx9bz
 ZFO/ZptkIaQ9c4BCdFeMLw/W+bxHd01EPUZkAj70A0311CYS7n3cRfequ+WKpM4PYUoT
 KRydFqo8PpdHvHge63YsoRFUQPb3SYJyAMWlrg1a/J8qJn1EwLzuIE5E01ZU3z05T3Sk
 WdemKxqr6HSae9lwziPByZ6BeRqSN/lj9Nqs+xCbcqA0zH1qG8M5SCb4pl+PuwRoUNYL
 9SNjTh0DBTdp5KJRDxkcfH2B7D+2CUlB5vf4w/gpmJvmY0UPrKmF3biL/IHOPOUMa5qp
 ExHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsXWrEM0z5XHbqaG37scxaKHgjsJwNXuTvaRbPraC5CjdBIATFUXeR5Jn7FqjUNoof851GvNv83ppa@nongnu.org
X-Gm-Message-State: AOJu0YzQFwXiZiNg3ug8i1k+7YjfqeaTnbf0IMR2tXKbMz4zqTVcfJM0
 S/EdPw8jiORcIcOibcnvvPOLrHRjf+1qbRnSJnP6EOciWhRPLQScsxwFZB00OTq5qqM=
X-Gm-Gg: AY/fxX4NVcWvdX4grEZeqQptu1a8THUzRnmfNoyw6HM53vVmMj7HEZwp7JegZWceG/S
 3p8Th0xhFpiCEHH9r5JFmrU3MxmgHxc/M2MGcZrLXDaMZLoIZd0nLspq99fozSxihEM14C29/yK
 DSafgKBKWh7RuT8bjjI4VXiAmjfAZGsk7qWFQS6WeVALCG22AcCUwWWLBEmFdZ+hYyg3moupesZ
 GQ6u8Ojj/FJHb5JJXsJj9txowgkyvKf2gJXKuFobzcbhhl59S6MZjv2orgOMpqoWBZ5vI2w3Q7X
 8nUZmTsVWCHfDt04JmvCbb0cY0duIxHlNqjgszsvVBvcgYX7KNKol/4FZWMdSiP1FgFbMsDXl/b
 SfxChtwKdYOCdTt9b3DY5UqXVkxoCpDj8B8VrzAU2u2mYejxVGsazvp00nVcGZM+Yk/rAjk4Ps2
 nZQI4YPyTd8le9qEW7puHmk1NIaTU=
X-Google-Smtp-Source: AGHT+IFKE61Z9YBOke4ODn3SMYictQ0cZ5Ql6gin9FH9Q7r8gFrAZdSyCYDlLngTqYTw8b5kJvReiw==
X-Received: by 2002:a17:90b:3e43:b0:34a:b4a2:f0bf with SMTP id
 98e67ed59e1d1-34f68c28716mr19082495a91.16.1768267034639; 
 Mon, 12 Jan 2026 17:17:14 -0800 (PST)
Received: from [192.168.15.8] ([101.187.175.172])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-350ff06dc07sm172123a91.4.2026.01.12.17.17.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 17:17:14 -0800 (PST)
Message-ID: <216accff-56e3-4658-8cb3-d033b5e837b0@linaro.org>
Date: Tue, 13 Jan 2026 12:17:05 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/12] target/m68k: introduce env->reset_pc
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Yanan Wang <wangyanan55@huawei.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Thomas Huth <huth@tuxfamily.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
 <20260108143423.1378674-3-alex.bennee@linaro.org>
 <f9ad7045-9e66-4271-b3d9-006958824f55@linaro.org>
Content-Language: en-US
In-Reply-To: <f9ad7045-9e66-4271-b3d9-006958824f55@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 1/11/26 18:52, Richard Henderson wrote:
> On 1/9/26 01:34, Alex Bennée wrote:
>> To transition CPUs to use the multi-phase resettable logic we need to
>> stash some information for the reset handlers. Arm does this with
>> arm_boot_info but for m68k all we really need is the PC we should
>> reset to.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>   target/m68k/cpu.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
>> index d9db6a486a8..fda015c4b7b 100644
>> --- a/target/m68k/cpu.h
>> +++ b/target/m68k/cpu.h
>> @@ -155,6 +155,7 @@ typedef struct CPUArchState {
>>       /* Fields from here on are preserved across CPU reset. */
>>       uint64_t features;
>> +    uint32_t reset_pc;
>>   } CPUM68KState;
>>   /*
> 
> I think this ought to merge with something else.
> Just adding the field is clearly incomplete.

Nevermind, I now see how it's used for the various m68k machines.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

