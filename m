Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDFAEE368C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 15:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqYGA-0006ta-TD; Thu, 12 Feb 2026 10:05:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1vqYG6-0006oB-Dy; Thu, 12 Feb 2026 10:05:34 -0500
Received: from out-171.mta0.migadu.com ([2001:41d0:1004:224b::ab])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1vqYG1-0003Ll-Q9; Thu, 12 Feb 2026 10:05:33 -0500
Message-ID: <af89e56b-1d08-457c-ac1e-8a94cf47c176@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1770908722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zqQUw75psSRldFezhOmlYYd+fHbOMNHv4Cu6QEPxP4s=;
 b=PXmOgankGXruw8cpNcPdrZ+o4/xNRzyXWabMhHSY4vaNhrfH0AHQsIRrkT9uUKp5K5OBpr
 Xcl3NjqnsPlfQj5EnyD9Om1WKWKU5kgUp6zvzc3A9S0cKT/4jYMWjlEh1jIJq54+wgaIge
 gcR7ALf8Fy25wayGYCH7+bAYauGNddQ=
Date: Thu, 12 Feb 2026 23:05:06 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v5 2/2] target/arm/hvf: Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260118215945.46693-1-philmd@linaro.org>
 <20260118215945.46693-3-philmd@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20260118215945.46693-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::ab;
 envelope-from=zenghui.yu@linux.dev; helo=out-171.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Hi,

On 1/19/26 5:59 AM, Philippe Mathieu-Daudé wrote:
> Keep CNTV_CTL_EL0 and CNTV_CVAL_EL0 synchronized with the
> host hardware accelerator.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/arm/hvf/hvf.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index fcb7fa3b30c..9ce720793d8 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -200,6 +200,9 @@ void hvf_arm_init_debug(void)
>  #define SYSREG_PMCEID0_EL0    SYSREG(3, 3, 9, 12, 6)
>  #define SYSREG_PMCEID1_EL0    SYSREG(3, 3, 9, 12, 7)
>  #define SYSREG_PMCCNTR_EL0    SYSREG(3, 3, 9, 13, 0)
> +
> +#define SYSREG_CNTV_CTL_EL0   SYSREG(3, 3, 14, 3, 1)
> +#define SYSREG_CNTV_CVAL_EL0  SYSREG(3, 3, 14, 3, 2)
>  #define SYSREG_PMCCFILTR_EL0  SYSREG(3, 3, 14, 15, 7)
>  
>  #define SYSREG_ICC_AP0R0_EL1     SYSREG(3, 0, 12, 8, 4)
> @@ -502,6 +505,7 @@ int hvf_arch_get_registers(CPUState *cpu)
>      uint64_t val;
>      hv_simd_fp_uchar16_t fpval;
>      int i, n;
> +    bool b;
>  
>      for (i = 0; i < ARRAY_SIZE(hvf_reg_match); i++) {
>          ret = hv_vcpu_get_reg(cpu->accel->fd, hvf_reg_match[i].reg, &val);
> @@ -631,6 +635,16 @@ int hvf_arch_get_registers(CPUState *cpu)
>  
>      aarch64_restore_sp(env, arm_current_el(env));
>  
> +    ret = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0, &val);
> +    assert_hvf_ok(ret);
> +    b = hvf_sysreg_write_cp(cpu, "VTimer", SYSREG_CNTV_CVAL_EL0, val);
> +    assert(b);
> +
> +    ret = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, &val);
> +    assert_hvf_ok(ret);
> +    b = hvf_sysreg_write_cp(cpu, "VTimer", SYSREG_CNTV_CTL_EL0, val);
> +    assert(b);
> +
>      return 0;
>  }
>  
> @@ -642,6 +656,7 @@ int hvf_arch_put_registers(CPUState *cpu)
>      uint64_t val;
>      hv_simd_fp_uchar16_t fpval;
>      int i, n;
> +    bool b;
>  
>      for (i = 0; i < ARRAY_SIZE(hvf_reg_match); i++) {
>          val = *(uint64_t *)((void *)env + hvf_reg_match[i].offset);
> @@ -756,6 +771,16 @@ int hvf_arch_put_registers(CPUState *cpu)
>      ret = hv_vcpu_set_vtimer_offset(cpu->accel->fd, hvf_state->vtimer_offset);
>      assert_hvf_ok(ret);
>  
> +    b = hvf_sysreg_read_cp(cpu, "VTimer", SYSREG_CNTV_CVAL_EL0, &val);
> +    assert(b);
> +    ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0, val);
> +    assert_hvf_ok(ret);
> +
> +    b = hvf_sysreg_read_cp(cpu, "VTimer", SYSREG_CNTV_CTL_EL0, &val);
> +    assert(b);
> +    ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, val);
> +    assert_hvf_ok(ret);
> +
>      return 0;
>  }

My Linux guest has been unable to start since this patch. I tested it on
M1 (macOS Tahoe 26.2). Not sure if this can be reproduced on your side.

Thanks,
Zenghui

