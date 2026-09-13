Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCDFC88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 10:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5hgK-0005he-1t; Sun, 13 Sep 2026 06:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hgI-0005hM-HQ
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:43:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hgH-0008Hi-0H
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789296208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7vqTlefAxjAaewqSyIMELLJSZMDNGtwP6wkFMJUuz3E=;
 b=AkPdNbQMCJ0PBOqszndZDjBH959UmU17WHmj9A4o69YQc0DiH9kV05xU1+qH5p4vVs/Cha
 oKC4AWMiI0qXzPTSpe2n74QMfZFxtPWz7e73xrHDHuZ3RWMg39nqhD8O3BInM9Wjk+Xgkw
 /CwggtDimy2YDdIFqQxuNGa104dmoO4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-Lk8Iqx59NbSPlufZ5Lsg0w-1; Sun,
 13 Sep 2026 06:43:26 -0400
X-MC-Unique: Lk8Iqx59NbSPlufZ5Lsg0w-1
X-Mimecast-MFC-AGG-ID: Lk8Iqx59NbSPlufZ5Lsg0w_1789296206
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0B351802154
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 10:43:25 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C428918004D4; Sun, 13 Sep 2026 10:43:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 13 Sep 2026 14:41:29 +0400
Subject: [GIT PULL 11/14] vhost-user-gpu: validate command buffer size in
 submit_3d
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260913-ui-v1-11-7a8d89d0423a@redhat.com>
References: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
In-Reply-To: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2181;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=eCgsOIk/89OdUDCfj2vNyKj3/4yi2096UmPlVIK4C9s=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpn4jcwPihWQbwOaegZcvigN2fMFN3habKWKdk
 YGPmOKM1FeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqZ+IwAKCRDa6OEJdZac
 5WAcD/457qIj9a7qfSyYRHpk679LtcZL9DVFVJQ+ofkFNA7MUujv/n8kA5zigi1j5hSflvS9Kry
 9ULaXhS5ekkOgzOcrX+H7Rn7qVi7dUkjNXZXA2RdiNMSq0qMWo6C/PmCiS+vRJT4mNTLaWv1jLH
 1/loYKpdqDHa778calIAus2/ozrxoPlG0JJDT9mUR3Sph73fgPqfy+MHtneSLEeNZt7zrSTd+on
 JgWMthiyUza14PxrknkGG7KZ3tw8nUNmaJZivZNyt2C1oOvlaW5exsfonG1m7y3EST8BwY6T2Ts
 Ew21hvsAIQXvR06AcpftkjPFI8rrU9Y0oLFAuL93z/oXeifQGZzEh3wzbTYaJ+sSrVTTgGFHJiY
 PJz6cYxhOYRW10MwHVW+IcOKURKwBI4tQyH5NnoP0IwFZ7iYbybIYiHBRPTnl+mCnJnBy2upyny
 AS/y0IEEapXvXuas5V+EGR+VhPS1zrZB89Z05UVIjjN3zeXCCnnfwyRh/C1uBXbRRmI5c4bWklY
 7uQd6XR2VjImu2IOQjRV3ckbcOqLv/5+NTcNRnjh1FclTeVJ9+QpDKUXOVfWryLiFPHBJ5PfNTC
 afN/QoteXtpxmzjpbden8Geb2UvRhKo+Ac/jdZp8iNemmyyTbG2ndYJUZ4zXAh7Z8CvN7YBn5zO
 +1EjVBw4Eh/0Zhw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

virgl_cmd_submit_3d() passes the guest-controlled cs.size directly to
g_malloc() without any bounds check. A malicious guest can set this
field to an arbitrarily large value (up to 4GB), causing an OOM abort
that crashes the vhost-user-gpu daemon.

Validate cs.size against the actual descriptor payload size before
allocating, rejecting values that exceed what the virtqueue entry
can carry.

Fixes: d52c454aadc ("contrib: add vhost-user-gpu")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3776
Reported-by: admin@fluentlogic.org
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260713125431.107278-1-marcandre.lureau@redhat.com>
Message-ID: <67f10fb88d3c75da3ba7fa5a37f7d6bcfcf3ce9e.1789071042.git.mst@redhat.com>
---
 contrib/vhost-user-gpu/virgl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virgl.c
index 5a5f9f14c80c..0ef4b9d8c903 100644
--- a/contrib/vhost-user-gpu/virgl.c
+++ b/contrib/vhost-user-gpu/virgl.c
@@ -209,20 +209,24 @@ virgl_cmd_submit_3d(VuGpu *g,
                     struct virtio_gpu_ctrl_command *cmd)
 {
     struct virtio_gpu_cmd_submit cs;
+    size_t iov_len;
     void *buf;
     size_t s;
 
     VUGPU_FILL_CMD(cs);
 
-    if (cs.size > VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE) {
-        g_critical("%s: command buffer too large (%u)",
-                   __func__, cs.size);
+    iov_len = iov_size(cmd->elem.out_sg, cmd->elem.out_num);
+    if (cs.size == 0 || iov_len < sizeof(cs) ||
+        cs.size > iov_len - sizeof(cs) ||
+        cs.size > VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE) {
+        g_critical("%s: size out of range (%u/%zu)",
+                   __func__, cs.size, iov_len);
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
         return;
     }
 
     buf = g_try_malloc(cs.size);
-    if (!buf && cs.size) {
+    if (!buf) {
         cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
         return;
     }

-- 
2.55.0.543.g5ebe2ebe4ea8


