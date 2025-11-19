Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A20CF58F5
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 20:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLp9w-0007sE-TA; Wed, 19 Nov 2025 15:52:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vLp9u-0007ri-C9
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 15:52:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vLp9s-00022m-Cc
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 15:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763585525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=telmREDl0NRi6jjPIxAR1upwJXK8/pOk41hEfINrNXo=;
 b=RIs8N5kdEfzlyYk6ssykD54HZMS75EbaYYYjppvluw0njcGUutCtkmc8kSX9T4HASyEb23
 ApEq+Qd59XmmGr9aPgGSa0m0ADCtdf7tbUVCfIphmWSOxud74PHaaKfWuV6zUAkHStbeKK
 Z5DWjTFn6IQPTcc9GwMWko4UItksd3E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158--d3ctl4hPkKZtXb1T00kzg-1; Wed,
 19 Nov 2025 15:52:04 -0500
X-MC-Unique: -d3ctl4hPkKZtXb1T00kzg-1
X-Mimecast-MFC-AGG-ID: -d3ctl4hPkKZtXb1T00kzg_1763585522
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A39019560AD; Wed, 19 Nov 2025 20:52:02 +0000 (UTC)
Received: from localhost (unknown [10.2.16.175])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7AB3E19560B0; Wed, 19 Nov 2025 20:52:01 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-rust@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Josh Stone <jistone@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 0/4] trace: add Rust DTrace/SystemTap SDT support
Date: Wed, 19 Nov 2025 15:51:56 -0500
Message-ID: <20251119205200.173170-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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

v2:
- Re-export probe::probe!() from the trace crate to avoid the explicit probe
  crate dependency from hpet, pl011, etc. [Paolo]

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

Based-on: <20251106215606.36598-1-stefanha@redhat.com>

Stefan Hajnoczi (4):
  hpet: remove unused trace events
  rust/hpet: add trace events
  subprojects: add probe crate
  tracetool: add Rust DTrace/SystemTap SDT support

 hw/timer/trace-events                         |  2 -
 rust/Cargo.lock                               |  6 ++
 rust/hw/timer/hpet/Cargo.toml                 |  1 +
 rust/hw/timer/hpet/meson.build                |  1 +
 rust/hw/timer/hpet/src/device.rs              | 45 ++++++++-----
 rust/meson.build                              |  2 +
 rust/trace/Cargo.toml                         |  1 +
 rust/trace/meson.build                        |  2 +-
 rust/trace/src/lib.rs                         |  4 ++
 scripts/archive-source.sh                     |  1 +
 scripts/make-release                          |  2 +-
 scripts/tracetool/__init__.py                 |  1 +
 scripts/tracetool/backend/dtrace.py           | 31 +++++++++
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
 23 files changed, 280 insertions(+), 27 deletions(-)
 create mode 100644 subprojects/packagefiles/probe-0.5-rs/meson.build
 create mode 100644 subprojects/probe-0.5-rs.wrap
 create mode 100644 tests/tracetool/dtrace.rs

-- 
2.51.1


