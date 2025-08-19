Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12276CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 20:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoSvW-0003wV-Mz; Tue, 19 Aug 2025 16:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoSvV-0003vZ-D5
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 16:27:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoSvS-0006PT-0z
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 16:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755635241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NilJ6MEPI25XTGInaoAYGovN3ut+wa4IIXZII1mTO+Q=;
 b=KOXMq7RP0ma8c7LDM7SjhHK5qMcGYtfG2EUylnbv7Yci4t2baIZgknBMdiqCdMwq3bRcck
 u8cv2SbZT9r98Ee1nl7CnLcrDiVgMOeNiBTXbScQrGup0nvEK+NPbeEtENPUKrx4mDImx8
 wTvm+XTzQprP6QAljtt8G5cr6nR5zfY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-UBODzNi7Mh-kef6v_us3SA-1; Tue,
 19 Aug 2025 16:27:16 -0400
X-MC-Unique: UBODzNi7Mh-kef6v_us3SA-1
X-Mimecast-MFC-AGG-ID: UBODzNi7Mh-kef6v_us3SA_1755635234
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E189B180028D; Tue, 19 Aug 2025 20:27:13 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.237])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C597619560B2; Tue, 19 Aug 2025 20:27:09 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, devel@lists.libvirt.org,
 Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 00/12] util: sync error_report & qemu_log output more closely
Date: Tue, 19 Aug 2025 21:26:56 +0100
Message-ID: <20250819202708.1185594-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In thinking about adding thread info to error_report, I came
to realize we should likely make qemu_log behave consistently
with error_report & friends more generally. We already honour
'-msg timestamp=on' in both (with duplicated code), and qemu_log
doesn't honour the '-msg guest-name=on' parameter, nor will it
include the binary name.

This series shouldn't be considered mutually exclusive with
Manos' backtrace suggestion above - it is complementary &
each proposal can be evaluated independently. 


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
  2025-08-19T20:12:50.211842Z [fish food] qemu-system-x86_64(1168876:main): qcrypto_tls_creds_get_path TLS creds path creds=0x5582183d8760 filename=ca-cert.pem path=<none>
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

I'm not too happy with the constructor priority
logic, but I don't see a better option, as I don't
think it is practical to order .o files passed to
the linker in a way that nicely guarantees the order
of constructor execution.

Daniel P. Berrangé (12):
  include: define constant for early constructor priority
  monitor: initialize global data from a constructor
  system: unconditionally enable thread naming
  util: set the name for the 'main' thread
  util: add API to fetch the current thread id
  util: add API to fetch the current thread name
  util: introduce common helper for error-report & log code
  util: convert error-report & log to message API for timestamp
  util: add support for formatting a workload name in messages
  util: add support for formatting a program name in messages
  util: add support for formatting thread info in messages
  util: add brackets around guest name in message context

 MAINTAINERS                          |  2 +
 docs/about/deprecated.rst            |  7 +++
 include/qemu/compiler.h              |  8 +++
 include/qemu/error-report.h          |  4 --
 include/qemu/message.h               | 52 +++++++++++++++++
 include/qemu/thread.h                |  3 +-
 meson.build                          | 21 +++++++
 monitor/monitor.c                    | 14 +++--
 storage-daemon/qemu-storage-daemon.c |  6 ++
 system/vl.c                          | 30 +++++++---
 tests/qemu-iotests/041               |  2 +-
 tests/qemu-iotests/common.filter     |  2 +-
 tests/unit/test-error-report.c       |  6 +-
 util/error-report.c                  | 29 +---------
 util/log.c                           | 20 +++----
 util/meson.build                     |  1 +
 util/message.c                       | 69 ++++++++++++++++++++++
 util/qemu-thread-posix.c             | 60 ++++++++++++++-----
 util/qemu-thread-win32.c             | 86 ++++++++++++++++++++--------
 19 files changed, 321 insertions(+), 101 deletions(-)
 create mode 100644 include/qemu/message.h
 create mode 100644 util/message.c

-- 
2.50.1


