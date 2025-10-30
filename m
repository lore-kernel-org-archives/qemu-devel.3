Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9776FCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 14:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vETyU-0000kQ-P3; Thu, 30 Oct 2025 10:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETyG-0000WN-3p
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:49:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETy6-0001P0-82
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761835774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6AqJAODDPrJh7t7f9F/ZHJNzsJI1oH+iGlXNH5R7C3k=;
 b=Bt8Is+6+jlIZt2ymloYt76Lxw0D/I5YPcu7w+4VrDDnMiAHxM1MZ44HdMXMs+l0NwQc+XW
 EhuLRhyxZjr2ppU7Zs6C7tPR1va0X3MEDUuy/jGL3ElRTYQT/v3LefcCiQ2cb03Wvqylyz
 HJxVYMctNd/oYk8KqF5XaiCHdQSz+YU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-xUdeUZTBPteXH68kLti0Kw-1; Thu,
 30 Oct 2025 10:49:31 -0400
X-MC-Unique: xUdeUZTBPteXH68kLti0Kw-1
X-Mimecast-MFC-AGG-ID: xUdeUZTBPteXH68kLti0Kw_1761835770
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B622A19541A7; Thu, 30 Oct 2025 14:49:30 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.122])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 30C7B30001A6; Thu, 30 Oct 2025 14:49:28 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org
Subject: [PATCH 00/21] crypto: support multiple parallel certificate identities
Date: Thu, 30 Oct 2025 14:49:06 +0000
Message-ID: <20251030144927.2241109-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This series aims to improve the support for post-quantum cryptography
in TLS connections by allowing  multiple sets of certificates to be
loaded. The idea is that during a transition period servers will have
a traditional RSA based certificate in parallel with an MLDSA based
certificate for PQC, and the right one will be dynamically determined
during the TLS handshake.

The first 12 patches are trivial cleanups.

The next 3 patches fix a potential use-after-free problem

The last patches introduce support for multiple certificates.

NB, in terms of testing this will require either CentOS Stream 10,
or Fedora 43. Most other distros will not support PQC out of the
box at this time even if they have new enough gnutls, since they
don't make use of the crypto-policies package which is needed to
enable PQC by default.

Daniel P. Berrangé (21):
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

 crypto/meson.build                    |   5 +-
 crypto/tlscreds.c                     |  77 ++--
 crypto/tlscredsanon.c                 |  62 +--
 crypto/tlscredsbox.c                  | 101 +++++
 crypto/tlscredsbox.h                  |  46 ++
 crypto/tlscredspriv.h                 |  36 +-
 crypto/tlscredspsk.c                  |  64 ++-
 crypto/tlscredsx509.c                 | 592 +++++++++++++++++---------
 crypto/tlssession.c                   | 139 ++----
 crypto/trace-events                   |   1 +
 docs/about/deprecated.rst             |   9 +
 docs/system/tls.rst                   | 134 +++++-
 include/crypto/tlscreds.h             |  26 ++
 include/crypto/tlscredsx509.h         |   6 +
 tests/unit/test-crypto-tlscredsx509.c |   8 +-
 ui/vnc.c                              |   9 +-
 16 files changed, 849 insertions(+), 466 deletions(-)
 create mode 100644 crypto/tlscredsbox.c
 create mode 100644 crypto/tlscredsbox.h

-- 
2.51.1


