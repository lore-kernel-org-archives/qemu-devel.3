Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A31EDE9A6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 16:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so41n-0007Hr-2I; Tue, 10 Sep 2024 12:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1so41W-0006jj-23
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:47:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1so41T-0007YQ-CK
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725986841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wpxpKIDvZg49dFo0iWm6slqt4TKh2Iw2C1+dbra+8Q4=;
 b=SfGuKuJpM+hPsVluhZcLvSjymW3NZZ4QmkEykWeZ7KZXtHp4mYtqLCCk0tAKxTlIF/CPdq
 iNY8wyrwNBus2KNIwYVSKt9ns+wPDwhTeJt6oBv4hphkEnl486hpeUvHgo8lFOIF6jEksb
 dUlFHfnWrIqhaJ/Hex8wE9R61lwAq/Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-770GvNtEM2mUYfb87b_85A-1; Tue,
 10 Sep 2024 12:47:18 -0400
X-MC-Unique: 770GvNtEM2mUYfb87b_85A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D04E1955D53; Tue, 10 Sep 2024 16:47:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B3F01956088; Tue, 10 Sep 2024 16:47:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 73E3B21E6A28; Tue, 10 Sep 2024 18:47:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 00/19] QAPI patches patches for 2024-09-10
Date: Tue, 10 Sep 2024 18:46:55 +0200
Message-ID: <20240910164714.1993531-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 7bbadc60b58b742494555f06cd342311ddab9351:

  Merge tag 'crypto-fixes-pull-request' of https://gitlab.com/berrange/qemu into staging (2024-09-09 15:19:32 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-09-10

for you to fetch changes up to 64f5e9db7706c8f4a7d7b521596caae9a1106337:

  qapi/vfio: Rename VfioMigrationState to Qapi*, and drop prefix (2024-09-10 14:03:45 +0200)

----------------------------------------------------------------
QAPI patches patches for 2024-09-10

