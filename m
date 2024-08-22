Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56D8C52D6F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 00:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgvgD-0006tP-Pd; Wed, 21 Aug 2024 20:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgvgB-0006sL-Iv
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 20:27:55 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgvg9-0002cc-ON
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 20:27:55 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-201fae21398so1788395ad.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 17:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724286472; x=1724891272; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p5zPl3Sc6tg5qSbtJfAKfqHzO0d6LB3RfQCwrW0ZnUM=;
 b=UHPaMgCUDBLNiNPNup4kuNTygNmp09i8vIeserG7oVkr2I/A4Y1hEbAZA7YLlsU42B
 Y/PLmdOMFr8fIVvtpI9zgcVJUJ5zKswO6PmdeqL/qUaIqEypfqO9OoMkvBoqd5U7D+zN
 0WK37k7wi4gyKh0foQ5JQ+v8B8ApfuNEwTlETHpUAbY92sszP9yQpvmoW/9F8xrt2rnA
 PsPuBxWxbD68WniIjJCGksn+1BZankl1tj0udwIeaszgr6KpAePZF6NQrhZayzBWlqeE
 bWu7bzrjbXW6wGmFcrHqsuzBRRgwfQ4EXQFZqkgRXKDCbqzYBHGIBZECDxRln9Ch4Oqu
 nU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724286472; x=1724891272;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p5zPl3Sc6tg5qSbtJfAKfqHzO0d6LB3RfQCwrW0ZnUM=;
 b=Q4+cwSEYofIJyQUGxZhHX4reJBcceVT9h+qiIeH2DOb0pOQdWyzRDB1GbWkF+95RxM
 FYVLlc/Gpz7GeFMEQtW4S9dh3GQejgjNR94tdimig29+qU0no4zEZGnbsEjopNF9DSw9
 qDQYvqaSVM/QFdjzwf/epnM5y8D8IjoXVekYWu5fzUi43RqDOBVLih9m+MVWH0EjlhKo
 2QuNU5sTRPWBIDWZGFHb+tM9gHqb8n/y5yUBvJQg4whowg0MXgqbUK94EBtZudXregdn
 2bcb1Qsx7yCFRLIAQWDN8hpKBXL9CjLE/aIlC+bpckjAngGg9SrPRiq1GrybeXJUxqdu
 qzaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG5B5qJ69kwh2a6ad3tZ99u3RhthNa7/fO+/3U8LTVQ17VE4cDM8xNgqJtDvLOHdkb0xFGNh2gVGpj@nongnu.org
X-Gm-Message-State: AOJu0YyjBXCj+TLu/JTeEL0dqS8Zkoh66iaG4Bg1Po41TUO4mRk/+fTA
 2iNneHNnNZV2j4hn1IGafYEKKvl6Ju1xDV9c6z1CbqTm13kRoeDIAWjSLEm6ozg=
X-Google-Smtp-Source: AGHT+IFY5dC6s6Ij78DyP2HoDqOQEgpytCqF7SPZaQT6Qn9KR898Nmp0YgpsKpWgi8SQlnH9KgkvtA==
X-Received: by 2002:a17:902:f54f:b0:202:18e9:f302 with SMTP id
 d9443c01a7336-20367af4d61mr35279685ad.6.1724286471788; 
 Wed, 21 Aug 2024 17:27:51 -0700 (PDT)
Received: from [192.168.98.227] (60-242-98-186.static.tpgi.com.au.
 [60.242.98.186]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2038557f04asm1730385ad.85.2024.08.21.17.27.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 17:27:51 -0700 (PDT)
Message-ID: <e0c0a34e-372b-48cd-93ba-4a2c8630f6f2@linaro.org>
Date: Thu, 22 Aug 2024 10:27:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/16] target/riscv: introduce ssp and enabling
 controls for zicfiss
To: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com
References: <20240821215014.3859190-1-debug@rivosinc.com>
 <20240821215014.3859190-10-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240821215014.3859190-10-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 8/22/24 07:50, Deepak Gupta wrote:
> zicfiss introduces a new state ssp ("shadow stack register") in cpu.
> ssp is expressed as a new unprivileged csr (CSR_SSP=0x11) and holds
> virtual address for shadow stack as programmed by software.
> 
> Shadow stack (for each mode) is enabled via bit3 in *envcfg CSRs.
> Shadow stack can be enabled for a mode only if it's higher privileged
> mode had it enabled for itself. M mode doesn't need enabling control,
> it's always available if extension is available on cpu.
> 
> This patch also implements helper bcfi function which determines if bcfi
> is enabled at current privilege or not. qemu-user also gets field
> `ubcfien` indicating whether qemu user has shadow stack enabled or not.
> 
> Adds ssp to migration state as well.
> 
> Signed-off-by: Deepak Gupta<debug@rivosinc.com>
> Co-developed-by: Jim Shu<jim.shu@sifive.com>
> Co-developed-by: Andy Chiu<andy.chiu@sifive.com>
> ---
>   target/riscv/cpu.c        |  5 ++++
>   target/riscv/cpu.h        |  4 +++
>   target/riscv/cpu_bits.h   |  6 +++++
>   target/riscv/cpu_helper.c | 25 +++++++++++++++++++
>   target/riscv/csr.c        | 52 +++++++++++++++++++++++++++++++++++++++
>   target/riscv/machine.c    | 19 ++++++++++++++
>   6 files changed, 111 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

