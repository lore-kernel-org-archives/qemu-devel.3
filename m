Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660B9CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 17:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT0g4-0006GP-RT; Fri, 29 May 2026 13:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <ba09716828e82992f9d8cac7f00eee0bc1c43c61@kylie.crudebyte.com>)
 id 1wT0fq-0006BO-0k; Fri, 29 May 2026 13:07:07 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <ba09716828e82992f9d8cac7f00eee0bc1c43c61@kylie.crudebyte.com>)
 id 1wT0fn-0005zd-VS; Fri, 29 May 2026 13:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=kuDU0SJYEpQm+SDC87IHg0dE+llS/Ci4L0J44gT7NX8=; b=h8qvR
 lnhB21YF2ZT08BW8VPKdyBEllYYLwbqPafSDlH22kSmXJJoddLhUsBevf1/tf/Oc1lPAdEqpfuLDu
 rYvLF4Kw4Pkm3n73UJ8g7WbwqyDtXDs4A86HFVL3GFZ8Dz75Yyp1MweeQ3MrCgJCK1mO3mv5hAREv
 W5DONmwjUXSrpjMC++MXFTNjIi27pQLo2Bgzf3FNjviCHkA84vRm5FbrgAP8qXYIIdW8yIt/Qemfr
 XnXx/WcqoqLG0OT7/GLBLzpfvEDjA9BJFjqx6vDkRBn9FEiu11B2BldAEVn4sx7kAbMxgxAPGecly
 k2iDJZLus2O2xCVkA2DlwxL+cd7ACdl2dD2yacRS5uO3FLF3Y+xPv6EQywr9JS4lhORiO8HkLoT1Y
 q0sc9nPmYGghPST9siEz1h6+y3FGEdIreLTvhBPWRp4XaYUC8GbV1VZ3zeVZcPz3dcicUqzMXg1X+
 tAOqOBot7eKPSbZ5VsDBHfV2iWhn3tZYhk57fHCalBQ6IMHF8661LP/boj7xkGXLr3amsTeAwd7/D
 5cYtVCmFL186oPkgKaPEzmV7u2ISAkqdfxf6UKk5By85sZ3JtyW8ZW90ufdq53XB98+rNnDFgJ+hx
 tipXImCEBylcXut705zmLVH1U+O34IE8AMnFd9Bpb81Sr0sw1ypqTF2a90mJIg=;
Message-ID: <ba09716828e82992f9d8cac7f00eee0bc1c43c61.1780072238.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1780072238.git.qemu_oss@crudebyte.com>
References: <cover.1780072238.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 29 May 2026 18:29:26 +0200
Subject: [PATCH 1/3] hw/9pfs: fix abort due to illegal name with Twstat rename
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=ba09716828e82992f9d8cac7f00eee0bc1c43c61@kylie.crudebyte.com;
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
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index e2713b9eee..88fb28b318 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3617,6 +3617,11 @@ static void coroutine_fn v9fs_wstat(void *opaque)
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

