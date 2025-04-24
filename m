Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28C0C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 08:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7sM2-0002yS-VW; Thu, 24 Apr 2025 04:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7sM1-0002yC-FU
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 04:54:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7sLz-0005CS-V8
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 04:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745484883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=k+ThEqRu79BvNXberhT830uw/TJnsT+5/UsDBmFPjx8=;
 b=BqrfJmawxWLFOLWgJuV4bjwrZG2Sb2LU20yWq80ZcSQdJNqzf5gE+q92zq6nqH7moOzg7J
 jrhHGXZmyMsfhBFJY27By3tqJunZPk7WNVD9r85HIixsuQGk/d9GfVrAQuazF/RVYd4o0p
 kMnghSooL7wXfhYKfh7tMBLsQ74eCSU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-CwdvPHuQOfCNfDCyR7sY_A-1; Thu,
 24 Apr 2025 04:54:37 -0400
X-MC-Unique: CwdvPHuQOfCNfDCyR7sY_A-1
X-Mimecast-MFC-AGG-ID: CwdvPHuQOfCNfDCyR7sY_A_1745484875
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A0001956086; Thu, 24 Apr 2025 08:54:35 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.162])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 42C8019560A3; Thu, 24 Apr 2025 08:54:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH] tests/functional/test_ppc64_pseries: Skip
 test_ppc64_linux_smt_boot if necessary
Date: Thu, 24 Apr 2025 10:54:26 +0200
Message-ID: <20250424085426.663377-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The test_ppc64_linux_smt_boot function lacks the set_machine('pseries'),
so this test is currently failing in case the 'pseries' machine has not
been compiled into the binary. Add the check now to fix it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_ppc64_pseries.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/test_ppc64_pseries.py b/tests/functional/test_ppc64_pseries.py
index fdc404ed033..67057934e8d 100755
--- a/tests/functional/test_ppc64_pseries.py
+++ b/tests/functional/test_ppc64_pseries.py
@@ -63,6 +63,7 @@ def test_ppc64_linux_hpt_smp_boot(self):
         wait_for_console_pattern(self, self.good_message, self.panic_message)
 
     def test_ppc64_linux_smt_boot(self):
+        self.set_machine('pseries')
         self.vm.add_args('-smp', '4,threads=4')
         self.do_test_ppc64_linux_boot()
         console_pattern = 'CPU maps initialized for 4 threads per core'
-- 
2.49.0


