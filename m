Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05756C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 13:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT0AU-000739-QW; Thu, 25 Jan 2024 08:53:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rT09s-0006eK-SG; Thu, 25 Jan 2024 08:52:47 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rT09q-0005z6-9G; Thu, 25 Jan 2024 08:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=2vjvTXdv8Z6RCk7Xuaj/TyLTsIgPSqwgzppjsX9Ov/A=; b=NSNzb+Hn9ieT
 HGHmWOw13j0mX4tr75FFXqRYJ1qAYRZnUVKBJLej0cPlv/Amb+zIpiY/rSLqUFWyQkb1FOlVwhfuh
 lfQHawIVUg+mCcR7y22Kq1BlwqviHpPCA+zsGma0bJM7gh8ivyZXAbrdTAnBebaC34oI0vhi1Bdvf
 zEvbJs57xa5t4XDZnIRqpipA26IC60N0UJPdZOcP0oidTvnilZMFKNWMC/ZesBzJZqkggiqixLYsT
 DHOhui95L3mAZ5p/0ctW/JBFF/U9fH3ACtMksmdpbGdsdBtd4XM0h37Brdy3JUg1IEqpeVhvp1jTj
 kMrZzPrDkWCmhdygEPQH/Q==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1rT09J-00B1lo-31;
 Thu, 25 Jan 2024 14:52:37 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH] iotests/264: Use iotests.sock_dir for socket creation
Date: Thu, 25 Jan 2024 15:52:37 +0200
Message-Id: <20240125135237.189493-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

If socket path is too long (longer than 108 bytes), socket can't be
opened.  This might lead to failure when test dir path is long enough.
Make sure socket is created in iotests.sock_dir to avoid such a case.

This commit basically aligns iotests/264 with the rest of iotests.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qemu-iotests/264 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/264 b/tests/qemu-iotests/264
index c532ccd809..c6ba2754e2 100755
--- a/tests/qemu-iotests/264
+++ b/tests/qemu-iotests/264
@@ -25,7 +25,8 @@ import os
 import iotests
 from iotests import qemu_img_create, file_path, qemu_nbd_popen
 
-disk_a, disk_b, nbd_sock = file_path('disk_a', 'disk_b', 'nbd-sock')
+disk_a, disk_b = file_path('disk_a', 'disk_b')
+nbd_sock = file_path('nbd-sock', base_dir=iotests.sock_dir)
 nbd_uri = 'nbd+unix:///?socket=' + nbd_sock
 wait_limit = 3.0
 wait_step = 0.2
-- 
2.39.3


