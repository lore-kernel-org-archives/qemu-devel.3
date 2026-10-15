Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F307FCC6B3C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJW8-000217-Pl; Thu, 15 Oct 2026 07:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJW5-000208-FE
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:20:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJW3-00040H-0X
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NyDOPFHMdLCDs3tkT+jxVfa9CaV06y+teiW41aZ+d38=;
 b=MxoeZU3IepnSp6vD+4OlsHM+1MoM2JMBY37elb5w6wr0ai6vZaYD1NPQ2DSZwVYk6c2/QL
 ELB5GaXrOs3mCsbMW+pyWg+bv3GRp6sVi+j/YMu/mkmoR7AFsPcA92FXNnsW/sGsBnX4jF
 aH0VefcorHOipe9d/il34tPI/+MaC/8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-h5wYvG6GOkibxG44A2rZRw-1; Thu,
 15 Oct 2026 11:20:52 +0000
X-MC-Unique: h5wYvG6GOkibxG44A2rZRw-1
X-Mimecast-MFC-AGG-ID: h5wYvG6GOkibxG44A2rZRw_1792063250
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 595C91956079; Thu, 15 Oct 2026 11:20:50 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7D1CC1800677; Thu, 15 Oct 2026 11:20:46 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 00/21] system: introduce a live data recorder facility
Date: Thu, 15 Oct 2026 12:20:23 +0100
Message-ID: <20261015112044.1999748-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This series introduces a new facility called 'tldr' which is a
live data recorder. This is intended to aid support of production
QEMU deployments, by providing a data collection facility that
can be left "always on", such that in the event of a QEMU crash
or guest OS crash, certain important information will be recorded.

The data recorder has to be enabled by adding a "tldr-config"
object instance with -object / object_add.

With this series, the data recorder collects

 * error_report/warn_report/error_printf messages
 * QMP events
 * QMP errors
 * QMP commands, which are not query-XXX/qom-list,
   or any command associated with a QMP error.
 * qemu_log output

The last item is intended primarily to be used in combination
with tracing and its 'log' backend, to have continuous
recording of certain interesting probes.

Each type of data is collected in a distinct circular
buffer, such that high volumes of one type of data, does
not result in overwriting other types of low volume data.

The data recorder is set to trigger on SIGBUS, SIGSEGV,
SIGILL, SIGFPE and SIGABRT, or manually via QMP 'tldr-dump'.

There is a open question in one of the patches about SIGBUS
handling, since that is already used for MCE capture and I'm
unclear if I'm breaking something about KVM MCE reporting.

This series proposes using sigaltstack() to register an
alternative signal handling stack. This would mainly be
useful if we have a crash from a stack overflow, but the
cost is that we have 8k extra per thread, and I'm not
entirely convinced that's a beneficial tradeoff. Might
be better to just accept stack overflows as a risk.

This series only captures text based info, but as a followup
I would like to extend this to capture statistics data from
relevant subsystems. For example, the BlockBackend has its
own "always on" stats accounting code, which can be queried
with QMP. Ideally I would like to figure out a way to dump
all the BlockBackend stats in the data recorder output.
Likewise perhaps capture NIC stats and/or KVM stats in an
"always on" manner for some interesting baseline dataset.
The challenge with that is making it safe to access the
stats data without taking any mutex locks, since this must
run from a signal handler.

A typical recommended usage would be:

 $QEMU  -object tldr-config,id=tldr
        -d tldr
        -trace events=/var/lib/libvirt/qemu/trace.txt

This leaves dumps to go to QEMU's stderr on crash, but
to send them to a file

   -object tldr-config,id=tldr,crash-target=/some/path

The '-d tldr' flag redirects qemu_log() to the TLDR buffer
instead of stdout, and the '-trace events' arg defines
the "always on" tracepoints we want to capture.

An example crash dump seen if I send SIGBUS to a libvirt
managed QEMU is, with 'object*' tracepoints collected:

🚨🚨🚨 QEMU Data Recorder Start 🚨🚨🚨

🔍 Trigger:
  - Signal: SIGBUS (7)
  - Code: User process kill (0)
  - Address: 0x1e5a9e

🎥  Message recording 'command':
2026-10-15T10:59:11.318427Z {"execute": "qmp_capabilities", "id": "libvirt-1"}
2026-10-15T10:59:11.322047Z {"execute": "migrate-set-capabilities", "arguments": {"capabilities": [{"state": true, "capability": "events"}]}, "id": "libvirt-3"}
2026-10-15T10:59:11.347566Z {"execute": "balloon", "arguments": {"value": 4294967296}, "id": "libvirt-9"}
2026-10-15T10:59:11.354570Z {"execute": "set-action", "arguments": {"panic": "pause"}, "id": "libvirt-12"}
2026-10-15T10:59:11.358046Z {"execute": "cont", "id": "libvirt-14"}

🎥  Message recording 'event':
2026-10-15T10:59:11.358108Z {"timestamp": {"seconds": 1792061951, "microseconds": 358094}, "event": "RESUME"}
2026-10-15T10:59:20.757392Z {"timestamp": {"seconds": 1792061960, "microseconds": 757371}, "event": "VSERPORT_CHANGE", "data": {"open": true, "id": "console1"}}
2026-10-15T10:59:24.431398Z {"timestamp": {"seconds": 1792061964, "microseconds": 431379}, "event": "NIC_RX_FILTER_CHANGED", "data": {"name": "net0", "path": "/machine/peripheral/net0/virtio-backend"}}
2026-10-15T10:59:32.586658Z {"timestamp": {"seconds": 1792061972, "microseconds": 586603}, "event": "RTC_CHANGE", "data": {"offset": 0, "qom-path": "/machine/unattached/device[12]/rtc"}}

