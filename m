Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB142CD98D8
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 15:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYQJR-0007zB-OX; Sat, 13 Jun 2026 11:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <d23fa874df4f474ee7cbe738a35c1483426057f0@kylie.crudebyte.com>)
 id 1wYQJH-0007qz-Np; Sat, 13 Jun 2026 11:30:12 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <d23fa874df4f474ee7cbe738a35c1483426057f0@kylie.crudebyte.com>)
 id 1wYQJG-00051R-4Y; Sat, 13 Jun 2026 11:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-ID:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=DejdLxAhSH1cWt712EigoGGfYmmkE6/aA7DyTv6pJ3Y=; b=b4iso
 GArLRedi32Lw4wGi1qHS1rQ7qq0FskFvgi7C6YkmRgR0/G6oQ7PLalBLzvxJDyqdAAYvHHj1GSRql
 YlbAm4xVwpKOwFWu6b5a7bJWxSrnz+gj/cALctEqPQ2tVvbed7bXe2wchEtvNQ9HAwNc7nOEDgcEr
 OVfcgr6PdRWM2T0gnouXUJgy7jnDJK/zoznoxbN3zDPh80UHVqGqk4kRhufPt3zyQAMpC5xmURGm8
 RihcER0RX49wpP1IpJljAewFncccsR+abU95DMNeA9FtXN5gtcmwC2kg06CDeFboEAcgygH1D3oDr
 l4u8dAGlrqSnqyHhsI5VHG0m3NwzQRyGWAzjrhMU64j5Uxoombo5l7q5nPh9kFyFLkJsOvkvnUrKN
 KO/2/7myeIMFgEyEorz9oNeRIrF09kcWT9AUF6YLv2TNesj3T6m3xt29o+jl3PHoNLpYzexYhKrfW
 sxcO7eoKkL/IAT8GOa/c/FaElMt+ehQxH22rhW3ie5NGzn2qh64SqsghBY+BiscmRUBwzmPefzDLT
 avUYhVzqPlAgzLJdLnfKD3VmKlkg7FQA2eTd72+goLQSA2RzRhSKaDvU6CsbS+L0lj/u1BSQtc6hh
 bmEY/3iCiJCwAAW/TqhTncSd/V0LJzgXluc4/zL2l/T2CsrCbCxJkBYzybsAPA=;
Message-ID: <cover.1781361555.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 13 Jun 2026 16:55:49 +0200
Subject: [PATCH v3 00/12] 9pfs: add xattr FID limit (CVE-2026-8348)
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=d23fa874df4f474ee7cbe738a35c1483426057f0@kylie.crudebyte.com;
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

This series adds a limit on the number of simultaneously open xattr FIDs
in QEMU's 9p filesystem server to prevent host memory exhaustion attacks.

The Txattrcreate 9p request creates FIDs for extended attribute operations.
Each xattr FID contains a buffer for the xattr value. Without a limit, a
malicious priviliged guest with direct communication access to 9p server
could create a huge number of xattr FIDs, leading to potential host memory
exhaustion (DoS, potentially affecting other services on host).

Overview Patches:

 - Patch 1 is the core fix that limits the amount of xattr FIDs to 1024.

 - Patch 2 adds option "max_xattr" allowing to override the default value.

 - Patch 3 updates QEMU documentation with this new option.

 - All other patches are basically just test case changes that guard
   correct behaviour of this new limit.

v3:
  - Patch 12: Fix one memory leak.
  - Fix more typos in commit logs of several patches.

v2:
  - Patch 1:
    - Add error_report_once() call when limit is exceeded.
    - Fix typos in comments.
  - Patch 3:
    - Fix option description being pasted to wrong paragraph.
    - Minor rephrasing.

Christian Schoenebeck (12):
  hw/9pfs: add xattr FID limit to prevent memory exhaustion
  hw/9pfs: add max_xattr option
  qemu-options: document 9pfs max_xattr option
  tests/9p: add Tread / Rread test client functions
  tests/9p: add Tclunk / Rclunk test client functions
  tests/9p: add Txattrcreate / Rxattrcreate test client functions
  hw/9pfs: enable xattr (mockup) support for synth fs driver
  hw/9pfs: add xattr count query interface to fs synth driver
  tests/9p: increase P9_MAX_SIZE for test client
  tests/9p: add virtio_9p_add_synth_driver_args() test client function
  tests/9p: add 3 xattr FID limit test cases (synth fs driver)
  tests/9p: add 3 xattr FID limit test cases (local fs driver)

 fsdev/file-op-9p.h                    |  11 ++
 fsdev/qemu-fsdev-opts.c               |   6 +
 fsdev/qemu-fsdev.c                    |   2 +-
 hw/9pfs/9p-local.c                    |   9 +
 hw/9pfs/9p-synth.c                    |  51 ++++-
 hw/9pfs/9p.c                          |  62 ++++++
 qemu-options.hx                       |  28 ++-
 system/vl.c                           |   7 +-
 tests/qtest/libqos/virtio-9p-client.c | 124 ++++++++++++
 tests/qtest/libqos/virtio-9p-client.h |  88 ++++++++-
 tests/qtest/libqos/virtio-9p.c        |   6 +
 tests/qtest/libqos/virtio-9p.h        |   6 +
 tests/qtest/virtio-9p-test.c          | 262 +++++++++++++++++++++++++-
 13 files changed, 643 insertions(+), 19 deletions(-)

-- 
2.47.3


