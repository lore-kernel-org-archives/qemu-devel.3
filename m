Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6719C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 15:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKgPy-00026r-9n; Fri, 21 Jun 2024 11:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKgPh-0001mh-Vs
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 11:42:59 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKgPf-0004Hp-Gd
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 11:42:57 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57cc1c00b97so2098306a12.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 08:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718984574; x=1719589374; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IXSj+NNNgXINRu4ZC/RcR1zjLwZ2WpiPQ2GU5bGPi0c=;
 b=luICIPFMXSpNp/rxdbgnv6s+C3wvnzvyjDTWLWv/JS73O6qGQRAeIgRPqdo0BNCL0G
 GJpVoZ8AHB6xRMygjWB4KWnUpwkUmb42xgOrAYF2rskjt2puiD8eQnd4nqOyrBqbDvw6
 FibKCgjDw8n+b+eTDvv0sJJs+9BRnLYT0ws/tO/kwWXk4un8nUCSfb/A3cSouU4lyi4S
 uyKb0rdXo4EL4UG86Gm2u8VCbd8Iw19vOrADLUXR2AYeWHKseKBSVad9/0m8N0Y9cBSm
 qJoZ5STv2sgCOQHxIfZfCZ9A+u7Xg3mZes8MKPAdasT4t5dOeXPpaKoBUpjcnCpPnWoG
 /5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718984574; x=1719589374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IXSj+NNNgXINRu4ZC/RcR1zjLwZ2WpiPQ2GU5bGPi0c=;
 b=VlIskB74Hk1dTqW/lyPUBrjq4Q3EWkmOj5hsVh5iKLDNZtHQdlpezb+nizENcD4VIb
 ieUS0eGk/VL4Z9FWCtFrqJZXdffkIF2BaQAjqzEBMcmVfyigt+ncg8WYcS2FrYC2F7HR
 zywR57JQyxOawp1WLuEbMOJ7gD6Cr0nYpHHMRpsR7HApXO07v7CWyfGz+K3MwV7hLkS5
 dND6VPGSP4D4mqFTKTULci8Zl2pYJ3UkoKLPcIqYewdCMcvXhno2cuLTm+lFrsO0hlc2
 93L+p2D48tGF7GOC3+yUGtRlL9QFOUT7akoMzVtm6FhUT6UkrLteoASnqFfYb4qdX6F2
 HDnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZfw3SD4zeETRA+euVR437kQjnMvkiAZ7lMnVCCQMv+4VM1o1Lo7SaMa2WGHWSE1w84cFnAbbHsDG8bEXwPGWVFAVLPQg=
X-Gm-Message-State: AOJu0Yyel8TS/BSXJMyDXYePF/DQXzsWAC6IgCQj2FrUQP/kU1QpC+Ak
 wX9K1wpn6NdGjbcllyNOyEfNxZgHjElbhNoeBbPoXdGNHZm0nJQtHqcPs++B5JCw24hETYdVZ6k
 yVr0RTnExQ+MShl5pEUH+LLKq2qXuksBWLnMkUw==
X-Google-Smtp-Source: AGHT+IFayiD+XyCR6nRLLfMFqk2ehbpw3mYKHEDExIWeo/poQp7EPrT4lUc0jt2XTNXgpgP4LVatO07VM3vpkQZ3dOw=
X-Received: by 2002:a50:8acf:0:b0:57c:5764:15f1 with SMTP id
 4fb4d7f45d1cf-57d07eaab6fmr4716563a12.29.1718984573959; Fri, 21 Jun 2024
 08:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240614093026.328271-1-sai.pavan.boddu@amd.com>
 <20240614093026.328271-2-sai.pavan.boddu@amd.com>
