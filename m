Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9783FC531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 05:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgHRS-0008Cw-EC; Tue, 20 Aug 2024 01:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgHRQ-0008C4-DE
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 01:30:00 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgHRO-0002ND-Mf
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 01:30:00 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-201d5af11a4so47207255ad.3
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 22:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724131797; x=1724736597; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XFIfNKPX35OgTOVZZu6v49jKwMCLXmLQgIqUZjqSRbo=;
 b=MbqsBkEW1kFACVcEnleiXthLEzihukgtv9m0CrMuzqrKfyplrsuqrptpNJXFeb0VFT
 m2rtbSjVCjN4Pn6EPcGfhbJe7yg4J2w8YEZwFdaXiH2IvNxvH1CBim8jQnMoh/Yz6WD8
 Y4Zf3HHzjIjKeVZGt6kaX6yoPjx9PHzxwlrCKaQi3Rwb95PYHWgxEt3qaJrdNx0mY0WW
 URuGxATChpJWwJ81XkpulOsStW7QLelfNFzPrvlPjWCY+Yu+FnBV47B0NF/rKk9hq9hr
 eBMJcg8YGjR5O6ytXshoR84DGFXV5AD9XFwWn6hI5fxEELySqTIZUfuWfzOpKhtaK3ip
 yGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724131797; x=1724736597;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XFIfNKPX35OgTOVZZu6v49jKwMCLXmLQgIqUZjqSRbo=;
 b=ZLNJJTKCKhAnB1c0SVGRwNDmSP6GN+TNVYiclR+gxUsC9tgVDACDE6O1BJVbwir0Le
 PlExzIhK3sWAM45D8bsL6MQ+ADxx3W6ovISAEYaA/DmQ4++UGbGmAPO/i7Y89EqwLtYH
 9ocXhVHXP+VVo2Hw50D1OQufyKPlcN/1xT659Efl6jJQx31emcAzjlD15Y5j9Uo2Giw4
 vnFd0704iYDQ64BYpVlwx9MAbBPmgg3QI3okOPSUaaquxfSXClvvuN8E31aJofQSJGFH
 d0uHDSQuhMub6hmZ2G5zKjZYGkIiEV+fRrSoAy8cgENBkyfe5+jfHUA9t0fza+E8o4ei
 QLTQ==
X-Gm-Message-State: AOJu0Ywr7ZpsVvfZ9h3dCpIwQAHxENqB5d8kNI5jdZJxy3bXnqPDc2W2
 8RH4+BuS6Xt0lT5Y7NqLU5TQB4s0cQt+yj7tEyt6jdR3ILy3GYlUTdecOnwpD7QN9PWONQePCbH
 nuGA=
X-Google-Smtp-Source: AGHT+IF66pfxSfv8F6EIToo7ykkH6dCL3NL1JanHTpgZVUexjWtwiZRkjf/pFFrrAmLxYKLRl0oPuw==
X-Received: by 2002:a17:902:f550:b0:202:3469:2c78 with SMTP id
 d9443c01a7336-2023469311cmr109563565ad.28.1724131796945; 
 Mon, 19 Aug 2024 22:29:56 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.3.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f039e084sm70875075ad.243.2024.08.19.22.29.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 22:29:56 -0700 (PDT)
Message-ID: <04082b27-3c3c-4a1c-9416-c8feb2319c6d@linaro.org>
Date: Tue, 20 Aug 2024 15:29:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/15] target/riscv: zicfilp `lpad` impl and branch
 tracking
To: qemu-devel@nongnu.org
References: <20240820000129.3522346-1-debug@rivosinc.com>
 <20240820000129.3522346-7-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240820000129.3522346-7-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 8/20/24 10:01, Deepak Gupta wrote:
> Implements setting lp expected when `jalr` is encountered and implements
> `lpad` instruction of zicfilp. `lpad` instruction is taken out of
> auipc x0, <imm_20>. This is an existing HINTNOP space. If `lpad` is
> target of an indirect branch, cpu checks for 20 bit value in x7 upper
> with 20 bit value embedded in `lpad`. If they don't match, cpu raises a
> sw check exception with tval = 2.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Co-developed-by: Jim Shu <jim.shu@sifive.com>
> Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> ---
>   target/riscv/cpu_user.h                 |  1 +
>   target/riscv/insn32.decode              |  5 ++-
>   target/riscv/insn_trans/trans_rvi.c.inc | 55 +++++++++++++++++++++++++
>   3 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu_user.h b/target/riscv/cpu_user.h
> index 02afad608b..e6927ff847 100644
> --- a/target/riscv/cpu_user.h
> +++ b/target/riscv/cpu_user.h
> @@ -15,5 +15,6 @@
>   #define xA6 16
>   #define xA7 17  /* syscall number for RVI ABI */
>   #define xT0 5   /* syscall number for RVE ABI */
> +#define xT2 7
>   
>   #endif
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index c45b8fa1d8..6533cb0758 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -123,7 +123,10 @@ sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
>   
>   # *** RV32I Base Instruction Set ***
>   lui      ....................       ..... 0110111 @u
> -auipc    ....................       ..... 0010111 @u
> +{
> +  lpad     label:20                   00000 0010111
> +  auipc    ....................       ..... 0010111 @u
> +}
>   jal      ....................       ..... 1101111 @j

Again, best to line up the decode bits.

While you are required to add two spaces within { },
you can remove two spaces before the first '.':

lui      ....................       ..... 0110111 @u
{
   lpad   label:20                   00000 0010111
   auipc  ....................       ..... 0010111 @u
}
jal      ....................       ..... 1101111 @j


Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

