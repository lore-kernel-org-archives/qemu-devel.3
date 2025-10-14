Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0596CCCD183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 03:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8VRI-0006i2-O9; Mon, 13 Oct 2025 23:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8VRH-0006hj-9S
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 23:11:03 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8VRC-0004D0-Au
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 23:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760411458; x=1791947458;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=wKlEa/Jx3xPSsZ3a1gnFAmOmgUSN+qbG0lyL/R1boyw=;
 b=dZa5M0ZcSSoaJz0tJkVLw7TzNAsgh1mh7IGHGQM2ZHjlODcAWkUJkL+3
 OebxsIAeO+RWvITbej6RufE0pWuQeMmFNGMYhssQAjCmXAZgRt0S8BBJh
 ivTjfXNHcN94GltCIIOitdG8Sb9do3xbuGc6hLH/INXds6cSvy9hWJv9D
 /8yYiPBXWUnppT5FjqkLV3yC/cm7BeNrVk9Rb4exBO1yl1cVkQKXe8xoT
 mPDsj4AT0Hn/awzQ0PeAT4qYQRKTLpdYEp67JF70k7Gr3rdUluA44gAJZ
 HsJvAcetF7tauZbhevzgxjdNKRdFWOD2n+ie7yP4EgGfNqKpgIWsvjFSI A==;
X-CSE-ConnectionGUID: Dk5I1IFlRBm5aACUDSEdnQ==
X-CSE-MsgGUID: MoKO2vhrRpe8CWzAUPR67w==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="73667472"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="73667472"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 20:10:53 -0700
X-CSE-ConnectionGUID: JRRYfemqQm+WTFwN/9Kt3w==
X-CSE-MsgGUID: pWvKnkYkRb+OxO42Zh1qAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="181724621"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 13 Oct 2025 20:10:52 -0700
Date: Tue, 14 Oct 2025 11:32:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 07/11] rust: migration: add high-level migration wrappers
Message-ID: <aO3EaSYMdIq4dRVg@intel.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
 <20251001075210.1042479-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001075210.1042479-7-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Oct 01, 2025 at 09:52:06AM +0200, Paolo Bonzini wrote:
> Date: Wed,  1 Oct 2025 09:52:06 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 07/11] rust: migration: add high-level migration wrappers
> X-Mailer: git-send-email 2.51.0
> 
> Instead of dealing with pre/post callbacks, allow devices to
> implement a snapshot/restore mechanism; this has two main
> advantages:
> 
> - it can be easily implemented via procedural macros
> 
> - there can be generic implementations to deal with various
>   kinds of interior-mutable containers, from BqlRefCell to Mutex,
>   so that C code does not see Rust concepts such as Mutex<>.
> 
> Using it is easy; you can implement the snapshot/restore trait
> ToMigrationState and declare your state like:
> 
>      regs: Migratable<Mutex<MyDeviceRegisters>>
> 
> Migratable<> allows dereferencing to the underlying object with
> no run-time cost.
> 
> Note that Migratable<> actually does not accept ToMigrationState,
> only the similar ToMigrationStateShared trait that the user will mostly
> not care about.  This is required by the fact that pre/post callbacks
> take a &self, and ensures that the argument is a Mutex or BqlRefCell
> (including an array or Arc<> thereof).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/rust.rst              |   1 +
>  rust/migration/meson.build       |   1 +
>  rust/migration/src/lib.rs        |   3 +
>  rust/migration/src/migratable.rs | 434 +++++++++++++++++++++++++++++++
>  4 files changed, 439 insertions(+)
>  create mode 100644 rust/migration/src/migratable.rs

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


