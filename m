Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205C4C28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tren0-00022Y-7X; Mon, 10 Mar 2025 11:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1tremy-00020O-5q
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:11:32 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1tremu-0007fM-FG
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:11:31 -0400
Received: (qmail 30594 invoked by uid 484); 10 Mar 2025 15:11:08 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.13.100 by smtp1.lauterbach.com
 (envelope-from <mario.fleischmann@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.13.100):. 
 Processed in 0.262838 secs); 10 Mar 2025 15:11:08 -0000
Received: from unknown (HELO mflpc1.LTB.LAN)
 (Authenticated_SSL:mfleischmann@[10.2.13.100])
 (envelope-sender <mario.fleischmann@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 10 Mar 2025 15:11:08 -0000
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, armbru@redhat.com,
 christian.boenig@lauterbach.com,
 Mario Fleischmann <mario.fleischmann@lauterbach.com>
Subject: [PATCH 00/16] Add Multi-Core Debug (MCD) API support
Date: Mon, 10 Mar 2025 16:04:54 +0100
Message-Id: <20250310150510.200607-1-mario.fleischmann@lauterbach.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Qmail-Scanner-2.11: added fake Content-Type header
Content-Type: text/plain
Received-SPF: pass client-ip=62.154.241.196;
 envelope-from=mario.fleischmann@lauterbach.com; helo=smtp1.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

This patch series introduces support for the Multi-Core Debug (MCD) API, a
commonly used debug interface by emulators. The MCD API, defined through a
header file, consists of 54 functions for implementing debug and trace.
However, since it is a header-file-only interface, MCD does not specify a
communication protocol. We get around this limitation by following a remote
procedure call approach using QMP. The client stub corresponding to this
implementation can be found at https://gitlab.com/lauterbach/mcdrefsrv

This series is the successor to:
"[PATCH v5 00/18] first version of mcdstub"
(https://patchew.org/QEMU/20231220162555.19545-1-nicolas.eder@lauterbach.com/)

* Architecture-independent MCD implementation
* QMP instead of custom TCP protocol

qemu-system-<arch> [options] -qmp tcp::1235,server=on,wait=off

* Architecture-independent QTest test suite

V=1 QTEST_QEMU_BINARY="./qemu-system-<arch> [options]" tests/qtest/mcd-test

* Architecture-specific tests can be found at the client stub

Mario Fleischmann (16):
  mcd: Introduce Multi-Core Debug (MCD) API
  mcd: Introduce MCD server
  mcd: Implement target initialization API
  mcd: Implement server connection API
  mcd: Implement target system query
  mcd: Implement core connection control
  mcd: Implement memory space query
  gdbstub: Expose GDBRegisterState
  mcd: Implement register query
  mcd: Implement runstate control
  mcd test: Implement core state query
  gdbstub: Expose gdb_write_register
  mcd: Implement register/memory access
  mcd: Implement single stepping
  mcd: Implement trigger control
  mcd: Implement reset control

 MAINTAINERS               |    9 +
 docs/interop/index.rst    |    1 +
 docs/interop/mcd.rst      |   58 +
 gdbstub/gdbstub.c         |   15 +-
 include/exec/gdbstub.h    |   18 +-
 mcd/libmcd_qapi.c         |  506 +++++
 mcd/libmcd_qapi.h         |   81 +
 mcd/mcd_api.h             | 3963 +++++++++++++++++++++++++++++++++++++
 mcd/mcdserver.c           | 2242 +++++++++++++++++++++
 mcd/mcdstub_qapi.c        |  974 +++++++++
 mcd/meson.build           |   12 +
 meson.build               |    1 +
 qapi/mcd.json             | 2366 ++++++++++++++++++++++
 qapi/meson.build          |    1 +
 qapi/qapi-schema.json     |    1 +
 tests/qtest/libmcd-test.c |  379 ++++
 tests/qtest/libmcd-test.h |   68 +
 tests/qtest/mcd-test.c    |  644 ++++++
 tests/qtest/meson.build   |    2 +
 19 files changed, 11331 insertions(+), 10 deletions(-)
 create mode 100644 docs/interop/mcd.rst
 create mode 100644 mcd/libmcd_qapi.c
 create mode 100644 mcd/libmcd_qapi.h
 create mode 100644 mcd/mcd_api.h
 create mode 100644 mcd/mcdserver.c
 create mode 100644 mcd/mcdstub_qapi.c
 create mode 100644 mcd/meson.build
 create mode 100644 qapi/mcd.json
 create mode 100644 tests/qtest/libmcd-test.c
 create mode 100644 tests/qtest/libmcd-test.h
 create mode 100644 tests/qtest/mcd-test.c

-- 
2.34.1


