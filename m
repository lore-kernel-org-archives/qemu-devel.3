Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B323CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 11:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzD0C-00088c-0J; Thu, 18 Sep 2025 07:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uzD01-00087Q-0i
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 07:40:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uzCzx-00034n-Iq
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 07:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758195623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=v8i/+BwLL+SPviwSVPOW1USXYrghU0ZkQrF4gNuEnsw=;
 b=SDA3S3tYQs02l2PuvNnDcl6yXlme/G4OH6gLI4UAfelBDEv4K01/mpd29pStFwp8yKLUb4
 dW7pms4djqeEtR5aIEVozkeUEZIZqoViX3LtqLxO29GRTzNTWPd0aMrc6FoblYXtJDmgEj
 CyJ2SIX9PLJNUP1ep4NhViOlMek7DHE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-5Ng-ljzHM7eS7j2muf7E1g-1; Thu,
 18 Sep 2025 07:40:20 -0400
X-MC-Unique: 5Ng-ljzHM7eS7j2muf7E1g-1
X-Mimecast-MFC-AGG-ID: 5Ng-ljzHM7eS7j2muf7E1g_1758195620
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90B34180057B; Thu, 18 Sep 2025 11:40:19 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F09A30002C5; Thu, 18 Sep 2025 11:40:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Subject: [PATCH] tests: Fix "make check-functional" for targets without
 thorough tests
Date: Thu, 18 Sep 2025 13:40:15 +0200
Message-ID: <20250918114015.83061-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

If QEMU gets configured for a single target that does not have
any thorough functional tests, "make check-functional" currently
fails with the error message "No rule to make target 'check-func'".
This happens because "check-func" only gets defined for thorough
tests (quick ones get added to "check-func-quick" instead).
Thus let's define a dummy target for this case, that simply
depends on the quick tests.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Closes: https://gitlab.com/qemu-project/qemu/-/issues/3119
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3538c0c7407..622be12e31b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -113,6 +113,8 @@ check-functional:
 	@$(NINJA) precache-functional
 	@QEMU_TEST_NO_DOWNLOAD=1 $(MAKE) SPEED=thorough check-func check-func-quick
 
+check-func: check-func-quick
+
 # Consolidated targets
 
 .PHONY: check check-clean
-- 
2.51.0


