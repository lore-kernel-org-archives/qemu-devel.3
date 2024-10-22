Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAF6D2C56C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 15:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3GkJ-0007Uh-9b; Tue, 22 Oct 2024 11:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3GkH-0007OZ-Gp
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:24:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3GkF-0004xZ-IG
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729610666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=miGZxaqpYfvW8TcLkvAr+PfNZXKXq672MhLU1UAajrc=;
 b=FwMOR2pLNekB5/sjdewaeoh0909c02TAn4dDVGSHDIDVdyQq1IMi7i8U5rrnyRy7R19B/f
 mGBAyrHAbL7b03qM+1Q055iwiVtBuG+LJC1H+kWthQlmAWYojFlbjb8CgAy+WQxVx94aIg
 YW9fyramsF9V32fgI63VdqJZWgBJPRQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-cQ9NZC_pMCy31q7YamD_1g-1; Tue,
 22 Oct 2024 11:24:21 -0400
X-MC-Unique: cQ9NZC_pMCy31q7YamD_1g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DC4C1944B3E; Tue, 22 Oct 2024 15:24:19 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.59])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BDD601955DC6; Tue, 22 Oct 2024 15:24:16 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/14] Misc fixes patches
Date: Tue, 22 Oct 2024 16:24:01 +0100
Message-ID: <20241022152415.1632556-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
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

The following changes since commit cc5adbbd50d81555b8eb73602ec16fde40b55be4:

  Merge tag 'pull-tpm-2024-10-18-1' of https://github.com/stefanberger/qemu-tpm into staging (2024-10-18 15:45:02 +0100)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request

for you to fetch changes up to c64df333f92798823c4897ae6d4bd7f49d060225:

  gitlab: enable afalg tests in fedora system test (2024-10-22 13:02:33 +0100)

----------------------------------------------------------------
Misc sockets, crypto and VNC fixes

* Fix rare EADDRINUSE failures on OpenBSD platforms seen
  with migration
* Fix & test overwriting of hash output buffer
* Close connection instead of returning empty SASL mechlist to
  VNC clients
* Fix handling of SASL SSF on VNC server UNIX sockets
* Fix handling of NULL SASL server data in VNC server
* Validate trailing NUL padding byte from SASL client
* Fix & test AF_ALG crypto backend build
* Remove unused code in sockets and crypto subsystems

----------------------------------------------------------------

Daniel P. Berrangé (11):
  util: don't set SO_REUSEADDR on client sockets
  crypto/hash: avoid overwriting user supplied result pointer
  tests: correctly validate result buffer in hash/hmac tests
  include/crypto: clarify @result/@result_len for hash/hmac APIs
  ui/vnc: don't return an empty SASL mechlist to the client
  ui/vnc: don't raise error formatting socket address for non-inet
  ui/vnc: fix skipping SASL SSF on UNIX sockets
  ui/vnc: don't check for SSF after SASL authentication on UNIX sockets
  ui: fix handling of NULL SASL server data
  ui: validate NUL byte padding in SASL client data more strictly
  gitlab: enable afalg tests in fedora system test

Dr. David Alan Gilbert (2):
  crypto: Remove unused DER string functions
  sockets: Remove deadcode

Markus Armbruster (1):
  crypto/hash-afalg: Fix broken build

 .gitlab-ci.d/buildtest.yml    |  2 +-
 crypto/der.c                  | 13 ------
 crypto/der.h                  | 22 ----------
 crypto/hash-afalg.c           | 10 ++---
 crypto/hash-gcrypt.c          | 15 +++++--
 crypto/hash-glib.c            | 11 ++++-
 crypto/hash-gnutls.c          | 16 ++++++--
 crypto/hash-nettle.c          | 14 +++++--
 include/crypto/hash.h         | 47 ++++++++++++++++------
 include/crypto/hmac.h         | 34 +++++++++++-----
 include/qemu/sockets.h        | 16 --------
 tests/unit/test-crypto-hash.c |  7 ++--
 tests/unit/test-crypto-hmac.c |  6 ++-
 ui/vnc-auth-sasl.c            | 75 ++++++++++++++++++++++++-----------
 ui/vnc.c                      |  3 --
 ui/vnc.h                      |  1 -
 util/qemu-sockets.c           | 36 -----------------
 17 files changed, 170 insertions(+), 158 deletions(-)

-- 
2.46.0


