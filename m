Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AE9E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 08:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLf0X-0005UD-OO; Thu, 12 Dec 2024 03:57:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLf0V-0005TK-9v; Thu, 12 Dec 2024 03:57:15 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLf0S-0003fQ-9s; Thu, 12 Dec 2024 03:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733993833; x=1765529833;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Wbwd++wwkn1Mj3aQSNGe3XqFI2JDXUXwmz5MPa6CSOw=;
 b=FIF3zz7DzzG7DW8/vA/pqs24eoVRBGNCiRo7va4fTGtC0ZmFN/1jIug9
 HCzM/rdZNaYwdoZAYox0wKWjjjrsrXIj5IGpJD3ReXaO+ZqwEjqc1vCxQ
 36dDmpTEYYg1wdEXb0O3Y8GGOSVM5pWANwt5Jd0ctsB2pu3Jw/t0U072I
 vGdZOSe/X9WIXgtEfnuBpPHuPs1EskBGwtw/qI7B83NVzL11yQLFwDtb3
 qanMEnEceZI5SsLcNGZYd4AGu1nmFV5Ek384Wzjl9sWeMIqySiRUN7B1f
 Ue71mgKZMYw+eFTq6pBQ4AOegRyiqowSWU0nGe0MVDwhuhLiNGyqDBWUR Q==;
X-CSE-ConnectionGUID: SPCl93BFTjS3s8w+wjdpEg==
X-CSE-MsgGUID: lWQC01mkQAydFlavhgQ9tQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="38184634"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; d="scan'208";a="38184634"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 00:57:09 -0800
X-CSE-ConnectionGUID: qhCk3v74TLO4ATFF3AYsHg==
X-CSE-MsgGUID: +wPK0zIxRAG+fAFaaRL43w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; d="scan'208";a="101026587"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 12 Dec 2024 00:57:07 -0800
Date: Thu, 12 Dec 2024 17:15:22 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 17/26] rust: qom: put class_init together from multiple
 ClassInitImpl<>
Message-ID: <Z1qpqvwRYZ4GaRE6@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-18-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209123717.99077-18-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
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

> Since CLASS_BASE_INIT applies to the type that is being defined,
> and only to it, move it to ObjectImpl.

It makes sense since class_base_init() is used when subclass is being
initialized.

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs  | 19 +------
>  rust/qemu-api/src/definitions.rs  | 85 +++++++++++++++++++++++--------
>  rust/qemu-api/src/device_class.rs | 50 +++++++-----------
>  rust/qemu-api/src/sysbus.rs       | 18 ++++++-
>  rust/qemu-api/tests/tests.rs      |  9 +---
>  5 files changed, 101 insertions(+), 80 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


