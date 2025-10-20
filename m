Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA740CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 14:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAqdA-0004Pi-Od; Mon, 20 Oct 2025 10:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vAqd1-0004OW-JD
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:12:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vAqcy-0007Jn-JZ
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760969563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NWqzvCjNN3mOD/GYJ+5EvdWwbg+fT++g+nO01u9j9k8=;
 b=NzcZRghliLCdFk122wZT6aT2PLgGQ9FtzhwXwGIWlPJhTyeLdWBg3jSO9k1g2ZgLBIPfI2
 Z0QKc5jzJKsBBOObTty7i76I1aNYI3TOFU0wq8ltsucBgRrZfNWtiVdCcfc3d/vaw55oHw
 pN21fm+QittR2hW90xYjqkQ0jpnJhmE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-aP-bxD4GM2CRteAvYRXUtQ-1; Mon,
 20 Oct 2025 10:12:42 -0400
X-MC-Unique: aP-bxD4GM2CRteAvYRXUtQ-1
X-Mimecast-MFC-AGG-ID: aP-bxD4GM2CRteAvYRXUtQ_1760969560
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CF01195608F
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 14:12:40 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.161])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 35D171800451; Mon, 20 Oct 2025 14:12:38 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v3 0/7] crypto: misc fixes and improvements to cert handling
Date: Mon, 20 Oct 2025 15:12:30 +0100
Message-ID: <20251020141237.2621796-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

This series includes three patches that were posted a fairly
long time ago. They are borderline between a feature request
and a bug fix, but I'm classing them more bug fix, since they
addressing issues with cert acceptance that we really should
not have had.

The patches by Henry had outstanding comments from myself,
and I've chosen to simply fix them in two followup commits
of my own now to get this over the line.

The patch from "matoro" was not accepted because they were
contributed under a github alias. With our change to have
a more relaxed interpretation of the DCO allowing any
"known identity", we can now accept this patch. It had
some conflicts with Henry's patch which I've fixed up.

Then there is one other small bug fix and one improvement
to use a newer gnutls API.

Changed in v3:

 - Re-ordered patch for fixing error reporting to be
   near start of series, instead of end
 - Add unit test for validating error reporting with
   incomplete CA chains
 - Unit test to validate that an Error is filled on
   expected failures

Changed in v2:

 - Update to latest upstream

Daniel P. Berrangé (5):
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
 crypto/tlssession.c                   |  12 +-
 docs/system/tls.rst                   |  13 +-
 tests/unit/crypto-tls-x509-helpers.h  |   6 +-
 tests/unit/test-crypto-tlscredsx509.c | 155 +++++++++++++++---
 tests/unit/test-crypto-tlssession.c   |  14 +-
 tests/unit/test-io-channel-tls.c      |   4 +-
 7 files changed, 280 insertions(+), 147 deletions(-)

-- 
2.50.1


