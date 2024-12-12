Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6160AE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 22:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLrIu-00018h-Dg; Thu, 12 Dec 2024 17:05:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1tLrIm-000187-SR
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 17:04:57 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1tLrIj-0005xb-GY
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 17:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734041094; x=1765577094;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=fcLqNUWXZKdJqXPcRRGkSkyE41XaNnf3cqr6Sktyuwg=;
 b=kstg2aTD75S36zxYXS6GhHKY1Iw/xxFKZk4hOCrwEZifediUDSgLxsmI
 lwVa8dzVaMP4RJlv/TYqinXz7jITJzf5GAt3Buo5VzUDXUWNdRRulRpz1
 4q6AV4W3WDpewt8iGjSlm/Z7D4o/AdAWCwU3Rce27hlGPwupksr5o9Hte
 AnfRbA4BMJ823sGTbtlvXw+M76VGVEVpJSNcoIN0+b1Zt/vTNdgLn61s4
 nJyNZ2w1eM84bMoTyI8rcQWFCGayE7SqGeICLv2q5vZumF7Cur5eZNNGi
 7Aczwz3Lyt/LjXzU8mCwgXTz77S/DfxEw2NccHjB3LttqnOJb0KDGr8FC A==;
X-CSE-ConnectionGUID: Gn7SLOJ/RFKtywrylhbx3g==
X-CSE-MsgGUID: axdsQOojQqe/GGEZ7hF6wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34614681"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; d="scan'208";a="34614681"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 14:04:49 -0800
X-CSE-ConnectionGUID: q2EolBEBSMe+Nve+GU6ohA==
X-CSE-MsgGUID: xqpa35YQRpCHDYTgrkEiCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; d="scan'208";a="96589080"
Received: from puneetse-mobl.amr.corp.intel.com (HELO localhost)
 ([10.125.110.112])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 14:04:47 -0800
Date: Thu, 12 Dec 2024 16:04:44 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 34/60] i386/tdx: implement tdx_cpu_realizefn()
Message-ID: <Z1td_BZPlZ5G9Zaq@iweiny-mobl>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-35-xiaoyao.li@intel.com>
 <82b74218-f790-4300-ab3b-9c41de1f96b8@redhat.com>
 <2bedfcda-c2e7-4e5b-87a7-9352dfe28286@intel.com>
 <44627917-a848-4a86-bddb-20151ecfd39a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44627917-a848-4a86-bddb-20151ecfd39a@redhat.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=ira.weiny@intel.com;
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

On Tue, Nov 05, 2024 at 12:53:25PM +0100, Paolo Bonzini wrote:
> On 11/5/24 12:38, Xiaoyao Li wrote:
> > On 11/5/2024 6:06 PM, Paolo Bonzini wrote:
> > > On 11/5/24 07:23, Xiaoyao Li wrote:
> > > > +static void tdx_cpu_realizefn(X86ConfidentialGuest *cg, CPUState *cs,
> > > > +                              Error **errp)
> > > > +{
> > > > +    X86CPU *cpu = X86_CPU(cs);
> > > > +    uint32_t host_phys_bits = host_cpu_phys_bits();
> > > > +
> > > > +    if (!cpu->phys_bits) {
> > > > +        cpu->phys_bits = host_phys_bits;
> > > > +    } else if (cpu->phys_bits != host_phys_bits) {
> > > > +        error_setg(errp, "TDX only supports host physical bits (%u)",
> > > > +                   host_phys_bits);
> > > > +    }
> > > > +}
> > > 
> > > This should be already handled by host_cpu_realizefn(), which is
> > > reached via cpu_exec_realizefn().
> > > 
> > > Why is it needed earlier, but not as early as instance_init?  If
> > > absolutely needed I would do the assignment in patch 33, but I don't
> > > understand why it's necessary.
> > 
> > It's not called earlier but right after cpu_exec_realizefn().
> > 
> > Patch 33 adds x86_confidenetial_guest_cpu_realizefn() right after
> > ecpu_exec_realizefn(). This patch implements the callback and gets
> > called in x86_confidenetial_guest_cpu_realizefn() so it's called after
> > cpu_exec_realizefn().
> > 
> > The reason why host_cpu_realizefn() cannot satisfy is that for normal
> > VMs, the check in cpu_exec_realizefn() is just a warning and QEMU does
> > allow the user to configure the physical address bit other than host's
> > value, and the configured value will be seen inside guest. i.e., "-cpu
> > phys-bits=xx" where xx != host_value works for normal VMs.
> > 
> > But for TDX, KVM doesn't allow it and the value seen in TD guest is
> > always the host value.  i.e., "-cpu phys-bits=xx" where xx != host_value
> > doesn't work for TDX.
> > 
> > > Either way, the check should be in tdx_check_features.
> > 
> > Good idea. I will try to implement it in tdx_check_features()

Is there any reason the TDX code can't just force cpu->host_phys_bits to true?

> 
> Thanks, and I think there's no need to change cpu->phys_bits, either. So
> x86_confidenetial_guest_cpu_realizefn() should not be necessary.

I was going to comment that patch 33 should be squashed here but better to just
drop it.

Ira

> 
> Paolo
> 

