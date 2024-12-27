Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B788E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 05:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tR2ll-00046B-59; Fri, 27 Dec 2024 00:20:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tR2li-00043z-5Z
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 00:20:14 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tR2lg-0001iU-8o
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 00:20:13 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21634338cfdso119200975ad.2
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 21:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735276810; x=1735881610; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/m7z/enMfHtbRtl0kchp9s9A3/wOviF5YPB85Rsi6jc=;
 b=OdciGxj6KI1LaMeTqB7CrbAY8/qlXbMlWTQhfjAW5KAh5UezRJOkQ8B8cQwI3UuH7O
 hBSnCx+klA1xJDvTK/8gmLw/V5yqh/f0lEiiMRO/TRoHmejiUj9tT9w26h+0kaVbRv2o
 KNLWEzOJiCILvzGBE/ijpiN3X+CC+X7Vwc8U5fe04T6trnQJx2yrJfxqD2kJbx9NocbU
 5vCLnAfLAqjQK/8dM1HoGwcL5CIp4NIIj6ZUliH4tTvBehHE5SMZ758uGTA3b4UVuTx7
 A2/eUSm61qsoQ9TuxKhGvEKqXhFpuX0EqynXNLKEGpXnFmgAYdDcHj7K40uoD0O6zZOw
 flnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735276810; x=1735881610;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/m7z/enMfHtbRtl0kchp9s9A3/wOviF5YPB85Rsi6jc=;
 b=I/i2SLDz6RLYT/JRUFpPzdRaL9ieFCY52wAPpQJzFilDUmSitiePFoZKEKhFYj0VRb
 y/1LNcvkqzmdU2ewRAguntt5jwXY5wieBFYDZKXoGhChBFXCPHgXEwwEL0umd0MzsVdD
 vTFBjv5kN96pkrJp4HlEssryBX6rUPJDexewmio4EfOD/whK3xiAzhaewY/nXGFlGi2W
 tJI4+tWM2eZ8iGJWzPp/NuJ0G93Aes6pHY1oIj/gEnd13bKJQ/4ggbfnxR5KR+qGArK0
 mtG2Xym0QC/5INpWHRRmkkW9NlRTvZ5U99ob4pnl134u7Hhb0uj4Qe590+gPA9z8wla1
 8Nsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwxdlFm+yUFBVXJrCzN6WFcrXdrqanGSKK+HIJjNZ3H6BXAe7DWVYijm+y5rONuLcNPRMfD6Hh/XVA@nongnu.org
X-Gm-Message-State: AOJu0YwQZg6S/9vIpDL/pF6nSTAnOWG9D0rdhjavbgGbZxkqnKnli7hT
 R5FXHQFTZJ47dPTIZAeL8Ph78AtKUmscWkwACPPZIlgndv4/AK0cG8fGxcl5r7g=
X-Gm-Gg: ASbGncuG0O+07CcDmrBtvE2sb5VPPLQkifx/zvVybr9qOczTn5drNCPoAUG3dzl4B04
 Yd80lWPt8fuuJDB+XtA7708iQR5WXUQYcBBLgstpX7XX/YDChAkFeYnxPfQWPij1xGd08QzngHP
 n+uKzBAKIc83io6wUWecetbpaVv1cL6PXmkPUlXyxW8PyGXkhPH4T25PbwoRdGhQoo1VMpugrAJ
 CUgeaEeGDI3pTN59+hxUaSXMYc0qlkiutRI4QQ6jGCUuxrpc0GULuX0Onb410DAAabf+N7B0XvD
 /PYY9qfxFlBfoUdRR0oceyQjB8xHUmdAOuAiUrY=
X-Google-Smtp-Source: AGHT+IELM28clZdiMNr0z3pJCLNcHkUV6KwG/qQ/IHyVuK204ILyXhbGdsivTbt84G/o1kE6RPDDzg==
X-Received: by 2002:a05:6a21:3a8e:b0:1e2:5c9:65e0 with SMTP id
 adf61e73a8af0-1e5e07f0218mr45129113637.32.1735276810315; 
 Thu, 26 Dec 2024 21:20:10 -0800 (PST)
Received: from [192.168.125.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb851sm13794357b3a.132.2024.12.26.21.20.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 21:20:09 -0800 (PST)
Message-ID: <0a6b9d18-435e-4d38-b2f5-a561d474fd58@linaro.org>
Date: Thu, 26 Dec 2024 21:20:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/23] config: Add loongarch32-softmmu target
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-23-0414594f8cb5@flygoat.com>
 <f332d6b4-66c0-481c-8936-12892664d24f@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f332d6b4-66c0-481c-8936-12892664d24f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 12/26/24 14:58, Philippe Mathieu-Daudé wrote:
> On 26/12/24 22:19, Jiaxun Yang wrote:
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>   MAINTAINERS                                     | 4 ++--
>>   configs/devices/loongarch32-softmmu/default.mak | 7 +++++++
>>   configs/targets/loongarch32-softmmu.mak         | 7 +++++++
>>   3 files changed, 16 insertions(+), 2 deletions(-)
> 
> 
>> diff --git a/configs/targets/loongarch32-softmmu.mak b/configs/targets/loongarch32- 
>> softmmu.mak
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..50e0075a24ac6bf3717db967b03b816b52a25964
>> --- /dev/null
>> +++ b/configs/targets/loongarch32-softmmu.mak
>> @@ -0,0 +1,7 @@
>> +TARGET_ARCH=loongarch32
>> +TARGET_BASE_ARCH=loongarch
>> +TARGET_KVM_HAVE_GUEST_DEBUG=y
>> +TARGET_SUPPORTS_MTTCG=y
>> +TARGET_XML_FILES= gdb-xml/loongarch-base32.xml gdb-xml/loongarch-fpu.xml gdb-xml/ 
>> loongarch-lsx.xml gdb-xml/loongarch-lasx.xml
>> +# all boards require libfdt
>> +TARGET_NEED_FDT=y
>>
> 
> I'd really like, if possible, to not add a new target, but make the
> current loongarch64-softmmu.mak evolve to support both 32/64 modes.

Yes indeed.  I had assumed the preceding 32-bit target_ulong enablement was for linux-user.


r~

