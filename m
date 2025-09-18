Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165C3CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 12:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzE7P-0006n1-9f; Thu, 18 Sep 2025 08:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uzE7L-0006mT-JC
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 08:52:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uzE7J-0003lr-Rf
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 08:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758199923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=61jE0V/zq743UTrbqJiWNVho+pSwVQ4cTXchqhOhwWU=;
 b=P5sjHwvzm/qi2lxO2cYZ6hwJgaoqX2K6OPjro7Z+n1KhAMOwh7IHr8OJuJfCBJoMn3dC6q
 EQpw8Ob4tOwhh+8Zu81tZoUHNA2M6br4QLQmwvErd5jPgt60BbOxLbrcvSbzXYQgM0dYNV
 Rm37dF39AAac5At+4rTC6EtaJ23QZ98=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-zVOSwjwFMo6gL-heAhla6A-1; Thu,
 18 Sep 2025 08:52:00 -0400
X-MC-Unique: zVOSwjwFMo6gL-heAhla6A-1
X-Mimecast-MFC-AGG-ID: zVOSwjwFMo6gL-heAhla6A_1758199919
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FF591955F45; Thu, 18 Sep 2025 12:51:59 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.33])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E25F01800451; Thu, 18 Sep 2025 12:51:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Subject: [PATCH v2] tests: Fix "make check-functional" for targets without
 thorough tests
Date: Thu, 18 Sep 2025 14:51:54 +0200
Message-ID: <20250918125154.126072-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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
The same problem can happen with the quick tests for targets that
do not have any functional test at all. To fix it, simply make sure
that the targets are always available in the Makefile.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Closes: https://gitlab.com/qemu-project/qemu/-/issues/3119
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 23fb722d426..9a3d137283e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -112,6 +112,9 @@ check-functional:
 	@$(NINJA) precache-functional
 	@QEMU_TEST_NO_DOWNLOAD=1 $(MAKE) SPEED=thorough check-func check-func-quick
 
+.PHONY: check-func check-func-quick
+check-func check-func-quick:
+
 # Consolidated targets
 
 .PHONY: check check-clean
-- 
2.51.0


