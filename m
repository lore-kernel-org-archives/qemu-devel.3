Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E923FC53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJu6-0003ee-Av; Mon, 27 Jul 2026 07:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJu3-0003Xu-V3
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:53:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJu2-000448-I0
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785153229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3otxHHzF848aWH4w40n6EBe3Am3b5Xd5NRbN2eJgj1c=;
 b=ht7pUOhHWnZhFaQGuq4RckyYgDc2PxZbKoVxyhriijqTZXI+NIvRhqxaMV6uHLU0Tlbsb4
 Q8GneFHeSQhVNxF38jtF9o78uD1bXISh/3o7cbzmALPzWqrtOf+r7LiY+hWbjE21e8pBB1
 a1++HXWSgxIq0lcVBesr70YuqSwL/mQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-o6EfhtJnOzyPJvRzVXbY4g-1; Mon,
 27 Jul 2026 07:53:43 -0400
X-MC-Unique: o6EfhtJnOzyPJvRzVXbY4g-1
X-Mimecast-MFC-AGG-ID: o6EfhtJnOzyPJvRzVXbY4g_1785153222
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60A341956056; Mon, 27 Jul 2026 11:53:42 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3BBE618001E1; Mon, 27 Jul 2026 11:53:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 15:51:32 +0400
Subject: [GIT PULL 23/23] migration/rdma: annotate and simplify
 wait_comp_channel()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix-v1-23-ca3fa3851347@redhat.com>
References: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
In-Reply-To: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Li Zhijian <lizhijian@fujitsu.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1623;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2C5ZqBaQBwSshXxXMaaT5VaLMkO28qyCe2lqnv2+Heg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZ0ZAIQzm3kTQNC9rWFyTB1HJNrd6AgNFE2EUz
 1zMv2gd1Q2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamdGQAAKCRDa6OEJdZac
 5cYWD/9oQ1KhBgsluzazVr8IK3k15uxTcBqtPzz2rVuPl8xFStnREmPbVfPSFgllO7DMCoNfnG2
 nD4GScVszxzTtRlRuxGxNnhqa5ehvdTBpNAKocpoV3l3Qzvaho+bWYlOQKkhyw+FTqQBMwFdzat
 8nHZiLhHZYo8ek/zN/t2vVkb41qxJIK+3OxX8WlivniI+7HoNe74wk92TgGxIlmu+2Fo/Dk7bxZ
 9iSrrx5F5wS68/1QAncTlr+/zUpanX1QJQAXrSMTMW3VbPxlsJg8yToSVtBqVj17TAmHmCw9LGA
 ysAb8HMc1TP3OjQduMaCJSxv9DOuwdgxedNmfQMB7mUyVLw74VcPEe1GHsDvRI7cTS7a4zZ0SUz
 ah0Xhg/efsYseyXJz2kvQG6mK0Ol91GI4GG8akQoKXAT2zRCdx9XcSe8MVHn6a/vk1pzR/d/IRx
 nqNlRbVLeiWWOt3XHYCG+uBzK8eX/dyrDC9PA0sLzJ1dcFOL8QxGVyNOJ+6+gHaWN8OjRqp4A6Y
 KW/MnXYSBsbzN4m1rMcbTrRflS6ib64deCK2jHDo/Q2CWwEu5xDYco0Dqdy+v720x3y1IzZjB3N
 3KE4kifKdnvpovW1iGdtw0QIB/PxIlSNpiGNnrZMO161lN/hVb4xw5zXUpW+O3lZ+Xgwzxbrxol
 2NUNHhdm3XeEVYw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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