In-Reply-To: <20240614093026.328271-2-sai.pavan.boddu@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jun 2024 16:42:43 +0100
Message-ID: <CAFEAcA-A8xuJza+B8K3-6go=BBY+n9ruy7_FpEMTZKqKFPn+3w@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] target/arm: Add dcc uart support
To: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, francisco.iglesias@amd.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Fri, 14 Jun 2024 at 10:30, Sai Pavan Boddu <sai.pavan.boddu@amd.com> wrote:
>
> DCC is a debug port to transfer some data between debugger and
> processor, we are using this feature to connect a chardev device.
> Chardev frontends should be named as "dcc<cpu-index>" inorder to connect
> to this interface.
>
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> ---
>  target/arm/cpu.h       | 11 +++++
>  target/arm/internals.h |  4 ++
>  target/arm/debug-dcc.c | 99 ++++++++++++++++++++++++++++++++++++++++++
>  target/arm/helper.c    |  3 ++
>  target/arm/meson.build |  1 +
>  5 files changed, 118 insertions(+)
>  create mode 100644 target/arm/debug-dcc.c
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 3841359d0f..6b3cb8e70e 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -30,6 +30,8 @@
>  #include "qapi/qapi-types-common.h"
>  #include "target/arm/multiprocessing.h"
>  #include "target/arm/gtimer.h"
> +#include "chardev/char.h"
> +#include "chardev/char-fe.h"
>
>  #ifdef TARGET_AARCH64
>  #define KVM_HAVE_MCE_INJECTION 1
> @@ -523,6 +525,11 @@ typedef struct CPUArchState {
>
>          /* NV2 register */
>          uint64_t vncr_el2;
> +        /*
> +         * Debug Trace regsiters
> +         */
> +        uint32_t dbgdtr_tx;
> +        uint32_t dbgdtr_rx;
>      } cp15;
>
>      struct {
> @@ -1097,6 +1104,9 @@ struct ArchCPU {
>
>      /* Generic timer counter frequency, in Hz */
>      uint64_t gt_cntfrq_hz;
> +
> +    /* dcc chardev */
> +    CharBackend dcc;
>  };
>
>  typedef struct ARMCPUInfo {
> @@ -2388,6 +2398,7 @@ enum arm_features {
>       * CPU types added in future.
>       */
>      ARM_FEATURE_BACKCOMPAT_CNTFRQ, /* 62.5MHz timer default */
> +    ARM_FEATURE_DCC,

Generally speaking we want to avoid adding new ARM_FEATURE bits
if there's some way to identify the presence of the feature via
the ID registers. In this case, the debug registers always exist
as long as we have ARM_FEATURE_V7, I think. So I think we should
always provide this as part of the registers we define in
debug_cp_reginfo[] in debug_helper.c, rather than having a
separate feature bit.

>  };
>
>  static inline int arm_feature(CPUARMState *env, int feature)
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 11b5da2562..2fa797c5df 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1778,4 +1778,8 @@ uint64_t gt_get_countervalue(CPUARMState *env);
>   * and CNTVCT_EL0 (this will be either 0 or the value of CNTVOFF_EL2).
>   */
>  uint64_t gt_virt_cnt_offset(CPUARMState *env);
> +/*
> + * Initialise Coresight Debug interface
> + */
> +void arm_dcc_init(ARMCPU *cpu);
>  #endif
> diff --git a/target/arm/debug-dcc.c b/target/arm/debug-dcc.c
> new file mode 100644
> index 0000000000..9144b54994
> --- /dev/null
> +++ b/target/arm/debug-dcc.c
> @@ -0,0 +1,99 @@
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "internals.h"
> +#include "cpregs.h"
> +#include "chardev/char-fe.h"
> +
> +#define MDCCSR_EL0_RXFULL_MASK (1 << 30)
> +#define MDCCSR_EL0_TXFULL_MASK (1 << 29)
> +
> +static void debug_dcc_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                        uint64_t value)
> +{
> +    ARMCPU *cpu = ri->opaque;
> +    env->cp15.dbgdtr_tx = value;
> +
> +    if (qemu_chr_fe_get_driver(&cpu->dcc)) {

This is a weird function to have to call. Generally we set things
up so that you don't need to care if there's actually anything
connected to the chardev -- qemu_chr_fe_write() and friends will
do nothing if there's no chardev attached to this backend.

> +        /*
> +         * Usually dcc is used for putc/getc calls which expect only
> +         * 1 byte from external debugger.
> +         * TODO: This needs to be generalized for other use-cases.
> +         */

Is this referring to the way that the DCC is defined as a 64-bit
(or 32-bit for AArch32) channel but we're ignoring all but the bottom
8 bits of the values?

> +        qemu_chr_fe_write_all(&cpu->dcc, (uint8_t *)&env->cp15.dbgdtr_tx, 1);

The DCC has flow-control flags so we don't need to use _write_all, and
generally we should avoid that in new code because it might block.

> +    }
> +}
> +
> +static uint64_t debug_dcc_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    uint32_t ret = 0;
> +    ARMCPU *cpu = ri->opaque;
> +
> +    if (env->cp15.mdscr_el1 & MDCCSR_EL0_RXFULL_MASK) {
> +        ret = env->cp15.dbgdtr_rx;
> +        env->cp15.dbgdtr_rx = 0;
> +        env->cp15.mdscr_el1 &= ~MDCCSR_EL0_RXFULL_MASK;
> +        qemu_chr_fe_accept_input(&cpu->dcc);
> +    }
> +    return ret;
> +}
> +
> +static const ARMCPRegInfo dcc_cp_reginfo[] = {
> +    /* DBGDTRTX_EL0/DBGDTRRX_EL0 depend on direction */
> +    { .name = "DBGDTR_EL0", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 2, .opc1 = 3, .crn = 0, .crm = 5, .opc2 = 0,
> +      .access = PL0_RW, .writefn = debug_dcc_write,
> +      .readfn = debug_dcc_read,
> +      .type = ARM_CP_OVERRIDE, .resetvalue = 0 },
> +    /* DBGDTRTXint/DBGDTRRXint depend on direction */
> +    { .name = "DBGDTRint", .state = ARM_CP_STATE_AA32, .cp = 14,
> +      .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 0,
> +      .access = PL0_RW, .writefn = debug_dcc_write,
> +      .readfn = debug_dcc_read,
> +      .type = ARM_CP_OVERRIDE, .resetvalue = 0 },
> +};

