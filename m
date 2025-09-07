Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE95ECA1017
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Sep 2025 14:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvGV0-00024P-8W; Sun, 07 Sep 2025 10:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvGUv-00023h-3u
 for qemu-devel@nongnu.org; Sun, 07 Sep 2025 10:36:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvGUg-0008Eh-ED
 for qemu-devel@nongnu.org; Sun, 07 Sep 2025 10:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757255744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B6xosFzpgBvmiuJ2xxCxQWCyAhrOmygpT2oG0J8D94o=;
 b=FQ72jvkfYOd0bEmEIbDkCjNK7rd2m8OsIDjNXCH0Ztib1mnrly+p0/kcTJsVFIQANih3Ea
 xwBu8L5IyBXA0pE1EWlUqyJOvBxYUJoB2VLTYz7gjouREcU1+AxlnJid8B8n84I3sjiF9h
 wDeWEaBhyPzAVl5OsvL1/EqqfmxWx18=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-sMbLAyLmMeKlfekwv19vcw-1; Sun, 07 Sep 2025 10:35:43 -0400
X-MC-Unique: sMbLAyLmMeKlfekwv19vcw-1
X-Mimecast-MFC-AGG-ID: sMbLAyLmMeKlfekwv19vcw_1757255742
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b96c2f4ccso20804725e9.0
 for <qemu-devel@nongnu.org>; Sun, 07 Sep 2025 07:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757255742; x=1757860542;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B6xosFzpgBvmiuJ2xxCxQWCyAhrOmygpT2oG0J8D94o=;
 b=L0N5DCxThxGJotl9bsK+oPccC4/GZH6dXnbUxyUE8ztqiQR88qeZTd7hf5WA09Mt6n
 Q5xxZMWay3kJDcaF/AO1qQ/7KR9T9iYIvdX8qY/ddIutz3b3SMHe0f13StIKRiToxlkg
 ijhJ/8P141aMIGxkAvVazDms4RThprlfPo7xNXdB59vaUJ3FOfbknbQwDMF7bAISsN0v
 p1LKteWT8BwKrhRndBHIMmLs2FFMRXZIAtLGADyEy3SCh0CmSS15orBpEM5sD3613PbQ
 jozn0XFopYHfZmPW4QAKEuk+UmY5tlMkGBN/P///zGimDrKUsG/DKzCSyjrhq2BFQlqA
 LuPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp0+DiXP46Akw2YTFWpHZ944UrQ5mq+eJswJrOqiG1TF8VV0j+v5aVZnC/AA9XJ2jQnrCF15+34MlV@nongnu.org
X-Gm-Message-State: AOJu0YxW1x3h1wqQb9jGA4qtA+IKQ4CD10sw0a+kgi9aUzdG6dItc3Sm
 ldtRPqz+DJn36NaizO1Hed61v6sceRZQ7VA1T3t++8Ic7IsRRHhoQNvRBqFgEEB7UipLSiRa/s0
 hb6LuWspSbn1qbIx/utrqkxW5jwl5RPnti5iT4YXzAYewi32ImuDr1qyUR3mrpWjmQ1JRy/1BT3
 gSO8tSINFGDNzZgyAEp+jhUq/kfFXctt4=
X-Gm-Gg: ASbGnctjjM6W/BooL0OAOH4Yb8MIYhgpzDFk8hw0UI2bviw3pPa2N4XmLBZKtDGuNgG
 UOIL3VshD3f2+3KsJ3nntRIqw8aGGQeqNBoSIRtW8mMc56sEBTv95G6eYatbthyS2WRe9p8FWLe
 4xMbpmplupr9OudAzUfAvIclcVW9RKAJ45fIvsaIM3A4nM78rC9RiqaBNOetk0zKpKAuNhXdtTT
 Hr9q1ewj/MCMktlmmdLKU9p
