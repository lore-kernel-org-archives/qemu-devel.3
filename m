Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6E6C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 11:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRsPe-00042I-1v; Thu, 11 Jul 2024 07:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sRsPN-00036U-5w
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:56:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sRsPA-000477-WB
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720698968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kFDx3AzhkOo696BWjrSPKvBIZNzTiUauoq2tCa2FXRQ=;
 b=LpGvFQ1hnuWsJxizmWhbYZFZ8eBud0pnnNeY1tWWaZdBS8AxXcLx5KQIlzIWjQHzVKiljB
 N218YeQFO6LD6DFRlnJt2JanbQaGNHJwBLdhGr6eJKeYNyau2tmd4/YMk8I1Di+2EF8w4h
 EtoixkGnLdTCyv0HY5oPC7c1qRgLcfU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-lSR4S4ZyOLmSRa-sjdVGsw-1; Thu,
 11 Jul 2024 07:56:05 -0400
X-MC-Unique: lSR4S4ZyOLmSRa-sjdVGsw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38D6518B65CA; Thu, 11 Jul 2024 11:56:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.118])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0A6DD1955E85; Thu, 11 Jul 2024 11:55:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH 2/8] tests/pytest: Convert some simple avocado tests into
 pytests
Date: Thu, 11 Jul 2024 13:55:40 +0200
Message-ID: <20240711115546.40859-3-thuth@redhat.com>
In-Reply-To: <20240711115546.40859-1-thuth@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

These test are rather simple and don't need any modifications apart
from adjusting the "from avocado_qemu" line. These tests can now
be run directly via "pytest" by setting the PYTHONPATH environment
variable to the python folder of QEMU and by providing the QEMU
binary via the PYTEST_QEMU_BINARY environment variable, and the source
and build directories via the PYTEST_SOURCE_ROOTand PYTEST_BUILD_ROOT
environment variables.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/{avocado/cpu_queries.py => pytest/test_cpu_queries.py}   | 2 +-
 .../empty_cpu_model.py => pytest/test_empty_cpu_model.py}      | 2 +-
 .../mem-addr-space-check.py => pytest/test_mem_addr_space.py}  | 3 +--
 .../virtio_version.py => pytest/test_virtio_version.py}        | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)
 rename tests/{avocado/cpu_queries.py => pytest/test_cpu_queries.py} (96%)
 rename tests/{avocado/empty_cpu_model.py => pytest/test_empty_cpu_model.py} (94%)
 rename tests/{avocado/mem-addr-space-check.py => pytest/test_mem_addr_space.py} (99%)
 rename tests/{avocado/virtio_version.py => pytest/test_virtio_version.py} (99%)

diff --git a/tests/avocado/cpu_queries.py b/tests/pytest/test_cpu_queries.py
similarity index 96%
rename from tests/avocado/cpu_queries.py
rename to tests/pytest/test_cpu_queries.py
index d3faa14720..b300447121 100644
--- a/tests/avocado/cpu_queries.py
+++ b/tests/pytest/test_cpu_queries.py
@@ -8,7 +8,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from avocado_qemu import QemuSystemTest
+from qemu_pytest import QemuSystemTest
 
 class QueryCPUModelExpansion(QemuSystemTest):
     """
diff --git a/tests/avocado/empty_cpu_model.py b/tests/pytest/test_empty_cpu_model.py
similarity index 94%
rename from tests/avocado/empty_cpu_model.py
rename to tests/pytest/test_empty_cpu_model.py
index d906ef3d3c..113740bc82 100644
--- a/tests/avocado/empty_cpu_model.py
+++ b/tests/pytest/test_empty_cpu_model.py
@@ -7,7 +7,7 @@
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
-from avocado_qemu import QemuSystemTest
+from qemu_pytest import QemuSystemTest
 
 class EmptyCPUModel(QemuSystemTest):
     def test(self):
diff --git a/tests/avocado/mem-addr-space-check.py b/tests/pytest/test_mem_addr_space.py
similarity index 99%
rename from tests/avocado/mem-addr-space-check.py
rename to tests/pytest/test_mem_addr_space.py
index 85541ea051..6ae7ba5e6b 100644
--- a/tests/avocado/mem-addr-space-check.py
+++ b/tests/pytest/test_mem_addr_space.py
@@ -8,8 +8,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from avocado_qemu import QemuSystemTest
-import signal
+from qemu_pytest import QemuSystemTest
 import time
 
 class MemAddrCheck(QemuSystemTest):
diff --git a/tests/avocado/virtio_version.py b/tests/pytest/test_virtio_version.py
similarity index 99%
rename from tests/avocado/virtio_version.py
rename to tests/pytest/test_virtio_version.py
index afe5e828b5..ca3aa806df 100644
--- a/tests/avocado/virtio_version.py
+++ b/tests/pytest/test_virtio_version.py
@@ -12,7 +12,7 @@
 import os
 
 from qemu.machine import QEMUMachine
-from avocado_qemu import QemuSystemTest
+from qemu_pytest import QemuSystemTest
 
 # Virtio Device IDs:
 VIRTIO_NET = 1
-- 
2.45.2


