Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F74C5516D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wphHb-0002Tv-IJ; Fri, 31 Jul 2026 03:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wphHX-0002Qj-3R
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 03:03:47 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wphHV-0004mj-Nm
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 03:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785481426; x=1817017426;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fsR2QftS0gbhwMDEj+tg6yYm3dWNvlhPmNhkKBZzbtQ=;
 b=C5m7IS2GxIP9cEzHfPKu1KzbwQiuNRGLhU5ZVgBh4I2O3Flb8gk1lFi9
 l97JuTYCE8mIBZqCPhRzQmEvZWWQnVJ5Ug7F/k5u+pevP7rKI0XP+sfAh
 6RHj0Ic/5MgQbf2z0x8k98FTysy4rvlQ9Cl0qSlAgqPoeXJ3L7pL0l3vT
 DU9nnvORuYKmjTZOmIUNdXb74o9+S49dtd3N7R2MKslEQqKNwWeqf3DJj
 gvkoStMJiRN1YwF1Aowyhoy/luK2m2KvRv3yf/O2zmTWg4zmAvNoECf/5
 3PsUF5OsCSeuVPj6W4HF2I5TWjAIV0x83vPaVSGfYq/3yO30UoH5GrFT3 w==;
X-CSE-ConnectionGUID: HPCZdMhhSsS77zbAZJ3Mpw==
X-CSE-MsgGUID: ae9crvmuRjiWo5mWNTjQzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="85231575"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="85231575"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 00:03:44 -0700
X-CSE-ConnectionGUID: uliembHEQvOELL0xelCWMw==
X-CSE-MsgGUID: hRWFoFTbTfGE475h0uzvVQ==
X-ExtLoop1: 1
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by fmviesa003.fm.intel.com with ESMTP; 31 Jul 2026 00:03:42 -0700
Date: Fri, 31 Jul 2026 15:03:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: zhang_wei@open-hieco.net
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v1 2/9] target/i386: Hide Intel cache CPUID leaves for
 Hygon
Message-ID: <amxIzcG2sSLLljng@intel.com>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
 <20260706055530.1752094-3-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706055530.1752094-3-zhang_wei@open-hieco.net>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 06, 2026 at 01:55:23PM +0800, zhang_wei@open-hieco.net wrote:
> Date: Mon,  6 Jul 2026 13:55:23 +0800
> From: zhang_wei@open-hieco.net
> Subject: [PATCH v1 2/9] target/i386: Hide Intel cache CPUID leaves for Hygon
> X-Mailer: git-send-email 2.43.7
> 
> From: Tina Zhang <zhang_wei@open-hieco.net>
> 
> When x-vendor-cpuid-only is enabled, QEMU suppresses CPUID leaves 2
> and 4 for AuthenticAMD CPUs because those leaves describe Intel cache
> information.  Hygon Dhyana uses the HygonGenuine vendor string, so it
> currently skips that filtering and can expose Intel cache leaves together
> with AMD/Hygon extended cache leaves.
> 
> That is inconsistent guest-visible CPUID: Hygon Dhyana provides cache
> information through the extended cache leaves, so it should not also
> advertise the Intel cache descriptor and deterministic cache parameter
> leaves.
> 
> Apply the same leaf 2 and leaf 4 filtering to Hygon CPUs when Hygon
> vendor ABI fixes are enabled.  The property keeps the old CPUID output
> for pc-11.0 and older machine types.
> 
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  target/i386/cpu.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


