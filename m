Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109006071AE0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cS/0A9lG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOhR8-0006sn-Oa; Wed, 04 Nov 2026 15:18:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xOhR6-0006rS-BK
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 15:18:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xOhR3-00062E-J8
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 15:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793823495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7D6FRaI17g5La1VKpEb91sSZYaYl9ZQWL6H1VMc1WdA=;
 b=cS/0A9lG2ptb6PUUHTH+fNdxElI2kiN9Dk5BJRKC22ZjVT6nYVEdIhMkAbLC18vGMa7QF+
 dG6yKKzyQun0qAhPTS7PF8hGjJPyxgSXC0coxNBuWvXJeXtdrLiunCexiICem/GDGI7eog
 05IkC+UHfdoV88XtvyVH2sutZNvn12g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-NR1f4T1OPZWxkvYgafSrRg-1; Wed,
 04 Nov 2026 15:18:11 -0500
X-MC-Unique: NR1f4T1OPZWxkvYgafSrRg-1
X-Mimecast-MFC-AGG-ID: NR1f4T1OPZWxkvYgafSrRg_1793823485
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03BBB18002EC; Wed,  4 Nov 2026 20:18:05 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 80FA11848D42; Wed,  4 Nov 2026 20:18:03 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-ppc@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Helge Deller <deller@gmx.de>
Subject: [PULL v2 00/25] Tracing patches
Date: Wed,  4 Nov 2026 15:17:36 -0500
Message-ID: <20261104201802.11556-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit f29ccc287a6cfdd51d3a4fd17fbe9af3310a0ac5:

  Merge tag 'pull-11.2-misc-fixes-031126-1' of https://gitlab.com/stsquad/qemu into staging (2026-11-03 14:44:10 -0800)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to ddfa19c50616657cda4476260ce300c9463b09d3:

  trace: remove 'trace_event_get_state' wrapper (2026-11-04 13:19:12 -0500)

----------------------------------------------------------------
Pull request

v2:
- Update "trace: include qemu_loglevel_mask(LOG_TRACE) in guard" so the Rust build succeeds [Daniel]

----------------------------------------------------------------

Daniel P. Berrangé (25):
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
  trace: include probe name in Rust format strings
  trace: add missing newline in ftrace Rust format string
  trace: eliminate dupe trace_event_get_state_dynamic_by_id() calls
  audio: remove mistaken use of trace_event_get_state()
  hw/ppc: remove mistaken use of trace_event_get_state()
  monitor: remove mistaken use of trace_event_get_state()
  trace: include qemu_loglevel_mask(LOG_TRACE) in guard
  target/hppa: use PRIx64 in trace-events
  trace: remove "disable" property from trace files
  trace: stop tracking static disabled state
  trace: remove parsing of "disable" event property
  trace: remove 'trace_event_get_state' wrapper

 docs/devel/tracing.rst                       |  27 +----
 qapi/trace.json                              |   5 +-
 include/qemu/osdep.h                         |   8 ++
 tests/tracetool/all.h                        | 100 +++++++++++++++++++
 tests/tracetool/dtrace.h                     |   6 +-
 tests/tracetool/ftrace.h                     |  14 ++-
 tests/tracetool/log.h                        |  26 +++--
 tests/tracetool/nop.h                        |  25 +++++
 tests/tracetool/simple.h                     |  10 +-
 tests/tracetool/syslog.h                     |  14 ++-
 tests/tracetool/ust.h                        |   6 +-
 trace/control-internal.h                     |   8 +-
 trace/control.h                              |  49 +--------
 trace/event-internal.h                       |  19 +---
 audio/audio-mixeng-be.c                      |   2 +-
 hw/ppc/vof.c                                 |  13 +--
 monitor/qmp.c                                |   4 +-
 stubs/trace-control.c                        |   6 --
 tests/tracetool/all.c                        |  61 +++++++++++
 tests/tracetool/dtrace.c                     |  10 +-
 tests/tracetool/ftrace.c                     |  10 +-
 tests/tracetool/log.c                        |  10 +-
 tests/tracetool/nop.c                        |   7 ++
 tests/tracetool/simple.c                     |  12 +--
 tests/tracetool/syslog.c                     |  10 +-
 tests/tracetool/ust.c                        |  10 +-
 trace/control-target.c                       |  29 ------
 trace/control.c                              |  19 +---
 trace/ftrace.c                               |   3 +-
 trace/qmp.c                                  |  47 +++------
 trace/simple.c                               |   9 +-
 hw/display/trace-events                      |   2 +-
 hw/xen/trace-events                          |   4 +-
 scripts/tracetool/__init__.py                |  32 ++----
 scripts/tracetool/backend/__init__.py        |   7 +-
 scripts/tracetool/backend/dtrace.py          |   2 -
 scripts/tracetool/backend/ftrace.py          |   8 +-
 scripts/tracetool/backend/log.py             |  22 ++--
 scripts/tracetool/backend/simple.py          |   9 +-
 scripts/tracetool/backend/syslog.py          |   6 +-
 scripts/tracetool/format/c.py                |  68 ++++++-------
 scripts/tracetool/format/d.py                |   3 -
 scripts/tracetool/format/h.py                |  48 ++++-----
 scripts/tracetool/format/log_stap.py         |   3 -
 scripts/tracetool/format/rs.py               |  30 +++---
 scripts/tracetool/format/simpletrace_stap.py |   3 -
 scripts/tracetool/format/stap.py             |   3 -
 scripts/tracetool/format/ust_events_c.py     |   3 -
 scripts/tracetool/format/ust_events_h.py     |   7 +-
 target/hppa/trace-events                     |  28 +++---
 tests/tracetool/all.d                        |  10 ++
 tests/tracetool/all.log-stap                 |  15 +++
 tests/tracetool/all.rs                       |  98 ++++++++++++++++++
 tests/tracetool/all.simpletrace-stap         |  16 +++
 tests/tracetool/all.stap                     |  14 +++
 tests/tracetool/all.ust-events-c             |  14 +++
 tests/tracetool/all.ust-events-h             |  56 +++++++++++
 tests/tracetool/dtrace.rs                    |   6 +-
 tests/tracetool/ftrace.rs                    |  10 +-
 tests/tracetool/log.rs                       |  12 ++-
 tests/tracetool/meson.build                  |   4 +-
 tests/tracetool/nop.rs                       |  51 ++++++++++
 tests/tracetool/simple.rs                    |   6 +-
 tests/tracetool/syslog.rs                    |  10 +-
 tests/tracetool/tracetool-test.py            |  12 ++-
 65 files changed, 747 insertions(+), 454 deletions(-)
 create mode 100644 tests/tracetool/all.h
 create mode 100644 tests/tracetool/nop.h
 create mode 100644 tests/tracetool/all.c
 create mode 100644 tests/tracetool/nop.c
 create mode 100644 tests/tracetool/all.d
 create mode 100644 tests/tracetool/all.log-stap
 create mode 100644 tests/tracetool/all.rs
 create mode 100644 tests/tracetool/all.simpletrace-stap
 create mode 100644 tests/tracetool/all.stap
 create mode 100644 tests/tracetool/all.ust-events-c
 create mode 100644 tests/tracetool/all.ust-events-h
 create mode 100644 tests/tracetool/nop.rs

-- 
2.56.0


