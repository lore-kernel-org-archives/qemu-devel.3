Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB11C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCFZ-0001Tb-Fv; Mon, 29 Jun 2026 09:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <75893c058b21d87d1ec66bbd4e8bf84e1fd616d1@kylie.crudebyte.com>)
 id 1weCEn-0008EP-Ee; Mon, 29 Jun 2026 09:41:27 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <75893c058b21d87d1ec66bbd4e8bf84e1fd616d1@kylie.crudebyte.com>)
 id 1weCEl-0005Us-Np; Mon, 29 Jun 2026 09:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=3fZFgoUDcW5y38BozeBzb4oblUwakWj+uCadZre4Sdw=; b=Gn8yT
 BK3NWZDSqSDZl3rAIS2cdKB31ax+Nzf0oi52e5Yvmhua0JCraFNfcTAEgQVkypvpOASFSPqsWH24s
 IF2eGBQEuyBqdW7zwdccsOC+nyR9hodusqr6AyjCUokKZdmbsKLHN/tVvTNx1kMO/VEwP3sxfWNLb
 GiAQ+YFGhJs82xtrXMAJma90s7XF7hvAuAaBWW/R5QpLnZKuho6PFGQvZoG+Av8d3msBPgFYvc/4i
 2kRoAaKAG9rXrzsZh0YEjOYt0w6PCTzvh0Yqv3FVbSCQp1PZO9P1aBB867fxC2X53oWrp2X5GPk0t
 K5GbNAx8vSDTUpt3nUk1e63BOF5toywazMbT+o8Fsv6A3PW1wLp0uQCO9DCXXBcFj2aaT6wKNePxY
 H9KOoJUUN3BjnAlwvUMjLp/WD8DMNwbtWVfCaXUw5JesQKIMJH9JV45B2L967RUv12scCBU7Nntq5
 jn/GsEwTzKzLpRdG7UlmuWCQ3m+K8N8siHb1Xg27XwVBOPOLpUgQ6Exk2Ic3v2FrEse6ZTlIRRkxM
 TbgNSvphqydOiaBDXDvVhMew34tIud4vC+zDQh9WYb922CuO/C/6OxAQC15OGPvIy87Y8rHrZFZe8
 yfGuv7WRA7Ppt3yXvz1YwP2ASzGN5MSHD8dVMMj3BuUdhwRKhmffkx1HPAZ6kM=;
Message-ID: <75893c058b21d87d1ec66bbd4e8bf84e1fd616d1.1782739719.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1782739719.git.qemu_oss@crudebyte.com>
References: <cover.1782739719.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 29 Jun 2026 15:28:39 +0200
Subject: [PULL 23/23] hw/9pfs/local: harden local_fid_fd() on FID types
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=75893c058b21d87d1ec66bbd4e8bf84e1fd616d1@kylie.crudebyte.com;
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

local_fid_fd() returns fs->fd for any FID type that is not P9_FID_DIR.

Since P9_FID_XATTR and P9_FID_NONE share union V9fsFidOpenState, calling
local_fid_fd() on these types misinterprets xattr state as a file
descriptor, potentially leading to undefined behaviour or information
disclosure.

Even though we are catching these FID type mismatches on protocol level
in 9p.c already, previous patches proofed this to be error prone.

So let's add another safety layer in local_fid_fd() that would return -1
if the FID type would not possess a valid file descriptor, to prevent
wrong file descriptors from reaching fs backend calls.

Link: https://lore.kernel.org/qemu-devel/531f6b81bc1bf1a48c3d4afaa60a65db10511041.1781621428.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p-local.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 4708e170a4..ee592b62f8 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -775,8 +775,11 @@ static int local_fid_fd(int fid_type, V9fsFidOpenState *fs)
 {
     if (fid_type == P9_FID_DIR) {
         return dirfd(fs->dir.stream);
-    } else {
+    } else if (fid_type == P9_FID_FILE) {
         return fs->fd;
+    } else {
+        errno = EBADF;
+        return -1;
     }
 }
 
-- 
2.47.3


