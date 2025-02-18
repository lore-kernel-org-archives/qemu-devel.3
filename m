Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB56C021AF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 18:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkSD4-0005uN-0q; Tue, 18 Feb 2025 13:20:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkSD1-0005sK-U7
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:20:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkSCy-0007X4-3X
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739902834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zSNbDDPam+yNNrXUgZaHfxSqJukqPkUznRTcWXXd2oA=;
 b=hkphGp0SrHDADhhF3BwlSbLd8BWnjOEOwg3F4ANdXArL2KRS/lLpZ0Uo+cZ9RpeNTdf1DR
 5xd9P0O7OYG9bwskobXZHngHBPCNG95dPnBVfHvE/o0zACKqeci47XXGtU1eAXPwiICeJO
 Tg4Ov1NquqxEuwZ2qmLDbaaAZ3WVi0A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-rMKfVzxtNFCVTnQt_oMGSA-1; Tue,
 18 Feb 2025 13:20:30 -0500
X-MC-Unique: rMKfVzxtNFCVTnQt_oMGSA-1
X-Mimecast-MFC-AGG-ID: rMKfVzxtNFCVTnQt_oMGSA_1739902829
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 820D719783B4; Tue, 18 Feb 2025 18:20:28 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.226.66])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D09A0180087C; Tue, 18 Feb 2025 18:20:25 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: [PATCH v2 00/11] rust/block: Add minimal block driver bindings
Date: Tue, 18 Feb 2025 19:20:08 +0100
Message-ID: <20250218182019.111467-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This series adds minimal bindings for writing block drivers in Rust and
converts the bochs block driver as an example. Some parts (such as the
open functions) are still essentially C written in Rust syntax, while
other parts already try to provide somewhat idiomatic abstractions.

The main purpose of this series is just to add a starting point for
incremental improvements to the bindings; it's clearly not very polished
yet and ignores some important points like enforcing the graph lock.

Therefore, the main focus in the immediate future after this series
should be cleaning up the bochs driver and the bindings it uses rather
than adding more drivers.

Based-on: <20250213143216.3910163-1-pbonzini@redhat.com>

v2:
- Rebased on top of current git master with qemu_api::errno patches
  applied
- Changed 'node' in MappingTarget from a dummy () to Arc<BdrvChild>
- Changed BdrvChild::read_uninit() to use Box<MaybeUninit<T>>
- Use libc crate instead of letting bindgen output EINVAL/EIO
- Fixed errno translation logic, in parts by using qemu_api::errno
- Changed two instances of incorrect *foo = ... into foo.write(...)
- Added rust/block/ to MAINTAINERS
- Some style and readability improvements

Kevin Wolf (11):
  rust: Build separate qemu_api_tools and qemu_api_system
  meson: Add rust_block_ss and link tools with it
  rust: Add some block layer bindings
  rust/qemu-api: Add wrappers to run futures in QEMU
  rust/block: Add empty crate
  rust/block: Add I/O buffer traits
  block: Add bdrv_open_blockdev_ref_file()
  rust/block: Add driver module
  rust/block: Add read support for block drivers
  bochs-rs: Add bochs block driver reimplementation in Rust
  rust/block: Add format probing

 include/block/block-global-state.h |   4 +
 include/qemu/coroutine-rust.h      |  24 +++
 rust/wrapper-system.h              |  46 +++++
 rust/wrapper.h                     |  16 +-
 block.c                            |  31 ++-
 util/qemu-co-rust-async.c          |  55 +++++
 MAINTAINERS                        |   1 +
 meson.build                        |  47 ++++-
 rust/Cargo.lock                    |   8 +
 rust/Cargo.toml                    |   1 +
 rust/block/Cargo.toml              |  16 ++
 rust/block/README.md               |   3 +
 rust/block/meson.build             |  20 ++
 rust/block/src/bochs.rs            | 317 +++++++++++++++++++++++++++++
 rust/block/src/driver.rs           | 309 ++++++++++++++++++++++++++++
 rust/block/src/iobuffer.rs         |  94 +++++++++
 rust/block/src/lib.rs              |   5 +
 rust/hw/char/pl011/meson.build     |   3 +-
 rust/hw/timer/hpet/meson.build     |   3 +-
 rust/meson.build                   |  12 +-
 rust/qemu-api/Cargo.toml           |   1 +
 rust/qemu-api/build.rs             |  10 +-
 rust/qemu-api/meson.build          |  80 +++++---
 rust/qemu-api/src/bindings.rs      |  52 +++--
 rust/qemu-api/src/futures.rs       |  77 +++++++
 rust/qemu-api/src/lib.rs           |   6 +
 rust/qemu-api/src/prelude.rs       |   3 +
 rust/qemu-api/src/zeroable.rs      |  34 ++--
 storage-daemon/meson.build         |   2 +-
 util/meson.build                   |   3 +
 30 files changed, 1188 insertions(+), 95 deletions(-)
 create mode 100644 include/qemu/coroutine-rust.h
 create mode 100644 rust/wrapper-system.h
 create mode 100644 util/qemu-co-rust-async.c
 create mode 100644 rust/block/Cargo.toml
 create mode 100644 rust/block/README.md
 create mode 100644 rust/block/meson.build
 create mode 100644 rust/block/src/bochs.rs
 create mode 100644 rust/block/src/driver.rs
 create mode 100644 rust/block/src/iobuffer.rs
 create mode 100644 rust/block/src/lib.rs
 create mode 100644 rust/qemu-api/src/futures.rs

-- 
2.48.1


