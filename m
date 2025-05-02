Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802DAC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 12:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uApH4-0002RK-KZ; Fri, 02 May 2025 08:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1uApGm-0002IO-QF; Fri, 02 May 2025 08:13:36 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1uApGg-0003oI-Q9; Fri, 02 May 2025 08:13:30 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so7600825e9.2; 
 Fri, 02 May 2025 05:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746188003; x=1746792803; darn=nongnu.org;
 h=content-transfer-encoding:autocrypt:subject:to:content-language
 :from:user-agent:mime-version:date:message-id:sender:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kzbgIF2R4BmQG6hvHHM1m0KdgHe5HWz/76KhUbeeolg=;
 b=mUaFSIiIdoooTrOjBsmJDd/6oyfaZrqIZTSY2y+Gws77+TwFA5Im15fpCSSB+GlpX7
 KAOIa6z0j+Hp444sKSsd7aW5UQSuDza5JH+qstxziMcbY5KeYqqpjEf23ORPzCrWTLJd
 ecTYinlCMU5u3zzKovNI/royJDSWkZA7ow1kUZrF0QDLVIv92ZKhABoLKHOgQubAoJ4o
 TC8I5vWuVPPYfgKi7pwDpQjaXWe7CQtx67+SsY0BvzEZYe8t3fkAMR6RAWvUcT+8vhYY
 ANeJ6Bk3swYWhc/MqdoHz8EeMXnj3iiJXR8cdcKNk2ytA6M9fzntXnKI7QKxwAFEaYio
 /WMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746188003; x=1746792803;
 h=content-transfer-encoding:autocrypt:subject:to:content-language
 :from:user-agent:mime-version:date:message-id:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kzbgIF2R4BmQG6hvHHM1m0KdgHe5HWz/76KhUbeeolg=;
 b=lJ9qnjJIe9iT/gLEyMYorXADdxRJkghlAaJOi5mBzwb7QLFanZaSpae6HGxIoTdPTV
 xw/a6SgF2D36yf2pWoXYdW9Cdm+QXH+2pDuUE69pXWeSQluEa1vVdrMpCl9+O5i9bOV6
 x5xCzXdDi2oa7IBfKaYhPl8QO6CP02fArLLi03adZz3AJgXV988Zq6HV9SSYqAPJpWXC
 VFijthk54wylHta57Lj7emmvviut85mRUo7XXEO8xo84g1h0JwS00QirMvXMeVskS2U8
 dC8oP/qnq90tGVmcEEjKcv86peD0r40l7C1stdIJwiOE4Uq/vDuBXtqFjjiZX7Ap9BcL
 h0/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqC1ND06NTIWzgy5Gmm8I7DLItuqOGGmhi1YDK8DseLLDkdlYWOXjBIraUwjCN+1uEZtIljhgsU6s=@nongnu.org
X-Gm-Message-State: AOJu0YwyYqNbqLVnQo148usDHVhIzI4CVHiSbJptcXooTp/CVKqUmar/
 feZ/m+/Xh2eQgLRSdV5/0zG9zK5jToj4R2DyXKQe5q7a9kqSNGklR7Bzyw==
X-Gm-Gg: ASbGncuXbfXDespiqY2lQYHICx2L3/23eudPRIvUcZpqoPth4VAG5mI+xjQSS9KI5yo
 I9vgZ8kzwJLcQzps2Jy1s4fN4/9pgxZ430AsZI5qNCIr8MyPkafGKTCiQzmg94x6Pg+BwC1g2iX
 gyoq7C99zI+DDGAT393WsVVvyQSkrFcmMPCRJFhMktr6A4YsOkdsMEVpeNbRelVmXIJS8J4yoiY
 U6Di+GdLex+aU2k8v0KmygJI8COC9iFI3pSRpsNuJ26+uXDeXDTxX/1Pr1d+RievfoX/goBrBA7
 hS7aXa1OcwhmAsj7MX0HHhwAh2BAyjm5hVgXHKE=
X-Google-Smtp-Source: AGHT+IHeLKms8AbS0taiNNqkACRN+JvkisrPtVdc1hqTnMovEosKJgb8Mb8Uqhgq96B3WbUhQ17aDQ==
X-Received: by 2002:a05:600c:154a:b0:43d:209:21fd with SMTP id
 5b1f17b1804b1-441bbf37ec7mr25505155e9.30.1746188002529; 
 Fri, 02 May 2025 05:13:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a099b0fe9dsm1989748f8f.71.2025.05.02.05.13.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 05:13:21 -0700 (PDT)
