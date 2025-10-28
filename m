Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03060CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDoQT-0002BS-6f; Tue, 28 Oct 2025 14:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vDoPZ-0001Xe-AD
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:27:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vDoPW-0003Pq-8w
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761676023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AaUvfKzB26s3XrTmtxK2gaUnDy8a03gE/3HV8l+hq+I=;
 b=XRe9bP4HVGJB9rYj19/I4f9UmeCnDroziqHIulAetYHdk664ZQzjWqen5TD5uZydcygNe4
 ly7HA9bRXC3TRcPErkJ8MYJ1Ce4aS3cA8FL/E75naekQOOg5QTzpqTT5B4IqGrlF/gg+du
 JFCLuf//wcPXXwBaECfoZa5C5uNtjcA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-cZL7e3-aMemVb2i63nOxxg-1; Tue,
 28 Oct 2025 14:26:59 -0400
X-MC-Unique: cZL7e3-aMemVb2i63nOxxg-1
X-Mimecast-MFC-AGG-ID: cZL7e3-aMemVb2i63nOxxg_1761676018
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE5211954B0C; Tue, 28 Oct 2025 18:26:58 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.86])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 45F4F1955F1B; Tue, 28 Oct 2025 18:26:57 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/2] tests/functional: include the lower level QMP log messages
Date: Tue, 28 Oct 2025 18:26:51 +0000
Message-ID: <20251028182651.873256-3-berrange@redhat.com>
In-Reply-To: <20251028182651.873256-1-berrange@redhat.com>
References: <20251028182651.873256-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We've seen a GitLab CI timeout failure in the test_pseries.py test,
where it appears likely that the test has hung in a self.qmp('quit')
call, but we don't have conclusive proof. Adding the QMP log category
to what we capture should help us diagnose this, at the cost of the
base.log file becoming significantly more verbose. The previous
commit to include the logger category name and function should at
least help understanding the more verbose logs.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 6fc6e1ac0a..5ab84ce674 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -225,6 +225,9 @@ def setUp(self):
         self.machinelog = logging.getLogger('qemu.machine')
         self.machinelog.setLevel(logging.DEBUG)
         self.machinelog.addHandler(self._log_fh)
+        self.qmplog = logging.getLogger('qemu.qmp')
+        self.qmplog.setLevel(logging.DEBUG)
+        self.qmplog.addHandler(self._log_fh)
 
         if not self.assets_available():
             self.skipTest('One or more assets is not available')
@@ -235,6 +238,7 @@ def tearDown(self):
         if self.socketdir is not None:
             shutil.rmtree(self.socketdir.name)
             self.socketdir = None
+        self.qmplog.removeHandler(self._log_fh)
         self.machinelog.removeHandler(self._log_fh)
         self.log.removeHandler(self._log_fh)
         self._log_fh.close()
-- 
2.51.1


