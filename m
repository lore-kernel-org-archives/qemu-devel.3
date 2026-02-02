Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E207FE7DF0F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 17:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmy2G-0004hB-C4; Mon, 02 Feb 2026 12:48:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vmy26-0004fR-KD
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:48:18 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vmy24-0007LH-Ds
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:48:18 -0500
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-8c70b5594f4so519039285a.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 09:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1770054495; x=1770659295; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bNfHxqQnoZ0Mq/tEojZ4H15F+BZJ7hz/KqHixXZINMk=;
 b=Lnp92VE1LuboIOu79ywzNMn52F48YLaUG40MMgdbDeLaeVLCeIW4McLASk2fK/oXfk
 syYDdbg0HIj6aRd/yRxzrmdXo2nWlJB8BPxl1PTeCQVmFfZt8v1tbMz/yXUSwLdN3AJ2
 efiDLQZIDdYiRjuuTVovvGTIIFvo8VzfCjAD2XosNxsHoWrTbjQyOrAXfoP2mHgNnU5d
 UE0FuC4EGcV318ZI0b7ndtPUzJz/3sjexabVf1AeAjSq0jnq+StA+IL/MPU/ey+bsy1g
 Wh+HXzbceb4/OKZSMlZ804agZI80ICspJ4MqBtYNCNE2Lv2sPqMIBcj5CxSTE+RmN5gG
 cHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770054495; x=1770659295;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bNfHxqQnoZ0Mq/tEojZ4H15F+BZJ7hz/KqHixXZINMk=;
 b=UYg1Vu4AZzJ1z4XMXg+JATrtIfAF702NHrJIkzlA51fYrQMrkoD8GVQh8lhoNY7127
 Ouqjal7UkXSfujl1HwDyul/OoWt2Os9Cu9H1afe5Wq9ZsVqCDgbcUDMAynX2AeJ+yKmQ
 bfJpK8H1rWxVG+E3jTKXiF7WvDhJTQbsqDiWE1JrSLhAvwGiLYj7vhsKaD0TAMdUqg9R
 CIBtX8jwsKwtp8/97jYa4Hd9SlvQtJWvELSPrT2cybv9mmjXzcFevbKUq/+jrAyvT2pK
 0cHkxdikbI98OUdJVKVzdynj/AoFj9KTMCb3jXulRapPD2G55+TCSkOJKrIotD9xLvqo
 kD8w==
X-Gm-Message-State: AOJu0Yyf4I26W32doigBwYBGrcWcC1gZUo6oQjnPQLXcMMiu+/fnBr3g
 FnP6oWdS/IAGJPY+iI5mZTyJIcAUTykx1xCoYSH1tskIfycfpmBCUlRtIVGA0QbySt4=
X-Gm-Gg: AZuq6aL77LzE/ID1whXkfaso7b1iQxVaR5ymZZp2LZQLlhk6Hi5lAO7Ww8et5DtaigC
 bQUvDkbog5b73CoXgn7B0kehC2PzqjCrTLZsTjK/HK06uI05hOGd7z9T0TGl45rOo7lGx6GGidd
 6HogtrgkLc9zbA/TmSwHOJGDi2IDUMSs9KZ2IAoyvbGHqsuFua+yQTgU7Feg5xMNB0+f1wMjNmg
 AgwTYLMfExruznlsw9E62ZNLaHevIexBNfmV727HHUWNXHwsZRP6uiym+2tNrtc4ob+dR4VqXEb
 ksJg/C4vrqzJ8qHCJNWpK+AOCT18Pq1/jwzkU4mtX7l507Vhl9dup3qbL1tEBS5k7XxoFqT2L8J
 ws0chacYXD/mwsimRXi67SaG76Xt8QdFsuHv/HYB4K1ltvMUuK/4bNw7qTNyx9UxchXncyohS18
 Su9HMo2fW3mtUGEOkkcPnR157MG/TDUJm72fFFZ+exmhtJNj34hIV6XqA0KarYfcs9BmwbwrdLC
 Ew/D0drh/Kf
