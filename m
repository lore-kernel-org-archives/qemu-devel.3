Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1107C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 05:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuPuH-0005ni-GZ; Tue, 18 Mar 2025 01:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tuPuF-0005nE-QP
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 01:54:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tuPuE-0004B1-3N
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 01:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742277264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CE259BpaNvuidCqDkrVqSHZvjw0om3Zlq8id+yeozUQ=;
 b=QnhxzKoph978sSJdyvtCycfuBZdP8v6+1g2gpSOzlnkqUgCxCNKIgKVr9xGwj7gPHGLrTD
 pl4yTyXxxWqnW0EKhnX2sQrwk6AKgFe5m2WI5XpybqG33ryKkphuLSbkUKrCtxg0IshYLf
 LKlEx9rcI9VSyZFnpJvfo92Z4VuaKtA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-O0-sr1KmM8eJDcjUDJO5dw-1; Tue,
 18 Mar 2025 01:54:22 -0400
X-MC-Unique: O0-sr1KmM8eJDcjUDJO5dw-1
X-Mimecast-MFC-AGG-ID: O0-sr1KmM8eJDcjUDJO5dw_1742277261
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD9C5195609F; Tue, 18 Mar 2025 05:54:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.69])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2940C1956095; Tue, 18 Mar 2025 05:54:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Niek Linnenbank <nieklinnenbank@gmail.com>
Cc: qemu-arm@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Subject: [PATCH] docs/system: Use the meson binary from the pyvenv
Date: Tue, 18 Mar 2025 06:54:15 +0100
Message-ID: <20250318055415.16501-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

To avoid problems with the meson installation from the host
system, we should always use the meson from our venv instead.
Thus use this in the documentation, too.

While we're at it, also mention that it has to be run from
the build folder (in the igb.rst file; the other two files
were already fine).

Suggested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/system/arm/bananapi_m2u.rst | 2 +-
 docs/system/arm/orangepi.rst     | 2 +-
 docs/system/devices/igb.rst      | 5 +++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/docs/system/arm/bananapi_m2u.rst b/docs/system/arm/bananapi_m2u.rst
index d30db8d04c3..6efa222c16f 100644
--- a/docs/system/arm/bananapi_m2u.rst
+++ b/docs/system/arm/bananapi_m2u.rst
@@ -136,4 +136,4 @@ provide the following command:
 
   $ cd qemu-build-dir
   $ QEMU_TEST_ALLOW_LARGE_STORAGE=1 \
-    meson test --suite thorough func-arm-arm_bpim2u
+    pyvenv/bin/meson test --suite thorough func-arm-arm_bpim2u
diff --git a/docs/system/arm/orangepi.rst b/docs/system/arm/orangepi.rst
index 8b9448ca7b0..716062fca9c 100644
--- a/docs/system/arm/orangepi.rst
+++ b/docs/system/arm/orangepi.rst
@@ -262,4 +262,4 @@ provide the following command from the build directory:
 .. code-block:: bash
 
   $ QEMU_TEST_ALLOW_LARGE_STORAGE=1 \
-    meson test --suite thorough func-arm-arm_orangepi
+    pyvenv/bin/meson test --suite thorough func-arm-arm_orangepi
diff --git a/docs/system/devices/igb.rst b/docs/system/devices/igb.rst
index 9145af5c757..71f31cb1160 100644
--- a/docs/system/devices/igb.rst
+++ b/docs/system/devices/igb.rst
@@ -57,11 +57,12 @@ directory:
   meson test qtest-x86_64/qos-test
 
 ethtool can test register accesses, interrupts, etc. It is automated as an
-functional test and can be ran with the following command:
+functional test and can be run from the build directory with the following
+command:
 
 .. code:: shell
 
-  meson test --suite thorough func-x86_64-netdev_ethtool
+  pyvenv/bin/meson test --suite thorough func-x86_64-netdev_ethtool
 
 References
 ==========
-- 
2.48.1


