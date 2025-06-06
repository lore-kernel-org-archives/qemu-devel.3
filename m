Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AF1C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 19:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNcTS-0007yW-BP; Fri, 06 Jun 2025 15:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uNcTQ-0007yL-Dq
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 15:11:28 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uNcTO-0003nN-Hu
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 15:11:28 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2F8784A417;
 Fri,  6 Jun 2025 19:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3E5C4CEEB;
 Fri,  6 Jun 2025 19:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749237083;
 bh=mGr0xjRxk9XZb9sSt43HZ39NOPt6UAkBq3wvnNIoY8M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TXRi+hKaUgxrgOCUUYWF0oCb/Y83iJRVQAd3LRAek+zLbVVTtnemYzeKfDSueeDKU
 zquY5Bks7FnNwGzb97iXSzZrCGBfqygcH8Lp4zP3LHp7XySQ4iFtvgim8TzERz2NcB
 afMR4LFpiLPIVrO+Lb/8CdsVSdm8/l6sEK9Y7ios5G0knK33GtfYEiZ4mWOtkSdTnG
 aCFhm9rheiEMZKJgglMWAT9P1UBsbq9OlemRs+AQ5cTD8qKqnbTGSCcr7e29XGeY3W
 pqPd3S6OrkJwTzebkKtGdt9O5Iltc0558HpPjbW8cGgwFWXGTyvoPD4SqfH5NgVN4o
 SNDfY4bU35kOQ==
Date: Fri, 6 Jun 2025 19:11:21 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 18/25] target/i386/mshv: Implement
 mshv_arch_put_registers()
Message-ID: <aEM9WdXPmQhOl5un@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-19-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520113018.49569-19-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=wei.liu@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, May 20, 2025 at 01:30:11PM +0200, Magnus Kulke wrote:
> Write CPU register state to MSHV vCPUs. Various mapping functions to
> prepare the payload for the HV call have been implemented.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
[...]
> +
> +static void populate_hv_table_reg(const struct SegmentCache *seg,
> +                                  hv_x64_table_register *hv_reg)
> +{
> +    hv_reg->base = seg->base;
> +    hv_reg->limit = seg->limit;
> +    memset(hv_reg->pad, 0, sizeof(hv_reg->pad));

I'm not sure if the compiler will optimize this function call out.

It is straightforward to write

       *hv_reg = { .base = seg->base, .limit = seg->limit };

> +}
> +
> +static int set_special_regs(const CPUState *cpu)
> +{
> +    X86CPU *x86cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86cpu->env;
> +    int cpu_fd = mshv_vcpufd(cpu);
> +    struct hv_register_assoc *assocs;
> +    size_t n_regs = sizeof(SPECIAL_REGISTER_NAMES) / sizeof(hv_register_name);
> +    int ret;
> +
> +    assocs = g_new0(struct hv_register_assoc, n_regs);

The allocation here can be removed, since we know for sure how many
elements are in `SPECIAL_REGISTER_NAMES`. It should be fine to use an
on-stack array.

There are probably other places you can optimize.

Thanks,
Wei.

