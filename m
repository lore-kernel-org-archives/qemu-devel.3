Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B845C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 22:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thc1w-0003pO-Ow; Mon, 10 Feb 2025 17:13:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thc1r-0003aP-TP
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:13:23 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thc1q-0001Sz-6j
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:13:23 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2fa1a3c88c5so6211077a91.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 14:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739225601; x=1739830401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZUWjMJc4W8+3u0IVXoIAfbjkMI2waB69vYIAm3ky0uI=;
 b=OyFS7DrWgZKplkQNJbhxywTXzhWUMmCdgdvbDBdBZmDxcK1LZxwzbYWrKPF90i8O9b
 jCxwSSrkSRAczOUm3oSuX1lTSAaTVCqbggYUzvYAirUoG1cpWPQwa99l7QWOhzb2ouk+
 oJc57+Jg8J785xqX/eI6PW0kzQFWXuVWyDPxBLngPVKeryhSlrpF+5eQVHPgrCSupaah
 Nib7PpBxSmcVUqpn/alGKNCdv34x5NpEaafO4WPLjRTsDsToclNchf7Y1Liz+/WWgJCE
 U2hEffuYcJGSN1tatv2jY0FpKqkRoHxwKw7LxB9vWfjmjbyRueUnCnuDaE9AJUjqlV8i
 hZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739225601; x=1739830401;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZUWjMJc4W8+3u0IVXoIAfbjkMI2waB69vYIAm3ky0uI=;
 b=qjyboeL3voM4DyYlJUcZFPF4XUVdoo810jiG4d9UHpeLWossUqj04QW8q2FilykVx9
 Rn7LMeZfYjXlIxpY1ZdNku0uqlv0TQyXG0NbSfcoZnWcuAKe31kRPW0k71yBYRfP6/nX
 AvvbWtNMBQ+9YeHSdph4WhjQLZMZKMFYMnAQVugfbRlfRsf4QPBFMExfB2SyrP5wI9Qh
 V5cXybvkfKNo6gXJjFHkxlapel6faraowox/m0NN64kxGFm+USNeQpMb9rrSShWBgJTG
 EDSPlLZ1TRuHFna/45/GOUbA6/ws9Pymz+2+xLdV6hhGn0GbBCDHMOIQW8wK9LRbBP8s
 axhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgtUXPeX7k8EeFDKg8ei2Tg86m5f6udBfIFtedKBM7wlT3OiNfD/dhfps4qi/G+08VwjBMJad0NcbP@nongnu.org
X-Gm-Message-State: AOJu0YxTEr+FryNmmrEpolv+bDxpunyyWr4Edx1Fh2psWkPe1hFh8csa
 rSaSWJAGSIXgZfGYt4OeicAEEBJc/v3NrWovoqEPTMQMMAVvxog0goi627FZMMY=
X-Gm-Gg: ASbGncvsBVGNpadhD+wgcckd7U0iWu2rnxsud1Yoo7OfuGAE6wQU/lvpavWgIErojcJ
 Srl6Q2hOXT8DfDvBvg6sbLVwDhWL8jAk6EI2FdNBW54km8ewuPpffh+uaC1n8iobmwg5BHWgRQB
 hXWISuCXOHMpEt8zj8pSgmqn4dqbso5okMB3nrKrwNAPoMUi0QnKoz4LFdzi/bTcXZbeeFwhD1M
 Z2FDmOgo1dsbM31M3KNW+haIRu/0evIY25qLDsleGWXPhhB68keBaeEPPM5bwWQrcmcL1OO6k27
 GonA+lSOJp4m+z+RmI7SJIcNjw36Uif9uegz2fy7vDgbYSh9/bovBew=
X-Google-Smtp-Source: AGHT+IFJ2FxSxerPwPjJRtCVKI1e/TlcdiT1PCXTp42og1rTRk2JzHL6fauLCGoo1Bg4QcV8STI0+g==
X-Received: by 2002:a17:90a:c883:b0:2f4:465d:5c94 with SMTP id
 98e67ed59e1d1-2fa9ed7cef9mr1785671a91.11.1739225600875; 
 Mon, 10 Feb 2025 14:13:20 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa08268f47sm9243539a91.13.2025.02.10.14.13.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 14:13:20 -0800 (PST)
Message-ID: <9ad927e3-9939-452f-b7d2-5bad5fe19e7f@linaro.org>
Date: Mon, 10 Feb 2025 14:13:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] target/xtensa: Set disassemble_info::endian
 value in disas_set_info()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Thomas Huth
 <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org
References: <20250210212931.62401-1-philmd@linaro.org>
 <20250210212931.62401-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250210212931.62401-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 2/10/25 13:29, Philippe Mathieu-Daudé wrote:
> Have the CPUClass::disas_set_info() callback set the
> disassemble_info::endian field.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   target/xtensa/cpu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
> index efbfe73fcfb..bc170dbb5cc 100644
> --- a/target/xtensa/cpu.c
> +++ b/target/xtensa/cpu.c
> @@ -159,6 +159,11 @@ static void xtensa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)
>   
>       info->private_data = cpu->env.config->isa;
>       info->print_insn = print_insn_xtensa;
> +#if TARGET_BIG_ENDIAN
> +    info->endian = BFD_ENDIAN_BIG;
> +#else
> +    info->endian = BFD_ENDIAN_LITTLE;
> +#endif
>   }
>   
?:

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

