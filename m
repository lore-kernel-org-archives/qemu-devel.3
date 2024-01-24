Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19495C47DDF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 10:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSaKY-0005b5-Dl; Wed, 24 Jan 2024 05:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSaKX-0005Y6-3M
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:18:01 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSaKV-0003vl-8D
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:18:00 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-554fe147ddeso7040953a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 02:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706091478; x=1706696278; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jHCnnfTejy5QARf1DO0t+EVDivL8dzaNZF5EgrGxArw=;
 b=ImQIniKV+3ofx1MvkX4lsSFNVc1txN2XQ8KST1by2UGtzpP6iSUdn5tZp9v5p8bOa3
 tleaWjkTWIPTeptJT6Q+PGhqQXm1j2p7BVMA2yJ0LI7I3dHamcZoEEflwBUKurXhWfAO
 cdOGjGTnKC4GXsoemPiy6uGUx/+5xRjKWoCCjgnA8zn9dtZoMPcg8trYIMcHSL7PWGtQ
 YGe47pH8KYrVINCN3NXXDJE1pxNc7Oa4M/uQKcV3K907JQkZpf7EN3L70o1A5jySvci9
 odX252+Mo3OHgB7LyXRIE287QY/oNhOHwoUDEton3r2PEV1nWQRcvG04KMzELiIJW/+b
 lcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706091478; x=1706696278;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jHCnnfTejy5QARf1DO0t+EVDivL8dzaNZF5EgrGxArw=;
 b=ZVarMJW0MdO5+sdg4WuAbjZmQNe02bK4hHmVdVS0MJfRuQl69bt88WeTxzUAVjpsIS
 vjb4XUJuwxdZaQW1NM872Y7Hdz9FoOS7ygqbJkuANbXwYM5Ouckp2lm3jsGNZ9nFLH2j
 iUt8dnzMyrYk9R0TmsD6M0p3KE0BJpiXToZHtGkvOiEmMViQz7RlQeZuKOztnXXOXHkl
 3qw4aoGiEhga56Ub6cVxMNoSCWWbStEo0HkUTg1KUxfmyObzbCcsCPtWAgyEKsneu/XI
 4eQiL8lR1DGb5ixxCnV3qoOeeX7Q8F+UV6azBaPBnZproCfZ+paXDg121oitluqpCDpd
 GFHA==
X-Gm-Message-State: AOJu0YyDy/8lLXDFewGaEYbUTxnu4R6rrWa+Md/0QraLD6iY0rCoBMtM
 e6R1NBzwgXKlpQ+6aWMPCDVe28vJPDdJA/YvJFyKRohevjVKeGRgVeR7kyLhm08=
X-Google-Smtp-Source: AGHT+IH0GVVhDCDTE3mWuVtBNJY5HjGlOkYH8RCAyfqek0koOcjYyYext1WsH4kBOYcDu2qbuobycQ==
X-Received: by 2002:a17:906:6550:b0:a2b:28a2:1bd9 with SMTP id
 u16-20020a170906655000b00a2b28a21bd9mr360936ejn.244.1706091477742; 
 Wed, 24 Jan 2024 02:17:57 -0800 (PST)
Received: from [192.168.69.100] (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 k16-20020a170906129000b00a274f3396a0sm15478120ejb.145.2024.01.24.02.17.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 02:17:57 -0800 (PST)
Message-ID: <f9b94516-fd70-49e8-85e6-c64019a52717@linaro.org>
Date: Wed, 24 Jan 2024 11:17:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] accel/tcg: Extract some x86-specific code
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Claudio Fontana <cfontana@suse.de>
References: <20240124101639.30056-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240124101639.30056-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

On 24/1/24 11:16, Philippe Mathieu-Daudé wrote:
> accel/tcg/ ought to be target agnostic. This series remove
> some x86 code, addressing part of "Work still remains" from
> Anjo's series:

Oops, s/Anjo/Anton/

> https://lore.kernel.org/qemu-devel/20240119144024.14289-1-anjo@rev.ng/
> 
> Based-on: <20240124075609.14756-1-philmd@linaro.org>
>            "Move perf and debuginfo support to tcg"
> 
> Philippe Mathieu-Daudé (9):
>    accel/tcg: Rename tcg_ss[] -> tcg_specific_ss[] in meson
>    accel/tcg: Rename tcg_cpus_destroy() -> tcg_cpu_destroy()
>    accel/tcg: Rename tcg_cpus_exec() -> tcg_cpu_exec()
>    accel/tcg: Un-inline icount_exit_request() for clarity
>    accel/tcg: Hoist CPUClass arg to functions with external linkage
>    accel/tcg: Introduce TCGCPUOps::need_replay_interrupt() handler
>    target/i386: Extract x86_need_replay_interrupt() from accel/tcg/
>    accel/tcg: Introduce TCGCPUOps::cpu_exec_halt() handler
>    target/i386: Extract x86_cpu_exec_halt() from accel/tcg/
> 
>   accel/tcg/tcg-accel-ops.h           |   4 +-
>   include/hw/core/tcg-cpu-ops.h       |   7 ++
>   target/i386/tcg/helper-tcg.h        |   2 +
>   accel/tcg/cpu-exec.c                | 125 ++++++++++++----------------
>   accel/tcg/tcg-accel-ops-mttcg.c     |   4 +-
>   accel/tcg/tcg-accel-ops-rr.c        |   4 +-
>   accel/tcg/tcg-accel-ops.c           |   4 +-
>   target/i386/tcg/sysemu/seg_helper.c |  23 +++++
>   target/i386/tcg/tcg-cpu.c           |   2 +
>   accel/tcg/meson.build               |  12 +--
>   10 files changed, 103 insertions(+), 84 deletions(-)
> 


