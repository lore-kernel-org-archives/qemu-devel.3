Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83522C54F40
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 09:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnZ0b-0000mZ-8k; Sat, 25 Jul 2026 05:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wnZ0T-0000iC-6O
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 05:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wnZ0R-0004V5-7j
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 05:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784972958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w9P2W4JHcW8gHi5z7gIDq25C1oCq7ThbiMkHET5NoPI=;
 b=V7leAz4pYgh+va8D7FfyV98s9On6TbY3ttlPUl84273J2uoSxO4InKy6E6w7Y5LhYV4qVH
 6tTEkeRycxDoi84E6xKXTA9OO0vrNoN6fPssofHhQ1ixdsBPWHofTSm6C2ihTBaK0CwYWf
 ITD/TU/BJsQ93NKbAVrew5hYzCDELjc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-BrmrMhXXN0i2jceZC3B3Mw-1; Sat,
 25 Jul 2026 05:49:13 -0400
X-MC-Unique: BrmrMhXXN0i2jceZC3B3Mw-1
X-Mimecast-MFC-AGG-ID: BrmrMhXXN0i2jceZC3B3Mw_1784972951
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8249419560BF; Sat, 25 Jul 2026 09:49:11 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D7A2B15AD; Sat, 25 Jul 2026 09:49:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Jul 2026 13:48:36 +0400
Subject: [PATCH v2 5/8] qcow2: remove invalid qcow2_check_refcounts calls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260725-co-v2-5-d3552ddb3931@redhat.com>
References: <20260725-co-v2-0-d3552ddb3931@redhat.com>
In-Reply-To: <20260725-co-v2-0-d3552ddb3931@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 John Snow <jsnow@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Fam Zheng <fam@euphon.net>, "Denis V. Lunev" <den@openvz.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 xen-devel@lists.xenproject.org, Li Zhijian <lizhijian@fujitsu.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=OO6u4jc/oE85ygnu76Eff+BQJm9qaSylokab/TrhS7g=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZIZzfPevyXGRv+xnq8r35PAUtTMrTUb4NAqe+
 hkubEX4UVGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamSGcwAKCRDa6OEJdZac
 5aAKD/wN53cO9tA13mklf71VFEHO7NQPXDCZjyms/h620vuCWbhJgtsXdTs/vauCTj6QNUvEbur
 fuKl3k2FkArKGYeX7xE4xQEmNJGupnV3nGUeCvIYmGXf0fAJqwjXdF5fN60c+mZ8uVMPW5WjXRB
 sefOQhmb7hNT1u7G50hQo6Lywi1rAlAltWxCnf/j2yK2LyBHQCArIMzwM+tGfR63ImLvUVeCrHw
 FU3dbk5dCWNDXGYcNF71kJVvxiqCdLxVEiWbkEtNJHUU2JSh6malEhnFsjaKnz1V5ZIB2BmOCZj
 NJ5ds5WC3g+koW/4yh9pAajJo3MIWtkpKA4hnm3RT7MpJ3vngIkbT6Qk2u7EjfvNLqInYHWWQfo
 lt40V1rdSWT5tY6bwj3Gou/6P3xwFWZSk7/ko0C3XvgaW3mml7X9oVls5rGXc65kBE4jtQB3va8
 RxD9Cio/knC3ua+Brls+Rm33paasb73NYZdiaqXW3a0zk2DmK6l1y+G5lKQfGOW6bvUDv1yfNwB
 wrSOTxQXxj/Wy/oO2tTL6aVKdqJxMtBnSEo2gCtcfgC8xeXXA49wmMbOLq0s8RmQ8E47BcVzcn/
 EqOfZPC7iOFaoI1cyhfCAQBS7zyDXyhuv2kB1jV+/W/xKKMPQw6oLSHhUVx4+BNmDDsTO83NyvQ
 z3SBv86fYOVjKbA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


