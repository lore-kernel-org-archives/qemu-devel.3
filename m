Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73088CAC594
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0hZ-0000w5-N0; Fri, 12 Sep 2025 06:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ux0hY-0000uJ-0u
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 06:08:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ux0hP-00024d-Ds
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 06:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757671686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OZ5kSFmLtWiykdMnySimFJQ93fikAalDa1MTUwd4FkA=;
 b=Kx7yto/6v14u5ALt61D2o8pYlCHEZGXftXGywgu9aeFEi27z2/LRkGwKb58uGg7Eb/3Ih3
 lEEkXiZYlcYfLFERmxMXZdCkn+VkMJkyJeuB0RW89VY9kPdZi6x1O9neTY1X5fuW5aC5nm
 uYJ5+PnMQMgI9YzWDqBMiWuuVqyNHQY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-pNUmowCGP0aKMSZiM7UcIw-1; Fri,
 12 Sep 2025 06:08:03 -0400
X-MC-Unique: pNUmowCGP0aKMSZiM7UcIw-1
X-Mimecast-MFC-AGG-ID: pNUmowCGP0aKMSZiM7UcIw_1757671682
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 074131954194; Fri, 12 Sep 2025 10:08:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.15])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 804AB1954126; Fri, 12 Sep 2025 10:08:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 1/4] tests: Move the old vmstate-static-checker files to
 tests/data/
Date: Fri, 12 Sep 2025 12:07:52 +0200
Message-ID: <20250912100755.316518-2-thuth@redhat.com>
In-Reply-To: <20250912100755.316518-1-thuth@redhat.com>
References: <20250912100755.316518-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Thomas Huth <thuth@redhat.com>

All other test data resides in tests/data/, so let's move the dump
files here, too.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                                     | 2 +-
 .../vmstate-static-checker}/dump1.json                          | 0
 .../vmstate-static-checker}/dump2.json                          | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/{vmstate-static-checker-data => data/vmstate-static-checker}/dump1.json (100%)
 rename tests/{vmstate-static-checker-data => data/vmstate-static-checker}/dump2.json (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb045388b92..bd8eb349649 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3604,7 +3604,7 @@ F: migration/
 F: scripts/vmstate-static-checker.py
 F: tests/functional/migration.py
 F: tests/functional/*/*migration.py
-F: tests/vmstate-static-checker-data/
+F: tests/data/vmstate-static-checker/
 F: tests/qtest/migration/
 F: tests/qtest/migration-*
 F: docs/devel/migration/
diff --git a/tests/vmstate-static-checker-data/dump1.json b/tests/data/vmstate-static-checker/dump1.json
similarity index 100%
rename from tests/vmstate-static-checker-data/dump1.json
rename to tests/data/vmstate-static-checker/dump1.json
diff --git a/tests/vmstate-static-checker-data/dump2.json b/tests/data/vmstate-static-checker/dump2.json
similarity index 100%
rename from tests/vmstate-static-checker-data/dump2.json
rename to tests/data/vmstate-static-checker/dump2.json
-- 
2.51.0


