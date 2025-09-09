Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1CACAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 13:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvymJ-00018u-JZ; Tue, 09 Sep 2025 09:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvym8-0000tH-TK
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvym3-0005KE-QB
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757425961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dyF/4fpiqPKdmi8Z4zrodxmHgK5zxLGUXM7FDj/rpyI=;
 b=ZNN3ziywNITcrh1gzmfNDPHQL21IhIpYx9ud1iXDVdpHBGR5+iGBcD+O9OMDE6/JoielLz
 7sslcCaiHbKTUMRhVvRaRVh6/fBY0odKydDUjc4dQs6iiMjgrEByv5k5ZBDFLNj61wS15m
 aPb+MtVkIIkBLOVh+s6Z4hXGgm8ES7s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-KdvnLTLBPC2I3U4mM62ANw-1; Tue,
 09 Sep 2025 09:52:40 -0400
X-MC-Unique: KdvnLTLBPC2I3U4mM62ANw-1
X-Mimecast-MFC-AGG-ID: KdvnLTLBPC2I3U4mM62ANw_1757425959
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78DA11800290; Tue,  9 Sep 2025 13:52:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.46])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6876E1800447; Tue,  9 Sep 2025 13:52:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 21/23] tests/functional: avoid duplicate messages on failures
Date: Tue,  9 Sep 2025 15:51:45 +0200
Message-ID: <20250909135147.612345-22-thuth@redhat.com>
In-Reply-To: <20250909135147.612345-1-thuth@redhat.com>
References: <20250909135147.612345-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

In some scenarios the same tests is mentioned in both the
'res.results.errors' and 'res.results.failures' array returned
by unittest.main(). This was seen when the 'tearDown' method
raised an exception.

In such a case, we printed out the same information about where
to find a log file twice for each test. Track which tests we
have already reported on, to avoid the duplication.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250908135722.3375580-3-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index fbeb1710587..82a7724404b 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -251,13 +251,14 @@ def main():
                                    test_output_log = pycotap.LogMode.LogToError)
         res = unittest.main(module = None, testRunner = tr, exit = False,
                             argv=[sys.argv[0], path] + sys.argv[1:])
+        failed = {}
         for (test, message) in res.result.errors + res.result.failures:
-
-            if hasattr(test, "log_filename"):
+            if hasattr(test, "log_filename") and not test.id() in failed:
                 print('More information on ' + test.id() + ' could be found here:'
                       '\n %s' % test.log_filename, file=sys.stderr)
                 if hasattr(test, 'console_log_name'):
                     print(' %s' % test.console_log_name, file=sys.stderr)
+                failed[test.id()] = True
         sys.exit(not res.result.wasSuccessful())
 
 
-- 
2.51.0


