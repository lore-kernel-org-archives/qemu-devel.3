Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F116CD5BC9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 00:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRg8q-0002zC-Si; Mon, 25 May 2026 20:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wRg8p-0002yq-CA
 for qemu-devel@nongnu.org; Mon, 25 May 2026 20:59:31 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wRg8n-0000Yj-SV
 for qemu-devel@nongnu.org; Mon, 25 May 2026 20:59:31 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3697f25d26eso5252371a91.1
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 17:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779757167; x=1780361967; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hDuVAeR6vhRwTXisvyB4W45rC5DZKRJvjCnRb3FnuuM=;
 b=DnGVEIoUBZybIqhLWBcJbCH1xYbJ20zSO0+xDUute8jeHF+4CgENJYldOFaIiRwP1h
 Lq8ENCKrDoKzioFRdFKnotkyBvyl95h0Snc8vn+nVZGrlYEZLhPMrRiJ2OgQ7R0j7JD/
 KCQMwKLW9sfsHG/jkOGLmuDIZ53HSEIWLfqHEaDyfApo2uwa8sqI4dRuduYAPYkALgsd
 TQ5fxcu1cyG2KzV0IDIikxabpd5rj4PF1ibHeaqzzioT2ec8iLH0oRyOOZU/ruM1WUKp
 N6YgTZnC0eNzRaORfZmkk4xYgYVPJ+MAUNb9YydOeZwg0HDGdBsbPdQyPyrzGAxwl9c/
 cY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779757167; x=1780361967;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hDuVAeR6vhRwTXisvyB4W45rC5DZKRJvjCnRb3FnuuM=;
 b=D4iCXVEdgh80zh4A6JxbdC0Tx9fkBUvACtUDsMsI7td2WMX6/F6axr+xNt/ISw8Hsh
 NbrRXelO4tkdJM3AuhsVgnrZHc1z2QpXGlolmt4KZA2wu3/6VzxtABqvIx4Wmo6fu2SB
 t6qzsPcefr8t7iwJrZ6quXHWxKnqyJjZHgPhlu5WQuvHgeCmSr/xSslMoAxzUQizOH1z
 V7kN2kVpTAofEcm0t1ORzsL7xkD8WHx5Q96QExBb1Z163vJtV4OvXFIC412jExHdn89G
 VlzA3dyPrlMnj3JxU8cV/XgdyuMQ0uugiSiko4TEqticMndgRzuMeM1dHGTYeLRDp8rA
 gp1w==
X-Gm-Message-State: AOJu0Yyft7+xrA5TzCm/1FFeWqIhNuYmOAsweCbIEQON+GI63/Mt2GL4
 aT+VNHOJnTOhu+Ul8aOpqqNCSyl55Au4Z1mD8BilVNcuk0e2cKUYSab8AiWNizkkf31dYtpdn8B
 Ys8XTDmU=
X-Gm-Gg: Acq92OE43ojLPCM7tIM013vzq4rarcel6n/gRnwf+0/mvgIG2uRxiXCDl2B6vqwT5gs
 uXq954jXnohvs6g3YPeH12FlgjiupCVdJ5C0zLCSD+WwX75+Md2OWnLhnul+zewu1FalXYIcm1C
 S03G61g/Uz7f4Qxzg7SN6qktf3I+NQPnkC267uBUDG4/QyUHqxKRgwOsGSTT4FhcnSMltw3XnYS
 pY5jGOIqsf4w+EvS2YDpwDoeDbGQDHRI3l1Z0YauUROIzzedtug0Q+dS5PJFwC/4wCm+ssBEbRl
 mU3DZZQC/q+5YI6Hu/9x4jyDHkqYFE6rSI3fd+k7pqv2FkE/hFK0cBVlFQpfisMMaTNKsXKPjz1
 v/IVV8fPrGkI/BhOJphilxa2U9hNjFaOdyf+1MWHITqWVlqXDcvWms4sHpadsc1zfNj+eDlaP7z
 vr8dtzCXoVUpttoVfyWO7OvoQhbq7gWqd55nQ5HzS2HbZ67UpIke2hqMUIWQ==
X-Received: by 2002:a17:90b:5343:b0:35f:bb33:d72c with SMTP id
 98e67ed59e1d1-36a6773cf81mr13220636a91.4.1779757167422; 
 Mon, 25 May 2026 17:59:27 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a71d93e6fsm10529869a91.4.2026.05.25.17.59.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 17:59:26 -0700 (PDT)
Message-ID: <bd8df63e-c2b0-4f78-b9e6-7324e2b240d3@linaro.org>
Date: Mon, 25 May 2026 17:59:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/ppc: restore fp_status from FPSCR on sigreturn
To: qemu-devel@nongnu.org
References: <20260525152312.4120017-1-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260525152312.4120017-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 5/25/26 08:23, Matt Turner wrote:
> restore_user_regs() restores the PPC FPSCR with a direct assignment:
> 
>      env->fpscr = (uint32_t) fpscr;
> 
> ppc_store_fpscr() exists precisely to write FPSCR and keep the derived
> env->fp_status in sync: it calls fpscr_set_rounding_mode() to update
> the softfloat rounding mode, and set_float_rebias_overflow/underflow()
> to reflect the FP_OE/FP_UE enable bits.  The direct assignment bypasses
> all of this.
> 
> On sigreturn, interrupted code resumes with whatever rounding mode and
> overflow/underflow-rebias state the signal handler last installed in
> fp_status, rather than the state that was saved at signal delivery.
> 
> Replace the direct assign with ppc_store_fpscr().  The FPSCR_MTFS_MASK
> applied inside ppc_store_fpscr() only excludes the computed FP_FEX and
> FP_VX bits, which it re-derives correctly from the exception and enable
> bits in the restored value.
> 
> Fixes: bcd4933a23 ("linux-user: ppc signal handling")
> Cc: qemu-stable@nongnu.org
> ---
>   linux-user/ppc/signal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git ./linux-user/ppc/signal.c ./linux-user/ppc/signal.c
> index a9c10e0987..ab1afea30a 100644
> --- ./linux-user/ppc/signal.c
> +++ ./linux-user/ppc/signal.c
> @@ -420,7 +420,7 @@ static void restore_user_regs(CPUPPCState *env,
>               __get_user(*fpr, &frame->mc_fregs[i]);
>           }
>           __get_user(fpscr, &frame->mc_fregs[32]);
> -        env->fpscr = (uint32_t) fpscr;
> +        ppc_store_fpscr(env, (uint32_t) fpscr);
>       }
>   
>   #if !defined(TARGET_PPC64)

I think the cast is wrong.  With that dropped,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

