Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A38D1D478
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 17:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdtQU-0003ZY-8X; Thu, 08 Jan 2026 12:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdtQR-0003QE-Tb
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:03:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdtQP-0006pE-Fc
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767891830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YF+Mwc+s7Lfbg/SwzKToQkDN48nwZ7Uo/gx34kG9XBg=;
 b=KO/zdz7BVdjLDo9AhVuw0z9ZxLJC7qier3qQAsB0gKmyDc15pvu0l73+VxTO20SVOBMCL7
 qtT3edGbqwManeaICHG8X3unxbRetj9U2RkHzQjx8jY/Jnm72dLs5rEPE4BFHW1T/AC89T
 ot9m3+K5km1HqzhVogzteNFbQPVcV6E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-cV_Au9f_N3qq0ZEKRhjOtQ-1; Thu,
 08 Jan 2026 12:03:47 -0500
X-MC-Unique: cV_Au9f_N3qq0ZEKRhjOtQ-1
X-Mimecast-MFC-AGG-ID: cV_Au9f_N3qq0ZEKRhjOtQ_1767891825
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC1AA18005B2; Thu,  8 Jan 2026 17:03:44 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.44])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C23B519560A2; Thu,  8 Jan 2026 17:03:39 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 00/24] util: sync error_report & qemu_log output more
 closely
Date: Thu,  8 Jan 2026 17:03:14 +0000
Message-ID: <20260108170338.2693853-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Changes in v5:

 - Remove redundant [] around values in qemu-options.hx
 - Use g_strlcpy instead of strlcpy
 - Remove redundant !! around a value that was already bool
 - Improve the qemu_lock_trylock() API docs to encourage
   use of fprintf() instead of further qemu_log() calls
 - Add a qemu_log_trylock_context() counterpart for
   qemu_log_trylock that includes the message context
 - Don't scan for \n to determine whether we can output
   a message context prefix or not. Instead track call
   depth on qemu_log_trylock() and only output it when
   the depth was initially zero. This fixes linux-user
   -strace output formatting which was mangled by v4
 - Use fprintf(stderr) instead of error_printf_mon
   in cases where mon would be NULL
 - Use fputs/fputc in simple cases where we don't need the
   full power of fprintf
 - Use qemu_f{un}lockfile instead of f{un}lockfile
 - Add  -msg thread-info=on|off,program-name=on|off args
   to allow default message prefixes to be optionally disabled

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

Daniel P. Berrangé (24):
  qemu-options: remove extraneous [] around arg values
  include: define constant for early constructor priority
  monitor: initialize global data from a constructor
  system: unconditionally enable thread naming
  util: expose qemu_thread_set_name
  audio: make jackaudio use qemu_thread_set_name
  util: set the name for the 'main' thread
  util: add API to fetch the current thread name
  util: introduce some API docs for logging APIs
  util: avoid repeated prefix on incremental qemu_log calls
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

 MAINTAINERS                          |   2 +
 audio/jackaudio.c                    |  30 +++++--
 docs/about/deprecated.rst            |   7 ++
 include/monitor/monitor.h            |   4 +-
 include/qemu/compiler.h              |   8 ++
 include/qemu/error-report.h          |   4 -
 include/qemu/log-for-trace.h         |  17 +++-
 include/qemu/log.h                   |  38 +++++++++
 include/qemu/message.h               |  40 +++++++++
 include/qemu/thread.h                |   3 +-
 meson.build                          |  21 +++++
 monitor/monitor.c                    |  61 +++++---------
 qemu-options.hx                      | 121 ++++++++++++++-------------
 rust/util/src/log.rs                 |   6 ++
 storage-daemon/qemu-storage-daemon.c |   6 ++
 stubs/error-printf.c                 |  23 -----
 stubs/meson.build                    |   1 -
 stubs/monitor-core.c                 |  20 ++++-
 system/vl.c                          |  49 +++++++++--
 tests/qemu-iotests/041               |   2 +-
 tests/qemu-iotests/common.filter     |   2 +-
 tests/unit/test-error-report.c       |   6 +-
 tests/unit/test-util-sockets.c       |   1 +
 ui/vnc.c                             |  14 ++--
 util/error-report.c                  |  97 ++++++++++++---------
 util/log.c                           |  47 ++++++-----
 util/meson.build                     |   1 +
 util/message.c                       |  51 +++++++++++
 util/qemu-thread-posix.c             |  77 +++++++++++------
 util/qemu-thread-win32.c             |  87 +++++++++++++------
 30 files changed, 580 insertions(+), 266 deletions(-)
 create mode 100644 include/qemu/message.h
 delete mode 100644 stubs/error-printf.c
 create mode 100644 util/message.c

-- 
2.52.0


