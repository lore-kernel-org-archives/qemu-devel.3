Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E76C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJtq-0002uL-18; Mon, 27 Jul 2026 07:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJto-0002tY-VT
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:53:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJtn-00042Y-Iy
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785153215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w9P2W4JHcW8gHi5z7gIDq25C1oCq7ThbiMkHET5NoPI=;
 b=XAACt6uQiilraPGtPcQfq4IiLwOoLEWNA6tlbwzpr3Q9p4dhi69ZIuC+CW6jaLmRw3CncS
 SUiM0ZDSwfqPH/Gh4rA0zDLqnwdov6r2r7CehvrZbeEaBjqkElW0gp0VicljKkNSLj/mk9
 elrCzYE1j4NlRYdlv56krl60xTMXpr4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-flTmZKK5O-yU4SrRfAWnrA-1; Mon,
 27 Jul 2026 07:53:32 -0400
X-MC-Unique: flTmZKK5O-yU4SrRfAWnrA-1
X-Mimecast-MFC-AGG-ID: flTmZKK5O-yU4SrRfAWnrA_1785153211
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29143195C27F; Mon, 27 Jul 2026 11:53:31 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA1521954B01; Mon, 27 Jul 2026 11:53:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 15:51:30 +0400
Subject: [GIT PULL 21/23] qcow2: remove invalid qcow2_check_refcounts calls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix-v1-21-ca3fa3851347@redhat.com>
References: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
In-Reply-To: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=OO6u4jc/oE85ygnu76Eff+BQJm9qaSylokab/TrhS7g=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZ0Y/VJqW0pBGn/XLy87cE7C+CmRbkAfc464rT
 ATUd1fk4j6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamdGPwAKCRDa6OEJdZac
 5dD2D/468ErqfxB6+H7woPdWXH6K4/sBdwOdEkuKVFfURcms4jXsYTixCz2O3rXXRAqyqOPnOWH
 eATcu9luqcY2ZkOVbzJeNV5MUBPiDQVxoICefWnkM4cCLjmTZU2WXWm685A40DI88z/XfLBFTp3
 J47nttxegS3t7ZbzEUNuDpT4s2mt4/0IJL/FlQChxlQQL3NfLvE89LKzWYqx8gDFgl0YeMPgrbV
 ebfZi7j0lKug6A5X4Xi1rhytu7SBaWPEZE3yOXnqobDN0XX7KQYcYdd9BA+Li4droWpsQjyQm8h
 wWcneqo9wjHcmX2BdnPt4HXL7pnoTJj9UspcydeVw1S+uFk1pw7GCAnb+GAX8I8n2rHmiCgakA8
 YP3q9HS5w0VJhiB4CJauZ4AQGV6lb0VgaZADh7lxJ0a2UR3uzvNtmhap/l3I3hIPW2xR3hOKZzs
 EoTu7mIBOrGjkhvSci/NWT9xVprrIQgpjiSzXo9XiTsqPKn1PPmIVQOFvLTi7ThmIkj28T0+GMn
 pXkXq79yfgk1uypSl1opS0FyryzBm3MIefSdE/ABm+QwEkQxx3nWq7oSlQP3n9GlOZz0OoV5qbA
 JXhT52LTfR8ETn0tnKf1x3s7zao27LplS+24XGmeK7sApvpwCwUD+F1zdWmP4+947m9P3JoyT+T
 S803MfjiBL6MV5A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Those DEBUG_ALLOC-guarded are dead code incorrectly calling coroutine fn
from non-coroutine. Remove it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Fixes: 70bacc44532 ("qcow2: mark more functions as coroutine_fns and  GRAPH_RDLOCK")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/qcow2-snapshot.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 1e8dc48be1c5..8453ad73d10f 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -740,12 +740,6 @@ int qcow2_snapshot_create(BlockDriverState *bs, QEMUSnapshotInfo *sn_info)
                           ROUND_UP(sn->vm_state_size, s->cluster_size),
                           QCOW2_DISCARD_NEVER, false);
 
-#ifdef DEBUG_ALLOC
-    {
-      BdrvCheckResult result = {0};
-      qcow2_check_refcounts(bs, &result, 0);
-    }
-#endif
     return 0;
 
 fail:
@@ -893,12 +887,6 @@ int qcow2_snapshot_goto(BlockDriverState *bs, const char *snapshot_id)
         goto fail;
     }
 
-#ifdef DEBUG_ALLOC
-    {
-        BdrvCheckResult result = {0};
-        qcow2_check_refcounts(bs, &result, 0);
-    }
-#endif
     return 0;
 
 fail:
@@ -975,12 +963,6 @@ int qcow2_snapshot_delete(BlockDriverState *bs,
         return ret;
     }
 
-#ifdef DEBUG_ALLOC
-    {
-        BdrvCheckResult result = {0};
-        qcow2_check_refcounts(bs, &result, 0);
-    }
-#endif
     return 0;
 }
 

-- 
2.55.0


