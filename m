Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FEECCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 12:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIRSW-00020Y-S3; Mon, 10 Nov 2025 07:57:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vIQtk-0004D9-11
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 07:21:39 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vIQtg-0000hj-AR
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 07:21:26 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-29558061c68so35539365ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 04:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762777282; x=1763382082; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e44jDuR+hMq8gfTXbw9E1tkIcgT9CLYBdOdZSJsryjM=;
 b=m5xUhvUG/s6/JRyKPV9o647JoIAXOkX3b1ezXk4c2GbHr1pQJjJr21uR9/aO6svmWt
 u+K80gBkRn7wre6CCzC/2DDUwYiol46k1oVx0N8Vz1Y0qbs1UjkI05zd0qOjGeXcRgNe
 hqZPmXpFfo/6W+tJZ0KOpYU11QeswLWLmQa5oq4632N7f9MuAf8a2LTvoLHYqCAUOBW8
 uoXqrvCr/YS9NCXFQXtrRA+KpZnEadWxFRw6wCdd+MU3w0yDCp60Dhuu/56fVxjPWOjv
 CIgjmBrSaBLYQAtOPw7Nqk1+FG7t8BPJuTugnubD9ykpngJFScYXT0BKQo7wU9uFRHXT
 4blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762777282; x=1763382082;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e44jDuR+hMq8gfTXbw9E1tkIcgT9CLYBdOdZSJsryjM=;
 b=XGLJD2OKDoBxQwAE4yAAuSpWH8MnZHTBHVFUSj5ohQ97eaJXrfCB0DUj7TvoXNpNNr
 g1u+/oY4+dqtG8W+T5+m3XLKATKo1E1GpsUsfxu+zPdMIomGS4aTpLY9Zxxfb3gtb/sz
 RoiSkYZJ7kFq9dwTw8+NMkFiA+VdVWVYm2ADMReymMw8+NUnJb5uIy4YxA4o8QjR6Su4
 NP0IUCHFEKHIvIfxXBdy5bEZG6jiWkJ7xTbf7+TEXf1c7ku/8ih5yGGSMsHqwAHW8U6l
 NxNJD0bWrqXtdMQNJZiJnwGvuedMGHYjdtY30hKOSX14tC0ERhLwHrpgxlyjQQTvp3sy
 ccvA==
X-Gm-Message-State: AOJu0YxIji3HVxples1JJbMEKwkCCw4HkxRCHduG4CW2k8k2QvKoVf4H
 ZoOad+IF0F8rdHUnV7Q3IGGO16A0wp0Nc0DrYs+h4jK2WVHw19NC8HB2+lUZ/d/92j4=
X-Gm-Gg: ASbGncvFpkBX40jC5v6NgjR4pS9do0LJTVUF5qgxuS02sQFLhCttZqnIBJmUh+awGfG
 J68PDs1q6Qy52MUvNiTG7QXfMVatFXfINylSl2CRMTxEAuoZS4FSAvTP9tuQoiwi/lbfkjjyPjW
 Xp//TDLpCRCC8s/YUZWPTuhb/YAuGZp/tKT/7rSA4/tdXCyvvl8eVtHKniK3s1NZVhAIbY85LV7
 E5fddMu3Z5dSAkRQudUCvvBPc/7nMNIKHz3R4inHS7Eqh8W5d21/zWuaembI5MGlc9jYOktVUv1
 N2H/KBI1CDUdAbbcQLbMs1TXTt/YX5o64ON5WC/Na1ids7EQrStH3K3DJ2Oog3g4NpflL24WSmv
 D2bXkY+97k4DNDDklb0dkfFtDykH3Eo2TaILJZiN4i7kus1hpARlU+9exIamuRqKlyNUEYa1D3G
 /+eX6ARbF5+PZ6RA==
X-Google-Smtp-Source: AGHT+IE4vTHsDkQwpy8eWI9w4CA8/OgXexqzA46hhJ1XrLGM6B7ajCq3iKsVSRyqf/sWV92F3GOIpA==
X-Received: by 2002:a17:903:a90:b0:295:7f1f:a808 with SMTP id
 d9443c01a7336-297e56b8c0cmr99514005ad.38.1762777281841; 
 Mon, 10 Nov 2025 04:21:21 -0800 (PST)
Received: from [192.168.68.110] ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7b0cc76c0e8sm11621965b3a.52.2025.11.10.04.21.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 04:21:21 -0800 (PST)
Message-ID: <6374e937-6de9-4d86-a833-fc519e91fac8@ventanamicro.com>
Date: Mon, 10 Nov 2025 09:21:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] riscv: riscv,isa fixes + check script
To: Conor Dooley <conor@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
References: <20251106112044.162617-1-dbarboza@ventanamicro.com>
 <20251106-napped-haunt-109e9e24ad40@spud>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251106-napped-haunt-109e9e24ad40@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x635.google.com
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



On 11/6/25 12:48 PM, Conor Dooley wrote:
> On Thu, Nov 06, 2025 at 08:20:42AM -0300, Daniel Henrique Barboza wrote:
>> Hi,
>>
>> We have an array called isa_edata_arr[] in target/riscv/cpu.c which
>> needs to be always kept in the RISC-V specification riscv,isa order.
>> Easier said that done: as more and more extensions are added we're
>> failing to keep up with the array ordering in the review process.
>>
>> I have considered changing how we're retrieving riscv,isa to not rely on
>> the array ordering (in fact I have code that does that). We would sort
>> the enabled extensions using riscv,is ordering during init time, before
>> writing it in the DT, ignoring the current isa_edata_arr ordering. When
>> all was said and done that sounded a bit extreme and I think there's
>> other stuff we can try first.
> 
> FWIW, I have yet to actually see a parser for it in a "real" application
> that relied on the ordering. It probably makes a parser more complicated
> to write than one where the ordering is ignored. The only time I can really
> see ordering mattering is if something has a very simple bit of code and
> is looking for "rv##ima" or similar, and using a string comparison
> function.
> Either way, my point basically is that you shouldn't have to go to any
> extreme effort to make sure it is perfect, particularly when it comes to
> the multiletter stuff as, at least for devicetree, the binding has never
> enforced ordering for multiletter extensions. I know ACPI cites spec
> order (and spec definitions, so GL there lol), and there could be relevant
> for some ACPI only code where the devicetree parser is not being reused.

Thanks for the insight. Yeah, I haven't seen software caring that much about
the riscv,isa ordering either. In case it exists it would be broken in QEMU
given that we're using the wrong order :D


Thanks,

Daniel

