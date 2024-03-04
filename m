Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE9EC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgx7H-0001U2-8Z; Sun, 03 Mar 2024 20:27:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx7A-0001Pt-KQ
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:27:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx79-0002LU-3v
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709515654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZJ+HNeqglJdMcQsTtamaGE7iHX66VkDcR8uP6a0Bcpg=;
 b=OaPLIR6jErvEhKcb9zgKK0otLfM9lvu24m56azKM64qsqAJJU5/RiXR3q2aKisIdcopqV9
 uxNX1CulsdI0FGuutpyTO44jfQXRac5hRWLhe0n3UYIqMLdJYT+VzA+JlnSl4Tqhgx1vth
 g3v60bQBfc4RCFe5YvZvxlVyWQZaib4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-oHHMq0p9OvWdJ9_Ez8J-eQ-1; Sun, 03 Mar 2024 20:27:30 -0500
X-MC-Unique: oHHMq0p9OvWdJ9_Ez8J-eQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 785CF85A588;
 Mon,  4 Mar 2024 01:27:30 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F304540C6EBA;
 Mon,  4 Mar 2024 01:27:26 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 11/27] migration: Add mapped-ram URI compatibility check
Date: Mon,  4 Mar 2024 09:26:18 +0800
Message-ID: <20240304012634.95520-12-peterx@redhat.com>
In-Reply-To: <20240304012634.95520-1-peterx@redhat.com>
References: <20240304012634.95520-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

The mapped-ram migration format needs a channel that supports seeking
to be able to write each page to an arbitrary offset in the migration
stream.

Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240229153017.2221-9-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 69f68f940d..2669600d25 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -148,10 +148,39 @@ static bool transport_supports_multi_channels(MigrationAddress *addr)
     return false;
 }
 
+static bool migration_needs_seekable_channel(void)
+{
+    return migrate_mapped_ram();
+}
+
+static bool transport_supports_seeking(MigrationAddress *addr)
+{
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
+        return true;
+    }
+
+    /*
+     * At this point, the user might not yet have passed the file
+     * descriptor to QEMU, so we cannot know for sure whether it
+     * refers to a plain file or a socket. Let it through anyway.
+     */
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        return addr->u.socket.type == SOCKET_ADDRESS_TYPE_FD;
+    }
+
+    return false;
+}
+
 static bool
 migration_channels_and_transport_compatible(MigrationAddress *addr,
                                             Error **errp)
 {
+    if (migration_needs_seekable_channel() &&
+        !transport_supports_seeking(addr)) {
+        error_setg(errp, "Migration requires seekable transport (e.g. file)");
+        return false;
+    }
+
     if (migration_needs_multiple_sockets() &&
         !transport_supports_multi_channels(addr)) {
         error_setg(errp, "Migration requires multi-channel URIs (e.g. tcp)");
-- 
2.44.0


