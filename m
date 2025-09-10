Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC082CA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 11:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwJ5f-0002tB-6H; Wed, 10 Sep 2025 07:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uwJ5d-0002sz-HZ
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 07:34:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uwJ5a-0006f6-JB
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 07:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757504049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nuuIJtJSvFDfBnS1FmFHgI58qM3NFy2i4swkdF1BMK8=;
 b=ioQNT3459aasO/Ez5c+FYgtiZunflmVrzkhtICFZKKGUct9On3wiJg5DHby9ahv+emZRfQ
 s5IwH5WHdU9BQmcnDiVibJV5uXuOYegstbqT8u+BlErv7p2nStk+0JHGLD6wuTA0sBFAtM
 2c8W2WLRR3U3MWgsjInsX+yKGneZiAo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-ds0_sqC9PG-wKIKoBW90vQ-1; Wed, 10 Sep 2025 07:34:08 -0400
X-MC-Unique: ds0_sqC9PG-wKIKoBW90vQ-1
X-Mimecast-MFC-AGG-ID: ds0_sqC9PG-wKIKoBW90vQ_1757504047
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45cb612d362so37458785e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 04:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757504047; x=1758108847;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nuuIJtJSvFDfBnS1FmFHgI58qM3NFy2i4swkdF1BMK8=;
 b=IgXjjwWozpYloNU+Dphc7aJK19BVo02rb+krmqLuTaxC3pxxA73SaGl6t4LEcmHVv5
 g/wq0ZjXxZgUINZRKO1lX7FE7nxp3eaJ8l23F1sDbUYdPTtKb9NrkGJO/j9omUHjqDRg
 A7veYr5LYneBilMZf6oe9J9cwBFoUXs0pPGGq6t+RX8NuzuOl/s+MtB9bKy9gxQxjLfM
 gKm9SUiGQ2e4jbdJZv50MVHUeRMzb/+QKTHN/zkRS9aTJcW5tIoOiGBqWFImithPq30m
 HlpwQcmDEdKlrFoO/cndKe86UQxvyPYVPljueQoMlDrPmlaU6ZRkQdP+o55DknnfovkF
 A9yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG0gMiFMoTjVUP3W/i7uY6G04XBC3Q6pLtZhL8ifY88gnqmACW08eOF54gaLs/d1qKG8sUoQEK+q/d@nongnu.org
X-Gm-Message-State: AOJu0YydvBj6/ehe38arJjIHcRJSr5pCu88rQlqrY2uzU7UmlLBU4E7c
 kVpIss5URb2uJUBaAdZ6ff3zzAeInx/uHrecQvUeOzAuzzAX1ulfpA3AATaCS1/HcdO5vVKS/eS
 zPrrwLV6jAlSaKMSn7z3QjUpIUIM+qTHpHYFhVKj0W/4mXlZ/xIaUhvg2yNtHpdBpw5IRp/AyMh
 DieYyNkxvHhuZg2hzJOPVY6cLVoDxu9GI=
X-Gm-Gg: ASbGncttSjN3q6cAsSeB8jw3di9lK5aydgTr0Ea8ZYeaSWBHMXi5c4sqr5wVx5LBEnX
 YTIL5t5hHJ7H3MaRYF7RxxTB7VVN5AW0eyE9PDZtGn53MsFKYD/YxgZHJYVbxXhcgy0zwSgPFQF
 3vyIVSDYSx2GZqBydHGRQjBfxRRJ07Ix6Yt6LguEjWWmvSOXxJic2ogAOOA58Vmtvwp3T4LStd7
 v9OBtTjIoGer76YRIz7utBb
X-Received: by 2002:a05:600c:8b4c:b0:45d:da45:50c8 with SMTP id
 5b1f17b1804b1-45dddef0265mr119822415e9.29.1757504046723; 
 Wed, 10 Sep 2025 04:34:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSpsYjTqq4ZuFLM3q3+aajJ3Xaxy8Qyto9MYz2MhiCB5m7PQZr+DMshaCmVCMyCgBqAweo/tsvEg5d6D4kKCg=