X-Received: by 2002:a5d:64e7:0:b0:3de:b99d:d43 with SMTP id
 ffacd0b85a97d-3e6428d7c2dmr3923374f8f.19.1757255741944; 
 Sun, 07 Sep 2025 07:35:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkvAm/woXJeA81SEMXCczdUtPu5jWBH11CTnjXx0xNPUcileQVEXesH7bWy9MQJep8ucsDJnzdMuimLkB1heM=
X-Received: by 2002:a5d:64e7:0:b0:3de:b99d:d43 with SMTP id
 ffacd0b85a97d-3e6428d7c2dmr3923356f8f.19.1757255741502; Sun, 07 Sep 2025
 07:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <8076a298-1cd9-4c90-a64c-f65004753975@redhat.com>
In-Reply-To: <8076a298-1cd9-4c90-a64c-f65004753975@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 7 Sep 2025 16:35:29 +0200
X-Gm-Features: AS18NWDJSGAbTlvLdzA7i2nDWnuTsWtaUsc9c3zhtfdiKjakglqVytdafBdchm4
Message-ID: <CABgObfaivSqSJGKkRv6iHYp3qznUqH4dXqrTER_7ZZRRhGN+AQ@mail.gmail.com>
Subject: Re: Rust high-level pre/post migration callbacks
To: qemu-rust@nondevel.org, qemu-devel <qemu-devel@nongnu.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Oh, and here is a possible way that ToMigrationState could be
implemented automatically:

#[derive(ToMigrationState)]
struct DeviceRegisters {
    #[migration_state(omit)]
    runtime_field: u32,

    #[migration_state(clone)]
    shared_data: String,

    #[migration_state(into(Cow<'static, str>), clone)]
    converted_field: String,

    #[migration_state(try_into(i8))]
    fallible_field: u32,

    // Default: use ToMigrationState trait recursively
    nested_field: NestedStruct,

    // Primitive types have a default implementation of ToMigrationState
    simple_field: u32,
}

Paolo

