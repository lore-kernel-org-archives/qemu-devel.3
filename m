Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0D0C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wphMi-0004Z9-W0; Fri, 31 Jul 2026 03:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wphMb-0004Yv-9V
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 03:09:01 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wphMZ-000591-GP
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 03:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785481739; x=1817017739;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ZfkmrXDF8nASwD6vtOWXhAlfiFwV9JT2BPLpEGdXUbw=;
 b=gCRjmPhP8+m9BdjUxZt4u/4JR+xPnVN0bdWJspy84JuyPqUt8+onMs88
 NYGikmi5mduFWFBL2b/Y1EiCre6qFsaJNCUWNHKXmX9Y74LvxxqWugIkQ
 4qtD1i/mLB9qILyXCiAsvdQB7CskgKN10tgPwBgZ7R3NOtn05yVT9lDdB
 QaGDh8E6XHHW9Ra6h2Bj1QmO/glKfrIie3zsn3JfoPSy7bPTLizIb+wKs
 9V0rHh/FpJdwXt8tqTwBsbiVxefYW62IeVJl4THbVkuqK+TeYXDEG4OrW
 N5cSD+MGfsc2XsASxx5rbyPri27AEJMEUkeD6uIplKioE8Pvp9VVrigia g==;
X-CSE-ConnectionGUID: jDkHjHwkT/28Vu5ZjvaH9w==
X-CSE-MsgGUID: lZnEntg0TTGA5ZNdtt1rQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="85978972"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="85978972"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 00:08:57 -0700
X-CSE-ConnectionGUID: aoHWJ+x5T3+SbffF+QVMYA==
X-CSE-MsgGUID: QRd2/T6LTtaZq6qP9/6r9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="259928929"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by orviesa008.jf.intel.com with ESMTP; 31 Jul 2026 00:08:56 -0700
Date: Fri, 31 Jul 2026 15:08:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: zhang_wei@open-hieco.net
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v1 8/9] target/i386: Use AMD legacy cache fallback for
 Hygon
Message-ID: <amxKB6CmYaAvk/CX@intel.com>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
 <20260706055530.1752094-9-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706055530.1752094-9-zhang_wei@open-hieco.net>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
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

On Mon, Jul 06, 2026 at 01:55:29PM +0800, zhang_wei@open-hieco.net wrote:
> Date: Mon,  6 Jul 2026 13:55:29 +0800
> From: zhang_wei@open-hieco.net
> Subject: [PATCH v1 8/9] target/i386: Use AMD legacy cache fallback for Hygon
> X-Mailer: git-send-email 2.43.7
> 
> From: Tina Zhang <zhang_wei@open-hieco.net>
> 
> When legacy-cache=on, x86_cpu_realizefn() builds a hardcoded cache
> model.  It selected the AMD legacy cache table only for CPUs with the
> AuthenticAMD vendor ID.  Dhyana uses the HygonGenuine vendor ID, so this
> explicit compatibility path fell back to QEMU's old Intel legacy cache
> table.
> 
> The wrong table is visible through AMD extended cache leaves.  With the
> Intel legacy table, Dhyana reports 32 KiB, 8-way L1 caches in CPUID
> 0x80000005 and a 4 MiB, 16-way L2 cache in CPUID 0x80000006.  Linux
> uses the AMD/Hygon cache enumeration path for Hygon and reads these AMD
> extended cache leaves.
> 
> Use the AMD legacy cache table for Hygon in this fallback path when the
> new Hygon vendor ABI fixes are enabled.
> Keep the old fallback for pc-11.0 and
> older machine types through x-hygon-vendor-abi-fixes=false.
> 
> The default Dhyana model is unchanged because it provides EPYC cache_info
> and therefore defaults legacy-cache to off.  The guest-visible change is
> limited to users who explicitly configure legacy-cache=on on new machine
> types.
> 
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  target/i386/cpu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


