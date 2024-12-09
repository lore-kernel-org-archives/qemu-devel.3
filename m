Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17ADFE77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 12:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKd1N-0003tj-S7; Mon, 09 Dec 2024 07:37:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd10-0003k7-FI
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:37:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd0x-0007O1-7I
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:37:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733747845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zZQyy3tQP8OD/1fdEQoI4TyeNI1Ugh3Z/zVs5dSJoV4=;
 b=XT+LuuzkxMR/IeKL6y2S/0sU4R0ZSwuVpkP8FtvxeG6mWtzU0qTRToosDJEb2ygPLxSIaI
 F7o6TKbjoJdYNROe2QaSqmre/5YNskdrjIscYGpdwaSp62FOoKMC4NCakd0spnhUGk8gFX
 yV3PwWgOLVoJU57QJwWLCtKiH/q8FVk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-wvvWIQnINZm5NupN401KYw-1; Mon, 09 Dec 2024 07:37:22 -0500
X-MC-Unique: wvvWIQnINZm5NupN401KYw-1
X-Mimecast-MFC-AGG-ID: wvvWIQnINZm5NupN401KYw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-434fb68b7d1so5863905e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 04:37:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733747840; x=1734352640;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zZQyy3tQP8OD/1fdEQoI4TyeNI1Ugh3Z/zVs5dSJoV4=;
 b=D9OeBQB1jmhYu6Mcc52Zq6fJX3aOqmI9FDy0cavhS2FOSCrb4E45gXruAi86QFYuXK
 mCPhyEvAIoHXtGp6NaxqKVqMUelF5hixAyKanhjGjQYMyCpKWQ0YcGWSWwyBGd8cHC4Z
 /2fKstjbdETA6bzUGO90maEgQ7hRLMBx9eiq6vKbM41QHXn9bEUbcZDJt+LLsqZLQ/N1
 bP+Hzz84i+DLTorC8WNnZa+hccuil3U7fFRlJH/h9HX/XouGyOEexriJx9RHINHPjXBX
 zeaQ9Bl3yxwL++E32CouSf+ITMoRdcKM48Rwn7h2zk2fKFXE1RA4JjmnL9vHOHuToJXv
 eH0A==
X-Gm-Message-State: AOJu0Yz87A1mZPyK0T9x8miBUUjmaYbk7hhS83QQb/r1nvo/Wcz5rpVP
 SvLEmO1wYCU9KLtEc5wW/PsqubsQsfT/cxeHAi82spzdUObvRcHcwwgH33qtcJUKck2ddHjb7oi
 7F2oM/TG6FWuzA4hi9CeDMegz0nuILIxV48+Swh8MRArOGbpRzFO41UsP696Mqtl9jLq8fvxzyf
 OgKo6iw7fT0cBEL6s79jTQS2D6hbG8qhLoz0X6
X-Gm-Gg: ASbGncuTG/8kgt+rhpE54SC90N1LFxiYcW9Wv344h3qZ71DBNWEPKNpO8SE6JZUdYyY
 I1Tx3VbveukCwFKLjzfY1yP6bgT73UvpIQUPwZakeWgrAOdoWLRj+UifmI94FsVEIhxezNNe3ny
 IQ7RTIlw4z6A5RaDnUwSEygJNXwTJuv5VxAX8UJe93MfOKgnNufYcPmoSmScRZ2tYSKWYG4mHvp
 1ia1kELyGL1g5WflyYLdSlfgeFMC41gjnuV0S2dV4XVIItILAVYmA==
X-Received: by 2002:a05:6000:4007:b0:385:f1d6:7b6a with SMTP id
 ffacd0b85a97d-3862b3cf82fmr9949590f8f.55.1733747840357; 
 Mon, 09 Dec 2024 04:37:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGolfB89T8KXr5Cv135D5++LYQhk9wH3nb1mgiHOKNvN464Xu7YokNKKTOvxu6HnRBtGViNEA==
