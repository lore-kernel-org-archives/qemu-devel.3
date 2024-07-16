Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313E6C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 06:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTbrb-0007MU-Ot; Tue, 16 Jul 2024 02:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTbrY-0007BM-Fm
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:40:36 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTbrW-0005ty-Oh
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:40:36 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42797bcfc77so35656595e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 23:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721112033; x=1721716833; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yop3I/GSDZjU2Z8+7A8Mw8g/mzz/FstNyOPA6EunhAk=;
 b=uxMI3VXC+6SfXjMqWMxX0jZ12nXIChZQkz969VZLTGjlX5eAj2g/8N2bubnSFuwWNc
 aP+pvpUUyESE0Q673+s4XL81EG/saTuvO3xjCUpo8QgAPR/0cMiqtVb9RnM+mDfhuoAV
 37AtFbodioWbSvQwPep8/56EV3d5cJPo6Zf2AvMG8k58yf6xewKxal4t5tHquUn02DBU
 2ZMx0I10Q6gjQAGT1YyGwvlc56tjtTCmi3SxrlJT4kGu2ech9lreYubhtACjcmtmPRcs
 5Q4bEBDuV/A+HYloYupnof7Zig4IqdMkwlIZHY6AVwxgw9dpUFxrD5s/v0R/82y0QRWo
 Ci1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721112033; x=1721716833;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yop3I/GSDZjU2Z8+7A8Mw8g/mzz/FstNyOPA6EunhAk=;
 b=lcRr0LXwEwPO3srORr172Z8LTGz0CZSMaWvlybIvrVQtEeSOlnpeq75GNr5n3CtHm4
 JdlP1QydQSVAXLUGqgUQotlcnmsJ2DGZUKpjmBnALTAkklEbas0egfitCP91oP/QyVzK
 Abl73gOJ71cNk8mrqsU9vMM5jbEFkHrkDoMENsFt2OAYWsIm/CeTtAyuEbdcC4pPcT1e
 MpEnntVNwSGR1FJSx47EWBU4UAUZnonSreSW//Nbk0DdTNXKG1C19lPv2jGhlyjx1Zyk
 qzBGbdw1oEsI4HSlq4wtgFCGVYIDwiiPn7lG5MlqYzwlT+rPeiwu61R621JRqsDQr+r5
 k7Gw==
X-Gm-Message-State: AOJu0YyZgZuoVUZJpKcjAhjMXp6EmwXgKffgspS3jcMY2UGhHmK6CRg9
 YAXmdkwTz50oDZTR92CrC7SHFJvcmCx+zCf8VhoWlWJOObW2BVBPxylit12FuCc=
X-Google-Smtp-Source: AGHT+IE8cxInwX67B7DAoc05mMKRiR4KhzfcYfBzlv03pIuzygncC4kHRJE/zVTmSTtFXsGJh6Shsg==
X-Received: by 2002:a05:600c:4ec6:b0:426:5dd0:a1ea with SMTP id
 5b1f17b1804b1-427ba6f4958mr8086135e9.28.1721112033151; 
 Mon, 15 Jul 2024 23:40:33 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427bb9988f6sm6893515e9.1.2024.07.15.23.40.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 23:40:32 -0700 (PDT)
Message-ID: <4061a31e-1cd8-4cd7-96f3-3e5208e12a87@linaro.org>
Date: Tue, 16 Jul 2024 08:40:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Reconstruct loongson ipi driver
To: maobibo <maobibo@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240704033802.3838618-1-maobibo@loongson.cn>
 <682d514b-1d49-4e23-9cb7-a6fd83cbd863@linaro.org>
 <d26cf86a-2247-b5d9-3674-64cead2fa816@loongson.cn>
 <b4a9e1e9-467c-2d50-0d24-174fc9e5c5fe@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b4a9e1e9-467c-2d50-0d24-174fc9e5c5fe@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 16/7/24 03:29, maobibo wrote:
> 
> 
> On 2024/7/16 上午9:04, maobibo wrote:
>>
>>
>> On 2024/7/15 下午11:17, Philippe Mathieu-Daudé wrote:
>>> On 4/7/24 05:37, Bibo Mao wrote:
>>>> Now loongson ipi and loongarch ipi share the same code with different
>>>> macro, loongson ipi has its separate function such mmio region,
>>>> loongarch ipi has other requirement such as irqchip in kernel.
>>>>
>>>> Interrupt irqchip has strong relationship with architecture, since
>>>> it sends irq to vcpu and interfaces to get irqchip register is also
>>>> architecture specific.
>>>>
>>>> Here like other architectures, base class TYPE_LOONGSON_IPI_COMMON
>>>> is added, it comes from loongson ipi mostly. And it defined four 
>>>> abstract
>>>> interfaces which can be used for MIPS 3A4000 and Loongarch 3A5000 
>>>> machine,
>>>> also can be used for 3A5000 irqchip in kernel mode soon.
>>>>
>>>> Also Loongarch ipi and loongson ipi device are added here, it inherits
>>>> from base class TYPE_LOONGSON_IPI_COMMON. Loongarch ipi is tested,
>>>> loongson ipi device only passes to compile and make check, it is not
>>>> tested.
>>>>
>>>> Bibo Mao (4):
>>>>    hw/intc/loongson_ipi_common: Add loongson ipi common class
>>>>    hw/intc/loongarch_ipi: Add loongarch ipi support
>>>>    hw/loongarch/virt: Replace loongson ipi with loongarch ipi
>>>>    hw/intc/loongson_ipi: reconstruct driver inherit from common class
>>>
>>> I'll try to respin a clearer v3.
>> I am ok with it since it solve the problem, and it is suitable for 9.1 
>> release. Only that in the long time we hope that intc emulation driver 
>> has common base class + tcg/kvm driver, similar with other architecture.
>>
> Sorry for the confusion, I had thought it was another topic.
> 
> Thanks for pointing out the problem and welcome the v3 version.

Please do not post v3, let me post it.


