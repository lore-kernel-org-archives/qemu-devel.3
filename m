Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEF7C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9e4A-0000fr-9L; Tue, 29 Apr 2025 02:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9e47-0000em-NU; Tue, 29 Apr 2025 02:03:36 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9e45-0004Mi-Vf; Tue, 29 Apr 2025 02:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745906614; x=1777442614;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Y/6SsQsFPmZzG1yqe9KNbE234gRASllcF7yURiWMsc4=;
 b=AL7dL8DLEMR56CweMQ61Ri9uM91XGEJhVVI1xaOC2KpO19sSRTW3HIV+
 anPkRyCYVyYhqHCnNv27HBEvedLc+y6GLuxWXv37ZMhgfMHgcc+PeoP47
 qi7HlbHQmAhFiaNI4mjCo7OPAWIdZAOaCSTnG/+MIwKjS3bGRhzB8zNYb
 AktHcKUeoXrVhXOAZut2kNmZVXjRHUnHxHmMX/B4rMBn63qM+2YIA+9v/
 ywVnp2aKZ3b0t+jot3qJB8vWnasTanOftwgksm6cSlop6I290KmwN2Zqy
 sC2h6My8L2nL9q6Jm+B4phLfaw9hzt9W/wer4LYLaCikvpNgTrLZApzLc g==;
X-CSE-ConnectionGUID: JgdG1c/gRlWK87f/iZejLg==
X-CSE-MsgGUID: iHPmttSqT1WgX1Yg3qOhDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58881338"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="58881338"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 23:03:31 -0700
X-CSE-ConnectionGUID: +FC4s7NbQ9O8szr9018u1A==
X-CSE-MsgGUID: btLFCSAaS12P/HF88J38mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="164679601"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 28 Apr 2025 23:03:27 -0700
Date: Tue, 29 Apr 2025 14:24:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 pierrick.bouvier@linaro.org
Subject: Re: [PATCH 3/5] i386/kvm: Support event with select & umask format
 in KVM PMU filter
Message-ID: <aBBwmDnZ5v7tpAkr@intel.com>
References: <20250409082649.14733-1-zhao1.liu@intel.com>
 <20250409082649.14733-4-zhao1.liu@intel.com>
 <87frhwfuv1.fsf@pond.sub.org> <aA3TeaYG9mNMdEiW@intel.com>
 <87h6283g9g.fsf@pond.sub.org> <aA+Ty2IqnE4zQhJv@intel.com>
 <87ldrks17s.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldrks17s.fsf@pond.sub.org>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> > What I'm a bit hesitant about is that, if different arches add similar
> > "conditional" enumerations later, it could cause the enumeration values
> > to change under different compilation conditions (correct? :-)). Although
> > it might not break anything, since we don't rely on the specific numeric
> > values.
> 
> Every binary we create contains target-specific code for at most one
> target.  Therefore, different numerical encodings for different targets
> are fine.
> 
> Same argument for struct members, by the way.  Consider
> 
>     { 'struct': 'CpuModelExpansionInfo',
>       'data': { 'model': 'CpuModelInfo',
>                 'deprecated-props' : { 'type': ['str'],
>                                        'if': 'TARGET_S390X' } },
>       'if': { 'any': [ 'TARGET_S390X',
>                        'TARGET_I386',
>                        'TARGET_ARM',
>                        'TARGET_LOONGARCH64',
>                        'TARGET_RISCV' ] } }
> 
> This generates
> 
>     #if defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
>     struct CpuModelExpansionInfo {
>         CpuModelInfo *model;
>     #if defined(TARGET_S390X)
>         strList *deprecated_props;
>     #endif /* defined(TARGET_S390X) */
>     };
>     #endif /* defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
> 
> The struct's size depends on the target.  If we ever add members after
> @deprecated_props, their offset depends on the target, too.

Thank your for further explanation!

Regards,
Zhao


