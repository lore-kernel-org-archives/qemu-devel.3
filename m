Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34136FCB637
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 17:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyYhA-0003x0-Mq; Fri, 06 Mar 2026 12:10:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyYh8-0003wQ-PF
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:10:34 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyYh7-0003x7-5y
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:10:34 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439b790af67so3611891f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 09:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772817031; x=1773421831; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S61AkLMm3JSn0UMvBbohswyBotXvKrhXmq9giBfJLMM=;
 b=dPUheEgzbFOZFRbteXiWHqLZYy5tLEQU3QtOyNSj4+WDVTJOuUMWzucva2RY8qnpGn
 SxmaDvUN99P8lpOuhgsxdf1W4T/Z7UaSjdH9EqUtFfI6dF8s/a5XMyNiKCVorTBBndjb
 izZ6jLyGFW4bQIRhrcsCm9HsphpaVvtlZr7Z6Ge1EJY2LYyvEWZ70MEtGcdfSPsAc32g
 B4jhqYSFtWrF1J3Qi5sp+qWgQrmjeAIR2yn1TjyueExxCD8YvJ8J5JEx7KzjCcM4Y2nu
 /vicO1zvaxXYrEYMkQtzxxGFWMWYF6zIJIgjermTmYoZfTrxoUpmxrWdImyXFSuWp43P
 uVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772817031; x=1773421831;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S61AkLMm3JSn0UMvBbohswyBotXvKrhXmq9giBfJLMM=;
 b=G9NVfQtt2uZZhEVan2NS5kgOFz0YF233IEx18iH9cN+jBE0XYfLViCqsYIxluLwtZe
 5yLmvlVmVx9TzV9mMZrEGVA+yxk+oqYt00zcXZ4Z4F/CiMZbJsOMDmJ96gl7qLXnTTcu
 30H98Z80wZZk7BFzTljeGjL5NzmKrkEfuZ3Cmh4NjXk+wOSzYlKuRwhl1nIGpD7OwOYz
 syNyMB2gNS9ZgBrvvuw6rvjduV5Lf7mUSNYRmy8fOAWdn8XWh2eZiUzDfs7ib50vpI7X
 4AS+DYlqJ8pjxBcOi+zu0ZM7LferkxoFFreWR3ucNuxknyzvFr+Ztgzck+vvCAaT7PGP
 Y+bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYhcUt4NHT1wfl0BwQGV4c7x6Gqde7lLpKCGCBh5JtFpR16zrwwG08Z3ib1Dag3WQehMbjTrsfRbZX@nongnu.org
X-Gm-Message-State: AOJu0YzUZl+542lLzFPcBk1qDsdvO5KlEJb09u3vPTuwsar/DNN5+sFs
 Ds3xBNg+fkaCv+1EcxBuVr6xodhEp9k+ooPJ1uL3cIXtxYJjZtVT3UqVU4LNtrZyJBM=
X-Gm-Gg: ATEYQzwHGHuLkQx2bZ1BJcF+KGnrDNufa17dM0nGefYukOZgqxlKRWTGhId7XIeGXUG
 TnP9vwmo2VMCOGzwXHhSBP+EI91ARvYrSnMlzVmXcZgqdpvSYTJvM1TFwcgbVpMsWeddWHJBgAO
 fOqnjt7sitx4Y9n/pJVZW7xJ51TIAm55DXCe9Hh1F0uHTCV+yJESG40q8wq7RcXtQSH5GMzgolU
 J80Kstvo2cjiHuSOLMlBbRKUzaEBdLy3gpdPe/SAghar8Qv4eiQGyjgwCRx1ZBGwYQhS80yIsYY
 WKhEOraJoONd1r755APGsE39SlibY+AIaPouYCWC3cc/7MTae5IrmQ/uiBMGm4Nz3yXZOtI2nYC
 4NMtekEq8H2KSDUbZJREaaBntVOllhTzFEui1VmAzSyEC8pJGBLgoxoV/gyprTSoK0Rz0iGLWZ0
 g35Mi52HeQdPaU82r8GooDjdhkiIGFaunTVh0OjOS2QCbWUT2W0ziy0LpK+nWRyqiHvA==
X-Received: by 2002:a05:6000:2f86:b0:439:c5da:64b7 with SMTP id
 ffacd0b85a97d-439cfd65b13mr12060994f8f.15.1772817030456; 
 Fri, 06 Mar 2026 09:10:30 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2ba66sm4245015f8f.20.2026.03.06.09.10.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2026 09:10:29 -0800 (PST)
Message-ID: <13ab2e58-8de7-4074-8871-4c59406f1110@linaro.org>
Date: Fri, 6 Mar 2026 18:10:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] hppa: Introduce HPPACPUDef
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
References: <20260305-hppa-c3600-v6-0-d51526e5269c@rev.ng>
 <20260305-hppa-c3600-v6-1-d51526e5269c@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260305-hppa-c3600-v6-1-d51526e5269c@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 5/3/26 23:54, Anton Johansson wrote:
> Restructures the CPU class heirarchy to clarify model names and allow
> for per-model configuration options via HPPACPUDef. 32-bit HPPA is
> assumed to run a PA-7300LC, and 64-bit assumed to run a PA-8700.
> A new PA-8500 model is added, which will later be used by the A400
> machine.  All CPU models are made into children of the now abstract
> TYPE_HPPA_CPU base class.
> 
> Two fields are added to HPPACPUDef describing the size of the physical
> address space, and whether or not the CPU uses the PA-RISC 2.0
> architecture.  The latter was previously a field in CPUHPPAState.
> 
> phys_addr_bits is currently set but unused, and will be used in the
> following commit.  Likewise, PA-8700 is moved to use 44 bit physical
> addresses in a followup commit to not break bisection.
> 
> References to "hppa/hppa64" models in test cases are also updated.
> 
> Reviewed-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/hppa/cpu-qom.h           |  8 ++++++-
>   target/hppa/cpu.h               | 24 ++++++++++++++++----
>   hw/hppa/machine.c               | 21 ++++++++++-------
>   linux-user/hppa/elfload.c       |  2 +-
>   target/hppa/cpu.c               | 50 +++++++++++++++++++++++++++++++----------
>   tests/qtest/machine-none-test.c |  2 +-
>   6 files changed, 80 insertions(+), 27 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

