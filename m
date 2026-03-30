Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E59FB3D00
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 10:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w79rV-0001Df-0z; Mon, 30 Mar 2026 06:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w79rS-0001BY-5r
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 06:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w79rP-0005FG-Cz
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 06:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774866522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z1d9tiJ2T0B368nmiqeZ/3YpPq5mj4POOCDgcmZzlJg=;
 b=AizZe/s4vIBRVSOPUsy48I2+zwKvJoO5YpXvG/mG3xqfelWCDx3kVaabWlz+p/XE8hXmEU
 J8toZ0geY0Q+ushmbHRs7Umh7SsJwKanZIYT4/9dmGl/QZQTUkEoQJVaaPkIx9II1rZ1pE
 2f1WoJ7G/xskHcSQB73dhTjL7PblltU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-40vnokgLPHerRlVnGPl8LA-1; Mon,
 30 Mar 2026 06:28:39 -0400
X-MC-Unique: 40vnokgLPHerRlVnGPl8LA-1
X-Mimecast-MFC-AGG-ID: 40vnokgLPHerRlVnGPl8LA_1774866518
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DFD219560A6; Mon, 30 Mar 2026 10:28:38 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.35.14])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 370173000223; Mon, 30 Mar 2026 10:28:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 7/7] tests/functional/migration.py: Skip migration_with_exec()
 if socat is not available
Date: Mon, 30 Mar 2026 12:28:15 +0200
Message-ID: <20260330102815.6759-8-thuth@redhat.com>
In-Reply-To: <20260330102815.6759-1-thuth@redhat.com>
References: <20260330102815.6759-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Commit 643a171f5668 ("tests: Replace ncat with socat in migration test
and drop ncat from containers") replaced ncat with socat, but missed to
skip related test cases if socat is not available, which will cause test
errors on the system without socat.

Fix this by checking socat instead of the original ncat.

Fixes: 643a171f5668 ("tests: Replace ncat with socat in migration test and drop ncat from containers")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20260330053300.2721608-1-zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/migration.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/functional/migration.py b/tests/functional/migration.py
index 2395119d6c6..144f091ba8a 100644
--- a/tests/functional/migration.py
+++ b/tests/functional/migration.py
@@ -80,8 +80,8 @@ def migration_with_unix(self):
         self.migrate(dst_uri)
 
     def migration_with_exec(self):
-        if not which('ncat'):
-            self.skipTest('ncat is not available')
+        if not which('socat'):
+            self.skipTest('socat is not available')
         with Ports() as ports:
             free_port = self._get_free_port(ports)
             dst_uri = 'exec:socat TCP-LISTEN:%u -' % free_port
-- 
2.53.0


