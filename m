Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A6EC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 08:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udlhd-00083P-M6; Mon, 21 Jul 2025 04:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1udlhL-0007pz-IV
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 04:16:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1udlhJ-0007eG-P3
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 04:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753085792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BJ6CU4sjeCPOeNC6MabAD9zbnxqnEwRvbvIeZp+xqB4=;
 b=Lnl1BunPz0G+l8jiaLNlu3L9a15qoeA6JR0OjcQnkU0WMikNB5tlPTKUAwT9/y0/mG75vV
 n7wF3rC/Rsr0WlwjRAdtqoemrF/CSwc8cwDuohgGDiZuKTgmRaGovpLrijQH9939CuE2Xa
 vrfa0NEhQnyeMvKxtDWgjTFvQ48/2JM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-CRp_-xaENwWRYc5A5oWW2Q-1; Mon,
 21 Jul 2025 04:16:29 -0400
X-MC-Unique: CRp_-xaENwWRYc5A5oWW2Q-1
X-Mimecast-MFC-AGG-ID: CRp_-xaENwWRYc5A5oWW2Q_1753085789
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3C4B19560A5
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 08:16:28 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.77])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7331119560A3; Mon, 21 Jul 2025 08:16:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 4/5] functional: always enable all python warnings
Date: Mon, 21 Jul 2025 10:16:13 +0200
Message-ID: <20250721081614.262563-5-thuth@redhat.com>
In-Reply-To: <20250721081614.262563-1-thuth@redhat.com>
References: <20250721081614.262563-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Daniel P. Berrangé <berrange@redhat.com>

Of most importance is that this gives us a heads-up if anything
we rely on has been deprecated. The default python behaviour
only emits a warning if triggered from __main__ which is very
limited.

Setting the env variable further ensures that any python child
processes will also display warnings.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250715143023.1851000-11-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 71c7160adcf..2a78e735f16 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -19,6 +19,7 @@
 from subprocess import run
 import sys
 import tempfile
+import warnings
 import unittest
 import uuid
 
@@ -235,6 +236,9 @@ def tearDown(self):
         self._log_fh.close()
 
     def main():
+        warnings.simplefilter("default")
+        os.environ["PYTHONWARNINGS"] = "default"
+
         path = os.path.basename(sys.argv[0])[:-3]
 
         cache = os.environ.get("QEMU_TEST_PRECACHE", None)
-- 
2.50.0


