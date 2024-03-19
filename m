Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C3ACD11DE
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 16:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbtg-0003cf-Ai; Tue, 19 Mar 2024 12:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rmbtC-0003So-3x
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:00:37 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rmbt9-0000Gs-Qt
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eZbkJl76ttvDVT4IQzLgunNdGjaFlHxcpolC53RCtuw=; b=wJKLnJoX1mm4cbXBSiAIc2XRv8
 txQrKuwhtmZzBMo/G5Nzwkqs4T0XJgrPLRbmlxAiKc4i/8ABQUbwLRFoqtVSmW1xmm84576EoFnAE
 OjwcgZrMru+g3neGpL9Sj0XRZqIoV6/VDddnhpU6SIR/Z46ZkOSLHHhRWPRwzo50ybNc=;
Date: Tue, 19 Mar 2024 17:01:21 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Laurent Vivier <laurent@vivier.eu>, Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH-for-9.1 5/8] target/microblaze: Restrict 64-bit
 'res_addr' to system emulation
Message-ID: <4cd57p52xrpxz3hbiyvsfoinauycwv5cy3oqonx4grhh4ctneo@ow3cso7fehcq>
References: <20240319062855.8025-1-philmd@linaro.org>
 <20240319062855.8025-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240319062855.8025-6-philmd@linaro.org>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 19/03/24, Philippe Mathieu-Daudé wrote:
> 'res_addr' is only used in system emulation, where we have
> TARGET_LONG_BITS = 64, so we can directly use the native
> uint64_t type instead of target_ulong.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/microblaze/cpu.h       | 10 +++++-----
>  target/microblaze/cpu.c       |  2 ++
>  target/microblaze/machine.c   |  2 +-
>  target/microblaze/translate.c |  9 +++++++--
>  4 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index c0c7574dbd..c3e2aba0ec 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -260,11 +260,6 @@ struct CPUArchState {
>      /* Stack protectors. Yes, it's a hw feature.  */
>      uint32_t slr, shr;
>  
> -    /* lwx/swx reserved address */
> -#define RES_ADDR_NONE 0xffffffff /* Use 0xffffffff to indicate no reservation */
> -    target_ulong res_addr;
> -    uint32_t res_val;
> -
>      /* Internal flags.  */
>  #define IMM_FLAG        (1 << 0)
>  #define BIMM_FLAG       (1 << 1)
> @@ -286,6 +281,11 @@ struct CPUArchState {
>      uint32_t iflags;
>  
>  #if !defined(CONFIG_USER_ONLY)
> +    /* lwx/swx reserved address */
> +#define RES_ADDR_NONE 0xffffffff /* Use 0xffffffff to indicate no reservation */
> +    uint64_t res_addr;
> +    uint32_t res_val;
> +
>      /* Unified MMU.  */
>      MicroBlazeMMU mmu;
>  #endif
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 96c2b71f7f..9e393cf217 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -193,7 +193,9 @@ static void mb_cpu_reset_hold(Object *obj)
>      }
>  
>      memset(env, 0, offsetof(CPUMBState, end_reset_fields));
> +#ifndef CONFIG_USER_ONLY
>      env->res_addr = RES_ADDR_NONE;
> +#endif
>  
>      /* Disable stack protector.  */
>      env->shr = ~0;
> diff --git a/target/microblaze/machine.c b/target/microblaze/machine.c
> index 51705e4f5c..4daf8a2471 100644
> --- a/target/microblaze/machine.c
> +++ b/target/microblaze/machine.c
> @@ -78,7 +78,7 @@ static const VMStateField vmstate_env_fields[] = {
>      VMSTATE_UINT32(iflags, CPUMBState),
>  
>      VMSTATE_UINT32(res_val, CPUMBState),
> -    VMSTATE_UINTTL(res_addr, CPUMBState),
> +    VMSTATE_UINT64(res_addr, CPUMBState),
>  
>      VMSTATE_STRUCT(mmu, CPUMBState, 0, vmstate_mmu, MicroBlazeMMU),
>  
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index d6a42381bb..493850c544 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1872,7 +1872,9 @@ void mb_tcg_init(void)
>          SP(iflags),
>          SP(bvalue),
>          SP(btarget),
> +#if !defined(CONFIG_USER_ONLY)
>          SP(res_val),
> +#endif
>      };
>  
>  #undef R
> @@ -1883,6 +1885,9 @@ void mb_tcg_init(void)
>            tcg_global_mem_new_i32(tcg_env, i32s[i].ofs, i32s[i].name);
>      }
>  
> -    cpu_res_addr =
> -        tcg_global_mem_new(tcg_env, offsetof(CPUMBState, res_addr), "res_addr");
> +#if !defined(CONFIG_USER_ONLY)
> +    cpu_res_addr = tcg_global_mem_new_i64(tcg_env,
> +                                          offsetof(CPUMBState, res_addr),
> +                                          "res_addr");
> +#endif
>  }
> -- 
> 2.41.0
> 
Reviewed-by: Anton Johansson <anjo@rev.ng>

