Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A755F47CA4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCoL-000279-IT; Thu, 05 Mar 2026 12:48:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyCnr-0001wd-8j
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:48:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyCnm-00026l-Cs
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:48:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772732875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=U/GF1jS37Mr90bbf8ilU5P9jvycnugt+I099M69dJ8k=;
 b=WwHyVBiz84kIGFASjX6/Y9bg7pTCkl2uwDB1GzpUZZmUtWYnSw6G6tV/JcaKnqBm81Ee5U
 4kGxiDaKdZWRCDnYCS9qYfBmG+IoRHMs/5CtmBty8OGoPruE/km/o/9EY+PxsIQP7kjoc/
 mFhDQtmqqvyd1/zv4nfpQbsRyWEaN5g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-lBOTWUNrM9K6Zzs18b9mlA-1; Thu,
 05 Mar 2026 12:47:54 -0500
X-MC-Unique: lBOTWUNrM9K6Zzs18b9mlA-1
X-Mimecast-MFC-AGG-ID: lBOTWUNrM9K6Zzs18b9mlA_1772732872
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 906DC195609D; Thu,  5 Mar 2026 17:47:51 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.44.34.61])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA1C31956095; Thu,  5 Mar 2026 17:47:45 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, qemu-rust@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>
Subject: [PULL v2 00/27] Misc patches queue
Date: Thu,  5 Mar 2026 17:47:16 +0000
Message-ID: <20260305174743.3084606-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 3fb456e9a0e9eef6a71d9b49bfff596a0f0046e9:

  Merge tag 'pull-request-2026-03-02' of https://gitlab.com/thuth/qemu into staging (2026-03-02 14:01:46 +0000)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/next-pr-pull-request

for you to fetch changes up to ca61f91ef9b0d10333881fd0070303ea33cbc72e:

  util/oslib-posix: increase memprealloc thread count to 32 (2026-03-05 17:40:24 +0000)

----------------------------------------------------------------
* Increase pre-alloc max thread count to 32
* Fix checkpatch warning for new/removed files with --terse
* Detect more GPL boilerplate in checkpatch
* Fix lean of data in TLS/websock GSource cancellation
* Tweak CPU docs for DiamondRapids
* Unconditionally enable thread naming
* Fix race setting thread naming on Win32
* Add API docs for logging APIs
* Fix interleaved error/trace output
* Fix missing error prefixes with warn_report
* Add detailed error reporting for VNC passworrd changes
* Refactoring of error_vprintf & related funcs

----------------------------------------------------------------

Daniel P. Berrangé (25):
  scripts: detect another GPL license boilerplate variant
  io: separate freeing of tasks from marking them as complete
  io: fix cleanup for TLS I/O source data on cancellation
  io: fix cleanup for websock I/O source data on cancellation
  docs: simplify DiamondRapids CPU docs
  qemu-options: remove extraneous [] around arg values
  include: define constant for early constructor priority
  monitor: initialize global data from a constructor
  system: unconditionally enable thread naming
  util: fix race setting thread name on Win32
  util: expose qemu_thread_set_name
  audio: make jackaudio use qemu_thread_set_name
  util: set the name for the 'main' thread on Windows
  util: add API to fetch the current thread name
  util: introduce some API docs for logging APIs
  util: avoid repeated prefix on incremental qemu_log calls
  util/log: add missing error reporting in qemu_log_trylock_with_err
  ui: add proper error reporting for password changes
  ui: remove redundant use of error_printf_unless_qmp()
  monitor: remove redundant error_[v]printf_unless_qmp
  monitor: refactor error_vprintf()
  monitor: move error_vprintf back to error-report.c
  util: fix interleaving of error & trace output
  util: don't skip error prefixes when QMP is active
  util: fix interleaving of error prefixes

Jon Kohler (1):
  util/oslib-posix: increase memprealloc thread count to 32

Markus Armbruster (1):
  scripts/checkpatch: Fix MAINTAINERS update warning with --terse

 audio/jackaudio.c                    |  28 +++++--
 docs/about/deprecated.rst            |   7 ++
 docs/system/cpu-models-x86.rst.inc   |  16 ++--
 include/io/task.h                    |  29 +++++--
 include/monitor/monitor.h            |   3 -
 include/qemu/compiler.h              |   8 ++
 include/qemu/log-for-trace.h         |  17 +++-
 include/qemu/log.h                   |  39 ++++++++++
 include/qemu/thread.h                |   3 +-
 include/ui/console.h                 |   2 +-
 include/ui/qemu-spice-module.h       |   3 +-
 io/channel-tls.c                     |  64 ++++++++++-----
 io/channel-websock.c                 |  46 ++++++++---
 io/task.c                            |   8 +-
 meson.build                          |  21 +++++
 monitor/monitor.c                    |  51 +++---------
 qemu-options.hx                      | 112 +++++++++++++--------------
 rust/util/src/log.rs                 |   6 ++
 scripts/checkpatch.pl                |  11 +--
 stubs/error-printf.c                 |  23 ------
 stubs/meson.build                    |   1 -
 stubs/monitor-core.c                 |  19 ++++-
 system/vl.c                          |  12 +--
 tests/functional/generic/test_vnc.py |   4 +-
 tests/unit/test-io-task.c            |  26 +++++++
 tests/unit/test-util-sockets.c       |   1 +
 ui/spice-core.c                      |  25 ++++--
 ui/spice-module.c                    |   7 +-
 ui/ui-qmp-cmds.c                     |  19 ++---
 ui/vnc-stubs.c                       |   6 +-
 ui/vnc.c                             |  16 ++--
 util/error-report.c                  |  92 +++++++++++++++++-----
 util/log.c                           |  50 +++++++-----
 util/oslib-posix.c                   |   2 +-
 util/qemu-thread-posix.c             |  89 +++++++++++++++------
 util/qemu-thread-win32.c             |  87 ++++++++++++++-------
 36 files changed, 631 insertions(+), 322 deletions(-)
 delete mode 100644 stubs/error-printf.c

-- 
2.53.0


