Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2259A606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=ZzXolSUN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp9I-00043S-H9; Fri, 27 Nov 2026 01:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp8F-0006x0-IW; Fri, 27 Nov 2026 01:08:31 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp8D-0006rx-JR; Fri, 27 Nov 2026 01:08:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759048; bh=lgAw5fJG5qtVmj2i3hb5K/pNS3xvEY/s+7UnBwbC1Gw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZzXolSUNgMiyDMx7FYB1V3GLyX+EYLwe8MLoOELzTxA7XVlZmFtKnYMYvVIUi3sAe
 o/Jy1aAuwSaoFoGLqw2n9VFfSkAqobk+07A1lgWpVhOf0Ct0JKpoXZkh+GAIjVYTGq
 jrK9/OgUKMffsC5Vk68Q7LyOOaH+lj6ojGwSLkCnQEWmih4zo+cQ47XmHzHgF9zGzv
 zW3YwSHCTr8QofWnsV4IODViCI+wLvPwvPmqPJ+8wD8b2NsODKrhnQv/8sgun/kcDK
 KY1vMpbHmVRY6R5G8MjiLy52nfiu4tn9g6ffDOSh+CzDwVI/loTfLavsz3XFkcWWrh
 eWpH6LP29Z8YQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 337F81EA36B;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 30F41469996;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 11A8BCF324; Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael S. Tsirkin <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 121/152] qapi/virtio: Restore backend features in
 x-query-virtio-status
Date: Fri, 27 Nov 2026 08:54:19 +0300
Message-ID: <20261127055709.39630-58-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Commit 1ee0bc0c9bf0 removed vhost_dev.backend_features and its
representation in VhostStatus. It also removed the assignment to
VirtioStatus.backend_features, although both that field and its source,
VirtIODevice.backend_features_ex, still exist.

The resulting NULL pointer causes HMP info virtio-status and QMP
x-query-virtio-status to crash. This affects virtio devices even without
an active vhost backend.

Restore the assignment from VirtIODevice.backend_features_ex.

Fixes: 1ee0bc0c9bf0 ("vhost: drop backend_features field")
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260922213210.1429435-3-vsementsov@yandex-team.ru>
(cherry picked from commit b501f21312d88ce8bfce08d91e9b3206cefec0a7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 57cc03828c2..36907180f7a 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -713,6 +713,8 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
                                                  vdev->guest_features_ex);
     status->host_features = qmp_decode_features(vdev->device_id,
                                                 vdev->host_features_ex);
+    status->backend_features = qmp_decode_features(vdev->device_id,
+                                                   vdev->backend_features_ex);
 
     switch (vdev->device_endian) {
     case VIRTIO_DEVICE_ENDIAN_LITTLE:
-- 
2.47.3


