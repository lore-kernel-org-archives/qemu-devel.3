Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4584C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WRP-0003ta-6x; Fri, 04 Sep 2026 12:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2WRO-0003sW-5u
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:06:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2WRK-0006d8-Q8
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788538012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hSevA/UIm9WyhjMWy0AjpuScF1HVUi47udikWS6eVSg=;
 b=WdWofVE2sgkvLP2fikUF7ATaNXHC61XGWxg/VecbOqUsuITlwxc8NdvIMGdLVVhi6Vv+Mw
 Emw6paYm+WdTke3RmBdUqxl46+lpGAT06T5GxIc/IIOG+k6NOg5dGvq2tPYhlMqtCsikM2
 mC+h8PaJJ/knZi6rjx1bD5Ud9xtsfSI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-iogBuBAfPCapzK1FYxo-Zw-1; Fri,
 04 Sep 2026 12:06:48 -0400
X-MC-Unique: iogBuBAfPCapzK1FYxo-Zw-1
X-Mimecast-MFC-AGG-ID: iogBuBAfPCapzK1FYxo-Zw_1788538007
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 502A9190A0BA; Fri,  4 Sep 2026 16:06:47 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 58DB93001D37; Fri,  4 Sep 2026 16:06:45 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 00/13] Misc fixes patches
Date: Fri,  4 Sep 2026 17:06:30 +0100
Message-ID: <20260904160643.353833-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The following changes since commit 99e54ab5e7a6efc945af6d5661842155d1f3fc7a:

  Merge tag 'hw-misc-20260903' of https://github.com/philmd/qemu into staging (2026-09-03 16:43:24 +0100)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request

for you to fetch changes up to 39dfe7cf8e87d6de975bae6c10c3712f4df56ee6:

  docs/system/security: exclude uninitialized stack variables as bugs (2026-09-04 14:29:16 +0100)

----------------------------------------------------------------
Merge crypto, I/O and misc fixes

 * Deprecated the AF_ALG crypto backend
 * Improve checkpatch output in CI jobs
 * Fix --disable-containers arg handling in configure
 * Document security policy for uninitialized stack variables
 * Fix multiple denial of service flaws in websockets
 * Fix error handling in some x509 APIs

----------------------------------------------------------------

Daniel P. Berrangé (4):
  crypto: deprecate the AF_ALG crypto backend
  gitlab: use --emacs --quiet for checkpatch.pl instead of --terse
  configure: correctly honour --disable-containers
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
 configure                            |   1 +
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
 16 files changed, 327 insertions(+), 48 deletions(-)
 create mode 100644 tests/unit/test-io-channel-websock.c

-- 
2.55.0


