Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AF9CAC5B1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 15:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1oJs-0002vk-Dn; Thu, 25 Sep 2025 11:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v1oJq-0002ur-40
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 11:55:42 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v1oJl-0006sX-QH
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 11:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758815737; x=1790351737;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ZjTIS1cmPArdo/fNffduXvO4bwpQS7mGZ23t9iv887M=;
 b=RZrCmO9JJgrNAvkUxM9vycgTofH2a19xlLf5ReORz4UzmzEw4Cljf02o
 fqfC8cMX13mOy4VYDbzzJgBEXbrXJ7Y9G8yk+NJ+YjtavfDQtN3TuMjKP
 1CEdmhxBAcJbLrNaYZdeWDFrUnmzy+r1YP+h7+rT0qwCeD0Z+qq/tgef4
 YqIHCKGMinBPI9mTTMyTRlX4LxY3Fji0QBocFDTAlQ1eE0d5+ZiUDtMuJ
 /akG96DIcZadqYiaB1QSeHyo/r00txtcDiaxiJ2bM/a8IJ8IuJgq6dxVR
 9vRK5H6siaRSPsinTelAm62TynSUqVR3mAxjA2NTaYhV754HPQwgLvFPG Q==;
X-CSE-ConnectionGUID: 4PURw32uS868NwGYgS4Xvg==
X-CSE-MsgGUID: Lr/LUfeXTJSmvo7/O9s9Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="48703471"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="48703471"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 08:55:10 -0700
X-CSE-ConnectionGUID: uGnWCKJqQ6q7/dnnNRiBYQ==
X-CSE-MsgGUID: tYLXBX1dS32WlD9EeaZFAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="182530640"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 25 Sep 2025 08:55:09 -0700
Date: Fri, 26 Sep 2025 00:17:06 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, hector.cao@canonical.com, lk@c--e.de,
 berrange@redhat.com, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [RFT PATCH v2 0/2] Fix cross migration issue with missing
 features: pdcm, arch-capabilities
Message-ID: <aNVrAkx+ahn7ZRns@intel.com>
References: <20250923104136.133875-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923104136.133875-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Tue, Sep 23, 2025 at 12:41:34PM +0200, Paolo Bonzini wrote:
> Date: Tue, 23 Sep 2025 12:41:34 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [RFT PATCH v2 0/2] Fix cross migration issue with missing
>  features: pdcm, arch-capabilities
> X-Mailer: git-send-email 2.51.0
> 
> Add two compatibility properties to restore legacy behavior of machine types
> prior to QEMU 10.1.  Each of them addresses the two changes to CPUID:
> 
> - ARCH_CAPABILITIES should not be autoenabled when the CPU model specifies AMD
>   as the vendor
> 
> - specifying PDCM without PMU now causes an error, instead of being silently
>   dropped in cpu_x86_cpuid.
> 
> Note, I only tested this lightly.

Sorry for late.

I found the previous 2 fixes were merged into stable 10.0:

24778b1c7ee7aca9721ed4757b0e0df0c16390f7
3d26cb65c27190e57637644ecf6c96b8c3d246a3

Should stable 10.0 revert these 2 fixes, to ensure migration
compatibility?

(+Michael)

Regards,
Zhao


