Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6FFE77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 23:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQx9U-0001Qf-Aa; Thu, 26 Dec 2024 18:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQx9P-0001QK-Vj
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 18:20:21 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQx9O-000197-Du
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 18:20:19 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso45838505e9.0
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 15:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735255216; x=1735860016; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ooKUSInrQyoQqSKqPXJ7lQm+0JQDbHpFynR34wPTuoo=;
 b=AXXLBw/uP8gbIsYUC54j2g2ZoPv1pkNL+SNJgeAKaBIf7MONKs13vbZXxm1Ta4ehJq
 7heirGPsu/pHAu52TnlgEB9zV60xFB5I8kFl1AislOMlI6EKvseq78rM2aCo/DN0/8wq
 OtCrbDk2othPcBChgsRfoOXRmiV4amEvpGYkBKkG8ZNm8NmQlSW5ZaTbeUlEVmZZ1Jv8
 vyharxaQ643Bt0Edop0jgXVMKk1U3NbrfFaMeO9pXQjMKNabeR+/VMlEBc/qXfDg54Ww
 L0rbgpe4jOF9xsquBAcaMy3aMINzquoHCw/P8Lf303GyO+9h3Sg3DX798xcKQw/z7P3l
 RKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735255216; x=1735860016;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ooKUSInrQyoQqSKqPXJ7lQm+0JQDbHpFynR34wPTuoo=;
 b=TOYodPS+1cDiBOd+iaKnY15YlFD4pHYEJidwGkxhneJQ6mTBGoZMcXPqqLQnMZ7mkT
 4RqIXHAQF5vmu7zqdTmDiMPBQsLYGzZCZL7NNc9irZAs4IV6Z09hTCpDI2oT6I7M5Bi1
 k8LSY3X2swbVbU39c8mWleWxl/fa43Dp0/HNBPjXRt+U7gc+/BfLyC5rRzT5H4U0VEBH
 6OoLuX9eUIzzsaJ2mBDlXG/h9M0FAZEXW7Cigf++7fcN2Vi/W34v7gB7hMC6IrEXmVnR
 lD1e/K5FhgbwE/WLdQR63CpfsDchdrzbE1hd3F0NFOZpCywMYzPxvnn+CcsNxg14Cfri
 Ff1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU22+uvSmS0sVklhVRCw5wg62q9gT2prWgDoxPE9kxF2QOz14S+hb3Oe7QYnbiS4je2SYr6qpYZejGN@nongnu.org
X-Gm-Message-State: AOJu0YyFJMLffMgijVKzczLGYSMGU/YlQHq++a3ykV48YvRGRIE89c9k
 QisV28IES0xMPppjzdnMxHhJQme7f+O8I73aGKEJnaTmvHY7vfzgPhkI2T02sjQ=
X-Gm-Gg: ASbGncu/BkUd1VT0LADSlTEO2re7ODUL9KjYstQgQLFgDeBmS7GH9ZLF7EnKj8nK0J9
 /jpiFH9r5/TFrxazVcxrEp/Pvap7ITSUsmUMEWS5v+71Ql6IcQCZZINaLin25vmTkwOmIMYxVQl
 r0aKadGuRgPIscIT5iraBMUGIF6Nq4nRrSuM1jpYRW1iE9u/lUt0GGyUfjYw/6Y9gm7Vja2H6cV
 DMYyW2f7xMaMycsHakeBkSIJ5mDP/UamDmkwlEBbX43ZXpqRqv/fGK4KcBle9uAK6SQbtyClffS
 Qr1rZVKk3yR0LHnk6iDiDLFM4Q+bgg==
X-Google-Smtp-Source: AGHT+IERPY+YwBR9gf13tzEpUDdRLxnBnkYOhJnmnJxQs/Y78G6LwivEzVLrojfRmja0y6WuIOn4wg==
X-Received: by 2002:a05:6000:4012:b0:386:3272:ee68 with SMTP id
 ffacd0b85a97d-38a221f9fd4mr22992488f8f.28.1735255216054; 
 Thu, 26 Dec 2024 15:20:16 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8292f4sm20972028f8f.3.2024.12.26.15.20.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 15:20:14 -0800 (PST)
Message-ID: <4f754f83-cc85-461f-a6d0-62d3bb01fd15@linaro.org>
Date: Fri, 27 Dec 2024 00:20:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/23] hw/loongarch/virt: Default to max32 CPU for
 LoongArch 32 build
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU devel <qemu-devel@nongnu.org>
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-20-0414594f8cb5@flygoat.com>
 <189159ad-0b0d-46db-bc58-c7e1f0ef9bc6@linaro.org>
 <67a7b26b-606e-4bb7-b1d3-fbfd49bdfb5e@app.fastmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <67a7b26b-606e-4bb7-b1d3-fbfd49bdfb5e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 27/12/24 00:03, Jiaxun Yang wrote:
> 在2024年12月26日十二月 下午10:56，Philippe Mathieu-Daudé写道：
>> On 26/12/24 22:19, Jiaxun Yang wrote:
>>> la464 CPU is not available on LoongArch32. Use max32 which makes
>>> more sense here.
>>>
>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> ---
>>>    hw/loongarch/virt.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>>> index 3a905cf71d46e3c5a29672f7bb73faedf1d29444..343d2e745e155d59f0ff17124b3c77ec9b3c111e 100644
>>> --- a/hw/loongarch/virt.c
>>> +++ b/hw/loongarch/virt.c
>>> @@ -1440,7 +1440,11 @@ static void virt_class_init(ObjectClass *oc, void *data)
>>>        HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
>>>    
>>>        mc->init = virt_init;
>>> +#if defined(TARGET_LOONGARCH64)
>>>        mc->default_cpu_type = LOONGARCH_CPU_TYPE_NAME("la464");
>>> +#elif defined(TARGET_LOONGARCH32)
>>> +    mc->default_cpu_type = LOONGARCH_CPU_TYPE_NAME("max32");
>>
>> Why can't we use it on LOONGARCH64?
> 
> I think many users are launching qemu-system-loongarch64 with default CPU,
> better not to break them, so we only do max32 as default for
> qemu-system-loongarch32.

Don't start with a default cpu on loongarch32! The user will get the
"no default cpu, use -cpu help to display them" and select max32 or any 
other :)

