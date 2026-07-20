Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DFFC44521
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlirk-0003pt-1n; Mon, 20 Jul 2026 03:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wlird-0003lx-Ts
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:56:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wlirc-0006lP-IP
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784534195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=utSN3mhE2is8KfGh3+2A1hakyZDW+n+VzyAtNi0hb8g=;
 b=hKlWoJS49i8hN2+vgCfreVyHKdbW3eZe6ZDcsy2jwlieleVfjKq2dGTIoRZsGkcvrcuZHx
 6oT8BompKwJH8c/rEahtKRbYO/JhJeb86fOgqqq3jzPCbkKtuUOhyuDrpGk9k84BrYR4k6
 1GiegvELj0yukDtDU3LYPCOp3raMTGE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-VB5yDZjfN5uX1YugrrQK3A-1; Mon,
 20 Jul 2026 03:56:32 -0400
X-MC-Unique: VB5yDZjfN5uX1YugrrQK3A-1
X-Mimecast-MFC-AGG-ID: VB5yDZjfN5uX1YugrrQK3A_1784534190
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BA841956057; Mon, 20 Jul 2026 07:56:30 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CAB5D195422C; Mon, 20 Jul 2026 07:56:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 20 Jul 2026 11:55:34 +0400
Subject: [PATCH 5/8] qcow2: remove invalid qcow2_check_refcounts calls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260720-co-v1-5-fabb4db3c204@redhat.com>
References: <20260720-co-v1-0-fabb4db3c204@redhat.com>
In-Reply-To: <20260720-co-v1-0-fabb4db3c204@redhat.com>
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1376;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=lDMiv5gtrBs/qk0wtWevIj1n6j5/hXAFjJohWIk2KvE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqXdSJagLQUSmkkLOieomfVHfQf3Yg/ieZBFMD8
 3E57Ey18IKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCal3UiQAKCRDa6OEJdZac
 5Tf5D/9/GombD/VzsbM/KN4eV+sUCeRbrgLneqzrGGiilG+mkvhBkAKEK+1hau1h1tarv0Mv+fi
 YGWaCug8JeZKiW3JeoHpClkZjYE+sFcimL+SI63Ll72CsTooTm/AOeql5HSar2LgPQ0sbYPVSGA
 7WMtKSnPtp41QS/N+ttHibR4oZwW58Qr2WEnD/lJbayNS7x8x+4tgriHicBsWDZGjgYKdJiGfYa
 wmvr9WSu4kPDrI3cbS8N2+wS8ZXNuDYZqASTRbFJo8F3cRnoVe9FU/2T5VBw+u6SdwBo6P+InXH
 jdCh8by7q49AYj81a3RXBBQUTo4E1KNL+PVwT9dyBVmbGKzodsz/vkap3GF6Io6/aSyU//VR+/e
 /KaT5LwRjm5CbajylToskjl4GTCviPaNAcj0h+N8rIjS82U5hE5OBHJGv1D5QxxgqhXkDZ7UW3R
 TqMXH81S2RikpKG8TzHNjfW5DbXapIKSPa9oBjAISx8dQeCbXd/0vRHBlep+su0x1l9wtmSVLy7
 r0RoGtOh/DO78mbFrmQwoBde6sepR2ORnDTz6L8UxVuq77tw+a+X8b2cp6kmdowBCpa9zALyDFW
 h0cgNPViS0D6em8jQPf/G6YYOHeF1yOjjHHQpsHCySPwKBT6gxGV4TE8tlv1PGhDqBdPM/GaWco
 0vMxckJnT25iCvQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/qcow2-snapshot.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 1e8dc48be1c..8453ad73d10 100644
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


