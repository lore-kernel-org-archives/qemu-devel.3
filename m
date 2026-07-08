Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F8CC44501
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whVHR-00047k-LK; Wed, 08 Jul 2026 12:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1whVHP-00047S-QF
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:37:47 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1whVHO-0001yU-Aa
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:37:47 -0400
Received: from example.com (unknown [167.220.208.42])
 by linux.microsoft.com (Postfix) with ESMTPSA id 8CA3720B7167;
 Wed,  8 Jul 2026 09:37:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8CA3720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1783528660;
 bh=mGWEF5+wA1CbBKnFvOam06NzGFE4orJFbunFFuFuqps=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XpfMdv5xyL3nBkh41oyZxaxQnoaic90kf84JrqbYn6j8+gXiPuBl1WvnNfwbM1A0P
 Y2O/ThaqNk/YZj70AxpsxAQsN6M1TvsoZVWtMgTPIeIfaFx5Led9TBktRgC9IrmLWu
 6l4OBNDMzAVN6pJgqqURaUFcxN5o7aCi0c1siSKU=
Date: Wed, 8 Jul 2026 18:37:41 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Magnus Kulke <magnuskulke@microsoft.com>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>
Subject: Re: [PATCH 2/5] target/i386/mshv: abort when hv_vp_register_page
 setup fails
Message-ID: <ak581d6f+Hr82VJU@example.com>
References: <20260707221645.24557-1-dblanzeanu@linux.microsoft.com>
 <20260707221645.24557-3-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707221645.24557-3-dblanzeanu@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
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

On Wed, Jul 08, 2026 at 01:16:42AM +0300, Doru Blânzeanu wrote:
> In case the call to mmap fails, we log an error and abort to signal
> there is something wrong with the system.
> Check the register page version and compare with the expected version and
> abort in case of a mismatch.
> 
> Fixes: a173f8f170
> Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
> ---
>  target/i386/mshv/mshv-cpu.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 1c433c408c..c782715497 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -2049,6 +2049,7 @@ void mshv_arch_init_vcpu(CPUState *cpu)
>      CPUX86State *env = &x86_cpu->env;
>      AccelCPUState *state = cpu->accel;
>      size_t page = HV_HYP_PAGE_SIZE, xsave_len;
> +    void *regs_page;
>      void *mem = qemu_memalign(page, 2 * page);
>      int ret;
>      X86XSaveHeader *header;
> @@ -2060,15 +2061,20 @@ void mshv_arch_init_vcpu(CPUState *cpu)
>                        > HV_HYP_PAGE_SIZE));
>  
>      /* mmap the registers page */
> -    void *rp = mmap(NULL, page, PROT_READ | PROT_WRITE,
> +    regs_page = mmap(NULL, page, PROT_READ | PROT_WRITE,
>                      MAP_SHARED, mshv_vcpufd(cpu),
>                      MSHV_VP_MMAP_OFFSET_REGISTERS * page);
> -    if (rp == MAP_FAILED) {
> -        warn_report("register page mmap failed, falling back to hypercalls: %s",
> -                    strerror(errno));
> -        env->regs_page = NULL;
> -    } else {
> -        env->regs_page = (struct hv_vp_register_page *) rp;
> +    if (regs_page == MAP_FAILED) {
> +        /* This shouldn't fail, so we treat it as a fatal error */
> +        error_report("register page mmap failed: %s", strerror(errno));
> +        abort();
> +    }
> +    env->regs_page = (struct hv_vp_register_page *) regs_page;
> +
> +    if (env->regs_page->version != HV_VP_REGISTER_PAGE_VERSION_1) {
> +        error_report("register page version mismatch: got %u, expected %u",
> +                     env->regs_page->version, HV_VP_REGISTER_PAGE_VERSION_1);
> +        abort();
>      }
>  
>      state->hvcall_args.base = mem;
> -- 
> 2.53.0

Reviewed-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