Message-ID: <d3d1944e-2482-4aa7-b621-596246a08107@gnu.org>
Date: Fri, 2 May 2025 14:13:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Bonzini <bonzini@gnu.org>
Content-Language: en-US
To: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Berrange <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Rust in QEMU update, April 2025
Autocrypt: addr=bonzini@gnu.org; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

It's been roughly three months since my previous update on the Rust in
QEMU project.  Support for Rust remains experimental, with most of the
past three months spent cleaning up the bindings and making more
functionality available from safe Rust.

As before, this mostly covers what I have looked at, which is making
it possible to write devices in safe Rust.  Topics such as QAPI and
async (block devices) are missing for this reason.

Overall, I'd say the progress is good: most of the missing features
mentioned in the previous update have been fixed or at least have a
plan for the next few months.

Table of contents
'''''''''''''''''

* Status in QEMU 10.0
* Build system
* Feature parity for devices
* Remaining unsafe code
* Rust version requirements
* A coding style for devices
* Next steps


Status in QEMU 10.0
'''''''''''''''''''

QEMU when built with ``--enable-rust`` compiles on all supported
build platforms.  It passes CI and ``make check-unit`` runs tests for
rust/qemu-api.  ``make check-qtests`` covers the Rust pl011 and HPET
device models, including migration of the former.  pl011 is entirely
implemented using safe code (minus migration and qdev properties).
HPET uses unsafe in some small and fairly well confined cases (see
below).

Since the previous update, some mistakes in the early bindings code
have become apparent; in particular, orphan rules made it too hard
to implement classes outside the qemu_api crate, and in general to
split the qemu_api crate in multiple parts---for example, parts that
are of interest to tools and parts that are only used by system
emulators.  Another important change is the separation between
bindgen-generated types and the structs that are actually used by
Rust code.  This allows traits such as Send, Sync or Zeroable to be
specified independently for C and Rust structs.

Thanks to Kevin Wolf's work on the block layer a new module appeared
to convert between C success/-errno conventions and ``io::Result``.
This module is also used in character device bindings.


Build system
''''''''''''

Developers can use ninja to easily access clippy, rustfmt and rustdoc.
Meson 1.8 supports clippy and rustdoc natively (including doctests),
but due to some regressions in 1.8.0 this will have to wait for the
next stable release.  This update to Meson will also make it possible
to use --enable-modules and --enable-rust together.

Rust is still not enabled and its presence is not checked for by
default.  The main reason is that Rust staticlibs also link statically
to the Rust standard library, thus bloating the resulting executable
(and making distros hate us as well).  A pending Meson pull request[1]
will fix this, as long as system/main.c is rewritten or wrapped in Rust.

.. [1] https://github.com/mesonbuild/meson/pull/14224


Feature parity for devices
''''''''''''''''''''''''''

Support for HPET live migration is ready to be merged.

As before, some recent pl011 commits are missing in the Rust version.

Logging and tracing were proposed as a project for Google Summer of
Code.


Remaining unsafe code
'''''''''''''''''''''

qdev bindings cover basic classes and interfaces, including
GPIO pins, timers, clocks and MemoryRegionOps.  VMState
still needs unsafe callbacks for pre_save/post_load, with
the final version waiting for a bump of the minimum supported
Rust version to 1.83.0.

Apart from VMState, the remaining instances of `unsafe` blocks in the
pl011 and HPET code can all be removed without bumping the language
version.

HPET does some very simple memory accesses; a good safe solution
for this may be the ``vm-memory`` crate.  While I have not looked into
using it, ``vm-memory`` and ``vm-virtio`` were written with QEMU's
use cases in mind.

The ``instance_init`` method is using unsafe code.  There are multiple
solutions to this: the one I planned for was to use a crate such as
`pin_init <https://docs.rs/pin_init/>`__ or
`pinned_init <https://docs.rs/pinned_init/>`__, but
I have also worked for self-education on a simpler version based on
``std::mem::MaybeUninit`` field projections.  This one removes ``unsafe``
only from the implementation and not from the ``instance_init`` method
itself, but it is less invasive and could be a possibility in the
short term.

The amount of functionality available from safe Rust is enough that
including new devices should be possible, even if they need some unsafe
code for parts of QEMU that do not have bindings yet.  Most devices
added to QEMU are simple and do not do any complex DMA; while such
simple devices have very little benefit from *rewriting* them in Rust,
there will be a substantial benefit to writing *new* devices in Rust as
soon as tracing and logging are supported.  Even though unsafe code in
migration and ``instance_init`` would count as technical debt for every
Rust device that is added to QEMU, I don't expect a flood of Rust devices
in the next few months such that this would be a problem.

