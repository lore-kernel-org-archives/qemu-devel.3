Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C31FC7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 08:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWsaw-0007Iz-3g; Wed, 02 Jul 2025 04:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uWsai-0007Gy-Um; Wed, 02 Jul 2025 04:13:20 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uWsae-0001QM-TK; Wed, 02 Jul 2025 04:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751443993; x=1782979993;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=pqKQoXF566I3jN7jBYoVqec+bIUayudHtA0Prhir1Lk=;
 b=MbR5n2ePimLOjDPwEHB9AmNV9llXDv9/5B6rC9h41hzpZ/kweYGnm5pz
 hElA7m/x4ttCpuahvgSDzlPXDwMBKLXces0BKBeSTu+ZoA3kINcSC5ink
 qd8ZXiQcad4nfip61S1Q28TNXs0hupp+JqAdioyENV/OgA7VN5xP179v5
 6npnSsiNYYwBbwtDJ/cpzjNWDvsQ5aHgmtUWS8fMTcOMrTutDhWIzfarr
 zC+F+WHx+9cxwAP404zQ6YyxdwnfRvrH3tC/J2wrDXTAifIoITBja8P6w
 5ldKTBAVvNEa9HMxDLmCuOFw2jTLQ+1h/zfEnRQvaXoOm4LpMjahjzRvq A==;
X-CSE-ConnectionGUID: 3r7ie9RrSmqwH/NGnowqSA==
X-CSE-MsgGUID: rESAzTOOTY+GPpOtIHIzlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53821377"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="53821377"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 01:13:08 -0700
X-CSE-ConnectionGUID: 6z/xjzRbToaDXZD/mBpeLw==
X-CSE-MsgGUID: G+Ui2uqNQlmmGX/qhD8vzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="159524773"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 02 Jul 2025 01:13:04 -0700
Date: Wed, 2 Jul 2025 16:34:29 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-stable@nongnu.org,
 boris.ostrovsky@oracle.com, maciej.szmigiero@oracle.com,
 Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Subject: Re: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be advertised on
 AMD
Message-ID: <aGTvFbqLKcG1wLqO@intel.com>
References: <20250630133025.4189544-1-alexandre.chartre@oracle.com>
 <aGO3vOfHUfjgvBQ9@intel.com>
 <c6a79077-024f-4d2f-897c-118ac8bb9b58@intel.com>
 <aGPWW/joFfohy05y@intel.com> <20250701150500.3a4001e9@fedora>
 <aGQ-ke-pZhzLnr8t@char.us.oracle.com> <aGS9E6pT0I57gn+e@intel.com>
 <f1d53417-4dce-43e8-a647-74fbc5c378cb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1d53417-4dce-43e8-a647-74fbc5c378cb@intel.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> I think we need firstly aligned on what the behavior of the Windows that hit
> "unsupported processor" is.
> 
> My understanding is, the Windows is doing something like
> 
> 	if (is_AMD && CPUID(arch_capabilities))
> 		error(unsupported processor)

This is just a guess; it's also possible that Windows checked this MSR
and found the necessary feature missing. Windows 11 has very strict
hardware support requirements.

> And I think this behavior is not correct.
> 
> However, it seems not the behavior of the Windows from your understanding.
> So what's the behavior in you mind?

Guessing and discussing what Windows' code actually does is unlikely to
yield results. It's closed-source, and even if someone knows the answer,
he probably won't disclose it due to contractual restrictions.

Thanks,
Zhao


