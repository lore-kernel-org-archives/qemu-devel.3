Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BB9C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 10:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcigy-0003Dy-RY; Tue, 28 Jan 2025 05:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1tcigx-0003DF-8r; Tue, 28 Jan 2025 05:19:35 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1tcigt-0006Rp-Rg; Tue, 28 Jan 2025 05:19:35 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361c705434so38224875e9.3; 
 Tue, 28 Jan 2025 02:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738059569; x=1738664369; darn=nongnu.org;
 h=content-transfer-encoding:autocrypt:subject:to:from
 :content-language:user-agent:mime-version:date:message-id:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kf41wgzyr2n/Fd+1qTjkJIcBK5C8KR55bbd0D0ZiFpQ=;
 b=nLFmc6Y/S+DETtBYjMfLhHLA855HoyeDq98pG3ZWb8llTCB8wfBTpKWB8obfwWPPUg
 T5Ye8j8TH2i2PYPhpi9Tcd0DI7lhUc4z2YAPmlAcd8W6RmvaNAatggcl6InKI44XmtEC
 Gv24tGfBGefSsgWF//Hl9omXJ7iTM3IWL1284VbDojTFG+wfsznCuulorvT3IQREjsho
 m3ORrXP6epdI+qdIZMR1IDRScuBgeHU8DxJ+4kTsvINJvyChqgDGl89s2Lu/Ryyx3uqK
 hSzlAt9pbEEULc9zrI7X/C0eH8+J0xr4f4QLIgijD+lZwKRZGFxklHF9/hdKM2jhZvG3
 Orfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738059569; x=1738664369;
 h=content-transfer-encoding:autocrypt:subject:to:from
 :content-language:user-agent:mime-version:date:message-id:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kf41wgzyr2n/Fd+1qTjkJIcBK5C8KR55bbd0D0ZiFpQ=;
 b=ZGJGgkgpRoCGapCEmP43oZWEKfgMv5k16o9Foz0iGtXLlLl++nj4y51+hGzPuQ8V+g
 9Ee1EgUazvUI+6y4fwHiF6Jqveqq7YlYBexHi8nBsl6BzJ6LHFLURGtvsdqVX/+ZHZls
 YSfG1r3dD7akmPTrf01wEZQmAQdOZSiPyofqX3foGaov1/witr0GndGji8CfYSXY5gkp
 Y5a0AM5Bs1Mcwb/Yo7X2XovVJz9fD5mcYp3i98DdG+IZQhdE1s1MJbkW6ZcphiO7g3jo
 nvHENea+VMNtOMEV4870JmgKO7sfWCBJOx7toyrp86t1KSqc/EyhryQobc1z7E7DpyfN
 ossw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVeBL0NvwMZ6NM/H4TU8KH6PVLcXV5ST0KvJCVQpPqa2LWvk8zHD45BQMHQi4COoGzu3A+CZV1lkw=@nongnu.org
X-Gm-Message-State: AOJu0YwWNh2ex6N+OXqYNsqeKVFpDcTSVxNLQvFuGbHxeo95GU3t19dg
 VfBJR6pr99/CBfAn8ISGsNehB9yuRenKMOHbTr5AF+z9l/3sXTx1A0oBgQ==
X-Gm-Gg: ASbGncvGak+DSC3O/MNB95iVb0+ZHBMn2gyDXHErXN/DnKSJ8u2mk0aSEUeT3pbX325
 OqIzYY/n6qyotMaeTe/uL+lzp8yIDegQ/pIeYC0Nf8Q0eYnpCwlUNAMk522G4xUXtEJaMWsBJwY
 aWVFEeFZgN3W1H7ItHAs4JJDfj/6NLuLQHodHjyRCAZymlzFNSx4B/qPHGA1YgwRMvhbWq5Jp/M
 53XYbjhv1gqCu/egqAftDnSg6BHuHHQfHmvzSER4x7zk9PtQFroLJRXdCgtygtexq8DJ8TB8+G+
 7SHt/VohnAmmPvH01ECIUZXt
X-Google-Smtp-Source: AGHT+IEf8TOiorpZ2aFQpRRxsHCQUBjqm4akX8lzR5iWuO2739RUYRseTbAD9yAQetkmH0V/g6WNZA==
X-Received: by 2002:a05:600c:1e1b:b0:434:f917:2b11 with SMTP id
 5b1f17b1804b1-43891429682mr359065345e9.21.1738059569134; 
 Tue, 28 Jan 2025 02:19:29 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-438bd57545dsm165494725e9.40.2025.01.28.02.19.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 02:19:28 -0800 (PST)
