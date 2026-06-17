Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71705CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZsQg-0003rY-Og; Wed, 17 Jun 2026 11:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <08750e31fcdccf5352dc3b44475ed5ba6bc80221@kylie.crudebyte.com>)
 id 1wZsQc-0003qm-Vr; Wed, 17 Jun 2026 11:43:47 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <08750e31fcdccf5352dc3b44475ed5ba6bc80221@kylie.crudebyte.com>)
 id 1wZsQb-0002JY-FQ; Wed, 17 Jun 2026 11:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=3BZ27s7P7Q8df9ELxbX/Yz9rKy7ELrktCVvJzz21ZN8=; b=b3kCz
 fOBRepmQZMOsTafCPx1GswCGc6Lz1uiQm4VY2df4oKMynlb6KFOV93TqkTc9EqyLoTOaHU74MXpnz
 Ar5DkPoVvjqkSapCJt2LoZFxgfc7qSDWSiHX7+0edUfZpVU0rYKBR7noM98U3PbfXBWpBChwb2foW
 I3FoD7FreGQtR9846yHaOVGxfgro9mM191GnSlrj79ed7GrhSPN1GksNWCS6QGmogMS3MTRUYtP29
 mRkd2b3TZakOhxrd2hpyJ4PVh8KU2HI1uKoMmiqTOubY8CxS5ezKakW5sdg0o/LAVDqM5qsHoq05c
 S7Lsr7VFCKIhQDLskmOTOIRqldd4BSu1EAu8nrmEkTy69AOxv6S8UQKMzEct+Ps5aZSAUw31a8ur3
 wHAoDtRtVhAupaIc71MzSEC+/akGbYcPd27DEyXZ8ItTGY6Dahw4f+HNcHNok3KRlK63pPJ4aIu5D
 +SW0NhpBPbfajh54qa1Pt3tlq7whteceE7dGXTGALvcoWwEfPL5DYhEsVXg+Y3z9IGWDKp2bMjRtT
 4PkKGqBoJk/dPaWBgkbHk2/MynBcVf5oKSJkjaDrypCEm4jJcfn23SjdtY3Mk2ucFbPg88bptiKGh
 sFZwr71rxdFBQGk5xbpPQNp1JAZiW74Don87euq80NHILC9RBcYa2puT3nBGzM=;
Message-ID: <08750e31fcdccf5352dc3b44475ed5ba6bc80221.1781710785.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781710785.git.qemu_oss@crudebyte.com>
References: <cover.1781710785.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 17 Jun 2026 17:39:46 +0200
Subject: [PULL 2/3] hw/9pfs: reject . and .. in Twstat rename
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=08750e31fcdccf5352dc3b44475ed5ba6bc80221@kylie.crudebyte.com;
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

The other Trename and Trenameat handlers already reject "." and ".."
as new name on rename requests by returning -EISDIR in this case.

The legacy Twstat rename handler is missing this validation. While passing
"." or ".." does not trigger a crash as fixed by the previous patch (since
the fs backend driver's system calls handle these gracefully), it creates
a behavioral inconsistency, as it is semantically meaningless to rename a
file to a directory reference in the first place.

Fix this by rejecting "." and ".." in Twstat rename handler with -EISDIR
to match behavior of Trename and Trenameat handlers.

Fixes: 8cf89e007a ("virtio-9p: Add P9_TWSTAT support")
Link: https://lore.kernel.org/qemu-devel/662333331d371c6c343c8091161de8eaa121880e.1780072238.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index f84698bfcc..936e4e9349 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3642,6 +3642,10 @@ static void coroutine_fn v9fs_wstat(void *opaque)
             err = -ENOENT;
             goto out;
         }
+        if (!strcmp(".", v9stat.name.data) || !strcmp("..", v9stat.name.data)) {
+            err = -EISDIR;
+            goto out;
+        }
 
         v9fs_path_write_lock(s);
         err = v9fs_complete_rename(pdu, fidp, -1, &v9stat.name);
-- 
2.47.3


