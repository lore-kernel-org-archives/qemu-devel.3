Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4560C87FDA
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 17:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujhgw-0006vo-55; Wed, 06 Aug 2025 13:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujhJm-0004zQ-Hd
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 12:48:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujhJj-0002DC-JO
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 12:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754498922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LihaRzvWyYINKtVeAPQJxNjcbBU1nCTZWEtJADG3C5I=;
 b=EyPYYn4jRPO6ABlmssrBqBC8k6/UwQSqkjNd+QaGXfZcF+T30MIIqj8eyXuY/u+29/oWyt
 ekege/YhF5etLRT8y6C+oQRsMxnPxijZwzGdRc1F3ETs6v/z63VS9zKww7eBok9aEezpXm
 gFo57IYMe03h0CL9s09YgxJxQzFSKQU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-kqBQ_O8aMRGDovNJ6QhpOQ-1; Wed,
 06 Aug 2025 12:48:38 -0400
X-MC-Unique: kqBQ_O8aMRGDovNJ6QhpOQ-1
X-Mimecast-MFC-AGG-ID: kqBQ_O8aMRGDovNJ6QhpOQ_1754498917
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 998E8195608B; Wed,  6 Aug 2025 16:48:37 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.223])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3AA5F195608F; Wed,  6 Aug 2025 16:48:33 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 0/8] tracetool: add test suite to improve reviewability
Date: Wed,  6 Aug 2025 17:48:24 +0100
Message-ID: <20250806164832.1382919-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

To repeat the start of the commit message in patch 5....

When reviewing tracetool patches it is often very unclear what the
expected output will be for the generated backends. Compounding
this is that a default build will only enable the 'log' trace
backend, so developers won't see generated code for other backends
without making a special effort. Some backends are also platform
specific, so can't be enabled in QEMU builds, even though tracetool
could generate the code.

To address this, introduce a test suite for tracetool which is
conceptually similar to the qapi-schema test. It is a simple
python program that runs tracetool and compares the actual output
to historical reference output kept in git.

This was inspired by noticing the now pointless "__nocheck__"
method wrapping in the inline probe functions.

Changed in v3:

 - Also modify the QAPI schema test to use QEMU_TEST_REGENERATE=1
   env & document / hint this
 - Make tracetool accept '-' as shorthand for stdout to
   avoid relative paths in the reference output

Changed in v2:

 - Add tracetool info to docs/devel/testing.rst

Daniel P. Berrangé (8):
  checkpatch: cull trailing '*/' in SPDX check
  tracetool: eliminate trailing whitespace in C format
  tracetool: avoid space after "*" in arg types
  tracetool: include SPDX-License-Identifier in generated files
  tracetool: support "-" as a shorthand for stdout
  tracetool: add test suite for tracetool with reference output
  tracetool: drop the probe "__nocheck__" wrapping
  qapi: switch to use QEMU_TEST_REGENERATE env var

 MAINTAINERS                                  |  1 +
 docs/devel/testing/main.rst                  | 40 +++++++++
 scripts/checkpatch.pl                        |  3 +
 scripts/tracetool/__init__.py                | 17 +++-
 scripts/tracetool/format/c.py                |  3 +-
 scripts/tracetool/format/d.py                |  3 +-
 scripts/tracetool/format/h.py                | 17 +---
 scripts/tracetool/format/log_stap.py         |  1 +
 scripts/tracetool/format/simpletrace_stap.py |  1 +
 scripts/tracetool/format/stap.py             |  1 +
 scripts/tracetool/format/ust_events_c.py     |  1 +
 scripts/tracetool/format/ust_events_h.py     |  1 +
 tests/Makefile.include                       |  1 +
 tests/meson.build                            |  1 +
 tests/qapi-schema/test-qapi.py               |  7 +-
 tests/tracetool/dtrace.c                     | 32 +++++++
 tests/tracetool/dtrace.d                     | 10 +++
 tests/tracetool/dtrace.h                     | 45 ++++++++++
 tests/tracetool/dtrace.log-stap              | 15 ++++
 tests/tracetool/dtrace.simpletrace-stap      | 16 ++++
 tests/tracetool/dtrace.stap                  | 14 +++
 tests/tracetool/ftrace.c                     | 32 +++++++
 tests/tracetool/ftrace.h                     | 59 +++++++++++++
 tests/tracetool/log.c                        | 32 +++++++
 tests/tracetool/log.h                        | 43 +++++++++
 tests/tracetool/meson.build                  | 25 ++++++
 tests/tracetool/simple.c                     | 61 +++++++++++++
 tests/tracetool/simple.h                     | 40 +++++++++
 tests/tracetool/syslog.c                     | 32 +++++++
 tests/tracetool/syslog.h                     | 43 +++++++++
 tests/tracetool/trace-events                 |  5 ++
 tests/tracetool/tracetool-test.py            | 91 ++++++++++++++++++++
 tests/tracetool/ust.c                        | 32 +++++++
 tests/tracetool/ust.h                        | 41 +++++++++
 tests/tracetool/ust.ust-events-c             | 14 +++
 tests/tracetool/ust.ust-events-h             | 56 ++++++++++++
 36 files changed, 813 insertions(+), 23 deletions(-)
 create mode 100644 tests/tracetool/dtrace.c
 create mode 100644 tests/tracetool/dtrace.d
 create mode 100644 tests/tracetool/dtrace.h
 create mode 100644 tests/tracetool/dtrace.log-stap
 create mode 100644 tests/tracetool/dtrace.simpletrace-stap
 create mode 100644 tests/tracetool/dtrace.stap
 create mode 100644 tests/tracetool/ftrace.c
 create mode 100644 tests/tracetool/ftrace.h
 create mode 100644 tests/tracetool/log.c
 create mode 100644 tests/tracetool/log.h
 create mode 100644 tests/tracetool/meson.build
 create mode 100644 tests/tracetool/simple.c
 create mode 100644 tests/tracetool/simple.h
 create mode 100644 tests/tracetool/syslog.c
 create mode 100644 tests/tracetool/syslog.h
 create mode 100644 tests/tracetool/trace-events
 create mode 100755 tests/tracetool/tracetool-test.py
 create mode 100644 tests/tracetool/ust.c
 create mode 100644 tests/tracetool/ust.h
 create mode 100644 tests/tracetool/ust.ust-events-c
 create mode 100644 tests/tracetool/ust.ust-events-h

-- 
2.50.1


