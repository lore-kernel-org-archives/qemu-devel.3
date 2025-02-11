Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE36C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 03:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thgn8-0004dU-CI; Mon, 10 Feb 2025 22:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thgn6-0004dE-GL; Mon, 10 Feb 2025 22:18:28 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thgn4-0003uF-Nq; Mon, 10 Feb 2025 22:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739243907; x=1770779907;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=PwcUWeRpOid2El1//cOIHViQXlZ/W85KIlicLI5bwQ4=;
 b=VJ2K22QJedoh2TwWNpvCec0X52KYLFy8g/fR0Abqbx2gGlWPry+XvTne
 R+vcAU4aayg9xIw0Mw6RMTtkVvSDiYqS3xUVl3Rjqwd3WwJ3OsAKordOd
 K0Z6fyF4/0DQxsGV7ivZR5oWYycZoPFePEKL0YynvCYrlQczBTAT6JR5G
 JpOadanWyvRbvrL1DEhNewOVRiJVpPe3rrjq0rgDRBeUlhR4yhRTRC1NN
 75mJNvtHaMRseS5O9t/KsB/FHudHFMhLf+mN4FAwf6drnl+9hjCuZfnvB
 +KnIhY3tC2OpoiT6tWGcwSB/af7q7D1hypTXuHPLK8ZRO5d0MDOtAXMbm w==;
X-CSE-ConnectionGUID: jpa0P4U3TmamoKhJbZyglA==
X-CSE-MsgGUID: pc6lI9wrRmqj4znA2QPKKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39089320"
X-IronPort-AV: E=Sophos;i="6.13,276,1732608000"; d="scan'208";a="39089320"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 19:18:24 -0800
X-CSE-ConnectionGUID: 1Bc2G9O4TAuIiK28zUjxig==
X-CSE-MsgGUID: TM5Q8DW+RB2qzdwEWRpGeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="117581846"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 10 Feb 2025 19:18:24 -0800
Date: Tue, 11 Feb 2025 11:37:54 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 12/12] rust: pl011: convert pl011_create to safe Rust
Message-ID: <Z6rGErQEvuRMba5w@intel.com>
References: <20250207101623.2443552-1-pbonzini@redhat.com>
 <20250207101623.2443552-13-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207101623.2443552-13-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
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

On Fri, Feb 07, 2025 at 11:16:23AM +0100, Paolo Bonzini wrote:
> Date: Fri,  7 Feb 2025 11:16:23 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 12/12] rust: pl011: convert pl011_create to safe Rust
> X-Mailer: git-send-email 2.48.1
> 
> Not a major change but, as a small but significant step in creating
> qdev bindings, show how pl011_create can be written without "unsafe"
> calls (apart from converting pointers to references).
> 
> This also provides a starting point for creating Error** bindings.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 39 ++++++++++++++++----------------
>  rust/qemu-api/src/sysbus.rs      | 34 +++++++++++++++++++++++++---
>  2 files changed, 50 insertions(+), 23 deletions(-)
>

Owned<> uses are proper, so still,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


