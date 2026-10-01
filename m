Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6E0CA5FD9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 15:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCISf-0000pR-5w; Thu, 01 Oct 2026 11:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCISb-0000ov-ES
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 11:12:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCISZ-0000tj-4s
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 11:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790867553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=r5yQb06djCrJowNbh57gbahzy5vlO1ovG+maLIGD0m0=;
 b=A9sSdap1AAX1+o25Ct5mbya/qkg9/C73n6tmxtRULvuvT7eVZIEIxnFt9jJEl2snKPlot8
 xaFQoDeymlU7TajvY+6JCCG0ogpiN1IV7TznHqfMmWdcJKJH8iUfTny4Y/cNZKKu81XIbB
 qAsTD9TMqAKiwjOBgHsbNvu05OQtTRg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-D8gOOBXzP7WMymJvgX5O1w-1; Thu,
 01 Oct 2026 11:12:31 -0400
X-MC-Unique: D8gOOBXzP7WMymJvgX5O1w-1
X-Mimecast-MFC-AGG-ID: D8gOOBXzP7WMymJvgX5O1w_1790867551
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B38C0180131A
 for <qemu-devel@nongnu.org>; Thu,  1 Oct 2026 15:12:30 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8CAC81956042; Thu,  1 Oct 2026 15:12:29 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 00/20] trace: bugfixes, cleanups and optimizations
Date: Thu,  1 Oct 2026 16:12:08 +0100
Message-ID: <20261001151228.3373747-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series started off with fixing some compile failures seen
with dtrace and ust backends, and got somewhat out of hand as
I looked more deeply at the trace code. So it ended up doing
various bits of code cleanup and memory usage optimizations.

The optimizations aren't huge against each individual binaries.
There are too many scenarios to show the full set, but here
are some binary size examples

The current git master baseline for different enabled
backends  on the x86_64 emulator:

  nop 88546360
  dtrace 90604496
  ftrace 93265944
  log 93799528
  syslog 93962704
  simple 97064528
  ust 162999944
  dtrace,ftrace,log,syslog,simple,ust 174438088

'ust' has insanely high overhead in terms of binary sizes,
inexplicably insane.

'ftrace/log/syslog' are all similar because their overhead
is dominated by the printf() format strings which are
identical in all.

'simple' is a bit worse because of the helper functions we
must generated for each probe

After this series is applied the results for x86_64 are

  nop 88510248
  dtrace 90576160
  ftrace 93156320
  log 93735064
  syslog 93853480
  simple 97050856
  ust 162957256
  dtrace,ftrace,log,syslog,simple,ust 174431128

IOW, for 'dtrace', we save 28k, for 'log' we save 62k

For the aarch64 binary, we see bigger saving in some
cases:

  baseline dtrace 127610144
  baseline log 131050320
     trace dtrace 127459264
     trace log  130998872

IOW, for 'dtrace' we save 150k, for 'log' we only save
50k. No clue why the saving is not so significant for
the 'log' backend but not a big deal.