There is still no interoperability between QEMU's C data structure and
Rust counterparts has no news either.  As before, we'll figure it out
as soon as we need a realize() implementation that can fail, or when
tackling QAPI.


Rust version requirements
'''''''''''''''''''''''''

Patches are on the list (and have mostly been reviewed) to bump the
minimum supported Rust version to 1.77.0.  However, there will probably
be at least one more bump to support references to statics in constants,
which are stable in 1.83.0 and are important for migration support in
safe Rust.

This will require dropping support for ``--enable-rust`` on Debian
bookworm with a distro-provided compiler.  If any devices are contributed
that are written in Rust and do not have a C counterpart, it may be
worth splitting "enable Rust" from "enable all devices written in Rust".
This way, the C versions of the pl011 and HPET devices remain available
on bookworm.


A coding style for devices
''''''''''''''''''''''''''

pl011 and HPET were developed independently and sometimes have different
idioms that could be unified.  Peter Maydell made several observations:

   Something I do notice is that there's some inconsistency in
   how we've structured things between the two devices, e.g.:

   * the pl011 main source file is device.rs, but the hpet one
     is hpet.rs

   * some places we use the actual names of bits in registers
     (eg Interrupt's OE, BE, etc consts), and some places we
     seem to have renamed them (e.g. pl011 Flags has clear_to_send
     not CTS, etc)

   * pl011 has defined named fields for its registers, but hpet does
     things like::

        self.config.get() & (1 << HPET_CFG_LEG_RT_SHIFT) != 0

   * pl011 has a split between PL011State and PL011Registers,
     but HPET does not. As I mentioned in an email thread a
     little while back, I feel like the State/Registers split
     is something we should either make a more clear deliberate
     formalised separation that's part of how we recommend
     device models should be designed

   [...]

   I think it would be good to figure out what we think is the
   right, best style, for writing this kind of thing, and be
   consistent. We have long standing problems in the C device
   models where there are multiple different styles for how
   we write them, and it would be good to try to aim for
   more uniformity on the Rust side.

One thing that I noticed is that in Rust QEMU code I tend to rely on
``const`` and ``static`` a lot, and several crates are not friendly
to this style, including the ``bilge`` crate that we use for named
fields and others such as ``bitflags``.  In both cases, this is
related to Rust not having const traits, e.g. for ``from()``/into()``
or operator overloading).  I already have a prototype of a bitflags-like
macro that is more const friendly, and we also need to make a decision
on whether to keep using ``bilge``, fork it, rewrite it or whatever.


Next steps
''''''''''

With respect to missing functionality, tracepoints and logging remain
the highest-priority missing feature, perhaps together with DMA, and the
main blocker before implementing new devices in Rust can be encouraged.
Hopefully this hole will be closed over the summer.

On the experimental side, if anybody wants to play with the ``vm-memory``
crate for DMA that would be very interesting.  However, the next steps
I am suggesting are mostly along the lines of cleaning up what is there,
ensuring that we're ready for more widespread usage of Rust in QEMU.

If someone like menial work, splitting the ``qemu_api`` crate is now
possible and a good thing to do.

If someone has good taste, they might go over the code with Peter's
above remarks in mind, cleaning up things so that pl011 and HPET both
provide good examples of Rust code in QEMU.

I also believe it's time to look again at using procedural macros to
simplify declaring QOM/qdev classes.  For example::

     #[derive(qemu_api_macros::Object(class_name="pl011", class=PL011Class))]
     #[derive(qemu_api_macros::Device(vmsd=VMSTATE_HPET))
     pub struct PL011State {
         pub parent_obj: ParentField<SysBusDevice>,
         pub iomem: MemoryRegion,
         pub regs: BqlRefCell<PL011Registers>,
         pub interrupts: [InterruptSource; IRQMASK.len()],
         pub clock: Owned<Clock>,

         #[qemu_api_macros::property(name="chr")]
         pub char_backend: CharBackend,

         #[qemu_api_macros::property(name="migrate-clk", default=true)]
         pub migrate_clock: bool,
     }

Related to this I have found recently the `attrs crate
<https://docs.rs/attrs/>`__, which provides an easy way to parse the
contents of attributes in a procedural macro.

