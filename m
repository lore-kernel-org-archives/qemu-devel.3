Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A29C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 15:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7FJL-0006dA-0U; Tue, 22 Apr 2025 11:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7FJJ-0006cu-PP
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:13:21 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7FJG-0007Xj-5f
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745334798; x=1776870798;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1drrdCAmwb3narJADwcS2D25pameaxuO+A5f3IqyxOE=;
 b=Su/t/oZk5QmsVWDJccXKmGNCh9e2/aGztD69HalNQylmxcbfGKBtE+M+
 yWB78m0PLwyjCj357PGUfjQQtxHWWuDANZ52fA9+B9DSFqmMwYGBv2W4o
 Qg3TQsW2P8UaQqFYHGmSzj3FNVqy6dAXZp+/AqdCMJvMRrZBCtiuivl2z
 vs/kel6yFeKUXc5id10YP/BlDr73KXZrAQIJghuPqnllRmwEdgeFOVtH5
 u3ijZfSFDDmMhDfZXJaX3WsPE+ymWpywuoysm7yhj3zsrBuoiBHIczLvr
 ZzlcTyv9HMn4rL5C9NU1JqyY5WOjJWH+eqYAvmnz8+LEDCPOTUUlRyim9 g==;
X-CSE-ConnectionGUID: xcKJ+hFsRDyjzdDfi9hSeg==
X-CSE-MsgGUID: bzG/h1VaSF2pPv2KnH/Tuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="50728047"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="50728047"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2025 08:13:13 -0700
X-CSE-ConnectionGUID: C6s88iQGQcWCqViOgSPMqw==
X-CSE-MsgGUID: cX8h6PdXSmSvgiANRMUkAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="155237267"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 22 Apr 2025 08:13:10 -0700
Date: Tue, 22 Apr 2025 23:34:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 08/55] i386/tdx: Initialize TDX before creating TD vcpus
Message-ID: <aAe27bMcwIwpDB6m@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-9-xiaoyao.li@intel.com>
 <Z-0iV-xIeu0hoaaC@redhat.com>
 <54c19255-0b05-4f50-83a5-256567724df4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54c19255-0b05-4f50-83a5-256567724df4@intel.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

> > > +int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
> > > +{
> > > +    X86CPU *x86cpu = X86_CPU(cpu);
> > > +    CPUX86State *env = &x86cpu->env;
> > > +    g_autofree struct kvm_tdx_init_vm *init_vm = NULL;
> > > +    Error *local_err = NULL;
> > > +    int retry = 10000;
> > > +    int r = 0;
> > > +
> > > +    QEMU_LOCK_GUARD(&tdx_guest->lock);
> > > +    if (tdx_guest->initialized) {
> > > +        return r;
> > > +    }
> > > +
> > > +    init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
> > > +                        sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
> > > +
> > > +    r = setup_td_xfam(x86cpu, errp);
> > > +    if (r) {
> > > +        return r;
> > > +    }
> > > +
> > > +    init_vm->cpuid.nent = kvm_x86_build_cpuid(env, init_vm->cpuid.entries, 0);
> > > +    tdx_filter_cpuid(&init_vm->cpuid);
> > > +
> > > +    init_vm->attributes = tdx_guest->attributes;
> > > +    init_vm->xfam = tdx_guest->xfam;
> > > +
> > > +    /*
> > > +     * KVM_TDX_INIT_VM gets -EAGAIN when KVM side SEAMCALL(TDH_MNG_CREATE)
> > > +     * gets TDX_RND_NO_ENTROPY due to Random number generation (e.g., RDRAND or
> > > +     * RDSEED) is busy.
> > > +     *
> > > +     * Retry for the case.
> > > +     */
> > > +    do {
> > > +        error_free(local_err);
> > > +        local_err = NULL;
> > > +        r = tdx_vm_ioctl(KVM_TDX_INIT_VM, 0, init_vm, &local_err);
> > > +    } while (r == -EAGAIN && --retry);
> > > +
> > > +    if (r < 0) {
> > > +        if (!retry) {
> > > +            error_report("Hardware RNG (Random Number Generator) is busy "
> > > +                         "occupied by someone (via RDRAND/RDSEED) maliciously, "
> > > +                         "which leads to KVM_TDX_INIT_VM keeping failure "
> > > +                         "due to lack of entropy.");
> > 
> > This needs to be
> > 
> >       error_append_hint(local_err, ....);
> > 
> > so that this message gets associated with the error object that
> > is propagated, and the top level will print it all at once.
> 
> Good suggestion! Will change to it in the next version.

A little suggestion:

With error_append_hint(local_err, ...), you can add "ERRP_GUARD()" at
the beginning of tdx_pre_create_vcpu(), just like the commit 95e9053a34ca.