Daniel P. Berrangé (20):
  osdep: add 'ignore_value(x)' macro
  trace: use 'ignore_value()' instead of a dummy variable
  trace: fix handling of char** in UST backend
  hw/xen: replace "long unsigned int" with "unsigned long " for dtrace
  trace: block use of "long int" for dtrace
  trace: drop unused trace_event_set_state_dynamic_init()
  trace: remove obsolete references to vcpu property
  trace: drop 'id' from TraceEvent struct when not required
  trace: change "DSTATE" variables from uint16_t to uint8_t
  trace: add testing of 'nop' trace backend
  trace: don't emit TraceEvent structs when 'nop' backend is used
  trace: add test of generation with all backends enabled
  trace: remove redundant headers from simple trace backend code
  audio: remove mistaken use of trace_event_get_state()
  hw/ppc: remove mistaken use of trace_event_get_state()
  trace: include qemu_loglevel_mask(LOG_TRACE) in guard
  trace: remove "disable" property from trace files
  trace: stop tracking static disabled state
  trace: remove parsing of "disable" event property
  trace: remove 'trace_event_get_state' wrapper

 audio/audio-mixeng-be.c                      |   2 +-
 hw/display/trace-events                      |   2 +-
 hw/ppc/vof.c                                 |  13 +--
 hw/xen/trace-events                          |   4 +-
 include/qemu/osdep.h                         |   8 ++
 monitor/qmp.c                                |   4 +-
 qapi/trace.json                              |   5 +-
 scripts/tracetool/__init__.py                |  32 ++----
 scripts/tracetool/backend/__init__.py        |   3 +-
 scripts/tracetool/backend/dtrace.py          |   2 -
 scripts/tracetool/backend/log.py             |   3 +-
 scripts/tracetool/backend/simple.py          |   4 +-
 scripts/tracetool/format/c.py                |  74 +++++++-------
 scripts/tracetool/format/d.py                |   3 -
 scripts/tracetool/format/h.py                |  42 ++++----
 scripts/tracetool/format/log_stap.py         |   3 -
 scripts/tracetool/format/rs.py               |  30 +++---
 scripts/tracetool/format/simpletrace_stap.py |   3 -
 scripts/tracetool/format/stap.py             |   3 -
 scripts/tracetool/format/ust_events_c.py     |   3 -
 scripts/tracetool/format/ust_events_h.py     |   7 +-
 stubs/trace-control.c                        |   6 --
 target/hppa/trace-events                     |  28 ++---
 tests/tracetool/all.c                        |  61 +++++++++++
 tests/tracetool/all.d                        |  10 ++
 tests/tracetool/all.h                        | 102 +++++++++++++++++++
 tests/tracetool/all.log-stap                 |  15 +++
 tests/tracetool/all.rs                       |  90 ++++++++++++++++
 tests/tracetool/all.simpletrace-stap         |  16 +++
 tests/tracetool/all.stap                     |  14 +++
 tests/tracetool/all.ust-events-c             |  14 +++
 tests/tracetool/all.ust-events-h             |  56 ++++++++++
 tests/tracetool/dtrace.c                     |  10 +-
 tests/tracetool/dtrace.h                     |   6 +-
 tests/tracetool/dtrace.rs                    |   6 +-
 tests/tracetool/ftrace.c                     |  10 +-
 tests/tracetool/ftrace.h                     |  14 ++-
 tests/tracetool/ftrace.rs                    |   6 +-
 tests/tracetool/log.c                        |  10 +-
 tests/tracetool/log.h                        |  20 ++--
 tests/tracetool/log.rs                       |   6 +-
 tests/tracetool/meson.build                  |   4 +-
 tests/tracetool/nop.c                        |   7 ++
 tests/tracetool/nop.h                        |  25 +++++
 tests/tracetool/nop.rs                       |  51 ++++++++++
 tests/tracetool/simple.c                     |  12 +--
 tests/tracetool/simple.h                     |  10 +-
 tests/tracetool/simple.rs                    |   6 +-
 tests/tracetool/syslog.c                     |  10 +-
 tests/tracetool/syslog.h                     |  14 ++-
 tests/tracetool/syslog.rs                    |   6 +-
 tests/tracetool/tracetool-test.py            |  12 ++-
 tests/tracetool/ust.c                        |  10 +-
 tests/tracetool/ust.h                        |   6 +-
 trace/control-internal.h                     |   8 +-
 trace/control-target.c                       |  29 ------
 trace/control.c                              |  19 +---
 trace/control.h                              |  43 +-------
 trace/event-internal.h                       |  19 +---
 trace/ftrace.c                               |   3 +-
 trace/qmp.c                                  |  47 +++------
 trace/simple.c                               |   9 +-
 62 files changed, 704 insertions(+), 396 deletions(-)
 create mode 100644 tests/tracetool/all.c
 create mode 100644 tests/tracetool/all.d
 create mode 100644 tests/tracetool/all.h
 create mode 100644 tests/tracetool/all.log-stap
 create mode 100644 tests/tracetool/all.rs
 create mode 100644 tests/tracetool/all.simpletrace-stap
 create mode 100644 tests/tracetool/all.stap
 create mode 100644 tests/tracetool/all.ust-events-c
 create mode 100644 tests/tracetool/all.ust-events-h
 create mode 100644 tests/tracetool/nop.c
 create mode 100644 tests/tracetool/nop.h
 create mode 100644 tests/tracetool/nop.rs

-- 
2.55.0


