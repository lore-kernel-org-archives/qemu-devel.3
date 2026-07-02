Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF702C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHtX-0002FH-HC; Thu, 02 Jul 2026 09:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1wfHtT-000293-Pn
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:55:56 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1wfHtR-0000wJ-Ax
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:55:55 -0400
Received: from linux.microsoft.com (unknown [86.121.140.206])
 by linux.microsoft.com (Postfix) with ESMTPSA id A65E920B7167;
 Thu,  2 Jul 2026 06:55:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A65E920B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1783000548;
 bh=T3oAbi3KleQKgw5VNea+jDBKQEiddldBpgpGgD2X2Fw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EaneDl5R5ubBE6ujEYunwZiJggRjQdclud3aD3U5aRQbnJ934mexCww4TlrxqMSRa
 PCyn5im/x3wLXRwf6sbSpVVDFyO1K7SHgnOA+ieKExEziuxbegM2on3EKabE50ba6O
 2TEq/L7Zqpv2q39nqtTelEMW5gcZkxmpLXcz0E6Y=
Date: Thu, 2 Jul 2026 16:55:43 +0300
From: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: Re: [PATCH] target/i386: Skip supervisor in xsave decompaction
Message-ID: <akZt35qP1EUSczOp@linux.microsoft.com>
References: <20260702124746.450228-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260702124746.450228-1-magnuskulke@linux.microsoft.com>
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

On Thu, Jul 02, 2026 at 02:47:46PM +0200, Magnus Kulke wrote:
> Supervisor state should be skipped b/c there is no slot in standard
> format XSAVE buffer for it. CET State is being migrated via MSRs and
> other supervisor state isn't currently migrated.
> 
> Fixes: 8612deb3f4
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  target/i386/cpu.h          |  2 ++
>  target/i386/xsave_helper.c | 13 ++++++++++---
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index e6a197602d..fff701c6c4 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -655,9 +655,11 @@ typedef enum X86Seg {
>  
>  #define XSTATE_DYNAMIC_MASK             (XSTATE_XTILE_DATA_MASK)
>  
> +#define ESA_FEATURE_XSS_BIT             0
>  #define ESA_FEATURE_ALIGN64_BIT         1
>  #define ESA_FEATURE_XFD_BIT             2
>  
> +#define ESA_FEATURE_XSS_MASK            (1U << ESA_FEATURE_XSS_BIT)
>  #define ESA_FEATURE_ALIGN64_MASK        (1U << ESA_FEATURE_ALIGN64_BIT)
>  #define ESA_FEATURE_XFD_MASK            (1U << ESA_FEATURE_XFD_BIT)
>  
> diff --git a/target/i386/xsave_helper.c b/target/i386/xsave_helper.c
> index 625bae103a..1fa3133b1a 100644
> --- a/target/i386/xsave_helper.c
> +++ b/target/i386/xsave_helper.c
> @@ -332,7 +332,7 @@ int decompact_xsave_area(const void *buf, size_t buflen, CPUX86State *env)
>      size_t i;
>      uint32_t eax, ebx, ecx, edx;
>      uint32_t size, dst_off;
> -    bool align64;
> +    bool align64, supervisor;
>      uint64_t guest_xcr0, *xstate_bv;
>  
>      compacted_xstate_bv = *(uint64_t *)(buf + XSAVE_XSTATE_BV_OFFSET);
> @@ -383,6 +383,7 @@ int decompact_xsave_area(const void *buf, size_t buflen, CPUX86State *env)
>          size = eax;
>          dst_off = ebx;
>          align64 = (ecx & (1u << 1)) != 0;
> +        supervisor = (ecx & ESA_FEATURE_XSS_MASK) != 0;
>  
>          /* Component is in the layout but unknown to the guest CPUID model */
>          if (size == 0) {
> @@ -433,8 +434,14 @@ int decompact_xsave_area(const void *buf, size_t buflen, CPUX86State *env)
>              return -E2BIG;
>          }
>  
> -        /* Copy components marked present in XSTATE_BV to guest model */
> -        if (((compacted_xstate_bv >> i) & 1) != 0) {
> +        /*
> +         * Copy components marked present in XSTATE_BV to guest model.
> +         *
> +         * NB: Supervisor state is skipped b/c there is no slot in the
> +         * standard format XSAVE buffer (CET state is migrated via MSRs,
> +         * others supervisor state isn't migrated).
> +         */
> +        if (((compacted_xstate_bv >> i) & 1) != 0 && !supervisor) {
>              memcpy(env->xsave_buf + dst_off, buf + xsave_offset, size);
>          }
>  
> -- 
> 2.34.1

Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

