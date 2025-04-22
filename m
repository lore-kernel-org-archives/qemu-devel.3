Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3528C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7EA1-0005VQ-16; Tue, 22 Apr 2025 09:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7E9z-0005Uy-6I
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 09:59:39 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7E9v-0006Hl-P3
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 09:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745330376; x=1776866376;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WtmWnebD8AB2nDZRGnvV5l5+j1oRf8uBgW1ZPekGEXo=;
 b=dF4775DNiSUZnh/RsTA9+YO2jXvljhuoBpkwSyzt4eKNsQow/M0HNUij
 MXNMUirZNZGvCt1pLfOYhGlL6nuV6X7BG0NCdEOG6JWhjx5NDCGAXISav
 WqFrXR7CtWSC8d2I1fIJhLfHb33kT/m9OYDYfjZVk2n+D9f5iJlDIfyF/
 ZQ2AgF3BmNz6l/LiyhLtCxAy8Txs9tO6gsNg+Iqdts3ssA/aFSVQqGq5V
 wIXFCQA3WU7h0PxvY7gj6QTlUD06P5p8hiq87K6CMS3ECwtJugpYS0g/d
 2//aw8/aB/NKsk5U4/gbspp5rQ2O0OtynO0u7M03D10R0RC7AG18oci0s Q==;
X-CSE-ConnectionGUID: 1Cdgf0FeRnSAZxqzU71y0w==
X-CSE-MsgGUID: eQjam/4LQZehH+fiVvDHYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="49552378"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="49552378"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2025 06:59:32 -0700
X-CSE-ConnectionGUID: xmYhynjBRjStBhdh6T/T0Q==
X-CSE-MsgGUID: pTo0aIktSrOhNbt448+5ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="131869035"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 22 Apr 2025 06:59:29 -0700
Date: Tue, 22 Apr 2025 22:20:24 +0800
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
Subject: Re: [PATCH v8 06/55] i386/tdx: Introduce is_tdx_vm() helper and
 cache tdx_guest object
Message-ID: <aAelqKOePQ9gplDm@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-7-xiaoyao.li@intel.com>
 <aAIfL0jS0lWSpvZE@intel.com>
 <12ec4e5c-33af-47a0-817f-b1fd0420f8f5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12ec4e5c-33af-47a0-817f-b1fd0420f8f5@intel.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

> > > +#ifdef CONFIG_TDX
> > > +bool is_tdx_vm(void);
> > > +#else
> > > +#define is_tdx_vm() 0
> > > +#endif /* CONFIG_TDX */
> > > +
> > a little nit: could we rename it as "tdx_enabled"?
> > 
> > Then the cases like these would be neater?
> 
> When sev support was added, it was seen as a feature for the VMs that are
> created on AMD platform. I think that's why it got called sev_enabled().
> 
> But for TDX, it is introduced as a different type of VM in contrast to the
> legacy/normal VMX VMs. We need to pass specific TDX vm type to
> KVM_CREATE_VM. Based on this, is_tdx_vm() was chosen.

But isn't AMD's SEV also defined as the VM type?

static const char *vm_type_name[] = {
    [KVM_X86_DEFAULT_VM] = "default",
    [KVM_X86_SEV_VM] = "SEV",
    [KVM_X86_SEV_ES_VM] = "SEV-ES",
    [KVM_X86_SNP_VM] = "SEV-SNP",
    [KVM_X86_TDX_VM] = "TDX",
};

Functionally, they are part of the coco functionality provided by
different vendors, so it's better thatt both could be in the same place
as much as possible, including file location, naming style. Of course,
it's not a big deal, and it can be cleaned up after merge if needed.

> I don't think the different name is a big issue, as nobody mentions it from
> the initial RFC to current v8 until you.

The Chinese saying: There are a thousand Hamlets in a thousand people's
eyes :-).


