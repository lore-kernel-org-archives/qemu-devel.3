Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60607E9380B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 03:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC7gg-0002Iw-CC; Sun, 12 Apr 2026 23:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC7ge-0002I9-9k
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 23:10:08 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC7gc-0000oP-Nx
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 23:10:08 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82f2385724aso934006b3a.0
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 20:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776049805; x=1776654605; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f/shBeol6NdSR2RcjLmiMkLVbnFPGJITlIgbjucedfY=;
 b=s46mIY0Pzxu9SH3Koc6XzLfTWltWU7GBYUDknYH3hA94w1KiQMeLzpAxCcl52VO6he
 Q6JLMTPxvp36/tdXKbOA1EMBkUS+S/JIRG7Hv6xUpxo3/bi/fvmoKbh1aKVq+fHMbEyU
 OOrLx07fhOLlVjz3wMVreZRtn3aqA/fvmKF5LZPFvHKWwkotabCneYUz7VrBcn/LYaVZ
 bNDAQFiiEkuO1aimCT7xmfCX4MsAhpVOLDXEq29tddAnEa1llFLeYtBDkf+aaklTS0GH
 29QDNUvz8NGURHC5MaLA9YStyK+6QcDSVj8uRw54usc1nDicN1m4SuA6hbhcOQ4k7q8W
 Xm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776049805; x=1776654605;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f/shBeol6NdSR2RcjLmiMkLVbnFPGJITlIgbjucedfY=;
 b=gNdJJJcmrlNGtUjC15X5ksZUCKAzBmij1dvkWbzbsSyLObCaFPV4b8tAr6QUsC+QkD
 LrWdSH0W5ZDdVAKzNgNhcJw4o0lJvp5ahRdxk630lyPn0y6X9d6bfpgDEUa7YTpNWlRU
 xpkxrOAB+9olTwHBUiK6aV3YNet7jLJnWSnhcwriUMJpi59JMSc4jdcpm8ak7KT7EUy5
 6X7A8L/GpKjvXa4Z+bXqmq6kbk75Ggp+7xc0n/GvA/ai1wHyy0uc16MH02p8WFYs6GRc
 d/4urYS/36Am1hPZsy4x0ak3bXr7jDdAR27j6fT17pr+viSXGq1o8/jTz7LnYVFxOI7v
 Anog==
X-Forwarded-Encrypted: i=1;
 AFNElJ9/3orJBmGRc341RbA+7l7AJgzhtgVB8dKfI3x/Syiiutnv2Xv3t8Tec7oIYNdXb6T6XuNyDadpEbPd@nongnu.org
X-Gm-Message-State: AOJu0YwBkaHm/spWlFDC81GGE1yNZQpor4MRWJ9zTZDP0AMe3/3xNHsK
 KnSGe9mcNMc2X01k1FIYb1hpcmtRBZ410ogBd2IaHPRXd0BrOnJfRCLKVgF/6rNUR0A=
X-Gm-Gg: AeBDieu5O6lln+vZ7AYIMz5/W4Xotx6S1TVLy+VtOqKJ9G9nUn3S69Wt9xpNee5LWwX
 dZRKLJLw4GS4r6gyq2QjQdc482NfTIyWM/z4Zo/uoYjdnhMkxrbMhzfex6gC8bFfyYhSfumrbkA
 wGB+WMFPC17HxUDn3lGhSjgPcwHTU2UOGr9+cX4qmrl+gCR6H5g6O1Tdn+rnSS1+bDJzT2GBZBh
 L9GAUmEGJ91iK+MwHbirrrC9l3aZ6Nqs5/1czyjC+RIW3slQWUtKB2KXuas6CAwz0O6KUSDWcUW
 +tr4bQ5irDWfd2m75WheEV0t+1YUmjsDACnFcQGcqaybVZYwIowyWHOUCf68eSIfxv8NdEmCfva
 ZyUufsfOYfbdwySdFrd+1PfglQq2hJ1NGa0gC+A94++Xbj+NG30UWuuwWXqvntCjG73hTWvnzgQ
 Mxd6uymA8hhkrGSEkqQ0NbpTxXn2gVfJXQIiWrzM/W3A9qUA3N3We/F+Jm6EUjlDUc86L90CsTl
 YL/BZDYDiyYWQ==
X-Received: by 2002:a05:6a00:1ad1:b0:82c:e4b9:531c with SMTP id
 d2e1a72fcca58-82f0c1e6575mr11662172b3a.7.1776049804492; 
 Sun, 12 Apr 2026 20:10:04 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 ([2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c4e854fsm9589265b3a.49.2026.04.12.20.10.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 20:10:04 -0700 (PDT)
Message-ID: <fdedc9be-2d42-44fb-b1de-fb41c61f1b4c@linaro.org>
Date: Mon, 13 Apr 2026 13:09:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/27] monitor: Remove 'monitor/hmp-target.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 4/11/26 05:52, Philippe Mathieu-Daudé wrote:
> he "monitor/hmp-target.h" header doesn't contain any
> target-specific declarations anymore. Merge it with
> "monitor/hmp.h", its target-agnostic counterpart.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Dr. David Alan Gilbert<dave@treblig.org>
> ---
>   MAINTAINERS                   |  1 -
>   include/monitor/hmp-target.h  | 42 -----------------------------------
>   include/monitor/hmp.h         | 12 ++++++++++
>   hw/i386/sgx-stub.c            |  1 -
>   hw/i386/sgx.c                 |  1 -
>   monitor/hmp-cmds.c            |  1 -
>   monitor/hmp-target.c          |  1 -
>   monitor/hmp.c                 |  1 -
>   stubs/target-monitor-defs.c   |  2 +-
>   target/i386/cpu-apic.c        |  1 -
>   target/i386/monitor.c         |  1 -
>   target/i386/sev-system-stub.c |  1 -
>   target/i386/sev.c             |  1 -
>   target/m68k/monitor.c         |  1 -
>   target/ppc/monitor.c          |  2 --
>   target/riscv/monitor.c        |  1 -
>   target/sh4/monitor.c          |  1 -
>   target/sparc/monitor.c        |  1 -
>   target/xtensa/monitor.c       |  1 -
>   19 files changed, 13 insertions(+), 60 deletions(-)
>   delete mode 100644 include/monitor/hmp-target.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

