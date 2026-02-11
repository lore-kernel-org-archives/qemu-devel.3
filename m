Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B06EB5949
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 00:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpy8f-0007NO-Kf; Tue, 10 Feb 2026 19:31:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpy8b-0007N3-PQ
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 19:31:27 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpy8Z-0000TD-9B
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 19:31:24 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-354c6619a07so1774139a91.3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 16:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770769882; x=1771374682; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BUQ3Anut1bEQg4Y+nzbjWJH4L+/k31Ak5RYZqjsQkKs=;
 b=sMONWP/F0lv6RNl6gfvIfDMUJ/TWa2vQCNmlGgMmRJs8R2rj0kktOD5jpMwc/fW9Tc
 Xi2O/nIVIP/XZL68nVHsaI9cjIzklibXMXv9eLEh5kABxL/qE9dDzgS92zrsbxMpyM0J
 e8gGQs44FlXKOa9AlHAH6OfvmJkThZ4WTZ6FoJWE9ZkbLeepe4UPlbGiDd362/jDDjTM
 IPzTOsewZ/NQWD1AVsoCAnSXMYGA2SN9HHXf47WPxG08DcocbYyguNy4z6lcxT4W2J6c
 jocx3428EjhuR5LgVqOFCfGZKaTDEdyL/54vpkB1rrVjp42CpyuCQ63VzTjn3du9jDkt
 auTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770769882; x=1771374682;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BUQ3Anut1bEQg4Y+nzbjWJH4L+/k31Ak5RYZqjsQkKs=;
 b=L92+SHoxcg6kr5DldNYTBaF5xzm36CQ8QV9O/3XegZh2qwxTPQ+vSccz9bGY0EhMyR
 /eWh19SHtDrPI0MhY/GiTU2HNJq+T3MfrICKY/cX2Nin6fB3nakxn8OdvdjEJV5ZcrEa
 ak85l09jTwJnx6ep/8iwFyDcEysBIaL0wzI8gvTeZk0FradXF+eG4Nlu2lS3N6TVQIN2
 rZWLEgG8g/C3IPsZCAeWjVI/WYMyY0Zz/twNgjvqx9Yw2yoTrm2dqA/IaPxmL9f3hnne
 XdVbR3VyZwh6ALKAboTyB4vf6r6Av1PI9MACp/baJDQ0U5lWuFZC3hdB0roaiLixg9OE
 nVAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR8Hi3y15LwhfzMA7Di4GMWWfarvlatkfhtjtrSc/9DQtdzBq/OJYWiG6la8Ksbdw2Z523mO8t28NO@nongnu.org
X-Gm-Message-State: AOJu0Yy2BrYewzhT8SZCkt6uExzwcURmqNAjd6gaL/ApkblXaaUZd0lt
 pn0zyjoO+PkYHL1lpVP08QMQfdVUCswjLMmX6IRj1RyYsFkAX06S210PUsSayTTtQLw=
X-Gm-Gg: AZuq6aJpoI3FgEkmyoMUFoZNDqHWAVvXP3vz3w7GeRWdKv113fBICT70qBRXUY6QB9a
 qV7t34pYtqNK06jpkRz8LenOUhkNBwBhmqFdMwpopfcpvxBETnKrOUXxljcJj6cHYHf2mPKUePG
 4HQgXJ+NVgwXcRL59iRvS4Hn7sJcBv1RtuCXFN982In/uYS3bKNRHLGHvmSHHCI/U59ebGswQVx
 8fj/NwGOKwHu8/zlLaBFoPCX9u6VIMzClxLVAB1yft2hhzye8PxD8kmqO3u8t+OGuaUFzz00au2
 nkJ65033sy7+w4uKfXombuHWZ28XB5ePYTgVFx/Ive16E+Z0/+E70WVJQAhgKqET14FdTMh2kcp
 ScsHy/IS+FtHxWpHaiY33iEQ8h07NQdyGDaMYyp0I1s4r4XONI90RZvmk0MdWg3RlZJJGpnQrDc
 8W0K/3JCD3RF88hJ4r6zEXHG3AnxzMDLvqrIcl6sIi+mY3XG8h0sIQKf5bHpNJpiBTR+OmrMCKg
 sb9yCLYXXekCQ==
