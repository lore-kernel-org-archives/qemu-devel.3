Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C7ED3C54C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 07:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1h0B-0006Hi-MH; Fri, 18 Oct 2024 03:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1h09-0006H2-AR
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 03:02:21 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1h07-0000UY-EO
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 03:02:21 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4315baec69eso13114735e9.2
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 00:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729234936; x=1729839736;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6T5PNVntjW0REyqQGx791ahhcx4V0j46YX3K6ntMxjg=;
 b=m08/5BkY6p+VX6BsJdg55gJMhJpwXHnCUTv/4wsc3KSU4r1tM/WKYvD3bMxl6NVV8t
 IHzmhng7bOZC3TpioEbw4VvkSb8vjjTxIzh5XJTs9vofE65RlP3UV1sDTlQ6Z7p+jGD9
 KTBG1yBRAGoJvAASYojZcdRwlFBvEu8P0zh8J6IslNN8ryJ4pzJ+Mw0opdJXSG54lmNz
 wT9tk2nOoPmIBgSkWb2mU1LR4QfuTHXZ4I4WFMD0zm6B5Z+JKpS5og6tX3OISsG+NAPQ
 Dt0w2cpPjRx+ELLXFBcIsgMyJmYU/aAZie31t9zppKTpryYncTRGWBoyuATXw7SAQn7U
 qf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729234936; x=1729839736;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6T5PNVntjW0REyqQGx791ahhcx4V0j46YX3K6ntMxjg=;
 b=gJDLi8NEI1O4fckAbW+KHBckA5Ii79AzctKSalNxQWwixgAY1ffUPjzvrfo3u3s3Up
 G36EHxBqCtYcTtdRyrg6SMQ3TidmDupmCZKZoPUVa8ZNHOak8o1IRgJtZldk/70A3b9R
 Wu8LqsQfE9msOXhcPvhwQvrUHOBe68+z0IGAqAErArZP28TPCB652qfPZn8BoReoOlGC
 y9nBekprqeuhpRHDKfn7HGWdagHVsYUaxhI2Y8YgjOcdRPbrJuR3aVsp+voQ+xUi1wC5
 B1vu9f/SLhXGXo21o3smEZwR3iPAzzKePeTw9HPzwaTXy97I7M7s326VIH02dkrP4IxH
 4vOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk8V48trpkKusIxG4DegRWVGnGPGbYxwDFVDZmBavfqud1VSLrZ8D22/6fSQw6r7FOTqCVYEKx/qpW@nongnu.org
X-Gm-Message-State: AOJu0Yz/O52k4JpG8aTMKrOx1DUj5ifS4wwSEKQqaXBZaTijoXBZeROM
 Jt8Iq8A2676tFKT3D3diPEA3D1xJHu6kt8AXlxirlDpYJ+gnpm6NIX+zSU4NT+o=
X-Google-Smtp-Source: AGHT+IHyZdtTkN+FPOjaCL30zMi3Y95DH3S3k5eD6VlfMEuWSY9xKYAsl/pd8krtrznjEwTukKRh2Q==
X-Received: by 2002:a05:600c:4fd4:b0:431:5f1b:a7c4 with SMTP id
 5b1f17b1804b1-431616ad74cmr8238235e9.34.1729234936487; 
 Fri, 18 Oct 2024 00:02:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ecf027d09sm1105318f8f.18.2024.10.18.00.02.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2024 00:02:16 -0700 (PDT)
Message-ID: <34909283-eff5-4ba3-bc9e-afcf8ec2b481@rivosinc.com>
Date: Fri, 18 Oct 2024 09:02:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] target/riscv: Implement Ssdbltrp sret, mret and
 mnret behavior
To: Alistair Francis <alistair23@gmail.com>, Ved Shanbhogue <ved@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Atish Patra
 <atishp@rivosinc.com>, qemu-devel@nongnu.org
References: <20240925115808.77874-1-cleger@rivosinc.com>
 <20240925115808.77874-3-cleger@rivosinc.com>
 <CAKmqyKPrHtsjAnc8kX__BeHvxoMvm+MmYLWSgh5TKdx0FE8o9A@mail.gmail.com>
 <Zwlz8LUEGB4Fa611@ved-XPS-8940>
 <CAKmqyKMtJK_2yoUoudVoZorW=A5fX=m5RvG_vvHNHj45nQy_hw@mail.gmail.com>
 <20241017182710.GA403564@vedvyas-XPS-13-9310>
 <CAKmqyKMir+rXf_ebU_XxkOk=5=v5tkT+g6j8Km_YGCjjX=cqUA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAKmqyKMir+rXf_ebU_XxkOk=5=v5tkT+g6j8Km_YGCjjX=cqUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 18/10/2024 04:21, Alistair Francis wrote:
> On Fri, Oct 18, 2024 at 4:27 AM Ved Shanbhogue <ved@rivosinc.com> wrote:
>>
>> Alistair Francis wrote:
>>> $ grep -r sstatus.SDT | grep SRET
>>> src/hypervisor.adoc:if the new privilege mode is VU, the `SRET`
>>> instruction sets `vsstatus.SDT`
>>>
>>> What am I missing here?
>>
>> https://github.com/riscv/riscv-isa-manual/blob/ef2ec9dc9afd003d0dab6d5ca36db59864c8483c/src/machine.adoc?plain=1#L538
> 
> Ah, I thought you were quoting the spec directly.
> 
> Makes sense. This patch misses the MDT bit clearing though. I'm
> guessing that's implemented in a different patch, but it should be
> pulled in here instead

This is actually done in the patch that adds Smdbltrp (this on is for
Ssdbltrp).

Thanks,

Clément

> 
> Alistair
> 
>>
>>
>> regards
>> ved


