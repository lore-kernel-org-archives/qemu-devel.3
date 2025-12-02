Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9B4D116FF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 08:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQLo2-0000rA-G6; Tue, 02 Dec 2025 03:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vQLo0-0000qH-5c
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 03:32:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vQLny-0007Iq-Gd
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 03:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764664332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y6nwHsloA98edYs4iEMv73ZiHGKr8bKy7cA0jyrEQu8=;
 b=h1PvHLJ3pJ8SW1MT4yyfzpjXaBcu0HzQXM9P6m/sbpKx6L/lTZsGr7wfRup+rByfVinkui
 bJ2xKc5R+Uw+wbUCd7JJ/qTvu3ShH0y5aLLydgLGYrnFRC6eNdZ1/QnguVPnz4mA4aIuR9
 3EjCIp4Vl46sH0HHMwEwMoT7N4T/lCg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-1XwbUN8_OjO_e55c08bjRA-1; Tue,
 02 Dec 2025 03:32:10 -0500
X-MC-Unique: 1XwbUN8_OjO_e55c08bjRA-1
X-Mimecast-MFC-AGG-ID: 1XwbUN8_OjO_e55c08bjRA_1764664329
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1B3118002C5; Tue,  2 Dec 2025 08:32:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 437A41956095; Tue,  2 Dec 2025 08:32:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BF1D021E6935; Tue, 02 Dec 2025 09:32:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 1/2] migration: Fix double-free on error path
Date: Tue,  2 Dec 2025 09:32:05 +0100
Message-ID: <20251202083206.4180561-2-armbru@redhat.com>
In-Reply-To: <20251202083206.4180561-1-armbru@redhat.com>
References: <20251202083206.4180561-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Fixes: ffaa1b50a879 (migration: Use warn_reportf_err() where appropriate)
Resolves: Coverity CID 1643463
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20251125070554.2256181-1-armbru@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 6210454838..3203dc98e1 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -450,7 +450,7 @@ static void multifd_send_set_error(Error *err)
  */
 static void migration_ioc_shutdown_gracefully(QIOChannel *ioc)
 {
-    g_autoptr(Error) local_err = NULL;
+    Error *local_err = NULL;
 
     if (!migration_has_failed(migrate_get_current()) &&
         object_dynamic_cast((Object *)ioc, TYPE_QIO_CHANNEL_TLS)) {
-- 
2.49.0


