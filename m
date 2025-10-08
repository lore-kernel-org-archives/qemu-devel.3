Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17597CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 17:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Y1G-0005KO-M2; Wed, 08 Oct 2025 13:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v6Y1E-0005Jp-Rk
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 13:32:04 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v6Y17-0003P3-Oe
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 13:32:03 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-33082c95fd0so210132a91.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 10:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759944714; x=1760549514; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n7fDejhZRn9peu/vRsHY6l007K8d/1IskghDPuSVtmg=;
 b=FyHc1g8MOrJXjahLGDka37VhAx1cFPFYJWt/8p6TAY6EbWwDwE5h7qWbErHcpTKTz4
 /Tmam8jORDvIPtAGunN4tvKpPPWQZMM8Eko2e5Q5QMFN4crN8MXnrSEb2tnmLlfCJWzM
 H3YZbZG+90C7O1+0E17I4Ijdr6GL7XAuKVOYJi4eSfUQRzUfyOOdKDXUfCYfHeatzUjI
 AxKDTtfmhRXVHFNjztv5XKo8HwUo0dqJw1KORvMaTRE47ThfSWXCdnjOG19Ak+zybpE6
 p4+QylDbRLIi6xFPL3ZEa/ooWV6B8tnhBPTkzQoaVnwTKofmYwG57OuJTpTC4Gw0K5pv
 0hZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759944714; x=1760549514;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n7fDejhZRn9peu/vRsHY6l007K8d/1IskghDPuSVtmg=;
 b=LAZHxgGaOJMaaKuZyzAvE3C5wCNa1vwKx9NIgMbqdFKhmqZmxjJz9u0K3yq0bzINPQ
 6rkkZiVMNAGqguCHAFvTEw7dE2cqlrp3UrhpsZK6vEg4/pxJ4ozWlEPZfl3Va1/gahdn
 9gCyPFleFXPxmxPAYWFk4qwhhd4o9Z/DPAYIytidno9Va3sEqXXvzSMZiv3QxsVipK6p
 nbb6XK1BkHajCJBiTKjPqHX5j6H1PpE5iKaglh4lNzlYtTEQleG9kAZ3UyrBd7gZipXC
 d4QHV7H7kKu1Z9JtcDDgJSCSiPQprDzpjAo6j9g4jPqEaMIUumDtHs2vb366u1a0g19l
 /15Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoOCfArZFV8d984fSz2vmyCU79fSYGQeY8+FKtaC0Wr2ABs5NWEYdiCCowijAF7xTRnlTwQ9QNmySk@nongnu.org
X-Gm-Message-State: AOJu0YxMuVUafG9OGwWjAqd9nWQua/97Nq3vJTQy6GZwv5cnK9JIjCD0
 0B2MrcXZwOLaHKDkWCVYoRk0V4mxec9/CP7s1VxEbkT16d7moLqEqOyyuWFHtJ+jN1ezUPAVvgN
 u4YUfmw0=
X-Gm-Gg: ASbGncvO7jpxJRL8WdJzKBTvgS+enDZOBVDTnuInVqGgaWYC+sDdWAC8QNuj300E6Mp
 N4WSJoN1dZxbNE00/zs4ybTdaPWu4RZRESPfzsQYUbxxVsFPh+HvlMWDOjC+5ZU0uJJvdkcuNaZ
 Hx4T7l1wZwO9HyipkLSZScq3EisnEni5x2vQ7+DIcMouLuompqNL8KPCjeHum2llJYltKrx8x31
 CsNOxajt1DUtdqXCDOKOx+BxX/6RuUdiw1/76iDe47vkudcxPAMrlNSsn3EBfs7l0QwBGiY54Ml
 CNiBDRDuNH0zBY858PEJr2rbIyigNTH6RC+4LjiIIG5i5ItrXcMO25JvpFB/hBn57X8Euo567tl
 kdU4Cv9R2Hwl6I3+fJ7jHBbBNGYbJNVCH/VledTBFDsQ88IaW5kZYxuqkq2hK+ps=
X-Google-Smtp-Source: AGHT+IGuNaUvm14wVMmdX1bGwpwN6fxjUZHiRJYoSyU+AjB+ZcBYd6CuMznMzH/pvZWFFQ6bh1pDFQ==
X-Received: by 2002:a17:902:e787:b0:273:3f62:6eca with SMTP id
 d9443c01a7336-29027379a0emr51945505ad.18.1759944713756; 
 Wed, 08 Oct 2025 10:31:53 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f95ecbsm2736315ad.130.2025.10.08.10.31.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 10:31:53 -0700 (PDT)
Message-ID: <56fd5fe0-7f5a-4331-a1b0-618e08bdd511@linaro.org>
Date: Wed, 8 Oct 2025 10:31:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] target/microblaze: Convert CPUMBState::res_addr field
 to uint32_t type
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20251008060129.87579-1-philmd@linaro.org>
 <20251008060129.87579-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251008060129.87579-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/7/25 11:01 PM, Philippe Mathieu-Daudé wrote:
