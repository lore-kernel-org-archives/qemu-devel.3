Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91765E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 21:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUuWk-0007zW-K7; Mon, 06 Jan 2025 16:20:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUuWj-0007zM-AI
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:20:46 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUuWh-000324-Om
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:20:45 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4361f796586so153249255e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 13:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736198442; x=1736803242; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E2sQ6sNtNAcU4ikhS2BlN51AtMCxDHHHSmX31JLhjjQ=;
 b=QUYcSgJaq5c7QuJwik3O3M4/N9JCgeetHZMf+pU2GcIQFQJbSODyLITTqbnzTabd36
 2iba+ECHG4CAPOCqDGvx5GG/uonCdCladtjgq739Sy3Vo1Y6V/C2WwBUEa8WrLlCn3en
 2jSx0VUmC5ID8PJvXjkG5AW5ooF5Nmohcn1byEm1HeJ6nKT5uVFPGP9lA0wjKRO76PvE
 HWgYCBR3cIfxxnSF0mmKG8ITnfXFgojaQYkS6/YAT4W3fKh6nzObnoQ1H6w1xKU1ki0W
 cjFrc3WEfsfrU5J/JWOGRSKVhJKVQKASgyWhTMCAyykQm7SnkV2Q1ssL5pGMMUHQbcBi
 aniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736198442; x=1736803242;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E2sQ6sNtNAcU4ikhS2BlN51AtMCxDHHHSmX31JLhjjQ=;
 b=dyiH71E2dnvk+my9jetppYSFq/JPBc3Onp0zJy2DoNgTVz0NRrYUlbmWdDT5fHRdxP
 6S0d60r6hZUphIeEy/s14B6drWDBsDJJvUmjO0C5lCN8Yw/oZyYU+T1AdYjPmlSgSCvx
 8bfmAdzVmifGUU/+CHht3+k/xz3Q36pqRPGNZveaXoMMQW3OuJK7K0RW9FmIDgDInkTc
 TCMnwEX+VnBLdUG5aoeu2ERP2zmuEzUj67uK3ZHigT+fIZJtcfSKV8SuPO7kFlnPt+7l
 xbwkHu2Xmn8pHhDzMSFD4UeYwnXsybWQggA0t6cws3XbvLCBQI6LtU/wj8j18V8keO3v
 lZxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiVOERq83iRwlV0tXsHUa61mX9uteEUhdSh8XJbuwqTP8GDhaSa1BC30H3oZy6mLzcq9wjX2Fh8T4o@nongnu.org
X-Gm-Message-State: AOJu0Ywu6/T++mw4kLOpK5xCcBgqsivVD5vkZ8nCMTGKeGzqrXdifBnH
 UZHsr2MK4OxkOsmq6Agbw3zHCQUvRny8MKuaIQ+X51LgXsxMvlStvEBWvxDnqAU=
X-Gm-Gg: ASbGnctesqJ/habcpmmUGBoiXJQQ9vCNXMekwStHP0VXBs6Svlm5xTDSPCV9j1feKk8
 wCl1U1NqFniaQAw37spTYeZ8Ig8zfez+cdoJ9MfAiXWfmMEZg8jJH5ZXRCNau7P1SR+WiNAMzH/
 KYxQWJ79Si4dwpIYu0QbyBjHEwizUdWegmg28KbMYkUCdOtQ1N72d2zKBsUYbF3fxbYoHAJqA+N
 6GbqkjwsHdS05kP/o3Uw/D7a3uER5J2axh60YTLvCAit+0qqhV2xNi588uG5xG5/6EJbHZnRBzJ
 JDb7Sm3n2IuioIicjeQ4Q+aI
X-Google-Smtp-Source: AGHT+IH3iSBQS9C/e7NqH5nI9mfsRg1ceU//j87bB8yqd7K3Trx9a3gpKaZGpwHfFREAQNMVH6hFVQ==
X-Received: by 2002:a05:600c:3b86:b0:434:f0df:9fd with SMTP id
 5b1f17b1804b1-4366835c187mr471389695e9.2.1736198441895; 
 Mon, 06 Jan 2025 13:20:41 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6c66sm624856405e9.5.2025.01.06.13.20.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 13:20:40 -0800 (PST)
Message-ID: <60b88f82-6d8a-48d7-829d-ecbe61df4ceb@linaro.org>
Date: Mon, 6 Jan 2025 22:20:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] target: Only link capstone to targets requiring it
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>
References: <20250103231738.65413-1-philmd@linaro.org>
 <20250103231738.65413-2-philmd@linaro.org>
 <75d3b6cd-7899-4ea8-b762-784145111906@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <75d3b6cd-7899-4ea8-b762-784145111906@linaro.org>
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

On 5/1/25 01:57, Richard Henderson wrote:
> On 1/3/25 15:17, Philippe Mathieu-Daudé wrote:
>> No need to link capstone to targets which don't use it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   disas/meson.build        | 1 -
>>   target/arm/meson.build   | 1 +
>>   target/i386/meson.build  | 1 +
>>   target/ppc/meson.build   | 1 +
>>   target/s390x/meson.build | 1 +
>>   5 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/disas/meson.build b/disas/meson.build
>> index bbfa1197835..4e80adf36ae 100644
>> --- a/disas/meson.build
>> +++ b/disas/meson.build
>> @@ -20,4 +20,3 @@ common_ss.add(when: 'CONFIG_TCG', if_true: files(
>>   ))
>>   common_ss.add(files('disas-common.c'))
>>   system_ss.add(files('disas-mon.c'))
>> -specific_ss.add(capstone)
> 
> You need to think about which hosts require capstone as well,
> which is most of them.  This will help almost never.

Right, good point.


