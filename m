Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E70C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 15:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1radi5-0002M4-ET; Thu, 15 Feb 2024 10:31:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1radi4-0002LU-Kd
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:31:36 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1radi2-0001IK-RH
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:31:36 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4122acb7e69so2808825e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 07:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708011092; x=1708615892; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GcwqVsCa+Ohf5b0UP6zNfJGfZs35k/9ldYEB3aIfx3o=;
 b=WM5UQgoqhgd/ug5w+dHpgsLXhdaZFuQgyOSmDWb9Az/iabrCcme2a0uoMG60oM9vLQ
 9hK7LiVRuxo6ldDaVOaoIVb9ANrLyKuR4H9fYmwXqcAqppiioQV/6CxKjAJIIEnqdQgb
 2WaHin6GKxbyZcs17cK8y/102sKQ7nJOEmwbamB4K09GKcIlqBr8otbNWgrdNIVh1x6y
 cYeDMYEvvMjYjnGHRv7iFhrpqshfV3MRR44UD2c+8OWfOL4L4QlkvvB4KPnTTKhnrApx
 s4TCNmYAIRx+kwOUiGlRG0XUkEnxizwUJGAMcNbRRCV+Pool2Ri+YywU0k1/dv18obbf
 iQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708011092; x=1708615892;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GcwqVsCa+Ohf5b0UP6zNfJGfZs35k/9ldYEB3aIfx3o=;
 b=h9D1D6R0gJ3lUnrfHZi2S3plvpC+VjjRmNqKNX/tjOYzXwoQga0Ntpf7h4ZIk5l/Er
 zN2HWXg6sdi1PQBN986U5r3wLtM1Z9HOne38X8MEfAaecwvhe5M7DRZsVAMzGfKPzMsy
 xs52QGZF9tVQPUXMv+pmPt1Bjnya5ohrs+ht2M1V7vVmRiSc0Jt37EK1wFfj09KHTDhK
 sOOpxf5w+kNgqVW2BGRLuhCIENXtF5wSktuYRJpaKyg71949zst45K9ly7XFVhjrtjne
 PvPhtAI1MeDO361VTPXWmXeUUuemHG84p1tKacbspddOAmkCEn/L7hRJWI+0jiXjiGUj
 1bgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxuIkDj/Vr4FpHxQdtSurautJ25TGCycSmaJEe7XXXt2E+woJSrf4URv4vsdyJ/TnSVW9RYQTVGJTeIGM2hbfbKKOCcyk=
X-Gm-Message-State: AOJu0YyHDqbzQdCkvWWWubNuG+S1/s/vVbGyzz0fWBgyu2aUiajH/kum
 fL/VDycFo/eD335D+Z70oFuMrYR9L6MXwArerly4Rqm6udUx5/I1KWtQkSIUnIE=
X-Google-Smtp-Source: AGHT+IGlI9tJMw+FXdsS6jyMwLgXirQaxJhBNIvJwkdDzDeSqiypXYg/w+5dR4cwMq85ZbeOAzYL9g==
X-Received: by 2002:adf:f9c5:0:b0:33d:14e8:70e2 with SMTP id
 w5-20020adff9c5000000b0033d14e870e2mr173303wrr.53.1708011091655; 
 Thu, 15 Feb 2024 07:31:31 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 bt21-20020a056000081500b0033d14455c99sm408546wrb.101.2024.02.15.07.31.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 07:31:30 -0800 (PST)
Message-ID: <5b53790b-8f94-4b21-b1da-e7f278af0dd7@linaro.org>
Date: Thu, 15 Feb 2024 16:31:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/i386: Enable page walking from MMIO memory
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gregory.price@memverge.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Sajjan Rao <sajjanr@gmail.com>,
 Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
 richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: linux-cxl@vger.kernel.org
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
 <20240215150133.2088-3-Jonathan.Cameron@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240215150133.2088-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

On 15/2/24 16:01, Jonathan Cameron via wrote:
> From: Gregory Price <gregory.price@memverge.com>
> 
> CXL emulation of interleave requires read and write hooks due to
> requirement for subpage granularity. The Linux kernel stack now enables
> using this memory as conventional memory in a separate NUMA node. If a
> process is deliberately forced to run from that node
> $ numactl --membind=1 ls
> the page table walk on i386 fails.
> 
> Useful part of backtrace:
> 
>      (cpu=cpu@entry=0x555556fd9000, fmt=fmt@entry=0x555555fe3378 "cpu_io_recompile: could not find TB for pc=%p")
>      at ../../cpu-target.c:359
>      (retaddr=0, addr=19595792376, attrs=..., xlat=<optimized out>, cpu=0x555556fd9000, out_offset=<synthetic pointer>)
>      at ../../accel/tcg/cputlb.c:1339
>      (cpu=0x555556fd9000, full=0x7fffee0d96e0, ret_be=ret_be@entry=0, addr=19595792376, size=size@entry=8, mmu_idx=4, type=MMU_DATA_LOAD, ra=0) at ../../accel/tcg/cputlb.c:2030
>      (cpu=cpu@entry=0x555556fd9000, p=p@entry=0x7ffff56fddc0, mmu_idx=<optimized out>, type=type@entry=MMU_DATA_LOAD, memop=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/cputlb.c:2356
>      (cpu=cpu@entry=0x555556fd9000, addr=addr@entry=19595792376, oi=oi@entry=52, ra=ra@entry=0, access_type=access_type@entry=MMU_DATA_LOAD) at ../../accel/tcg/cputlb.c:2439
>      at ../../accel/tcg/ldst_common.c.inc:301
>      at ../../target/i386/tcg/sysemu/excp_helper.c:173
>      (err=0x7ffff56fdf80, out=0x7ffff56fdf70, mmu_idx=0, access_type=MMU_INST_FETCH, addr=18446744072116178925, env=0x555556fdb7c0)
>      at ../../target/i386/tcg/sysemu/excp_helper.c:578
>      (cs=0x555556fd9000, addr=18446744072116178925, size=<optimized out>, access_type=MMU_INST_FETCH, mmu_idx=0, probe=<optimized out>, retaddr=0) at ../../target/i386/tcg/sysemu/excp_helper.c:604
> 
> Avoid this by plumbing the address all the way down from
> x86_cpu_tlb_fill() where is available as retaddr to the actual accessors
> which provide it to probe_access_full() which already handles MMIO accesses.
> 

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> 
> ---
> Patch posted in reply to thread:
> https://lore.kernel.org/qemu-devel/ZbvpSaOXzZkqDd6c@memverge.com/
> 
> I checked Gregory was fine with me adding Sign-off / author via the CXL discord.
> ---
>   target/i386/tcg/sysemu/excp_helper.c | 57 +++++++++++++++-------------
>   1 file changed, 30 insertions(+), 27 deletions(-)


