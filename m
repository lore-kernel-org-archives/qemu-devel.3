Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62EED2FFFA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 15:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1pFi-0007xI-DF; Fri, 18 Oct 2024 11:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1pFg-0007x6-W4
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:50:57 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1pFb-0001iy-6I
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729266651; x=1760802651;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=CupctDBDqFYaayO6awqPihA17D5MXKbRJwtQSQSeWHo=;
 b=d4olzDaKf3gvWfkM1Yfe7QqsWBDhd/ERH+b2rkbdJ2VYo2zEDYeqr3Wv
 nqBJ2JJ8vkfItoHzmMY6qYLA/0VqQ+VUTot2IW+nWVvjHlhacMOR6zU77
 tImhoKwtqKDCslA8ENplkb7OtHSFOckJhU2wVaGbslyMmE8BX/4uf3cPB
 mmXM1fnHf4HhppCshP2oX8cXbEBYavP0AbTeUQ2/JCp5cmN3V3re/AJgx
 Xmha30sQ59U03rlyBVtKRo4sDsvkT2OwtRrqx5iO3kQaIJz9cqScxkMA3
 Uxo9uTJgDc37RoWsdH1VrKx1HFPDuib09F4AFAwSMw6109Ng7icKfef9H A==;
X-CSE-ConnectionGUID: /skHIjENRDWhnGqdHbjzHQ==
X-CSE-MsgGUID: zHvsNzmVSFif0HkAH8ydBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39347607"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="39347607"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 08:50:49 -0700
X-CSE-ConnectionGUID: dAqVFAfoRUGqnu77sPqkUQ==
X-CSE-MsgGUID: rZ1LFJNZQLehFWVXA+oSmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; d="scan'208";a="79246471"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 18 Oct 2024 08:50:48 -0700
Date: Sat, 19 Oct 2024 00:07:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 07/16] rust: use std::os::raw instead of core::ffi
Message-ID: <ZxKHqNlUFaSlcHPH@intel.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015131735.518771-8-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
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

On Tue, Oct 15, 2024 at 03:17:25PM +0200, Paolo Bonzini wrote:
> Date: Tue, 15 Oct 2024 15:17:25 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 07/16] rust: use std::os::raw instead of core::ffi
> X-Mailer: git-send-email 2.46.2
> 
> core::ffi::c_* types were introduced in Rust 1.64.0.  Use the older types
> in std::os::raw, which are now aliases of the types in core::ffi.  There is
> no need to compile QEMU as no_std, so this is acceptable as long as we support
> a version of Debian with Rust 1.63.0.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build                          |  3 +--
>  rust/hw/char/pl011/src/device.rs     | 20 +++++++++++---------
>  rust/hw/char/pl011/src/lib.rs        |  2 +-
>  rust/hw/char/pl011/src/memory_ops.rs | 10 ++++++----
>  rust/qemu-api/src/definitions.rs     |  4 +++-
>  rust/qemu-api/src/device_class.rs    |  8 ++++----
>  rust/qemu-api/src/lib.rs             |  8 +++++---
>  7 files changed, 31 insertions(+), 24 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


