Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C5DE7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 07:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ5rr-0004m7-9z; Thu, 05 Dec 2024 02:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ5ro-0004lt-NS
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 02:01:40 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ5rm-0006ie-22
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 02:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733382098; x=1764918098;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6sdAX8j2TLSkPt0XBt4sabqVCqrBqtx/9Ttd1gqRKjc=;
 b=UnvMJ4P84TmP2U+whQn0hcEj1aF1Rjrxi4mqKOD3lLIh3a4vNkP8QWW/
 +LWeP1jB6QKqXfcSF4V+4+y+i3hclm7olPi91BV7KLHZQUvocjQBxaDQT
 UeAwi4rlyv47igZGZd1fzRBR0BBosszFCbhuTndlM4s22tyh0r7/MRTWF
 rX0MKfI/4TpDznVEKc3k1xV1cRUBrs0y0JQQaAaAf6hXPbW9+WZi1fWq2
 4DwvbG24xV2lG6HLDyqYNYmC+zwtLWekwZ1vwPNZAqm/S/6QwWtamsset
 fKVNL7gvr5ZsuQVF2Fv7kOepl7h8XY4n1x8ifDfNbYiOpJk5QE6ZahtHZ w==;
X-CSE-ConnectionGUID: ONTM0YpQQOOOSzb/xRRRHA==
X-CSE-MsgGUID: TN0BEQWyRQ6srkQRSQbq1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33030378"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33030378"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2024 23:01:34 -0800
X-CSE-ConnectionGUID: cYwifOL5TyKNuXDdjPZJzg==
X-CSE-MsgGUID: LEC6o5xfT7KTfb69YvauQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="124817091"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 04 Dec 2024 23:01:28 -0800
Date: Thu, 5 Dec 2024 15:19:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Brian Cain <bcain@quicinc.com>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bmeng.cn@gmail.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v1 2/4] i386/cpu: Set up CPUID_HT in
 x86_cpu_expand_features() instead of cpu_x86_cpuid()
Message-ID: <Z1FUDGnenETEFV6Z@intel.com>
References: <20241108070609.3653085-1-xiaoyao.li@intel.com>
 <20241108070609.3653085-3-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108070609.3653085-3-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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

Hi Xiaoyao,

Sorry for late reply.

> @@ -7490,6 +7489,7 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
>  void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>  {
>      CPUX86State *env = &cpu->env;
> +    CPUState *cs = CPU(cpu);
>      FeatureWord w;
>      int i;
>      GList *l;
> @@ -7531,6 +7531,10 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>          }
>      }
>  
> +    if (cs->nr_cores * cs->nr_threads > 1) {
> +        env->features[FEAT_1_EDX] |= CPUID_HT;
> +    }
> +

We shouldn't place any CLI-configurable features here,
especially after expanding plus_features and minus_features.

HT has been made configurable since the commit 83629b1 ("target/i386/
cpu: Fix CPUID_HT exposure"), so if you want palce HT here, you
should make it un-configurable first.

Regarding commit 83629b1, in what cases do we need to actively set HT?

That commit even introduces more issues. Ideally, the hardware being
emulated by setting or masking feature bits should be feature-consistent.

However, "-cpu *,-ht -smp 2" does not remove the HT flag (which is
unexpected), and "-cpu *,+ht -smp 1" forcibly sets HT (which results in
buggy emulation). :(

In fact, HT should not be freely configurable in hardware emulation;
users should configure it in the BIOS.


>      for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
>          FeatureDep *d = &feature_dependencies[i];
>          if (!(env->features[d->from.index] & d->from.mask)) {
> -- 
> 2.34.1
> 
> 

