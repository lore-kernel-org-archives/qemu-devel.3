Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4204CF34C3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 20:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swSko-00042q-JF; Thu, 03 Oct 2024 16:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swSkk-00041w-NN
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 16:48:50 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swSkj-0006ax-70
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 16:48:50 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cbbb1727eso13966595e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 13:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727988527; x=1728593327; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O+d+gREokMQfYaRx8CJFPzimuSEyThuIXy8uhC1mxxg=;
 b=TSy7Wi+TypDg7v0XQ1zYzxHQxoAID6JW3l5v9FV90ISIE4zGCKcFNIb01kdDVquuxy
 EE1SqDAKKGMhbDX138eI+E3Kv2ZuT76kKUxvDgg52Y4Bkt9Cz23SJaNBUwJl56Ks1Kff
 6VA5mkRCk6rHk80yYYlcb+MPvnp0FEElsDmkF3dYaVI7k5kv9XJmTXtXCG+qQ2/glwxb
 CM/qaEdzMeDRHl/SZZxPq3Ha5innsTAHASYptNMiCxDXhdgX4P8GcNlBP58C1nFDp8Jb
 IwQ1FiWFt7l4w+qNdkpZH8frUWDVGZXlVkUJLRPcjpWTyK7fIeP99wNKeR7LFOEnpxm0
 ee0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727988527; x=1728593327;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O+d+gREokMQfYaRx8CJFPzimuSEyThuIXy8uhC1mxxg=;
 b=FiBfZ2fqZ8F9lvDn4rEd9fcNJX9+bA2bynt8WkV4Vssrp3sH1b9XMlHHC9im0DcxFk
 j43S2etWKl8PZp4ZWvVNqo/WnC//rM8dwDN/aok7aGVB+QXwNhUjNSuClnkRsKJjb2Hj
 Mq/IE4p3JJexwJ30Jvvg3/tP69byaUohRy3dfcyotjvWyWEPbZFtRsq2aJXNHTEo6PN+
 T4r0d23Ry3fJiUPytOv3m6z0kf+cw3JwnubfY0NTZaZfxSq374ni4fSPc3kcC1dupiS0
 VrdONT5FY75McLQHk9VNa3XYb4V9uZxfiGBe9UyOKOzus8VyZ+Ue1jFhFnvLujlbT1LF
 e4Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5XCi0pvjymg12+yJMFe93PGUYEmeBlpQvMrCh0g0rlfNdsHEIeDq4QcnRx/l0GzVkZ4eNisGGzTeI@nongnu.org
X-Gm-Message-State: AOJu0YwgN8hrl5JbxLoWoJ+xjkFFOz0jSkZTxV+rR6pky7t7x6z89/d9
 0AOtdLrIuYBWxA64P+EmhOI05+ujBpGiFryoccQQADLbJzfPNfOa2bZZZsuTo5A=
X-Google-Smtp-Source: AGHT+IG8c01Gg0wr7F17qs/3Tk4DZlW6td1xpQdKOusZYSz0WYEDwq4Zy/CQ+LztT2I22+GmJjzTcw==
X-Received: by 2002:a05:6000:e08:b0:37c:d537:9dc0 with SMTP id
 ffacd0b85a97d-37d0e6d82e3mr415708f8f.12.1727988526979; 
 Thu, 03 Oct 2024 13:48:46 -0700 (PDT)
Received: from [172.33.27.23] (134.pool62-36-43.static.orange.es.
 [62.36.43.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f80255f01sm23489535e9.9.2024.10.03.13.48.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 13:48:46 -0700 (PDT)
Message-ID: <f20cebfe-027a-4664-82f0-3769c7047e38@linaro.org>
Date: Thu, 3 Oct 2024 22:48:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] hw/xtensa/xtfpga: Replace memcpy()+tswap32() by
 stl_endian_p()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, Huacai Chen
 <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-9-philmd@linaro.org>
 <257b0de0-6744-4ae8-a2c5-f05eec29a3f0@redhat.com>
 <0c28a435-0af6-450f-8558-14dddc6cb6a6@linaro.org>
 <a14cd43c-087b-4a5d-b036-39aa6a80e691@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a14cd43c-087b-4a5d-b036-39aa6a80e691@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 3/10/24 18:04, Pierrick Bouvier wrote:
> On 10/3/24 09:02, Philippe Mathieu-Daudé wrote:
>> On 30/9/24 16:32, Thomas Huth wrote:
>>> On 30/09/2024 09.34, Philippe Mathieu-Daudé wrote:
>>>> Replace a pair of memcpy() + tswap32() by stl_endian_p(),
>>>> which also swap the value using target endianness.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>    hw/xtensa/xtfpga.c | 6 ++----
>>>>    1 file changed, 2 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
>>>> index 228f00b045..521fe84b01 100644
>>>> --- a/hw/xtensa/xtfpga.c
>>>> +++ b/hw/xtensa/xtfpga.c
>>>> @@ -438,11 +438,9 @@ static void xtfpga_init(const XtfpgaBoardDesc
>>>> *board, MachineState *machine)
>>>>                const size_t boot_sz = TARGET_BIG_ENDIAN ? 
>>>> sizeof(boot_be)
>>>>                                                         : 
>>>> sizeof(boot_le);
>>>>                uint8_t *boot = TARGET_BIG_ENDIAN ? boot_be : boot_le;
>>>> -            uint32_t entry_pc = tswap32(entry_point);
>>>> -            uint32_t entry_a2 = tswap32(tagptr);
>>>> -            memcpy(boot + 4, &entry_pc, sizeof(entry_pc));
>>>> -            memcpy(boot + 8, &entry_a2, sizeof(entry_a2));
>>>> +            stl_endian_p(TARGET_BIG_ENDIAN, boot + 4, entry_point);
>>>> +            stl_endian_p(TARGET_BIG_ENDIAN, boot + 8, tagptr);
>>>
>>> Why don't you simply use stl_p() here?
>>
>> We want to remove the tswap32() calls...
>>
> 
> I think is point is that you could directly use stl_be_p, instead of 
> stl_endian_p(TARGET_BIT_ENDIAN, ...).

TARGET_BIG_ENDIAN is defined as 0 on little endian, and 1 on big one.

The following change isn't worth it:

   if (TARGET_BIG_ENDIAN) {
     stl_be_p(boot + 8, tagptr);
   } else {
     stl_le_p(boot + 8, tagptr);
   }

Maybe I'm missing Thomas point, as the xtfpga machines are available
for both xtensa-softmmu (LE) and xtensaeb-softmmu (BE).

> I don't know if your intent is to make be/le variant "private" and 
> relies only on endian_p though.

My intent is to enforce endian agnostic API uses when possible, and
use LE/BE specific variant when it is known at build time.

