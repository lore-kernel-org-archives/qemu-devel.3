Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4A4EB5948
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 00:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpyCY-0000g1-G9; Tue, 10 Feb 2026 19:35:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpyCX-0000fl-Gk
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 19:35:29 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpyCV-0001B7-Ud
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 19:35:29 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-bc274b8b15bso772093a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 16:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770770126; x=1771374926; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N0ODTrsBoAwUoWjk2cqDOmXirToHM5QXGutlSnNP8kw=;
 b=aemKDqHHXlo/9DzmhiothQJMfyiKUheG6aV9lN8aSHZLXzjXiZwXEx5HW/Bh1FzO3g
 Pth9f+15idiauZuf6/jWckw4ruYUPhNPQ8l5nPGl+qc2CRyarJHkhyUEnCpAnNyileWc
 D4nJ6F/TKaj+ltfbzkoIn8toMI2RdTjxGEBqfw/Aj8sI0MNKcCtQXWHC9j0fo1HUnLUA
 pjFT5i6seSkgCXszLPD+pOlYPqpXgAlNJJFBwRKC5TIpANnSS05ETlPcCtn7kTxQewci
 oiKjNclPl+C0x6vLO7/h5/k4n/9aGnGd5gxzcJdevZBTF1uJkR6ZqsqshP7kVjEihEhw
 o0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770770126; x=1771374926;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N0ODTrsBoAwUoWjk2cqDOmXirToHM5QXGutlSnNP8kw=;
 b=qtaiAF3MzFlQFly0iDAVlSw9hvX2SWD6CuMaCVqv/DBfkdrZw93gRkJ3OAt5DgjsoA
 FX2RwieJ48h4tw9erblZpIWkFnZjkOQ1vj1ybsVtX/n1liZPr8C1HEePlFqiuG73Rcan
 3AoF0rtVghAKo8BnT9aUoonEpt1+yeSuHv88RKznKVRm8IfOfvNjLC1ZVxTytvn7Zx79
 YEo0Ur7QmsXo3zFDB1rU5fUq3oQpfq6nyx6uc4sCBfuBVOKpwIqWqf5iR9cj4s36RTYc
 8kKH4gzBFgIpwoSmVAz3tavmnkz5XmQTHjJgYLZqatL3rlyj/ayety3SEz1d7q2NAioy
 15Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2L+PBrT7jtUSFK3NWxJtAj3ac0CfVOYIRIYw3x3Pa/YgK+nOmUmroRoAxUwJcNCKvOJA5ttV2cdMY@nongnu.org
X-Gm-Message-State: AOJu0Yz/m/K+izZ/Gy33TgN8zodx+KI9OfOS0KGhhr7IHbuD3m1MGct6
 blYYJCYW27t8OXY3EsTpuRCtxBS05S8aDLrQaSfXaO1R1d9+adtbnWNMfwjiEkABz4U=
X-Gm-Gg: AZuq6aLH7EqBubmeadC32OnJWG5muly7q7qgYF3CauB52h2hpEJV8UJMeLJgLS4m+Q2
 FN+JRUCJ/g7o1v6u2P7rWUP32cnynr/KOpjIOhf18rQjYejKn29a6riZDLyEgl/wdg15dS+AKM/
 z3PKLioLT9f+I47cNL3HKP0oA0ygmKQ9kLr88g8i/CWVefgKMMlZ9WAwL2cu1ckp80y/hgqzs5H
 WVdIHGfOrvf5ISpF9+UJW7LvsgN7hjhNdZY3SlEVD/dILyDMFZe8v6QN0vg/oBP43bp07S4st+s
 qO6IlXQJUdosx5pJKR1J+efIS/zPyEr3MTWT/bGsp8Em+TisScuDPADamMSB1w15nnv/29hjRkq
 i45zIruTp86+WFpEPEFtwP4xcrG6u96tZGYHJpAVbr9k+A3a9/fWIksQRNdS78SYy0E0wSuMeQT
 IzvDkAhMl5cUC2C0Gelqq6k4Yt+JP/qjBd0UhYa3kBK4zZfXTPQnkIQXGaDvvIVAy9x+M6tCVZB
 lwfUHwKRAmUocV2BVxoOyGM
X-Received: by 2002:a17:90b:2b8e:b0:34c:cb3c:f536 with SMTP id
 98e67ed59e1d1-354b3e6d672mr13724190a91.36.1770770125911; 
 Tue, 10 Feb 2026 16:35:25 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:f8f8:2c3b:9605:55a0?
 ([2001:8003:e109:dd00:f8f8:2c3b:9605:55a0])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3567c470bedsm356956a91.1.2026.02.10.16.35.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 16:35:25 -0800 (PST)
Message-ID: <606ac024-9d02-4684-b538-c01fff9d5bf7@linaro.org>
Date: Wed, 11 Feb 2026 10:35:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] target/loongarch: Introduce loongarch_palen_mask()
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 palmer@dabbelt.com, alistair.francis@wdc.com, pbonzini@redhat.com,
 gaosong@loongson.cn, maobibo@loongson.cn, deller@gmx.de
References: <20260210-phys_addr-v4-0-725a589e83c8@rev.ng>
 <20260210-phys_addr-v4-5-725a589e83c8@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260210-phys_addr-v4-5-725a589e83c8@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/10/26 21:33, Anton Johansson wrote:
> @@ -364,3 +366,9 @@ hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>       }
>       return context.physical;
>   }
> +
> +uint64_t loongarch_palen_mask(CPULoongArchState *env)
> +{
> +    uint64_t phys_bits = FIELD_EX32(env->cpucfg[1], CPUCFG1, PALEN);
> +    return MAKE_64BIT_MASK(0, phys_bits);
> +}

PALEN holds bits - 1.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

