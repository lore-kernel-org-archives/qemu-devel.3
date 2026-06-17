Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82766CD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZsQY-0003mL-NH; Wed, 17 Jun 2026 11:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <7f5445e7e4050cc117ed4b137bb7dd1474e49d57@kylie.crudebyte.com>)
 id 1wZsQW-0003kr-LC; Wed, 17 Jun 2026 11:43:40 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <7f5445e7e4050cc117ed4b137bb7dd1474e49d57@kylie.crudebyte.com>)
 id 1wZsQV-0002IX-8o; Wed, 17 Jun 2026 11:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=OaQCMTHN5Q1bX2MsH9spPLL7wft92aNI47qi3ILU7yo=; b=XBFzt
 /A8cApMNd9XAQEo10DQ5YGfXGK/IKCrxkJGpvWNzE2q2lmZ8yj563llEA5xdbP/nEIAMd/bSD9Aei
 b+1I5ochUf4VP5cQy8q62lW5+Zz1sFZrR68XHrlr25HZGapiaYtjdYwSmFWx7OBzXjF1pjpacN4H7
 QQKdPhmRYEHfoKantWFg1c453KnyHW2jSp+UZuVsd8tMhLnvE5B/HD+ocV41GVEh+1avomJX2cu5F
 7Iiy2DLpjIDsGkBEu7Mi0DB5Hpd95yKQAzE2nqZgXMTMv23XBUy5N/4bN2bYHQyLeqCS+bk1q3Qle
 KhvN7kZixaY2vGHP4p68pKTMjUI4MOF9BWEz3xWS5qcw3pWlp3cjXEfasm9vgvt9SVKk+rdNVzuXJ
 YW/45eg3Q3CkEmmY3fXkfCZxTT9OPDxhEghDxaRucq5uv/uzoadR+G9XDVo5q2PB5hriY4Ma6powj
 JdBPWm/02ZIciqcsHhDBJ0Pv8QwfQ9wDZurhNV8BHkS9AoiuvQHE769nZ7YcSoBQRhJpp2Ks4Dg5Y
 B4ImtVk0arBNzGsF8tcgKhx8sKcDgzio7rrc4yN1dhT1aCJmIPTH6KQLqs1kqlGSzHJttdYbsYo7h
 y2DA+ilZ0DSFdBlc35mRpb1eJrZ6pCz/n77gWU1MPa3xpjhYYDhwjJha/CYyTY=;
Message-ID: <7f5445e7e4050cc117ed4b137bb7dd1474e49d57.1781710785.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781710785.git.qemu_oss@crudebyte.com>
References: <cover.1781710785.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 17 Jun 2026 17:39:46 +0200
Subject: [PULL 1/3] hw/9pfs: fix abort due to illegal name with Twstat rename
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=7f5445e7e4050cc117ed4b137bb7dd1474e49d57@kylie.crudebyte.com;
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

The legacy Twstat 9p request can be used to rename files and directories.
Unlike the other, more recent rename requests like Trename and Trenameat,
Twstat does not validate the submitted new name before passing it to
v9fs_complete_rename().

A priviliged guest user with direct communication access to 9p server
could pass a string containing '/' as new name, which causes an assertion
fault (DoS) in local_name_to_path().

Fix this by rejecting such strings by checking the client supplied new
name with name_is_illegal(), similar to how Trename and Trenameat handlers
do already.

Reported-by: Feifan Qian <bea1e@proton.me>
Fixes: 8cf89e007a ("virtio-9p: Add P9_TWSTAT support")
Link: https://lore.kernel.org/qemu-devel/ba09716828e82992f9d8cac7f00eee0bc1c43c61.1780072238.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index b4314d2549..f84698bfcc 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3638,6 +3638,11 @@ static void coroutine_fn v9fs_wstat(void *opaque)
             err = -EOPNOTSUPP;
             goto out;
         }
+        if (name_is_illegal(v9stat.name.data)) {
+            err = -ENOENT;
+            goto out;
+        }
+
         v9fs_path_write_lock(s);
         err = v9fs_complete_rename(pdu, fidp, -1, &v9stat.name);
         v9fs_path_unlock(s);
-- 
2.47.3


