Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B5BD44D57
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 12:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8f8T-0007C7-6p; Wed, 06 Nov 2024 07:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t8f8O-0007Bn-Ad; Wed, 06 Nov 2024 07:27:40 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t8f8M-0005Kf-6D; Wed, 06 Nov 2024 07:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730896058; x=1762432058;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Q5mAGqr6fBZa46ptlj0c2tOjO/AVkSYXS7mLE8kdevc=;
 b=BO4oV4TRmOlxdEGhfx7vEzhVMATX/z91btwasq63n/gtyZknXJbe8KQo
 9aO+z6junRNO62r/63O7/ofT70R6BWDKhXa8XwZ6mMAutiBjWxkOcj3Nc
 YJDBvY5VRaEbaaZP7j9FkeIu5BUELLKMsuV9m4SsUm+cIrWC44XVAZm+W
 IiDKN4KvT7xdoVVL0470XwLP6++Mlne8TsDrX8yPYRhVlTTe5mOt2TuSK
 7MWoJBLRZDIT/Rput5aC2GY0xB+XWhfZXdXXu/CdKe4vNV9/TI7h4/F8e
 E8yOWBeM1dO/UFJRJ8JgLhMOz+HvOkdN7JGtYek+U5HhapAiZbpsW/DPz A==;
X-CSE-ConnectionGUID: 0NGXSYmbS9KOBXNxIV1F6w==
X-CSE-MsgGUID: YJGIaQ2LS127E17VVe3OeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="30117916"
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; d="scan'208";a="30117916"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2024 04:27:34 -0800
X-CSE-ConnectionGUID: pcgVXOXpTwKtm7Qqb+LBAw==
X-CSE-MsgGUID: oEPzkh84Qme5i7cGVAyMIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; d="scan'208";a="89635785"
Received: from linux.bj.intel.com ([10.238.157.71])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2024 04:27:30 -0800
Date: Wed, 6 Nov 2024 20:22:23 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>,
 Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-stable@nongnu.org
Subject: Re: [PATCH v5 01/11 for v9.2?] i386/cpu: Mark avx10_version filtered
 when prefix is NULL
Message-ID: <Zytffxz6DMfQSv0G@linux.bj.intel.com>
References: <20241106030728.553238-1-zhao1.liu@intel.com>
 <20241106030728.553238-2-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106030728.553238-2-zhao1.liu@intel.com>
Received-SPF: none client-ip=192.198.163.18;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Wed, Nov 06, 2024 at 11:07:18AM +0800, Zhao Liu wrote:
> In x86_cpu_filter_features(), if host doesn't support AVX10, the
> configured avx10_version should be marked as filtered regardless of
> whether prefix is NULL or not.
> 
> Check prefix before warn_report() instead of checking for
> have_filtered_features.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: commit bccfb846fd52 ("target/i386: add AVX10 feature and AVX10 version property")
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Tao Su <tao1.su@linux.intel.com>

> ---
> v5: new commit.
> ---
>  target/i386/cpu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 3baa95481fbc..77c1233daa13 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7711,8 +7711,10 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
>              env->avx10_version = version;
>              have_filtered_features = true;
>          }
> -    } else if (env->avx10_version && prefix) {
> -        warn_report("%s: avx10.%d.", prefix, env->avx10_version);
> +    } else if (env->avx10_version) {
> +        if (prefix) {
> +            warn_report("%s: avx10.%d.", prefix, env->avx10_version);
> +        }
>          have_filtered_features = true;
>      }
>  
> -- 
> 2.34.1
> 

