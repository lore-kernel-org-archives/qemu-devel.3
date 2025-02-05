Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C23C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 18:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfjtm-0001vt-BB; Wed, 05 Feb 2025 13:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfjtf-0001vY-R9
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 13:13:12 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfjtX-00070k-5C
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 13:13:04 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2f9d3d0f55dso2734834a91.1
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 10:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738779180; x=1739383980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WdM1+Mlmlw/7q1fz2L115JqpGnkud5UgwC7sjxwk2r4=;
 b=BKoWug4rTqnCyeEL9+zYgTO+4s9KEETTTUYaK1EikHTwkFhvg2HyPw1KPp6UDEbS9P
 ut3nltxvJATkp0+Xe5uDyZ1IfdaWG1nh4MY08UyPft3jnt04H/pqt7mUMCF4lN8mWs6E
 IGHOnf6l27CeE0S56ZnVoY0oUsDrJu+Uzh4tQ5y0vGHV4fdV6Ywypf8f1hEcdkwx/S0e
 TWGdDs0eWx30SG16E6s4Ch+dyildbu13dErDDg9HGgJLocDvhHy+/aaBv5TwJXeK5wdg
 jzvLPeBhsQN0TemxWJnhxSHdNrdhMpVry5Wg3pivAAdhwYRUIgNLSmp5E36qFGmyrYO5
 Hmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738779180; x=1739383980;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WdM1+Mlmlw/7q1fz2L115JqpGnkud5UgwC7sjxwk2r4=;
 b=YaQOP7KNMIe5D7/cj7NKVIgZ+KDL2iDtD2TG0gnUcYxbwHBZC6dMHEIsW95xaIP/1k
 SBwrUspezLV3sDMnJZ59MuhdsdpOb5aqDhGeXo5Mv1B3wxFOCfgCAYPqKO073nZyEqJE
 8Uof/mltJnZqFFvx1X0OP+1S9xNHDnk6D5STDhikH2VLRz8viJ+Emndx+oag0yRAurO4
 /e013+FrfLHqstLGmgyZxAS1hxUbiCiqsTBzAQJYSnOptYZ41oZfcYhb3R4oZUWOL84r
 0VRcdn8NM2RqR+cvadr119jDvTv5zu3Hgm+0EbLEslgZK1SKhT3Jia8D8l60jHT2CDXJ
 /U6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0RXCl5lXRZkjeaVYDL+dM8AJR05vDKx7Y1sYnDQDom9sgZ4+ZwxHGmmCsrDEro4S7jDODyXrGwIJS@nongnu.org
X-Gm-Message-State: AOJu0YwkURs12ekBuQUpl69fFvZVapeUjyhKJpLv9DD0ZvA33DR1JrGe
 tf5BFJBon2l7PDzrvDsCiF9e5yxpb6Nn2IVq0Hc6KNQadPTRWH4CEHXVZ2nGU2U=
X-Gm-Gg: ASbGncvB1/GJC1RjdcpH8n2bzS32Q9n42YjaOWwqVWo1tl7F3pdP69PkqKBUghW5M0v
 +rSo2WzqMFPHGIrHbTlNdcHFlTTFRC3l1KN1IidOd6L9WrkbltDk84rKEEhuj/UlxAnN2TLbAkq
 /kcm9I4St0Q/LkBjSy1+IaM9jIcCsH+FK05Q+Z41c4b4NA1nQpvs3r2H+9OPsJatbpBByYVYS/L
 NxrpwcNvhXSr4n4KxUq4F6ZKo9zWpOtLHi8kd48zf8WuylNxE7+uV2Bgz7fHIIVOMsTruTDpxw/
 wYEg+ONp4tYbKAHv3IFv5CZgJFjsTG1h6HvVpVLcGOmOVjxQ/7tXKeo=
X-Google-Smtp-Source: AGHT+IFkzEnZy2OpTHxupxcEldsfzpRUJt2BnpkhlTvfb8Bc7rv5mmpaAlT8rnr1esJy49T9xww+aQ==
X-Received: by 2002:a17:90b:4cd2:b0:2ee:c918:cd60 with SMTP id
 98e67ed59e1d1-2f9e078b720mr5947260a91.20.1738779179964; 
 Wed, 05 Feb 2025 10:12:59 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9e1d7a61esm1901567a91.19.2025.02.05.10.12.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 10:12:59 -0800 (PST)
Message-ID: <502c72da-9079-46d8-9d1c-4a63d2da86c4@linaro.org>
Date: Wed, 5 Feb 2025 10:12:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/12] meson: Deprecate 32-bit host support
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, thuth@redhat.com,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250204215359.1238808-1-richard.henderson@linaro.org>
 <20250204215359.1238808-12-richard.henderson@linaro.org>
 <adce8772-d473-4b1d-b0f4-1f921ce89932@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <adce8772-d473-4b1d-b0f4-1f921ce89932@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 2/5/25 10:05, Philippe Mathieu-Daudé wrote:
> On 4/2/25 22:53, Richard Henderson wrote:
>> We deprecated i686 system mode support for qemu 8.0.  However, to
>> make real cleanups to TCG we need to deprecate all 32-bit hosts.
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   docs/about/deprecated.rst | 7 +++++++
>>   meson.build               | 8 +++-----
>>   2 files changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 4a3c302962..7c61d0ba16 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -204,6 +204,13 @@ is going to be so much slower it wouldn't make sense for any serious
>>   instrumentation. Due to implementation differences there will also be
>>   anomalies in things like memory instrumentation.
>> +32-bit host operating systems (since 10.0)
>> +''''''''''''''''''''''''''''''''''''''''''
>> +
>> +Keeping 32-bit host support alive is a substantial burden for the
>> +QEMU project.  Thus QEMU will in future drop the support for all
>> +32-bit host systems.
>> +
>>   System emulator CPUs
>>   --------------------
>> diff --git a/meson.build b/meson.build
>> index aa1ca8355d..3347b0a553 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -4843,14 +4843,12 @@ if host_arch == 'unknown'
>>       message('configure has succeeded and you can continue to build, but')
>>       message('QEMU will use a slow interpreter to emulate the target CPU.')
>>     endif
>> -elif host_arch == 'mips'
>> +elif host_long_bits < 64
>>     message()
>>     warning('DEPRECATED HOST CPU')
>>     message()
>> -  message('Support for CPU host architecture ' + cpu + ' is going to be')
>> -  message('dropped as soon as the QEMU project stops supporting Debian 12')
>> -  message('("Bookworm"). Going forward, the QEMU project will not guarantee')
>> -  message('that QEMU will compile or work on this host CPU.')
>> +  message('Support for 32-bit CPU host architecture ' + cpu + ' is going')
>> +  message('to be dropped in a future QEMU release.')
> 
> This change still allows us to remove 32-bit mips host support before
> the other architectures, right?
No, bookworm goes into LTS in June 2026, which would match QEMU 11.1 release.
If we add this now, we could (selectively) remove 32-bit support earlier than that.


r~

