Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04603CA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 16:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwNIC-0004Tq-RB; Wed, 10 Sep 2025 12:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwNHw-0004Ci-FY
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 12:03:27 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwNHn-0004cf-A5
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 12:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757520187; x=1789056187;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=xZCKiCcGS7e7tKYJxzoHfuVR+9ToYP/8va8zczdPUR8=;
 b=DP01zkYSFsQmiLrVKxQqqIooCS4xzb3nB3F5qNUtTjVY+0xLyUDdiWvw
 7X2DqK6lGuO2H7JTBKZj71BP1EkrDOxPAZzEQDURCNAN7W4etn1qfvZcK
 AuVomAefMInbvHtJwTsrVOcXhJUj0MMvMtwUC/MH2OH2fyUA1mDX5Cy65
 owUHkwlOwG/LJL87jqJ66YTAqscvI8mhFFE3HY3yfHqd8g4MdK9HrwXa2
 0JEwOtW/lCiq9ObkgfEcyCYcoH2GAqna3/hbO/olQ6yXpaxliyU3Z454e
 uQfUHvmen39pnph7Nq3rK+2vIHk+gXoZQAEyj8rPjLNzN9CVjW8D+Keaj w==;
X-CSE-ConnectionGUID: xMGNC35PRrSW2ru6PsTo6w==
X-CSE-MsgGUID: RrSQONcYRqaOYCw1B6OMbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63667272"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="63667272"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2025 09:03:02 -0700
X-CSE-ConnectionGUID: QNELGcRySjWvsY0wQhFlog==
X-CSE-MsgGUID: 8HOhq+iPREOTZCL2qi0O/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; d="scan'208";a="173880469"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 10 Sep 2025 09:03:01 -0700
Date: Thu, 11 Sep 2025 00:24:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-rust@nondevel.org, qemu-devel <qemu-devel@nongnu.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: Rust high-level pre/post migration callbacks
Message-ID: <aMGmVNdIAyrN/W4J@intel.com>
References: <8076a298-1cd9-4c90-a64c-f65004753975@redhat.com>
 <aME0r+dDsdmGCbxA@intel.com>
 <CABgObfaBOJs73XMCUS1tPnoSYYYoKSWmjRmWnjUOb2kFL6XPJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfaBOJs73XMCUS1tPnoSYYYoKSWmjRmWnjUOb2kFL6XPJg@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
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

On Wed, Sep 10, 2025 at 01:33:53PM +0200, Paolo Bonzini wrote:
> Date: Wed, 10 Sep 2025 13:33:53 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: Rust high-level pre/post migration callbacks
> 
> On Wed, Sep 10, 2025 at 9:58 AM Zhao Liu <zhao1.liu@intel.com> wrote:
> > > If a pure snapshot is possible, implementing the new trait
> > > is also simple:
> > >
> > > impl_vmstate_struct!(MyDeviceRegisters, ...);
> > >
> > > impl ToMigrationState for MyDeviceRegisters {
> > >     type Migrated = Self;
> > >     fn to_migration_state(&self) ->
> >
> > Just about the name:
> >
> > `to_migration_state` and `restore_migrated_state*` sound not a proper pair.
> > What about `snapshoot_migration_state` and `restore_migration_state`?
> 
> to_migration_state is the one that creates a new migration state, but
> perhaps it could be implemented in terms of
> 
>     fn snapshot_migration_state(&self, target: &mut Self::Migrated) ->
>        Result<(), migration::InvalidError>;

Thanks for this snapshot_migration_state() example. Then I think the
original to_migration_state() is better (returning migration state in the
`Result` looks better than passing `&mut` :). )

> > > trait ToMigrationState {
> > >     type Migrated: Default + VMState;
> > >     fn to_migration_state(&self) ->
> >
> > I think maybe here it's also necessary to accept a `&mut self` since
> > device would make some changes in pre_save.
> >
> > Then this trate can provide mutable methods and ToMigrationStateShare
> > provides immuatable ones.
> 
> That should not be necessary with this approach,

Indeed, I had misunderstood this point. Rethink the pre_save: Use HPET
as the example - changing something within `pre_save` is what HPETState's
`pre_save` does, and it's unrelated to the current Migratable<>'s
`pre_save`.

Here, Migratable<>'s `pre_save` is used to assist in retrieving the
corresponding migration state.

> since all changes can
> be done in the newly-allocated migration state.

EMM, I didn't your point here... could you please talk more about this
point?

> > > impl<T> ToMigrationState for Mutex<T: ToMigrationState> {
> > >     type Migrated = T::Migrated;
> > >     fn to_migration_state(&self) ->
> > >         Result<Box<Self::Migrated>, migration::InvalidError> {
> > >         self.lock().to_migration_state()
> >
> > I'm considerring maybe we could use get_mut() (and check bql by
> > assert!(bql_locked())) instead of locking this Mutex.
> >
> > In this context, C side should hold the BQL lock so that this is
> > already a stronger protection.
> 
> For non-BQL-protected device I think you cannot know that another
> thread isn't taking the lock. For BQL the assertion is only needed in
> Migratable and BqlRefCell's implementation of ToMigrationStateShared.

Yes, I see.

> > This omits the restore_migrated_state_mut, I guess it should be
> > filled with `unimplemented!()`.
> 
> restore_migrated_state_mut() however *can* use get_mut().

Yes!

> > > unsafe impl VMState for Migratable<T: ToMigrationStateShared> {
> > >     const BASE: bindings::VMStateField = {
> > >         static VMSD: &$crate::bindings::VMStateDescription =
> > >             VMStateDescriptionBuilder::<Self>::new()
> > >                 .version_id(T::VMSD.version_id)
> > >                 .minimum_version_id(T::VMSD.minimum_version_id)
> > >                 .priority(T::VMSD.priority)
> > >                 .pre_load(Self::pre_load)
> > >                 .post_load(Self::post_load)
> > >                 .pre_save(Self::pre_save)
> > >                 .post_save(Self::post_save)
> >
> > Maybe performance is a thing, and it might be worth comparing the
> > impact of these additional callbacks.
> 
> This is only done once per device so it should be okay.

Okay, I agree.

Thanks,
Zhao


