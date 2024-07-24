Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF464C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 09:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWYax-00013L-3A; Wed, 24 Jul 2024 05:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWYau-00012c-97
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:47:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWYaq-0003GL-9q
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721814450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2zPhToKEmBtfoQacfe3UpvlDddnRA4YNArW5j1A1IBY=;
 b=ZloHd3W3REkTYPVYaYTeZO9oZaGr1wAJG9o2+qpPnwq9OKLtMoP6OmcnrNwBE8p0lSRdtg
 Gehqwtwbd5TPYJLNW3b8uPfFnXDIdZE5j9TACyyL0+z+75BYErLSSG2bSjnuezSdpWlzKw
 Gy5OVuEeLkafyFWEUPfj4D6cv1FwiAs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-yiUsg9sLPjuPeDE8u-OKfA-1; Wed,
 24 Jul 2024 05:47:24 -0400
X-MC-Unique: yiUsg9sLPjuPeDE8u-OKfA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B043619560B3; Wed, 24 Jul 2024 09:47:22 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.141])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 477D919560AA; Wed, 24 Jul 2024 09:47:12 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [PULL 00/11] Crypto patches
Date: Wed, 24 Jul 2024 10:46:55 +0100
Message-ID: <20240724094706.30396-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

The following changes since commit 6410f877f5ed535acd01bbfaa4baec379e44d0ef:

  Merge tag 'hw-misc-20240723' of https://github.com/philmd/qemu into staging (2024-07-24 15:39:43 +1000)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request

for you to fetch changes up to 97f7bf113eb50fcdaf0c73aa2ee01e5355abc073:

  crypto: propagate errors from TLS session I/O callbacks (2024-07-24 10:39:10 +0100)

----------------------------------------------------------------

* Drop unused 'detached-header' QAPI field from LUKS create options
* Improve tracing of TLS sockets and TLS chardevs
* Improve error messages from TLS I/O failures
* Add docs about use of LUKS detached header options
* Allow building without libtasn1, but with GNUTLS
* Fix detection of libgcrypt when libgcrypt-config is absent

----------------------------------------------------------------

Daniel P. Berrangé (6):
  qapi: drop unused QCryptoBlockCreateOptionsLUKS.detached-header
  meson: build chardev trace files when have_block
  chardev: add tracing of socket error conditions
  crypto: drop gnutls debug logging support
  crypto: push error reporting into TLS session I/O APIs
  crypto: propagate errors from TLS session I/O callbacks

Hyman Huang (1):
  docs/devel: Add introduction to LUKS volume with detached header

Philippe Mathieu-Daudé (3):
  crypto: Remove 'crypto-tls-x509-helpers.h' from
    crypto-tls-psk-helpers.c
  crypto: Restrict pkix_asn1_tab[] to crypto-tls-x509-helpers.c
  crypto: Allow building with GnuTLS but without Libtasn1

Yao Zi (1):
  meson.build: fix libgcrypt detection on system without
    libgcrypt-config

 MAINTAINERS                                   |   3 +-
 chardev/char-socket.c                         |  37 ++--
 chardev/trace-events                          |  10 +
 crypto/init.c                                 |  15 +-
 crypto/tlssession.c                           | 124 ++++++++----
 docs/devel/crypto.rst                         |  10 +
 docs/devel/index-internals.rst                |   1 +
 docs/devel/luks-detached-header.rst           | 182 ++++++++++++++++++
 include/crypto/tlssession.h                   |  33 +++-
 io/channel-tls.c                              |  66 +++----
 meson.build                                   |   4 +-
 qapi/crypto.json                              |   5 +-
 tests/qtest/meson.build                       |   3 +-
 tests/unit/crypto-tls-psk-helpers.c           |   1 -
 tests/unit/crypto-tls-x509-helpers.c          |   6 +-
 tests/unit/crypto-tls-x509-helpers.h          |   3 -
 tests/unit/meson.build                        |   6 +-
 .../{pkix_asn1_tab.c => pkix_asn1_tab.c.inc}  |   5 +-
 tests/unit/test-crypto-tlssession.c           |  30 ++-
 19 files changed, 418 insertions(+), 126 deletions(-)
 create mode 100644 docs/devel/crypto.rst
 create mode 100644 docs/devel/luks-detached-header.rst
 rename tests/unit/{pkix_asn1_tab.c => pkix_asn1_tab.c.inc} (99%)

-- 
2.45.2


