Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3ABC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 14:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYRVI-0002UT-2G; Fri, 09 Feb 2024 09:05:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRVG-0002TS-Cx
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:05:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRVC-00049i-Bt
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:05:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707487513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KPslZ7kHJJrYc+T/H12eQP73hO9jxeZa4lhQTRrYHDc=;
 b=iLHrjpty6bBD6xjly0GZluaO1kpYIJQzRX3J4yJeeFN/myBZp9QSKZgOeWXejcMMH42b3k
 xfSTQaN/KYn4ryOcqd56aVgDVrNh0kuPCWDV+ciGnuW6IGbO/lYQiA23aOzmsf8qSnMyL7
 QmjgFVg7SMBsJ4xHeIYGiNJDF9DeyfA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-EHSht4HpM-ewIDMUymmi5g-1; Fri, 09 Feb 2024 09:05:10 -0500
X-MC-Unique: EHSht4HpM-ewIDMUymmi5g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68024185A78F;
 Fri,  9 Feb 2024 14:05:09 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A6E711216;
 Fri,  9 Feb 2024 14:05:06 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 00/17] Misc fixes patches
Date: Fri,  9 Feb 2024 14:04:48 +0000
Message-ID: <20240209140505.2536635-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 9e34f127f419b3941b36dfdfac79640dc81e97e2:

  Merge tag 'pull-request-2024-02-06' of https://gitlab.com/thuth/qemu into staging (2024-02-08 11:59:28 +0000)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request

for you to fetch changes up to d87b258b75498d3e8563ec8ebaaf67efc27be945:

  tests: Add case for LUKS volume with detached header (2024-02-09 12:50:38 +0000)

----------------------------------------------------------------
 - LUKS support for detached headers
 - Update x86 CPU model docs and script
 - Add missing close of chardev QIOChannel
 - More trace events o nTKS handshake
 - Drop unsafe VNC constants
 - Increase NOFILE limit during startup

----------------------------------------------------------------

Daniel P. Berrangé (8):
  meson: sort C warning flags alphabetically
  ui: drop VNC feature _MASK constants
  softmmu: remove obsolete comment about libvirt timeouts
  scripts: drop comment about autogenerated CPU API file
  docs: fix highlighting of CPU ABI header rows
  docs: re-generate x86_64 ABI compatibility CSV
  chardev: close QIOChannel before unref'ing
  io: add trace event when cancelling TLS handshake

Fiona Ebner (1):
  qemu_init: increase NOFILE soft limit on POSIX

Hyman Huang (8):
  crypto: Introduce SM4 symmetric cipher algorithm
  crypto: Support LUKS volume with detached header
  qapi: Make parameter 'file' optional for BlockdevCreateOptionsLUKS
  crypto: Modify the qcrypto_block_create to support creation flags
  block: Support detached LUKS header creation using blockdev-create
  block: Support detached LUKS header creation using qemu-img
  crypto: Introduce 'detached-header' field in QCryptoBlockInfoLUKS
  tests: Add case for LUKS volume with detached header

 MAINTAINERS                                   |   5 +
 block.c                                       |   5 +-
 block/crypto.c                                | 144 +++++++-
 block/crypto.h                                |   8 +
 block/qcow.c                                  |   2 +-
 block/qcow2.c                                 |   2 +-
 chardev/char-socket.c                         |   4 +
 crypto/block-luks.c                           |  52 ++-
 crypto/block.c                                |   4 +-
 crypto/blockpriv.h                            |   2 +
 crypto/cipher-gcrypt.c.inc                    |   8 +
 crypto/cipher-nettle.c.inc                    |  49 +++
 crypto/cipher.c                               |   6 +
 docs/system/cpu-models-x86-abi.csv            |  20 +-
 docs/system/cpu-models-x86.rst.inc            |   2 +-
 include/crypto/block.h                        |  16 +
 include/sysemu/os-posix.h                     |   1 +
 include/sysemu/os-win32.h                     |   5 +
 io/channel-tls.c                              |   1 +
 io/trace-events                               |   1 +
 meson.build                                   |  66 ++--
 os-posix.c                                    |  22 ++
 qapi/block-core.json                          |  13 +-
 qapi/crypto.json                              |  13 +-
 scripts/cpu-x86-uarch-abi.py                  |   1 -
 system/vl.c                                   |   3 +-
 tests/qemu-iotests/210.out                    |   4 +
 tests/qemu-iotests/tests/luks-detached-header | 316 ++++++++++++++++++
 .../tests/luks-detached-header.out            |   5 +
 tests/unit/test-crypto-block.c                |   2 +
 tests/unit/test-crypto-cipher.c               |  13 +
 ui/vnc.c                                      |  34 +-
 ui/vnc.h                                      |  22 +-
 33 files changed, 760 insertions(+), 91 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/luks-detached-header
 create mode 100644 tests/qemu-iotests/tests/luks-detached-header.out

-- 
2.43.0


