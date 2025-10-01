Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCB4CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yny-0001Vc-27; Wed, 01 Oct 2025 11:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3ynw-0001Ui-3O
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:31:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3yna-0005qF-1w
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759332670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cMsOgMSmcXE5EW/arXueqpj+JXzJTNC0KYfmuS0w7+I=;
 b=BiKIR1b+E3mjDVESQPdgGTAWYdBqdpDHTCDn80spwrizifkbdHqtX3K1N+opazc6+EjivS
 0fnDFyUarlx3klOFJoyeuOAUK3x1mOBCbE4Ex9vC41LbcNjKoKJhxeGYBvLY15EgIXSlQA
 Ry/byGuKJ8MbZI3txM2kUDOmAo3S8rk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-mr2T8W0BPwaaoPPHyQzLiw-1; Wed,
 01 Oct 2025 11:31:06 -0400
X-MC-Unique: mr2T8W0BPwaaoPPHyQzLiw-1
X-Mimecast-MFC-AGG-ID: mr2T8W0BPwaaoPPHyQzLiw_1759332664
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CB7B19560AD; Wed,  1 Oct 2025 15:31:02 +0000 (UTC)
Received: from localhost (unknown [10.2.16.112])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE98918004D8; Wed,  1 Oct 2025 15:31:00 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bandan Das <bsd@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Alexander Bulekov <alxndr@bu.edu>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-rust@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Cleber Rosa <crosa@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Michael Roth <michael.roth@amd.com>, Mads Ynddal <mads@ynddal.dk>,
 Alexandre Iooss <erdnaxe@crans.org>, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 00/16] Tracing patches
Date: Wed,  1 Oct 2025 11:30:43 -0400
Message-ID: <20251001153059.194991-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 29b77c1a2db2d796bc3847852a5c8dc2a1e6e83b:

  Merge tag 'rust-ci-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2025-09-30 09:29:38 -0700)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 1461752f0fa4bcd7e60d51fe47e3430f8a81cdd8:

  tracetool/syslog: add Rust support (2025-10-01 11:22:07 -0400)

----------------------------------------------------------------
Pull request

Tanish Desai and Paolo Bonzini's tracing Rust support.

----------------------------------------------------------------

Paolo Bonzini (8):
  tracetool: fix usage of try_import()
  tracetool: remove dead code
  treewide: remove unnessary "coding" header
  tracetool: add SPDX headers
  trace/ftrace: move snprintf+write from tracepoints to ftrace.c
  rust: qdev: add minimal clock bindings
  rust: pl011: add tracepoints
  log: change qemu_loglevel to unsigned

Tanish Desai (8):
  tracetool: add CHECK_TRACE_EVENT_GET_STATE
  tracetool/backend: remove redundant trace event checks
  tracetool: Add Rust format support
  rust: add trace crate
  tracetool/simple: add Rust support
  tracetool/log: add Rust support
  tracetool/ftrace: add Rust support
  tracetool/syslog: add Rust support

 include/qemu/log-for-trace.h                  |   4 +-
 include/qemu/log.h                            |  44 ++--
 tests/tracetool/ftrace.h                      |  28 +--
 tests/tracetool/log.h                         |  16 +-
 trace/ftrace.h                                |   1 +
 trace/ftrace.c                                |  15 ++
 util/log.c                                    |   2 +-
 docs/conf.py                                  |   2 -
 docs/sphinx-static/theme_overrides.css        |   3 +-
 hw/char/trace-events                          |  14 +-
 rust/Cargo.lock                               |   8 +
 rust/Cargo.toml                               |   1 +
 rust/hw/char/pl011/Cargo.toml                 |   1 +
 rust/hw/char/pl011/meson.build                |   1 +
 rust/hw/char/pl011/src/device.rs              |  57 +++--
 rust/hw/core/src/qdev.rs                      |  33 +++
 rust/meson.build                              |   2 +-
 rust/trace/Cargo.toml                         |  19 ++
 rust/trace/meson.build                        |  19 ++
 rust/trace/src/lib.rs                         |  39 ++++
 rust/util/src/log.rs                          |   2 +-
 scripts/analyse-locks-simpletrace.py          |   1 -
 scripts/modinfo-collect.py                    |   1 -
 scripts/modinfo-generate.py                   |   1 -
 scripts/oss-fuzz/minimize_qtest_trace.py      |   1 -
 scripts/oss-fuzz/output_reproducer.py         |   1 -
 .../oss-fuzz/reorder_fuzzer_qtest_trace.py    |   1 -
 scripts/probe-gdb-support.py                  |   1 -
 scripts/qapi/error.py                         |   2 -
 scripts/qapi/expr.py                          |   2 -
 scripts/qapi/gen.py                           |   2 -
 scripts/qapi/parser.py                        |   2 -
 scripts/qapi/schema.py                        |   2 -
 scripts/qemu-plugin-symbols.py                |   1 -
 scripts/qemugdb/tcg.py                        |   2 -
 scripts/qemugdb/timers.py                     |   1 -
 scripts/replay-dump.py                        |   1 -
 scripts/tracetool.py                          |   1 -
 scripts/tracetool/__init__.py                 | 202 ++++++++++++++----
 scripts/tracetool/backend/__init__.py         |  43 ++--
 scripts/tracetool/backend/dtrace.py           |   2 +-
 scripts/tracetool/backend/ftrace.py           |  26 +--
 scripts/tracetool/backend/log.py              |  22 +-
 scripts/tracetool/backend/simple.py           |  17 +-
 scripts/tracetool/backend/syslog.py           |  17 +-
 scripts/tracetool/backend/ust.py              |   2 +-
 scripts/tracetool/format/__init__.py          |   4 +-
 scripts/tracetool/format/c.py                 |   2 +-
 scripts/tracetool/format/d.py                 |   2 +-
 scripts/tracetool/format/h.py                 |  18 +-
 scripts/tracetool/format/log_stap.py          |   4 +-
 scripts/tracetool/format/rs.py                |  64 ++++++
 scripts/tracetool/format/simpletrace_stap.py  |   4 +-
 scripts/tracetool/format/stap.py              |   2 +-
 scripts/tracetool/format/ust_events_c.py      |   2 +-
 scripts/tracetool/format/ust_events_h.py      |   2 +-
 tests/tracetool/ftrace.rs                     |  40 ++++
 tests/tracetool/log.rs                        |  44 ++++
 tests/tracetool/simple.rs                     |  40 ++++
 tests/tracetool/syslog.rs                     |  40 ++++
 tests/tracetool/tracetool-test.py             |   2 +
 trace/meson.build                             |   8 +-
 62 files changed, 720 insertions(+), 223 deletions(-)
 create mode 100644 rust/trace/Cargo.toml
 create mode 100644 rust/trace/meson.build
 create mode 100644 rust/trace/src/lib.rs
 create mode 100644 scripts/tracetool/format/rs.py
 create mode 100644 tests/tracetool/ftrace.rs
 create mode 100644 tests/tracetool/log.rs
 create mode 100644 tests/tracetool/simple.rs
 create mode 100644 tests/tracetool/syslog.rs

-- 
2.51.0


