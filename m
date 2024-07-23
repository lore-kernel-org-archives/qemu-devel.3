Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C51C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWCaE-0000bE-4I; Tue, 23 Jul 2024 06:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWCa2-0008WB-KL
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:17:15 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWCa0-0001OS-Sm
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:17:14 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a79f9a72a99so97984866b.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721729831; x=1722334631; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0wf60d5+X5f9Nbcemxz+CczAAti8q7IsbdQWVoE//kY=;
 b=HOFkXaLNdJbrxnxvzuf2NF/mULYWannjvFhm0rJ43QJPvib+LOmeOOHpCxbjKyJ8RK
 PLvweh1iBAMAb69W0hKgBcF5ZWYMuBEw6R5jRyEvpG2TkWz6X2I5VubnNhvJtcGqJKpo
 xOgK6NOAhym/MxEHosdHzb3owscHqVJZzRtRbs1sZ9MU8dTGsp0ln95XP0zsQ+3ySLN6
 th5UYx0Z0qAy7r6dijeA1uzw66wWGBD7bdX948sauMDsK7keDPKRcX7w65Nq1LpTq2TX
 j5Zkq+MZ8qrg7m0mwge62OO7H0SLAqFYe7Es2gtuTuzd+L3TtQ9K+mEdg0NiXZsAgaBm
 tgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721729831; x=1722334631;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0wf60d5+X5f9Nbcemxz+CczAAti8q7IsbdQWVoE//kY=;
 b=Do1JPCp/q4qOBSo/Iq0s+6N5J3rbGChTFAZH7RA8q4EKQT7caOausPMjbjfqvjpAAK
 6/k01TofthdiZeltwE53FRqZutwE7ztmy9u8chn7JYh/mtSRF3YXvmyMWFTjqfrH6Wku
 jwJa2TZmqm3U5i8SSbTpbj9g51fhx2sPT0EloBow8Socs27wknRA92f8cYQykgPYuu0+
 /PG9ISJG88zmae421hiyfC44s+OQt6a17L213EMlmUD6jOEbyaKqytYI9XH2S/EuWYmv
 AN+uJ8zkrRwI/fdf+hMzVwgzcUK2A/ENyPOCLsE8pUWsDHJdHSERhMBcQSb6lgN9zwDx
 +R4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/0k3txckcVSB4t5dxDW1yN8HrGiSkNr0XIHSYKZXJrZvIiBpwUDtp1bItd6GCLjwrpdcOqIh5TK79GSpr3KdIJrUkCG4=
X-Gm-Message-State: AOJu0YxGXxzMKuXIY4SCsbqKJKTysTUv9wQmKrzANpwyKNi2Lt5JpIS0
 JOOexDkijAQpld/KpIxtgFKaaT7bZwBUqkHx2em8JBJUNY7oVUFul1qzfgsoA5I=
X-Google-Smtp-Source: AGHT+IFQBHEzcfsb0OxS5nwyEB1KjkNKk7K7i3s4PGQsO168vo1O2dJpW5j0Hw1Wm8lWmqHBIKrd1w==
X-Received: by 2002:a17:907:3f0a:b0:a6f:4287:f196 with SMTP id
 a640c23a62f3a-a7a93f37bf9mr187375366b.2.1721729830973; 
 Tue, 23 Jul 2024 03:17:10 -0700 (PDT)
Received: from [192.168.203.175] (5.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.5]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c922d3fsm524827466b.183.2024.07.23.03.17.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 03:17:10 -0700 (PDT)
Message-ID: <9e7032bb-b029-4bed-b187-1525fe104e18@linaro.org>
Date: Tue, 23 Jul 2024 12:17:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/19] hw/intc/loongson_ipi: Extract
 loongson_ipi_common_finalize()
To: gaosong <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
References: <20240718133312.10324-1-philmd@linaro.org>
 <20240718133312.10324-5-philmd@linaro.org>
 <492e9968-a05d-44b2-b374-1d839e49b6e3@linaro.org>
 <2431160c-5f6e-cc99-5b3f-701ae352ba83@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2431160c-5f6e-cc99-5b3f-701ae352ba83@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 23/7/24 12:00, gaosong wrote:
> 在 2024/7/23 下午4:41, Philippe Mathieu-Daudé 写道:
>> On 18/7/24 15:32, Philippe Mathieu-Daudé wrote:
>>> From: Bibo Mao <maobibo@loongson.cn>
>>>
>>> In preparation to extract common IPI code in few commits,
>>> extract loongson_ipi_common_finalize().
>>>
>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>> [PMD: Extracted from bigger commit, added commit description]
>>> Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
>>> Tested-by: Bibo Mao <maobibo@loongson.cn>
>>> Acked-by: Song Gao <gaosong@loongson.cn>
>>> ---
>>>   hw/intc/loongson_ipi.c | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
>>> index d870af39c1..960d1e604f 100644
>>> --- a/hw/intc/loongson_ipi.c
>>> +++ b/hw/intc/loongson_ipi.c
>>> @@ -357,13 +357,18 @@ static void loongson_ipi_class_init(ObjectClass 
>>> *klass, void *data)
>>>       dc->vmsd = &vmstate_loongson_ipi;
>>>   }
>>>   -static void loongson_ipi_finalize(Object *obj)
>>> +static void loongson_ipi_common_finalize(Object *obj)
>>>   {
>>>       LoongsonIPIState *s = LOONGSON_IPI(obj);
>>>         g_free(s->cpu);
>>
>> Unfortunately the current code is bogus, @cpu is allocated in
>> loongson_ipi_realize(), a DeviceRealize handler, so must be
>> de-allocated in a DeviceUnrealize equivalent. Not at the instance
>> finalize cleanup which is too late because we could leak after
>> UNREALIZE -> REALIZE sequences.
>>
> Yes,  we should use  DeviecUnrealize to free s->cpu.
> 
> I will send a patch to correct it.

No need, I already wrote it, currently testing various build
configs before posting v6.


