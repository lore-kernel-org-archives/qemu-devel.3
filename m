Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0355C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 10:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI3BF-0002yv-Im; Thu, 22 May 2025 06:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uI3BC-0002yK-K3
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:29:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uI3B7-0006M7-RP
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747909771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ektz7OD0hYzBphenw5zpimORufWjXvtSTh7ImPDDEts=;
 b=ME+TICn39JqsUr6thLfbM+bxZ1gVV8hsQxJP97AINNKG0M5FNNUwQNpTlPMAmVIr+W75Ck
 cSdqrbtbwXHoAnpmHox+rMtWqa8prTazkEf1HVTnZaPE5AqZV2UNA+HXZI2ye9qNtgR7cY
 RsaDugCf7uSFoC7En5XvZ3VRrbGRDB4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-UOuSp77WMwqPuVdLN0ts-Q-1; Thu,
 22 May 2025 06:29:29 -0400
X-MC-Unique: UOuSp77WMwqPuVdLN0ts-Q-1
X-Mimecast-MFC-AGG-ID: UOuSp77WMwqPuVdLN0ts-Q_1747909768
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 967CB1801A1E; Thu, 22 May 2025 10:29:28 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.179])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B4FE91958014; Thu, 22 May 2025 10:29:24 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 00/23] Misc VNC, I/O, Crypto & checkpatch fixes
Date: Thu, 22 May 2025 11:29:00 +0100
Message-ID: <20250522102923.309452-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit f0737158b483e7ec2b2512145aeab888b85cc1f7:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-05-20 10:26:30 -0400)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/misc-next-pull-request

for you to fetch changes up to 81941aa896b718c194f08cebb4303561b64c60b4:

  scripts/checkpatch.pl: mandate SPDX tag for Rust src files (2025-05-22 11:24:41 +0100)

----------------------------------------------------------------

* Fix VNC tight encoding with 8/16-bpp formats with
  mixed endian server/client
* Fix VNC non-tight encoding with mixed endian server/client
* Drop built-in AES impl from non-TCG usage, requiring
  nettle/gcrypt/gnutls
* Fix validation of SPDX-License-Identifier in new files
* Mandate SPDX-License-Identifier in Rust source
* Reject license boilerplate in new files
* Add full control over TCP keep alive setting for sockets

----------------------------------------------------------------

Daniel P. Berrangé (17):
  ui/vnc.c: replace big endian flag with byte order value
  ui/vnc: take account of client byte order in pixman format
  ui/vnc: fix tight palette pixel encoding for 8/16-bpp formats
  tests: skip encrypted secret tests if AES is not available
  tests: skip legacy qcow2 encryption test if AES is not available
  tests: fix skipping cipher tests when AES is not available
  crypto: fully drop built-in cipher provider
  Revert "scripts: mandate that new files have SPDX-License-Identifier"
  scripts/checkpatch.pl: fix various indentation mistakes
  scripts/checkpatch: introduce tracking of file start/end
  scripts/checkpatch: use new hook for ACPI test data check
  scripts/checkpatch: use new hook for file permissions check
  scripts/checkpatch: expand pattern for matching makefiles
  scripts/checkpatch: use new hook for MAINTAINERS update check
  scripts/checkpatch: reimplement mandate for SPDX-License-Identifier
  scripts/checkpatch: reject license boilerplate on new files
  scripts/checkpatch.pl: mandate SPDX tag for Rust src files

Juraj Marcin (6):
  io: Fix partial struct copy in qio_dns_resolver_lookup_sync_inet()
  util/qemu-sockets: Refactor setting client sockopts into a separate
    function
  util/qemu-sockets: Refactor success and failure paths in
    inet_listen_saddr()
  util/qemu-sockets: Add support for keep-alive flag to passive sockets
  util/qemu-sockets: Refactor inet_parse() to use QemuOpts
  util/qemu-sockets: Introduce inet socket options controlling TCP
    keep-alive

 crypto/cipher-builtin.c.inc     | 303 ------------------------
 crypto/cipher-stub.c.inc        |  30 +++
 crypto/cipher.c                 |   2 +-
 include/ui/qemu-pixman.h        |   4 +-
 io/dns-resolver.c               |  21 +-
 meson.build                     |  30 +++
 qapi/sockets.json               |  23 +-
 scripts/checkpatch.pl           | 392 +++++++++++++++++++++-----------
 tests/unit/test-crypto-block.c  |   7 +
 tests/unit/test-crypto-cipher.c |  13 +-
 tests/unit/test-crypto-secret.c |  28 ++-
 tests/unit/test-util-sockets.c  | 235 +++++++++++++++++++
 ui/qemu-pixman.c                |  15 +-
 ui/vnc-enc-tight.c              |  20 +-
 ui/vnc-enc-zrle.c               |   2 +-
 ui/vnc-jobs.c                   |   2 +-
 ui/vnc.c                        |   9 +-
 ui/vnc.h                        |   2 +-
 util/qemu-sockets.c             | 327 ++++++++++++++++----------
 19 files changed, 843 insertions(+), 622 deletions(-)
 delete mode 100644 crypto/cipher-builtin.c.inc
 create mode 100644 crypto/cipher-stub.c.inc

-- 
2.49.0


