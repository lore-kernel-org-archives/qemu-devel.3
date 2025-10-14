Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C50CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 06:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8YbX-0002O0-BY; Tue, 14 Oct 2025 02:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8YbR-0002Nf-Ey
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 02:33:47 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8YbO-00061r-NR
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 02:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760423622; x=1791959622;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qMXCq+rgsGxQcZRcmyOXcZ7fh6iMsgKa5H2qjqBzr7Y=;
 b=aaj8PcBgi4IY1ArBFWqLzT7BWGBqJHG57yna0NeLumm1G70BnhJRmRGn
 8FhZjue8Xv8BFPiKZfZtoVsJYxk293m58VF6VZPPab7JiMXNel3n+AQN+
 aFGZ58n7Rs5DlSMOa2cHhnRvUsQb974EXhmz2OIQhL5iaJAPyg8oXU2lW
 okEoCfcqVMueptJf3ozHeLCc9e4ff9oC1vFCsyJjPWm6a+QoEOjW+z4lz
 m28aIeGFTyZ81Ow3F8D/JKmxATywZKFNws+bII6JSk4tW2Ac6i77fh4zz
 HjV39xcSqNSeO3+KWxj3iyVBSy5q36prUYKTCMlyuuVW3O9eXN9MFCu2y A==;
X-CSE-ConnectionGUID: 9H8TT4E/SwSa1Gza4BG40Q==
X-CSE-MsgGUID: gp+0TDfJQ4+qWENQpZy6Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62507004"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="62507004"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 23:33:39 -0700
X-CSE-ConnectionGUID: F9rnvAtfSZGJJy0ko5L9iQ==
X-CSE-MsgGUID: Tx/HTHlCT6W47C0ehOCSgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="212420368"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 13 Oct 2025 23:33:39 -0700
Date: Tue, 14 Oct 2025 14:55:43 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 10/11] rust: migration: implement ToMigrationState for
 Timer
Message-ID: <aO3z7zbztw3TaxY+@intel.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
 <20251001075210.1042479-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001075210.1042479-10-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
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

On Wed, Oct 01, 2025 at 09:52:09AM +0200, Paolo Bonzini wrote:
> Date: Wed,  1 Oct 2025 09:52:09 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 10/11] rust: migration: implement ToMigrationState for Timer
> X-Mailer: git-send-email 2.51.0
> 
> Timer is a complex struct, allow adding it to a struct that
> uses #[derive(ToMigrationState)]; similar to vmstate_timer, only
> the expiration time has to be preserved.
> 
> In fact, because it is thread-safe, ToMigrationStateShared can
> also be implemented without needing a cell or mutex that wraps
> the timer.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/migration/src/migratable.rs | 31 +++++++++++++++++++++++++++++++
>  rust/util/src/timer.rs           | 10 +++++++++-
>  2 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/migration/src/migratable.rs b/rust/migration/src/migratable.rs
> index ded6fe8f4a6..e85ef810efc 100644
> --- a/rust/migration/src/migratable.rs
> +++ b/rust/migration/src/migratable.rs
> @@ -140,6 +140,26 @@ fn restore_migrated_state_mut(
>  
>  impl_for_primitive!(u8, u16, u32, u64, i8, i16, i32, i64, bool);
>  
> +impl ToMigrationState for util::timer::Timer {
> +    type Migrated = i64;
> +
> +    fn snapshot_migration_state(&self, target: &mut i64) -> Result<(), InvalidError> {
> +        // SAFETY: as_ptr() is unsafe to ensure that the caller reasons about
> +        // the pinning of the data inside the Opaque<>.  Here all we do is
> +        // access a field.
> +        *target = self.expire_time_ns().unwrap_or(-1);
> +        Ok(())
> +    }
> +
> +    fn restore_migrated_state_mut(
> +        &mut self,
> +        source: Self::Migrated,
> +        version_id: u8,
> +    ) -> Result<(), InvalidError> {
> +        self.restore_migrated_state(source, version_id)
> +    }
> +}
> +
>  impl<T: ToMigrationState, const N: usize> ToMigrationState for [T; N]
>  where
>      [T::Migrated; N]: Default,
> @@ -237,6 +257,17 @@ fn restore_migrated_state(
>      ) -> Result<(), InvalidError>;
>  }
>  
> +impl ToMigrationStateShared for util::timer::Timer {
> +    fn restore_migrated_state(&self, source: i64, _version_id: u8) -> Result<(), InvalidError> {
> +        if source >= 0 {
> +            self.modify(source as u64);

Timer::modify() is the wrapper of timer_mod(), and timer_mod() will
re-compute the expire time with scale factor.

So here we should use a binding of timer_mod_ns() - Timer::modify_ns()
instead of Timer::modify(), just like C side did.

Moreover, for Timer::modify_ns() & Timer::modify(), the simplest
way is to build them based on timer_mod_ns() & timer_mod() (but this
sounds like shifting the responsibility for type checking and overflow
checking to the C side :-( ).

Alternative, we can make Timer::modify() based on Timer::modify_ns(),
but then it involves many numeric type conversions: scale is i32 but
expire_time is u64, and Timer::modify_ns() may accept a u64 argument.

Fortunately,, we can make Timer's modify() accept i64 to reduce type
conversions.

> +        } else {
> +            self.delete();
> +        }
> +        Ok(())
> +    }
> +}
> +
>  impl<T: ToMigrationStateShared, const N: usize> ToMigrationStateShared for [T; N]
>  where
>      [T::Migrated; N]: Default,
> diff --git a/rust/util/src/timer.rs b/rust/util/src/timer.rs
> index c6b3e4088ec..a99ff5e7ef7 100644
> --- a/rust/util/src/timer.rs
> +++ b/rust/util/src/timer.rs
> @@ -10,7 +10,8 @@
>  use common::{callbacks::FnCall, Opaque};
>  
>  use crate::bindings::{
> -    self, qemu_clock_get_ns, timer_del, timer_init_full, timer_mod, QEMUClockType,
> +    self, qemu_clock_get_ns, timer_del, timer_expire_time_ns, timer_init_full, timer_mod,
> +    QEMUClockType,
>  };
>  
>  /// A safe wrapper around [`bindings::QEMUTimer`].
> @@ -86,6 +87,13 @@ pub fn init_full<'timer, 'opaque: 'timer, T, F>(
>          }
>      }
>  
> +    pub fn expire_time_ns(&self) -> Option<i64> {
> +        // SAFETY: the only way to obtain a Timer safely is via methods that
> +        // take a Pin<&mut Self>, therefore the timer is pinned
> +        let ret = unsafe { timer_expire_time_ns(self.as_ptr()) };
> +        i64::try_from(ret).ok()

Good! This detects all negative values.

> +    }
> +
>      pub fn modify(&self, expire_time: u64) {
>          // SAFETY: the only way to obtain a Timer safely is via methods that
>          // take a Pin<&mut Self>, therefore the timer is pinned
> -- 
> 2.51.0
> 

