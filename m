Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEBCC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 21:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thy3F-0007uq-QW; Tue, 11 Feb 2025 16:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thy3D-0007ol-76
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 16:44:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thy39-00055p-AP
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 16:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739310248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=h/ifcYhQ7KkTIGj6O+VZXM2QcwDr9dlJUCrUFlqQsPg=;
 b=UCMyhiaqr/AoLj03VL70AUPZrtq3BJTM+x7BEgC9qMPZ0jz9xVR7hgXSex9ojiaEcR0zOB
 zzi97G+LngONHg2qAUqv3/+IXWNZhsdNaRxBbUWyUmdHjzUxcAmXHqsvfHx60Wea6WIisb
 5MLQj5NC/jwu9nImgxbD2jrOSNNk78A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-YyH2liYOPQuhWdxtwfzIwA-1; Tue,
 11 Feb 2025 16:44:06 -0500
X-MC-Unique: YyH2liYOPQuhWdxtwfzIwA-1
X-Mimecast-MFC-AGG-ID: YyH2liYOPQuhWdxtwfzIwA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C01A1800876; Tue, 11 Feb 2025 21:44:05 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.210])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BD30B195608D; Tue, 11 Feb 2025 21:44:02 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: [PATCH 00/11] rust/block: Add minimal block driver bindings
Date: Tue, 11 Feb 2025 22:43:17 +0100
Message-ID: <20250211214328.640374-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
 rust/wrapper-system.h              |  44 ++++
 rust/wrapper.h                     |  14 +-
 block.c                            |  30 ++-
 util/qemu-co-rust-async.c          |  55 +++++
 meson.build                        |  48 ++++-
 rust/Cargo.lock                    |   7 +
 rust/Cargo.toml                    |   1 +
 rust/block/Cargo.toml              |  15 ++
 rust/block/README.md               |   3 +
 rust/block/meson.build             |  19 ++
 rust/block/src/bochs.rs            | 316 +++++++++++++++++++++++++++++
 rust/block/src/driver.rs           | 309 ++++++++++++++++++++++++++++
 rust/block/src/iobuffer.rs         |  94 +++++++++
 rust/block/src/lib.rs              |   5 +
 rust/hw/char/pl011/meson.build     |   3 +-
 rust/meson.build                   |  12 +-
 rust/qemu-api/Cargo.toml           |   1 +
 rust/qemu-api/build.rs             |  10 +-
 rust/qemu-api/meson.build          |  71 ++++---
 rust/qemu-api/src/bindings.rs      |  16 +-
 rust/qemu-api/src/futures.rs       |  78 +++++++
 rust/qemu-api/src/lib.rs           |   5 +
 rust/qemu-api/src/prelude.rs       |   2 +
 rust/qemu-api/src/zeroable.rs      |  11 +
 storage-daemon/meson.build         |   2 +-
 util/meson.build                   |   3 +
 28 files changed, 1146 insertions(+), 56 deletions(-)
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


