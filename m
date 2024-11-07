Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BC8D5D67D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 18:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t96r0-0003D6-8K; Thu, 07 Nov 2024 13:03:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1t96qy-0003Ce-9O
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 13:03:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1t96qv-0003Uf-KY
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 13:03:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731002607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wp6P7rUNGA5bgLWyuR/b23ag0Pts4kImB1lsYsdSjfA=;
 b=DsNdl13nfRR2IIRums0VHUuFNF7LVL5d17VPRPqFnw5TqzY0gJ0J7YWl5Z6jAfuvDTyI1M
 s3M6Uu8VcX/J4A6hjYVQHFKQGDUCwBapr+4VuEl4QznWXPrfQpPuuKGCCshFwTOw4RU+Ao
 iSy9CERKRj3Krhlh+2t3ouMc7IaNHJs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-b0ldBbmDNVOfc99NG9nf_Q-1; Thu,
 07 Nov 2024 13:03:24 -0500
X-MC-Unique: b0ldBbmDNVOfc99NG9nf_Q-1
X-Mimecast-MFC-AGG-ID: b0ldBbmDNVOfc99NG9nf_Q
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A87DA1954B10
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2024 18:03:18 +0000 (UTC)
Received: from corp.redhat.com (unknown [10.39.192.96])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D712195607C; Thu,  7 Nov 2024 18:03:15 +0000 (UTC)
From: Dorinda Bassey <dbassey@redhat.com>
To: qemu-devel@nongnu.org
Cc: aesteve@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 Dorinda Bassey <dbassey@redhat.com>
Subject: [PATCH v2] virtio-dmabuf: Ensure UUID persistence for hash table
 insertion
Date: Thu,  7 Nov 2024 19:00:31 +0100
Message-ID: <20241107180309.1713601-1-dbassey@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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
memory space. The value is then inserted into the hash table
with this persistent UUID key to ensure that the key stored in
the hash table remains valid as long as the hash table entry
exists.

Fixes: faefdba847 ("hw/display: introduce virtio-dmabuf")

Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
---
 hw/display/virtio-dmabuf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
index 3dba4577ca7..5e0395be77c 100644
--- a/hw/display/virtio-dmabuf.c
+++ b/hw/display/virtio-dmabuf.c
@@ -35,11 +35,13 @@ static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject *value)
     if (resource_uuids == NULL) {
         resource_uuids = g_hash_table_new_full(qemu_uuid_hash,
                                                uuid_equal_func,
-                                               NULL,
+                                               g_free,
                                                g_free);
     }
     if (g_hash_table_lookup(resource_uuids, uuid) == NULL) {
-        g_hash_table_insert(resource_uuids, uuid, value);
+        g_hash_table_insert(resource_uuids,
+                            g_memdup2(uuid, sizeof(*uuid)),
+                            value);
     } else {
         result = false;
     }
-- 
2.47.0


