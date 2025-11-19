Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA59CF58C9
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 18:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLmlH-0006q4-U6; Wed, 19 Nov 2025 13:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vLmlF-0006p1-Gn
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 13:18:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vLmlD-0004b1-Cg
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 13:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763576309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LRJW8QkiQFFKXDIVbbf9MkmVQT39M65DZ0r9NxADYIo=;
 b=Tewer4OJeEoddDcF++sLDWHPUIJbstnV9Nqmog8nNg0AD9T1NqgNwsjzcJ1oVza14rfvyP
 K2eBq+d+3hcs8USC5J4/WdftfB5mJ3Pr/tRZXjASqZRzekaDKvaIFvKUK8mzagQrWYrY9p
 6OQsu3hFfjM08YTUQqLabghbKh0r+ng=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-ehHdRAM7M1ekY6OhwjjKbg-1; Wed,
 19 Nov 2025 13:18:25 -0500
X-MC-Unique: ehHdRAM7M1ekY6OhwjjKbg-1
X-Mimecast-MFC-AGG-ID: ehHdRAM7M1ekY6OhwjjKbg_1763576303
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61417180034F; Wed, 19 Nov 2025 18:18:23 +0000 (UTC)
Received: from localhost (unknown [10.2.16.175])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A90D330001B9; Wed, 19 Nov 2025 18:18:22 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-rust@nongnu.org, Josh Stone <jistone@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/2] trace: add Rust DTrace/SystemTap SDT support
Date: Wed, 19 Nov 2025 13:18:19 -0500
Message-ID: <20251119181821.154833-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This series adds SDT probe support so that SystemTap, GDB, etc can trace QEMU's
Rust code when compiled with `./configure --enable-trace-backends=dtrace`.

The dtrace(1) tool that generates the .o and C header file does not support
Rust. Use the probe crate (https://crates.io/crates/probe), which takes care of
emitting SDT probes, and extend tracetool to emit code for the trace events.

While SDT is cross-platform, the probe crate currently only supports Linux
(SystemTap). On other platforms the crate is a nop - it compiles but does
nothing. Future changes to the probe crate may add support for other operating
systems like FreeBSD, macOS, etc without much needed in the way of QEMU code
changes.

Josh: I CCed you just to let you know that QEMU will use the probes
crate. There is no need to review the code unless you want to.

Based-on: <20251106215606.36598-1-stefanha@redhat.com>

Stefan Hajnoczi (2):
  subprojects: add probe crate
  tracetool: add Rust DTrace/SystemTap SDT support

 rust/Cargo.lock                               |  6 ++
 rust/hw/char/pl011/meson.build                |  1 +
 rust/hw/timer/hpet/meson.build                |  1 +
 rust/meson.build                              |  2 +
 rust/trace/Cargo.toml                         |  1 +
 rust/trace/meson.build                        |  2 +-
 scripts/archive-source.sh                     |  1 +
 scripts/make-release                          |  2 +-
 scripts/tracetool/__init__.py                 |  1 +
 scripts/tracetool/backend/dtrace.py           | 32 +++++++++
 scripts/tracetool/format/rs.py                | 27 ++++++--
 subprojects/.gitignore                        |  1 +
 .../packagefiles/probe-0.5-rs/meson.build     | 22 +++++++
 subprojects/probe-0.5-rs.wrap                 |  7 ++
 tests/tracetool/dtrace.rs                     | 65 +++++++++++++++++++
 tests/tracetool/ftrace.rs                     | 21 ++++++
 tests/tracetool/log.rs                        | 21 ++++++
 tests/tracetool/simple.rs                     | 21 ++++++
 tests/tracetool/syslog.rs                     | 21 ++++++
 tests/tracetool/tracetool-test.py             |  2 +-
 20 files changed, 250 insertions(+), 7 deletions(-)
 create mode 100644 subprojects/packagefiles/probe-0.5-rs/meson.build
 create mode 100644 subprojects/probe-0.5-rs.wrap
 create mode 100644 tests/tracetool/dtrace.rs

-- 
2.51.1


