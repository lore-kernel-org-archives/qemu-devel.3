Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B391C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 11:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkJvY-0006ns-EP; Thu, 16 Jul 2026 07:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1wkJvW-0006ma-59
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 07:06:50 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1wkJvT-0003HE-EI
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 07:06:48 -0400
Received: from linux.microsoft.com (unknown [167.220.197.183])
 by linux.microsoft.com (Postfix) with ESMTPSA id 3522120B7167;
 Thu, 16 Jul 2026 04:06:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3522120B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1784199994;
 bh=r9bcdXskcSuKd2g0BrAyoEPN5qq+H7GaU2HModfNBtE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ELn0lebGwYjdgvGN9yd2MuJmDgX10K3JNe62/piK2vzT54YulwGkGkh79J3JRrZO8
 Pl8UJi4T5KyngPD78QwVUh5eTCI0nCPlw7E35YqQq1BgZRdp2IqiRQI8IpHP6yNXGv
 1Ps5P0ijIx8rIfFOWQgsMAGVtnF5tljIp523WDDM=
Date: Thu, 16 Jul 2026 14:06:32 +0300
From: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>
Subject: Re: [PATCH 01/12] target/i386/mshv: disable AMX TILE features
Message-ID: <ali7OIHQ0BjH0pmq@linux.microsoft.com>
References: <20260710101534.664604-1-magnuskulke@linux.microsoft.com>
 <20260710101534.664604-2-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710101534.664604-2-magnuskulke@linux.microsoft.com>
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

On Fri, Jul 10, 2026 at 12:15:23PM +0200, Magnus Kulke wrote:
> For the time being we disable AMX TILE in partition processor features
> and CPUID b/c AMX TILE XSAVE state (XTILE_DATA) is 8KB, which exceeds
> the current fixed 4KB XSAVE buffer size.
> 
> For now we filter it until buffer sizing is computed dynamically from CPUID.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  accel/mshv/mshv-all.c       |  8 ++++++++
>  target/i386/mshv/mshv-cpu.c | 16 ++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index 72721d0f0d..5e8756ede2 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -203,6 +203,14 @@ static int create_partition(int mshv_fd, int *vm_fd)
>  
>      /* enable all */
>      disabled_xsave_features.as_uint64 = 0;
> +    /*
> +     * AMX TILE XSAVE state (XTILE_DATA) is 8KB, which exceeds the
> +     * current fixed 4KB XSAVE buffer size.
> +     */
> +    disabled_xsave_features.amx_tile_support = 1;
> +    disabled_xsave_features.amx_bf16_support = 1;
> +    disabled_xsave_features.amx_int8_support = 1;
> +    disabled_xsave_features.amx_fp16_support = 1;
>  
>      /*
>       * query host for supported processor features and disable unsupported
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 1c433c408c..8eca01a8fa 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -2156,6 +2156,22 @@ uint32_t mshv_get_supported_cpuid(uint32_t func, uint32_t idx, int reg)
>           */
>          ret &= ~CPUID_7_0_ECX_LA57;
>      }
> +    if (func == 0x07 && idx == 0 && reg == R_EDX) {
> +        /*
> +         * AMX TILE XSAVE state (XTILE_DATA) is 8KB, which exceeds the
> +         * current fixed 4KB XSAVE buffer size. Filter until buffer
> +         * sizing is computed dynamically from CPUID.
> +         */
> +        ret &= ~CPUID_7_0_EDX_AMX_TILE;
> +        ret &= ~CPUID_7_0_EDX_AMX_BF16;
> +        ret &= ~CPUID_7_0_EDX_AMX_INT8;
> +    }
> +    if (func == 0x07 && idx == 1 && reg == R_EAX) {
> +        ret &= ~CPUID_7_1_EAX_AMX_FP16;
> +    }
> +    if (func == 0x07 && idx == 1 && reg == R_EDX) {
> +        ret &= ~CPUID_7_1_EDX_AMX_COMPLEX;
> +    }
>  
>      return ret;
>  }
> -- 
> 2.34.1

Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

