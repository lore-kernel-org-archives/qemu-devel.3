Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FC3C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 12:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0LAB-0000Mx-6g; Fri, 26 Apr 2024 08:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s0LA4-0000KG-Oi
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 08:58:45 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s0L9z-0005CJ-VX
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 08:58:43 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5f80aa2d4a3so1760400a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 05:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1714136318; x=1714741118; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SQtRaGg1Gm5+PAPWDnHNpYoDL9My/Y3Yh2R8U3TeLXQ=;
 b=a06dtrs0ZNpD+MQeQE5VaIlpjjIAKNnnLo3FI2Xypc5DJph+lD9ZGsikpo9xrbQGnH
 zXJBvBz0JaK5IA8KQopbK0xZqw8FFbo9cC5LpQ50klVvOoAft+ZmeBRenvovo5jgfMFY
 JSRqpJMDELsFuEVT9R6pVY2g2PA4uuBbyjOOaicC15/E2o+Rkw8Micl4vyFXVM2Bh4w7
 4W5jdGl3uJ5zY4DMnzL9sNpCyLcod3n1ccGz00XKvkVCEPJRUPX+sJEHU5tstcWVpXGC
 JxrBsugkXK4PiGcg/qHqnUqfqXD6ChceHIH9iZ3+R53PJcFMFRQtjB5kvpe5xtFCqePM
 BJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714136318; x=1714741118;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SQtRaGg1Gm5+PAPWDnHNpYoDL9My/Y3Yh2R8U3TeLXQ=;
 b=bEXsAcEeCrQSQMPugPpdOdCBVzLiMLuet46u/J/GvTiNi31hJ2Be9FW8dx934OAq3H
 r7pmeJJt4Mxdcr7uAUwAKzGdNbFG/SbPCmZraaCrcgzcxbER8Ni+Vvuo7K8KrR9fF4Lp
 qfO7hk7lg3WiMkqiqdJoKL9cjjbbVTFHqESdeV2kLBBF/4o9xgRkjDRWoxR01Y9w4aNh
 AyIuR7Q96BqGJeTBhyf5ESNxvBCUIpbu3hbJ5fqQedeLpXlHh3UIp4E8Bse/VBznnlwh
 s3GpwMrVrZh3nKcmd4r0g30j6+0+ioutnOtDHXetvN4FoCnOoaBeLp5iIrgE18HuXk6Y
 OdwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv5bvgUiOsEzuFv5eGGfJrXA+eWNMzQRyr5odD8Fz2/tSGrrLhwn7OPwS77xsCs6tqBvXtLBuWGSNWik4WIu5+HGi0CaY=
X-Gm-Message-State: AOJu0YxQMrlDl5EX5ZgXGFBCay1oJgWkH972UXwgmCLCI1ajQjc5YjdF
 bPdscGLaQrk73kk4+JH0KEpg8PUL2p+V6DvfN4IsFek3RxdJ95eX0/QI7jcA20A=
X-Google-Smtp-Source: AGHT+IFI2KMEGBea5/dF+ummNu/AHBa1eObGmObmZu0y6ZJl5DDo2MITS7eCmKjiiYcGHewEyF0RXw==
X-Received: by 2002:a17:90b:4387:b0:2af:e1f8:11a4 with SMTP id
 in7-20020a17090b438700b002afe1f811a4mr2367535pjb.19.1714136317830; 
 Fri, 26 Apr 2024 05:58:37 -0700 (PDT)
Received: from [192.168.68.110] ([191.202.238.92])
 by smtp.gmail.com with ESMTPSA id
 iq2-20020a17090afb4200b002a9f707ec45sm16221923pjb.11.2024.04.26.05.58.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 05:58:37 -0700 (PDT)
Message-ID: <c6be34c4-680e-4940-80a9-ecf4719335d3@ventanamicro.com>
Date: Fri, 26 Apr 2024 09:58:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/riscv: Raise exceptions on wrs.nto
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: christoph.muellner@vrull.eu, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
References: <20240424142808.62936-2-ajones@ventanamicro.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240424142808.62936-2-ajones@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x531.google.com
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



