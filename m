Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760F8C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Wyb-0004W9-Fv; Mon, 07 Sep 2026 06:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x3WyY-0004Vm-Lu
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x3WyU-0008WD-EG
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788778397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/qIMG2YygDO+bEvssxKQBG+LKR1ijNpdOfCqT6Qk6dM=;
 b=F2BwpcDVbWXDMbQJbw6QUdAtiUt7XScRpQV6RRDuyc5uK+IUq3qEuNCQ7RSXCdailE0N6N
 MkiekNEgBYHHM4SNzaC3ZWD9yuaUAHaNdrshfbt5vSherKFKtVgYb1l3UzQ9et1CcjaUIb
 r93XeZsZPT00iNTk/MtLUa/x0r+N/v8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-UNUZ4i2xPbeFnofw79G6aA-1; Mon,
 07 Sep 2026 06:53:14 -0400
X-MC-Unique: UNUZ4i2xPbeFnofw79G6aA-1
X-Mimecast-MFC-AGG-ID: UNUZ4i2xPbeFnofw79G6aA_1788778393
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F81C1828B02; Mon,  7 Sep 2026 10:53:13 +0000 (UTC)
Received: from berrange.fritz.box (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 860821956056; Mon,  7 Sep 2026 10:53:11 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v3 00/12] Misc fixes patches
Date: Mon,  7 Sep 2026 11:52:58 +0100
Message-ID: <20260907105310.497730-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit ff1d2d19d7e24893e2012d879f8e73077e17b9bd:

  Merge tag 'pull-11.1-check-tcg-meson-040926-2' of https://gitlab.com/stsquad/qemu into staging (2026-09-04 16:52:58 +0100)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request

for you to fetch changes up to 0766e83d2f94285338e6c642b4b003ffafb142f4:

  docs/system/security: exclude uninitialized stack variables as bugs (2026-09-07 11:31:03 +0100)

----------------------------------------------------------------
Merge crypto, I/O and misc fixes

 * Deprecated the AF_ALG crypto backend
 * Improve checkpatch output in CI jobs
 * Document security policy for uninitialized stack variables
 * Fix multiple denial of service flaws in websockets
 * Fix error handling in some x509 APIs

----------------------------------------------------------------

Daniel P. Berrangé (3):
  crypto: deprecate the AF_ALG crypto backend
  gitlab: use --emacs --quiet for checkpatch.pl instead of --terse
  docs/system/security: exclude uninitialized stack variables as bugs

Denis V. Lunev (6):
  io/channel-socket: do not treat a zero length write as an error
  io/channel-websock: send an HTTP 400 when the greeting has no space
  io/channel-websock: handle a blocked write during the handshake
  tests/unit: add websock handshake test
  io/channel-websock: do not lose QIO_CHANNEL_ERR_BLOCK while reading
  tests/unit: cover blocked IO during the websock handshake

Evgeny Kolmakov (1):
  crypto: Use g_autofree

Marc-André Lureau (2):
  crypto/x509-utils: don't double set errp
  crypto/x509-utils: propagate the error

 .gitlab-ci.d/check-patch.py          |   6 +-
 crypto/block.c                       |  17 +-
 crypto/hmac-gcrypt.c                 |  12 +-
 crypto/hmac-glib.c                   |  10 +-
 crypto/ivgen-essiv.c                 |  15 +-
 crypto/ivgen.c                       |   6 +-
 crypto/secret_keyring.c              |   5 +-
 crypto/x509-utils.c                  |   4 +-
 docs/about/deprecated.rst            |  21 +++
 docs/system/security.rst             |  10 ++
 io/channel-socket.c                  |   2 +-
 io/channel-websock.c                 |  10 +-
 meson.build                          |   6 +
 tests/unit/meson.build               |   1 +
 tests/unit/test-io-channel-websock.c | 249 +++++++++++++++++++++++++++
 15 files changed, 326 insertions(+), 48 deletions(-)
 create mode 100644 tests/unit/test-io-channel-websock.c

-- 
2.55.0


