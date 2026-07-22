Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938C9C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmXXs-0002m4-Ta; Wed, 22 Jul 2026 10:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1wmXXr-0002ln-E2
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 10:03:35 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1wmXXp-0007O0-UU
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 10:03:35 -0400
Received: from linux.microsoft.com (unknown [86.121.140.206])
 by linux.microsoft.com (Postfix) with ESMTPSA id 947BF20B7167;
 Wed, 22 Jul 2026 07:03:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 947BF20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1784728999;
 bh=eaIjGCyozH9V40rnl7gMhm+VJnQW4ImQYjEBDphR2Ro=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Jw6gj+5M0ZC+sz7gEe4kDFEE9iv7Y1VyJGuv6LXlFY2Love0yVpTvF1roLp9PhVZC
 7Ppbl6Q3KJyqqmGOfThFUpeGNTa5VtQl8LOpLPvDr7PDV/ZnzV4XzdeZ9O88o3LGMg
 WbYEbrbjI2GAuX2bCsTTLkNJI0ZElK3b0mBk+Y2M=
Date: Wed, 22 Jul 2026 17:03:22 +0300
From: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>
Subject: Re: [PATCH 06/12] target/i386/mshv: migrate Synic SINT MSRs
Message-ID: <amDNqvZ37qZX5Yd1@linux.microsoft.com>
References: <20260710101534.664604-1-magnuskulke@linux.microsoft.com>
 <20260710101534.664604-7-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710101534.664604-7-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

On Fri, Jul 10, 2026 at 12:15:28PM +0200, Magnus Kulke wrote:
> Migrate HyperV SynIC SINT MSRs. We can only read/write those if SCONTROL
> is enabled in the guest, hence we have to split the SINT MSR out and
> make reading/writing them dependent on that MSR.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  target/i386/mshv/msr.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/target/i386/mshv/msr.c b/target/i386/mshv/msr.c
> index a5f639c3ca..5288e32b6d 100644
> --- a/target/i386/mshv/msr.c
> +++ b/target/i386/mshv/msr.c
> @@ -331,6 +331,8 @@ int mshv_get_msrs(CPUState *cpu)
>      struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT];
>      size_t i, j;
>      uint32_t name;
> +    X86CPU *x86cpu = X86_CPU(cpu);
> +    bool synic_enabled;
>  
>      set_hv_name_in_assocs(assocs, n_assocs);
>  
> @@ -357,6 +359,27 @@ int mshv_get_msrs(CPUState *cpu)
>  
>      store_in_env(cpu, assocs, n_assocs);
>  
> +    /* Read SINT MSRs only if SynIC is enabled */
> +    synic_enabled = x86cpu->env.msr_hv_synic_control & 1;
> +    if (synic_enabled) {
> +        QEMU_BUILD_BUG_ON(MSHV_MSR_TOTAL_COUNT < HV_SINT_COUNT);
> +
> +        for (i = 0; i < HV_SINT_COUNT; i++) {
> +            assocs[i].name = HV_REGISTER_SINT0 + i;
> +        }
> +
> +        ret = mshv_get_generic_regs(cpu, assocs, HV_SINT_COUNT);
> +        if (ret < 0) {
> +            error_report("Failed to get SynIC SINT MSRs");
> +            return -errno;
> +        }
> +
> +        for (i = 0; i < HV_SINT_COUNT; i++) {
> +            uint64_t hv_sint_value = assocs[i].value.reg64;
> +            x86cpu->env.msr_hv_synic_sint[i] = hv_sint_value;
> +        }
> +    }
> +
>      return 0;
>  }
>  
> @@ -391,6 +414,8 @@ int mshv_set_msrs(const CPUState *cpu)
>      struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT];
>      int ret;
>      size_t i, j;
> +    X86CPU *x86cpu = X86_CPU(cpu);
> +    bool synic_enabled = x86cpu->env.msr_hv_synic_control & 1;
>  
>      load_from_env(cpu, assocs, n_assocs);
>  
> @@ -423,5 +448,21 @@ int mshv_set_msrs(const CPUState *cpu)
>          return -errno;
>      }
>  
> +    /* SINT MSRs can only be written if SCONTROL has been set, so we split */
> +    if (synic_enabled) {
> +        QEMU_BUILD_BUG_ON(MSHV_MSR_TOTAL_COUNT < HV_SINT_COUNT);
> +
> +        for (i = 0; i < HV_SINT_COUNT; i++) {
> +            assocs[i].name        = HV_REGISTER_SINT0 + i;
> +            assocs[i].value.reg64 = x86cpu->env.msr_hv_synic_sint[i];
> +        }
> +
> +        ret = mshv_set_generic_regs(cpu, assocs, HV_SINT_COUNT);
> +        if (ret < 0) {
> +            error_report("Failed to set SynIC SINT MSRs");
> +            return -errno;
> +        }
> +    }
> +
>      return 0;
>  }
> -- 
> 2.34.1

Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

