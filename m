Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D328CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZW0U-00077s-Rm; Tue, 16 Jun 2026 11:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <531f6b81bc1bf1a48c3d4afaa60a65db10511041@kylie.crudebyte.com>)
 id 1wZW0R-00077T-P9; Tue, 16 Jun 2026 11:47:15 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <531f6b81bc1bf1a48c3d4afaa60a65db10511041@kylie.crudebyte.com>)
 id 1wZW0Q-0000D3-Cs; Tue, 16 Jun 2026 11:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-ID:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=wX/b9Wz7cnUDEBHaByGqj2oBMl1kNrQ+PMn62SOB2mo=; b=rxtDA
 FsiuTJI+ynKnr4sxC7eTBSSWr6qmXvVARuUKfK+KBNgF1TpAU0h+1EAp+bNmQpj3DX/6ugt5kf1PL
 591enSLYfeF0K7R3BNsRw5FXfIASfCSk0rXo3FEVGG6dRcsMWYtrGnnvruA/f3XuQE3K4iCDtki0y
 8pCgeisjfEF1hHrrBHwM1llgMOyTJC4C47vfFXzD5KZdKFYAbNW9mbd+nc8mOOtvDe3gNMTY0ZRBh
 KyCO8lAklFyhraj4kXGxWN46BQzdXvu5H1qA2OyjkC0x/iZmOXGG5bckhgWyFFzo5Fa9guE7oVfUq
 KfiB3oGGXXZiB4zDetIb0vWjFyhjC+tmfTSAiU8Ss/KlmKO/8u7HnIGMbiJD7lefGSOmu/PjzvelL
 vcqXxRhFmVxHpYQb1+1C3l+NbHxdDJcFpQkIgipgyBSjcRAWegUMET9xHvP8z9w0Sb7Wuvvvpeocs
 n8FyUIs7iBkkeu/Uz1YOKQjZj40wNICeC4WAv/NcRVXa0YEv8RBv0EeWrwx1Lk3/1TNZBjpf2Irty
 lCjZQnZ8djGb/KFCAJvIXmwFyVRZr0Yi5cJNy5Ce2s55uO3SNZ4MU8SllzrVLeMa36JKzivWs1Vls
 WxM56bIo0rpPlS86zjxbVzfYMKRsS/qB3Fx/2WRaQ/dEDMHh+NmT4Bpt4VTubM=;
Message-ID: <cover.1781621428.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 16 Jun 2026 17:00:11 +0200
Subject: [PATCH 0/3] 9pfs: fix invalid union V9fsFidOpenState access
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=531f6b81bc1bf1a48c3d4afaa60a65db10511041@kylie.crudebyte.com;
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

The individual FID types (P9_FID_NONE, P9_FID_FILE, P9_FID_DIR, P9_FID_XATTR)
share union V9fsFidOpenState with FID-type specific fields. Accessing any of
the union fields must comply with the FID-type to avoid undefined behaviour
or information disclosure.

This series fixes invalid access of this union type at several locations.

* Patch 1 and Patch 2 are the core fixes checking the FID type on protocol
  level (9p.c) before allowing access to a FID-type specific union field.

* Patch 3 adds another safety layer by returning -1 from local_fid_fd() if
  the FID type would not have a valid file descriptor.

Christian Schoenebeck (3):
  hw/9pfs: fix invalid union access by v9fs_co_fsync()
  hw/9pfs: fix invalid union access by v9fs_co_fstat()
  hw/9pfs/local: harden local_fid_fd() on FID types

 hw/9pfs/9p-local.c |  5 ++++-
 hw/9pfs/9p.c       | 17 +++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.47.3


