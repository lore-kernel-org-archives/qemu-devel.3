Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C90C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 22:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgXbH-0003bQ-AE; Tue, 20 Aug 2024 18:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgXbF-0003aj-SW
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 18:45:13 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgXbE-0000tt-9k
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 18:45:13 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5da686531d3so4101636eaf.3
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 15:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724193910; x=1724798710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bFnPEBuHmqI0U+Esr+MzPVn0qUuhdui/U7szmn8UMwc=;
 b=IAqFsFbBioPJ/t+DYe1bs7sO7u7B41H4nX2o4loDcL3gDSUFsp5+VYPN8W/1whSoA7
 jE62Lw81UHjDCjHH6X3K/LAW5IyPtXphscsbutrShcno7rK73i21OP4GYNKg8e3EKZF1
 MhA6cKdy+EebXHAAsiKefS3UDgBJVErLF6ZTPelwOEgePpQn8p/xD/lxXOMTX1RaRYMA
 FZCKD3bMm1B6+Wd+8IkjsAIKucMfXZL7N2mhWY6Fgyv6EH8M0AGHH9boph/p/4vsuTgX
 FbIPhY5z8g5wAVpdeKFkVVUkjQg1qVG6StQuepUnKEJyaFp/P2PLasTjSMs4aOKthizR
 CFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724193910; x=1724798710;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bFnPEBuHmqI0U+Esr+MzPVn0qUuhdui/U7szmn8UMwc=;
 b=umv1vwIF5Hlko4btUbitv+7UV2trtAhEqfeng2FU+9PuxkB0N9tBBPFvBDrrmWN+Os
 fLFv8y87ABNqoM/ev3XNrOzbMM2pfXq7aLHLoH0wEGdfputE6/rDZCSDaV2TzCAzyvAb
 9rBdOOBxWk/8wXByTxYuN35pgZHWi3vsKs6yRTJGn2jhArVnlyJ0PQqgk0EWbB1EY/2U
 JXfz4OIkNj4rdDE9Rkw8kwh9vBFzP0WTGjmK5S3B4ouHVaaJvCQt2OEnXczxY04YSn2r
 qoKOhVNGxLQPg8rFycZM/MRuadh5H08gKbXzn2CtJqhFY1MQGdzYzGSWv/2LGwxvGOpI
 J+og==
X-Gm-Message-State: AOJu0YzrW7LrbfutCBnY7hpTg865SrJ3IPC9ULRm61MC94SSEN3fGWQO
 SvLszZSDnncEC+NfAr9UQ1m85bnf5WQ60FGerPtU+OAHurFx3m7Fdkz2rHhLvYY=
X-Google-Smtp-Source: AGHT+IFm8SrgK/DeHG2rBT8YyTynWwMU/yto0vLIAGJtWHZCouX2a+6eK/HY2dOAV9R/cJsP9HjVGg==
X-Received: by 2002:a05:6871:729:b0:268:2efa:2de0 with SMTP id
 586e51a60fabf-2737ef00186mr429178fac.13.1724193910069; 
 Tue, 20 Aug 2024 15:45:10 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.3.188])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127aefa2efsm8741289b3a.112.2024.08.20.15.45.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 15:45:09 -0700 (PDT)
Message-ID: <4b8540be-bdb2-44c7-b50e-a87ac03ba1b3@linaro.org>
Date: Wed, 21 Aug 2024 08:45:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 18/20] hw/i386/pc: Unify vmport=auto handling
To: =?UTF-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>
References: <20240819225116.17928-1-philmd@linaro.org>
 <20240819225116.17928-19-philmd@linaro.org>
 <ee5b8c9e-09fe-4b28-86fb-c6859085f988@linaro.org>
 <l60k6IPuP5TW4SNWI9iSNbMRiENiDl10oJROwImn9NsILTP6M-CVvIV42wUG8RYSdW_o6xdPhhr27Cqc0_2MgvZaBRn2B2poF6CYMGtn3Rc=@szczek.dev>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <l60k6IPuP5TW4SNWI9iSNbMRiENiDl10oJROwImn9NsILTP6M-CVvIV42wUG8RYSdW_o6xdPhhr27Cqc0_2MgvZaBRn2B2poF6CYMGtn3Rc=@szczek.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

On 8/21/24 06:32, Kamil Szczęk wrote:
> Also, just as a test I added a single line of code before the assert:
> 
> pcms->vmport = -1;
> 
> And, to my surprise, it compiled successfully without any warning and as expected, aborted on the assert:
> 
> qemu-system-x86_64: ../hw/i386/pc.c:1225: pc_basic_device_init: Assertion 'pcms->vmport >= 0 && pcms->vmport < ON_OFF_AUTO__MAX' failed.
> 
> Is this expected behavior?

Yes.

The underlying integral type for enum in C is implementation defined.
It can and does vary between compilers, leading to this sort of thing.

The only reasonable fix is

   (unsigned)foo < max

But you could also question whether the assert is really useful.


r~

