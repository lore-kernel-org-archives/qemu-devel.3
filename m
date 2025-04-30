Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2D0C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 05:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9zzh-0002BQ-Fa; Wed, 30 Apr 2025 01:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u9zzf-0002Ac-Qt
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 01:28:27 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u9zza-0006hR-7g
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 01:28:26 -0400
Received: (qmail 1597 invoked by uid 484); 30 Apr 2025 05:28:02 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.13.100 by smtp1.lauterbach.com
 (envelope-from <mario.fleischmann@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.13.100):. 
 Processed in 0.249008 secs); 30 Apr 2025 05:28:02 -0000
Received: from unknown (HELO mflpc1.LTB.LAN)
 (Authenticated_SSL:mfleischmann@[10.2.13.100])
 (envelope-sender <mario.fleischmann@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 30 Apr 2025 05:28:02 -0000
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, armbru@redhat.com,
 christian.boenig@lauterbach.com,
 Mario Fleischmann <mario.fleischmann@lauterbach.com>
Subject: [PATCH v2 00/20] Add Multi-Core Debug (MCD) API support
Date: Wed, 30 Apr 2025 07:27:21 +0200
Message-Id: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
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

This patch series introduces support for the Multi-Core Debug (MCD) API, a
commonly used debug interface by emulators. The MCD API, defined through a
header file, consists of 54 functions for implementing debug and trace.
However, since it is a header-file-only interface, MCD does not specify a
communication protocol.

To keep the overhead of a communication protocol on top of MCD minimal,
we follow a remote procedure call approach by using QAPI as an interface
definition and transport infrastructure. This way, we can use qapi-gen to
take care of generating the infrastructure to dispatch MCD functions and
to (un)marshal their arguments and results. Furthermore, qapi-doc and qtest
provide good integration into QEMU's documentation and test frameworks.

In v1 of this patch series, the MCD protocol was directly integrated in QMP
and the QMP monitor was responsible for dispatching MCD's server stub. This
introduced a dependency between QEMU's machine protocol and the MCD debug
protocol which is not to be expected. For this reason, v2 introduces a MCD
monitor which uses as much of the QMP monitor's framework as possible but
keeps the two protocols separate from each other.
Similarly, MCD's test suite uses as much of the qtest framework as is useful
for sending JSON commands to the QEMU under test but adds new code where
required to prevent dependencies to QMP.

To enable MCD, configure QEMU with `--enable-mcd`.

To start the MCD monitor, run QEMU with the `-mcd` option:
qemu-system-<arch> [options] -qmp tcp::1235,server=on,wait=off

To run the MCD test suite independently, start `mcd-test`:
V=1 QTEST_QEMU_BINARY="./qemu-system-<arch> [options]" tests/qtest/mcd-test

To connect from a MCD client, a client stub corresponding to this
patch series can be found at https://gitlab.com/lauterbach/mcdrefsrv

Mario Fleischmann (20):
  mcd: Introduce Multi-Core Debug (MCD) API
  meson: Add --enable-mcd option
  mcd: Introduce MCD server
  qapi: Introduce MCD schema
  mcd: Introduce MCD server stub
  qtest: Introduce MCD test suite
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

 MAINTAINERS                   |    9 +
 docs/interop/index.rst        |    1 +
 docs/interop/mcd.rst          |   65 +
 gdbstub/gdbstub.c             |   15 +-
 include/exec/gdbstub.h        |   18 +-
 include/exec/mcdstub.h        |   18 +
 mcd/mcd_api.h                 | 3963 +++++++++++++++++++++++++++++++++
 mcd/mcd_monitor.c             |   90 +
 mcd/mcd_qapi.c                |  505 +++++
 mcd/mcd_qapi.h                |   81 +
 mcd/mcd_server.c              | 2274 +++++++++++++++++++
 mcd/mcd_stub.c                |  988 ++++++++
 mcd/meson.build               |   60 +
 meson.build                   |    5 +
 meson_options.txt             |    3 +
 qapi/mcd.json                 | 2366 ++++++++++++++++++++
 qemu-options.hx               |   11 +
 scripts/meson-buildoptions.sh |    3 +
 system/vl.c                   |   13 +
 tests/qtest/mcd-test.c        |  698 ++++++
 tests/qtest/mcd-util.c        |  389 ++++
 tests/qtest/mcd-util.h        |   73 +
 tests/qtest/meson.build       |    5 +
 23 files changed, 11643 insertions(+), 10 deletions(-)
 create mode 100644 docs/interop/mcd.rst
 create mode 100644 include/exec/mcdstub.h
 create mode 100644 mcd/mcd_api.h
 create mode 100644 mcd/mcd_monitor.c
 create mode 100644 mcd/mcd_qapi.c
 create mode 100644 mcd/mcd_qapi.h
 create mode 100644 mcd/mcd_server.c
 create mode 100644 mcd/mcd_stub.c
 create mode 100644 mcd/meson.build
 create mode 100644 qapi/mcd.json
 create mode 100644 tests/qtest/mcd-test.c
 create mode 100644 tests/qtest/mcd-util.c
 create mode 100644 tests/qtest/mcd-util.h

-- 
2.34.1


