Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598D9C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 07:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1gub-0004cy-00; Mon, 07 Apr 2025 03:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u1guY-0004cn-UH
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:28:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u1guW-0000c7-AT
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744010925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=v7+yFtSeZh9R3gpZloPwa7L6hzUtfKi0BEPr6uO2kDs=;
 b=FF6Z8MoOXAU+Mkwcv8LF5dtGpPMjZttwHniJunCpGfM6PH5VmpFtf8ERXNom9lnlapsYlh
 T8GCEoIJnUI/O8Wnb/iieUK6fpIEpJx7qFRkdtxpDzzrWJnCiiSgGoZRUUlZlqZc45IvUN
 S6ZkKZ1+7yjUpoALrRYQy3n4zqKeGGo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-QtbMRFYBPji7b3wv6vxEZQ-1; Mon,
 07 Apr 2025 03:28:43 -0400
X-MC-Unique: QtbMRFYBPji7b3wv6vxEZQ-1
X-Mimecast-MFC-AGG-ID: QtbMRFYBPji7b3wv6vxEZQ_1744010922
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F22A7180AF50; Mon,  7 Apr 2025 07:28:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1CB6180A803; Mon,  7 Apr 2025 07:28:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E28E021E66C5; Mon, 07 Apr 2025 09:28:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de
Subject: [PATCH] migration: Fix latent bug in migrate_params_test_apply()
Date: Mon,  7 Apr 2025 09:28:33 +0200
Message-ID: <20250407072833.2118928-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

migrate_params_test_apply() neglects to apply tls_authz.  Currently
harmless, because migrate_params_check() doesn't care.  Fix it anyway.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/options.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index b0ac2ea408..cb8eec218f 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1193,6 +1193,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
         dest->tls_hostname = params->tls_hostname->u.s;
     }
 
+    if (params->tls_authz) {
+        assert(params->tls_authz->type == QTYPE_QSTRING);
+        dest->tls_authz = params->tls_authz->u.s;
+    }
+
     if (params->has_max_bandwidth) {
         dest->max_bandwidth = params->max_bandwidth;
     }
-- 
2.48.1


