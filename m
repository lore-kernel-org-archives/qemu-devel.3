Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC3ACA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 11:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoKSm-0003rK-1f; Tue, 19 Aug 2025 07:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uoKSj-0003pZ-9W
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:25:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uoKSf-0007QO-QO
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755602705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=29ofl8DLYoPL4tRUjgwSOAhBcMgWVoFRR3QRLdl+5Lg=;
 b=duQpR8eiLu1jXsbXU0s6tCo2oVQrQ8J4FCpy02LzOO04NtqK9tJwOUFvr21P84zrvPyktt
 gFFqnhHLLDnJiKAxp27Oruryn50/0xfUF22HWkAb5dCU9cHNVOqL+yGtVpmxam1Mpe+oyt
 Ba3v0TygseIjTfXv2rjtxCYrWsClOq8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-22NPqekjM--3eefFqBdSXg-1; Tue,
 19 Aug 2025 07:25:03 -0400
X-MC-Unique: 22NPqekjM--3eefFqBdSXg-1
X-Mimecast-MFC-AGG-ID: 22NPqekjM--3eefFqBdSXg_1755602702
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C986C195609F; Tue, 19 Aug 2025 11:25:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.251])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C200530001A8; Tue, 19 Aug 2025 11:25:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 18/25] tests/functional: Move rx test into target-specific
 folders
Date: Tue, 19 Aug 2025 13:23:55 +0200
Message-ID: <20250819112403.432587-19-thuth@redhat.com>
In-Reply-To: <20250819112403.432587-1-thuth@redhat.com>
References: <20250819112403.432587-1-thuth@redhat.com>
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

From: Thomas Huth <thuth@redhat.com>

Move the architecture specific test into an architecture specific
subdirectory.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                               | 2 +-
 tests/functional/meson.build                              | 5 +----
 tests/functional/rx/meson.build                           | 5 +++++
 tests/functional/{test_rx_gdbsim.py => rx/test_gdbsim.py} | 0
 4 files changed, 7 insertions(+), 5 deletions(-)
 create mode 100644 tests/functional/rx/meson.build
 rename tests/functional/{test_rx_gdbsim.py => rx/test_gdbsim.py} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 81262546c4b..c6410a5f5fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1721,7 +1721,7 @@ R: Yoshinori Sato <yoshinori.sato@nifty.com>
 S: Orphan
 F: docs/system/target-rx.rst
 F: hw/rx/rx-gdbsim.c
-F: tests/functional/test_rx_gdbsim.py
+F: tests/functional/rx/test_gdbsim.py
 
 SH4 Machines
 ------------
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 2d8f67fd94f..7e7a6aa0c93 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -28,6 +28,7 @@ subdir('ppc')
 subdir('ppc64')
 subdir('riscv32')
 subdir('riscv64')
+subdir('rx')
 
 test_s390x_timeouts = {
   's390x_ccw_virtio' : 420,
@@ -58,10 +59,6 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
-tests_rx_system_thorough = [
-  'rx_gdbsim',
-]
-
 tests_s390x_system_thorough = [
   's390x_ccw_virtio',
   's390x_pxelinux',
diff --git a/tests/functional/rx/meson.build b/tests/functional/rx/meson.build
new file mode 100644
index 00000000000..6af83a9f23f
--- /dev/null
+++ b/tests/functional/rx/meson.build
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+tests_rx_system_thorough = [
+  'gdbsim',
+]
diff --git a/tests/functional/test_rx_gdbsim.py b/tests/functional/rx/test_gdbsim.py
similarity index 100%
rename from tests/functional/test_rx_gdbsim.py
rename to tests/functional/rx/test_gdbsim.py
-- 
2.50.1


