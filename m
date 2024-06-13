Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9ADC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 06:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHe24-000727-Us; Thu, 13 Jun 2024 02:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sHe22-00071k-DP
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 02:33:58 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sHe1z-0000Hm-D4
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 02:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718260436; x=1749796436;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=bv8zXqqzoxL1cfR9kD8+nJ2IEnCJ/inoLv/HgcT04Q4=;
 b=jskqSfaIVS8xpsJOQpcw+8I69hTgAdNZoIju8LuOgytqDhNSYFn6QZGv
 K8rtNrJEJZwjjMjhdtGB/GOxLDQMWzS9wl+u+UvY9jhG7bQ6q9q7m65Jd
 fqtagiQcMAz7GD7N2ufn1sB+P9qE2QFB6uvSfsxEBoEB5JnIOovZz8WHx
 HkOOK2dB65R5N0S+1HLLATjlVIeufhsr8iTyLfc8t+4dRwsrj3NnsG7p5
 q1l27KZ1Eem/gsW5X0FvZEMFEEUZKBrfQKFI89wgN1Wdrh+OriWcNjDIW
 26re2yDlQwP5nPg7ex0v2iYDxEGvFtyIOYyUWoou1JYlxWroel390hJ5B Q==;
X-CSE-ConnectionGUID: qOxf8i3sQH2jTuxJ6Tm/0A==
X-CSE-MsgGUID: gQCZpp7NQFevCiwxI1xsig==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="26480967"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="26480967"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2024 23:33:47 -0700
X-CSE-ConnectionGUID: KmH9BOYYToO1/cIKx9dJ8Q==
X-CSE-MsgGUID: wHMUvk+3QkWVjt+REjbq6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="44568066"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 12 Jun 2024 23:33:45 -0700
Date: Thu, 13 Jun 2024 14:49:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Babu Moger <babu.moger@amd.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH 1/4] i386/cpu: Add RAS feature bits on EPYC CPU models
Message-ID: <ZmqWatuwNiYdaG7S@intel.com>
References: <cover.1718218999.git.babu.moger@amd.com>
 <9bba9cbb783da2eaee4e385bf3d93b7cac2c8c77.1718218999.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bba9cbb783da2eaee4e385bf3d93b7cac2c8c77.1718218999.git.babu.moger@amd.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jun 12, 2024 at 02:12:17PM -0500, Babu Moger wrote:
> Date: Wed, 12 Jun 2024 14:12:17 -0500
> From: Babu Moger <babu.moger@amd.com>
> Subject: [PATCH 1/4] i386/cpu: Add RAS feature bits on EPYC CPU models
> X-Mailer: git-send-email 2.34.1
> 
> Add the support for following RAS features bits on AMD guests.
> 
> SUCCOR: Software uncorrectable error containment and recovery capability.
> 	The processor supports software containment of uncorrectable errors
> 	through context synchronizing data poisoning and deferred error
> 	interrupts.
> 
> McaOverflowRecov: MCA overflow recovery support.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  target/i386/cpu.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


