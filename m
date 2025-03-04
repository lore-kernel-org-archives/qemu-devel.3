Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D484AC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 15:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpUZc-0004ub-Oh; Tue, 04 Mar 2025 10:52:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tpUZY-0004uB-Jg
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 10:52:44 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tpUZW-0003Ik-SB
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 10:52:44 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-439846bc7eeso37513015e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 07:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1741103561; x=1741708361; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ob+55ii8E4Ycc2GkEVlEPolvIyx3KgrxuhKnE7204WA=;
 b=SfS3g3PfmbK/MgNUHRPhTcEddK5gBuEa18CbncHnh1euxPUpUisVOjh1a2B9th6LAv
 B8XF0xNqwWbSBB9A/oPEx9MkphSMccxb4gtDcHqKsDumtFdJ3q3C1ODc4XvRepp7Tkdj
 Q7IiFowHCg1ir+SLt1WM3l90IWD9PxXf/OKq0eI/jQR/NSP1L3iSKGm6xTJanoAqmv2G
 NOkRWwngJxwCtC7joMP3d959MDqQKQ8S6u78obUul4ONUobdPeKQ1AHXtEuzcr8TCQgH
 tsp3aJ9WMIi2tQNJldDv8ITOjKdct1rOdWcj3PADjfmUXMiQfMcytUFFQXRR3aaolej9
 yEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741103561; x=1741708361;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ob+55ii8E4Ycc2GkEVlEPolvIyx3KgrxuhKnE7204WA=;
 b=RxNnkYLR3yluOmgIhR6YOkkVGHUCwaM5mVL7XFkJhTb3SWPh96tCcBBORz+AKVlo9l
 HvYuf5yGJVY0F6B8nj1NmZwJmO5VfyD+MA+E6bxhZQl7V86uSgaKIa/a94zgVwHnqtQf
 v//eR+r2yhMkthgL1EUkIofk+osMFkZeYgaJUCbHQevO2Q6p7Kek8UuyvhOSyqTXFpGb
 qn1/RbNdM66KIn4kc2OiBSGHsHCixNSJuDZ7vIlZqXml7ht8Gqa7j4MIgYgCZBPc/lwo
 4HAbpjpM7jTVIA+PYkoz68As8wvkWjt6mTegc07G6B5QdSQwrXeoAdflPbOjh2tqbfny
 M4PQ==
X-Gm-Message-State: AOJu0YwDTnaMsFFxlTol8PLEx9rBOz594TNunzxt1r6Hlrq26dwrzKLD
 d1Q1Sna+Xjb2fuJJPqldcweiyR3d+atlQV0FYNxfZSsSjihhOWwmnjd3z1azSH92AoDp+SKu/Q0
 G
X-Gm-Gg: ASbGncvGXk6iRyPsA/lqvS8eHtda/VTS8AbTdmQpDaGP+Lp6KSgClHxgZZhbd08EXql
 1QxWZJoB3rq4dSl1syk8LnnAgD5uaRMSskWEfIr1jw19c8Yrr++999NShFyy6HtdW3mBEsq/Ct3
 BcCOL1Sne96sbjvFpISXusxxOVraGn/WmAjEIdQB9AEFJEsPxidFbxNgj0Fd0rCUkaNzS27ETiX
 e3ID3bFpRM2/5DrwRDLxRFe7jbyAjMl2fTCUYD3psWva66zx+EJrakSTz6kSgPk+OGr8Rm3aW6C
 +pAENkpuRhcuuxaT5diA6S4uJZpf48mo
X-Google-Smtp-Source: AGHT+IGjscO4ADJjKnuALrcPAQ0LK/XwIq1iH7QKTDkKX2tPx7j7fB1QbfPoWnzpTvL1WH5s3/780Q==
X-Received: by 2002:a05:600c:4fd0:b0:43b:d12a:40e1 with SMTP id
 5b1f17b1804b1-43bd12a42b8mr835005e9.18.1741103561024; 
 Tue, 04 Mar 2025 07:52:41 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::688c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bbed8b26asm92527595e9.22.2025.03.04.07.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 07:52:40 -0800 (PST)
Date: Tue, 4 Mar 2025 16:52:39 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com, 
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 6/8] target/riscv/kvm: add CSR_SIREG and CSR_STOPEI
 emulation
Message-ID: <20250304-d8cce0e92dc6363ebfecd07a@orel>
References: <20250224082417.31382-1-yongxuan.wang@sifive.com>
 <20250224082417.31382-7-yongxuan.wang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224082417.31382-7-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x334.google.com
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

