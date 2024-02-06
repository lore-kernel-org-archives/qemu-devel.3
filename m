Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96E1C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 19:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXQm5-0008Iw-M7; Tue, 06 Feb 2024 14:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rXQm4-0008IR-BT
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 14:06:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rXQm2-0000fM-Tz
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 14:06:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707246386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WHMeE1cx5qVWPE8IMyaGV8IfYtxBOS9Ntd4W17upN5Y=;
 b=DKr7hdUleWFitszh/rl0DZrvEUB7AbtLK8wGWVk+BMGbV9qN4DGo4SEsjBmImVM07gk3+5
 ZzMUpstiCYlrcQD++RktfHelVrtbZruwR+3lf80vi7sIcIjRkgyLNIdDRrfWn9SN7tD3so
 RRBQ7O0KTVURBlRBS6H2slI9JMgaz2k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-iUrt1BmMO6alqfTzoSqs2g-1; Tue,
 06 Feb 2024 14:06:19 -0500
X-MC-Unique: iUrt1BmMO6alqfTzoSqs2g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0792038300B9;
 Tue,  6 Feb 2024 19:06:18 +0000 (UTC)
Received: from localhost (unknown [10.39.192.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09D4DC07F51;
 Tue,  6 Feb 2024 19:06:16 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 2/5] virtio-blk: clarify that there is at least 1 virtqueue
Date: Tue,  6 Feb 2024 14:06:07 -0500
Message-ID: <20240206190610.107963-3-stefanha@redhat.com>
In-Reply-To: <20240206190610.107963-1-stefanha@redhat.com>
References: <20240206190610.107963-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

It is not possible to instantiate a virtio-blk device with 0 virtqueues.
The following check is located in ->realize():

  if (!conf->num_queues) {
      error_setg(errp, "num-queues property must be larger than 0");
      return;
  }

Later on we access s->vq_aio_context[0] under the assumption that there
is as least one virtqueue. Hanna Czenczek <hreitz@redhat.com> noted that
it would help to show that the array index is already valid.

Add an assertion to document that s->vq_aio_context[0] is always
safe...and catch future code changes that break this assumption.

Suggested-by: Hanna Czenczek <hreitz@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 6e3e3a23ee..e430ba583c 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1824,6 +1824,7 @@ static int virtio_blk_start_ioeventfd(VirtIODevice *vdev)
      * Try to change the AioContext so that block jobs and other operations can
      * co-locate their activity in the same AioContext. If it fails, nevermind.
      */
+    assert(nvqs > 0); /* enforced during ->realize() */
     r = blk_set_aio_context(s->conf.conf.blk, s->vq_aio_context[0],
                             &local_err);
     if (r < 0) {
-- 
2.43.0


