Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015A1CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 08:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1hZe-0000bw-Rg; Thu, 25 Sep 2025 04:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v1hZc-0000bX-Nf; Thu, 25 Sep 2025 04:43:32 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v1hZO-0001rW-Gj; Thu, 25 Sep 2025 04:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758789798; x=1790325798;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=rmFAaHfBEczcsaBb/aXAybi4F2kd/Wfxu0LppVYWYk4=;
 b=UnQqHogX3fCymdYh6fFAlNGZLn8HPIc7Ur8liCAwmwReGTLZIrMztXdi
 INhKJzR8fuVQOED00WE6ZoGZWl7l95jA2STo7Wz3/HvsdMG1Dy6lnk+yR
 uuLGL9AH+uXcOypSSlxPWXLDcDUJOiXtYpMpdPclijqm0oBwWqZwmwak4
 6v08Z78sSo9toS294vd5/5FygN7n/HlaLXjKoAQpyW9rkDMF+tEVaMHea
 6c70clSsNa/jG0vfm2+JIpWTwJSLFTDxjrRFjj3rR0KVstfWeTPwjrww+
 7R3gkKoVnIw4if56OnLtPXplsWu5q8oVrVi927jkwYtkkKHsyxF/lkQXm A==;
X-CSE-ConnectionGUID: UyNerHGvSBmu1lxN0ElgFg==
X-CSE-MsgGUID: ALMhA5LiQ625uGhTG+UOFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61152239"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="61152239"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 01:43:06 -0700
X-CSE-ConnectionGUID: nWAFfcOITQ6WlsmYSJOBlQ==
X-CSE-MsgGUID: +5MPPKimSEqwrWxbnyDBsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="208018552"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 25 Sep 2025 01:43:04 -0700
Date: Thu, 25 Sep 2025 17:05:02 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, manos.pitsidianakis@linaro.org
Subject: Re: [PATCH 4/7] rust: migration: add high-level migration wrappers
Message-ID: <aNUFvm7GKHkfrSui@intel.com>
References: <20250920142958.181910-1-pbonzini@redhat.com>
 <20250920142958.181910-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920142958.181910-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Sat, Sep 20, 2025 at 04:29:55PM +0200, Paolo Bonzini wrote:
> Date: Sat, 20 Sep 2025 16:29:55 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 4/7] rust: migration: add high-level migration wrappers
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
>  rust/Cargo.lock                  |   1 +
>  rust/migration/Cargo.toml        |   1 +
>  rust/migration/meson.build       |   1 +
>  rust/migration/src/lib.rs        |   3 +
>  rust/migration/src/migratable.rs | 430 +++++++++++++++++++++++++++++++
>  5 files changed, 436 insertions(+)
>  create mode 100644 rust/migration/src/migratable.rs

The entire wrapper is quite nice. So,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


Only a few comments for comments inline:

> +// Interior-mutable types only require ToMigrationState for the inner type!
> +

extra blank line.

> +impl<T: ToMigrationState> ToMigrationState for Mutex<T> {
> +    type Migrated = T::Migrated;
> +
> +    fn snapshot_migration_state(&self, target: &mut Self::Migrated) -> Result<(), InvalidError> {
> +        self.lock().unwrap().snapshot_migration_state(target)
> +    }

Or maybe your previous sentence is worth commenting on here:

// For non-BQL-protected device we cannot know that another
// thread isn't taking the lock. So, always acquire the lock.

> +    fn restore_migrated_state_mut(
> +        &mut self,
> +        source: Self::Migrated,
> +        version_id: u8,
> +    ) -> Result<(), InvalidError> {
> +        self.restore_migrated_state(source, version_id)
> +    }
> +}
> +
> +impl<T: ToMigrationState> ToMigrationStateShared for Mutex<T> {
> +    fn restore_migrated_state(
> +        &self,
> +        source: Self::Migrated,
> +        version_id: u8,
> +    ) -> Result<(), InvalidError> {
> +        self.lock()
> +            .unwrap()
> +            .restore_migrated_state_mut(source, version_id)
> +    }
> +}
> +


