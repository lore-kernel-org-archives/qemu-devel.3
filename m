Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44290CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 17:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyZq5-0007uP-Hz; Tue, 16 Sep 2025 13:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uyZps-0007K2-1A
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:51:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uyZpo-0008Er-9s
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758045075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Wnm2c70/sInb5Kln1tljKEQJTxHEu5y+56S6FKsuwvw=;
 b=iL7KnGZA1wWDQFiwygxLLxFX2wZ/pnv5ekIP5fpNEHQE3SnJModm4742xWecFJ0IJec1pB
 gff9n84FNNGfTnWuMS/J5SSGe7SqjrdZ6YKS5iQLd+r1i/UXW80QY00M1rjfaZkd2g+3Td
 hgBPePNIznfOelrUK0GbO/MVpl44LU4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-C3Wg-JLLMdWSoDm71oYKoQ-1; Tue,
 16 Sep 2025 13:51:12 -0400
X-MC-Unique: C3Wg-JLLMdWSoDm71oYKoQ-1
X-Mimecast-MFC-AGG-ID: C3Wg-JLLMdWSoDm71oYKoQ_1758045070
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF9FE1956087; Tue, 16 Sep 2025 17:51:10 +0000 (UTC)
Received: from localhost (unknown [10.2.17.12])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C5D39195608E; Tue, 16 Sep 2025 17:51:09 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Subject: [PULL v2 0/8] Tracing patches
Date: Tue, 16 Sep 2025 13:51:00 -0400
Message-ID: <20250916175108.139627-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
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

The following changes since commit 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d:

  Merge tag 'pull-request-2025-09-09' of https://gitlab.com/thuth/qemu into staging (2025-09-11 12:41:01 +0100)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 2c27d8523927b0965b7b3d265eee3baf9a15c9c8:

  tracetool-test: allow to run in parallel (2025-09-16 13:31:40 -0400)

----------------------------------------------------------------
Pull request

Daniel's updated tracetool test suite that doesn't break Windows CI.

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
 tests/tracetool/meson.build                  |  28 +++++
 tests/tracetool/trace-events                 |   5 +
 tests/tracetool/tracetool-test.py            | 107 +++++++++++++++++++
 tests/tracetool/ust.ust-events-c             |  14 +++
 tests/tracetool/ust.ust-events-h             |  56 ++++++++++
 36 files changed, 826 insertions(+), 21 deletions(-)
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