On 4/24/24 11:28, Andrew Jones wrote:
> Implementing wrs.nto to always just return is consistent with the
> specification, as the instruction is permitted to terminate the
> stall for any reason, but it's not useful for virtualization, where
> we'd like the guest to trap to the hypervisor in order to allow
> scheduling of the lock holding VCPU. Change to always immediately
> raise exceptions when the appropriate conditions are present,
> otherwise continue to just return. Note, immediately raising
> exceptions is also consistent with the specification since the
> time limit that should expire prior to the exception is
> implementation-specific.
> 
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Christoph Müllner <christoph.muellner@vrull.eu>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

> v3:
>   - Sending again, hoping the ü remains in Müllner
> v2:
>   - Added #ifndef CONFIG_USER_ONLY around helper call
> 
>   target/riscv/helper.h                       |  1 +
>   target/riscv/insn_trans/trans_rvzawrs.c.inc | 29 ++++++++++++++-------
>   target/riscv/op_helper.c                    | 11 ++++++++
>   3 files changed, 32 insertions(+), 9 deletions(-)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 8a635238514d..451261ce5a4f 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -132,6 +132,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
>   DEF_HELPER_1(sret, tl, env)
>   DEF_HELPER_1(mret, tl, env)
>   DEF_HELPER_1(wfi, void, env)
> +DEF_HELPER_1(wrs_nto, void, env)
>   DEF_HELPER_1(tlb_flush, void, env)
>   DEF_HELPER_1(tlb_flush_all, void, env)
>   /* Native Debug */
> diff --git a/target/riscv/insn_trans/trans_rvzawrs.c.inc b/target/riscv/insn_trans/trans_rvzawrs.c.inc
> index 32efbff4d5a5..0eef03383889 100644
> --- a/target/riscv/insn_trans/trans_rvzawrs.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzawrs.c.inc
> @@ -16,7 +16,7 @@
>    * this program.  If not, see <http://www.gnu.org/licenses/>.
>    */
>   
> -static bool trans_wrs(DisasContext *ctx)
> +static bool trans_wrs_sto(DisasContext *ctx, arg_wrs_sto *a)
>   {
>       if (!ctx->cfg_ptr->ext_zawrs) {
>           return false;
> @@ -40,12 +40,23 @@ static bool trans_wrs(DisasContext *ctx)
>       return true;
>   }
>   
> -#define GEN_TRANS_WRS(insn)                                     \
> -static bool trans_ ## insn(DisasContext *ctx, arg_ ## insn *a)  \
> -{                                                               \
> -    (void)a;                                                    \
> -    return trans_wrs(ctx);                                      \
> -}
> +static bool trans_wrs_nto(DisasContext *ctx, arg_wrs_nto *a)
> +{
> +    if (!ctx->cfg_ptr->ext_zawrs) {
> +        return false;
> +    }
>   
> -GEN_TRANS_WRS(wrs_nto)
> -GEN_TRANS_WRS(wrs_sto)
> +    /*
> +     * Depending on the mode of execution, mstatus.TW and hstatus.VTW, wrs.nto
> +     * should raise an exception when the implementation-specific bounded time
> +     * limit has expired. Our time limit is zero, so we either return
> +     * immediately, as does our implementation of wrs.sto, or raise an
> +     * exception, as handled by the wrs.nto helper.
> +     */
> +#ifndef CONFIG_USER_ONLY
> +    gen_helper_wrs_nto(tcg_env);
> +#endif
> +
> +    /* We only get here when helper_wrs_nto() doesn't raise an exception. */
> +    return trans_wrs_sto(ctx, NULL);
> +}
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index f414aaebdbab..2baf5bc3ca19 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -380,6 +380,17 @@ void helper_wfi(CPURISCVState *env)
>       }
>   }
>   
> +void helper_wrs_nto(CPURISCVState *env)
> +{
> +    if (env->virt_enabled && (env->priv == PRV_S || env->priv == PRV_U) &&
> +        get_field(env->hstatus, HSTATUS_VTW) &&
> +        !get_field(env->mstatus, MSTATUS_TW)) {
> +        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
> +    } else if (env->priv != PRV_M && get_field(env->mstatus, MSTATUS_TW)) {
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +    }
> +}
> +
>   void helper_tlb_flush(CPURISCVState *env)
>   {
>       CPUState *cs = env_cpu(env);

