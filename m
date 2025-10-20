Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211A5CCD184
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 00:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAdg1-0004wv-Gp; Sun, 19 Oct 2025 20:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vAdfz-0004wn-Ih
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 20:23:03 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vAdfw-0008Lx-Ny
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 20:23:03 -0400
Received: from [172.130.10.190] ([115.90.12.10]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59K0MP9p030037
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 09:22:53 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=3zkTLDd1D34rXR4r8ns0CHeyU0fL8yF7KtP3Llx5CmQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1760919774; v=1;
 b=n1N4vZebfL/B6IwvDH3OonUtnbnGEsTtMBtgkVDOsDefjfOjQpCBBeoTRxw6EVZX
 XjoD+dcvkk8epAomzrayaSha5oCJBIDJcgHu/jvMqEANUtLbWEalz6GnI3hz8cgM
 /k4U8/gtjrDVxEgkO224QU+hcvg26ukeNjvKpQgmOHau9ZynCr4uM/zYTf04u6Ys
 M/SFMbp2DArEjP/wDsdtygQtLQ2MDIy4RtyxMnPFy9lR9xT3POXwPie6aTQcAPHF
 LrZWhybD/SP9p/5PK+1E5LFMz51S1P4MLye1O4/lI4GPtdggz0mcpXbl7PWaKb8U
 Gud5zK7MW9Aw46VRTboKww==
Message-ID: <aafbce70-45a1-45cd-9006-df0871fdb3d9@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 20 Oct 2025 09:22:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Fix a uninitialized variable warning
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
References: <20251019-vlen-v1-1-f7352a402f06@rsg.ci.i.u-tokyo.ac.jp>
 <b3cbe49d-e863-456d-a254-b7514e3bb33a@ventanamicro.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <b3cbe49d-e863-456d-a254-b7514e3bb33a@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/10/19 19:01, Daniel Henrique Barboza wrote:
> 
> 
> On 10/19/25 5:19 AM, Akihiko Odaki wrote:
>> riscv_cpu_validate_v() left its variable, min_vlen, uninitialized if
>> no vector extension is available, causing a compiler warning. Avoid
>> the warning by calling g_assert_not_reached() in the case.
> 
> For the compiler point of view the variable will be left uninitialized.
> In reality we'll always set it to at least '32' in validate_v(). This
> is how the function is being called:
> 
>      if (cpu->cfg.ext_zve32x) {
>          riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
>          if (local_err != NULL) {
>              error_propagate(errp, local_err);
>              return;
>          }
>      }
> 
> This means that inside the function we guarantee that min_vlen will be
> at least set to 32 because cfg->ext_zve32x will always be true:
> 
>      if (riscv_has_ext(env, RVV)) {
>          min_vlen = 128;
>      } else if (cfg->ext_zve64x) {
>          min_vlen = 64;
>      } else if (cfg->ext_zve32x) {
>          min_vlen = 32;
>      }
> 
> 
> To make the compiler happy and the code a bit clearer I suggest 
> initializing
> min_vlen = 32 and folding the "if (cpu->cfg.ext_zve32x)" check inside
> validate_v() for an early exit. Something like this:
> 
> 
> @@ -417,15 +417,19 @@ static void 
> riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
>   static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
>                                    Error **errp)
>   {
> -    uint32_t min_vlen;
> -    uint32_t vlen = cfg->vlenb << 3;
> +    uint32_t min_vlen, vlen;
> +
> +    if (cfg->ext_zve32x) {
> +        return;
> +    }
> +
> +    min_vlen = 32;
> +    vlen = cfg->vlenb << 3;
> 
>       if (riscv_has_ext(env, RVV)) {
>           min_vlen = 128;
>       } else if (cfg->ext_zve64x) {
>           min_vlen = 64;
> -    } else if (cfg->ext_zve32x) {
> -        min_vlen = 32;
>       }

What about:

     if (riscv_has_ext(env, RVV)) {
         min_vlen = 128;
     } else if (cfg->ext_zve64x) {
         min_vlen = 64;
     } else if (cfg->ext_zve32x) {
         min_vlen = 32;
     } else {
         return;
     }

Always initializing min_vlen with 32 looks a bit misleading to me. 
min_vlen is inherently dependent on the RVV and zve* flags; initializing 
the value after checking the flags show that more clearly.

And I find separating the cfg->ext_zve64x and cfg->ext_zve32x checks a 
bit awkward as they are semantically not that different. In terms of 
semantics, I see the code like as follows:

if (RVV) {
   initialize the extension parameters for RVV
} else if (zve64x) {
   initialize the extension parameters for zve64x
} else if (zve32x) {
   initialize the extension parameters for zve32x
} else {
   no vector extension is present so skip validation
}

> 
>       if (vlen > RV_VLEN_MAX || vlen < min_vlen) {
> @@ -676,12 +680,10 @@ void riscv_cpu_validate_set_extensions(RISCVCPU 
> *cpu, Error **errp)
>           return;
>       }
> 
> -    if (cpu->cfg.ext_zve32x) {
> -        riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
> -        if (local_err != NULL) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> +    riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
> +    if (local_err != NULL) {
> +        error_propagate(errp, local_err);
> +        return;

Removing this duplicate cpu->cfg.ext_zve32x looks good.

>       }
> 
> 
> Note: I wonder why we're allowing settings of VLEN and so on when we do
> not have RVV set. Seems like a bug ...

I think this is because the ordering of property setting is not 
deterministic. It is possible to set the vlen property before setting 
the v, zve64x or zve32x properties.

Regards,
Akihiko Odaki

