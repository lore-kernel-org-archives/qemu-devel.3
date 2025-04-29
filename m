Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2B8C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eht-0004cq-Tu; Tue, 29 Apr 2025 02:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9ehi-0004bk-1I
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:44:32 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9ehf-0000cK-3g
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:44:29 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso44149375e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 23:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745909057; x=1746513857; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JlqfCyNdE5FYlekZVAaqvdxIkrdBYx0EdLuO6m4gKXQ=;
 b=I+A05LJGSI8sfLkVV4wyR/aw8JwwrQ4Mfu78hbgfcYx4oJuM9hnKZlQDNRzrlTjGsz
 L+FGaZlKM/0KH92uTqPqkk8jaZhcSGo6PDe2v+XtI0Cil5xXjK2VF4uDh/FudBVpF+Ud
 /N4w4s4C9ZQ08fo9+BFVzjSWMvf2K4doMBeGcvIDh87SzLVs6jE1XdsrUZIcbyDzb9xz
 SUpS9YyfO0YomFexUtT+6T6peweZSvNRxilwAlh5PPD74Jkv9CoxXp4+80qhhS2oA+YF
 RQhvbwGthEnO+GxA0arwY+kSXsgsCNTumVaV88IOCrRlbg25q16EoltYtMKAi6/zBgpN
 hChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745909057; x=1746513857;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JlqfCyNdE5FYlekZVAaqvdxIkrdBYx0EdLuO6m4gKXQ=;
 b=ckLuOk6lnnStH4hNcwC7uBTpkKFnuxUnkJ83dEFoyqiakPA/NNH4HLWmU9pnARlo0p
 vdtS+vc62FfNHVYasPKv8uG7AsuEcs4VpGT8b1cxUmzi1f0kwFB9J+v6M3NVUK6EPZio
 D0hvCYjgARdwBrncwpkpRxpxR/xTaf6jzhtQ27NWI4uu03/j1+PnnER6GtVZwi7Wdu2v
 K/7/Bye5uOCHfeTmbh+//N4jlj/HfbzPh2MEN+oFtk+tHOWjfxqh77skT6/OPnHnm5Ws
 TxwiYgTQfPfIRl+NM5OyjYBTHwAQhwqGJQGCfjs5futkoQjYCQjnZ/Mfr1ywj1JKOKZT
 e3/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3uenlgxb2PKr+bLHuFAoWDU11qkDW12Mp67ym4QUJaTd2EZ3F/jYi/QkjYW9XUXZ5GH3IuxTL3Xz3@nongnu.org
X-Gm-Message-State: AOJu0YzlkRhVpVPjcrnuy3E48bRau5Sg/wGv+1Y9cded3e1T8AcxdE7p
 zTbb8mnoIoaD2Jajf0eGMnGzxK68xlTVyVNY06zs7eksFrrtQfvMb7JglfmHVWQ=
X-Gm-Gg: ASbGncveDqiEnplj7o7lRNzkUo9Jqc+bOG3wAkbEWMbrz9xkBWLIR2GlomSXkpP4FOR
 NM/bo0JX/TKkRZ6fu3pDqqy4N3fnDpfrpM53pfg/u+3mMXSdfU2A2ow/KUhcB8Ly2PTmQxg48p6
 gZNVVevxAtQ/ugslRmq4Y2Ls7me4aiVjvqDSlXTt6iuU5qSXGcbJ3X2J6moEG1RWPYXG6SqDrP5
 opjUda9kf6DUcm4sRkTBq3M56rguXXYsjUwJnTLBYdYR97hGY7sZF1IwaTMG9F0tBZlQLL7Ca3g
 NARpBSQAvJt2Ad0S0jn47MpRfxM2MSJ5E64HuhlWsWPsJ0lV9/ad9pv0slQijP6WQ4lBPmuW2OV
 elTyu2k3v
X-Google-Smtp-Source: AGHT+IG/re0U2Tx2EPr2yseNyXywcsc6ECGSm7WWNkjUaQzlHqkDw1EiTRrszRRPYp0XnwP/pTGnog==
X-Received: by 2002:a05:600c:1d9b:b0:43c:fe15:41cb with SMTP id
 5b1f17b1804b1-441ac85cf5bmr23130455e9.15.1745909056904; 
 Mon, 28 Apr 2025 23:44:16 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a538f9c6sm146196795e9.39.2025.04.28.23.44.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 23:44:16 -0700 (PDT)
Message-ID: <b7c96493-c10c-44a8-8ab9-7879837fe143@linaro.org>
Date: Tue, 29 Apr 2025 08:44:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] accel/tcg: Introduce TCGCPUOps.cpu_exec_reset
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
 <20250428201028.1699157-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250428201028.1699157-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 28/4/25 22:10, Richard Henderson wrote:
> Initialize all instances with cpu_reset(), so that there
> is no functional change.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ops.h | 2 ++
>   accel/tcg/cpu-exec.c        | 3 ++-
>   target/alpha/cpu.c          | 1 +
>   target/arm/cpu.c            | 1 +
>   target/arm/tcg/cpu-v7m.c    | 1 +
>   target/avr/cpu.c            | 1 +
>   target/hppa/cpu.c           | 1 +
>   target/i386/tcg/tcg-cpu.c   | 1 +
>   target/loongarch/cpu.c      | 1 +
>   target/m68k/cpu.c           | 1 +
>   target/microblaze/cpu.c     | 1 +
>   target/mips/cpu.c           | 1 +
>   target/openrisc/cpu.c       | 1 +
>   target/ppc/cpu_init.c       | 1 +
>   target/riscv/tcg/tcg-cpu.c  | 1 +
>   target/rx/cpu.c             | 1 +
>   target/s390x/cpu.c          | 1 +
>   target/sh4/cpu.c            | 1 +
>   target/sparc/cpu.c          | 1 +
>   target/tricore/cpu.c        | 1 +
>   target/xtensa/cpu.c         | 1 +
>   21 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
> index 60b5e97205..3ff72b8d9d 100644
> --- a/include/accel/tcg/cpu-ops.h
> +++ b/include/accel/tcg/cpu-ops.h
> @@ -155,6 +155,8 @@ struct TCGCPUOps {
>       void (*do_interrupt)(CPUState *cpu);
>       /** @cpu_exec_interrupt: Callback for processing interrupts in cpu_exec */
>       bool (*cpu_exec_interrupt)(CPUState *cpu, int interrupt_request);
> +    /** @cpu_exec_reset: Callback for reset in cpu_exec.  */
> +    void (*cpu_exec_reset)(CPUState *cpu);

I'm not sure "cpu_exec" is still relevant these days, maybe we can
directly call it "cpu_reset()". Anyhow,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       /**
>        * @cpu_exec_halt: Callback for handling halt in cpu_exec.
>        *

