Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC4BFF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 06:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHyIO-0004an-5O; Wed, 29 Apr 2026 02:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wHyHv-0004Vk-34; Wed, 29 Apr 2026 02:20:51 -0400
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wHyHl-00077C-EA; Wed, 29 Apr 2026 02:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1777443622; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=wpsQePTv0btTrCLyqE5kqL0DTPlWHThu8xlylHlpxhs=;
 b=qaPq+dntt/OqqMDlomsSmPYNpKpsz92jXSMAVhfgA9RkUdTD1Qlkr3uY9LHJeBrAwsTx3Iv8pJ7rRatNz1hg/h/g6pn1VDjvPCLKYaPQBBCqQ+adT74wh1NpPeb3ce3VMohbWSN07MfQy1plImPz2qzHWkn4/2ADqWcujlUI4ro=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0X1wRJXH_1777443612; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X1wRJXH_1777443612 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 29 Apr 2026 14:20:22 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, qemu-block@nongnu.org
Subject: [PATCH 1/3] qom/object: merge double hash table traversal in
 object_property_del_child
Date: Wed, 29 Apr 2026 14:20:02 +0800
Message-ID: <20260429062004.36582-2-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260429062004.36582-1-guobin@linux.alibaba.com>
References: <20260429062004.36582-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

object_property_del_child() previously performed two full iterations
over obj->properties: the first to find the matching child property and
call its release callback, the second to find the same property again
and remove it from the hash table.

Merge the two loops into one: when the matching property is found, call
the release callback and immediately remove the entry via
g_hash_table_iter_remove(), then break.  This halves the number of hash
table operations in the common case and avoids the redundant second scan.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 qom/object.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index f981e27044..9c0e8dfd02 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -629,13 +629,6 @@ static void object_property_del_child(Object *obj, Object *child)
                 prop->release(obj, prop->name, prop->opaque);
                 prop->release = NULL;
             }
-            break;
-        }
-    }
-    g_hash_table_iter_init(&iter, obj->properties);
-    while (g_hash_table_iter_next(&iter, &key, &value)) {
-        prop = value;
-        if (object_property_is_child(prop) && prop->opaque == child) {
             g_hash_table_iter_remove(&iter);
             break;
         }
-- 
2.50.1 (Apple Git-155)