Message-ID: <17ad81c3-98fc-44c2-8f65-f5e2cc07030b@gnu.org>
Date: Tue, 28 Jan 2025 11:19:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Paolo Bonzini <bonzini@gnu.org>
To: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: Rust in QEMU update, January 2025
Autocrypt: addr=bonzini@gnu.org; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.038,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

It's been roughly two months since my previous posting of a roadmap
for Rust in QEMU, so it's time for an update.  While the project is
still at an experimental phase, the amount of functionality available
from safe Rust is enough that it could be considered for new devices.

As before, this mostly covers what I have looked at, which is making
it possible to write devices in safe Rust.  Topics such as QAPI and
async (block devices) are missing for this reason. An "⚠️" icon marks
the most important missing features.

Table of contents
'''''''''''''''''

* Status in QEMU 10.0
* Build system
* Feature parity for devices
* Avoiding undefined behavior
* Bindings to C code
* New utility code
* Rust version requirements
* Next steps


Status in QEMU 10.0
'''''''''''''''''''

QEMU when built with ``--enable-rust`` compiles on all supported
build platforms.  It passes CI and ``make check-unit`` runs tests for
rust/qemu-api.  ``make check-qtests`` covers the Rust pl011 device model,
including migration; a Rust conversion of the HPET device is available
on the mailing list, and will probably be merged in the next few weeks.

The amount of unsafe code needed to define classes, define callbacks,
and invoke core QEMU functionality has gone down a lot since 9.2,
especially if you count a few more pieces that are posted and pending
review.  QOM objects can be created and their lifetime managed using
entirely safe code; unlike C code, Rust is able to differentiate embedded
objects (which do not have an independent reference count) from those
that are allocated in their own heap block.  Available bindings include
sysbus devices, GPIO pins, clocks and MemoryRegionOps and timers;
Kevin Wolf is working on the block layer and on using Rust in tools.
There are also core building blocks that make it much easier to extend
the C<->Rust bindings.

Last December I posted a comparison between the pl011 C implementation
and the "intended" shape of the Rust code; at the time of the posting
(https://lists.nongnu.org/archive/html/qemu-rust/2024-12/msg00006.html)
the code compiled but was far from being usable.  The in-tree Rust
implementation of pl011 is now very similar to that intended shape,
the main exception being character devices and safe ``instance_init``.


Build system
''''''''''''

Developers can use ninja to easily access clippy, rustfmt and rustdoc.
Meson 1.7 supports clippy natively, with a rustdoc pull request
in progress.  This is important because long term it would be nice to
avoid having a proliferation of src/ directories since QEMU has hundreds
of devices.

A Meson pull request is also in progress that add support for doctests,
integrating them into ``make check`` and allowing them (unlike ``cargo test
--doc``) to link with C code[1]_.

⚠️ Modules do not work with Rust code yet due to a limitation of
rust/qemu-api/meson.build.  The fix for this is also in Meson and there
is a pull request open for this as well[2]_.

Rust is still not enabled and its presence is not checked for by
default.  If any devices are contributed that are written in Rust and
do not have a C counterpart, it may be worth splitting "enable Rust"
from "enable all devices written in Rust".

.. [1] https://github.com/mesonbuild/meson/pull/13933
.. [2] https://github.com/mesonbuild/meson/pull/14031


Feature parity for devices
''''''''''''''''''''''''''

⚠️ Some recent pl011 commits are missing in the Rust version.  Philippe
volunteered to port them to teach himself Rust.  Some issues in the
ported device are now fixed and the migration stream is compatible
between the Rust and C versions.

⚠️ Philippe also has a series to implement flow control and better use of
the PL011 FIFO (IIUC).  Porting this to Rust would be hard right now,
so its Rust implementation blocked on having chardev bindings.

⚠️ HPET is lacking support for live migration.

⚠️ As before, also missing is logging and tracing.


Avoiding undefined behavior
'''''''''''''''''''''''''''

Interior mutability types specific to QEMU---homegrown variants of Cell
and RefCell that support the "big QEMU lock", and therefore are usable
in a multi-threaded context---are included in tree, and used by the
pl011 and HPET device models.  This means that Rust code is now
respecting the invariant that mutable references must be either
unique, or obtained from an ``UnsafeCell<>``.

In some cases it is still creating references that point to invalid
data before they are initialized; this will be solved by using Linux's
pinned-init crate to implement the QOM ``instance_init`` method.
``pinned-init`` is available for use in userspace on crates.io and
eliminates the need to expose partially-initialized objects to safe
Rust code.

John Baublitz pointed out more cases of fields that should also be
included in a cell, because they are modified by C code.  These
include fields for qdev properties, and the C structs for QOM
classes.  The issues here are a lot more theoretical than the
rest, and Linux provides examples of how to deal with them too.


