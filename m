Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC01C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 15:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBxQh-0001Yq-OR; Mon, 05 May 2025 11:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uBxQd-0001XD-3o
 for qemu-devel@nongnu.org; Mon, 05 May 2025 11:08:23 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uBxQa-0007CJ-Gd
 for qemu-devel@nongnu.org; Mon, 05 May 2025 11:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746457700; x=1777993700;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=+p5FCm6DQ9MAGyEbIwegXKJjpMiJfd6UklRI3XleVpQ=;
 b=Q4RL3jmTw6blBQ1afOzsci1aHhxQdO5KpgouWrcExA2USXdWOtMI7bTG
 2DI3DO6bgixr9E+XTjFZtg9ylEfNuG647jYSusZ5a5v3/bPKrJPCO47jg
 TaH+5BXFzlaJpNv1JaJFrlA634kg3Qx2NfkrIVQW1oltMD+tBvgdzIhk2
 HzeGhXYGuWMp40E5Mf0O97WU6SEQvTodSsRSQWdOh5lcNCsFd6xPgKCZr
 I5xJsxZ8/E36bCdCMQZjNjYBa5cwuFYyceJ4dsQawm3ZzL9OQZQp0c+Nf
 VMZEucyEZhywP7KG+busnbK+O5HpanqjDC7VvMRmbhWKuyLgDaREL1+wp w==;
X-CSE-ConnectionGUID: YKZ0Vy+tToSd1go6o337XQ==
X-CSE-MsgGUID: Slt2CbWZQcuxV9ikeN6RXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="50723965"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; d="scan'208";a="50723965"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2025 08:08:12 -0700
X-CSE-ConnectionGUID: 4jsSXWe1S7aIZkBKIh/lwg==
X-CSE-MsgGUID: 0wTOGyh7QZWai9cmAMTAyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; d="scan'208";a="140267138"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 05 May 2025 08:08:10 -0700
Date: Mon, 5 May 2025 23:29:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 54/55] i386/tdx: Validate phys_bits against host value
Message-ID: <aBjZRsgEkDFc9JgE@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-55-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-55-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> @e -875,6 +876,13 @@ static int tdx_check_features(X86ConfidentialGuest *cg, CPUState *cs)
>          return -1;

Here you has already used "return -1", so...

>      }
>  
> +    if (cpu->phys_bits != host_cpu_phys_bits()) {
> +        error_report("TDX requires guest CPU physical bits (%u) "
> +                     "to match host CPU physical bits (%u)",
> +                     cpu->phys_bits, host_cpu_phys_bits());
> +        exit(1);

...what about "return -1"?

kvm_init_vcpu() missed a "goto err", but it is not a big deal:

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 9862d8ff1d38..05034f622f20 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -595,6 +595,7 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
         error_setg_errno(errp, -ret,
                          "kvm_init_vcpu: kvm_arch_init_vcpu failed (%lu)",
                          kvm_arch_vcpu_id(cpu));
+        goto err;
     }
     cpu->kvm_vcpu_stats_fd = kvm_vcpu_ioctl(cpu, KVM_GET_STATS_FD, NULL);
---

Overall, LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> +    }
> +
>      return 0;
>  }
>  
> -- 
> 2.34.1
> 
> 