X-Received: by 2002:a05:620a:4151:b0:8c9:e989:9d8c with SMTP id
 af79cd13be357-8ca2032ed92mr32839285a.3.1770054495370; 
 Mon, 02 Feb 2026 09:48:15 -0800 (PST)
Received: from [192.168.68.103] (200-206-229-25.dsl.telesp.net.br.
 [200.206.229.25]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d36a5f82sm121062896d6.10.2026.02.02.09.48.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 09:48:14 -0800 (PST)
Message-ID: <48b819aa-da6b-43f6-9427-78f721b9ad39@ventanamicro.com>
Date: Mon, 2 Feb 2026 14:48:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 7/7] target/riscv: add sdtrig trigger action=debug
 mode
To: Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, wangjingwei@iscas.ac.cn,
 devel@lists.libvirt.org
References: <cover.1769751489.git.chao.liu.zevorn@gmail.com>
 <8fe531a24703eb426a66618822649bf5ee78697f.1769751489.git.chao.liu.zevorn@gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <8fe531a24703eb426a66618822649bf5ee78697f.1769751489.git.chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x743.google.com
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



On 1/30/2026 3:00 AM, Chao Liu wrote:
> RISC-V Debug Specification:
> https://github.com/riscv/riscv-debug-spec/releases/tag/1.0
> 
> Allow mcontrol/mcontrol6 action=1 when Sdext is enabled. When such a
> trigger hits, enter Debug Mode with cause=trigger and stop with
> EXCP_DEBUG.
> 
> Also report inst-count triggers in tinfo and read their action field.
> 
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> ---
>   target/riscv/debug.c | 53 ++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 5877a60c50..4e30d42905 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -110,6 +110,8 @@ static trigger_action_t get_trigger_action(CPURISCVState *env,
>           action = (tdata1 & TYPE6_ACTION) >> 12;
>           break;
>       case TRIGGER_TYPE_INST_CNT:
> +        action = tdata1 & ITRIGGER_ACTION;
> +        break;
>       case TRIGGER_TYPE_INT:
>       case TRIGGER_TYPE_EXCP:
>       case TRIGGER_TYPE_EXT_SRC:
> @@ -280,6 +282,7 @@ static target_ulong textra_validate(CPURISCVState *env, target_ulong tdata3)
>   
>   static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
>   {
> +    CPUState *cs = env_cpu(env);
>       trigger_action_t action = get_trigger_action(env, trigger_index);
>   
>       switch (action) {
> @@ -289,6 +292,21 @@ static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
>           riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, 0);
>           break;
>       case DBG_ACTION_DBG_MODE:
> +        if (!env_archcpu(env)->cfg.ext_sdext) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "trigger action=debug mode requires Sdext\n");


I believe we want LOG_GUEST_ERROR for invalid actions like this one. You 
can check examples in trigger_priv_match and other places in debug.c

LOG_UNIMP is reserved for cases where QEMU does not implement something 
at all and we want to warn the user about it. For instance, again in 
debug.c:trigger_priv_match():


     case TRIGGER_TYPE_INT:
     case TRIGGER_TYPE_EXCP:
     case TRIGGER_TYPE_EXT_SRC:
         qemu_log_mask(LOG_UNIMP, "trigger type: %d is not supported\n", 
type);
         break;


This is the intended use for LOG_UNIMP.

Everything else LGTM.

Thanks,
Daniel



> +            riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, 0);
> +        }
> +        riscv_cpu_enter_debug_mode(env, env->pc, DCSR_CAUSE_TRIGGER);
> +        /*
> +         * If this came from the Trigger Module's CPU breakpoint/watchpoint,
> +         * we're already returning via EXCP_DEBUG. Otherwise, stop now.
> +         */
> +        if (cs->exception_index != EXCP_DEBUG) {
> +            cs->exception_index = EXCP_DEBUG;
> +            cpu_loop_exit_restore(cs, GETPC());
> +        }
> +        break;
>       case DBG_ACTION_TRACE0:
>       case DBG_ACTION_TRACE1:
>       case DBG_ACTION_TRACE2:
> @@ -441,6 +459,7 @@ static target_ulong type2_mcontrol_validate(CPURISCVState *env,
>   {
>       target_ulong val;
>       uint32_t size;
> +    uint32_t action;
>   
>       /* validate the generic part first */
>       val = tdata1_validate(env, ctrl, TRIGGER_TYPE_AD_MATCH);
> @@ -448,11 +467,25 @@ static target_ulong type2_mcontrol_validate(CPURISCVState *env,
>       /* validate unimplemented (always zero) bits */
>       warn_always_zero_bit(ctrl, TYPE2_MATCH, "match");
>       warn_always_zero_bit(ctrl, TYPE2_CHAIN, "chain");
> -    warn_always_zero_bit(ctrl, TYPE2_ACTION, "action");
>       warn_always_zero_bit(ctrl, TYPE2_TIMING, "timing");
>       warn_always_zero_bit(ctrl, TYPE2_SELECT, "select");
>       warn_always_zero_bit(ctrl, TYPE2_HIT, "hit");
>   
> +    action = (ctrl & TYPE2_ACTION) >> 12;
> +    if (action == DBG_ACTION_BP) {
> +        val |= ctrl & TYPE2_ACTION;
> +    } else if (action == DBG_ACTION_DBG_MODE) {
> +        if (env_archcpu(env)->cfg.ext_sdext) {
> +            val |= ctrl & TYPE2_ACTION;
> +        } else {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "trigger action=debug mode requires Sdext\n");
> +        }
> +    } else {
> +        qemu_log_mask(LOG_UNIMP, "trigger action: %u is not supported\n",
> +                      action);
> +    }
> +
>       /* validate size encoding */
>       size = type2_breakpoint_size(env, ctrl);
>       if (access_size[size] == -1) {
> @@ -569,6 +602,7 @@ static target_ulong type6_mcontrol6_validate(CPURISCVState *env,
>   {
>       target_ulong val;
>       uint32_t size;
> +    uint32_t action;
>   
>       /* validate the generic part first */
>       val = tdata1_validate(env, ctrl, TRIGGER_TYPE_AD_MATCH6);
> @@ -576,11 +610,25 @@ static target_ulong type6_mcontrol6_validate(CPURISCVState *env,
>       /* validate unimplemented (always zero) bits */
>       warn_always_zero_bit(ctrl, TYPE6_MATCH, "match");
>       warn_always_zero_bit(ctrl, TYPE6_CHAIN, "chain");
> -    warn_always_zero_bit(ctrl, TYPE6_ACTION, "action");
>       warn_always_zero_bit(ctrl, TYPE6_TIMING, "timing");
>       warn_always_zero_bit(ctrl, TYPE6_SELECT, "select");
>       warn_always_zero_bit(ctrl, TYPE6_HIT, "hit");
>   
> +    action = (ctrl & TYPE6_ACTION) >> 12;
> +    if (action == DBG_ACTION_BP) {
> +        val |= ctrl & TYPE6_ACTION;
> +    } else if (action == DBG_ACTION_DBG_MODE) {
> +        if (env_archcpu(env)->cfg.ext_sdext) {
> +            val |= ctrl & TYPE6_ACTION;
> +        } else {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "trigger action=debug mode requires Sdext\n");
> +        }
> +    } else {
> +        qemu_log_mask(LOG_UNIMP, "trigger action: %u is not supported\n",
> +                      action);
> +    }
> +
>       /* validate size encoding */
>       size = extract32(ctrl, 16, 4);
>       if (access_size[size] == -1) {
> @@ -919,6 +967,7 @@ target_ulong tinfo_csr_read(CPURISCVState *env)
>   {
>       /* assume all triggers support the same types of triggers */
>       return BIT(TRIGGER_TYPE_AD_MATCH) |
> +           BIT(TRIGGER_TYPE_INST_CNT) |
>              BIT(TRIGGER_TYPE_AD_MATCH6);
>   }
>   


