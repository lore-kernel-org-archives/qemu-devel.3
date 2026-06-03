Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5564BCD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 16:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUotv-0005PC-Lz; Wed, 03 Jun 2026 12:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUott-0005Ob-Ke
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 12:57:05 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUots-0000KG-2Z
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 12:57:05 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-36ab8816a35so6555873a91.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780505822; x=1781110622; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hq7Tld+xP5icwAA24A27Ss+Gqa4T9WXi2AioM6zG01E=;
 b=P76dAzr9GdCmjECLni+jyTqlvT148KsuV11eRgI5JgAG/9j8WCrNHpfzVUN7QzsprY
 C9+6T3cE4A4zgBUyJubctzj7RI1K7PLQ66h7bmeOj/+0imYE20WXPx2dsz8za3GvlXxV
 rBBvhB6oE2JKoJ/hqbcZWwzETm3i7iObzGeLpyzs9bm3RrX+VKPD1OMmE0hJQjYc5n8D
 LPfLOFzhxuzgA5RYiwZnu5GD1vcq09lc1EMoYMEcChg0+5dQFHxzj39MEK85jQDiqcec
 rTCKfuqXoUUO2HGFXdBN1wuefTbLGLIsMTR0eDGtrpbB2jHRyOICJmXfdWCDFVkKeQ3Q
 tmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780505822; x=1781110622;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hq7Tld+xP5icwAA24A27Ss+Gqa4T9WXi2AioM6zG01E=;
 b=qMYRsPguOXvst0JipPUNbp6wQ5iHqWTnp0IHAK99cj0yZQcmksjV5g4/lYmgHV2jXM
 esTNGyyhOSVnmb7XTEY3FLOrbilc55Zm1mb+XDUsJTM4ZB03dDH2CHHurvhuXeUpT0rJ
 B5XXAaCjKJhS8CNhNYW6taAdKbgXfbm5OrMdT8XeCaXk+kqlbvZQTc29Q1amDkOot9PL
 51RKlByyEbK+DruR8dxCn9dF6w3OWe+GIMEIPOBLClniFBCcDUCUqbOzRAIUiJCT/A2X
 kIXJcjA04XL7WFZyOIxXNxjOSDJ3i9TIjX2uv797BWgwHsvWN9Ol1jDRmnwx3K4kkqX9
 NCMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+oQJemkGcJdDNe7J2HlBTQ4ztLHzRU73ST920lW9ZjHIYylyxWfMgN09fEtczEZDC3Eu0TYh9Bjl3J@nongnu.org
X-Gm-Message-State: AOJu0YwH7iP5sR6tgKWKtNEqD1DrvPwZ0zlCga5p04UhoyGOSOS/o89C
 Z4adnanYCQYOmAEPrOTqEvUGc2TlgAf4E/JN9JoAmyQE4vi1bn0EbvwtgEbLyumvbTa3VzoFUtF
 pmYWxY6M=
X-Gm-Gg: Acq92OF5soJgpUJR0X335gb7kXlhWaldkKEx2rFroser46Bqz87iy9fOnWAyN1z9XS8
 FQTIIVQwLm8EHoZP7/+weGAHP4cE0s0stceDCqxL23UbIHzzr2jBW6LYzo5YtU4PNzL5F7rWjYs
 +2f2k6LyYYOyBursSLpueTK/N+5oOOgp1/kioKQobITTfwQItJaFpu0EZXA+ASLk6pH7RqF3VUW
 puRB7UOVDV9PgNUJlfnS+U+Ty3pqI1l5/P6oPTleWju88CAUxuxuC5+PVrdznpWfv4+EgvZlm1B
 Ge6IwsGrtGnuSBKSocMRFIOqc0ROh5lh/mTTZzJUsPPi9N/9llcbIPf1S679RRSBOTvLbIEIEUb
 KO9opYjOfugQNgWGK4JL+taXsJI6gAGLkqJmmfnaOVbMLPVoQjLnERo3yxrOkNHffiOV7b1x0xO
 GQIYp+PK1kD6F83wUqND//Do9clNpHyT5yf214zRbDAQjUJr4=
X-Received: by 2002:a17:90b:5488:b0:365:3154:7b1 with SMTP id
 98e67ed59e1d1-36e335db2f6mr4522303a91.26.1780505822037; 
 Wed, 03 Jun 2026 09:57:02 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f68bf99dcsm247714a91.0.2026.06.03.09.57.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 09:57:01 -0700 (PDT)
Message-ID: <9c453509-7887-47fc-aaad-1cbee06a2208@linaro.org>
Date: Wed, 3 Jun 2026 09:57:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] linux-user/sparc: flush register windows before core
 dump
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260603161852.1831864-1-mattst88@gmail.com>
 <20260603161852.1831864-4-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260603161852.1831864-4-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 6/3/26 09:18, Matt Turner wrote:
> @@ -502,6 +502,14 @@ void target_to_host_siginfo(siginfo_t *info, const target_siginfo_t *tinfo)
>       info->si_value.sival_ptr = (void *)(long)sival_ptr;
>   }
>   
> +/*
> + * Weak arch hook: flush all register windows to the guest stack before
> + * writing a core dump.  Required on SPARC where the register file holds
> + * multiple call-frames that have not been spilled to memory yet.
> + * Architectures without register windows leave this as a no-op.
> + */
> +void __attribute__((weak)) target_flush_windows(CPUArchState *env) {}
> +
>   /* returns 1 if given signal should dump core if not handled */
>   static int core_dump_signal(int sig)
>   {
> @@ -828,6 +836,7 @@ void dump_core_and_abort(CPUArchState *env, int target_sig)
>   
>       /* dump core if supported by target binary format */
>       if (core_dump_signal(target_sig) && (ts->bprm->core_dump != NULL)) {
> +        target_flush_windows(env);
>           stop_all_tasks();
>           core_dumped =
>               ((*ts->bprm->core_dump)(target_sig, env) == 0);

Not a fan of the weak symbol.

I'm pretty sure you need this flush for all threads, so probably has to happen after 
stop_all_tasks.  Probably via one of the CPU_FOREACH in elf_core_dump.

We're not quite to the state where there are no TARGET_FOO ifdefs in elfload.c.
I think we can stand a TARGET_SPARC ifdef in elf_core_dump.

> +/* Override the weak hook in linux-user/signal.c to flush all SPARC register
> + * windows to the guest stack before a core dump is written.  Without this,
> + * only the active window (captured in NT_PRSTATUS) ends up in memory; all
> + * deeper call frames remain in the register file and are absent from the
> + * core's memory segments, breaking stack unwind beyond one frame. */
> +void target_flush_windows(CPUArchState *env)
> +{
> +    flush_windows((CPUSPARCState *)env);
> +}

Cast not required -- the two names are typedefs of each other.


r~

