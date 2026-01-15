Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0106CD44C6D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 15:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgPfD-0001I0-Pr; Thu, 15 Jan 2026 10:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vgPf9-0001HM-ET
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 10:53:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vgPf7-0006BY-BD
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 10:53:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768492405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sRobLSEIMKAyvN7TAwnvNgehkJTCBStcFCj1CeEKa3c=;
 b=YQSSZqDere7n6ULP1NN0oYpJK7DvjZvx3drBEAh6EWM9HGtVaawJgNN3OFNlC26sCON5Nf
 681eDL78j6RJdud83iArUt3RC3qBFcKTb0WKAW2plsH87FlFYpujZfKRYQRrgUZTydI+a2
 qIttjFHKob8XTzf0IbKDeTJjOSQc8bk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-TaX3BkgTPGSb0Ol2vKLVCg-1; Thu,
 15 Jan 2026 10:53:23 -0500
X-MC-Unique: TaX3BkgTPGSb0Ol2vKLVCg-1
X-Mimecast-MFC-AGG-ID: TaX3BkgTPGSb0Ol2vKLVCg_1768492401
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C42251956054; Thu, 15 Jan 2026 15:53:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.246])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B0B651955F22; Thu, 15 Jan 2026 15:53:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2] tests/tracetool: Honor the Python interpreter that
 "configure" detected
Date: Thu, 15 Jan 2026 16:53:18 +0100
Message-ID: <20260115155318.37823-1-thuth@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The tracetool tests currently fail if the host installation does not
have a "python3" binary (and you compiled QEMU by selecting a different
one during the "configure" step). This happens because tracetool-test.py
executes scripts/tracetool.py directly, so that this script is run via
its shebang line. To fix the issue, use the same Python interpreter to
run scripts/tracetool.py as we are using to run the tracetool-test.py
script.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Use sys.executable instead of passing the Python interpreter around
     via a PYTHON environment variable.

 tests/tracetool/tracetool-test.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tracetool/tracetool-test.py b/tests/tracetool/tracetool-test.py
index 30006a99190..59e9ab3d6ef 100755
--- a/tests/tracetool/tracetool-test.py
+++ b/tests/tracetool/tracetool-test.py
@@ -36,7 +36,8 @@ def test_tracetool_one(tracetool, backend, fmt, src_dir, build_dir):
     actual_file = Path(build_dir, rel_filename)
     expect_file = Path(src_dir, rel_filename)
 
-    args = [tracetool, f"--format={fmt}", f"--backends={backend}", "--group=testsuite"]
+    args = [sys.executable, tracetool,
+            f"--format={fmt}", f"--backends={backend}", "--group=testsuite"]
 
     if fmt.find("stap") != -1:
         args += ["--binary=qemu", "--probe-prefix=qemu"]
-- 
2.52.0


