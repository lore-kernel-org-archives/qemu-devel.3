Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA57C52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 17:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbO3v-0004MV-Gr; Tue, 06 Aug 2024 13:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sbO3s-0003xt-W2
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 13:33:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sbO3r-0006Vu-B3
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 13:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722965606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nf0S6+2UWAoiK8QJhCNo+DMvi4LJgeUAgWrNmgWlrjc=;
 b=TkhlzPS74T1RjmKNXAL+vUU3QmxQDvhqalWlI1+i3g+cB1Q9uvaKfcq9sCmZM/7wo7LE4j
 WfjJevnl0yECsioNB4FWABcGygHkM/IezBXwPcUkIs36TOSIGw91gYozXHuPw0NDl2T4B0
 aMACGhctTsshVh2MgckEsMO3TtNiTDg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-z6V6pmDHM0m4MjOMBls8sg-1; Tue,
 06 Aug 2024 13:33:22 -0400
X-MC-Unique: z6V6pmDHM0m4MjOMBls8sg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A773F1955D42; Tue,  6 Aug 2024 17:33:15 +0000 (UTC)
Received: from p1.localdomain.com (unknown [10.39.192.15])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 809E819560AE; Tue,  6 Aug 2024 17:33:06 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Radoslaw Biernacki <rad@semihalf.com>, Troy Lee <leetroy@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Beraldo Leal <bleal@redhat.com>,
 kvm@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paul Durrant <paul@xen.org>, Eric Auger <eric.auger@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>
Subject: [PATCH v2 9/9] Avocado tests: allow for parallel execution of tests
Date: Tue,  6 Aug 2024 13:31:19 -0400
Message-ID: <20240806173119.582857-10-crosa@redhat.com>
In-Reply-To: <20240806173119.582857-1-crosa@redhat.com>
References: <20240806173119.582857-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index af73d3d64f..97ebc8211f 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -998,6 +998,18 @@ of Avocado or ``make check-avocado``, and can also be queried using:
 
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
index 537804d101..545b5155f9 100644
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
-            $(AVOCADO_CMDLINE_TAGS) --max-parallel-tasks=1 \
+            $(AVOCADO_CMDLINE_TAGS) --max-parallel-tasks=$(AVOCADO_PARALLEL) \
+			-p timeout_factor=$(AVOCADO_PARALLEL) \
             $(if $(GITLAB_CI),,--failfast) $(AVOCADO_TESTS), \
             "AVOCADO", "tests/avocado")
 
-- 
2.45.2


