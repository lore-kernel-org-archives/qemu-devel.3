Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A9FCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 06:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1JBg-0002fg-Bd; Wed, 24 Sep 2025 02:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v1JBB-0002Y7-SV
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 02:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v1JAz-0006mG-KR
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 02:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758696028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=raTA0kM5nFI+z4B5gzD6Ep5lYfS+FsUc1xyZ0yVdXQ0=;
 b=e95SQrmAkrE2/tn7mgaKuNOHDAMJCyZEY0WdAHQqmGDUl0U0SFFOZc0AxqkRU9ZffzkfC3
 G9UpDsfv605jzEpfF7DKBvqGo1P8kmifFZRSWPZxmwtzjRP6MoaSOtx/vXyDQJhS6uwG8q
 W02vCYqlCdE7je43qA0RDwPZm4ySi4U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-euXcDny4NZKx8lV_sB9I2w-1; Wed,
 24 Sep 2025 02:40:18 -0400
X-MC-Unique: euXcDny4NZKx8lV_sB9I2w-1
X-Mimecast-MFC-AGG-ID: euXcDny4NZKx8lV_sB9I2w_1758696017
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55721195608B; Wed, 24 Sep 2025 06:40:17 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 340BB1955F19; Wed, 24 Sep 2025 06:40:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 10/12] tests: Fix "make check-functional" for targets without
 thorough tests
Date: Wed, 24 Sep 2025 08:39:54 +0200
Message-ID: <20250924063956.519792-11-thuth@redhat.com>
In-Reply-To: <20250924063956.519792-1-thuth@redhat.com>
References: <20250924063956.519792-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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
Message-ID: <20250918125154.126072-1-thuth@redhat.com>
---
 tests/Makefile.include | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3538c0c7407..62a4fc8ed31 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -113,6 +113,9 @@ check-functional:
 	@$(NINJA) precache-functional
 	@QEMU_TEST_NO_DOWNLOAD=1 $(MAKE) SPEED=thorough check-func check-func-quick
 
+.PHONY: check-func check-func-quick
+check-func check-func-quick:
+
 # Consolidated targets
 
 .PHONY: check check-clean
-- 
2.51.0


