Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3383ACD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZW0M-000766-DG; Tue, 16 Jun 2026 11:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <b583e29d5a0776e41263732c93ac9f0da0a6016d@kylie.crudebyte.com>)
 id 1wZW0L-00075t-EH; Tue, 16 Jun 2026 11:47:09 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <b583e29d5a0776e41263732c93ac9f0da0a6016d@kylie.crudebyte.com>)
 id 1wZW0K-0000CM-3Y; Tue, 16 Jun 2026 11:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=7NyJ2XsVvajSIhIIvEmJyLqzswgkwsSYrVdjDPRCdX8=; b=Y4kQq
 hVuP+t2dfpLZ3R43vVyVdWQE/a1NY88V/iBuRhyuwlPngOaIz1TjL9OFpedusS7XFNFjSb8H/Hcvw
 SoV5Jn1K2RKfF/+XlcTiSC6YLxOzaBHfFvqV/lKV9VQ98JWOCF6g0sXFeWxbTcy+ZkzddQ8wmurew
 Djcq3gH9uZnjX/8my4KMFqhk5zsrYwGDDa8Oc52lT7iga3tdFeLhb5FfZ6XAjEUAea8LsZnm7S7RT
 38RT/BrQKtpDcA8UlA70X4rSxGwn0cSAg3g3J/NmZdSNDZXkST9dFhE9kNsuLsAM/Y5s/sOui1cBe
 66E2McsIeK9gxkQOAFKz5lKGdgBsPpeC5aYQWrywJIMaIi1OvHnhIpZvpVuRoODIrQlcP3r7EOexC
 SKHA5IqyDx/U18rcHP3SExNZAWYv8bw4ulReL54iLycwsBkmL136ldG2/THAY3KnkTwPv4RDTMlb1
 kTN5mnWS+qTkW9TcHc4ghWGn6/SGpoDCb4dwjxy00qORndmUbkNUzhs7Ctte5wNEGl6/cfZ+jOG1w
 Yz+twlGOpFrfF9TTOYmtvS9JItQvBioKWDw2j4db42Qn3XurwJkw54Sk373fogKp4vOqg3Jk/ehaq
 700jfItOQMBkfLShwVKA1JfMcjaGnU28LdxmT13rDmXXmD5uAZ1a0UNowJR+s8=;
Message-ID: <b583e29d5a0776e41263732c93ac9f0da0a6016d.1781621428.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781621428.git.qemu_oss@crudebyte.com>
References: <cover.1781621428.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 16 Jun 2026 17:00:11 +0200
Subject: [PATCH 1/3] hw/9pfs: fix invalid union access by v9fs_co_fsync()
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=b583e29d5a0776e41263732c93ac9f0da0a6016d@kylie.crudebyte.com;
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

Fix this in v9fs_fsync() and v9fs_wstat() by checking if FID has a valid file
descriptor before calling v9fs_co_fsync().

Fixes: 10b468bdc533 ("virtio-9p: Implement TXATTRCREATE")
Reported-by: Feifan Qian <bea1e@proton.me>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index b4314d2549..6dd6a57e7a 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2247,10 +2247,15 @@ static void coroutine_fn v9fs_fsync(void *opaque)
         err = -ENOENT;
         goto out_nofid;
     }
+    if (!fid_has_valid_file_handle(pdu->s, fidp)) {
+        err = -EBADF;
+        goto out;
+    }
     err = v9fs_co_fsync(pdu, fidp, datasync);
     if (!err) {
         err = offset;
     }
+out:
     put_fid(pdu, fidp);
 out_nofid:
     pdu_complete(pdu, err);
@@ -3584,6 +3589,10 @@ static void coroutine_fn v9fs_wstat(void *opaque)
     }
     /* do we need to sync the file? */
     if (donttouch_stat(&v9stat)) {
+        if (!fid_has_valid_file_handle(s, fidp)) {
+            err = -EBADF;
+            goto out;
+        }
         err = v9fs_co_fsync(pdu, fidp, 0);
         goto out;
     }
-- 
2.47.3