X-Received: by 2002:a05:6000:4007:b0:385:f1d6:7b6a with SMTP id
 ffacd0b85a97d-3862b3cf82fmr9949565f8f.55.1733747839849; 
 Mon, 09 Dec 2024 04:37:19 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3862a4ae481sm10589989f8f.25.2024.12.09.04.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 04:37:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 00/26] rust: bundle of prerequisites for HPET implementation
Date: Mon,  9 Dec 2024 13:36:51 +0100
Message-ID: <20241209123717.99077-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

These are the initial set of bindings and support code that are needed
to apply Zhao's posted HPET implementation, and for him to apply
my review comments.  They include:

- QOM cleanups (already posted)

- interrupts sources and cells (posted and reviewed)

- bit deposit and extract operations (new)

- QOM generalization beyond DeviceState (new)

- callbacks system (new)

This is the code that I aim at integrating in QEMU 10.0, and is also
what is needed to develop additional bindings (for e.g. timers) more
or less independently.  I'll focus here on the changes to QOM because they
represent the bulk of the patches.  The bit operations and callbacks are
just one or two patches each, and better explained by the doc comments
in the patch itself.

With respect to qdev, some of this was already explained in the "Rust
in QEMU roadmap".  The patches are split in two series, corresponding
to patches 7-14 and 15-24.

The first and previously posted part mostly removes code duplication,
while keeping the focus very much on four elements of DeviceClass
(realize, legacy reset, properties, vmstate).

The second instead starts to establish a correspondence between the
QOM class hierarchy and the Rust trait system.  The hierarchy of classes
is visible as an ObjectImpl::ParentType associated type, and also present
in the implementation of the ClassInitImpl<ClassType> trait.  The
ClassInitImpl trait is implemented for each Rust-defined QOM class as
before, but now its implementation is split over multiple blanket impls,
one for each superclass.  This allows code reuse of the class_init
wrappers, and is implemented in patches 15-18.

After a brief cleanup intermission in patches 19-21, patches 22-23 provide
the method invocation infrastructure.  Taking inspiration from glib-rs's
GObject bindings, an IsA<> trait declares what is a subclass of what,
which allows two things:

- safe and efficient typecasts, which are compile-time checked so that
  it is an error if the destination type is not a superclass.

