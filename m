Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54717FF5134
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABTk-0004ie-Mz; Tue, 07 Apr 2026 14:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wABS4-0002em-U9
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:47:04 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wA9DD-0000Vm-4c
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 12:23:36 -0400
Received: by mail-qk1-x744.google.com with SMTP id
 af79cd13be357-8d424af6282so501909285a.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 09:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775579012; x=1776183812; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IZHSAVKdJyuJt/gQRuSxcAt6hhuT+ixUxltGt6A/2FE=;
 b=RYFo+iD98I+IHWu0agbbD2U6HS6vaA01zzRsJlnjrkV5chjBU5uubT3nT9Rx8560kr
 M3CJFGWMMnEMeYU546w0a+o6GsUEb+Opyy2Zp1qiBrArNgRhjUmpf43hphJ/8A9k1cLg
 LBMhaiM32Oi7CWkbQic9jNfaMTL5DASurSGcmJv1O4T5dZXqh62FGcxAL99hNDzo6/Yk
 /Vcrv2Pa1bwHJXxeV+ZBlFdQlYdtRfI3EDRRncHoGjZgEJDyzHxAm+e1DyBwGyy9WJYN
 wZeesLah1iw6FaegMoUZ2Y1VVzMIagn+4S3MokzvukwhQ561CIIxBSBNRbERHhaLHTg5
 cNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775579012; x=1776183812;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IZHSAVKdJyuJt/gQRuSxcAt6hhuT+ixUxltGt6A/2FE=;
 b=WlHknSfKfWzS6nyeZ5DB6J45z7ayN77VBQEgQidG5ZJGpDoPDkMuaol6Zta+f8V/ze
 3L4dFXsMgAOuJuSSMOAGRrsZmvYEJJk9Lq/vsJy7jNXyietQlSb7DoH6CG71UwL9iEKW
 pBAe9qkuj/NDrA9S2SwfuSjfMStjb07eoxJeGQUplJ9REfv1tlA6SZhHBzjgqOxn2kPp
 oM2vsAMdkJ3yz5GSFh880ZbZuagZLN9azOTFamT/E/pYlakhP9vTM0s7vccpjzJT9rVr
 JJvCTimNrCDvbdeuaOV6K5XY931AbVlVJez3/d6Ptgv2A9hXpCf8AJfvswfwD1ZHAdFR
 V5gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXqplM7McIG8qqGjVgTJm225F4sz4Jsoz7Hq2XtajWxq5KTG6uxX53bRW96orj811rVy8iqE3toZ81@nongnu.org
X-Gm-Message-State: AOJu0Yyoxlvl991AGyYMFZdceDkfJXqYusjcAs86BaPOAnuSE0ZOmO8G
 xQ9coUgNCInzxTG14XZZolBnkhoRLt2AJp6DfjzTEIOc5NBznRrsCksc
X-Gm-Gg: AeBDievSNR14li+dRV4zVoXemLBH4ddHKVJPO9Qrj7EwSweUB4qzzWndD9kcDzLBf0G
 O8PzL3OILqDzsss8E9e1moQZjkDzZPDlFU7yFxH9KBv0F0bzYHsZ7exSG38OhatW55+IRttKQh5
 gOrtkPwB0cO4H4WQYipgE20MkmtP3mRwGyO+jPElpsnnZ41nJ22jRzKxosSRyBGC3hlg4+5SSnE
 lk3bRgUrcy5AiEbmFzr8chTQhhA2bQD6wYVZI+63Xefu+vshjVCyviiw2Aptr62fHLDCpm7fQk1
 cVANvMVWN/zyBZzFYAJOm8LIYo0U/1u1OwDaeihttwEyXqJrjg9JGNxXHEksAsnzoWShl4u1gm5
 plIQqGEw9y9y05RkOmYi/dEnsL5P6T9ieUaYULUPT9SXGm96Jmjileyv47z5kM2Hwi4kscuqLtO
 MmOBa60ywtvPyNqT27SvJjBpkykp3dMvD5yER4n8WhlWkxr/VoBp5poDlmf8HGUqbRrtAswm61
X-Received: by 2002:a05:620a:444f:b0:8d6:7dc4:6906 with SMTP id
 af79cd13be357-8d67dc46e3bmr1560983785a.33.1775579011257; 
 Tue, 07 Apr 2026 09:23:31 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a8c2a453sm1370549385a.47.2026.04.07.09.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 09:23:30 -0700 (PDT)
Date: Wed, 8 Apr 2026 00:23:10 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: alistair23@gmail.com
Cc: palmer@dabbelt.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 1/5] target/riscv: Generate access fault if sc comparison
 fails
Message-ID: <adUvBNdDiVYh1gpo@ZEVORN-PC.localdomain>
References: <20260407043614.372871-1-alistair.francis@wdc.com>
 <20260407043614.372871-2-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407043614.372871-2-alistair.francis@wdc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::744;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qk1-x744.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Apr 07, 2026 at 02:36:10PM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> The RISC-V spec states:
> 
> "For the purposes of memory protection, a failed SC.W may be treated
> like a store."
> 
> So if the comparison in sc.w fails we should still check for alignment
> and do a probe access to check permissions.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3323
> Resoves: https://gitlab.com/qemu-project/qemu/-/work_items/3136
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/helper.h                   |  3 +++
>  target/riscv/op_helper.c                | 14 ++++++++++++++
>  target/riscv/insn_trans/trans_rva.c.inc |  6 ++++++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index b785456ee0..af6cfcfc27 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1289,3 +1289,6 @@ DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
>  #ifndef CONFIG_USER_ONLY
>  DEF_HELPER_1(ssamoswap_disabled, void, env)
>  #endif
> +
> +/* Zalrsc" SC write probe */
stray `"` after Zalrsc.

other LGTM :)

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> +DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 6ccc127c30..b569366369 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -281,6 +281,20 @@ void helper_cbo_inval(CPURISCVState *env, target_ulong address)
>      /* We don't emulate the cache-hierarchy, so we're done. */
>  }
>  
> +void helper_sc_probe_write(CPURISCVState *env, target_ulong addr,
> +                           target_ulong size)
> +{
> +    uintptr_t ra = GETPC();
> +    int mmu_idx = riscv_env_mmu_index(env, false);
> +
> +    if (addr & (size - 1)) {
> +        env->badaddr = addr;
> +        riscv_raise_exception(env, RISCV_EXCP_STORE_AMO_ADDR_MIS, ra);
> +    }
> +
> +    probe_write(env, addr, size, mmu_idx, ra);
> +}
> +
>  #ifndef CONFIG_USER_ONLY
>  
>  target_ulong helper_sret(CPURISCVState *env)
> diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
> index a7a3278d24..62c0fe673d 100644
> --- a/target/riscv/insn_trans/trans_rva.c.inc
> +++ b/target/riscv/insn_trans/trans_rva.c.inc
> @@ -90,6 +90,12 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
>       */
>      TCGBar bar_strl = (ctx->ztso || a->rl) ? TCG_BAR_STRL : 0;
>      tcg_gen_mb(TCG_MO_ALL + a->aq * TCG_BAR_LDAQ + bar_strl);
> +    /*
> +     * "For the purposes of memory protection, a failed SC.W may be treated
> +     * like a store." so let's check the write access permissions
> +     */
> +    gen_helper_sc_probe_write(tcg_env, src1,
> +                              tcg_constant_tl(memop_size(mop)));
>      gen_set_gpr(ctx, a->rd, tcg_constant_tl(1));
>  
>      gen_set_label(l2);
> -- 
> 2.53.0
> 

