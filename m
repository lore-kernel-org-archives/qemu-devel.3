Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465D7CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEP3Z-0008SW-Gk; Wed, 07 Oct 2026 06:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <39f9fb4e48dfd08ed6d05519be5a28898a3bf872@kylie.crudebyte.com>)
 id 1xEP33-0008JL-TA; Wed, 07 Oct 2026 06:39:05 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <39f9fb4e48dfd08ed6d05519be5a28898a3bf872@kylie.crudebyte.com>)
 id 1xEP32-00080F-Ed; Wed, 07 Oct 2026 06:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-ID:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=jCPZsG2l+Tvq+E3lzqK2Xo0J+VXp3VGSSsHB/fxf/I4=; b=dzlXZ
 D90jNwr7ucK9mBLGy1gL5dt0Jc/Qr0fO9uDGAI05luOGTd0TfgsscUVJQZ7sieG0dsF7GUGyrLifW
 uCutjsrSJzSfyyaQasUph7IkIsTC6Q61xd9V5vUWo7gYgvZE7bpNKkx/DzL0PhVqiBpTF9cfShWBE
 n/m2R7FXw5nGrRlx+k60ITTd/K8zf5cIvj+oDgbIEQJyaFyiiIjA1s/ROmE4P+164waS8aVT5qsBc
 RrbFf/hFGAoKs9FsXAbFYcolat6N8V6gfSASsUGpxmDdEka4+8x0rpiIyuhuNbxZFP6zN/kjEWk8k
 LUfZ+stroht5VHfGvnh9hxs1eSp2PxY9SYba0AD6cQFWy3GEq8NFwWPTLhyTB/dHVWTrNkQkoFXtR
 0K21RwRPv0fIN39KpCjsu5gEcFAQTTQUBdV9je5QV/YClRlFlDzxyT4HLPpt5MWdtOHLkrrFGc0+q
 nhLCHzHdGM6JF4+ceIeQxh1TNMKKMRqC+RZ+yPZCCU/DFtLq+A7oLbMs8xZJ36y8PYG7vIE6R+EE1
 JH6k3AbGZ/krTOUnTDRWInj6TpgP14OIm3a+5PkNMTE2o2SOfF1NJ/qV0YFaICm+ZmM/AdDHxVRqC
 UUBOfdXI3CSTV1uoINNx7Y0GeQp3MuQ804MNCTdziUyYbnLqI8MPcQQELP5aYQ=;
Message-ID: <cover.1791368962.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 7 Oct 2026 12:29:22 +0200
Subject: [PATCH v2 0/9] 9pfs: add race test suite + fix 9p2000.u dir stream
 race
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
    Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=39f9fb4e48dfd08ed6d05519be5a28898a3bf872@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series adds a race test suite for 9p and fixes a race on legacy
9p2000(.u)'s Tread request on directories, which was uncovered by this
new test suite.

This new race test suite challenges races by sending crafted concurrent 9p
requests on certain aspects of the 9p protocol. This series covers 3 race
tests:

  1. Patch 2 adds "race/fid-path": this race test guards CVE-2026-93834
     (fixed by commit fe9e30899f "hw/9pfs: Use read-write lock for protecting
     fid path.").

     Please refer to the commit log message of this patch for how to run
     these new 9p race tests in general.

  2. Patch 5 adds "race/readdir": this test guards directory stream races
     on 9p2000.L's Treaddir request.

  3. Patch 9 adds "race/tread-dir": this tests legacy 9p2000(.u)'s equivalent
     of Treaddir for directory stream races, and this test got triggered during
     the work on this series.

Therefore:

  - Fix: Patch 6 fixes the directory stream race vulnerability uncovered by
    race test #3.

All the other patches are basically just 9p test client additions required
for these new tests.

Changes:

  v2:
    - Allow skipping these race tests by setting environment variable
      V9FS_RACE=0, or force running them by setting V9FS_RACE=1 respectively.

Christian Schoenebeck (9):
  tests/9p-client: add Txattrwalk / Rxattrwalk test client functions
  tests/9p-race: add 9p race test suite (race FID-path mutations)
  tests/9p-client: add Rerror function (legacy 9p2000.u)
  tests/9p-client: add Tstat / Rstat test client functions
  tests/9p-race: add Treaddir race test
  hw/9pfs: fix dirent stream protection for legacy (9p2000.u) Tread
  tests/9p-client: add Tcreate / Rcreate test client functions
  tests/9p-client: track the negotiated 9p version for session
  tests/9p-race: add Tread-on-dir race test

 MAINTAINERS                           |    1 +
 hw/9pfs/9p.c                          |   23 +-
 tests/qtest/libqos/virtio-9p-client.c |  213 ++++-
 tests/qtest/libqos/virtio-9p-client.h |  124 +++
 tests/qtest/libqos/virtio-9p.h        |    6 +
 tests/qtest/meson.build               |    1 +
 tests/qtest/virtio-9p-race-test.c     | 1035 +++++++++++++++++++++++++
 7 files changed, 1393 insertions(+), 10 deletions(-)
 create mode 100644 tests/qtest/virtio-9p-race-test.c

-- 
2.47.3


