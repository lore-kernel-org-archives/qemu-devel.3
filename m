Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDA5CD5BC9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 00:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRg68-0001ks-Ra; Mon, 25 May 2026 20:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wRg5s-0001SX-CP
 for qemu-devel@nongnu.org; Mon, 25 May 2026 20:56:28 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wRg5n-0007Av-VE
 for qemu-devel@nongnu.org; Mon, 25 May 2026 20:56:25 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-367c2a39fcfso4597353a91.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 17:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779756982; x=1780361782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uFpt4VOCnZhzZqjaTPlctGv0zya+v+8QKGsP2bPsAZs=;
 b=XrbtqRUGNnKuZrOWMZy1AXrc8a2TT/jIrhXbikkCs9tpB04vsLp/yXcEoR30QDly1b
 vpA9nKuT1L9O21S0GoCsSjN0Ejlr2KD44tTD1XEYMkEDdUpdMArK1kvn4dfuFMGsXL5w
 CQYj6GVkcMzfN0V6+rqGq4OQP6TCmQu1YD9rloQm9T/JxU1dO+p/2EXGmW0SjZZOdwPb
 SlOtJ/79FDtUISkIfHYlGRYyFhVvscBVW4WJgoHWWXQYtPHl0mL2dXmV5dqxqfrxV3xH
 1176TugiuDjfuHXmDunqvXNFmVpCGEmk9bYglfx8QdvyUZcjRehaW2vdSsj7UqVa46I2
 uaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779756982; x=1780361782;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uFpt4VOCnZhzZqjaTPlctGv0zya+v+8QKGsP2bPsAZs=;
 b=Td/HiOp6D+0R5HdeD+4ZOM+GapcJaGPFtECh3pF6UvCPFkdsS+CinUzpjMIeRmvkY8
 JbhmxeaxVascQ+jU/jpdz5y/W3+ywp0uOdWuMwXMsW+gVyXkC9ZAsGIuxlMxrgo/6Zqn
 DrnlmTzux8uPplIxxjNIy0LUkdu+TcuA/RzfoWlTUhzyxh61M7elJwUh/Zm6CuBn0i07
 JgPj8SwKFB0ss0BvP6p64FjN1wSaLXlTe9IKL54ja5MmXxu2aiMXgqtpLGul3HkmlJG9
 dCy8MFAjR4NAwZ93yDrmPwzrdlz/qMbwHNNdMOKj5PJLeWQpHq4aalyzrYe3/wWxTJPF
 T+jw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SX4pkcLDNMT70pknJITApRzuZpLScYopQ35NEoLMrzHTL+5Jb1VfinXGhc0qs5ntb3KDOCrnc0dLG@nongnu.org
X-Gm-Message-State: AOJu0YyFg2eMOvT2o478ZFq1I1MpUxYeD2dObaKZJFTYkORUOc9MI2fI
 u26aqQB8lx+fTHaOTPAxdNMok9uIaElC8Uiv05D0jHFxtHouO3bo6D8Sx8hMpguFodY=
X-Gm-Gg: Acq92OFVNZYrX9dfvpj5/QLyhpj61deceXkrNhg0Is9XQTyCYmmUpLtP9cx/33u87mx
 139w4R3+x0yDjQyDf3PbRhKYYfD8W2fTRISBKhFx7aT7CLl6VIYOEP3kieoGVjGoVUW88btcJ//
 kcIRNOgiCtLZUYE/6ioAZ17rMV6lhpPx8QjJSm0UejfECbnuSsQFOAZP7ugTbbwdviWNYxMvCxr
 x7409nCDSNjjEaVS+Lr984c0KLZSPqkh9REvt+sRdOylQvU3BOfucMJB0oYypyspXDfMrNJSjoc
 wY1oneiOXwYtVOxpMXZ+Srs1CHwE+puxyM1QU+qaaPm9gyfzDWmvjSb3Tb0EbrQUQ+GlFC0mJC3
 w+RqaArwE5bymtu7YGbLRofP/wdqub4Nh1jp+vpdYpCuPHWTing6ixvrPjcrkVs+lKi34mLgxB1
 /EAQHl3TSdY79CbnNsKsFzuxvDtd2uLDQMNtvX
X-Received: by 2002:a17:90b:3807:b0:366:2e1f:393 with SMTP id
 98e67ed59e1d1-36a676291d3mr17190155a91.21.1779756982176; 
 Mon, 25 May 2026 17:56:22 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6c44a44asm6693635a91.2.2026.05.25.17.56.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 17:56:21 -0700 (PDT)
Message-ID: <fae95369-8b4f-42e6-ad26-7ffe948c4cfd@linaro.org>
Date: Mon, 25 May 2026 17:56:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/sh4: sync fp_status when gdb writes FPSCR
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-stable@nongnu.org
References: <20260525152642.4121729-1-mattst88@gmail.com>
 <20260525152642.4121729-3-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260525152642.4121729-3-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/25/26 08:26, Matt Turner wrote:
> sh4_cpu_gdb_write_register() wrote the incoming FPSCR value straight
> into env->fpscr, leaving the derived env->fp_status (rounding mode and
> flush-to-zero) stale, so a gdb-initiated FPSCR change did not take
> effect for subsequent FP operations. Use cpu_load_fpscr() instead, the
> same way the adjacent case already uses cpu_write_sr() for SR.
> 
> Cc: qemu-stable@nongnu.org
> ---
>   target/sh4/gdbstub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git ./target/sh4/gdbstub.c ./target/sh4/gdbstub.c
> index 4f36e800d2..bdc8c1d164 100644
> --- ./target/sh4/gdbstub.c
> +++ ./target/sh4/gdbstub.c
> @@ -113,7 +113,7 @@ int superh_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>           env->fpul = ldl_p(mem_buf);
>           break;
>       case 24:
> -        env->fpscr = ldl_p(mem_buf);
> +        cpu_load_fpscr(env, ldl_p(mem_buf));
>           break;
>       case 25 ... 40:
>           if (env->fpscr & FPSCR_FR) {


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

