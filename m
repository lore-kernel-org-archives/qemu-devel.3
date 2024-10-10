Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D5BCFC5E4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 16:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syvvW-0006uI-Bd; Thu, 10 Oct 2024 12:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syvvP-0006sy-Su
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:22:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syvvM-0004N2-Hb
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728577317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=W1VnErksa+PLpB6HrokKStF1bcmhwH2sddh4YxgzDLM=;
 b=S2eMlx1Fr528eSumb70rEocZHjOutwMz2x50lhFfL24QOcRaNCka2ZAUlNZUc7Hwl51h9U
 zjErKdYrkXsabxFzgmV9bphoZB5vxtY3Qzn5+d5oHy/hPjOZK/wb3nbtXbiYKZNJO/srQb
 dMm5Turp3RwoDZAfUX8+n/xQryp7TJY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-jE4POAJxMge-EpRgVxtHbg-1; Thu,
 10 Oct 2024 12:21:53 -0400
X-MC-Unique: jE4POAJxMge-EpRgVxtHbg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96B261955D60; Thu, 10 Oct 2024 16:21:52 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.110])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E93FD30001A5; Thu, 10 Oct 2024 16:20:25 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kunwu <chentao@kylinos.cn>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 00/17] Crypto fixes patches
Date: Thu, 10 Oct 2024 17:20:07 +0100
Message-ID: <20241010162024.988284-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit 838fc0a8769d7cc6edfe50451ba4e3368395f5c1:

  Merge tag 'chr-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2024-10-09 15:06:56 +0100)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/crypto-fixes-pull-request

for you to fetch changes up to 08e702043fbee7b366d1d27c1b6682090c46c0d6:

  tests/unit: Add a assert for test_io_channel_unix_listen_cleanup (2024-10-10 13:41:45 +0100)

----------------------------------------------------------------
Introduce new cryptography hashing APIs

----------------------------------------------------------------

Alejandro Zeise (15):
  crypto: accumulative hashing API
  crypto/hash-glib: Implement new hash API
  crypto/hash-gcrypt: Implement new hash API
  crypto/hash-gnutls: Implement new hash API
  crypto/hash-nettle: Implement new hash API
  util/iov: Introduce iov_send_recv_with_flags()
  crypto/hash-afalg: Implement new hash API
  crypto/hash: Implement and use new hash API
  tests/unit/test-crypto-hash: accumulative hashing
  crypto/hash-glib: Remove old hash API functions
  crypto/hash-gcrypt: Remove old hash API functions
  crypto/hash-gnutls: Remove old hash API functions
  crypto/hash-nettle: Remove old hash API functions
  crypto/hash-afalg: Remove old hash API functions
  crypto/hashpriv: Remove old hash API function

Daniel P. Berrangé (1):
  crypto: drop obsolete back compat logic for old nettle

Kunwu (1):
  tests/unit: Add a assert for test_io_channel_unix_listen_cleanup

 crypto/hash-afalg.c                 | 167 ++++++++++++++++++++--------
 crypto/hash-gcrypt.c                | 112 ++++++++++---------
 crypto/hash-glib.c                  |  92 ++++++++-------
 crypto/hash-gnutls.c                |  97 ++++++++++------
 crypto/hash-nettle.c                |  94 ++++++++--------
 crypto/hash.c                       | 161 ++++++++++++++++++++++-----
 crypto/hashpriv.h                   |  13 ++-
 include/crypto/hash.h               | 119 ++++++++++++++++++++
 include/qemu/iov.h                  |  27 +++++
 tests/unit/test-crypto-hash.c       |  46 ++++++++
 tests/unit/test-io-channel-socket.c |   6 +-
 util/iov.c                          |  25 +++--
 12 files changed, 705 insertions(+), 254 deletions(-)

-- 
2.46.0


