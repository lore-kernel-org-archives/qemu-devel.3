Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56E6CCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFukt-0005DO-UF; Mon, 03 Nov 2025 08:37:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFuks-0005Cy-Ap
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:37:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFukm-0004Gu-Vd
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762177061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hrvTfKQjDLd4bn6uo0LXFcW/sp8uwCfbprm7DM3ZYlk=;
 b=cbOx6xCvHtskoVllUjkcuJ5ErfEfGY1YNtaDfR5QzJrVDMyPBByXKsVVZmkRLXiGIqZiXf
 ydgaGGd5pHelMzkLrXdQO9GBui9+hvpj/mrTZNAqsDtcUOHcN1lkDoyxXRRte8WovvJUMj
 q2s8Egyn/5EQGNlH4o94lmAvD9Tc7R0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-AmZA1prTOuG6inxNYTA3uw-1; Mon,
 03 Nov 2025 08:37:37 -0500
X-MC-Unique: AmZA1prTOuG6inxNYTA3uw-1
X-Mimecast-MFC-AGG-ID: AmZA1prTOuG6inxNYTA3uw_1762177056
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65BA81956089; Mon,  3 Nov 2025 13:37:36 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A0F691800576; Mon,  3 Nov 2025 13:37:30 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 00/32] Next pr patches
Date: Mon,  3 Nov 2025 13:36:54 +0000
Message-ID: <20251103133727.423041-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 53b41bb78950912ba2d9809eef6b45e4df30c647:

  Merge tag 'pull-target-arm-20251031' of https://gitlab.com/pm215/qemu into staging (2025-11-01 10:52:48 +0100)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/next-pr-pull-request

for you to fetch changes up to 2aaca8c6d22b18786ceff51189704113d0639590:

  docs: creation of x509 certs compliant with post-quantum crypto (2025-11-03 10:45:55 +0000)

----------------------------------------------------------------
Merge crypto and other misc fixes / features

 * Increase minimum gnutls to 3.7.5
 * Increase minimum libgcrypt to 1.9.4
 * Increase minimum nettle to 3.7.3
 * Drop obsolete in-tree XTS impl
 * Fix memory leak when loading certificates
 * Remove/reduce duplication when loading certifcates
 * Fix possible crash when certificates are unloaded
   while an active TLS connection is using when in a
   TLS handshake operation
 * Deprecate use of dh-params.pem file
 * Document how to create certificates with Post-Quantum
   Cryptography compliant algorithms.
 * Support loading multiple certificate identities to
   allow support for Post-Quantum crypto in parallel
   with traditional RSA/ECC
 * Add "-run-with exit-with-parent=on" parameter
 * Flush pending errors when seeing ENOBUFS with
   a zero-copy send attempt
 * Fix data buffer parameters in hash & IO channel APIs
   to use 'void *'

----------------------------------------------------------------

Daniel P. Berrangé (26):
  crypto: bump min gnutls to 3.7.5
  crypto: unconditionally enable gnutls XTS support
  crypto: bump min libgcrypt to 1.9.4
  crypto: bump min nettle to 3.7.3
  crypto: drop in-tree XTS cipher mode impl
  crypto: remove redundant parameter checking CA certs
  crypto: add missing free of certs array
  crypto: replace stat() with access() for credential checks
  crypto: remove redundant access() checks before loading certs
  crypto: move check for TLS creds 'dir' property
  crypto: use g_autofree when loading x509 credentials
  crypto: remove needless indirection via parent_obj field
  crypto: move release of DH parameters into TLS creds parent
  crypto: shorten the endpoint == server check in TLS creds
  crypto: remove duplication loading x509 CA cert
  crypto: reduce duplication in handling TLS priority strings
  crypto: introduce method for reloading TLS creds
  crypto: introduce a wrapper around gnutls credentials
  crypto: fix lifecycle handling of gnutls credentials objects
  crypto: make TLS credentials structs private
  crypto: deprecate use of external dh-params.pem file
  crypto: avoid loading the CA certs twice
  crypto: avoid loading the identity certs twice
  crypto: expand logic to cope with multiple certificate identities
  crypto: support upto 5 parallel certificate identities
  docs: creation of x509 certs compliant with post-quantum crypto

Manish Mishra (1):
  io: flush zerocopy socket error queue on sendmsg failure due to ENOBUF

Philippe Mathieu-Daudé (2):
  crypto/hash: Have hashing functions take void * buffer argument
  io/channel: Have read/write functions take void * buffer argument

Richard W.M. Jones (2):
  Implement -run-with exit-with-parent=on
  tests/qtest: Use exit-with-parent=on in qtest invocations

Tejus GK (1):
  io: add a "blocking" field to QIOChannelSocket

 crypto/cipher-gnutls.c.inc            |   8 -
 crypto/cipher-nettle.c.inc            |  44 --
 crypto/cipher.c                       |   2 +-
 crypto/hash.c                         |  16 +-
 crypto/hmac.c                         |   8 +-
 crypto/meson.build                    |  10 +-
 crypto/tlscreds.c                     |  79 ++--
 crypto/tlscredsanon.c                 |  64 +--
 crypto/tlscredsbox.c                  | 101 +++++
 crypto/tlscredsbox.h                  |  50 +++
 crypto/tlscredspriv.h                 |  36 +-
 crypto/tlscredspsk.c                  |  64 ++-
 crypto/tlscredsx509.c                 | 593 +++++++++++++++++---------
 crypto/tlssession.c                   | 139 ++----
 crypto/trace-events                   |   1 +
 crypto/xts.c                          | 250 -----------
 docs/about/deprecated.rst             |   9 +
 docs/system/tls.rst                   | 134 +++++-
 include/crypto/hash.h                 |   8 +-
 include/crypto/hmac.h                 |   4 +-
 include/crypto/tlscreds.h             |  26 ++
 include/crypto/tlscredsx509.h         |   6 +
 include/crypto/tlssession.h           |   4 +-
 include/crypto/xts.h                  |  82 ----
 include/io/channel-socket.h           |   6 +
 include/io/channel.h                  |  14 +-
 include/qemu/exit-with-parent.h       |  57 +++
 io/channel-socket.c                   |  86 +++-
 io/channel-tls.c                      |   4 +-
 io/channel.c                          |  14 +-
 meson.build                           |  69 +--
 qemu-options.hx                       |  13 +-
 system/exit-with-parent.c             | 140 ++++++
 system/meson.build                    |   1 +
 system/vl.c                           |  13 +
 tests/qtest/libqtest.c                |  22 +-
 tests/unit/meson.build                |   3 -
 tests/unit/test-crypto-block.c        |   3 +-
 tests/unit/test-crypto-tlscredsx509.c |   8 +-
 tests/unit/test-crypto-tlssession.c   |   4 +-
 tests/unit/test-crypto-xts.c          | 529 -----------------------
 ui/vnc.c                              |   9 +-
 42 files changed, 1208 insertions(+), 1525 deletions(-)
 create mode 100644 crypto/tlscredsbox.c
 create mode 100644 crypto/tlscredsbox.h
 delete mode 100644 crypto/xts.c
 delete mode 100644 include/crypto/xts.h
 create mode 100644 include/qemu/exit-with-parent.h
 create mode 100644 system/exit-with-parent.c
 delete mode 100644 tests/unit/test-crypto-xts.c

-- 
2.51.1