🎥  Message recording 'log':
28:QIO_CHANNEL_FILE)
2026-10-15T10:59:31.753125Z object_dynamic_cast_assert obj=0x557d5c828780 type=chardev-pty->chardev-pty (../chardev/char-pty.c:50:PTY_CHARDEV)
2026-10-15T10:59:31.753128Z object_dynamic_cast_assert obj=0x557d5c828780 type=chardev-pty->chardev-pty (../chardev/char-pty.c:50:PTY_CHARDEV)
2026-10-15T10:59:31.796114Z object_dynamic_cast_assert obj=0x557d5ca7d3a0 type=host-x86_64-cpu->x86_64-cpu (../target/i386/cpu-qom.h:31:X86_CPU)
2026-10-15T10:59:31.796148Z object_class_dynamic_cast_assert type=kvm-apic->apic-common (/home/berrange/src/virt/qemu/include/hw/i386/apic_internal.h:131:APIC_COMMON_GET_CLASS)

...snip...

2026-10-15T10:59:33.713641Z object_dynamic_cast_assert obj=0x557d5cc20b10 type=PCIE->PCI (/home/berrange/src/virt/qemu/include/hw/pci/pci.h:289:PCI_BUS)
2026-10-15T10:59:33.713643Z object_class_dynamic_cast_assert type=PCIE->PCI (/home/berrange/src/virt/qemu/include/hw/pci/pci.h:289:PCI_BUS_GET_CLASS)
2026-10-15T10:59:33.713648Z object_dynamic_cast_assert obj=0x557d5ca03700 type=host-x86_64-cpu->x86_64-cpu (../target/i386/cpu-qom.h:31:X86_CPU)
2026-10-15T10:59:33.713664Z object_dynamic_cast_assert obj=0x557d5eadd320 type=virtio-gpu-device->virtio-device (/home/berrange/src/virt/qemu/include/hw/virtio/virtio.h:91:VIRTIO_DEVICE)

🚨🚨🚨 QEMU Data Recorder End 🚨🚨🚨

"object_*" is not a particularly good choice for 'always on'
data collection as it is high volume and mostly noise. The
job of identifying the "interesting" low volume tracepoints
is outstanding. We can provide guidance upstream but downstream
should control what they're interested in collecting. We might
want to add further tracepoints in the code at interesting
places that we useful for post-crash debugging.

Daniel P. Berrangé (21):
  osdep: add 'ignore_value(x)' macro
  system: move SIGBUS signal handling to signal.c
  system: rename qemu_init_sigbus to qemu_init_crash_signals
  system: run SIGBUS handler on alternate signal stack
  util: expand alternate signal stack to all threads
  osdep: provide dummy siginfo_t definition
  util: introduce 'tldr', a system data recorder for crash handling
  qapi: add 'tldr-dump' command for on-demand data recorder output
  system: trigger TLDR crash dump on unhandled SIGBUS
  system: simplify signal handler logic
  main: allow SIGBUS in the main loop
  system: enable SIGBUS handling on non-Linux platforms
  system: enable crash dumps on SIGSEGV, SIGILL, SIGFPE and SIGABRT
  util: introduce capture of textual messages in data recorder
  util: capture warnings and errors in the data recorder
  monitor: remove obsolete/redundant exports
  monitor: capture monitor commands and events in data recorder
  log: enable directing log messages to data recorder
  tests/qtest: add API to declare an expected crash signal
  qtest: add 'crash' command to generate 'authentic' process crashes
  tests/qtest: add test to validate data recorder on crashes

 MAINTAINERS                 |  12 +
 include/qemu/log.h          |   1 +
 include/qemu/osdep.h        |  16 +
 include/qemu/tldr.h         |  76 ++++
 include/system/signal.h     |  25 ++
 meson.build                 |   4 +
 monitor/monitor-internal.h  |   2 -
 monitor/qmp.c               |  66 +++-
 qapi/meson.build            |   1 +
 qapi/qapi-schema.json       |   1 +
 qapi/qom.json               |  18 +
 qapi/tldr.json              |  62 +++
 qemu-options.hx             |  24 ++
 stubs/meson.build           |   1 +
 stubs/monitor-puts.c        |   9 +
 system/cpus.c               |  78 +---
 system/meson.build          |   1 +
 system/qtest.c              |  50 +++
 system/signal.c             | 149 +++++++
 tests/qtest/libqtest.c      |  62 ++-
 tests/qtest/libqtest.h      |  27 ++
 tests/qtest/meson.build     |   3 +
 tests/qtest/tldr-test.c     | 124 ++++++
 tests/unit/meson.build      |   1 +
 tests/unit/test-util-tldr.c | 377 ++++++++++++++++++
 util/error-report.c         |  43 ++-
 util/log.c                  |  42 +-
 util/main-loop.c            |   1 -
 util/meson.build            |   1 +
 util/qemu-thread-posix.c    |  20 +
 util/tldr-internal.h        |  52 +++
 util/tldr.c                 | 750 ++++++++++++++++++++++++++++++++++++
 32 files changed, 1976 insertions(+), 123 deletions(-)
 create mode 100644 include/qemu/tldr.h
 create mode 100644 include/system/signal.h
 create mode 100644 qapi/tldr.json
 create mode 100644 stubs/monitor-puts.c
 create mode 100644 system/signal.c
 create mode 100644 tests/qtest/tldr-test.c
 create mode 100644 tests/unit/test-util-tldr.c
 create mode 100644 util/tldr-internal.h
 create mode 100644 util/tldr.c

-- 
2.56.0


