Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F52ECA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 09:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utk0Y-0004Xy-AP; Wed, 03 Sep 2025 05:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utk0W-0004XH-DX
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 05:42:24 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utk0U-0007ks-P9
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 05:42:24 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-afcb7ace3baso534958366b.3
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 02:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756892540; x=1757497340; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qVloED/cCXklq1H9Q3/BOz+7rpEZkvOe1zzclFB3ykQ=;
 b=vovvx+KWO6NUhKwcOt1T4njyXjEEnyS2Uf8UAl5BY0K8aJu5sXXat3PzU8K2C/KjbD
 ro4tFxEuCUbzmIzTGzh/dF0BU4/RusbgKjQIAYOVUF3EYJE1diVrED1nRoFHWTpSzmzs
 e+8X5VIyxbhMWwHiZTz3uRT6H6J/vaUC3XPOrsZl8gO4jlbKWHUA+pX/pjfEgL6KNmEn
 XyQSQKFf+zbXyt0DlGANKTgDlTpz0RIQoeufkZmaFgci3VPPd9FYDaVJquwNj57uR4uf
 7cnaDMAhXSY5HrA8XaVyHP2BoVC7m/9LmlyTuqAD5xVCGjBbBVd32D9BITfoHS+BV5nH
 hVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756892540; x=1757497340;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qVloED/cCXklq1H9Q3/BOz+7rpEZkvOe1zzclFB3ykQ=;
 b=WciGsjXDlSqQG5aff+6fNR52y/ssLjocLtWupfbEFCxEO1KlRSgV3mEBMdWDnI4Jlb
 nQk/1+zBqPZV2jl5m3/C6Rr+mxAoyYRn/xZbuy4zYP9FM4We6cCaMYTn17q3RoKgFHvg
 93prxefJLe+mO0TY+dzZnwHqN1rIqx7P9BHskFtvCu54ze+8scg0yoHeTjgXJP5/Wq1I
 +40Phd2VBf+eGEvgcsJhARGDPBTpTA64+ITlrMSb4Db/Pj/ik82l9zSp2EuReLVpbuiN
 WJ0I29lcYv1nscXgKvf2+cQLiGw072Q6YxahYijZtsxEu4HGwfmdX4Uh7Kkqvck3fi6f
 cApQ==
X-Gm-Message-State: AOJu0YwHUx55I6Kd5idYq4w6mzR5ILoMwECcX8P1k5osUYhUu/dBUH6M
 0KZ2N3Ekt+c0jjWEyERsQ49uy3b+8eeLhUf4c9gKpigSbA2aV+CrQ2zQVk55LbX5tr8Srb4d/5p
 ZZhViRe0=
X-Gm-Gg: ASbGncvnVn+IWwkm/Q2U60HHeq05cqIb8R3eMrlrS9K7U4msgIaa7seqgJIAVD/ssQw
 /EbPRGywCBcL+N1iYDQzZMgPiPtvVrRdvwCaHlOnRKhQfHvgf0re7ya+RafOP7g0HomV1+zqVwI
 nQruHJGWzzWHIyFDQK9v1bPXf9qJj4ZUD86t38bNThLhoeSGK2nvzh3KSvyR5NL767bhRSQ9K+R
 YIq+rmSdoD7eRpSaXCtFU+s+Qgd0Hqzi24YGDa/oSUmL4i1D58DRuf58/wrmxAdnV6WHCbBAST6
 dzxApwztt3HGEd1W6G8DO0x9OsDeqmj7HFfnfzeFk/reE71sqQqE9VnOU/jSWpnAelkGq6U1z39
 bx8XhQOLGYdd4sN/iKnAIDh0W+jtorDS98EfNnCuETcIlhtGZFtfjv7mTwcLNZkttxCxznyAgNz
 6/34Ejlg==
X-Google-Smtp-Source: AGHT+IFRYp0GLDTomXrceVYe5TxDbzmUecBu1IfuaDCnlC2bv3G+PR4CSnDC4vqwBoDJghqJ/PsHxg==
X-Received: by 2002:a17:906:9f92:b0:afe:a615:39ef with SMTP id
 a640c23a62f3a-b01d8a2667emr1504807166b.9.1756892540499; 
 Wed, 03 Sep 2025 02:42:20 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61edb0fdf1dsm1166351a12.18.2025.09.03.02.42.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 02:42:20 -0700 (PDT)
Message-ID: <420e8b3e-9f59-4615-8f88-315f78200321@linaro.org>
Date: Wed, 3 Sep 2025 11:42:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] linux-user/riscv: add vector state to signal
 context
To: qemu-devel@nongnu.org
References: <20250903081417.338515-1-npiggin@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903081417.338515-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x629.google.com
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

On 9/3/25 10:14, Nicholas Piggin wrote:
> Changes in v2:
> - Fix 32-bit compile
> - Moved sizeof_rt_sigframe change to its correct patch (patch 2 is the
>    one that extends the size of rt_sigframe, patch 3 is adding new
>    extended state to the frame which is added dynamically).
> 
> This series adds vector state to the linux-user signal handler,
> and adds a basic signal handling test case. As a sanity check, I
> also verified the signal handling test works in the same way when
> run under a real Linux kernel.
> 
> The signal handler test has some gross header hacks in it to make
> it work for me (debian arm64->riscv64 cross compile environment),
> I would not be surprised if it breaks in other environments, any
> ideas or breakages let me know. May just have to define the types
> by hand for now if it becomes intractable.
> 
> I couldn't find much in the way of previous discussion or work on
> this, forgive me if I've missed it.
> 
> Thanks,
> Nick
> 
> Nicholas Piggin (4):
>    tests/tcg/riscv64: Add a user signal handling test
>    linux-user/riscv: Add extended state to sigcontext
>    linux-user/riscv: Add vector state to signal context
>    tests/tcg/riscv64: Add vector state to signal test
> 
>   linux-user/riscv/signal.c                | 197 ++++++++-
>   linux-user/riscv/vdso-asmoffset.h        |   4 +-
>   tests/tcg/riscv64/Makefile.target        |   5 +
>   tests/tcg/riscv64/test-signal-handling.c | 507 +++++++++++++++++++++++
>   4 files changed, 700 insertions(+), 13 deletions(-)
>   create mode 100644 tests/tcg/riscv64/test-signal-handling.c
> 

Whoops, v2 and my review of v1 passed in flight.
There are a number of errors.

r~

