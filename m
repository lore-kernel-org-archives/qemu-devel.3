Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57F0C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 09:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuT85-00026u-UX; Tue, 18 Mar 2025 05:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tuT7v-00025b-Uo
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:20:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tuT7i-00080S-Hz
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742289630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=K3SzfxSCZgpmLJDnc88j36vDbZA6TbFCNXok+V4j/qg=;
 b=Fm0WiCBqedj1q3C7NBmTJsD9/ZrC5rmkLanIrT61FbFmsViApsZ1/f3rsFn20NpG9kao9N
 SvzqRojLharSp7Qa2XixGu8pOWNqGSKxDlCT0B1gv/PqvYo4cf3S5oh7StP0IGICsyJLlA
 Aao3huMuS/jzJWX6hroXAyBgBQK9iBY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-aEsAvPSmPaydmwHiELmdlw-1; Tue,
 18 Mar 2025 05:20:26 -0400
X-MC-Unique: aEsAvPSmPaydmwHiELmdlw-1
X-Mimecast-MFC-AGG-ID: aEsAvPSmPaydmwHiELmdlw_1742289625
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 894051800257; Tue, 18 Mar 2025 09:20:25 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-228.str.redhat.com
 [10.33.192.228])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2ABF8180174E; Tue, 18 Mar 2025 09:20:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Aditya Gupta <adityag@linux.ibm.com>
Subject: [PATCH] docs/devel/testing/functional: Add a section about logging
Date: Tue, 18 Mar 2025 10:20:21 +0100
Message-ID: <20250318092021.53719-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

We should tell the users where to find the log file.
While we're at it, also rename the "Overview" heading to a
more accurate "Introduction to writing tests" instead.

Reported-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/testing/functional.rst | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
index a9fa45eac1f..9bc973392aa 100644
--- a/docs/devel/testing/functional.rst
+++ b/docs/devel/testing/functional.rst
@@ -72,8 +72,26 @@ files around on disk by setting ```QEMU_TEST_KEEP_SCRATCH=1``` as an env
 variable.  Any preserved files will be deleted the next time the test is run
 without this variable set.
 
-Overview
---------
+Logging
+-------
+
+The framework collects log files for each test in the build directory
+in the following subfolder::
+
+ <builddir>/tests/functional/<arch>/<fileid>.<classid>.<testname>/
+
+There are usually three log files:
+
+* ``base.log`` contains the generic logging information that is written
+  by the calls to the logging functions in the test code (e.g. by calling
+  the ``self.log.info()`` or ``self.log.debug()`` functions).
+* ``console.log`` contains the output of the serial console of the guest.
+* ``default.log`` contains the output of QEMU. This file could be named
+  differently if the test chooses to use a different identifier for
+  the guest VM (e.g. when the test spins up multiple VMs).
+
+Introduction to writing tests
+-----------------------------
 
 The ``tests/functional/qemu_test`` directory provides the ``qemu_test``
 Python module, containing the ``qemu_test.QemuSystemTest`` class.
-- 
2.48.1


