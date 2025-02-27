Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46227C19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnemw-0004my-Vc; Thu, 27 Feb 2025 09:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnemW-0003la-BM
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:22:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnemR-000441-7s
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:22:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4VkJ57zjgyHFgj0AXjaq86EaB5VXCZKU4ItaWiQb4aQ=;
 b=O6cv9WmnfGzG8PdRLxCBwyxogXWum3EYtDI2CCD6HraU6JYLrVYA/K1EFkSST6y7vj0oWR
 Z15A6Nl+/SunNWwfOGKjO09Qv/pWrlDLXOy0Nq58KxbhEXKBZ75BolUd7Hk8BOXB1VCyXD
 Y9kBxYO07WrxIpKmIo4d81gs8xXamHI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-VTcIe5ynOdOaJYtC1x5jPg-1; Thu, 27 Feb 2025 09:22:23 -0500
X-MC-Unique: VTcIe5ynOdOaJYtC1x5jPg-1
X-Mimecast-MFC-AGG-ID: VTcIe5ynOdOaJYtC1x5jPg_1740666142
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa6b904a886so89205566b.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666141; x=1741270941;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4VkJ57zjgyHFgj0AXjaq86EaB5VXCZKU4ItaWiQb4aQ=;
 b=RyGyP3Xu/W6Mru9Ku+PtqK5NmpQsHR+Eu1VPK0GQjPIUeCao+cCAj688BxoTv0uHva
 48hGBJF+krMbrReVnvakIYk2AncchyJjKE3oMyC0A777jpoKKbjR8K5Ot1Cin312CHS6
 oAXWtaNTwfD/4e03RmUl6VY9iLQN3W/9+zOMsw54wO+fbis3wQq5gERqXrvKnV7zlWxQ
 Ro9BD+wUJPy/G8X/uwwJzHkP8fxjrpe0T36qqEDbgJngk/A3QJRAyDglmSHJ57qifEgv
 7CcnfJHwt2W2eoCFrKOHR6vCasN1yUqC1gHQqagiPcTNLb5g7W6OfyYe+GS6G4PjQpZv
 6LdA==
X-Gm-Message-State: AOJu0YxOHvpRsCByEXAVmLAYHgtAqJunDHSUASURXsQe809AXjrFgepF
 WyKURvrp5pIJWv7o2ea7wty3IgetV5jiQTpo/sqR5HGYX2I573IWOM4vwbqydFYgtwKorygR4kw
 iQp7xCCxZu/bIoCDiAJ9wG4FsgHvcAD6jMy0n8UAcII3z/UqEBJe6qOYQ5HjH/EB9xPgOeRmvjB
 G2Z4NXaP0YXxo/WdpVwn4YWVPlL333JlrHBCkMbvQ=
X-Gm-Gg: ASbGnctC/UxnwBnyH/L3FGEo6cnfPFTTO4wexXYPtg7CpNhScMh0NxoXSeUWUncaYKV
 efX6pcsmf0uMmmkYhORVG8Dl+FSIcKBpUT+hrwxZ+yRLiA0X+wenE4Dz/iG6JAExBRQkELLOF/e
 ym5SWNxcJ5kG/BnC0hFqIgoBhFYOmiaiyjj88tqovhH3pHRolWwTPpDExmoEqNoNFc85QpUhtyS
 GfF/ph51G/MoMH4PnxLNhdTnB7x8WzH+pUeQ9jMvQhAFqP/pPdGLdxH+sUe4vB77Z2hQkdydHQj
 yjZW9y/v332ky7/JVU9d
X-Received: by 2002:a17:906:bc55:b0:abc:29a2:f6cf with SMTP id
 a640c23a62f3a-abc29a2f975mr1967489166b.19.1740666141248; 
 Thu, 27 Feb 2025 06:22:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfOyAtyO7UXx6Jz11MRWvY8ssv+d7lcnv9b6HROoKZ2vu3FvYPvy0Oo3WROz7zqooaaQ9X7Q==
