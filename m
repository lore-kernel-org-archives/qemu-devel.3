Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27177CCFA06
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 11:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFsHK-0003zT-2X; Mon, 03 Nov 2025 05:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFsHI-0003xn-Lt
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:59:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFsHE-0004WN-UE
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:59:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762167546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IOVDcGhMCkuyVVd2jbsDowfYGThYB1elQwWqVfTLoV4=;
 b=dDqM9dF5lWPyrEXKIZr4pQf0EdtjlzXK1lefQbWCeo1IFlYZiMSEYFNrg3iDfsMLghCqtv
 yQLS7spqoYSVWZ1319Nmoa0U6DcXt1X3Wf74/qf3vD69HdMKNktNgfpG3wM2HPIYdfVFy0
 wCyONvFWWBadrJR6T/PN7mbuD1Ngfqc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-GYjWc5YxPDm-uNYWh0oLQQ-1; Mon,
 03 Nov 2025 05:59:04 -0500
X-MC-Unique: GYjWc5YxPDm-uNYWh0oLQQ-1
X-Mimecast-MFC-AGG-ID: GYjWc5YxPDm-uNYWh0oLQQ_1762167544
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 166C61954230; Mon,  3 Nov 2025 10:59:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8CF3330001A1; Mon,  3 Nov 2025 10:59:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 17/22] tests/functional: include the lower level QMP log
 messages
Date: Mon,  3 Nov 2025 11:58:14 +0100
Message-ID: <20251103105824.322039-18-thuth@redhat.com>
In-Reply-To: <20251103105824.322039-1-thuth@redhat.com>
References: <20251103105824.322039-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

We've seen a GitLab CI timeout failure in the test_pseries.py test,
where it appears likely that the test has hung in a self.qmp('quit')
call, but we don't have conclusive proof. Adding the QMP log category
to what we capture should help us diagnose this, at the cost of the
base.log file becoming significantly more verbose. The previous
commit to include the logger category name and function should at
least help understanding the more verbose logs.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251028182651.873256-3-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index d9d114e63e3..1d773dd697d 100644
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
             self.socketdir.cleanup()
             self.socketdir = None
+        self.qmplog.removeHandler(self._log_fh)
         self.machinelog.removeHandler(self._log_fh)
         self.log.removeHandler(self._log_fh)
         self._log_fh.close()
-- 
2.51.0