On Mon, Feb 24, 2025 at 04:24:13PM +0800, Yong-Xuan Wang wrote:
> Support user-space emulation of SIREG and STOPEI CSR with KVM
> acceleration. For SIREG emulation, the SISELECT CSR value and iprio
> array must be loaded before handling, and since the iprio array might
> be modified, it must be written back after the emulation.
> 
> When running with KVM acceleration, the machine lacks M-mode CSRs and
> does not report S-mode support in its environment configuration, even
> though some S-mode CSRs are accessible. This patch adds kvm_enabled()
> checks in relevant predicates to ensure proper handling and validation.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  target/riscv/csr.c         | 12 +++++++++---
>  target/riscv/kvm/kvm-cpu.c | 27 +++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index a2830888d010..594df30c456a 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -27,6 +27,7 @@
>  #include "exec/exec-all.h"
>  #include "exec/tb-flush.h"
>  #include "system/cpu-timers.h"
> +#include "system/kvm.h"
>  #include "qemu/guest-random.h"
>  #include "qapi/error.h"
>  #include <stdbool.h>
> @@ -42,6 +43,11 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops)
>      csr_ops[csrno & (CSR_TABLE_SIZE - 1)] = *ops;
>  }
>  
> +static bool riscv_has_ext_s(CPURISCVState *env)
> +{
> +    return riscv_has_ext(env, RVS) || kvm_enabled();
> +}
> +
>  /* Predicates */
>  #if !defined(CONFIG_USER_ONLY)
>  RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit)
> @@ -52,7 +58,7 @@ RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit)
>          return RISCV_EXCP_NONE;
>      }
>  
> -    if (!(env->mstateen[index] & bit)) {
> +    if (!kvm_enabled() && !(env->mstateen[index] & bit)) {
>          return RISCV_EXCP_ILLEGAL_INST;
>      }
>  
> @@ -66,7 +72,7 @@ RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit)
>          }
>      }
>  
> -    if (env->priv == PRV_U && riscv_has_ext(env, RVS)) {
> +    if (env->priv == PRV_U && riscv_has_ext_s(env)) {
>          if (!(env->sstateen[index] & bit)) {
>              return RISCV_EXCP_ILLEGAL_INST;
>          }
> @@ -326,7 +332,7 @@ static RISCVException csrind_or_aia_any(CPURISCVState *env, int csrno)
>  
>  static RISCVException smode(CPURISCVState *env, int csrno)
>  {
> -    if (riscv_has_ext(env, RVS)) {
> +    if (riscv_has_ext_s(env)) {
>          return RISCV_EXCP_NONE;
>      }

Scattering kvm_enabled() checks around, as is done in the above hunks, is
what I meant in my reply to the previous patch about TCG likely not having
its state maintained well enough to always provide functional CSR
emulation for KVM. Rather than fixing things up as we bump into them with
kvm_enabled() checks we should come up with a way to truly support QEMU
KVM emulation forwarding to TCG.

Thanks,
drew

>  
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index b088b947adae..50b0e7c9ff7d 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1627,6 +1627,31 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
>  }
>  
>  /* User-space CSR emulation */
> +static int kvm_riscv_emu_sireg_ctx_load(CPUState *cs)
> +{
> +    CPURISCVState *env = &RISCV_CPU(cs)->env;
> +
> +    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(siselect), env->siselect);
> +    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio1), env->siprio[0]);
> +    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio1h), env->siprio[8]);
> +    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio2), env->siprio[16]);
> +    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio2h), env->siprio[24]);
> +
> +    return 0;
> +}
> +
> +static int kvm_riscv_emu_sireg_ctx_put(CPUState *cs)
> +{
> +    CPURISCVState *env = &RISCV_CPU(cs)->env;
> +
> +    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio1), env->siprio[0]);
> +    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio1h), env->siprio[8]);
> +    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio2), env->siprio[16]);
> +    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio2h), env->siprio[24]);
> +
> +    return 0;
> +}
> +
>  struct kvm_riscv_emu_csr_data {
>      target_ulong csr_num;
>      int (*context_load)(CPUState *cs);
> @@ -1635,6 +1660,8 @@ struct kvm_riscv_emu_csr_data {
>  
>  struct kvm_riscv_emu_csr_data kvm_riscv_emu_csr_data[] = {
>      { CSR_SEED, NULL, NULL },
> +    { CSR_SIREG, kvm_riscv_emu_sireg_ctx_load, kvm_riscv_emu_sireg_ctx_put },
> +    { CSR_STOPEI, NULL, NULL },
>  };
>  
>  static int kvm_riscv_handle_csr(CPUState *cs, struct kvm_run *run)
> -- 
> 2.17.1
> 

