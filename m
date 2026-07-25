Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AE6C53209
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 09:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnZ0x-0001G1-1d; Sat, 25 Jul 2026 05:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wnZ0o-00011t-Bk
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 05:49:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wnZ0k-0004Xg-SY
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 05:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784972978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3otxHHzF848aWH4w40n6EBe3Am3b5Xd5NRbN2eJgj1c=;
 b=ARnfV8+vl5WJEHr7oCrRFvGndsu2H7RPks8ZokdpREM8nRoMR/mW8qU8PB3AnTyatV/DCQ
 rBRo2A011wf3smPC+lrYJod1NlqGp4RzVLifjOXkxH8B2VICXat4kujAlUwtvCL9bZAzEM
 cKeNEuZj0t/sXXVUAs5YUsh7FwbPeY4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-tlpeUg09MbS26wXvY2u7bA-1; Sat,
 25 Jul 2026 05:49:33 -0400
X-MC-Unique: tlpeUg09MbS26wXvY2u7bA-1
X-Mimecast-MFC-AGG-ID: tlpeUg09MbS26wXvY2u7bA_1784972971
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66BC41800BE2; Sat, 25 Jul 2026 09:49:31 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D426E18001DA; Sat, 25 Jul 2026 09:49:27 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Jul 2026 13:48:39 +0400
Subject: [PATCH v2 8/8] migration/rdma: annotate and simplify
 wait_comp_channel()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260725-co-v2-8-d3552ddb3931@redhat.com>
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1623;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2C5ZqBaQBwSshXxXMaaT5VaLMkO28qyCe2lqnv2+Heg=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGpkhnOgGsGaEW7fYQnX0R7hzSkmXg+bUb7nkK4SHhe9sZ9mD
 IkCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqZIZzAAoJENro4Ql1lpzl2WAP/AlG
 8U2u9t+z/ghM4iddfUBBNQCKNNC94atpjYBR7zEtMmEinsybH1CBGtm0uRRF21C/Pl36mCq99Oh
 LikhyMG6+0EH4lEGC2CSC/HD+SiYvSScNx32vMK1FXF2VWtPpZfjNKcDrilTVOpJBdE4WMyEHgo
 Hyjh0m9/kFgISoiAA04TY9YNB4798/imFwDCRNAmfwqRYs3CDQ5JkZRUA7nAo2o7gJfmPSYW9Pf
 PAJoDnwtwHD1tuocvj/G4/lQV90ohuZXkRBSbHjwsLhEZmhZylsnFkeX2ja0SjKeUjbrlYm+iNE
 CdYyQw7HCXZtAVYN7+BEnvv/RqLHHYNXNC00CzfmGuERxgGw/2gcFz6/nAYxbM6P1VrOsefRJqs
 hwmXCzX4AIrSYKeOsaXVQUSf3ZHg68HLzpn9Q/ZQhS+TerMfXo6bmSvg/gO27j2m1SqRgUR7/nx
 ud+F9xVyvWhFQr0rO/HRFPndoVtmWuCXzlUr7LAwOPK2SGU502dhXVbLz1VzIC/HzJ1vE5hbzfR
 iUYVQFA4wZJ0TFeLdD0k7RR3IErhEFiG/bRUxHVdBIownfSeLbwlJyZa6zP2CYaD9oSe4PPtYCE
 I6z7TqtrC0pCcDJjYyuF0/WnxguSZ1LTzgxq1wDBgUv00yB3KFZ44rk7ExMaFtSVGHMoWma7jp+
 GYfAm
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 migration/rdma.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 3e37a1d44013..438419d18943 100644
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


