Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C08C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0Hs-0000Dz-SS; Mon, 22 Jul 2024 17:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW0Hr-000072-5t
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:09:39 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW0Hp-0005W3-Fc
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:09:38 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-369cb9f086aso1346000f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721682575; x=1722287375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8bZMTtGKwIBDBaLkQH4s32NLPydgDEBlJxsa2VlsmTk=;
 b=Mu38cH6i7tk7gzTEi4gB/TR0JHUhLonVWsJkn8L5W/Z4RtvM1WLEwtNZFSLTWu2ZSY
 oWE31m2lpys92w+U+dUCCpu8Ba2lbHEJ8Tflt93d+qw7ZLzaN3y720Q0HroE24DBReRX
 ZcdFnBqImNXYuALKo89fNzWxMVsVWPDFWyTEV+KHTo4ha+CgCYB1gHmlSfaLHfkwqEhK
 TqJ75MRhHb7/VVlJmnHfcidWol+3FzTYFVwk/+44gYD+YOeVXnzqkonuk150CaWrwHpT
 TDu+IXp2/MylcP6URR8vzAo4nFc9pJTGOy12f9MxXUjZRzBW0EvcqQbon0GpUKJX0sdR
 u/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721682575; x=1722287375;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8bZMTtGKwIBDBaLkQH4s32NLPydgDEBlJxsa2VlsmTk=;
 b=OBCgTILexh5eamBIW0FT0MW+UG3lJfs9NKioSfCMFGfrLjabQX6RYuoFWVtMIfzcRV
 XS6aDuhjmUsyB+FaqyvaCWC6LMd6JbBKpGChjZHo6iyDmxaP+ZsaOTc5K2q8IRkCaJjx
 9WrD+Va5pMMXpYiO1IwfhdtiWB8zuvRbob5cE77sGFXCyblWGKLVf5yqA1HMqU5dwff9
 Fs/TPf8khKm+QlTjMYnD5FuG+lfjuOuhX252UU86YdeRKBODqM3/iTO/VByKe30C7W9N
 Ie5keE9/2nIeBBdiNNbTW7d0eCEkijGHsznSVZyTEyJx0GBNT+ahP4MJ/1gRm92rF/iT
 wIXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXOKOZmc1Sem7VjKnxNccsA4Y99K8ABbtgBY4u8RVNsTz/3wVQ9cadV4nf5OrkZj4VBk4ABkKrvQs1PaoT5zJLcUP4yv8=
X-Gm-Message-State: AOJu0YzgrUoHrlb+21d7Yf1gGxQb+TMpfHDeeAfYuC6VGc346ojXziYh
 +uFaxaLCejL/q4xM3mlkgvSh6o32DnMqs17Lib6/wNVsAVqfT0A9tTgkbmVDWRA=
X-Google-Smtp-Source: AGHT+IEXQZrcSC+BHMDNXX9JN68CO0ALnloFaawIGit3duqkcXI2WZKNjVyoF0q7tyI8r5NzoiQOeA==
X-Received: by 2002:a05:6000:2cf:b0:367:8fee:443b with SMTP id
 ffacd0b85a97d-369dee57b35mr809155f8f.41.1721682575538; 
 Mon, 22 Jul 2024 14:09:35 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868aa6esm9552136f8f.26.2024.07.22.14.09.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 14:09:35 -0700 (PDT)
Message-ID: <7c8a189c-4c8a-448d-bfce-cf1b0c993122@linaro.org>
Date: Mon, 22 Jul 2024 23:09:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/16] Final bits for 9.1-rc0 (docker, plugins, gdbstub,
 semihosting)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240722110413.118418-1-alex.bennee@linaro.org>
 <28ad74f2-1103-465f-b977-b1d48c06083e@linaro.org>
Content-Language: en-US
In-Reply-To: <28ad74f2-1103-465f-b977-b1d48c06083e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 22/7/24 23:07, Philippe Mathieu-Daudé wrote:
> Hi Alex,
> 
> On 22/7/24 13:03, Alex Bennée wrote:
>> warn: No match for commit c135d5eaafe7aa2533da663d8e5a34a424b71eb9 
>> found at https://gitlab.com/stsquad/qemu.git
>> warn: Are you sure you pushed 
>> 'pull-target-arm-20240711-209-gc135d5eaaf' there?
> 
> Is this warning expected?

Apparently the tag you pushed is pull-maintainer-9.1-rc0-220724-1.

> 
>> The following changes since commit 
>> a7ddb48bd1363c8bcdf42776d320289c42191f01:
>>
>>    Merge tag 'pull-aspeed-20240721' of 
>> https://github.com/legoater/qemu into staging (2024-07-22 07:52:05 +1000)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/stsquad/qemu.git 
>> pull-target-arm-20240711-209-gc135d5eaaf
>>
>> for you to fetch changes up to c135d5eaafe7aa2533da663d8e5a34a424b71eb9:
>>
>>    tests/tcg/aarch64: Fix test-mte.py (2024-07-22 09:38:17 +0100)
>>
>> ----------------------------------------------------------------
> 


