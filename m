Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98FEC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 12:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5OwU-0002nl-Gx; Fri, 10 May 2024 08:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s5OwP-0002gv-2i
 for qemu-devel@nongnu.org; Fri, 10 May 2024 08:01:34 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s5OwM-0004ec-UC
 for qemu-devel@nongnu.org; Fri, 10 May 2024 08:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715342491; x=1746878491;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Wb9I6qXaHoQLDpLHE1UFUax0yvl+5egVuuHGvO4z590=;
 b=A+nCy0jK28dogAk6VeQnnh6cNTSxIX6IxMhPEbkgke1R/yrfXHmu8uAS
 j8oW8Y3it3ZHl7pT/KgisoKYfeivDsZNYZWjWfDNDrgD3g0FxFfsABBAv
 aNJ5dE1CGK4ThTQEvIafyOW5k37kvP6R0nEBs7Ha+En0ByTnKkBs76jFz
 7j/zZ7iqqxMVSLZVaKzx9/88bCCtGiaT/WPsQNryf6J3iTBiluMc+IZFY
 cMf8EsS+NNVQbS7qzMmn5H6rCxdoieyJWyup/GrPFdQLiu7ehVS7HFvqc
 WIeEQ0DFLH60BnJ6vbtV9MwCCZZ4UxmOP2Ai3VKy2j1YPl8Icwc7pWSAw g==;
X-CSE-ConnectionGUID: X9UQL0uTTlu0N+7ACYbKzQ==
X-CSE-MsgGUID: W1stEccmTaaqc4Ugu/0iBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11152079"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; d="scan'208";a="11152079"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2024 05:01:27 -0700
X-CSE-ConnectionGUID: IHIQmkKMQ/aFnMRYqwvfNw==
X-CSE-MsgGUID: w5K/V3iGRZO2ZsaP1AchpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; d="scan'208";a="60764885"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 10 May 2024 05:01:20 -0700
Date: Fri, 10 May 2024 20:15:34 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com
Subject: Re: [PATCH 08/13] i386: correctly select code in hw/i386 that
 depends on other components
Message-ID: <Zj4P5kiuAPgZoZxU@intel.com>
References: <20240509170044.190795-1-pbonzini@redhat.com>
 <20240509170044.190795-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509170044.190795-9-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.586,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Thu, May 09, 2024 at 07:00:39PM +0200, Paolo Bonzini wrote:
> Date: Thu,  9 May 2024 19:00:39 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 08/13] i386: correctly select code in hw/i386 that depends
>  on other components
> X-Mailer: git-send-email 2.45.0
> 
> fw_cfg.c and vapic.c are currently included unconditionally but
> depend on other components.  vapic.c depends on the local APIC,
> while fw_cfg.c includes a piece of AML builder code that depends
> on CONFIG_ACPI.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/i386/fw_cfg.c    | 2 ++
>  hw/i386/meson.build | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


