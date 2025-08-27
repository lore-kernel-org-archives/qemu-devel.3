Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7F6CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 10:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urDbj-0003rC-AU; Wed, 27 Aug 2025 06:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1urDbZ-0003jx-69
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:42:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1urDbT-0002uw-MA
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756291323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7TXJ0y/ae6YNieMOTHmczSqaD6qU/74iVrH804IUeN8=;
 b=OErVsQYC5HpdAKeuvK0EZwf7OGY2ZgAyN1X0Wi6iw5VxVOpnvObdLBuBxIrruCauAgs2I+
 6QWTWiND+uB/xLsb+JjUhXNDRuCzuAM08kdHxUK8aobq90xw/phWSeHKufT9SeRQ7x7XhM
 d71P732xmXkSj8/te8rXT8tqGBv1YvE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-m_CucGDUOpKgDdrTsKHzOw-1; Wed,
 27 Aug 2025 06:41:56 -0400
X-MC-Unique: m_CucGDUOpKgDdrTsKHzOw-1
X-Mimecast-MFC-AGG-ID: m_CucGDUOpKgDdrTsKHzOw_1756291315
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4573B19560AD; Wed, 27 Aug 2025 10:41:55 +0000 (UTC)
Received: from localhost (unknown [10.45.242.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 677B51800446; Wed, 27 Aug 2025 10:41:51 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 00/22] rust: split qemu-api
Date: Wed, 27 Aug 2025 14:41:22 +0400
Message-ID: <20250827104147.717203-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Hi,

qemu-api is providing bindings for various internal libraries. Instead, the
bindings requirements should match the various libraries and use the minimal set
of dependencies.

An initial Rust-only "common" crate is introduced, then "util" (for libqemuutil,
without bql), "migration" (so it doesn't depend on bql), "bql", "qom" (arguably,
bql shouldn't be required?), and "chardev", "system", "hwcore". Finally the
qemu-api crates are renamed and repurposed.

rfc->v1:
- added "rust: make build.rs generic over various ./rust/projects" patch, and
  link to common build.rs to avoid duplicated copies
- moved "errno" module to the "common" crate
- add/move the prelude for "qom"
- re-export macros in their corresponding crates
- drop the qom test for now
- added "docs/rust: update msrv" patch
- more misc doc changes
- add some missing spdx tags, and collect a r-b

Marc-André Lureau (22):
  docs/rust: update msrv
  rust: remove unused global qemu "allocator"
  rust: add workspace authors
  rust: make build.rs generic over various ./rust/projects
  rust: split Rust-only "common" crate
  rust: split "util" crate
  rust: move vmstate_clock!() to qdev module
  rust: move VMState handling to QOM module
  rust: move Cell vmstate impl
  rust: split "migration" crate
  rust: split "bql" crate
  rust: split "qom" crate
  rust: split "chardev" crate
  rust: split "system" crate
  rust: split "hwcore" crate
  rust: rename qemu_api_macros -> qemu_macros
  rust/hpet: drop now unneeded qemu_api dep
  rust/pl011: drop dependency on qemu_api
  rust: repurpose qemu_api -> tests
  rust: re-export qemu_macros internal helper in "bits"
  rust: re-export qemu macros from common/qom/hwcore
  docs: update rust.rst

 MAINTAINERS                                   |  12 +-
 docs/devel/rust.rst                           |  65 ++--
 meson.build                                   |   4 -
 rust/bql/wrapper.h                            |  27 ++
 rust/chardev/wrapper.h                        |  28 ++
 rust/hw/char/pl011/wrapper.h                  |  51 +++
 rust/hw/core/wrapper.h                        |  32 ++
 rust/{qemu-api => migration}/wrapper.h        |  20 --
 rust/qom/wrapper.h                            |  27 ++
 rust/system/wrapper.h                         |  29 ++
 rust/util/wrapper.h                           |  32 ++
 rust/Cargo.lock                               | 123 ++++++-
 rust/Cargo.toml                               |  20 +-
 rust/bits/Cargo.toml                          |   2 +-
 rust/bits/meson.build                         |   2 +-
 rust/bits/src/lib.rs                          |   7 +-
 rust/{qemu-api => bql}/Cargo.toml             |  13 +-
 rust/bql/build.rs                             |   1 +
 rust/bql/meson.build                          |  52 +++
 rust/bql/src/bindings.rs                      |  25 ++
 rust/{qemu-api => bql}/src/cell.rs            | 333 +++---------------
 rust/bql/src/lib.rs                           |  29 ++
 rust/chardev/Cargo.toml                       |  23 ++
 rust/chardev/build.rs                         |   1 +
 rust/chardev/meson.build                      |  54 +++
 rust/chardev/src/bindings.rs                  |  36 ++
 rust/{qemu-api => chardev}/src/chardev.rs     |  23 +-
 rust/chardev/src/lib.rs                       |   6 +
 rust/common/Cargo.toml                        |  20 ++
 rust/common/meson.build                       |  34 ++
 rust/{qemu-api => common}/src/assertions.rs   |  16 +-
 rust/{qemu-api => common}/src/bitops.rs       |   1 -
 rust/{qemu-api => common}/src/callbacks.rs    |  12 +-
 rust/{qemu-api => common}/src/errno.rs        |  11 +-
 rust/common/src/lib.rs                        |  22 ++
 rust/common/src/opaque.rs                     | 238 +++++++++++++
 rust/{qemu-api => common}/src/uninit.rs       |   2 +-
 rust/common/src/zeroable.rs                   |  18 +
 rust/hw/char/pl011/Cargo.toml                 |  10 +-
 rust/hw/char/pl011/build.rs                   |   1 +
 rust/hw/char/pl011/meson.build                |  38 +-
 rust/hw/char/pl011/src/bindings.rs            |  27 ++
 rust/hw/char/pl011/src/device.rs              |  46 ++-
 rust/hw/char/pl011/src/lib.rs                 |   1 +
 rust/hw/char/pl011/src/registers.rs           |   4 +-
 rust/hw/core/Cargo.toml                       |  25 ++
 rust/hw/core/build.rs                         |   1 +
 rust/{qemu-api => hw/core}/meson.build        |  86 ++---
 rust/hw/core/src/bindings.rs                  |  41 +++
 rust/{qemu-api => hw/core}/src/irq.rs         |  16 +-
 rust/hw/core/src/lib.rs                       |  14 +
 rust/{qemu-api => hw/core}/src/qdev.rs        |  74 +++-
 rust/{qemu-api => hw/core}/src/sysbus.rs      |  26 +-
 rust/{qemu-api => hw/core}/tests/tests.rs     |  26 +-
 rust/hw/timer/hpet/Cargo.toml                 |   9 +-
 rust/hw/timer/hpet/meson.build                |  12 +-
 rust/hw/timer/hpet/src/device.rs              |  56 ++-
 rust/hw/timer/hpet/src/fw_cfg.rs              |   6 +-
 rust/meson.build                              |  13 +-
 rust/migration/Cargo.toml                     |  20 ++
 rust/migration/build.rs                       |   1 +
 rust/migration/meson.build                    |  57 +++
 rust/migration/src/bindings.rs                |  48 +++
 rust/migration/src/lib.rs                     |   6 +
 rust/{qemu-api => migration}/src/vmstate.rs   | 166 ++++-----
 rust/qemu-api/.gitignore                      |   2 -
 rust/qemu-api/README.md                       |  19 -
 rust/qemu-api/src/lib.rs                      | 170 ---------
 rust/qemu-api/src/prelude.rs                  |  31 --
 rust/qemu-api/src/zeroable.rs                 |  37 --
 .../Cargo.toml                                |   2 +-
 .../meson.build                               |  10 +-
 .../src/bits.rs                               |   0
 .../src/lib.rs                                |  20 +-
 .../src/tests.rs                              |   8 +-
 rust/qom/Cargo.toml                           |  23 ++
 rust/qom/build.rs                             |   1 +
 rust/qom/meson.build                          |  47 +++
 rust/qom/src/bindings.rs                      |  25 ++
 rust/qom/src/lib.rs                           |  10 +
 rust/qom/src/prelude.rs                       |  12 +
 rust/{qemu-api => qom}/src/qom.rs             |  27 +-
 rust/system/Cargo.toml                        |  21 ++
 rust/system/build.rs                          |   1 +
 rust/system/meson.build                       |  56 +++
 rust/{qemu-api => system}/src/bindings.rs     |  33 +-
 rust/system/src/lib.rs                        |   6 +
 rust/{qemu-api => system}/src/memory.rs       |  18 +-
 rust/tests/Cargo.toml                         |  29 ++
 rust/tests/meson.build                        |  14 +
 .../tests/vmstate_tests.rs                    |  18 +-
 rust/util/Cargo.toml                          |  22 ++
 rust/{qemu-api => util}/build.rs              |  10 +-
 rust/util/meson.build                         |  60 ++++
 rust/util/src/bindings.rs                     |  25 ++
 rust/{qemu-api => util}/src/error.rs          |   6 +-
 rust/util/src/lib.rs                          |   9 +
 rust/{qemu-api => util}/src/log.rs            |  16 +-
 rust/{qemu-api => util}/src/module.rs         |   2 +-
 rust/{qemu-api => util}/src/timer.rs          |  12 +-
 100 files changed, 2039 insertions(+), 1044 deletions(-)
 create mode 100644 rust/bql/wrapper.h
 create mode 100644 rust/chardev/wrapper.h
 create mode 100644 rust/hw/char/pl011/wrapper.h
 create mode 100644 rust/hw/core/wrapper.h
 rename rust/{qemu-api => migration}/wrapper.h (77%)
 create mode 100644 rust/qom/wrapper.h
 create mode 100644 rust/system/wrapper.h
 create mode 100644 rust/util/wrapper.h
 rename rust/{qemu-api => bql}/Cargo.toml (52%)
 create mode 120000 rust/bql/build.rs
 create mode 100644 rust/bql/meson.build
 create mode 100644 rust/bql/src/bindings.rs
 rename rust/{qemu-api => bql}/src/cell.rs (70%)
 create mode 100644 rust/bql/src/lib.rs
 create mode 100644 rust/chardev/Cargo.toml
 create mode 120000 rust/chardev/build.rs
 create mode 100644 rust/chardev/meson.build
 create mode 100644 rust/chardev/src/bindings.rs
 rename rust/{qemu-api => chardev}/src/chardev.rs (95%)
 create mode 100644 rust/chardev/src/lib.rs
 create mode 100644 rust/common/Cargo.toml
 create mode 100644 rust/common/meson.build
 rename rust/{qemu-api => common}/src/assertions.rs (92%)
 rename rust/{qemu-api => common}/src/bitops.rs (98%)
 rename rust/{qemu-api => common}/src/callbacks.rs (97%)
 rename rust/{qemu-api => common}/src/errno.rs (98%)
 create mode 100644 rust/common/src/lib.rs
 create mode 100644 rust/common/src/opaque.rs
 rename rust/{qemu-api => common}/src/uninit.rs (98%)
 create mode 100644 rust/common/src/zeroable.rs
 create mode 120000 rust/hw/char/pl011/build.rs
 create mode 100644 rust/hw/char/pl011/src/bindings.rs
 create mode 100644 rust/hw/core/Cargo.toml
 create mode 120000 rust/hw/core/build.rs
 rename rust/{qemu-api => hw/core}/meson.build (52%)
 create mode 100644 rust/hw/core/src/bindings.rs
 rename rust/{qemu-api => hw/core}/src/irq.rs (93%)
 create mode 100644 rust/hw/core/src/lib.rs
 rename rust/{qemu-api => hw/core}/src/qdev.rs (86%)
 rename rust/{qemu-api => hw/core}/src/sysbus.rs (89%)
 rename rust/{qemu-api => hw/core}/tests/tests.rs (89%)
 create mode 100644 rust/migration/Cargo.toml
 create mode 120000 rust/migration/build.rs
 create mode 100644 rust/migration/meson.build
 create mode 100644 rust/migration/src/bindings.rs
 create mode 100644 rust/migration/src/lib.rs
 rename rust/{qemu-api => migration}/src/vmstate.rs (80%)
 delete mode 100644 rust/qemu-api/.gitignore
 delete mode 100644 rust/qemu-api/README.md
 delete mode 100644 rust/qemu-api/src/lib.rs
 delete mode 100644 rust/qemu-api/src/prelude.rs
 delete mode 100644 rust/qemu-api/src/zeroable.rs
 rename rust/{qemu-api-macros => qemu-macros}/Cargo.toml (94%)
 rename rust/{qemu-api-macros => qemu-macros}/meson.build (63%)
 rename rust/{qemu-api-macros => qemu-macros}/src/bits.rs (100%)
 rename rust/{qemu-api-macros => qemu-macros}/src/lib.rs (91%)
 rename rust/{qemu-api-macros => qemu-macros}/src/tests.rs (93%)
 create mode 100644 rust/qom/Cargo.toml
 create mode 120000 rust/qom/build.rs
 create mode 100644 rust/qom/meson.build
 create mode 100644 rust/qom/src/bindings.rs
 create mode 100644 rust/qom/src/lib.rs
 create mode 100644 rust/qom/src/prelude.rs
 rename rust/{qemu-api => qom}/src/qom.rs (98%)
 create mode 100644 rust/system/Cargo.toml
 create mode 120000 rust/system/build.rs
 create mode 100644 rust/system/meson.build
 rename rust/{qemu-api => system}/src/bindings.rs (56%)
 create mode 100644 rust/system/src/lib.rs
 rename rust/{qemu-api => system}/src/memory.rs (95%)
 create mode 100644 rust/tests/Cargo.toml
 create mode 100644 rust/tests/meson.build
 rename rust/{qemu-api => tests}/tests/vmstate_tests.rs (96%)
 create mode 100644 rust/util/Cargo.toml
 rename rust/{qemu-api => util}/build.rs (81%)
 create mode 100644 rust/util/meson.build
 create mode 100644 rust/util/src/bindings.rs
 rename rust/{qemu-api => util}/src/error.rs (98%)
 create mode 100644 rust/util/src/lib.rs
 rename rust/{qemu-api => util}/src/log.rs (93%)
 rename rust/{qemu-api => util}/src/module.rs (97%)
 rename rust/{qemu-api => util}/src/timer.rs (93%)

-- 
2.50.1


