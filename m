Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D85EC0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thUel-0004Hw-Ld; Mon, 10 Feb 2025 09:21:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thUej-0004Cw-D0; Mon, 10 Feb 2025 09:21:01 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thUef-0006Xe-U2; Mon, 10 Feb 2025 09:21:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739197258; x=1770733258;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=sYbTlx77q+ft32PSThKf42Jf95f3ZBTqng6r3Qc2hXU=;
 b=Dj8LG4WTIEBpEIIuzARV5+HsIfg8yJ876jYnnKiSzP7ijyMfuZQEgFkt
 D9abAZFE7WDiV1P+llmtdOW/qDcMoyRUMyE7U/OOP2Mx/8nQlkcELMLWr
 0qgZrUJCnrmngD+hF2NM2NzoULAcHz+tpHrKjHQwcxawgDHOCURigmwnk
 DEB2kkvdQuOsqgLmxYJcyqBgbXYQ9BL+SvgHUPo+xL788JPxwS5FLgowl
 QzUyK2p0QRjyrB2QV7s/G3JvBhUqHQfump9CLA+EoiLxDwa69SKenEh88
 ZpM92F50YCtZ7jwhrOi2X6y1s3s3sq/pC/UjjmnAX8arFQ7gTjMerThd5 A==;
X-CSE-ConnectionGUID: 2nz94KCbRA6sTh+aMPiStw==
X-CSE-MsgGUID: 84KmWp5BTpWvbqZQJqCUOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="50010932"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; d="scan'208";a="50010932"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 06:20:54 -0800
X-CSE-ConnectionGUID: lVKNosY/TX680ICYIJC4fw==
X-CSE-MsgGUID: xwB0cp5zR7yOfUFs29NXBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="117129848"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 10 Feb 2025 06:20:52 -0800
Date: Mon, 10 Feb 2025 22:40:23 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 04/12] rust: qdev: add clock creation
Message-ID: <Z6oP18+J96S0BS90@intel.com>
References: <20250207101623.2443552-1-pbonzini@redhat.com>
 <20250207101623.2443552-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207101623.2443552-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
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

On Fri, Feb 07, 2025 at 11:16:15AM +0100, Paolo Bonzini wrote:
> Date: Fri,  7 Feb 2025 11:16:15 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 04/12] rust: qdev: add clock creation
> X-Mailer: git-send-email 2.48.1
> 
> Add a Rust version of qdev_init_clock_in, which can be used in
> instance_init.  There are a couple differences with the C
> version:
> 
> - in Rust the object keeps its own reference to the clock (in addition to
>   the one embedded in the NamedClockList), and the reference is dropped
>   automatically by instance_finalize(); this is encoded in the signature
>   of DeviceClassMethods::init_clock_in, which makes the lifetime of the
>   clock independent of that of the object it holds.  This goes unnoticed
>   in the C version and is due to the existence of aliases.
> 
> - also, anything that happens during instance_init uses the pinned_init
>   framework to operate on a partially initialized object, and is done
>   through class methods (i.e. through DeviceClassMethods rather than
>   DeviceMethods) because the device does not exist yet.  Therefore, Rust
>   code *must* create clocks from instance_init, which is stricter than C.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs |  43 +++++-------
>  rust/qemu-api/src/prelude.rs     |   2 +
>  rust/qemu-api/src/qdev.rs        | 109 ++++++++++++++++++++++++++++++-
>  rust/qemu-api/src/vmstate.rs     |   4 +-
>  4 files changed, 127 insertions(+), 31 deletions(-)
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


