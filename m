Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384F6C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqk7-0006VZ-9u; Mon, 21 Jul 2025 09:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1udqjs-0003Ul-Gk
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1udqjq-0007Xv-Ah
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753105167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zxkQrhTQ653SH73ji0uO8up7wP37NdVkOmI6hqPcbHY=;
 b=ES9fnwADbSVrB1uOuetzzeIbb7bKAelDaHZYl2qYCO16134Fbkz3fnLf+0HGvaxTHx1b6H
 6LP9M2YBLxu5bTKEt/v1eyRmI4/VBv4/bHasefdteRUTvvT3iypT5eFmQ3xnEGHN62yA8g
 XJVEdLWjj6gyVpJ2mVV+Ns4P9iYqguA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-xC7P_Q48N1yHaHNUBzY8Bw-1; Mon,
 21 Jul 2025 09:39:23 -0400
X-MC-Unique: xC7P_Q48N1yHaHNUBzY8Bw-1
X-Mimecast-MFC-AGG-ID: xC7P_Q48N1yHaHNUBzY8Bw_1753105163
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFD581800C3D; Mon, 21 Jul 2025 13:39:20 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.213])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 81976195608D; Mon, 21 Jul 2025 13:39:15 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] migration: show error message when postcopy fails
Date: Mon, 21 Jul 2025 14:39:13 +0100
Message-ID: <20250721133913.2914669-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The 'info migrate' command only shows the error message when the
migration state is 'failed'. When postcopy is used, however,
the 'postcopy-paused' state is used instead of 'failed', so we
must show the error message there too.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 migration/migration-hmp-cmds.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index cef5608210..07fd227edc 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -153,7 +153,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
     if (info->has_status) {
         monitor_printf(mon, "Status: \t\t%s",
                        MigrationStatus_str(info->status));
-        if (info->status == MIGRATION_STATUS_FAILED && info->error_desc) {
+        if ((info->status == MIGRATION_STATUS_FAILED ||
+             info->status == MIGRATION_STATUS_POSTCOPY_PAUSED) && info->error_desc) {
             monitor_printf(mon, " (%s)\n", info->error_desc);
         } else {
             monitor_printf(mon, "\n");
-- 
2.50.1


