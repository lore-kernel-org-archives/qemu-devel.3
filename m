Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCB7C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgx6X-0001Bk-J0; Sun, 03 Mar 2024 20:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx6V-0001BO-Ix
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:26:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx6U-0002D2-26
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:26:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709515613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ir0qtqpandnsGtqegAJq1Iw5ZTngl6lZQdOMv82MTII=;
 b=Fp3jumq8U6o9oX16Y0q51RiFAYGW1pEFt6djgN42XxvR09lbIbRPJihTot+9QWGzzIKwuP
 X4kEDBdhVOVoJ0pjob30U4oduIIuK4BaxCTPTHlBLhdeFaaQPFB48ZwR1YSI+flyysZdAo
 32iq/Ae3pWhdyIhWr4aVe47a0c2JY9w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-F3UAZCTHMhmWDbqFiklEXw-1; Sun, 03 Mar 2024 20:26:51 -0500
X-MC-Unique: F3UAZCTHMhmWDbqFiklEXw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECADF185A783;
 Mon,  4 Mar 2024 01:26:50 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 542BE40C6EBA;
 Mon,  4 Mar 2024 01:26:45 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Bryan Zhang <bryan.zhang@BYTEDANCE.COM>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PULL 02/27] migration: Properly apply migration compression level
 parameters
Date: Mon,  4 Mar 2024 09:26:09 +0800
Message-ID: <20240304012634.95520-3-peterx@redhat.com>
In-Reply-To: <20240304012634.95520-1-peterx@redhat.com>
References: <20240304012634.95520-1-peterx@redhat.com>
MIME-Version: 1.0
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

From: Bryan Zhang <bryan.zhang@BYTEDANCE.COM>

Some glue code was missing, so that using `qmp_migrate_set_parameters`
to set `multifd-zstd-level` or `multifd-zlib-level` did not work. This
commit adds the glue code to fix that.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Link: https://lore.kernel.org/r/20240301035901.4006936-2-bryan.zhang@bytedance.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/options.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index 3e3e0b93b4..1cd3cc7c33 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1312,6 +1312,12 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_multifd_compression) {
         dest->multifd_compression = params->multifd_compression;
     }
+    if (params->has_multifd_zlib_level) {
+        dest->multifd_zlib_level = params->multifd_zlib_level;
+    }
+    if (params->has_multifd_zstd_level) {
+        dest->multifd_zstd_level = params->multifd_zstd_level;
+    }
     if (params->has_xbzrle_cache_size) {
         dest->xbzrle_cache_size = params->xbzrle_cache_size;
     }
@@ -1447,6 +1453,12 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_multifd_compression) {
         s->parameters.multifd_compression = params->multifd_compression;
     }
+    if (params->has_multifd_zlib_level) {
+        s->parameters.multifd_zlib_level = params->multifd_zlib_level;
+    }
+    if (params->has_multifd_zstd_level) {
+        s->parameters.multifd_zstd_level = params->multifd_zstd_level;
+    }
     if (params->has_xbzrle_cache_size) {
         s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
         xbzrle_cache_resize(params->xbzrle_cache_size, errp);
-- 
2.44.0


