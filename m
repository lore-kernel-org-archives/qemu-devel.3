Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7148CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 13:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCHi2-0005Rw-IY; Fri, 24 Oct 2025 09:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCHhz-0005Qo-Mi
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:19:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCHht-0004jt-H7
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761311986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y6PPrjuCttFk0m0tTAQPPKCE9IcAXLVEOdtZuoz+HgM=;
 b=NIK5/KCDlzX5CcfGQacSda5y6KvJc5ZMEn2+A2EA8WX05V/p+80X2C+cibSo26mY0DYxmo
 vNHKsFTTlI//jBvLkvpgz9MKfXptAawIMZ2u608PXmBuFavCfNebfVofY0UrerXyrzFSq5
 /kD9i3+x2mX2+SVMYQzrTdxa05yQdf0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-siFLa-WHNviwFFIFGVSakw-1; Fri,
 24 Oct 2025 09:19:41 -0400
X-MC-Unique: siFLa-WHNviwFFIFGVSakw-1
X-Mimecast-MFC-AGG-ID: siFLa-WHNviwFFIFGVSakw_1761311980
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88A4019560B8; Fri, 24 Oct 2025 13:19:40 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2867219540EB; Fri, 24 Oct 2025 13:19:38 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 00/13] Next crypto & I/O patches
Date: Fri, 24 Oct 2025 14:19:24 +0100
Message-ID: <20251024131937.56673-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit e8779f3d1509cd07620c6166a9a280376e01ff2f:

  Merge tag 'pull-riscv-to-apply-20251024' of https://github.com/alistair23/qemu into staging (2025-10-24 10:53:02 +0200)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/next-pr-pull-request

for you to fetch changes up to 608be310a9c0a8501480a8ba76de3df8feaaf0d8:

  crypto: switch to newer gnutls API for distinguished name (2025-10-24 13:06:05 +0100)

----------------------------------------------------------------
Merge misc, crypto and I/O subsystems changes

 * Fix use after free in websocket handshake (CVE-2025-11234)
 * Improved stack traces fatal errors/aborts raised for
   user creatable objects
 * Stop requiring 'key encipherment' usage in x509 certs
 * Only sanity check CA certs needed in the chain of trust
 * Allow intermediate CA certs to be present in client/server
   cert file
 * Fix regression propagating errors in premature shutdown
   of TLS connections

----------------------------------------------------------------

Daniel P. Berrangé (11):
  crypto: propagate Error object on premature termination
  qom: use ERRP_GUARD in user_creatable_complete
  tests: use macros for registering char tests for sockets
  io: release active GSource in TLS channel finalizer
  io: move websock resource release to close method
  io: fix use after free in websocket handshake code
  crypto: remove extraneous pointer usage in gnutls certs
  crypto: validate an error is reported in test expected fails
  crypto: fix error reporting in cert chain checks
  crypto: stop requiring "key encipherment" usage in x509 certs
  crypto: switch to newer gnutls API for distinguished name

Henry Kleynhans (1):
  crypto: only verify CA certs in chain of trust

matoro (1):
  crypto: allow client/server cert chains

 crypto/tlscredsx509.c                 | 223 +++++++++++++++-----------
 crypto/tlssession.c                   |  20 +--
 docs/system/tls.rst                   |  13 +-
 include/io/channel-websock.h          |   3 +-
 io/channel-tls.c                      |  23 ++-
 io/channel-websock.c                  |  33 +++-
 qom/object_interfaces.c               |   7 +-
 tests/unit/crypto-tls-x509-helpers.h  |   6 +-
 tests/unit/test-char.c                |   8 +-
 tests/unit/test-crypto-tlscredsx509.c | 155 +++++++++++++++---
 tests/unit/test-crypto-tlssession.c   |  14 +-
 tests/unit/test-io-channel-tls.c      |   4 +-
 12 files changed, 336 insertions(+), 173 deletions(-)

-- 
2.50.1