Other registers that need updates for a real DCC:
 * MDCCSR_EL0
 * OSDTRRX_EL1
 * OSDTRTX_EL1

(all of which we currently have dummy versions of in
debug_helper.c).

> +
> +
> +static int dcc_chr_can_read(void *opaque)
> +{
> +    ARMCPU *cpu = opaque;
> +    CPUARMState *env = &cpu->env;
> +
> +    if (!(env->cp15.mdscr_el1 & MDCCSR_EL0_RXFULL_MASK)) {
> +        /*
> +         * Usually dcc is used for putc/getc calls which expect only
> +         * 1 byte from external debugger.
> +         * TODO: This needs to be generalized for other use-cases.
> +         */
> +        return 1;
> +    }
> +
> +    return 0;
> +}
> +
> +static void dcc_chr_read(void *opaque, const uint8_t *buf, int size)
> +{
> +    ARMCPU *cpu = opaque;
> +    CPUARMState *env = &cpu->env;
> +
> +    env->cp15.dbgdtr_rx = *buf;
> +    env->cp15.mdscr_el1 |= MDCCSR_EL0_RXFULL_MASK;
> +}
> +
> +void arm_dcc_init(ARMCPU *cpu)
> +{
> +    Chardev *chr;
> +    char *dcc_name;
> +    CPUState *p = CPU(cpu);
> +
> +    dcc_name = g_strdup_printf("dcc%d", p->cpu_index);
> +    chr = qemu_chr_find(dcc_name);
> +    define_arm_cp_regs_with_opaque(cpu, dcc_cp_reginfo, cpu);
> +    if (chr) {
> +        qemu_chr_fe_init(&cpu->dcc, chr, NULL);
> +        qemu_chr_fe_set_handlers(&cpu->dcc,
> +                      dcc_chr_can_read,
> +                      dcc_chr_read,
> +                      NULL, NULL, cpu, NULL, true);
> +    }
> +    g_free(dcc_name);
> +}

thanks
-- PMM

