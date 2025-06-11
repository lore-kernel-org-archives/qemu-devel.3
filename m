Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E76C71136
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 22:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPUHd-0002y6-A7; Wed, 11 Jun 2025 18:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uPUHY-0002xq-9i
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 18:50:56 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uPUHU-0006x9-Bb
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 18:50:54 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-747fc77bb2aso419549b3a.3
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 15:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749682250; x=1750287050; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qr8Vm26bwEB8sBKWoq9jz9MbSYIekiYYwK0RS2Jde2I=;
 b=N6jg+f8YykpvvbKYl4xKLJNciEwY8ae1HIIT0SA3qr4Hp7vt/U2FvHFPDO6JUxS+BY
 hj7Mo50ZnSvDJ5fssKVFmzNTuiCNZTtCeomoVBAI5PjTp6uiOrZEooBz5UwT7adeGOGi
 XaiTgxYZtNzoefZefCDYC9G6Bmv0EQjfihC7KPiXMWEbCX0492lVQ1+R9eyJtUQ+raB4
 e8ZQrb+8V8U9AxjhJA5jnx3FVvruOm7SokKPIfBjgw0z1+KGK31uSYnNNp6Mv8fhFJiH
 PEHPOQbsNQcy6nMxaRacC2rWz3wfwXQiGDDv27eH8B4pSYer4P+etJ8xUYY++IOw5LFO
 L9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749682250; x=1750287050;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qr8Vm26bwEB8sBKWoq9jz9MbSYIekiYYwK0RS2Jde2I=;
 b=e5ngzvz7C7kZFBuajN/7o8FoGkaLsgmQzifElStIFDP17l/99xk7fVOKiZrUGG2IQB
 BR/fFdAQxZ198M/cVaSxiV9aI0eCpCZuO14VN1aAFkFvUofr6pX6ZlgMz0Di/XI6hPLn
 suDDQMUb4l5GWVdvgXACXMpCqI0YC03UZJY2V9a+gbpUWcphkp8kekzD943MnCWp6l/L
 RMgXqtdUJbQWrzPVBdJ9/qVPl6ngPf5/MGf6kblOLdV+14XzF4GiVYtoQked2xVJKvel
 9QOtXBgmfeSL/WFnONfyoYizVTeXSZ1VT9//dLWzJH/8Z5DfCmtqbVj8lhu0OI0bV4kN
 EQqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW08SKjdsipH0CcZ4JY43sKgzsg2j+LY95xLVuRdWzJjXy1USn4GyiCYFeZedlYh5/vcxQFUlSgogno@nongnu.org
X-Gm-Message-State: AOJu0YxYFww85Q1N1lpO5UIeaUu6YOKSr1gDswasHkpWDAyrk5GyeJtR
 mUNLInMvjaItot0uK2BPyaSfFTvFWFtx1lzorDi3bWSsTD0HEjgi2ctn
X-Gm-Gg: ASbGncuHFTYWk1gYoRTo3IsesHff4OAO/anp8kg6bMOvYVhJjmxTMA5YHYzq5Ja8aoF
 IaHJ96obJgnzR0A97M1/1HsSpRv9GZTnyyBJMlZpr1E1fqQJG7L+YCZn6vijJsLD9sVDcIZ1tQf
 EHoESDjCcE85dJH7r+sfPTSYq9NdVNzlTnsLY9P7MITxw6PskpKrYSZA2ufjFsB0PBCwXc3LCML
 vgUuRcGpSbAci+hPaICwz0fWhhPo08m9BWDsVYVFUBWBfGS53uc/UCEiLfjAtZYXCMyHkdHgRLs
 WJ8Qzmrqt9/zonPlHkI8061GZRUrAWRJfN+TE3YmaG+9b3nXiMX6xifa0czRW/19Pw==
X-Google-Smtp-Source: AGHT+IEyrWZ8iR8OeTCL/DSwOCNxYzeP0X+qiagZHMMcpIikW8vLwFD0zyKePT2hQuq++7Jw31Sz0g==
X-Received: by 2002:a05:6a21:33a5:b0:21f:54aa:2004 with SMTP id
 adf61e73a8af0-21f97762fc2mr2246788637.2.1749682250225; 
 Wed, 11 Jun 2025 15:50:50 -0700 (PDT)
Received: from [192.168.1.119] ([50.46.174.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-748809d2b63sm92666b3a.83.2025.06.11.15.50.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 15:50:49 -0700 (PDT)
Message-ID: <bee281b0-529f-4fe5-af33-82bc7313375c@gmail.com>
Date: Wed, 11 Jun 2025 15:50:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 7/8] plugins: Add hypercalls plugin and test
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20250609193841.348076-1-rowanbhart@gmail.com>
 <20250609193841.348076-8-rowanbhart@gmail.com>
 <02f706f1-4dde-4f6f-b806-7882d57e5de6@linaro.org>
Content-Language: en-US
From: Rowan Hart <rowanbhart@gmail.com>
In-Reply-To: <02f706f1-4dde-4f6f-b806-7882d57e5de6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

>> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
>> ---
>>   tests/tcg/Makefile.target                     |   1 +
>>   tests/tcg/plugins/hypercalls.c                | 547 ++++++++++++++++++
>>   tests/tcg/plugins/meson.build                 |   2 +-
>>   tests/tcg/x86_64/Makefile.softmmu-target      |   6 +-
>>   tests/tcg/x86_64/system/hypercalls-target.c   |  40 ++
>>   .../tcg/x86_64/system/validate-hypercalls.py  |  40 ++
>>   6 files changed, 634 insertions(+), 2 deletions(-)
>>   create mode 100644 tests/tcg/plugins/hypercalls.c
>>   create mode 100644 tests/tcg/x86_64/system/hypercalls-target.c
>>   create mode 100755 tests/tcg/x86_64/system/validate-hypercalls.py
>
> Hypercalls are a very nice idea, and could help to write code aware of 
> instrumentation, to send specific events to a plugin.
>
> Introducing this in a specific plugin is an excellent proof of 
> concept, but if we want something upstream, we'll need a proper plugin 
> API implementation. That means one where a plugin can register a 
> specific hypercall_nr (checking it's only registered once), and can 
> read arguments and return values: in short, reinventing a proper 
> syscall convention. This is what has been achieved in the current 
> patch, the idea would to wrap all that on QEMU plugins side.
>
> In more, we should provide a portable header, allowing any code to 
> include it. All that with fixed width types, so it's not affected by 
> differences between architectures. This way, any system code, or user 
> code, can include this, and communicate with a (compatible) plugin 
> easily.
>
> No need to cover all architectures at once, we can start with only 
> i386* and arm* targets, and extend that later.
>
> That said, I think we should leave this out of the current series for 
> now, as it's not directly related to what is introduced, but it's 
> definitely something that would be nice to see in the future, with the 
> requirements above.
>
> Thanks,
> Pierrick


Sure, this plugin is honestly just designed to test the new memory write 
capability in a realistic way, but since the patch plugin does that too 
I think it's basically redundant. I'll drop it from this series and we 
can circle back on hypercalls at a later time, because I think coming up 
with a good specification will take some input from people with a more 
intimate idea of the various architectures other than x86 than I have.

-Rowan


