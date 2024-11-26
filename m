Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED7ED6553C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 18:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFzuB-0007o2-Vq; Tue, 26 Nov 2024 13:03:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFztf-0007bZ-Md
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 13:02:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFztc-0005an-LR
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 13:02:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732644162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S83XJnMzLI8LacLdWrtVYwsB++1icr8Ej3GR3pT0z94=;
 b=LHnT6fEFYFmMkqW9QYZCidXOtKUJ+QxHiDNY+p/Kv4HTzsnBiJDeb7EL5kDyD5ixLJVnfL
 K1EwvoIf0tOskADx/WTnOdgmN0EIfaGDN8vbhwznVIqZ/x4mdP80hfDmc4fhRmYtJvOiOz
 QadU1SNqKXEwFKq+nqA/FKJA72GI5nc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-3z0yEpfJOd6xYKmYDMJo-g-1; Tue, 26 Nov 2024 13:02:41 -0500
X-MC-Unique: 3z0yEpfJOd6xYKmYDMJo-g-1
X-Mimecast-MFC-AGG-ID: 3z0yEpfJOd6xYKmYDMJo-g
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-434a27c9044so12231935e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 10:02:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732644159; x=1733248959;
 h=content-transfer-encoding:mime-version:message-id:date:to:subject
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S83XJnMzLI8LacLdWrtVYwsB++1icr8Ej3GR3pT0z94=;
 b=ckBxRzpsXOy9ghd2kXrO6o9oPA1iVquqS8GoGIAUZrCTec2x++Eg1nLCLU7U/odzIx
 ENOJseeArTHu5rO2LjoVxS4iTz1JboUe1y2OovoCO3UB4YFpv9CGQeI6S72oxNb09lrw
 KqJ6TUxXBd4zAVMDgc3iDYRo223h5ObTB7gOvFYJzP9N8YtGdh8FC21WdkPK9jQqOXwh
 78lBZudl3uARx9/T+vABdLiKbOre5vVhCn1T0jPDB5R53HTYhjLTmVPb30dCX1sVypp8
 brFY+lh6xk9pACAZaJJQ9OXYm78mfjMft+qFEP52XVx+y7QyDQFijWgTBHW9NBgp9J/m
 O21w==
X-Gm-Message-State: AOJu0YzTrJrzj8t88AdhoGRZ3Jd+EAnz2PkSGvMndNU3bGkHuIFcSc+K
 td2H2plpZV32vZw5b/9NpjGk4j3ESIgUq/gQ8nyyQvw7p4WWE2E/pZUf2S8FRVuccK4gTBToWWx
 DpH3fHRKbxpIPnMydj6LL6k3VbXJPUm5bwqISycKPjgJuLarzizk0O3SVVM9KLm7bRbSb3ro8gG
 qCUFooZaNMoK4quvcdosUOEtEecMBiIWUs6vWo
X-Gm-Gg: ASbGncucGwbLaJO2Q0TaA+h5d9LjqKXVeH5VV6ZuXDSb209enBQ7uBCeEddDHk8kYrg
 TGuHCPxIcTlKte0Uo3mfzi6uYyUqLktjVX1wT9+FljT/D+on9URhwjAtgASRLDaPJbG6HtJ1Nbx
 UXQULJZasm2YcTjt/CLd1bKqjLXv8VUkRhUhcrD2Ysrj6u0hp41LgCnvzC0iCEgHHXeO+1orzKF
 9SiEutTLTyNwZZORg9NuzyO2N/jRQMbiMdqu/IqVH3HJS6ie8Sc/g==
X-Received: by 2002:a05:6000:2cd:b0:382:498a:9cf5 with SMTP id
 ffacd0b85a97d-38260b5ae29mr17875619f8f.14.1732644157083; 
 Tue, 26 Nov 2024 10:02:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGc+IpXjVRsDJexVrYAd43JWmOHWQ+E3QDWjASMZY2qGG3x9J3fh/SyMQqjTQGi8jpxMh8HbQ==
X-Received: by 2002:a05:6000:2cd:b0:382:498a:9cf5 with SMTP id
 ffacd0b85a97d-38260b5ae29mr17875377f8f.14.1732644154939; 
 Tue, 26 Nov 2024 10:02:34 -0800 (PST)
