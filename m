Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105CFC3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 13:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXLHe-0001pI-Sq; Fri, 26 Jul 2024 09:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sXLH8-0007BU-8o
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 09:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sXLH4-0002B7-NO
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 09:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722001581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Im4JjI8yzxxn9wQq5bZQLL26rZjo/9QxJ6+zUl4DQ7s=;
 b=DUyWGN4r7r24U/jgytdlvtFkzY/L1XcLy++0wOGMX+BJG+/kq7xGwmCrb8PZIB1e8ht246
 UCkRc3fOkzjmaX+FRsg6G8KDKggzY6TNbDl8OOngQ68EZhRRw86eb6uVNqg5JcAvzSSqx8
 UIp5xxCEGA7BsoSHADAUqKZ0okawMc8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-dGOgJqcsNGmzR9AyTJmYdQ-1; Fri,
 26 Jul 2024 09:46:17 -0400
X-MC-Unique: dGOgJqcsNGmzR9AyTJmYdQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B640C19E5770; Fri, 26 Jul 2024 13:46:07 +0000 (UTC)
Received: from p1.localdomain.com (unknown [10.22.17.77])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A4F71955D42; Fri, 26 Jul 2024 13:45:42 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 David Woodhouse <dwmw2@infradead.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>, Cleber Rosa <crosa@redhat.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 13/13] Avocado tests: allow for parallel execution of tests
Date: Fri, 26 Jul 2024 09:44:38 -0400
Message-ID: <20240726134438.14720-14-crosa@redhat.com>
In-Reply-To: <20240726134438.14720-1-crosa@redhat.com>
References: <20240726134438.14720-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The updated Avocado version allows for the execution of tests in
parallel.

While on a CI environment it may not be a good idea to increase the
parallelization level in a single runner, developers may leverage that
on specific CI runners or on their development environments.

This also multiplies the timeout for each test accordingly.  The
reason is that more concurrency can lead to less resources, and less
resources can lead to some specific tests taking longer to complete
and then time out.  The timeout factor being used here is very
conservative (being equal to the amount of parallel tasks).  The worst
this possibly oversized timeout value can do is making users wait a
bit longer for the job to finish if a test hangs.

Overall, users can expect a much quicker turnaround on most systems
with a value such as 8 on a 12 core machine.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 docs/devel/testing.rst | 12 ++++++++++++
 tests/Makefile.include |  6 +++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 23d3f44f52..5600123743 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -983,6 +983,18 @@ of Avocado or ``make check-avocado``, and can also be queried using:
 
   pyvenv/bin/avocado list tests/avocado
 
+To run tests in parallel, the ``AVOCADO_PARALLEL`` environment
+variable can be defined with a value different than ``1`` (its default
+value).  Example:
+
+ .. code::
+
+  make check-avocado AVOCADO_PARALLEL=4
+
+Please exercise care when using parallel execution with the QEMU
+Avocado tests as a higher system load can cause time sensitive tests
+to timeout and be interrupted.
+
 Manual Installation
 ~~~~~~~~~~~~~~~~~~~
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 6618bfed70..545b5155f9 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -94,6 +94,9 @@ TESTS_RESULTS_DIR=$(BUILD_DIR)/tests/results
 ifndef AVOCADO_TESTS
 	AVOCADO_TESTS=tests/avocado
 endif
+ifndef AVOCADO_PARALLEL
+	AVOCADO_PARALLEL=1
+endif
 # Controls the output generated by Avocado when running tests.
 # Any number of command separated loggers are accepted.  For more
 # information please refer to "avocado --help".
@@ -141,7 +144,8 @@ check-avocado: check-venv $(TESTS_RESULTS_DIR) get-vm-images
             --show=$(AVOCADO_SHOW) run --job-results-dir=$(TESTS_RESULTS_DIR) \
             $(if $(AVOCADO_TAGS),, --filter-by-tags-include-empty \
 			--filter-by-tags-include-empty-key) \
-            $(AVOCADO_CMDLINE_TAGS) \
+            $(AVOCADO_CMDLINE_TAGS) --max-parallel-tasks=$(AVOCADO_PARALLEL) \
+			-p timeout_factor=$(AVOCADO_PARALLEL) \
             $(if $(GITLAB_CI),,--failfast) $(AVOCADO_TESTS), \
             "AVOCADO", "tests/avocado")
 
-- 
2.45.2


