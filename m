Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB96CD11DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 10:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpmtz-0003N6-97; Thu, 28 Mar 2024 06:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rpmty-0003I3-9m
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rpmtw-0007lD-U0
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711621348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=brNznkesgm5sM6cu00vVLhBhhfdPMXzqKQMxNztlRXs=;
 b=g+3tbAEE1eQXlUgKyfL/aaQ4AcqKEy7xuB49uRwLhJs8U7PIUcn/zmgJyzdlc4MFBf6W/k
 ju3bEpEsr8Wb+tUpLxfse0Ovib68IWKWTbb2eNiupmOyXm78DjobkzJvsPDzS87cgXNTen
 sdpXYuW49QhEU/x7dTovFttVSPWVQTU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-LfCy9EUyP5i1D_F6jCjsCg-1; Thu,
 28 Mar 2024 06:22:23 -0400
X-MC-Unique: LfCy9EUyP5i1D_F6jCjsCg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8021E29AC032;
 Thu, 28 Mar 2024 10:22:22 +0000 (UTC)
Received: from localhost (unknown [10.39.208.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0CAC492BD0;
 Thu, 28 Mar 2024 10:22:20 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 John Snow <jsnow@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Bin Meng <bin.meng@windriver.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 08/19] hw/vhost-scsi: fix -Werror=maybe-uninitialized
Date: Thu, 28 Mar 2024 14:20:41 +0400
Message-ID: <20240328102052.3499331-9-marcandre.lureau@redhat.com>
In-Reply-To: <20240328102052.3499331-1-marcandre.lureau@redhat.com>
References: <20240328102052.3499331-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

../hw/scsi/vhost-scsi.c:173:12: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]

It can be reached when num_queues=0. It probably doesn't make much sense
to instantiate a vhost-scsi with 0 IO queues though. For now, make
vhost_scsi_set_workers() return success/0 anyway, when no workers have
been setup.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/scsi/vhost-scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index ae26bc19a4..5b066df4f7 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -170,7 +170,7 @@ static int vhost_scsi_set_workers(VHostSCSICommon *vsc, bool per_virtqueue)
     struct vhost_dev *dev = &vsc->dev;
     struct vhost_vring_worker vq_worker;
     struct vhost_worker_state worker;
-    int i, ret;
+    int i, ret = 0;
 
     /* Use default worker */
     if (!per_virtqueue || dev->nvqs == VHOST_SCSI_VQ_NUM_FIXED + 1) {
-- 
2.44.0


