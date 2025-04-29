Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B358C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 09:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9hgK-0001Z2-8Z; Tue, 29 Apr 2025 05:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9hgH-0001Xk-Ek
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:55:13 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9hgC-0001sM-Ro
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745920509; x=1777456509;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=OX5FWFVRePN62rny21MpXEwd4sB+zseHcMixBWVS0h8=;
 b=TvkOCU9xYv3basG4pqdRiHg9U9xzYnlWtsS6tRSclpoPrtOzmXN2VUYo
 6uTH63brPruhzxvXi1U94/sfK+HUhAYwP78ZAAM9vuwG4GyUGvraiWna8
 ZhxKfoXkyJckliuUUxAInYcNnZ4miavfpihMDJompOiyNb7KAA3BUdYfF
 7B+EifEtMp8pdDJwLQnVurEQJ+Pk8MB6lnyWO6rzHKJz8gC25KuPwnCco
 F671PHzCQmWIKKcWAyObvsnAYnamtMwq3YpwQVQrDMeE4uw4PGXvFaDiS
 WVV0x78tJncFl/6AT0bSJv2oRQ46TmPSQIun6BR5iQ2ihdhBYgR88ZB+M w==;
X-CSE-ConnectionGUID: EhdT5tllQXKwkyZa9eBLlg==
X-CSE-MsgGUID: DIwbS7c+QnyLXZ1QID9yOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="70037881"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="70037881"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2025 02:55:08 -0700
X-CSE-ConnectionGUID: MPQ/CmP4RhiktHz2Ohpo5g==
X-CSE-MsgGUID: 2H0BIWvRSOKRYtqndPc84A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="138766050"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 29 Apr 2025 02:55:04 -0700
Date: Tue, 29 Apr 2025 18:16:02 +0800
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
Subject: Re: [PATCH v8 37/55] i386/tdx: Disable PIC for TDX VMs
Message-ID: <aBCm4oQWn3WzndlB@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-38-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-38-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
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

On Tue, Apr 01, 2025 at 09:01:47AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:47 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 37/55] i386/tdx: Disable PIC for TDX VMs
> X-Mailer: git-send-email 2.34.1
> 
> Legacy PIC (8259) cannot be supported for TDX VMs since TDX module
> doesn't allow directly interrupt injection.  Using posted interrupts
> for the PIC is not a viable option as the guest BIOS/kernel will not
> do EOI for PIC IRQs, i.e. will leave the vIRR bit set.
> 
> Hence disable PIC for TDX VMs and error out if user wants PIC.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  target/i386/kvm/tdx.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


