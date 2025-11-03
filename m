Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E80CCCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 12:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFtxO-0005E4-Su; Mon, 03 Nov 2025 07:46:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vFtxH-0005Cq-EO; Mon, 03 Nov 2025 07:46:40 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vFtx3-0002U6-Mp; Mon, 03 Nov 2025 07:46:38 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5A3Cjgvl034173
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 3 Nov 2025 21:45:42 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=hHes6wQ/fSO2TACbDjWeO7HMyyy9kCIpBgvrsaB50x8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1762173943; v=1;
 b=WWPR0yIY38g9/Z6Gdif55JRxpAwrufkbHCYbUDAYV2Kr+ALccB9bZe1fOiR4ZYg6
 A56SASK8IwgGPr0L8s1JTHwd4qbA+A05kn4w7bTKH9WjDpcGrCUrG6uP5PglQY5+
 TH3dwfktfOUiD2TgxqEpnMHrznBtYUqBMoDCq10mdWJfsgD/PAQ9bFlLEBlIFqRA
 f5y3cv8ywzHAm49b7WiGronrzuKGseoYcL4WHP8Kcvj+XzA+65pxjrr0vimdJURh
 lBzNYMLM+W2/TxhlReZIPYlqzcnNUV/wdHJZGdnbUsBsB+o/4HD0Gzp2PbF2Zn+4
 co9y26YQ6hWdNtufl2fVFw==
Message-ID: <8f1c4b47-c6cd-449a-b2f5-2c26c4aae498@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 3 Nov 2025 21:45:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/23] accel/hvf: Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Peter Collingbourne <pcc@google.com>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20251103101034.59039-1-philmd@linaro.org>
 <20251103101034.59039-24-philmd@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251103101034.59039-24-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/11/03 19:10, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 39 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 268a0bcd8ea..60378075882 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -200,6 +200,9 @@ void hvf_arm_init_debug(void)
>   #define SYSREG_PMCEID0_EL0    SYSREG(3, 3, 9, 12, 6)
>   #define SYSREG_PMCEID1_EL0    SYSREG(3, 3, 9, 12, 7)
>   #define SYSREG_PMCCNTR_EL0    SYSREG(3, 3, 9, 13, 0)
> +
> +#define SYSREG_CNTV_CTL_EL0   SYSREG(3, 3, 14, 3, 1)
> +#define SYSREG_CNTV_CVAL_EL0  SYSREG(3, 3, 14, 3, 2)
>   #define SYSREG_PMCCFILTR_EL0  SYSREG(3, 3, 14, 15, 7)
>   
>   #define SYSREG_ICC_AP0R0_EL1     SYSREG(3, 0, 12, 8, 4)
> @@ -2017,13 +2020,49 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
>       return ret;
>   }
>   
> +static void hvf_sync_vtimer_pre_exec(CPUState *cpu)
> +{
> +    hv_return_t r;
> +    uint64_t val;
> +    bool b;
> +
> +    b = hvf_sysreg_read_cp(cpu, "VTimer", SYSREG_CNTV_CVAL_EL0, &val);
> +    assert(b);
> +    r = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0, val);
> +    assert_hvf_ok(r);
> +
> +    b = hvf_sysreg_read_cp(cpu, "VTimer", SYSREG_CNTV_CTL_EL0, &val);
> +    assert(b);
> +    r = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, val);
> +    assert_hvf_ok(r);
> +}
> +
> +static void hvf_sync_vtimer_post_exec(CPUState *cpu)
> +{
> +    hv_return_t r;
> +    uint64_t val;
> +    bool b;
> +
> +    r = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0, &val);
> +    assert_hvf_ok(r);
> +    b = hvf_sysreg_write_cp(cpu, "VTimer", SYSREG_CNTV_CVAL_EL0, val);
> +    assert(b);
> +
> +    r = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, &val);
> +    assert_hvf_ok(r);
> +    b = hvf_sysreg_write_cp(cpu, "VTimer", SYSREG_CNTV_CTL_EL0, val);
> +    assert(b);
> +}
> +
>   void hvf_arch_cpu_synchronize_pre_exec(CPUState *cpu)
>   {
> +    hvf_sync_vtimer_pre_exec(cpu);

Perhaps this should be called from hvf_put_registers(). It will gate the 
logic behind the vcpu_dirty flag, and, after all, hvf_put_registers() is 
a function for setting registers like what hvf_sync_vtimer_pre_exec() sets.

>       flush_cpu_state(cpu);
>   }
>   
>   void hvf_arch_cpu_synchronize_post_exec(CPUState *cpu)
>   {
> +    hvf_sync_vtimer_post_exec(cpu);
>   }
>   
>   int hvf_arch_vcpu_exec(CPUState *cpu)


