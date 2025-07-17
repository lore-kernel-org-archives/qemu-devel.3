Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34ADEC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 03:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucFbg-0000ks-O4; Wed, 16 Jul 2025 23:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ucFbF-0008VZ-8X; Wed, 16 Jul 2025 23:48:04 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ucFb8-0001Pq-QV; Wed, 16 Jul 2025 23:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752724075; x=1784260075;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=x95USqEUAJ3TfizX9RllSBsZQAaFZdyA5zxrXmDLHNI=;
 b=RzwRMmPE1Qhw072ha5rJ18Wo9g3NzC/TrXdu9/7Ydb2TUDhgdyH+MGel
 mrZYrf8WJOdbxaTUjZx87FYisx/KPLxUJklEILk9aSvDHbUegMQe0Lp+x
 1sfPWotqmNhNxevBOVMofiqcOvIVxG6363hayAOgiIzd9wPYFmhPjm4Iq
 XHWcaItY43OaJmt+gQ8PFh4vrSyddB2/RhkJ8xkJJ8EhI/u6hFz/q49BJ
 TN9pJi7y3r3DobGyopndLZMe1aP4z0SlcruyOxLLfh/iajaLiI0Sm6kUg
 uzmvBmIhYGC78FowDQdRIqcYY3a/cYrOlAcQG4IowwxvVnq+a0xBUTImy w==;
X-CSE-ConnectionGUID: IW45Z3+JT6u1SNhIGApYew==
X-CSE-MsgGUID: hjj23v8mSwC+x2NeV1V6MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="66435409"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; d="scan'208";a="66435409"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 20:47:52 -0700
X-CSE-ConnectionGUID: QzLVpvMNS/m6ZiL4fLtGYQ==
X-CSE-MsgGUID: UB4VuYZ3QUWFkTUMMehfXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; d="scan'208";a="181366622"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 16 Jul 2025 20:47:49 -0700
Date: Thu, 17 Jul 2025 12:09:20 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, Chuang Xu <xuchuangxclwt@bytedance.com>,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v2 4/7] i386/cpu: Fix number of addressable IDs field for
 CPUID.01H.EBX[23:16]
Message-ID: <aHh3cFxaf3SeLFVe@intel.com>
References: <20250714080859.1960104-1-zhao1.liu@intel.com>
 <20250714080859.1960104-5-zhao1.liu@intel.com>
 <33497cb5-037b-4656-bd8d-6310c7c03e65@tls.msk.ru>
 <aHhosJ/VWEyjwQDc@intel.com>
 <2d8fe938-3148-470f-b2d2-8eb60c67aeb1@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d8fe938-3148-470f-b2d2-8eb60c67aeb1@tls.msk.ru>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
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

> This makes sense.
> 
> In this case though, the next patch, a62fef5829956 "i386/cpu: Fix cpu
> number overflow in CPUID.01H.EBX[23:16]", becomes a one-liner:
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 2c9517f56d..5e55dd9ee5 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6828,7 +6828,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index,
> uint32_t count,
>          }
>          *edx = env->features[FEAT_1_EDX];
>          if (threads_per_pkg > 1) {
> -            *ebx |= threads_per_pkg << 16;
> +            /* Fixup overflow: max value for bits 23-16 is 255. */
> +            *ebx |= MIN(threads_per_pkg, 255) << 16;
>          }
>          if (!cpu->enable_pmu) {
>              *ecx &= ~CPUID_EXT_PDCM;
> 
> Is it okay with you, or maybe should I drop this change for 10.0.x
> too?

Yes, it's okay. This commit I should have cc'd stable, as it is indeed a
reported bug.

And after this commit, there're another 2 commits to avoid overflow:

* commit 3e86124e7cb9 ("i386/cpu: Fix overflow of cache topology fields
  in CPUID.04H")
* commit 5d21ee453ad8 ("i386/cpu: Honor maximum value for CPUID.
  8000001DH.EAX[25:14]")

I think these two could also be stable v10.0.x materials.

Thanks,
Zhao



