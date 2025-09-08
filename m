Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9F9CAC588
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 14:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvcWo-0001bQ-1e; Mon, 08 Sep 2025 10:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uvcWk-0001WQ-Kq
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:07:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uvcWX-00079D-3p
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757340420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ze5FtPK6PHx6N1vfciI+tfRK+bd8SS35/ymyPb/Et8g=;
 b=TIvtox0y6ZXNrD/8yLIGexolJuvVqIPBl2T0hULVuCnV7ZBoKIJHmJfRbe37+FrOrLPUWA
 QwhDwUjGOQJ3DmEDc06GNj13LlF8Z5hsgztCziXp73vSCKHhJ8gBPTI85bFHQAQ6HCQf5Z
 NR/NvtZ14WejVOorwfjjM+qKQ08hEII=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-wJm4_hCYMnyBkuXPemtJtQ-1; Mon,
 08 Sep 2025 10:06:57 -0400
X-MC-Unique: wJm4_hCYMnyBkuXPemtJtQ-1
X-Mimecast-MFC-AGG-ID: wJm4_hCYMnyBkuXPemtJtQ_1757340415
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F2D819560AB; Mon,  8 Sep 2025 14:06:55 +0000 (UTC)
Received: from localhost (unknown [10.2.16.148])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 55E5E19560A2; Mon,  8 Sep 2025 14:06:54 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Michael Roth <michael.roth@amd.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 0/8] Tracing patches
Date: Mon,  8 Sep 2025 10:06:44 -0400
Message-ID: <20250908140653.170707-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8:

  Merge tag 'pull-tcg-20250905' of https://gitlab.com/rth7680/qemu into staging (2025-09-05 09:51:27 +0200)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to b91cbf4e691b397510584b04fd6197284f55b52c:

  tracetool-test: allow to run in parallel (2025-09-08 09:48:10 -0400)

----------------------------------------------------------------
Pull request

Daniel Berrangé's tracetool test suite and Marc-André Lureau's test suite fix.

----------------------------------------------------------------

Daniel P. Berrangé (7):
  checkpatch: cull trailing '*/' in SPDX check
  tracetool: eliminate trailing whitespace in C format
  tracetool: avoid space after "*" in arg types
  tracetool: include SPDX-License-Identifier in generated files
  tracetool: add test suite for tracetool with reference output
  tracetool: drop the probe "__nocheck__" wrapping
  qapi: switch to use QEMU_TEST_REGENERATE env var

Marc-André Lureau (1):
  tracetool-test: allow to run in parallel

 MAINTAINERS                                  |   1 +
 docs/devel/testing/main.rst                  |  40 +++++++
 tests/Makefile.include                       |   1 +
 tests/tracetool/dtrace.h                     |  45 ++++++++
 tests/tracetool/ftrace.h                     |  59 ++++++++++
 tests/tracetool/log.h                        |  43 ++++++++
 tests/tracetool/simple.h                     |  40 +++++++
 tests/tracetool/syslog.h                     |  43 ++++++++
 tests/tracetool/ust.h                        |  41 +++++++
 tests/tracetool/dtrace.c                     |  32 ++++++
 tests/tracetool/ftrace.c                     |  32 ++++++
 tests/tracetool/log.c                        |  32 ++++++
 tests/tracetool/simple.c                     |  61 +++++++++++
 tests/tracetool/syslog.c                     |  32 ++++++
 tests/tracetool/ust.c                        |  32 ++++++
 scripts/checkpatch.pl                        |   3 +
 scripts/tracetool/__init__.py                |   9 +-
 scripts/tracetool/format/c.py                |   3 +-
 scripts/tracetool/format/d.py                |   3 +-
 scripts/tracetool/format/h.py                |  17 +--
 scripts/tracetool/format/log_stap.py         |   1 +
 scripts/tracetool/format/simpletrace_stap.py |   1 +
 scripts/tracetool/format/stap.py             |   1 +
 scripts/tracetool/format/ust_events_c.py     |   1 +
 scripts/tracetool/format/ust_events_h.py     |   1 +
 tests/meson.build                            |   1 +
 tests/qapi-schema/test-qapi.py               |   7 +-
 tests/tracetool/dtrace.d                     |  10 ++
 tests/tracetool/dtrace.log-stap              |  15 +++
 tests/tracetool/dtrace.simpletrace-stap      |  16 +++
 tests/tracetool/dtrace.stap                  |  14 +++
 tests/tracetool/meson.build                  |  25 +++++
 tests/tracetool/trace-events                 |   5 +
 tests/tracetool/tracetool-test.py            | 107 +++++++++++++++++++
 tests/tracetool/ust.ust-events-c             |  14 +++
 tests/tracetool/ust.ust-events-h             |  56 ++++++++++
 36 files changed, 823 insertions(+), 21 deletions(-)
 create mode 100644 tests/tracetool/dtrace.h
 create mode 100644 tests/tracetool/ftrace.h
 create mode 100644 tests/tracetool/log.h
 create mode 100644 tests/tracetool/simple.h
 create mode 100644 tests/tracetool/syslog.h
 create mode 100644 tests/tracetool/ust.h
 create mode 100644 tests/tracetool/dtrace.c
 create mode 100644 tests/tracetool/ftrace.c
 create mode 100644 tests/tracetool/log.c
 create mode 100644 tests/tracetool/simple.c
 create mode 100644 tests/tracetool/syslog.c
 create mode 100644 tests/tracetool/ust.c
 create mode 100644 tests/tracetool/dtrace.d
 create mode 100644 tests/tracetool/dtrace.log-stap
 create mode 100644 tests/tracetool/dtrace.simpletrace-stap
 create mode 100644 tests/tracetool/dtrace.stap
 create mode 100644 tests/tracetool/meson.build
 create mode 100644 tests/tracetool/trace-events
 create mode 100755 tests/tracetool/tracetool-test.py
 create mode 100644 tests/tracetool/ust.ust-events-c
 create mode 100644 tests/tracetool/ust.ust-events-h

-- 
2.51.0


