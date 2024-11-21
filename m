Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415BED78782
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 15:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE9M0-0002fd-2i; Thu, 21 Nov 2024 10:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE9Lx-0002bP-5V
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 10:44:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE9Lv-00015c-K7
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 10:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732203858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0txKiQWpxyguRebXD1DZVJACnLLYk3HWNLZCDAk2wrg=;
 b=XQY6tPxmR8ZFU+UIssbHFCdscqDtdX6lf3jfXVgcmNuPvzgiYTOaSRdByFwIX0Qjhl9fDO
 RQXAkahULljFMQhTv8ZfiMPRksB9inR5dKVGGWtE+2gG0Ohw/CySAGg+NbnrW/MRaeNavx
 qwVWh+l4cL/zQIPfGMEJASIKXNGsO0o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-PTtEFarwO6e5dqT1A9266Q-1; Thu,
 21 Nov 2024 10:44:15 -0500
X-MC-Unique: PTtEFarwO6e5dqT1A9266Q-1
X-Mimecast-MFC-AGG-ID: PTtEFarwO6e5dqT1A9266Q
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20B7C1956095; Thu, 21 Nov 2024 15:44:14 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.5])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C68191956086; Thu, 21 Nov 2024 15:44:07 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 17/18] tests/functional: add a QMP backdoor for debugging
 stalled tests
Date: Thu, 21 Nov 2024 15:42:17 +0000
Message-ID: <20241121154218.1423005-18-berrange@redhat.com>
In-Reply-To: <20241121154218.1423005-1-berrange@redhat.com>
References: <20241121154218.1423005-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Support the QEMU_TEST_QMP_BACKDOOR=backdoor.sock env variable as a
way to get a QMP backdoor for debugging a stalled QEMU test. Most
typically this would be used if running the tests directly:

 $ QEMU_TEST_QMP_BACKDOOR=backdoor.sock \
   QEMU_TEST_QEMU_BINARY=./build/qemu-system-arm \
   PYTHONPATH=./python \
   ./tests/functional/test_arm_tuxrun.py

And then, when the test stalls, in a second shell run:

 $ ./scripts/qmp/qmp-shell backdoor.sock

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/devel/testing/functional.rst      | 10 ++++++++++
 tests/functional/qemu_test/testcase.py |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
index 6b5d0c5b98..b8ad7b0bf7 100644
--- a/docs/devel/testing/functional.rst
+++ b/docs/devel/testing/functional.rst
@@ -176,6 +176,16 @@ primarily depend on the value of the ``qemu_bin`` class attribute.
 If it is not explicitly set by the test code, its default value will
 be the result the QEMU_TEST_QEMU_BINARY environment variable.
 
+Debugging hung QEMU
+^^^^^^^^^^^^^^^^^^^
+
+When test cases go wrong it may be helpful to debug a stalled QEMU
+process. While the QEMUMachine class owns the primary QMP monitor
+socket, it is possible to request a second QMP monitor be created
+by setting the ``QEMU_TEST_QMP_BACKDOOR`` env variable to refer
+to a UNIX socket name. The ``qmp-shell`` command can then be
+attached to the stalled QEMU to examine its live state.
+
 Attribute reference
 -------------------
 
diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index e2a329c3e5..fceafb32b0 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -175,6 +175,13 @@ def _new_vm(self, name, *args):
                          log_dir=self.logdir)
         self.log.debug('QEMUMachine "%s" created', name)
         self.log.debug('QEMUMachine "%s" temp_dir: %s', name, vm.temp_dir)
+
+        sockpath = os.environ.get("QEMU_TEST_QMP_BACKDOOR", None)
+        if sockpath is not None:
+            vm.add_args("-chardev",
+                        f"socket,id=backdoor,path={sockpath},server=on,wait=off",
+                        "-mon", "chardev=backdoor,mode=control")
+
         if args:
             vm.add_args(*args)
         return vm
-- 
2.46.0


