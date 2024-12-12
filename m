Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0321E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 17:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLmvi-0001aZ-2t; Thu, 12 Dec 2024 12:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1tLmvH-0001El-Ib
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:24:25 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1tLmvF-0006v3-3D
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734024261; x=1765560261;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ZN9iIEDIb+qeXTusHRIG1A2JOHVdIqP6CkyHsmJ9ujM=;
 b=CQLRgsKN6An06X3ImFLB77wTdPNa5DQ5e/KSjI+hIPauNg0cxGM/Zaeq
 ut3kYmNaxhQNtBZpTLc374k4iVLCOHu/3TVJyfoM6Hrtvu5OnSVE4PiiS
 N8WzwwW9N6WDY21lzznQNxyxQX/5bteEKqXz14urcm9lVZQ1fjUvI6Rx6
 6kKYVOAjkoNOgJ0kxR3QxqSqFpbQ/XMwvdV8S58nQ7NCJGQAqBsVE5n27
 Xs7cMyHuoEen5gZUY1UHH9rEiAevYCBTYm7tJmCmhCsDyXOxVqSEZ6NeU
 Y2VGqMCy+fmOU8p2Oq6cNae7LiQWhLEepyOP8NKAPzCd6q3pn+qEBFpT+ Q==;
X-CSE-ConnectionGUID: DIRTV2HvTX6Z3DH5gyyQFQ==
X-CSE-MsgGUID: ZLCwn8kqRW2QcxYkrRUShQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="38241597"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; d="scan'208";a="38241597"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 09:24:16 -0800
X-CSE-ConnectionGUID: WAHnGzjwQpGSyx05PFjkYQ==
X-CSE-MsgGUID: eSvjt7GoRFe113nOgoiflQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="127292779"
Received: from puneetse-mobl.amr.corp.intel.com (HELO localhost)
 ([10.125.110.112])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 09:24:08 -0800
Date: Thu, 12 Dec 2024 11:24:03 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "Liu, Zhao1" <zhao1.liu@intel.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "anisinha@redhat.com" <anisinha@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "wangyanan55@huawei.com" <wangyanan55@huawei.com>,
 "berrange@redhat.com" <berrange@redhat.com>
Subject: Re: [PATCH v6 09/60] i386/tdx: Initialize TDX before creating TD vcpus
Message-ID: <Z1scMzIdT2cI4F5T@iweiny-mobl>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-10-xiaoyao.li@intel.com>
 <1235bac6ffe7be6662839adb2630c1a97d1cc4c5.camel@intel.com>
 <c0ef6c19-756e-43f3-8342-66b032238265@intel.com>
 <Zyr7FA10pmLhZBxL@tlindgre-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zyr7FA10pmLhZBxL@tlindgre-MOBL1>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=ira.weiny@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
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

On Wed, Nov 06, 2024 at 07:13:56AM +0200, Tony Lindgren wrote:
> On Wed, Nov 06, 2024 at 10:01:04AM +0800, Xiaoyao Li wrote:
> > On 11/6/2024 4:51 AM, Edgecombe, Rick P wrote:
> > > +Tony
> > > 
> > > On Tue, 2024-11-05 at 01:23 -0500, Xiaoyao Li wrote:
> > > > +int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
> > > > +{
> > > > +    X86CPU *x86cpu = X86_CPU(cpu);
> > > > +    CPUX86State *env = &x86cpu->env;
> > > > +    g_autofree struct kvm_tdx_init_vm *init_vm = NULL;
> > > > +    int r = 0;
> > > > +
> > > > +    QEMU_LOCK_GUARD(&tdx_guest->lock);
> > > > +    if (tdx_guest->initialized) {
> > > > +        return r;
> > > > +    }
> > > > +
> > > > +    init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
> > > > +                        sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
> > > > +
> > > > +    r = setup_td_xfam(x86cpu, errp);
> > > > +    if (r) {
> > > > +        return r;
> > > > +    }
> > > > +
> > > > +    init_vm->cpuid.nent = kvm_x86_build_cpuid(env, init_vm->cpuid.entries, 0);
> > > > +    tdx_filter_cpuid(&init_vm->cpuid);
> > > > +
> > > > +    init_vm->attributes = tdx_guest->attributes;
> > > > +    init_vm->xfam = tdx_guest->xfam;
> > > > +
> > > > +    do {
> > > > +        r = tdx_vm_ioctl(KVM_TDX_INIT_VM, 0, init_vm);
> > > > +    } while (r == -EAGAIN);
> > > 
> > > KVM_TDX_INIT_VM can also return EBUSY. This should check for it, or KVM should
> > > standardize on one for both conditions. In KVM, both cases handle
> > > TDX_RND_NO_ENTROPY, but one tries to save some of the initialization for the
> > > next attempt. I don't know why userspace would need to differentiate between the
> > > two cases though, which makes me think we should just change the KVM side.
> > 
> > I remember I tested retrying on the two cases and no surprise showed.
> > 
> > I agree to change KVM side to return -EAGAIN for the two cases.
> 
> OK yeah let's patch KVM for it.

Will the patch to KVM converge such that it is ok for qemu to loop forever?

Ira

> 
> Regards,
> 
> Tony