Received: from [192.168.10.3] ([151.49.236.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb2760asm13870895f8f.52.2024.11.26.10.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 10:02:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Rust in QEMU roadmap
To: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Date: Tue, 26 Nov 2024 18:46:45 +0100
Message-ID: <cc40943e-dec1-4890-a1d9-579350ce296f@pbonzini.local>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

[several people are in bcc.  You can follow the thread at
 https://lore.kernel.org/r/cc40943e-dec1-4890-a1d9-579350ce296f@pbonzini.local]

Based on the content presented in the community calls, here are some
ideas for future Rust in QEMU subprojects.

This is by no means exhaustive, for example QAPI and async (block devices)
are missing because I have not looked at them.

Table of contents
'''''''''''''''''

* Status in QEMU 9.2
* Build system
* Feature parity for pl011 device
* Avoiding undefined behavior
* Safe QOM class definitions
* QOM method calls
* Callbacks
* Tracing/logging
* Data structure interoperability
* Features expected from recent rust


Status in QEMU 9.2
''''''''''''''''''

QEMU when built with --enable-rust compiles on all supported
build platforms.  It passes CI and "make check-unit" runs tests for
rust/qemu-api.  "make check-qtests" covers the Rust pl011 device model
including migration.  However, Rust is not enabled and its presence is
not checked for by default.

Lots of unsafe code is needed to define classes, define callbakcs, and
invoke any core functionality.  That said, the current pl011 code provides
a good roadmap for what functionality Rust code needs more urgently.

Zhao Liu is working on a conversion to Rust of the HPET device.  It has the
same limitations, but it covers a slightly different set of functionality
(e.g. timers) and it provides a second device with which to validate
the abstractions that are being built.  However, including any device
beyond these two should (in my opinion) wait until FFI abstractions are
ready and usage of unsafe code is limited (especially after initialization).

For now we're looking at simple devices.  These do not do any DMA or
memory allocation; there is hardly any benefit from Rewriting In Rust.
However, they are small and self-contained, and let us learn to walk
before we try to run.

For anybody who wants to work on FFI, it is highly recommended to consult
the subsystem maintainers and to post *early and often*.  Also include
links to the mailing list threads in https://wiki.qemu.org/RustInQemu.


Build system
''''''''''''

Posted: https://lore.kernel.org/qemu-devel/20241108180139.117112-1-pbonzini@redhat.com/

This provides developers with easy access to clippy, rustfmt and rustdoc;
and in general Cargo is the easiest way to integrate tools other than rustc.
This series also makes it possible to configure warnings with the familiar
syntax provided by Cargo.toml.

Next steps:

* Access to clippy and rustfmt could be done by Meson, similar to its
  existing "ninja clang-tidy" and "ninja clang-format" targets.  This
  removes code from QEMU and more importantly avoids that every mixed
  Rust/C project reinvents the wheel.

* rustdoc tests should be integrated into "make check".  Running "cargo
  test --doc" has the limitation that the tests are not able to link with
  C code.  I have prototyped this, but mostly to teach myself how rustdoc
  tests are run and implement them in Meson.

Long term a separate rust/ directory probably will not exist, and it'd
be nice to avoid having a proliferation of src/ directories since QEMU
has hundreds of devices.  It will be interesting to see whether at that
point there will still be a need for Cargo, or whether all required
functionality will be included in Meson before we get there.

Summary:
* The series is mostly Python and Meson code so I am comfortable merging
  it in 10.0

* Long term, cargo-like functionality should be provided by Meson.  In
  the meanwhile it can be implemented by hand, but we should upgrade
  to Meson 1.7.0 if it comes out with native support for clippy and
  friends.


Feature parity for pl011 device
'''''''''''''''''''''''''''''''

Some recent pl011 commits are missing in the Rust version.  Philippe
volunteered to port them to teach himself Rust.

Philippe also has a series to implement flow control and better use
of the PL011 FIFO (IIUC).  Porting this to Rust would be hard right
now, so its Rust implementation blocked on having chardev bindings.

Also missing is logging and tracing, but this part should not be a
blocker for defaulting to --enable-rust.

Summary:

* Philippe's FIFO work might impact the plan of defaulting to
  --enable-rust as soon as 10.0.


Avoiding undefined behavior
'''''''''''''''''''''''''''

Part 1: https://lore.kernel.org/qemu-devel/20241122074756.282142-1-pbonzini@redhat.com/

Currently, the Rust in QEMU code is not respecting the invariant that
mutable references must be either unique or obtained from an UnsafeCell<>.
It's also in some cases creating references (either shared or mutable)
that point to invalid data, for example NULL references.  This was
a necessary evil to be able to have *some* Rust code in tree and
develop build system integration, but it obviously has to be fixed.

The first part is solved by annotating the code to use the proper
interior mutability types.  These include homegrown variants of Cell
and RefCell that support the "big QEMU lock", and therefore are
usable in a multi-threaded context.  In particular, QEMU's variant of
RefCell will also check that bql_unlock() is never called with outstanding
borrows.

The second part is solved by using Linux's pinned-init crate, which is
available for use in userspace on crates.io.  The pinned-init crate avoids
exposing partially-initialized objects to safe Rust code.  Right now
it only supports nightly Rust, but I've sent a pull request to fix this;
supporting Debian's rustc 1.63.0 of this pull request is not an issue.

Summary:

* Introduce cell types as needed.  BqlCell was posted, BqlRefCell is
  written but does not have a use yet.

* Using pinned-init is planned but will come later.


Safe QOM class definitions
''''''''''''''''''''''''''

Part 1: https://lore.kernel.org/qemu-devel/20241125080507.115450-1-pbonzini@redhat.com/

QOM's object-oriented, inheritance heavy design is a challenge for Rust,
but fortunately we can learn from the experience of glib-rs developers.
There are two orthogonal parts to making QOM accessible from safe,
idiomatic Rust code: namely, defining QOM classes and calling QOM methods.

With respect to defining QOM classes, it is expected that Rust code
will mostly define *leaf* classes, which simplifies the task a bit.
Or at least, that any superclasses defined by Rust code will only be
subclassed in Rust as well.

A first attempt at this was posted by Manos, but in the review I
commented that his procedural macro approach was limited to subclasses
of DeviceState.  It would be much better to have something more easily
adaptable to other classes.

For now I've posted a series that removes code duplication but is still
very much focused on four elements of DeviceClass (realize, legacy reset,
properties, vmstate).  This part is simple.

A second step is to encode the QOM hierarchy in the type system.  A new
ClassInitImpl<ClassType> trait initializes the methods of a specific
class, for example DeviceClass, and then "recurses" to the superclass::

  trait ClassInitImpl<ClassType> {
    fn class_init(class: &mut ClassType);
  }

  impl ClassInitImpl<DeviceClass> for T where T: DeviceImpl {
    fn class_init(class: &mut DeviceClass) {
      dc.realize = rust_realize_fn::<T>;
      ...
      <Self as ClassInitImpl::<ObjectClass>>::class_init(class.parent_class);
    }
  }

  impl ClassInitImpl<ObjectClass> for T where T: ObjectImpl { ... }

This generalizes the class_init implementation that is in the already-posted
part.  The same pattern of recursion can be used to support QOM interfaces
as well.

Summary:

* Reviews are welcome on the first part.  Hopefully when I post the second
  (mid December?) the first will have been reviewed at least in part.

* Procedural macros still remain a valuable tool.  Using them for qdev
  properties should be easy to extract from Manos's submission.  In the
  review I also proposed building a small "toolkit" that can be reused
  by more procedural macros in the future.


QOM method calls
''''''''''''''''

This is a separate branch of QOM work that I had started last July, by looking
at glib-rs's implementation of GObject.  The idea is to be able to write code
that looks like native Rust but calls QOM methods.  For example::

   let dev = PL011State::new();
   dev.prop_set_chr("chardev", chr)
   dev.realize().unwrap_fatal();		// operate on Error**
   dev.mmio_map(0, addr);
   dev.connect_irq(0, irq);
   Object::into_raw(dev)

Note how methods can come from multiple classes (DeviceState, SysBusDevice,
even Object in the case of "new").  This makes it harder to implement devices
as something like SysBusDevice<PL011Properties, PL011Registers>; you'd still
have to surface methods in superclasses of SysBusDevice, for example
"prop_set_chr" or "realize" in the above example.

glib-rs's implementation is based on an IsA trait that has to be written
by hand (e.g. PL011State implements IsA<Object>, IsA<DeviceState>,
IsA<SysBusDevice>).  Rust's automatic dereferencing behavior can then be
extended to all superclasses; wrappers for methods are implemented in a
trait::

  trait DeviceMethods {
    fn realize(&self) -> Result<(), qemu_api::Error> {
      ...
      device_realize((self as *const _).cast_mut().cast::<DeviceState>, ...);
      ...
    }
  }

and the trait is applied to everything that dereferences to a subclass of
DeviceState::

  impl<R: Deref> DeviceMethods for R where R::Target: IsA<DeviceState> {}

Related to this, the IsA trait allows typesafe compile-time checked casts.
Unlike in C code, casting to a superclass can be written in such a way
that the compiler will complain if the destination type is *not* a
superclass, and with zero runtime cost.

Callbacks
'''''''''

This is the least mature of the "urgent" changes, and perhaps the more
important to have a good design for.  PL011 has callbacks for character
devices and memory regions, but other usecases include timers, bottom
halves and interrupt sinks (aka GPIO inputs).

So far all I have is a silly 100% Rust example that uses callbacks
as you would have find tham in C (so with function pointers and void*
opaques); it then implements "bindings" where you write a Rust trait
and the function pointers are filled in automatically.  You can find it
at https://gist.github.com/bonzini/2c63a905851f4f78573d022b1f196f4f.
The reason for doing this exercise with Rust, despite the code
looking nothing like idiomatic Rust, is to make sure that Miri (Rust's
experimental "undefined behavior detector") likes it.

HPET, which Zhao is working on, is particularly interesting because it
also has *arrays* of timers.

Summary:

* This requires some adventurous person to look at it.  It's not impossible
  but it's both harder and high priority.

* Linux has some examples but they are really hard to follow.  If anything
  easier is possible at the cost of leaving some easily-verifed "unsafe"
  blocks (and still provide safe callbacks for timers, memory regions, etc.)
  that may be a better short term plan.


Tracing/logging
'''''''''''''''

Tracepoints and logging are not supported yet, and no one has started working
on it.

For tracing, it's not clear to me how much C code can be reused and how
much Rust code can be automatically generated.  This would be a valid
Outreachy or Summer of Code project, as it has a limited need for unsafe
code and a well-defined scope.

A pure-Rust implementation would be interesting, but note that the usage
of printf-style %-based field formatting is pervasive in the tracing
subsystem.

Logging is a small component of QEMU and it's a good opportunity to define
a coding style for C code translated to Rust, e.g. how to name enums and
functions.  My only request is to allow using the same syntax as format!()
for logging code!

Summary:

* Simple, low priority.

* Anybody wants a small project to learn Rust FFI?


Data structure interoperability
'''''''''''''''''''''''''''''''

The poster child here is "Error", i.e. providing an easy way to convert
from QEMU's Error object to Rust's Error trait and back.

Both Marc-André and I have worked on this with two different approaches.
Marc-André based his on glib-rs, which focuses on the desired ownership
semantics (i.e. whether the resulting data is owned by Rust or C) because
glib-rs in turn was inspired by GIR (the GObject cross-language
introspection interfaces).  Mine instead tries to extend the ideas
behind the Rust traits From<>/Into<>/Clone to provide conversion and
cloning of Rust objects into C objects and vice versa.

The primitives are similar:

    from_glib_full          from_foreign
    from_glib_none          cloned_from_foreign
    to_glib_full            clone_to_foreign_ptr
    to_glib_none            clone_to_foreign

though the design and code are very different

Summary:

* I am obviously biased, so this needs more brains to help with the design.
  It's not urgent but it has to be figured out before we get to QAPI.  Maybe
  even asking on users.rust-lang.org could be an idea.

* I'm not planning any work on this for now, but I'd like whatever approach
  we choose to be an external crate that is developed outside QEMU and just
  used by it.


Features expected from recent rust
''''''''''''''''''''''''''''''''''

QEMU supports rustc version 1.63.0 and newer.  Notably, the following features
are missing:

* ``core::ffi`` (1.64.0).  Using ``std::os::raw`` and ``std::ffi`` instead.

* "let ... else" (1.65.0).  Using ``if let`` instead.  This is currently patched
  in QEMU's vendored copy of the bilge crate.

* ``CStr::from_bytes_with_nul()`` as a ``const`` function (1.72.0).

* MaybeUninit::zeroed() as a ``const`` function (1.75.0).  QEMU uses a
  ``Zeroable`` trait, and you can implement it to provide by hand a
  ``Zeroable::ZERO`` associated constant.

It is expected that QEMU will advance its minimum supported version of
rustc to 1.75.0 as soon as it stops supporting Debian bookworm.  However,
the following will still be missing:

* c"" literals (stable in 1.77.0).  QEMU provides a ``c_str!()`` macro
  to define ``CStr`` constants easily, so no big deal.

* ``offset_of!`` (stable in 1.77.0).  QEMU uses ``offset_of!()`` heavily and
  provides a ``const``-friendly replacement in the ``qemu_api`` crate.
  Also note that *nested* ``offset_of!`` was only stabilized in Rust
  1.82.0, which will probably be useful as soon as we start using BqlCell
  and BqlRefCell more widely.  So we'll be stuck with our replacement
  for a while.

* ``&raw`` (stable in 1.82.0).  Using ``addr_of!`` and ``addr_of_mut!``
  instead, though hopefully the need for raw pointers will go down over time.

* ``new_uninit`` (stable in 1.82.0).  This is used internally by the
  ``pinned_init`` crate, but it can be patched easily when/if QEMU vendors a
  copy of the crate.

* referencing statics in constants (stable in 1.83.0).  For now, using a
  const function is the sole alternative.


QEMU also supports version 0.60.x of bindgen, which is missing option
``--generate-cstr``.  This requires version 0.66.x and will be adopted
as soon as supporting these older versions is not necessary anymore.
This only affects a handful of places, which are easily found as they'll
not compile anymore once the option is addde back.


