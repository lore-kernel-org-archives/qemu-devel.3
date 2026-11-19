Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65116071655
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ovhcloud.com header.i=@ovhcloud.com header.a=rsa-sha256 header.s=mailout header.b=qsuhuK/I
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU3Q7-0004Ue-FB; Thu, 19 Nov 2026 09:47:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xU3Pv-0004R0-AW; Thu, 19 Nov 2026 09:47:17 -0500
Received: from 1.mo508.mail-out.ovh.net ([5.135.90.176])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xU3Pp-0006D1-Hk; Thu, 19 Nov 2026 09:47:12 -0500
Received: from DAGFR11EX3.OVH.local (unknown [10.110.58.62])
 by mo508.mail-out.ovh.net (Postfix) with ESMTPS id 4jVhBQ4q99z7tDT;
 Thu, 19 Nov 2026 14:46:54 +0000 (UTC)
Received: from ovhcloud.com (109.190.254.2) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 15:46:53 +0100
From: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, <eblake@redhat.com>, <vsementsov@yandex-team.ru>, 
 <kwolf@redhat.com>, <hreitz@redhat.com>, <stefanha@redhat.com>,
 <fam@euphon.net>, Guillaume Vincke <guillaume.vincke@ovhcloud.com>
Subject: [PATCH 0/5] block/nbd: Fix block resize on idle device
Date: Thu, 19 Nov 2026 15:46:27 +0100
Message-ID: <20261119144632.232457-1-guillaume.vincke@ovhcloud.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CAS2.OVH.local (172.16.1.2) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 855402457000591837
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTE03POJSvJxZ/ZAD2FML4OApQa5CAuPFd+GiPeim6W93w01LLdJozjdbdDshLZy5aDsRenk1iGBkQ25uvGMFtnPbIzJjqNyy8hRxeKGDl5YRHwtoVGPeLqiqTr/6nIK5uTPrZ33wykYnXG9bOnPn0McKG/CrX+6mi5B1e0mremeM5e/EiXKFwDmbTO04TcNVxYVuQFMZ4jXGRbM84YZdnFxKP9bNy4OO+fuZwnlJQUw/RsGJSrLbtvK6Xaw3/43qxZMgb01BZxrS5qoPehzV5aTCbR6EFjPfLRpTkpe+DpufotcS3KCQCYujIRPLspI5BAlFgkuypZRklkoZj2/HL3laYfaXNsELcEDsM8ITbDs2eJLfaDRsTPFJSsc3Q1sWUhqp/bKJurODx1sZBFRCk6hI9A6vQX8Aof09FIzFJOP0pvElKN2WGr8W2OMmgCaHzyLJoo07UOjhLUQJJkkq3AwJFtU+VUPrrSBAfUtrfYxGZSmUoo0Cgp8iyxQItzLu2tVoZOWZ8MZ7RKCg7QYs16PJRkopgv+PvPqgGNAp+xP6fA5jbpNkOLJYBt6OFqjcIdSQwrTcEDKnOIRMrf4o/5+5a9xEKkH9nLFpteWnkScVy3JCF+Z9FkWsuXrZEcctVZVzb9YZXo1KMi85XPCLK9XDdUpS41igAdCPnfox9xnig
DKIM-Signature: a=rsa-sha256; bh=CEmspZ6xGeMESBOr0BUQCAtMPuZ1lSEeMaTpkVqIv2Y=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1795099615; v=1; 
 b=qsuhuK/IOcc2Y+EGAZpLAyogWffK8gd1zQ7Xhpuf0Iwt+JPNPxBYOMGKNnVcwzUGtGUAIOed
 jf5aTa2IKL6Zm9ReSpRUXb8C7lxhbsB4wZ6Ms1k8sIMQud9dLDymIfsKVDIOa+iRZUh/RHydy/t
 AWygwisIenunlb6ez6+2i1yE=
Received-SPF: pass client-ip=5.135.90.176;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=1.mo508.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: guillaume.vincke@ovhcloud.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When using an NBD backed device, the size is exchanged during
handshake. Therefore, when a volume gets resized on the target, it
closes its clients' connections to force a new handshake. Then,
management like OpenStack calls the block_resize QMP command to update
the node size.
This method works on active devices but, considering the NBD client
reconnection is lazy, the handshake does not happen on idle ones which
leads to a "Cannot grow NBD nodes" error when calling block_resize.

This patchset adds a function to manually trigger reconnection on an
NBD device and calls it in the block_resize QMP command to make sure
the new size gets exchanged before trying to update the device
internals. It also implements the refresh callback in the raw and luks
drivers, which forward it to their file child.

Based-on: <20261105164124.249395-1-guillaume.vincke@ovhcloud.com>
Needed to detect if the channel was closed by the server.

Based-on: <20261113140852.702959-1-guillaume.vincke@ovhcloud.com>
Needed to implement a deterministic test.

Guillaume Vincke (5):
  block/nbd: Extract request slot access and reconnection
  block: Refresh the connection before block_resize
  block/nbd: Refresh the connection on block_resize
  iotests: Add coverage for NBD resize
  block: Add refresh connection support to raw and luks

 block/block-backend.c                   |  12 +++
 block/crypto.c                          |   7 ++
 block/io.c                              |  24 +++++
 block/nbd.c                             |  95 +++++++++++++++----
 block/raw-format.c                      |   7 ++
 blockdev.c                              |   9 ++
 include/block/block-io.h                |   8 ++
 include/block/block_int-common.h        |   3 +
 include/block/nbd.h                     |   1 +
 include/system/block-backend-io.h       |   2 +
 nbd/client-connection.c                 |   7 +-
 tests/qemu-iotests/tests/nbd-resize     | 116 ++++++++++++++++++++++++
 tests/qemu-iotests/tests/nbd-resize.out |  24 +++++
 13 files changed, 297 insertions(+), 18 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/nbd-resize
 create mode 100644 tests/qemu-iotests/tests/nbd-resize.out


base-commit: 6883fb508cb7a93e2e7b44c0582bfd9fc2196d4d
prerequisite-patch-id: 484bee7f7d30179f284198c8fc5162830f56b2e2
prerequisite-patch-id: 73f560b55444e04d1615f3351b13a47f375bcd82
prerequisite-patch-id: 722470bc9ae187fc429d7af8a5f3eefb46bf80d7
prerequisite-patch-id: 6c1f8d46edf0e6dc070764a755d34740855af4f1
-- 
2.43.0


