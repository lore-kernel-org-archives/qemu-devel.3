Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519EAC02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 05:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taqF3-0002i5-3m; Thu, 23 Jan 2025 00:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taqF1-0002hk-6X; Thu, 23 Jan 2025 00:58:59 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taqEz-0005wk-Dr; Thu, 23 Jan 2025 00:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737611937; x=1769147937;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Y+f7VfQeGWmWOnT2G8rAtfhA7cECN+MkCr7yLplgx9c=;
 b=m/7fMtrXg3xCZmWCVyUlhup7MMGEZot0nyW2sk7Sh/jvfJbJxd23jM/K
 Z5ylm5yNbsWwAMEMqxg2AsSXlCRBE7q1sDD4Mof/mJXWCP9XlIIbPdBj/
 g2OL1MTjr5BP/ojpH82sui/QmBIuBpkkkCu/kSGGogeIJRi9aGC52UkYY
 HA09R20a8TD0GqJVEkHjy4wK2VrNMRTH7t2upy/tH5S+fg1NOt7D9SrQw
 iffwRTAoJzp3MKPb0nirb+NDn9AsFLrr0ijMdaOAi0On8ZUBe0MKYmcoi
 bcmxDLVX+wdum70JSmiQOtMovcJU1OxmChTNzumLtMdqU53/Byzdg5BHG g==;
X-CSE-ConnectionGUID: lJCkBD58SgyAAfKq6oSdcg==
X-CSE-MsgGUID: yBS5ElZqSM+cBS/L53f3xQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="37356395"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; d="scan'208";a="37356395"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2025 21:58:54 -0800
X-CSE-ConnectionGUID: 1YHOGLV1RReCPPpBwc86XQ==
X-CSE-MsgGUID: hafhHg93SoSZ1J5KjXYABQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="112466182"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 22 Jan 2025 21:58:53 -0800
Date: Thu, 23 Jan 2025 14:18:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 09/10] rust: pl011: pull device-specific code out of
 MemoryRegionOps callbacks
Message-ID: <Z5HfJ8y6HCRY/JW5@intel.com>
References: <20250117092657.1051233-1-pbonzini@redhat.com>
 <20250117092657.1051233-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117092657.1051233-10-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Fri, Jan 17, 2025 at 10:26:56AM +0100, Paolo Bonzini wrote:
> Date: Fri, 17 Jan 2025 10:26:56 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 09/10] rust: pl011: pull device-specific code out of
>  MemoryRegionOps callbacks
> X-Mailer: git-send-email 2.47.1
> 
> read() can now return a simple u64.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs     | 16 +++++++++-------
>  rust/hw/char/pl011/src/memory_ops.rs | 23 ++++-------------------
>  2 files changed, 13 insertions(+), 26 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