Bindings to C code
''''''''''''''''''

Even though QOM's object-oriented, inheritance heavy design is a challenge
for Rust, qdev bindings in QEMU 10.0 are going to be relatively complete,
covering both classes and interfaces.  Thanks to a new callback
functionality, devices have access to GPIO pins, timers, clocks and
MemoryRegionOps.  This should be enough to implement devices with very
limited use of unsafe code.

One area of development that was not mentioned in the previous roadmap
is VMState.  While a direct port of the C macros was part of 9.2, it
required a large amount of macros, and especially it was not type safe.
The latter actually made the Rust version worse than the C code and,
while fixable, rewriting it to take advantage of Rust's type system
and const evaluation was a better plan.  The VMState API is not yetfinal
(for example it still needs unsafe callbacks for pre_save/post_load)
but the new version is already a lot easier to use.

The remaining instances of `unsafe` blocks in the pl011 and HPET code
are as follows:

* pl011 needs character device bindings; the code for this is almost
   ready, though it may not necessarily be in 10.0

* HPET does some very simple memory accesses; a good safe solution
   for this may be the ``vm-memory`` crate.  I have not looked into
   using it, but ``vm-memory`` and ``vm-virtio`` were written with
   QEMU's use cases in mind

* as mentioned above, bindings for VMState definitions are also in
   progress and still partly unsafe

* the ``instance_init`` method is using unsafe code until the
   ``pinned-init`` crate is introduced.  ``pinned-init`` will also
   help with creating cyclical data structures

While this may seem a lot, the fact that we can enumerate the uses of
``unsafe`` and plan their removal is already a substantial achievement!

The amount of functionality available from safe Rust is enough that
including new devices should be possible, even if they need some unsafe
code for parts of QEMU that do not have bindings yet.

Most devices added to QEMU are simple and do not do any complex DMA.
In the previous roadmap I mentioned that such simple devices have very
little benefit from rewriting them in Rust.  While this is probably
true for devices that exist as C code, there is in my opinion already a
benefit to writing *new* devices in Rust.  The code is generally clearer
and so are some aspects of the semantics (e.g. which fields are mutable);
the main limitation is lack of support for tracing and logging.


New utility code
''''''''''''''''

The qemu-api and qemu-api-macros crates now include more utility code
for use in both bindings and devices, including:

* bit-twiddling extensions for integers

* a procedural macro to convert between enums and integers

* callback support

Callbacks are the best and most unexpected news since the last roadmap
post.  The solution implemented in the qemu-api crate makes it possible
to convert a Rust function and a reference into a function pointer and
an opaque value; generics are used to create separate trampolines (i.e.
separate function pointers) for each Rust function.  This mechanism
is used by clocks, timers, memory regions and character devices; so
this part can be considered solved.

The qemu-api-macros crates has also grown a small set of utility functions
that can be reused by more procedural macros in the future.

One utility that I'm missing is bit-flag enums.  The most
commonly used crate in the Rust ecosystem is bitflags
(https://docs.rs/bitflags/2.6.0/bitflags/); it does not have any
dependencies so it is easy to incorporate in QEMU if desired.


Rust version requirements
'''''''''''''''''''''''''

Compared to the previous roadmap, the main change is that three features
have become a bit more pressing:

* while pinned-init's code only needs small changes to support Rust 1.63.0,
   it relies heavily on ``impl Trait`` return types; trait functions however
   can only return ``impl Trait`` since Rust 1.75.0.  Because instance_init
   is itself in a trait, this is an important limitation which might delay the
   inclusion of pinned-init; the only supported distro with an older rustc
   is Debian bookworm.

* references to statics in constants (stable in 1.83.0); the main place
   where ugly workarounds are needed is VMState.

While none of these are blockers for enabling Rust, the first two add a
small amount of technical debt for each Rust device that is added to QEMU.
It may be appealing to use the ``rustc-web`` package on Debian bookworm,
which provides the 1.78.0 version of rustc as of this writing.


Next steps
''''''''''

Two areas that were mentioned in earlier discussions have seen no
activity yet:

* Tracepoints and logging are the highest-priority missing feature, perhaps
   together with DMA; while the current set of device only has a limited set
   of tracepoints, observability is obviously important as a debugging tool.
   This is the main blocker before implementing new devices in Rust can be
   encouraged.

* interoperability between QEMU's C data structure and Rust counterparts
   has no news either.  We'll figure it out as soon as we need a realize()
   implementation that can fail, or when tackling QAPI.

On top of this it may be worthwhile to investigate again using procedural
macros to simplify declaring QOM/qdev classes, such as for qdev properties.


