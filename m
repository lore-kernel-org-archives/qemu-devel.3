Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E81CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 07:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwFik-0003jv-M9; Wed, 10 Sep 2025 03:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwFii-0003jP-76
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 03:58:24 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwFib-0003jW-6l
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 03:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757491097; x=1789027097;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=EAED98ObkEDqeEj8FTD/TsDCmoyioGP4kSYS0Lm9kEk=;
 b=DR5koyQG6VoSkqMnxBzyKzLf2XBvrKbCmEfpBDLahbkRAqAlNQJY3XRD
 Y+yPyKBEJ7GUQmv8bHOK0W7OkGWEfW3qOv54rvdsp5veHZQLdpMb5qyOh
 PVP09rrkpdPBzwuq2352llyIYDy5rkm79k/5ThYOJH6RnfmEp0DjNyxZ8
 iPBru2ZRtRWQEBEXrd1ib5WQH76+Zxb+Y+o71Cdu4goal4+Vx+HtG+XQR
 f8WfVkfoh3iJ6HMdwRjdyY11Lgy5PJuk91YXdn9962vYAUrcpEyLJJfgA
 DCynzAMCzlqKiBwOR3ujpgMS33uJv4czWy571ykeb+k/NDIjrvlWYBh7B w==;
X-CSE-ConnectionGUID: 5LBdvpW4Q+i6PDRnlREXWw==
X-CSE-MsgGUID: lSuaA6NHR/ySYiBVrxfZKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="70411714"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; d="scan'208";a="70411714"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2025 00:58:09 -0700
X-CSE-ConnectionGUID: lfvuZuw9SuCSmp/6tvb75w==
X-CSE-MsgGUID: YvcUMkQbTT+9/vV7viJyDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; d="scan'208";a="173775247"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 10 Sep 2025 00:58:08 -0700
Date: Wed, 10 Sep 2025 16:19:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-rust@nondevel.org, qemu-devel <qemu-devel@nongnu.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: Rust high-level pre/post migration callbacks
Message-ID: <aME0r+dDsdmGCbxA@intel.com>
References: <8076a298-1cd9-4c90-a64c-f65004753975@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8076a298-1cd9-4c90-a64c-f65004753975@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
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

> Instead of dealing with pre/post callbacks, devices implement a
> snapshot/restore mechanism; this way, C code sees a simplified
> picture and does not have to deal with Rust concepts such as
> Mutex<>.
> 
> Using it is very easy, you can just declare your state like:
> 
>     regs: Migratable<Mutex<MyDeviceRegisters>>

I realized there's no need for QemuMutex binding, since we can use Rust
native Mutex directly, except some case which will share the Mutex with
C side.

> If a pure snapshot is possible, implementing the new trait
> is also simple:
> 
> impl_vmstate_struct!(MyDeviceRegisters, ...);
> 
> impl ToMigrationState for MyDeviceRegisters {
>     type Migrated = Self;
>     fn to_migration_state(&self) ->

Just about the name:

`to_migration_state` and `restore_migrated_state*` sound not a proper pair.
What about `snapshoot_migration_state` and `restore_migration_state`?

>         Result<Box<Self>, ...> {
>         Ok(Box::new(self.clone()))
>     }
> 
>     fn restore_migrated_state_mut(&mut self, source: &Self,
>         _version_id: u8) -> Result<(), migration::InvalidError> {
>         *self = source;
>         Ok(())
>     }
> }
> 
> I'm really bad at writing Rust code with the correct syntax
> from the get-go, but I'll try anyway.
> 
> new traits:
> 
> /// Enables QEMU migration support for types that may be wrapped in
> /// synchronization primitives (like `Mutex`) that the C migration
> /// code cannot directly handle. The trait provides methods to
> /// extract essential state for migration and restore it after
> /// migration completes.
> ///
> /// On top of extracting data from synchronization wrappers during save
> /// and restoring it during load, it's also possible to convert
> /// runtime representations to migration-safe formats.
> trait ToMigrationState {
>     type Migrated: Default + VMState;
>     fn to_migration_state(&self) ->

I think maybe here it's also necessary to accept a `&mut self` since
device would make some changes in pre_save.

Then this trate can provide mutable methods and ToMigrationStateShare
provides immuatable ones.

BTW, if possible, maybe we can rename the traits like:
* ToMigrationState -> ToMigrationStateMut
* ToMigrationStateShared -> ToMigrationState

>         Result<Box<Self::Migrated>, migration::InvalidError>;
>     fn restore_migrated_state_mut(&mut self, source: &Self::Migrated,
>         version_id: u8) -> Result<(), migration::InvalidError>;
> }
> 
> /// Extension trait for types that support migration state restoration
> /// through interior mutability.
> ///
> /// This trait extends `ToMigrationState` for types that can restore
> /// their state without requiring mutable access.  While user structs
> /// will generally use `ToMigrationState`, the device will have multiple
> /// references and therefore the device struct has to employ an interior
> /// mutability wrapper like `Mutex`, `RefCell`, or `BqlRefCell`.  In
> /// turn, wrappers implementing this trait can be used within `Migratable<T>`,
> /// which makes no assumptions on how to achieve mutable access to the
> /// run-time state.
> trait ToMigrationStateShared: ToMigrationState {
>     fn restore_migrated_state(&self, source: &Self::Migrated) ->
>         Result<(), migration::InvalidError>;
> }
> 
> 
> with implementations for wrapper types like:
> 
> impl<T> ToMigrationState for Mutex<T: ToMigrationState> {
>     type Migrated = T::Migrated;
>     fn to_migration_state(&self) ->
>         Result<Box<Self::Migrated>, migration::InvalidError> {
>         self.lock().to_migration_state()

I'm considerring maybe we could use get_mut() (and check bql by
assert!(bql_locked())) instead of locking this Mutex.

In this context, C side should hold the BQL lock so that this is
already a stronger protection.

>     }
>     ...

