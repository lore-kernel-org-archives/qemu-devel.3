Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB99606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=rUpAZGYr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR5yy-0005rJ-91; Wed, 11 Nov 2026 05:55:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xR5yw-0005qs-3J
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 05:55:10 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xR5yu-0000fV-Fo
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 05:55:09 -0500
Received: from example.com (p50892c72.dip0.t-ipconnect.de [80.137.44.114])
 by linux.microsoft.com (Postfix) with ESMTPSA id 33C9020B7168;
 Wed, 11 Nov 2026 02:55:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 33C9020B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1794394503;
 bh=5/M7mWpqiDwfHmFMZBKXELug6KWnkFehPY7ss/gutyU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rUpAZGYrl63maeTYR+petH1GFbduDtJO9AfxhQEuN7fMdbWa/s6g+9BHIOOKPn6jK
 G9zxrjWABYw4aq0fLN0CHwV8plu8SfssygC73JFbVJF77M0DD2Myia61ejGJzlWnnU
 zc42fV4NiSVjcOK+34LNevZcADKzKczt3FAuMNDg=
Date: Wed, 11 Nov 2026 11:54:59 +0100
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>
Subject: Re: [PATCH v2 1/3] i386/cpu.c: Adjust minimum xlevel to 0x8000_001E
 when TOPOEXT is enabled
Message-ID: <avRJgx+DN8oz11gh@example.com>
References: <20261110095617.50713-1-dblanzeanu@linux.microsoft.com>
 <20261110095617.50713-2-dblanzeanu@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261110095617.50713-2-dblanzeanu@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 11:56:15AM +0200, Doru Blânzeanu wrote:
> This ensures the guests can discover the AMD cache and processor topology leaves
> when TOPOEXT feature is enabled.
> 
> Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
> ---
>  target/i386/cpu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index eab0d5a4d4..e443132ce9 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -9911,6 +9911,11 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>          x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000000A);
>      }
>  
> +    /* TOPOEXT requires CPUID[0x8000001D] and CPUID[0x8000001E] */
> +    if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) {
> +        x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001E);
> +    }
> +
>      /* SEV requires CPUID[0x8000001F] */
>      if (sev_enabled()) {
>          x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001F);
> -- 
> 2.54.0

It looks correct, but since this change touches a generic path it might
have an unintended fallout. Maybe we can split this out and post this
as a isolated patch, and solve the issue in allocator-local code like
KVM apparently does in kvm_cpu_instance_init() w/
kvm_cpu_max_instance_init()?

