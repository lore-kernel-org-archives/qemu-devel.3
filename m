Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B656CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 13:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvcNd-0003y2-Sv; Mon, 08 Sep 2025 09:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvcNY-0003vm-Qf
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 09:57:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvcNM-0005cY-3e
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 09:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757339854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hdqpij1YIh83DmCO+ezh0fMDAmtNazIV0O/ENmitVn8=;
 b=ZWUUZy9mAtkgSbGL1ygZKPR4ZgrXSGrKGKDhydGVmsEiM/sVJn04+yrKzeRuDfGkLngXT/
 M8AUegjWL0VpSRvZfmB0x8jdRpr1Z0WRrMEd6i+PmIeeyvb0yT3Es2Ls9ar9ARIDAHYvAW
 3fkstyYDEllTkrOr05mOxA/cppp19dc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-prRK28rLP-KhijMKXYtBIg-1; Mon,
 08 Sep 2025 09:57:32 -0400
X-MC-Unique: prRK28rLP-KhijMKXYtBIg-1
X-Mimecast-MFC-AGG-ID: prRK28rLP-KhijMKXYtBIg_1757339851
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA2D2180057A; Mon,  8 Sep 2025 13:57:31 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.93])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 21A6C18003FC; Mon,  8 Sep 2025 13:57:29 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/4] tests/functional: avoid tearDown failure when QEMU dies
Date: Mon,  8 Sep 2025 14:57:21 +0100
Message-ID: <20250908135722.3375580-4-berrange@redhat.com>
In-Reply-To: <20250908135722.3375580-1-berrange@redhat.com>
References: <20250908135722.3375580-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In a QEMU process under test dies unexpectedly, the 'shutdown'
method may well raise an exeception. This causes the tearDown
method to fail, which means any later cleanup code fails to
get run. Most notably the log handlers don't get removed so
the base.log file from an earlier test will get polluted with
messages from any subsequent tests. The tearDown failure also
results in pages of exceptions printed on the console, which
obscures the real failure message / trace printed by the test.

Ignore any shutdown failures in the tearDown method, since any
test which cares about clean shutdown should have already
cleaned up any running VMs. The tearDown method is just there
as a safety net to cleanup resources. The base.log file will
still containing log messages from the failed 'vm.shutdown'
call too.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 82a7724404..faa0a4f0db 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -404,7 +404,10 @@ def set_vm_arg(self, arg, value):
 
     def tearDown(self):
         for vm in self._vms.values():
-            vm.shutdown()
+            try:
+                vm.shutdown()
+            except Exception as ex:
+                self.log.error("Failed to teardown VM: %s" % ex)
         logging.getLogger('console').removeHandler(self._console_log_fh)
         self._console_log_fh.close()
         super().tearDown()
-- 
2.50.1


