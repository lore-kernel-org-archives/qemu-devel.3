Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3F2C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlirx-0004H0-Rg; Mon, 20 Jul 2026 03:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wlirw-0004FG-1z
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:56:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wliru-0006nA-Jq
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784534213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QtMvLnVwqMzsmDla/+s5l4nRkQgIhL5LT1ivzwU06OA=;
 b=eh8sQpmSrRV810ueaHX0xKDWs6pvdu8cJh7rokIkkKJn7HZCMGzsH61pzUcvlPz+9G3qZB
 mDJFtHGW6bmmQUNVssBLJkHsxwSr6/iykM304LEdbGkcScRAmRceFPOLjE9/mdYHzJm8hI
 OmaxwgX5ccqzX8OKBtuVN1iTF7Phbvw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-a-9sm84FOP-1Id4qXsae5A-1; Mon,
 20 Jul 2026 03:56:49 -0400
X-MC-Unique: a-9sm84FOP-1Id4qXsae5A-1
X-Mimecast-MFC-AGG-ID: a-9sm84FOP-1Id4qXsae5A_1784534207
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D017195C27E; Mon, 20 Jul 2026 07:56:47 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 906B5300019F; Mon, 20 Jul 2026 07:56:45 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 20 Jul 2026 11:55:37 +0400
Subject: [PATCH 8/8] migration/rdma: annotate and simplify wait_comp_channel()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260720-co-v1-8-fabb4db3c204@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1578;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=oJIZjL5v3qPuEfmBmoADXHdeUtnH1fO9aSt78aaOTQA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqXdSJmwU3fDMJVOh8NuPQiJP+1ImSwWEZ2LEnz
 qyx/VYPaPuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCal3UiQAKCRDa6OEJdZac
 5QRXD/9BDWYERq9hLRl+MFCCSV5uIL8qHuaXkYPzavZXz7FtCWheLKyyvu7gNq789M2FyuM6L/U
 SmN25PuDKXTlF0LLOKYvy6NCVOmVtdB7O4X9Hr/527c79DSfow3UbQOHHLIPnWy9R7s6YKriGsc
 EhBrRia46wFO7TjPaDdYpX/fKWOpgm2Fushi3gMbtZcac+5WWg0SkECprjBV0b+OXThYzlzpe9o
 N/kxmJMzJOj5BSePFncuxHyN6VlkssZrgd4MhWf0PthYCSnetE1WDSMPBCv2644cXFk1EUdkBPM
 pouk07hjPvPgyI8GRY8cKNn/j3crriZPAMd9obZ3+nI34KECpH9aINhlRs7jMl1mQkq0NU3eDug
 9omDTtOEUTZYs9U4LGSptWwmVklM12krTzNUeuabXyG6EA9tcBuIo2d+GhtOvgrXRO2IfGkz1Mj
 c7+oQjf8y0ZuQYAkw0rTQQ9CXjh+qaNGv6hTHg5hHhmbEwTGSZraj1RzRNvu4s1A5qtSAQkRmGW
 frqDSIk1ncj1UZ1Cz7aWKNP11TsjvC7DqePEvURkQvZCzTLg5IZiD5Aq+XfQiJqcF7jIv7oeo6y
 z4BpSH8CNBkAYoPujDpgvdtJ4Sk3Dx4rPgNrKoXeg9mOq7ONID/yFe4vKn7XQFs3ZxaJeZ7hZ1f
 WBJ+qu9IhQiLhRA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

The function calls yield_until_fd_readable() (coroutine_fn) when in
coroutine context, and polls with qemu_poll_ns() otherwise.

Replace the migration-state proxy check with qemu_in_coroutine(),
which directly tests what matters.

Fixes: 2da776db4846 ("rdma: core logic")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 migration/rdma.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 3e37a1d4401..438419d1894 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1348,17 +1348,13 @@ static int qemu_rdma_poll(RDMAContext *rdma, struct ibv_cq *cq,
 /* Wait for activity on the completion channel.
  * Returns 0 on success, none-0 on error.
  */
-static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
-                                       struct ibv_comp_channel *comp_channel)
+static int coroutine_mixed_fn
+qemu_rdma_wait_comp_channel(RDMAContext *rdma,
+                            struct ibv_comp_channel *comp_channel)
 {
     struct rdma_cm_event *cm_event;
 
-    /*
-     * Coroutine doesn't start until migration_fd_process_incoming()
-     * so don't yield unless we know we're running inside of a coroutine.
-     */
-    if (rdma->migration_started_on_destination &&
-        migration_incoming_get_current()->state == MIGRATION_STATUS_ACTIVE) {
+    if (qemu_in_coroutine()) {
         yield_until_fd_readable(comp_channel->fd);
     } else {
         /* This is the source side, we're in a separate thread

-- 
2.55.0


