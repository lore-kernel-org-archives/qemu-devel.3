Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D734CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 09:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1iXI-0000gd-L5; Thu, 25 Sep 2025 05:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iXF-0000ek-7d
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:45:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iX6-0001Dc-0O
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758793495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZbiCnWb4l2IWtgum/cFkysJOW3fk9LbLJ1WOjTz7/yc=;
 b=badAvIwfas8wauGlPp4LM7ollkysET0LIpExoMFWY51FG5vPd8AE3JAY8wMI+eMgEurKvL
 z1lo5qS+zIB09yMssKScWsNscLwFIjcq4KCsjHMn+CeNGkIWjUejkCbtiubSlkvZFQEaXt
 t5qlTpcAymfKPlY+8zQyyJYAk2rsM5s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-aC7p4BXFOL2Z4VZQQXsulg-1; Thu,
 25 Sep 2025 05:44:51 -0400
X-MC-Unique: aC7p4BXFOL2Z4VZQQXsulg-1
X-Mimecast-MFC-AGG-ID: aC7p4BXFOL2Z4VZQQXsulg_1758793489
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D0B719560BB; Thu, 25 Sep 2025 09:44:49 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.163])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9046930002D0; Thu, 25 Sep 2025 09:44:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-rust@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 00/23] util: sync error_report & qemu_log output more
 closely
Date: Thu, 25 Sep 2025 10:44:18 +0100
Message-ID: <20250925094441.1651372-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

This series is a tangent that came out of discussion in

   https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg00903.html

In thinking about adding thread info to error_report, I
came to realize we should likely make qemu_log behave
consistently with error_report & friends. We already
honour '-msg timestamp=on', but don't honour 'guest-name=on'
and also don't include the binary name.

As an example of the current state, consider mixing error and
log output today:

- Default context:

  # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish \
                       -d 'trace:qcrypto*'
  qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55ac6d97f700 dir=fish
  qcrypto_tls_creds_get_path TLS creds path creds=0x55ac6d97f700 filename=ca-cert.pem path=<none>
  qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory

- Full context:

  # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish \
                       -d 'trace:qcrypto*' \
                       -msg guest-name=on,timestamp=on \
                       -name "fish food"
  2025-08-19T20:14:16.791413Z qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55e9a3458d10 dir=fish
  2025-08-19T20:14:16.791429Z qcrypto_tls_creds_get_path TLS creds path creds=0x55e9a3458d10 filename=ca-cert.pem path=<none>
  2025-08-19T20:14:16.791433Z fish food qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory

And after this series is complete:

- Default context:

  # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish \
                      -d 'trace:qcrypto*'
  qemu-system-x86_64(1184284:main): qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55a24ad5cb30 dir=fish
  qemu-system-x86_64(1184284:main): qcrypto_tls_creds_get_path TLS creds path creds=0x55a24ad5cb30 filename=ca-cert.pem path=<none>
  qemu-system-x86_64(1184284:main): Unable to access credentials fish/ca-cert.pem: No such file or directory

- Full context:

  # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish \
                      -d 'trace:qcrypto*' \
                      -msg guest-name=on,timestamp=on \
                      -name "fish food"
  2025-08-19T20:12:50.211823Z [fish food] qemu-system-x86_64(1168876:main): qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x5582183d8760 dir=fish
  2025-08-19T20:12:50.211842Z [fish food] qemu-system-x86_64(1168876:main): qcrypto_tls_creds_get_path TLS creds path creds=0x5582183d8760 filename=ca-cert.pem
+path=<none>
  2025-08-19T20:12:50.211846Z [fish food] qemu-system-x86_64(1168876:main): Unable to access credentials fish/ca-cert.pem: No such file or directory

The main things to note:

 * error_report/warn_report/qemu_log share the same
   output format and -msg applies to both

 * -msg debug-threads=on is now unconditionally enabled
   and thus the param is deprecated & ignored

 * Thread ID and name are unconditionally enabled

 * Guest name is surrounded in [...] brackets

 * The default output lines are typically 15 chars
   wider given that we always include the thread
   ID + name now

 * This takes the liberty of assigning the new file
   to the existing error-report.c maintainer (Markus)
   Since splitting it off into message.c instead of
   putting it all in error-report.c felt slightly
   nicer.

