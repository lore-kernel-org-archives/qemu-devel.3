Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D756C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 15:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE9ij-0006i7-UR; Mon, 03 Jun 2024 11:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE9ii-0006gB-5h
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:35:36 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE9ig-0000xT-Ii
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:35:35 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52965199234so5095032e87.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 08:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717428932; x=1718033732; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JEAvTofJ18KoArWousPRtr8oanbKJHLd6FS1aHQbHUs=;
 b=KUmnf64K6/Wk2b32YqkCOGJ/ra8wfQAGByH16wAt501S1YmxV8QDnnOX+UBIFQidBl
 MlK3Cu+dsjBbYh7cTjtvSZq0NFk73dMCZORmYxCujNEOby7q7TcNNFixW3LVi17C7d+v
 7N1qKUTJTuquyW4z0O0jaX7x5XnfuSinHcEeyw6T1RW6wWdHt+hzfm5eHnR59PWrnZv5
 +hl9yr2ASPPCdUHYFmH1au9CrWO5PN6E+cfRGyWX7Ncx5ORaPy/gAa0tGGkXPr+vqwm9
 dRVtXdtWXGvydZdSkTJG1VQpRyKKfLXwjE3nq+0ilZCLNRPp7EkVYg/3ShBIQ4AHViNg
 4aIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717428932; x=1718033732;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JEAvTofJ18KoArWousPRtr8oanbKJHLd6FS1aHQbHUs=;
 b=wY+vEkvH9nA4kKNO/NUlr5KzX+4VWk28EjqcBt1t5+i/kNTSuPNRxYAnYwKD/O6Ndp
 Q8F/BMNt8IzEG+RiykY3gXMd/JrH6oQG/z5pvBFjueTUFQ+uXpihibcceQa/2LQvDk9M
 Z6sGTuNEdWPNbe8gl78Kbg1+7thuFke2fjIZURrid0xZAIVQWmwv7OK3v9ldXPI20IAb
 yqklCtx5Vmb7JWHEEntDDeEZCK3zxhHz7hX85gozWKJH9QQgVEy7/pOZ36sjoeHrEkUd
 vmWczw9L9vbvYEfYQj7+ObICzFe3MmZwyMDqt68MvlgyVumMBQiqmLR6clMcEJK9A0Lq
 Z17Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfK91QZ5t2GCYFuDTCzeL/xHg1gi5iDnWqAdFAcu0y2cgaIZIbYm0MVoYs5tDlSecvGxfNDUbTPAeqt6de/Y1QSHFmXT0=
X-Gm-Message-State: AOJu0YxZkBOQnCnC/WSwRynU4A5/44JPMxjdQ3Q5baR3zCtJrUrDF7gi
 es6X+8S3TaznaR9mkZt9+Pt9P84oP+YXiP2Wk8yUhVT74O6Vrl4aHEKHI0qyIl8=
X-Google-Smtp-Source: AGHT+IEiY7DFhLsc9/O8P2yvSSCoW5BRnA8l+gt5fAGam8RBUQwgZJsrU/X7ZjiExSEYfihrVvx/cg==
X-Received: by 2002:ac2:5e68:0:b0:523:899f:c63d with SMTP id
 2adb3069b0e04-52b896bfd2amr5790185e87.47.1717428932154; 
 Mon, 03 Jun 2024 08:35:32 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04d94e6sm8981451f8f.51.2024.06.03.08.35.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 08:35:31 -0700 (PDT)
Message-ID: <96870199-5782-4d87-ba10-f4b886936a96@linaro.org>
Date: Mon, 3 Jun 2024 17:35:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] hw/mips/loongson3_virt: Implement IPI support
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU devel <qemu-devel@nongnu.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>
References: <20240508-loongson3-ipi-v1-0-1a7b67704664@flygoat.com>
 <a9717e72-9de2-469f-89c1-8ae969b0031e@linaro.org>
 <75c78b9e-4a18-4faf-9b80-a497d3401dba@app.fastmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <75c78b9e-4a18-4faf-9b80-a497d3401dba@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 16/5/24 12:53, Jiaxun Yang wrote:
> 
> 
> 在2024年5月8日五月 下午10:41，Philippe Mathieu-Daudé写道：
>> On 8/5/24 15:06, Jiaxun Yang wrote:
>>> Hi all,
>>>
>>> This series enabled IPI support for loongson3 virt board, loosely
>>> based on my previous work[1].
>>> It generalized loongarch_ipi device to share among both loongarch
>>> and MIPS machines.
>>
>>
>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> ---
>>> Jiaxun Yang (5):
>>>         hw/intc/loongarch_ipi: Remove pointless MAX_CPU check
>>>         hw/intc/loongarch_ipi: Rename as loongson_ipi
>>>         hw/intc/loongson_ipi: Implement IOCSR address space for MIPS
>>
>> So far patches 1-3 queued to hw-misc tree, thanks.
> 
> Hi Philippe,
> 
> Thanks! What's your plan with the rest of the series

Patches LGTM, but I'd like an Acked-by from Song Gao ;)

> and earlier MIPS CPS SMP series?

No plan, just lack of time :/

> Let me know if you need help on testing etc.
> 
> Thanks


