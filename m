Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B405ACD4F50
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 18:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP2mD-0006eQ-5n; Mon, 18 May 2026 14:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <933552b2cfc2c442fac7f4e68c777dce20ee8d7e@kylie.crudebyte.com>)
 id 1wP2la-0006OW-LR; Mon, 18 May 2026 14:32:48 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <933552b2cfc2c442fac7f4e68c777dce20ee8d7e@kylie.crudebyte.com>)
 id 1wP2lV-0002Ql-J7; Mon, 18 May 2026 14:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-ID:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=t8s7J6yEtqcRJEkBmv7SqXGFV2+aytw+FyII5ro4DyI=; b=Om7ny
 NHQONP0+JiOf6rarGzw2BuGF/DrmKzQIzpQC31NU8i/CqmSA5PaZB9p1o+wEIi2Vcr851NYYLzkh0
 dpI17QGHK0plBj5+5Gr2JicvbX1w4AXc+bMjQLjFnFK6wxreurG6yxgtZZvCtJ3fW40MIDFdzVNt1
 iSr0wX5qR3IxTrAeiyBS7n5tEUiJhR3ZbDL6Y62AIVPQgAPDhOMNwnuWwQ7tsmy9v8rrl4JRCF60m
 wfJrP/DOOkDEAdb7a4rnfs4PFiJvnxrv3NIUmgJuPv4Pdx5hjUTY8/FBFRg1xvQL6jW93IFaRyHsg
 o22rgqHazvHdcvGspjajMzUfezut480cgYb4K0AWgVlcS6eVYHK0zAZydeATmbt/8VtKKqRzsF1y3
 xTjn/2QvSZkqhuFgGMBNGU4chWu1ie9ycYap7RVzZS2D/a2yzND2QR+zhrA7DoBZRC4U3keOiGoN2
 TuQWDQC/HJ0OZ3QjSRqc4aZyRuC7asAgsVsCrBxk2HA9XIWuI8jIJfZaTgpjq2SHtqqdvX7fQAX+a
 gj7RdNbbfyuRlEvCojUujFDNYE7X5aAeAMEUOyXThdxK22v7G8dtA8YwS+MS1/WQ6nRpagfIE/hoh
 n9OJcW08GlMYgB0QI/KqyBbikKTCHeEugouL8I01WlcZGOoh1frRsOEAXDW9+U=;
Message-ID: <cover.1779126034.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 18 May 2026 19:40:34 +0200
Subject: [PATCH 0/6] 9pfs: fix V9fsPath heap buffer overflow
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Jia Jia <physicalmtea@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=933552b2cfc2c442fac7f4e68c777dce20ee8d7e@kylie.crudebyte.com;
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

This series fixes a heap buffer overflow vulnerability in the 9pfs local
backend. The vulnerability occurs when handling paths exceeding 65536 bytes,
due to the V9fsPath.size field being limited to 16 bits.

The fix consists of:

- Changing V9fsPath.size from uint16_t to size_t.
- Converting v9fs_path_sprintf() to return int for error handling.
- Adding error propagation through all path manipulation functions.

Invididual Patches:

- Patch 1 is just an additional defensive patch.

- Actual fixes are patches 2..4, where patch 2..3 are prepatory, and
  patch 4 is the actual behaviour fix.

- Patch 5 adds a reset function to the virtio test client for the new
  test to work.

- Patch 6 adds a new test to guard this buffer overflow issue.
  It must be enabled explicitly by -m slow for it to run.
  
More details about this issue:
https://gitlab.com/qemu-project/qemu/-/issues/3358

Christian Schoenebeck (6):
  hw/9pfs: add NULL check in v9fs_path_is_ancestor()
  hw/9pfs: change V9fsPath.size to size_t and v9fs_path_sprintf() return
    type
  hw/9pfs: add error handling to v9fs_fix_path()
  hw/9pfs: let callers of v9fs_path_sprintf() and v9fs_fix_path() handle
    errors
  tests/qtest/libqos: add qvirtqueue_reset_pool() for descriptor pool
    reset
  tests/9pfs: add deep absolute path test

 fsdev/file-op-9p.h           |  2 +-
 hw/9pfs/9p-local.c           | 23 ++++++++----
 hw/9pfs/9p.c                 | 41 +++++++++++++++------
 hw/9pfs/9p.h                 |  4 +--
 tests/qtest/libqos/virtio.c  | 23 ++++++++++++
 tests/qtest/libqos/virtio.h  |  2 ++
 tests/qtest/virtio-9p-test.c | 69 ++++++++++++++++++++++++++++++++++++
 7 files changed, 144 insertions(+), 20 deletions(-)

-- 
2.47.3