> CPUMBState::@res_addr field is used as u32 since commit
> cfeea807e5a ("target-microblaze: Tighten up TCGv_i32 vs
> TCGv type usage"). Convert it as such, bumping the migration
> version. Use the RES_ADDR_NONE definition when appropriate.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/microblaze/cpu.h       |  2 +-
>   target/microblaze/machine.c   |  6 +++---
>   target/microblaze/translate.c | 17 +++++++++--------
>   3 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 3ce28b302fe..14b107876a4 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -259,7 +259,7 @@ struct CPUArchState {
>   
>       /* lwx/swx reserved address */
>   #define RES_ADDR_NONE 0xffffffff /* Use 0xffffffff to indicate no reservation */
> -    target_ulong res_addr;
> +    uint32_t res_addr;
>       uint32_t res_val;
>   
>       /* Internal flags.  */
> diff --git a/target/microblaze/machine.c b/target/microblaze/machine.c
> index a4cf38dc891..48efa546d39 100644
> --- a/target/microblaze/machine.c
> +++ b/target/microblaze/machine.c
> @@ -78,7 +78,7 @@ static const VMStateField vmstate_env_fields[] = {
>       VMSTATE_UINT32(iflags, CPUMBState),
>   
>       VMSTATE_UINT32(res_val, CPUMBState),
> -    VMSTATE_UINTTL(res_addr, CPUMBState),
> +    VMSTATE_UINT32(res_addr, CPUMBState),
>   
>       VMSTATE_STRUCT(mmu, CPUMBState, 0, vmstate_mmu, MicroBlazeMMU),
>   
> @@ -87,8 +87,8 @@ static const VMStateField vmstate_env_fields[] = {
>   
>   static const VMStateDescription vmstate_env = {
>       .name = "env",
> -    .version_id = 0,
> -    .minimum_version_id = 0,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
>       .fields = vmstate_env_fields,
>   };
>   
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index ff33e64a710..04fbd4fe17f 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -55,7 +55,7 @@ static TCGv_i32 cpu_imm;
>   static TCGv_i32 cpu_bvalue;
>   static TCGv_i32 cpu_btarget;
>   static TCGv_i32 cpu_iflags;
> -static TCGv cpu_res_addr;
> +static TCGv_i32 cpu_res_addr;
>   static TCGv_i32 cpu_res_val;
>   
>   /* This is the state at translation time.  */
> @@ -857,7 +857,7 @@ static bool trans_lwx(DisasContext *dc, arg_typea *arg)
>   
>       tcg_gen_qemu_ld_i32(cpu_res_val, addr, dc->mem_index,
>                           mo_endian(dc) | MO_UL);
> -    tcg_gen_mov_tl(cpu_res_addr, addr);
> +    tcg_gen_mov_i32(cpu_res_addr, addr);
>   
>       if (arg->rd) {
>           tcg_gen_mov_i32(cpu_R[arg->rd], cpu_res_val);
> @@ -1024,7 +1024,7 @@ static bool trans_swx(DisasContext *dc, arg_typea *arg)
>        * branch, but we know we can use the equal version in the global.
>        * In either case, addr is no longer needed.
>        */
> -    tcg_gen_brcond_tl(TCG_COND_NE, cpu_res_addr, addr, swx_fail);
> +    tcg_gen_brcond_i32(TCG_COND_NE, cpu_res_addr, addr, swx_fail);
>   
>       /*
>        * Compare the value loaded during lwx with current contents of
> @@ -1052,7 +1052,7 @@ static bool trans_swx(DisasContext *dc, arg_typea *arg)
>        * Prevent the saved address from working again without another ldx.
>        * Akin to the pseudocode setting reservation = 0.
>        */
> -    tcg_gen_movi_tl(cpu_res_addr, -1);
> +    tcg_gen_movi_i32(cpu_res_addr, RES_ADDR_NONE);
>       return true;
>   }
>   
> @@ -1173,7 +1173,7 @@ static bool trans_brk(DisasContext *dc, arg_typea_br *arg)
>           tcg_gen_movi_i32(cpu_R[arg->rd], dc->base.pc_next);
>       }
>       tcg_gen_ori_i32(cpu_msr, cpu_msr, MSR_BIP);
> -    tcg_gen_movi_tl(cpu_res_addr, -1);
> +    tcg_gen_movi_i32(cpu_res_addr, RES_ADDR_NONE);
>   
>       dc->base.is_jmp = DISAS_EXIT;
>       return true;
> @@ -1194,7 +1194,7 @@ static bool trans_brki(DisasContext *dc, arg_typeb_br *arg)
>       if (arg->rd) {
>           tcg_gen_movi_i32(cpu_R[arg->rd], dc->base.pc_next);
>       }
> -    tcg_gen_movi_tl(cpu_res_addr, -1);
> +    tcg_gen_movi_i32(cpu_res_addr, RES_ADDR_NONE);
>   
>   #ifdef CONFIG_USER_ONLY
>       switch (imm) {
> @@ -1885,6 +1885,7 @@ void mb_tcg_init(void)
>             tcg_global_mem_new_i32(tcg_env, i32s[i].ofs, i32s[i].name);
>       }
>   
> -    cpu_res_addr =
> -        tcg_global_mem_new(tcg_env, offsetof(CPUMBState, res_addr), "res_addr");
> +    cpu_res_addr = tcg_global_mem_new_i32(tcg_env,
> +                                          offsetof(CPUMBState, res_addr),
> +                                          "res_addr");
>   }

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


