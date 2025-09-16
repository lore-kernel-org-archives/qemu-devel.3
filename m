Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F92CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 08:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyQsB-0003lY-1U; Tue, 16 Sep 2025 04:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyQrx-0003iA-Lu
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 04:16:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyQrt-00041p-C5
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 04:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758010607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ozftMxGRwg9QjxVyXUfLCSLNYz3tbzIckk2IQctABZk=;
 b=ZyrC93YYF+qyNDxU6Ta+hOMBMDDvl+H2zd2SeHH+tuBL9wwqJ/bKs1xKWxTl63UP6IAiP3
 rm7GYBj4/HkdPvxYX0mCgAnad7kImZN0d00dybG1JL56a2XdqlKuIOiU0OL5TIG+naOmVe
 IS73zXckfMRuRKFhBsCgTCuwsANDleA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-eZGlGPNGMbC1CHtV85mcoQ-1; Tue,
 16 Sep 2025 04:16:44 -0400
X-MC-Unique: eZGlGPNGMbC1CHtV85mcoQ-1
X-Mimecast-MFC-AGG-ID: eZGlGPNGMbC1CHtV85mcoQ_1758010603
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 171E81956096; Tue, 16 Sep 2025 08:16:43 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.153])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D826418004A3; Tue, 16 Sep 2025 08:16:39 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v5 0/8] tracetool: add test suite to improve reviewability
Date: Tue, 16 Sep 2025 09:16:30 +0100
Message-ID: <20250916081638.764020-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Changed in v5:

 - Disabled new test on Windows platform, due to undiagnosed
   problems with spawning child processes
 - Include extra patch to fix parallel test execution

Changed in v4:

 - Drop patch adding '-' as an output filename for tracetool
 - Rewrite test to always use relative filenames for both
   inputs and outputs
 - Pass python code through 'black'
 - Minor docs punctuation tweak
 - Drop unused python method

Changed in v3:

 - Also modify the QAPI schema test to use QEMU_TEST_REGENERATE=1
   env & document / hint this
 - Make tracetool accept '-' as shorthand for stdout to
   avoid relative paths in the reference output

Changed in v2:

 - Add tracetool info to docs/devel/testing.rst

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
 tests/Makefile.include                       |   1 +
 tests/meson.build                            |   1 +
 tests/qapi-schema/test-qapi.py               |   7 +-
 tests/tracetool/dtrace.c                     |  32 ++++++
 tests/tracetool/dtrace.d                     |  10 ++
 tests/tracetool/dtrace.h                     |  45 ++++++++
 tests/tracetool/dtrace.log-stap              |  15 +++
 tests/tracetool/dtrace.simpletrace-stap      |  16 +++
 tests/tracetool/dtrace.stap                  |  14 +++
 tests/tracetool/ftrace.c                     |  32 ++++++
 tests/tracetool/ftrace.h                     |  59 ++++++++++
 tests/tracetool/log.c                        |  32 ++++++
 tests/tracetool/log.h                        |  43 ++++++++
 tests/tracetool/meson.build                  |  28 +++++
 tests/tracetool/simple.c                     |  61 +++++++++++
 tests/tracetool/simple.h                     |  40 +++++++
 tests/tracetool/syslog.c                     |  32 ++++++
 tests/tracetool/syslog.h                     |  43 ++++++++
 tests/tracetool/trace-events                 |   5 +
 tests/tracetool/tracetool-test.py            | 107 +++++++++++++++++++
 tests/tracetool/ust.c                        |  32 ++++++
 tests/tracetool/ust.h                        |  41 +++++++
 tests/tracetool/ust.ust-events-c             |  14 +++
 tests/tracetool/ust.ust-events-h             |  56 ++++++++++
 36 files changed, 826 insertions(+), 21 deletions(-)
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