On Sat, Sep 6, 2025 at 8:45=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> Hi,
>
> based on the low-level sketch in Zhao and my presentation,
> I would like to propose this more high-level implementation
> of pre/post migration callbacks.
>
> Instead of dealing with pre/post callbacks, devices implement a
> snapshot/restore mechanism; this way, C code sees a simplified
> picture and does not have to deal with Rust concepts such as
> Mutex<>.
>
> Using it is very easy, you can just declare your state like:
>
>      regs: Migratable<Mutex<MyDeviceRegisters>>
>
> If a pure snapshot is possible, implementing the new trait
> is also simple:
>
> impl_vmstate_struct!(MyDeviceRegisters, ...);
>
> impl ToMigrationState for MyDeviceRegisters {
>      type Migrated =3D Self;
>      fn to_migration_state(&self) ->
>          Result<Box<Self>, ...> {
>          Ok(Box::new(self.clone()))
>      }
>
>      fn restore_migrated_state_mut(&mut self, source: &Self,
>          _version_id: u8) -> Result<(), migration::InvalidError> {
>          *self =3D source;
>          Ok(())
>      }
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
>      type Migrated: Default + VMState;
>      fn to_migration_state(&self) ->
>          Result<Box<Self::Migrated>, migration::InvalidError>;
>      fn restore_migrated_state_mut(&mut self, source: &Self::Migrated,
>          version_id: u8) -> Result<(), migration::InvalidError>;
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
> /// turn, wrappers implementing this trait can be used within `Migratable=
<T>`,
> /// which makes no assumptions on how to achieve mutable access to the
> /// run-time state.
> trait ToMigrationStateShared: ToMigrationState {
>      fn restore_migrated_state(&self, source: &Self::Migrated) ->
>          Result<(), migration::InvalidError>;
> }
>
>
> with implementations for wrapper types like:
>
> impl<T> ToMigrationState for Mutex<T: ToMigrationState> {
>      type Migrated =3D T::Migrated;
>      fn to_migration_state(&self) ->
>          Result<Box<Self::Migrated>, migration::InvalidError> {
>          self.lock().to_migration_state()
>      }
>      ...
> }
>
> impl<T> ToMigrationStateShared for Mutex<T: ToMigrationState> {
>      fn restore_migrated_state(&self, source: &Self::Migrated,
>          version_id: u8) -> Result<(), migration::InvalidError>{
>          self.lock().restore_migrated_state_mut(source, version_id)
>      }
> }
>
> impl<T> ToMigrationState for BqlRefCell<T: ToMigrationState> {
>      type Migrated =3D T::Migrated;
>      fn to_migration_state(&self) ->
>          Result<Box<Self::Migrated>, migration::InvalidError> {
>          self.borrow().to_migration_state()
>      }
>      ...
> }
>
> impl<T> ToMigrationStateShared for BqlRefCell<T: ToMigrationState> {
>      fn restore_migrated_state(&self, source: &Self::Migrated,
>          version_id: u8) ->Result<(), migration::InvalidError> {
>          self.borrow_mut().restore_migrated_state_mut(source, version_id)
>      }
> }
>
> new struct maps the above trait to the C-style callbacks:
>
> /// A wrapper that bridges Rust types with QEMU's C-based migration syste=
m.
> ///
> /// `Migratable<T>` enables QEMU migration support for Rust types that im=
plement
> /// `ToMigrationState`, as long as they are wrapped with an interior muta=
bility
> /// like `Mutex` or `BqlRefCell`.  It provides translation functionality =
as well
> /// as access to synchronization primitives that the C code cannot direct=
ly handle.
> ///
> /// This wrapper acts as a transparent proxy during normal operation
> /// (via `Deref`/`DerefMut`), while handling state extraction and restora=
tion
> /// around migration.
> pub struct<T: ToMigrationStateShared> Migratable {
>      runtime_state: T,
>      // C vmstate does not support NULL pointers, so no Option<Box<>>
>      // Actually a BqlCell<*mut T::Migrated>, but keeping it simple
>      // for now.
>      migration_state: *mut T::Migrated
> };
>
> unsafe impl<T> Send for Migratable<T: Send> {}
> unsafe impl<T> Sync for Migratable<T: Sync> {}
>
> // just return runtime_state
> impl<T> Deref for Migratable<T: ToMigrationStateShared> {
>      type Migrated =3D T;
>      ...
> }
> impl<T> DerefMut for Migratable<T: ToMigrationStateShared> {
>      ...
> }
>
> impl Migratable {
>      fn pre_save(...) -> ... {
>          self.migration_state =3D Box::into_raw(self.0.to_migration_state=
()?);
>      }
>
>      fn post_save(...) -> ... {
>          drop(Box::from_raw(self.migration_state.replace(ptr::null_mut())=
);
>      }
>
>      fn pre_load(...) -> ... {
>          self.migration_state =3D Box::into_raw(Box::default());
>      }
>
>      fn post_load(...) -> ... {
>          let state =3D Box::from_raw(self.migration_state.replace(ptr::nu=
ll_mut());
>          self.0.restore_migrated_state(state, version_id)
>      }
> }
>
> unsafe impl VMState for Migratable<T: ToMigrationStateShared> {
>      const BASE: bindings::VMStateField =3D {
>          static VMSD: &$crate::bindings::VMStateDescription =3D
>              VMStateDescriptionBuilder::<Self>::new()
>                  .version_id(T::VMSD.version_id)
>                  .minimum_version_id(T::VMSD.minimum_version_id)
>                  .priority(T::VMSD.priority)
>                  .pre_load(Self::pre_load)
>                  .post_load(Self::post_load)
>                  .pre_save(Self::pre_save)
>                  .post_save(Self::post_save)
>                  .fields(vmstate_fields! {
>                      vmstate_of!(Migratable<T>, migration_state)
>                  }
>                  .build();
>
>          bindings::VMStateField {
>              vmsd: addr_of!(*VMSD),
>              size: size_of::<Migratable<T>>(),
>              flags: bindings::VMStateFlags::VMS_STRUCT,
>              ..common::Zeroable::ZERO
>          }
>      };
> }
>
> This is just a sketch but should give the idea.
>
> Paolo