- automatically making methods available to all subclasses.  This is done
  through another blanket implementation of a trait, as in glib-rs (see
  https://gtk-rs.org/gtk4-rs/stable/latest/docs/src/gtk4/auto/widget.rs.html#5377),
  though the details are a bit different.

The differences with glib-rs are not small, but fortunately it is the QEMU
version that is simpler.  QEMU does not use a complicated macro like glib's
(https://gtk-rs.org/gtk-rs-core/git/docs/glib/macro.wrapper.html)  to
wrap all subclasses of GObject with an opaque Rust type.  While macros
in general, and procedural macros in particular, may be a useful tool(*),
for now I prefer to ensure that the infrastructure is usable and readable
even without any macro magic.

The two pieces allow defining QOM class hierarchies entirely in Rust;
patch 24 for example gives TYPE_PL011 its own class type PL011Class,
and stores the device id in PL011Class instead of PL011State.

I understand that this is a lot of code, and a lot of added lines in
particular.  Fortunately about 40% of it is docs, which is definitely
a change for QEMU's standards. :)  Also all except the last two patches
have already been used by Zhao, who did not report any particular problem
adopting them.

Excepting the docs, the bulk of the new code is in the BqlCell and
BqlRefCell implementations, as well as in patch 22.  Fortunately these
patches are also relatively boring.  The more interesting patches to
review are patch 15-18 for QOM, and 25 for the callbacks.  Patch 25 is
also the trickiest to explain from the point of view of using advanced
language features; (**) I tried to explain that in the doc comments
and commit messages but please ask for more if necessary.

This series is available at branch rust-next of
https://gitlab.com/bonzini/qemu.git.
Thanks,

Paolo

(*) For example they could automate the declaration of various traits,
many of which are "unsafe" as a reminder that they interact with C code.
This should be pretty easy, considering that the amount of code required
to write QOM types is already smaller in Rust than in C.  qdev properties
are also a useful target, as exemplified by Manos's previously posted
series.

(**) In particular, zero-sized types and the Fn trait.


Paolo Bonzini (26):
  bql: check that the BQL is not dropped within marked sections
  rust: cell: add BQL-enforcing Cell variant
  rust: cell: add BQL-enforcing RefCell variant
  rust: define prelude
  rust: add bindings for interrupt sources
  rust: add a bit operation module
  rust: qom: add default definitions for ObjectImpl
  rust: qom: rename Class trait to ClassInitImpl
  rust: qom: convert type_info! macro to an associated const
  rust: qom: move ClassInitImpl to the instance side
  rust: qdev: move device_class_init! body to generic function,
    ClassInitImpl implementation to macro
  rust: qdev: move bridge for realize and reset functions out of pl011
  rust: qom: automatically use Drop trait to implement instance_finalize
  rust: qom: move bridge for TypeInfo functions out of pl011
  rust: qom: split ObjectType from ObjectImpl trait
  rust: qom: change the parent type to an associated type
  rust: qom: put class_init together from multiple ClassInitImpl<>
  rust: qom: add possibility of overriding unparent
  rust: rename qemu-api modules to follow C code a bit more
  rust: re-export C types from qemu-api submodules
  rust: tests: allow writing more than one test
  rust: qom: add casting functionality
  rust: qom: add initial subset of methods on Object
  rust: qom: move device_id to PL011 class side
  rust: qemu-api: add a module to wrap functions and zero-sized closures
  rust: callbacks: allow passing optional callbacks as ()

 include/qemu/main-loop.h               |  15 +
 stubs/iothread-lock.c                  |  15 +
 system/cpus.c                          |  15 +
 rust/Cargo.toml                        |   1 +
 rust/hw/char/pl011/src/device.rs       | 156 ++---
 rust/hw/char/pl011/src/device_class.rs |  34 -
 rust/qemu-api-macros/src/lib.rs        |   2 +-
 rust/qemu-api/Cargo.toml               |   3 +-
 rust/qemu-api/meson.build              |  14 +-
 rust/qemu-api/src/bitops.rs            | 119 ++++
 rust/qemu-api/src/callbacks.rs         | 238 +++++++
 rust/qemu-api/src/cell.rs              | 822 +++++++++++++++++++++++++
 rust/qemu-api/src/definitions.rs       |  91 ---
 rust/qemu-api/src/device_class.rs      |  74 ---
 rust/qemu-api/src/irq.rs               |  91 +++
 rust/qemu-api/src/lib.rs               |  15 +-
 rust/qemu-api/src/module.rs            |  43 ++
 rust/qemu-api/src/prelude.rs           |  18 +
 rust/qemu-api/src/qdev.rs              | 146 +++++
 rust/qemu-api/src/qom.rs               | 556 +++++++++++++++++
 rust/qemu-api/src/sysbus.rs            |  51 ++
 rust/qemu-api/src/vmstate.rs           |   9 +-
 rust/qemu-api/tests/tests.rs           | 208 +++++--
 23 files changed, 2374 insertions(+), 362 deletions(-)
 create mode 100644 rust/qemu-api/src/bitops.rs
 create mode 100644 rust/qemu-api/src/callbacks.rs
 create mode 100644 rust/qemu-api/src/cell.rs
 delete mode 100644 rust/qemu-api/src/definitions.rs
 delete mode 100644 rust/qemu-api/src/device_class.rs
 create mode 100644 rust/qemu-api/src/irq.rs
 create mode 100644 rust/qemu-api/src/module.rs
 create mode 100644 rust/qemu-api/src/prelude.rs
 create mode 100644 rust/qemu-api/src/qdev.rs
 create mode 100644 rust/qemu-api/src/qom.rs
 create mode 100644 rust/qemu-api/src/sysbus.rs

-- 
2.47.1


