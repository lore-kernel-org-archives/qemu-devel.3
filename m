Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1A8CCD188
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6kpj-0005XC-G4; Thu, 09 Oct 2025 03:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pawan.kumar.gupta@linux.intel.com>)
 id 1v6kph-0005X1-15
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:13:01 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pawan.kumar.gupta@linux.intel.com>)
 id 1v6kpb-0008Bg-Rl
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759993976; x=1791529976;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=j8D6lhpn+DvzIQLbN0xjFG5MUcZv6Y4XKehAfbA8pDA=;
 b=Kds5QxO7UgYZirOdtR5hbqg4w30leL50bt/yNfiRsK4nzoS/tkJNGqB/
 Hydkp+8nKXjuyNaWAAdVCViTlJSKXXEQMJDL7aNKQXw5wkyynYg+eI2q+
 ZqBxGoKfJ29ke4mvn+mT7dWS26pt5N3W6X0w06rnSVUqCzAm3UL1VYo4q
 fpdI/RFGisUOc1lPikYB1Wsns9aDiaAf2Fng1PVpSBcxMaZZY23P8aZZa
 DI26gT+XNwhx+aK3ApjCKQPlyJW8dRlvHvpy2biXLA8axtLwwjqH34g+R
 AGQtiyRaCPgTLxsRP54hLNq/NyZNBrEw9PFYdo/PihVHFrgNH/Gnj0Yyg Q==;
X-CSE-ConnectionGUID: D1z0uoZZSuS4YU/2fPlGEw==
X-CSE-MsgGUID: eYwRDgydTfWXglfqdnqLqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="62228447"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; d="scan'208";a="62228447"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 00:12:47 -0700
X-CSE-ConnectionGUID: +dq2x9SWSBuW0bGxn5PcRA==
X-CSE-MsgGUID: 0WFjPuc6TUG7Aps4ldM5Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; d="scan'208";a="180582050"
Received: from guptapa-dev.ostc.intel.com (HELO desk) ([10.54.69.136])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 00:12:47 -0700
Date: Thu, 9 Oct 2025 00:12:39 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH] i386/kvm: Expose ARCH_CAP_FB_CLEAR when invulnerable to
 MDS
Message-ID: <upvij3mabr6bahxotydtuha6hsvfritx7bn3fqyptmk5ckga2k@gcl6mlol2wbx>
References: <20251008202557.4141285-1-jon@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008202557.4141285-1-jon@nutanix.com>
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=pawan.kumar.gupta@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

On Wed, Oct 08, 2025 at 01:25:57PM -0700, Jon Kohler wrote:
> Newer Intel hardware (Sapphire Rapids and higher) sets multiple MDS
> immunity bits in MSR_IA32_ARCH_CAPABILITIES but lacks the hardware-level
> MSR_ARCH_CAP_FB_CLEAR (bit 17):
>     ARCH_CAP_MDS_NO
>     ARCH_CAP_TAA_NO
>     ARCH_CAP_PSDP_NO
>     ARCH_CAP_FBSDP_NO
>     ARCH_CAP_SBDR_SSDP_NO
> 
> This prevents VMs with fb-clear=on from migrating from older hardware
> (Cascade Lake, Ice Lake) to newer hardware, limiting live migration
> capabilities. Note fb-clear was first introduced in v8.1.0 [1].
> 
> Expose MSR_ARCH_CAP_FB_CLEAR for MDS-invulnerable systems to enable
> seamless migration between hardware generations.

LGTM, thanks!

