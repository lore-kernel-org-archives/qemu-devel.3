Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC34C98328
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8X2-00030n-7g; Fri, 25 Sep 2026 12:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xA8Fr-0000D0-Pr; Fri, 25 Sep 2026 11:54:34 -0400
Received: from 2.mo15.mail-out.ovh.net ([5.135.90.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xA8Fp-00067Q-CV; Fri, 25 Sep 2026 11:54:31 -0400
Received: from DAGFR11EX3.OVH.local (unknown [10.110.43.115])
 by mo15.mail-out.ovh.net (Postfix) with ESMTPS id 4hrwHV1kk8z3wZw;
 Fri, 25 Sep 2026 15:54:13 +0000 (UTC)
Received: from ovhcloud.com (109.190.254.61) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 17:54:13 +0200
From: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, Eric Blake <eblake@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 0/2] nbd/client-connection: Fix client returning a closed
 channel
Date: Fri, 25 Sep 2026 17:53:44 +0200
Message-ID: <20260925155346.357703-1-guillaume.vincke@ovhcloud.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [109.190.254.61]
X-ClientProxiedBy: CAS4.OVH.local (172.16.1.4) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 11035507938916974887
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGzICmfK24qXpWZRFZ4KesKjdwXkYSu5E1QpslTSTFwnL1fDNy7esKCZB59qn5Po04j0U4nTu4FyYlseC1p3VRyCh3PXL6nNlCT2Z3VprvuQsx1E6SDDjqFX/TJpx3L+XCvyg3eCQ4qLGQyqp6JTLxyvHHMx+Wu7bahEpNulv9/9p5LFxeBYMz5aZoTKr0oBGmazzQBNhy2R6pZkV5/qjr4Wui9sDzw9FJjGa7pIi3I3+vO3L02n6nvQI4OvQ8aOt3Z/VnN8c8bzelOoIQqixdDCBKLk9g/STuGGCyG21qubdBNcYXIeCc8Q9wbMC9cMPCF0tUJKnqx6CAPvFHxTT+QGn9EK0TyMZnWKVXCsWf2up7XRdWmf6vWb91+6J95MsjaHTW5W9s3xmuP0tq+6PWfA8IW/9yxkOUdbI4UbwOwiRtWI2p9qxnpepczj6GyLzSUBWzW5FFHu5Z+DadgyXkWZBqBm0GVi8Zhu0H9gLhTUhYavMIdOWs25EtwOiwjkg4mOGvnlql+46Amty+G7zMOmh48FlqlL0hza4+pftx8LUcHMFEk0MGFt4vnmCCuLspVZsOcesnY/fQm6SDnVls/D+2h3Dk2Fb1nrCPlkIm4qM8+FnuDtxQoV3MFV0t/3n5WsWRLHQag981EQ8eVBZCZStHLGW0Jp18FKjqr5ceY5Q
DKIM-Signature: a=rsa-sha256; bh=z8x28vUVIpWclSKRN4whi/vrjIHL0hEOSvqnSEib9cM=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1790351655; v=1; 
 b=Q1Zx8YLgpU8aD8Cohp/6tF/KzHPFizu9V6IJLeg54r63DIbP+/dfWZAjxcYHSpzHsjU6fHC8
 cTTQZvydv6dZcUXHDPz6CPN0fzAZVSqCw8rWRT0Ic7reaw3vEXYmGjt2nTPtbdnfBitDUbfFdNy
 qpMpI2iJWHQavi5M9W1ZJzNg=
Received-SPF: pass client-ip=5.135.90.179;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=2.mo15.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Sep 2026 12:05:02 -0400
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

NBD client relies on lazy reconnection on error. There is a case where
nbd_co_establish_connection() will hand back a channel disconnected by
its peer. This leads to the request running on the dead channel. When
reconnect-delay is set to 0 (the default), this bug prevents the
nbd-connect thread from running on the first operation. This patch set
addresses this specific case.

Found while searching for a way to force client reconnection to simplify
the resize of idle nodes which will be the subject of another patch set.

Guillaume Vincke (2):
  nbd/client-connection: Fix client returning a closed channel
  iotests: Add coverage for NBD connect thread start delay

 nbd/client-connection.c                       | 35 +++++++++++
 tests/qemu-iotests/tests/nbd-stale-connection | 62 +++++++++++++++++++
 .../tests/nbd-stale-connection.out            | 17 +++++
 3 files changed, 114 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/nbd-stale-connection
 create mode 100644 tests/qemu-iotests/tests/nbd-stale-connection.out


base-commit: 3876503faff51ce3a132dbbd0ab42c10f2269319
-- 
2.43.0


