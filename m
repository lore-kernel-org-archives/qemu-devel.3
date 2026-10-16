Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECACCCA46B
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHeUD-00019c-UY; Fri, 16 Oct 2026 05:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHeTv-0000xw-BU
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:44:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHeTs-0007Kl-OK
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792143843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tq/DSFEuCzHUHQXq/8JiBcaPIiFnjF8nfhr7UakpoOM=;
 b=i54hEZcDnb9TBW53BAvCIo0bYNg3nI5UQTIhpPEace7FrFM3qDKv3y05e1oTPxd3eaarzq
 5ENc7RqTt9dqtgfvhIRY/P8MQpgX7KVhYbRNLip5jsxoTC5KMcvWNi1tY6eGTqHDzG8Nla
 XSerSGy1JK1Ph3i53UEmTCU1MhNLHrc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-ErqngBeUNFu5W1n6JK8Jnw-1; Fri,
 16 Oct 2026 09:44:01 +0000
X-MC-Unique: ErqngBeUNFu5W1n6JK8Jnw-1
X-Mimecast-MFC-AGG-ID: ErqngBeUNFu5W1n6JK8Jnw_1792143841
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D650A180063A; Fri, 16 Oct 2026 09:44:00 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2D6B03000B4E; Fri, 16 Oct 2026 09:43:58 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 5/8] Revert "migration: activate TLS thread safety workaround"
Date: Fri, 16 Oct 2026 10:43:45 +0100
Message-ID: <20261016094348.2616374-6-berrange@redhat.com>
In-Reply-To: <20261016094348.2616374-1-berrange@redhat.com>
References: <20261016094348.2616374-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

This reverts commit eb3618e9e259ef93f5a1a76867fbccae540fcd61.

The workaround for the GNUTLS bug was not correct and it was
decided to rely on GNUTLS being patched by distros instead,
or users manually disabling use of the problematic ciphers.

Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 migration/tls.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/migration/tls.c b/migration/tls.c
index 89ba52de02a..b7914831923 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -88,10 +88,6 @@ void migration_tls_channel_process_incoming(QIOChannel *ioc, Error **errp)
 
     trace_migration_tls_incoming_handshake_start();
     qio_channel_set_name(QIO_CHANNEL(tioc), "migration-tls-incoming");
-    if (migrate_postcopy_ram() || migrate_return_path()) {
-        qio_channel_set_feature(QIO_CHANNEL(tioc),
-                                QIO_CHANNEL_FEATURE_CONCURRENT_IO);
-    }
     qio_channel_tls_handshake(tioc,
                               migration_tls_incoming_handshake,
                               NULL,
@@ -142,11 +138,6 @@ void migration_tls_channel_connect(MigrationState *s, QIOChannel *ioc,
 
     trace_migration_tls_outgoing_handshake_start();
     qio_channel_set_name(QIO_CHANNEL(tioc), "migration-tls-outgoing");
-
-    if (migrate_postcopy_ram() || migrate_return_path()) {
-        qio_channel_set_feature(QIO_CHANNEL(tioc),
-                                QIO_CHANNEL_FEATURE_CONCURRENT_IO);
-    }
     qio_channel_tls_handshake(tioc,
                               migration_tls_outgoing_handshake,
                               s,
-- 
2.56.0