----------------------------------------------------------------
Markus Armbruster (19):
      qapi: Smarter camel_to_upper() to reduce need for 'prefix'
      tests/qapi-schema: Drop temporary 'prefix'
      qapi/block-core: Drop temporary 'prefix'
      qapi/common: Drop temporary 'prefix'
      qapi/crypto: Drop temporary 'prefix'
      qapi/ebpf: Drop temporary 'prefix'
      qapi/machine: Drop temporary 'prefix'
      qapi/ui: Drop temporary 'prefix'
      qapi/machine: Rename CpuS390* to S390Cpu*, and drop 'prefix'
      qapi/crypto: Drop unwanted 'prefix'
      qapi/crypto: Rename QCryptoHashAlgorithm to *Algo, and drop prefix
      qapi/crypto: Rename QCryptoCipherAlgorithm to *Algo, and drop prefix
      qapi/crypto: Rename QCryptoIVGenAlgorithm to *Algo, and drop prefix
      qapi/crypto: Rename QCryptoAkCipherAlgorithm to *Algo, and drop prefix
      qapi/crypto: Rename QCryptoRSAPaddingAlgorithm to *Algo, and drop prefix
      qapi/crypto: Rename QCryptoAFAlg to QCryptoAFAlgo
      qapi/cryptodev: Drop unwanted 'prefix'
      qapi/cryptodev: Rename QCryptodevBackendAlgType to *Algo, and drop prefix
      qapi/vfio: Rename VfioMigrationState to Qapi*, and drop prefix

 qapi/block-core.json                     |   4 +-
 qapi/crypto.json                         |  56 ++++++--------
 qapi/cryptodev.json                      |   7 +-
 qapi/machine-common.json                 |   5 +-
 qapi/machine-target.json                 |  11 ++-
 qapi/machine.json                        |   9 +--
 qapi/migration.json                      |   1 +
 qapi/pragma.json                         |   6 +-
 qapi/ui.json                             |   1 +
 qapi/vfio.json                           |   9 +--
 crypto/afalgpriv.h                       |  14 ++--
 crypto/akcipherpriv.h                    |   2 +-
 crypto/blockpriv.h                       |   6 +-
 crypto/cipherpriv.h                      |   2 +-
 crypto/hashpriv.h                        |   2 +-
 crypto/hmacpriv.h                        |   4 +-
 crypto/ivgenpriv.h                       |   6 +-
 include/crypto/afsplit.h                 |   8 +-
 include/crypto/block.h                   |   2 +-
 include/crypto/cipher.h                  |  18 ++---
 include/crypto/hash.h                    |  18 ++---
 include/crypto/hmac.h                    |   6 +-
 include/crypto/ivgen.h                   |  30 ++++----
 include/crypto/pbkdf.h                   |  14 ++--
 include/crypto/x509-utils.h              |   2 +-
 include/hw/qdev-properties-system.h      |   2 +-
 include/hw/s390x/cpu-topology.h          |   2 +-
 include/sysemu/cryptodev.h               |   2 +-
 target/s390x/cpu.h                       |   2 +-
 backends/cryptodev-builtin.c             |  52 ++++++-------
 backends/cryptodev-lkcf.c                |  36 ++++-----
 backends/cryptodev-vhost-user.c          |   6 +-
 backends/cryptodev.c                     |  12 +--
 block.c                                  |   6 +-
 block/crypto.c                           |  10 +--
 block/parallels-ext.c                    |   2 +-
 block/qcow.c                             |   2 +-
 block/qcow2.c                            |  10 +--
 block/quorum.c                           |   4 +-
 block/rbd.c                              |   4 +-
 crypto/afalg.c                           |   8 +-
 crypto/afsplit.c                         |   6 +-
 crypto/akcipher.c                        |   2 +-
 crypto/block-luks.c                      | 128 +++++++++++++++----------------
 crypto/block-qcow.c                      |   6 +-
 crypto/block.c                           |   8 +-
 crypto/cipher-afalg.c                    |  36 ++++-----
 crypto/cipher.c                          |  72 ++++++++---------
 crypto/hash-afalg.c                      |  40 +++++-----
 crypto/hash-gcrypt.c                     |  20 ++---
 crypto/hash-glib.c                       |  20 ++---
 crypto/hash-gnutls.c                     |  20 ++---
 crypto/hash-nettle.c                     |  18 ++---
 crypto/hash.c                            |  30 ++++----
 crypto/hmac-gcrypt.c                     |  22 +++---
 crypto/hmac-glib.c                       |  22 +++---
 crypto/hmac-gnutls.c                     |  22 +++---
 crypto/hmac-nettle.c                     |  22 +++---
 crypto/hmac.c                            |   2 +-
 crypto/ivgen.c                           |  18 ++---
 crypto/pbkdf-gcrypt.c                    |  36 ++++-----
 crypto/pbkdf-gnutls.c                    |  36 ++++-----
 crypto/pbkdf-nettle.c                    |  32 ++++----
 crypto/pbkdf-stub.c                      |   4 +-
 crypto/pbkdf.c                           |   6 +-
 crypto/secret_common.c                   |   2 +-
 crypto/x509-utils.c                      |  18 ++---
 ebpf/ebpf_rss.c                          |   2 +-
 hw/core/numa.c                           |   4 +-
 hw/core/qdev-properties-system.c         |   6 +-
 hw/misc/aspeed_hace.c                    |  16 ++--
 hw/pci-bridge/cxl_upstream.c             |   4 +-
 hw/s390x/cpu-topology.c                  |   6 +-
 hw/vfio/migration.c                      |   2 +-
 hw/vfio/pci.c                            |  10 +--
 hw/virtio/virtio-crypto.c                |  24 +++---
 io/channel-websock.c                     |   2 +-
 system/vl.c                              |   2 +-
 target/i386/sev.c                        |   6 +-
 tests/bench/benchmark-crypto-akcipher.c  |  28 +++----
 tests/bench/benchmark-crypto-cipher.c    |  22 +++---
 tests/bench/benchmark-crypto-hash.c      |  10 +--
 tests/bench/benchmark-crypto-hmac.c      |   6 +-
 tests/unit/test-crypto-afsplit.c         |  10 +--
 tests/unit/test-crypto-akcipher.c        |  54 ++++++-------
 tests/unit/test-crypto-block.c           |  58 +++++++-------
 tests/unit/test-crypto-cipher.c          |  66 ++++++++--------
 tests/unit/test-crypto-hash.c            |  42 +++++-----
 tests/unit/test-crypto-hmac.c            |  16 ++--
 tests/unit/test-crypto-ivgen.c           |  38 ++++-----
 tests/unit/test-crypto-pbkdf.c           |  46 +++++------
 tests/unit/test-qobject-input-visitor.c  |   4 +-
 tests/unit/test-qobject-output-visitor.c |   4 +-
 ui/dbus.c                                |   8 +-
 ui/egl-context.c                         |   2 +-
 ui/egl-headless.c                        |   2 +-
 ui/egl-helpers.c                         |  12 +--
 ui/gtk.c                                 |   4 +-
 ui/sdl2-gl.c                             |   8 +-
 ui/sdl2.c                                |   2 +-
 ui/spice-core.c                          |   2 +-
 ui/vnc.c                                 |   6 +-
 util/hbitmap.c                           |   2 +-
 crypto/akcipher-gcrypt.c.inc             |  44 +++++------
 crypto/akcipher-nettle.c.inc             |  56 +++++++-------
 crypto/cipher-builtin.c.inc              |  18 ++---
 crypto/cipher-gcrypt.c.inc               |  56 +++++++-------
 crypto/cipher-gnutls.c.inc               |  38 ++++-----
 crypto/cipher-nettle.c.inc               |  58 +++++++-------
 crypto/rsakey-builtin.c.inc              |   4 +-
 crypto/rsakey-nettle.c.inc               |   4 +-
 scripts/qapi/common.py                   |  42 +++++-----
 scripts/qapi/schema.py                   |   2 +-
 tests/qapi-schema/alternate-array.out    |   1 -
 tests/qapi-schema/comments.out           |   1 -
 tests/qapi-schema/doc-good.out           |   1 -
 tests/qapi-schema/empty.out              |   1 -
 tests/qapi-schema/include-repetition.out |   1 -
 tests/qapi-schema/include-simple.out     |   1 -
 tests/qapi-schema/indented-expr.out      |   1 -
 tests/qapi-schema/qapi-schema-test.out   |   1 -
 121 files changed, 950 insertions(+), 967 deletions(-)

-- 
2.46.0