One thing I didn't tackle is making the location
info get reported for qemu_log. This is used to
give context for error messages when parsing some
CLI args, and could be interesting for log messages
associated with those same CLI args.

Changes in v4:

 - Re-architected the way error_vprintf() operates
   to simplify monitor dependency
 - Fixed the move of error_vprintf from monitor.c
   to error-report.c so that unit tests can still
   get a stub to capture messages to g_test_message
 - Simplify changes to vreport() to avoid passing
   around function pointers
 - Add locking of stderr to vreport() to serialize
   incremental output
 - Fix thread naming logic changes on Windows
 - Change deprecation warning messages

Changes in v3:

 - Stop formatting a string in qmessage_context, instead
   output directly to a "FILE *" stream
 - Fix pre-existing bug interleaving qemu_log and
   vreport when the trace 'log' backend has mutex probes
   enabled

Changes in v2:

 - Re-use existing qemu_get_thread_id rather than
   re-inventing it as qemu_thread_get_id.
 - Expose qemu_thread_set_name and use it from all
   locations needing to set thread names
 - Fix qemu_log() to skip context prefix when
   emitting a log message in fragments across
   multiple calls
 - Skip allocating memory for empty context messages
 - Fix leak in win32 impl of qemu_thread_get_name
 - Use g_strlcpy where possible

Daniel P. Berrangé (23):
  include: define constant for early constructor priority
  monitor: initialize global data from a constructor
  system: unconditionally enable thread naming
  util: expose qemu_thread_set_name
  audio: make jackaudio use qemu_thread_set_name
  util: set the name for the 'main' thread
  util: add API to fetch the current thread name
  log: avoid repeated prefix on incremental qemu_log calls
  util: introduce some API docs for logging APIs
  ui/vnc: remove use of error_printf_unless_qmp()
  monitor: remove redundant error_[v]printf_unless_qmp
  monitor: refactor error_vprintf()
  monitor: move error_vprintf back to error-report.c
  monitor: introduce monitor_cur_is_hmp() helper
  util: don't skip error prefixes when QMP is active
  util: fix interleaving of error & trace output
  util: fix interleaving of error prefixes
  util: introduce common helper for error-report & log code
  util: convert error-report & log to message API for timestamp
  util: add support for formatting a workload name in messages
  util: add support for formatting a program name in messages
  util: add support for formatting thread info in messages
  util: add brackets around guest name in message context

 MAINTAINERS                          |  2 +
 audio/jackaudio.c                    | 30 +++++++--
 docs/about/deprecated.rst            |  7 ++
 include/monitor/monitor.h            |  4 +-
 include/qemu/compiler.h              |  8 +++
 include/qemu/error-report.h          |  4 --
 include/qemu/log-for-trace.h         | 35 +++++++++-
 include/qemu/log.h                   | 26 ++++++++
 include/qemu/message.h               | 40 ++++++++++++
 include/qemu/thread.h                |  3 +-
 meson.build                          | 21 ++++++
 monitor/monitor.c                    | 61 ++++++-----------
 rust/util/src/log.rs                 |  7 ++
 storage-daemon/qemu-storage-daemon.c |  6 ++
 stubs/error-printf.c                 | 23 -------
 stubs/meson.build                    |  1 -
 stubs/monitor-core.c                 | 20 +++++-
 system/vl.c                          | 31 ++++++---
 tests/qemu-iotests/041               |  2 +-
 tests/qemu-iotests/common.filter     |  2 +-
 tests/unit/test-error-report.c       |  6 +-
 tests/unit/test-util-sockets.c       |  1 +
 ui/vnc.c                             | 14 ++--
 util/error-report.c                  | 97 +++++++++++++++++-----------
 util/log.c                           | 28 ++++----
 util/meson.build                     |  1 +
 util/message.c                       | 47 ++++++++++++++
 util/qemu-thread-posix.c             | 77 +++++++++++++++-------
 util/qemu-thread-win32.c             | 87 +++++++++++++++++--------
 29 files changed, 485 insertions(+), 206 deletions(-)
 create mode 100644 include/qemu/message.h
 delete mode 100644 stubs/error-printf.c
 create mode 100644 util/message.c

-- 
2.50.1


