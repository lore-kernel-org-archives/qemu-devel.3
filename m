Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657EDC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 18:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACWK-0003iE-Kr; Wed, 30 Apr 2025 14:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uACWI-0003eq-Jc
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:50:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uACWH-0008Kn-3i
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746039056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yE+Dy3KSzP7hqd2P27FXKfvA+IPbYGVyZC5yv2AnfkE=;
 b=HkZzYTgrmlSc0DDcL6z+xY1UsY2L3EqqRl8e/pIr5IZXlTxwd0tYcYa+DXwiLzGWzB7UNp
 krr7H04ZIyXPiIbzF0xBv+rhRZEAL12d3kRqIgsMYKWfHtZ2TmFzeAh7i1r/pAWXvlhQgf
 pBUx+l0J2crNxiXmHWhuAD2z19wCNSM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-DotMhijkPq6TZPOChEJOzQ-1; Wed,
 30 Apr 2025 14:50:55 -0400
X-MC-Unique: DotMhijkPq6TZPOChEJOzQ-1
X-Mimecast-MFC-AGG-ID: DotMhijkPq6TZPOChEJOzQ_1746039054
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 025B819560AE; Wed, 30 Apr 2025 18:50:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.67])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 624BD19560A3; Wed, 30 Apr 2025 18:50:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 6/9] tests/functional/test_ppc64_pseries: Skip
 test_ppc64_linux_smt_boot if necessary
Date: Wed, 30 Apr 2025 20:50:32 +0200
Message-ID: <20250430185035.724919-7-thuth@redhat.com>
In-Reply-To: <20250430185035.724919-1-thuth@redhat.com>
References: <20250430185035.724919-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

The test_ppc64_linux_smt_boot function lacks the set_machine('pseries'),
so this test is currently failing in case the 'pseries' machine has not
been compiled into the binary. Add the check now to fix it.

Message-ID: <20250424085426.663377-1-thuth@redhat.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
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