X-Received: by 2002:a17:90b:4fc7:b0:34a:b4a2:f0bf with SMTP id
 98e67ed59e1d1-356679cc21emr3841292a91.16.1770769881480; 
 Tue, 10 Feb 2026 16:31:21 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:f8f8:2c3b:9605:55a0?
 ([2001:8003:e109:dd00:f8f8:2c3b:9605:55a0])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8249e3bc92dsm180905b3a.19.2026.02.10.16.31.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 16:31:21 -0800 (PST)
Message-ID: <7014cfc3-f6fe-4ac1-bf69-cc8de46146a2@linaro.org>
Date: Wed, 11 Feb 2026 10:31:14 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] target/i386: Drop physical address range checks
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 palmer@dabbelt.com, alistair.francis@wdc.com, pbonzini@redhat.com,
 gaosong@loongson.cn, maobibo@loongson.cn, deller@gmx.de
References: <20260210-phys_addr-v4-0-725a589e83c8@rev.ng>
 <20260210-phys_addr-v4-4-725a589e83c8@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260210-phys_addr-v4-4-725a589e83c8@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 2/10/26 21:33, Anton Johansson wrote:
> Since TARGET_PHYS_ADDR_SPACE_BITS is now fixed to 64 bits for all
> targets we can remove range checks on cpu->phys_bits and
> TCG_PHYS_ADDR_BITS.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/i386/tcg/helper-tcg.h | 2 --
>   target/i386/cpu.c            | 9 +++------
>   target/i386/kvm/kvm.c        | 3 +--
>   3 files changed, 4 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
> index e41cbda407..f4b2ff740d 100644
> --- a/target/i386/tcg/helper-tcg.h
> +++ b/target/i386/tcg/helper-tcg.h
> @@ -31,8 +31,6 @@
>   # define TCG_PHYS_ADDR_BITS 36
>   #endif
>   
> -QEMU_BUILD_BUG_ON(TCG_PHYS_ADDR_BITS > TARGET_PHYS_ADDR_SPACE_BITS);
> -
>   /**
>    * x86_cpu_do_interrupt:
>    * @cpu: vCPU the interrupt is to be handled by.
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 0a7b884528..11755a5a7e 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -9943,12 +9943,9 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>        * accel-specific code in cpu_exec_realizefn.
>        */
>       if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
> -        if (cpu->phys_bits &&
> -            (cpu->phys_bits > TARGET_PHYS_ADDR_SPACE_BITS ||
> -            cpu->phys_bits < 32)) {
> -            error_setg(errp, "phys-bits should be between 32 and %u "
> -                             " (but is %u)",
> -                             TARGET_PHYS_ADDR_SPACE_BITS, cpu->phys_bits);
> +        if (cpu->phys_bits && cpu->phys_bits < 32) {
> +            error_setg(errp, "phys-bits should be at least 32"
> +                             " (but is %u)", cpu->phys_bits);
>               return;
>           }
>           /*
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 0c940d4b64..a48be342fe 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -4765,8 +4765,7 @@ static int kvm_get_msrs(X86CPU *cpu)
>        */
>   
>       if (cpu->fill_mtrr_mask) {
> -        QEMU_BUILD_BUG_ON(TARGET_PHYS_ADDR_SPACE_BITS > 52);
> -        assert(cpu->phys_bits <= TARGET_PHYS_ADDR_SPACE_BITS);
> +        assert(cpu->phys_bits <= 52);
>           mtrr_top_bits = MAKE_64BIT_MASK(cpu->phys_bits, 52 - cpu->phys_bits);
>       } else {
>           mtrr_top_bits = 0;
> 