This omits the restore_migrated_state_mut, I guess it should be
filled with `unimplemented!()`.

> }
> 
> impl<T> ToMigrationStateShared for Mutex<T: ToMigrationState> {
>     fn restore_migrated_state(&self, source: &Self::Migrated,
>         version_id: u8) -> Result<(), migration::InvalidError>{
>         self.lock().restore_migrated_state_mut(source, version_id)

And here, maybe `get_mut()` + `assert!(bql_locked())`?

>     }
> }

...

> new struct maps the above trait to the C-style callbacks:
> 
> /// A wrapper that bridges Rust types with QEMU's C-based migration system.
> ///
> /// `Migratable<T>` enables QEMU migration support for Rust types that implement
> /// `ToMigrationState`, as long as they are wrapped with an interior mutability
> /// like `Mutex` or `BqlRefCell`.  It provides translation functionality as well
> /// as access to synchronization primitives that the C code cannot directly handle.
> ///
> /// This wrapper acts as a transparent proxy during normal operation
> /// (via `Deref`/`DerefMut`), while handling state extraction and restoration
> /// around migration.
> pub struct<T: ToMigrationStateShared> Migratable {
>     runtime_state: T,
>     // C vmstate does not support NULL pointers, so no Option<Box<>>
>     // Actually a BqlCell<*mut T::Migrated>, but keeping it simple
>     // for now.
>     migration_state: *mut T::Migrated
> };
> 
> unsafe impl<T> Send for Migratable<T: Send> {}
> unsafe impl<T> Sync for Migratable<T: Sync> {}
> 
> // just return runtime_state
> impl<T> Deref for Migratable<T: ToMigrationStateShared> {
>     type Migrated = T;
>     ...
> }
> impl<T> DerefMut for Migratable<T: ToMigrationStateShared> {
>     ...
> }
> 
> impl Migratable {
>     fn pre_save(...) -> ... {
>         self.migration_state = Box::into_raw(self.0.to_migration_state()?);
>     }
> 
>     fn post_save(...) -> ... {
>         drop(Box::from_raw(self.migration_state.replace(ptr::null_mut()));
>     }
> 
>     fn pre_load(...) -> ... {
>         self.migration_state = Box::into_raw(Box::default());
>     }
> 
>     fn post_load(...) -> ... {
>         let state = Box::from_raw(self.migration_state.replace(ptr::null_mut());
>         self.0.restore_migrated_state(state, version_id)
>     }

Yes, this is a nice way to handle Rust wrappers.

> }
> 
> unsafe impl VMState for Migratable<T: ToMigrationStateShared> {
>     const BASE: bindings::VMStateField = {
>         static VMSD: &$crate::bindings::VMStateDescription =
>             VMStateDescriptionBuilder::<Self>::new()
>                 .version_id(T::VMSD.version_id)
>                 .minimum_version_id(T::VMSD.minimum_version_id)
>                 .priority(T::VMSD.priority)
>                 .pre_load(Self::pre_load)
>                 .post_load(Self::post_load)
>                 .pre_save(Self::pre_save)
>                 .post_save(Self::post_save)

Maybe performance is a thing, and it might be worth comparing the
impact of these additional callbacks.

>                 .fields(vmstate_fields! {
>                     vmstate_of!(Migratable<T>, migration_state)
>                 }
>                 .build();
> 
>         bindings::VMStateField {
>             vmsd: addr_of!(*VMSD),
>             size: size_of::<Migratable<T>>(),
>             flags: bindings::VMStateFlags::VMS_STRUCT,
>             ..common::Zeroable::ZERO
>         }
>     };
> }

Overall, the design looks great!

Thanks,
Zhao


