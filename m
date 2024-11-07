Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE89CD4335A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 12:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t91zr-0003D6-4C; Thu, 07 Nov 2024 07:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1t91zn-0003Ci-0K
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:52:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1t91zk-00058p-1Q
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:52:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730983933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UWSbhocGk2G4x0WBfgN2OYC7v1K1AdCmmIxocVE3cG0=;
 b=ZjIJ2J1g9HkFUVOqnBPQ1WKLeXabHrsRmMTPcB6OgNIuRi5SFGIgUoSNfin8HqlobXIqaE
 int2DBcUh6XP224lSFB+PBkgzsJMCMJy5Q013AAGifng+A8jd9hT7g5RLzudBylwW+IHcP
 qv1ch8VjgYEoyadrhmMRLcTrqo7Z13M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-ut-v8x5RPIKSQkqw_U9O_w-1; Thu,
 07 Nov 2024 07:52:10 -0500
X-MC-Unique: ut-v8x5RPIKSQkqw_U9O_w-1
X-Mimecast-MFC-AGG-ID: ut-v8x5RPIKSQkqw_U9O_w
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C53EA1955BC9
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2024 12:52:09 +0000 (UTC)
Received: from corp.redhat.com (unknown [10.39.194.232])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82359195E480; Thu,  7 Nov 2024 12:52:07 +0000 (UTC)
From: Dorinda Bassey <dbassey@redhat.com>
To: qemu-devel@nongnu.org
Cc: aesteve@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 Dorinda Bassey <dbassey@redhat.com>
Subject: [PATCH] virtio-dmabuf: Ensure UUID persistence for hash table
 insertion
Date: Thu,  7 Nov 2024 13:52:01 +0100
Message-ID: <20241107125201.1640759-1-dbassey@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dbassey@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In `virtio_add_resource` function, the UUID used as a key for
`g_hash_table_insert` was temporary, which could lead to
invalid lookups when accessed later. This patch ensures that
the UUID remains valid by duplicating it into a newly allocated
memory space (persistent_uuid). The value is then inserted into
the hash table with this persistent UUID key to ensure that the
key stored in the hash table remains valid as long as the hash
table entry exists.

Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
---
 hw/display/virtio-dmabuf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
index 3dba4577ca7..4353970bc87 100644
--- a/hw/display/virtio-dmabuf.c
+++ b/hw/display/virtio-dmabuf.c
@@ -39,7 +39,12 @@ static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject *value)
                                                g_free);
     }
     if (g_hash_table_lookup(resource_uuids, uuid) == NULL) {
-        g_hash_table_insert(resource_uuids, uuid, value);
+        QemuUUID *persistent_uuid = g_memdup2(uuid, sizeof(QemuUUID));
+        if (persistent_uuid == NULL) {
+            result = false;
+        } else {
+            g_hash_table_insert(resource_uuids, persistent_uuid, value);
+        }
     } else {
         result = false;
     }
-- 
2.47.0


