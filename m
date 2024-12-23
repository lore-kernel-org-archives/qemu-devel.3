Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F9FE7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 23:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPrgl-0007e0-Dk; Mon, 23 Dec 2024 18:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tPrgj-0007df-5p
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 18:18:13 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tPrgh-0005ZI-HE
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 18:18:12 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so52855025e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2024 15:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734995889; x=1735600689; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YCM6xIEzH94DNuFPXwq8qUmhS8PcflXbyhDF6xHTKrQ=;
 b=d9TiWzzxK/wLj+Ca5BFmO03JGp+OG+A9S+VbREsixUw48SIs7WeI2mT7wqQK/P330v
 8Rjka+WK73Qh4hRFyIB6AYwnjLReaj4XIOEVP/uO27XJ0g9E4aw8hK5RWkM9A/Dk8gbL
 UNhMnA/Skw9hKBS1J8jYU+Gp9uiLFTZJ1QuZv1mzKUhTlN00B+YCY14wfxT2nwfEVYln
 6qgxUM2f4P0/g987KaE0xM/YnD2eHyz1T+yZ3o/ApaeO5KNxVtSVJ/kj+7khN3q2nH96
 /Gqiwe9ZKyW+nFRGjxAU3EgwbQcVmQxaB74bP7xpMbT8Z+P9uNH7mzeU+aMRmBAEjw3g
 eyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734995889; x=1735600689;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YCM6xIEzH94DNuFPXwq8qUmhS8PcflXbyhDF6xHTKrQ=;
 b=ff/1REg0TT3EWlwpIGs4aR4SKfsES8Ce1rb6PH7WgdPu3/zr67duEHksH+ZG/T78SI
 VasoMLzFhVUj7WRhaYM17TqsK/RijpsuAWIuqtrURY0gXFSCU5GE+hLIebVJyVINFEIq
 c8uyYGxxHBxEzJ71Jza5t78paXoB/yQnW6fJHieCzgnilg2XC6UPn1DD22d/ced9DRyO
 YrTkY2ByFFD2Vc7SvAC4D1GVQEgRq5cs3uGOhcFS49ygMXHSzKTiJVgNCeZmopD2SyEr
 r0XA2SIZ+oJxeX9yS/Di9QkyFqvJ6q1qVxx+WMZmx2ArNr+40OdYY1Oiskkfl1vV80LS
 WD2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3E4ucFTJt+j1E18/eDAIUhHE+AjKHhTOFw092bsuPjBS5TtEOTSYgVUW1rW4r3c79DjooTQOZ37Hq@nongnu.org
X-Gm-Message-State: AOJu0Yx3O+33lg9IJpwnGrF+vfg9nykDU4ASxsF9agyWJWxnbtuc1GRe
 B5AEEfn6SI6tVgWomnR/Xw81ZOSAiFwFW4FAQNOAVj+m+xQG699dUa60Q6P0GWbbwNXFVQRQ4la
 x
X-Gm-Gg: ASbGncsrBLe//u2ARlUV75ZHNg6YdV/SzSn5e+aaNuoRYMnfjJzg+e1H4rN9cb0BrzA
 G5lNz4DHnseqOwl5vOoVyArQrHYyq1Db3Z1eC4RuA4S7kU2VjcVbHfJx1yPllYFUavQYfNb39n0
 xosWdjZhnIunKfe1WLtwK74Lh1CPETnwa4AwVqyRcQ9BKPWSYcQCarbseAjQpqwvbADiAxssr3C
 OQ1NdwbrJVLvW+R4RqLr+eEsK45gN2rQYpGMYK5bp/mQ8CudTCOPV3Q68xyG2NvktA=
X-Google-Smtp-Source: AGHT+IF4gILSNfKOvaJySpYWjeAN0lgfY2GIp/ChY914k1NKnCwmZf/Pp48qClUymio7CH3kc+M+jQ==
X-Received: by 2002:a05:600c:1913:b0:434:f396:525e with SMTP id
 5b1f17b1804b1-4366b2fa0a6mr126373485e9.9.1734995888825; 
 Mon, 23 Dec 2024 15:18:08 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4367086e40esm110670515e9.30.2024.12.23.15.18.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Dec 2024 15:18:08 -0800 (PST)
Message-ID: <0a550dea-68b1-41a5-9616-5046d4577c44@linaro.org>
Date: Tue, 24 Dec 2024 00:18:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/loongarch: Fix LLSC for LoongArch32
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU devel <qemu-devel@nongnu.org>
References: <20241222-la32-fixes1-v1-0-8c62b7e594db@flygoat.com>
 <20241222-la32-fixes1-v1-2-8c62b7e594db@flygoat.com>
 <a86f364c-58ee-4e73-8c0a-110fefc1f985@linaro.org>
 <6564d4a5-9299-4de3-99ca-ec4094b9e642@app.fastmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6564d4a5-9299-4de3-99ca-ec4094b9e642@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 23/12/24 22:01, Jiaxun Yang wrote:
> 
> 
> 在2024年12月23日十二月 下午3:15，Richard Henderson写道：
>> On 12/22/24 15:40, Jiaxun Yang wrote:
>>> @@ -9,7 +9,7 @@ static bool gen_ll(DisasContext *ctx, arg_rr_i *a, MemOp mop)
>>>        TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
>>>        TCGv t0 = make_address_i(ctx, src1, a->imm);
>> ...
>>> @@ -28,7 +28,8 @@ static bool gen_sc(DisasContext *ctx, arg_rr_i *a, MemOp mop)
>>>        TCGLabel *l1 = gen_new_label();
>>>        TCGLabel *done = gen_new_label();
>>>    
>>> -    tcg_gen_addi_tl(t0, src1, a->imm);
>>> +    tcg_gen_mov_tl(t0, src1);
>>> +    t0 = make_address_i(ctx, t0, a->imm);
>>
>> The move before make_address_i is not required.
>> See the similar code just above in gen_ll.
> 
> I think it’s necessary, I thought the same and end up spending hours to track down the problem.
> 
> make_address_i won’t make a new temp_reg if imm is zero.

Only if va32 = 0, IOW if HW_FLAGS_VA32 is not set. Per is_va32,
VA32 == !LA64 or VA32L[1-3]

Indeed make_address_x() returns the same TCGv if !VA32 and imm=0.

> So when imm is 0 src1 and src2 is the same tcg reg the value will be clobbered by cmpxchg,
> causing a couple of tcg tests to fail.

Missing constraint or mis-designed make_address_x()?
To KISS I'd use a temp in make_address_x() regardless of addend=0.

> 
> I think only way to ensure t0 is a new temp reg is to perform a move here.
> 
> Thanks
>>
>>
>> r~
> 