X-Received: by 2002:a05:600c:8b4c:b0:45d:da45:50c8 with SMTP id
 5b1f17b1804b1-45dddef0265mr119822115e9.29.1757504046258; Wed, 10 Sep 2025
 04:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <8076a298-1cd9-4c90-a64c-f65004753975@redhat.com>
 <aME0r+dDsdmGCbxA@intel.com>
In-Reply-To: <aME0r+dDsdmGCbxA@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 10 Sep 2025 13:33:53 +0200
X-Gm-Features: AS18NWC4Ht8w6U8ebKaMsFtpoN1BORtAa-ZK8IuCJ0qrIF-2l1jUNYMDfzSmtSk
Message-ID: <CABgObfaBOJs73XMCUS1tPnoSYYYoKSWmjRmWnjUOb2kFL6XPJg@mail.gmail.com>
Subject: Re: Rust high-level pre/post migration callbacks
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-rust@nondevel.org, qemu-devel <qemu-devel@nongnu.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 10, 2025 at 9:58=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
> > If a pure snapshot is possible, implementing the new trait
> > is also simple:
> >
> > impl_vmstate_struct!(MyDeviceRegisters, ...);
> >
> > impl ToMigrationState for MyDeviceRegisters {
> >     type Migrated =3D Self;
> >     fn to_migration_state(&self) ->
>
> Just about the name:
>
> `to_migration_state` and `restore_migrated_state*` sound not a proper pai=
r.
> What about `snapshoot_migration_state` and `restore_migration_state`?

to_migration_state is the one that creates a new migration state, but
perhaps it could be implemented in terms of

    fn snapshot_migration_state(&self, target: &mut Self::Migrated) ->
       Result<(), migration::InvalidError>;

> > trait ToMigrationState {
> >     type Migrated: Default + VMState;
> >     fn to_migration_state(&self) ->
>
> I think maybe here it's also necessary to accept a `&mut self` since
> device would make some changes in pre_save.
>
> Then this trate can provide mutable methods and ToMigrationStateShare
> provides immuatable ones.

That should not be necessary with this approach, since all changes can
be done in the newly-allocated migration state.

> > impl<T> ToMigrationState for Mutex<T: ToMigrationState> {
> >     type Migrated =3D T::Migrated;
> >     fn to_migration_state(&self) ->
> >         Result<Box<Self::Migrated>, migration::InvalidError> {
> >         self.lock().to_migration_state()
>
> I'm considerring maybe we could use get_mut() (and check bql by
> assert!(bql_locked())) instead of locking this Mutex.
>
> In this context, C side should hold the BQL lock so that this is
> already a stronger protection.

For non-BQL-protected device I think you cannot know that another
thread isn't taking the lock. For BQL the assertion is only needed in
Migratable and BqlRefCell's implementation of ToMigrationStateShared.

> This omits the restore_migrated_state_mut, I guess it should be
> filled with `unimplemented!()`.

restore_migrated_state_mut() however *can* use get_mut().

> > unsafe impl VMState for Migratable<T: ToMigrationStateShared> {
> >     const BASE: bindings::VMStateField =3D {
> >         static VMSD: &$crate::bindings::VMStateDescription =3D
> >             VMStateDescriptionBuilder::<Self>::new()
> >                 .version_id(T::VMSD.version_id)
> >                 .minimum_version_id(T::VMSD.minimum_version_id)
> >                 .priority(T::VMSD.priority)
> >                 .pre_load(Self::pre_load)
> >                 .post_load(Self::post_load)
> >                 .pre_save(Self::pre_save)
> >                 .post_save(Self::post_save)
>
> Maybe performance is a thing, and it might be worth comparing the
> impact of these additional callbacks.

This is only done once per device so it should be okay.

Paolo


