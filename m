Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B5BCAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 14:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13wn-0006Pb-M9; Tue, 23 Sep 2025 10:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v13wl-0006NE-Qj; Tue, 23 Sep 2025 10:24:48 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v13wg-000113-6Q; Tue, 23 Sep 2025 10:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758637482; x=1790173482;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=hW+0rC8w5oQ2LbEO14lMfZQZM844zv7jTbxOKNJJN44=;
 b=IxsPmue5sgVPGmEwFazO5W/OfdNC5wd5d4mOTmaxlqTfkuqxqrMSDzDB
 GgHONqkqSf04VD1Y9yIO+qBepaQ/DQojjsyafFGHfYAtW3V7eOrcypH1Y
 OkDlZ0dBX+64WXc63kUpo1ImxfSrGqKcKLh3WCBVszXptd3LFTM8sC9y2
 U+HpA48jyoiZgj/xOtI4asOZPgW32IcTYykaoTCTIguPPulWJnaXyA8pp
 yBzYLniOQcwW0bw4okoKw0jSXChVRmwQFmj/+Mp00r6tYuAdkBP+4mZt6
 wJZJveMX+DfwUBZ0Y576vMAECleajlXg7GVOo0ngKAauXzOFnyoVKnqBo A==;
X-CSE-ConnectionGUID: u0/IlOTDQ8aDGB8mVTBm5w==
X-CSE-MsgGUID: 5b0rrmArRQmVh04YvgS8RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="71539626"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="71539626"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 07:24:38 -0700
X-CSE-ConnectionGUID: 9Ijp4oTYTF+wrRPNvrvT4g==
X-CSE-MsgGUID: AK3mUiDwQ76PQ1QSzSk1kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="181088323"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 23 Sep 2025 07:24:37 -0700
Date: Tue, 23 Sep 2025 22:46:34 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, manos.pitsidianakis@linaro.org
Subject: Re: [PATCH 2/7] rust: move VMState from bql to migration
Message-ID: <aNKyyvDwpHstJDiv@intel.com>
References: <20250920142958.181910-1-pbonzini@redhat.com>
 <20250920142958.181910-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920142958.181910-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sat, Sep 20, 2025 at 04:29:53PM +0200, Paolo Bonzini wrote:
> Date: Sat, 20 Sep 2025 16:29:53 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 2/7] rust: move VMState from bql to migration
> X-Mailer: git-send-email 2.51.0
> 
> The high-level wrapper Migratable<T> will contain a BqlCell,
> which would introduce a circular dependency betwen the bql and
> migration crates.  Move the implementation of VMState for cells
> to "migration", together with the implementation for std types.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/Cargo.lock               | 4 +---
>  rust/bql/Cargo.toml           | 3 ---
>  rust/bql/meson.build          | 1 -
>  rust/bql/src/cell.rs          | 6 ------
>  rust/meson.build              | 2 +-
>  rust/migration/Cargo.toml     | 1 +
>  rust/migration/meson.build    | 4 ++--
>  rust/migration/src/vmstate.rs | 2 ++
>  8 files changed, 7 insertions(+), 16 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