X-Received: by 2002:a17:906:bc55:b0:abc:29a2:f6cf with SMTP id
 a640c23a62f3a-abc29a2f975mr1967487266b.19.1740666140831; 
 Thu, 27 Feb 2025 06:22:20 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf181e0712sm82538066b.182.2025.02.27.06.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:22:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH v2 00/12] rust: wrap all C types exposed through qemu_api
Date: Thu, 27 Feb 2025 15:22:07 +0100
Message-ID: <20250227142219.812270-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This is the second part of "rust: prepare for splitting crates" with
Zhao's suggestions addressed and with more precise handling of pinning
for Timers.

The series introduce a third generic type in qemu_api::cell, Opaque<T>.
This type is similar to a same-named type in Linux; it is basically a
"disable all undefined behavior" switch for the Rust compiler and it
helps maintaining safety at the Rust/C boundary, complementing the
existing BqlCell and BqlRefCell types.

Apart from making things more formally correct, this makes it possible
to implement methods on a struct that is distinct from the one produced
by bindgen.  This has a couple of advantages:

- you do not have to disable the Copy trait on structs where you want
  to add a Drop trait.  This was already a problem for the Timer struct.

- whether Send and Sync are implemented is entirely a decision of the
  place that implements the wrapper.  Previously, a struct with no
  pointers for example would have been always both Send and Sync,
  whereas now that can be adjusted depending on the actual
  thread-safety of the Rust methods.

- more pertinent to the "multiple crates" plan that prompted posting
  of v1, you do not have to put the methods in the same crate as the
  bindgen-generated bindings.inc.rs.

It also makes Debug output a bit less unwieldy, and in the future one
might want to add specialized implementations of Display and Debug that
are both useful and readable.

Paolo

Supersedes: <20250221170342.63591-1-pbonzini@redhat.com>

v1->v2:
From Zhao's review:
- fix Opaque::zeroed()
- improve comments for as_mut_ptr() fand as_void_ptr()
- remove unnecessary ".0" accesses, or highlight why they're needed
- add patch to access SysBusDevice MMIO addresses safely

Other changes:
- improve safety comments for constructors of Opaque
- remove implementation of Default for Opaque<T: Default>,
  leaving Opaque::new() in but only as an unsafe function
- change Timer patch to construct timers as Pin<Box<Self>>,
  following the documentation of `Opaque<>`
- add "rust: vmstate: add std::pin::Pin as transparent wrapper"

Paolo Bonzini (12):
  rust: cell: add wrapper for FFI types
  rust: qemu_api_macros: add Wrapper derive macro
  rust: vmstate: add std::pin::Pin as transparent wrapper
  rust: timer: wrap QEMUTimer with Opaque<> and express pinning
    requirements
  rust: irq: wrap IRQState with Opaque<>
  rust: qom: wrap Object with Opaque<>
  rust: qdev: wrap Clock and DeviceState with Opaque<>
  rust: hpet: do not access fields of SysBusDevice
  rust: sysbus: wrap SysBusDevice with Opaque<>
  rust: memory: wrap MemoryRegion with Opaque<>
  rust: chardev: wrap Chardev with Opaque<>
  rust: bindings: remove more unnecessary Send/Sync impls

 docs/devel/rust.rst             |  36 +++--
 meson.build                     |   7 -
 rust/hw/timer/hpet/src/hpet.rs  |  27 ++--
 rust/qemu-api-macros/src/lib.rs |  86 +++++++++++-
 rust/qemu-api/meson.build       |   7 +-
 rust/qemu-api/src/bindings.rs   |  26 +---
 rust/qemu-api/src/cell.rs       | 228 +++++++++++++++++++++++++++++++-
 rust/qemu-api/src/chardev.rs    |   8 +-
 rust/qemu-api/src/irq.rs        |  15 ++-
 rust/qemu-api/src/memory.rs     |  37 +++---
 rust/qemu-api/src/qdev.rs       |  75 +++++++----
 rust/qemu-api/src/qom.rs        |  35 +++--
 rust/qemu-api/src/sysbus.rs     |  40 +++++-
 rust/qemu-api/src/timer.rs      |  47 ++++---
 rust/qemu-api/src/vmstate.rs    |   3 +-
 15 files changed, 527 insertions(+), 150 deletions(-)

-- 
2.48.1


