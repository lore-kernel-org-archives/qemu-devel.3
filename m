Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F609C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 03:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXulS-0001ej-Lo; Wed, 07 Feb 2024 22:07:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXukb-0006wB-UG
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:07:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXuka-0004R5-5a
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707361615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bqdspIyEEHDphJ+ZT5r7uaPRH0LLxzv8NL2MWnHp1Hw=;
 b=YK4CliYHJI8AyWssaQkH1LL/Oo02oUMMoNcy+Anx2Arx025G4XjuX967Llb9dTyYryi2bV
 dYM7tJUStBHjw+xa2UhzrEaWMzoDX8uWTp0Yc6a20vlLj6KAoiXlESj950uBHP3UKa3AZ5
 k/LxwoCmvUi/t3sz8nRFVPSEI9dLSWo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-vQ-EpK2HPpuO54zLtxAcGQ-1; Wed, 07 Feb 2024 22:06:52 -0500
X-MC-Unique: vQ-EpK2HPpuO54zLtxAcGQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8AFB5185A784;
 Thu,  8 Feb 2024 03:06:51 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 91B0F492BC7;
 Thu,  8 Feb 2024 03:06:48 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Avihai Horon <avihaih@nvidia.com>, qemu-stable <qemu-stable@nongnu.org>
Subject: [PULL 25/34] migration: Fix logic of channels and transport
 compatibility check
Date: Thu,  8 Feb 2024 11:05:19 +0800
Message-ID: <20240208030528.368214-26-peterx@redhat.com>
In-Reply-To: <20240208030528.368214-1-peterx@redhat.com>
References: <20240208030528.368214-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Avihai Horon <avihaih@nvidia.com>

The commit in the fixes line mistakenly modified the channels and
transport compatibility check logic so it now checks multi-channel
support only for socket transport type.

Thus, running multifd migration using a transport other than socket that
is incompatible with multi-channels (such as "exec") would lead to a
segmentation fault instead of an error message.
For example:
  (qemu) migrate_set_capability multifd on
  (qemu) migrate -d "exec:cat > /tmp/vm_state"
  Segmentation fault (core dumped)

Fix it by checking multi-channel compatibility for all transport types.

Cc: qemu-stable <qemu-stable@nongnu.org>
Fixes: d95533e1cdcc ("migration: modify migration_channels_and_uri_compatible() for new QAPI syntax")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240125162528.7552-2-avihaih@nvidia.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 9b695685b1..b427be8762 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -129,11 +129,17 @@ static bool migration_needs_multiple_sockets(void)
     return migrate_multifd() || migrate_postcopy_preempt();
 }
 
-static bool transport_supports_multi_channels(SocketAddress *saddr)
+static bool transport_supports_multi_channels(MigrationAddress *addr)
 {
-    return saddr->type == SOCKET_ADDRESS_TYPE_INET ||
-           saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
-           saddr->type == SOCKET_ADDRESS_TYPE_VSOCK;
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &addr->u.socket;
+
+        return saddr->type == SOCKET_ADDRESS_TYPE_INET ||
+               saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
+               saddr->type == SOCKET_ADDRESS_TYPE_VSOCK;
+    }
+
+    return false;
 }
 
 static bool
@@ -141,8 +147,7 @@ migration_channels_and_transport_compatible(MigrationAddress *addr,
                                             Error **errp)
 {
     if (migration_needs_multiple_sockets() &&
-        (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) &&
-        !transport_supports_multi_channels(&addr->u.socket)) {
+        !transport_supports_multi_channels(addr)) {
         error_setg(errp, "Migration requires multi-channel URIs (e.g. tcp)");
         return false;
     }
-- 
2.43.0


