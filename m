Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6584AE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 08:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVR7H-0008Iy-AF; Wed, 08 Jan 2025 03:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tVR7E-0008Im-JZ; Wed, 08 Jan 2025 03:08:36 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tVR7C-0007vf-4e; Wed, 08 Jan 2025 03:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736323715; x=1767859715;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=lTmf6+DEkOT/neIjkMZHZXbCSAiJ0rwmceQ359+peZ0=;
 b=iccTqWPxxVnburGn6ScdvCSuT3UDURFQqgeqGhb7oYQumHmZxu95Jnmn
 x5bGPDJwC6SwaALv+tdQokiNVdZ4+kllwvfWS1lvZd2G7UNreCS8VSlTB
 svJ7q+8hs5EzSmr/dKTkTPejkuaj09R/ShmX8XAa7t+5X1CRtVplQKREe
 YAF8x4VCByN/tbSzro0I8GjhkQ6EEBYGX0eJpsCIx1ewKgB9x70Do1uSf
 UMNHW0DzrMih7FW8MK0eO54UIhBW3CCtWGfzKHFrA6E/CoVIBHVmTe9Q5
 8cE9Yh2DOT6WNbP3w/N3acf6KsUS0C6l42f7vSlLkj4Jr5hSgbviSia4u g==;
X-CSE-ConnectionGUID: g0XEKNLQQS+rI95KjklJbQ==
X-CSE-MsgGUID: BjW0+MsiQGmMrzttfQBo9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="36420437"
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; d="scan'208";a="36420437"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2025 00:08:30 -0800
X-CSE-ConnectionGUID: ySn3r5jNRE6TTdltwiK+/w==
X-CSE-MsgGUID: KRwAdTBxQmiWF+T9kaMaeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; d="scan'208";a="102935581"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 08 Jan 2025 00:08:28 -0800
Date: Wed, 8 Jan 2025 16:27:16 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, junjie.mao@hotmail.com
Subject: Re: [RFC PATCH 8/9] rust: pl011: switch vmstate to new-style macros
Message-ID: <Z3425DPYX2z08Xe1@intel.com>
References: <20241231002336.25931-1-pbonzini@redhat.com>
 <20241231002336.25931-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241231002336.25931-9-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
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

On Tue, Dec 31, 2024 at 01:23:35AM +0100, Paolo Bonzini wrote:
> Date: Tue, 31 Dec 2024 01:23:35 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [RFC PATCH 8/9] rust: pl011: switch vmstate to new-style macros
> X-Mailer: git-send-email 2.47.1
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs       |  3 ++-
>  rust/hw/char/pl011/src/device_class.rs | 36 +++++++++++++-------------
>  rust/hw/char/pl011/src/lib.rs          |  6 +++++
>  3 files changed, 26 insertions(+), 19 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


