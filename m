Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0979CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 19:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4P7x-0007Nb-IY; Thu, 02 Oct 2025 15:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v4P7o-0007Kj-5a
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:38:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v4P7X-0000ZA-Aq
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759433857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vkj8Y8HGC5BdazHkziF8Ypl9wP8rIPQNT0W0slOVMZw=;
 b=BhfMqkm4bSMUFOyf3u/1rqk4KoLlJRMu98QKukaxVkZsd4s4X2x1AxRN0/SzJF3fjO6hur
 /aZbtahRvu+lzpIAlzVL9dYygeXkFa+ZHtE6emSxaere5bT5Oga7y5HyKsB+TTuNTfl/EI
 y1mlwB+84YYYyDLBQdZqBqTUhT8ELFE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-sQNsz0n1NOi5TutPEIvOkg-1; Thu,
 02 Oct 2025 15:37:35 -0400
X-MC-Unique: sQNsz0n1NOi5TutPEIvOkg-1
X-Mimecast-MFC-AGG-ID: sQNsz0n1NOi5TutPEIvOkg_1759433854
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4593719560B7; Thu,  2 Oct 2025 19:37:34 +0000 (UTC)
Received: from localhost (unknown [10.2.16.139])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DC3C91800452; Thu,  2 Oct 2025 19:37:33 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Jean-Louis Dupond <jean-louis@dupond.be>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 3/3] iotests: add Linux loop device image creation test
Date: Thu,  2 Oct 2025 14:40:00 -0400
Message-ID: <20251002184000.410486-4-stefanha@redhat.com>
In-Reply-To: <20251002184000.410486-1-stefanha@redhat.com>
References: <20251002184000.410486-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This qemu-iotests test case is based on the reproducer that Jean-Louis
Dupond <jean-louis@dupond.be> shared in
https://gitlab.com/qemu-project/qemu/-/issues/3127.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/tests/loop-create-file     | 59 +++++++++++++++++++
 tests/qemu-iotests/tests/loop-create-file.out |  8 +++
 2 files changed, 67 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/loop-create-file
 create mode 100644 tests/qemu-iotests/tests/loop-create-file.out

diff --git a/tests/qemu-iotests/tests/loop-create-file b/tests/qemu-iotests/tests/loop-create-file
new file mode 100755
index 0000000000..5ec75b046b
--- /dev/null
+++ b/tests/qemu-iotests/tests/loop-create-file
@@ -0,0 +1,59 @@
+#!/usr/bin/env bash
+# group: quick
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright Red Hat, Inc.
+#
+# Test Linux loop device image creation
+#
+# This test verifies #3127 "qemu-img create fails on loop device with sector size 4096"
+# https://gitlab.com/qemu-project/qemu/-/issues/3127
+
+seq="$(basename $0)"
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+_cleanup() {
+    if [ -n "$loopdev" ]; then
+        sudo losetup --detach "$loopdev"
+    fi
+
+    _cleanup_test_img
+}
+
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+cd ..
+. ./common.rc
+. ./common.filter
+
+_supported_fmt raw
+_supported_proto file
+_supported_os Linux
+
+if ! sudo -n losetup &>/dev/null; then
+    _notrun "sudo losetup not available"
+fi
+
+echo
+echo "=== Create image on a 4 KB sector size loop device ==="
+echo
+
+_make_test_img -f $IMGFMT 1M
+
+loopdev=$(sudo losetup --sector-size 4096 --find --show "$TEST_IMG")
+if [ -z "$loopdev" ]; then
+    _fail
+fi
+
+sudo $QEMU_IMG_PROG create -f raw "$loopdev" 1M | \
+    sed -e "s#/dev/loop[0-9]\\+#LOOPDEV#g"
+
+# success, all done
+echo
+echo '*** done'
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/tests/loop-create-file.out b/tests/qemu-iotests/tests/loop-create-file.out
new file mode 100644
index 0000000000..32d4155695
--- /dev/null
+++ b/tests/qemu-iotests/tests/loop-create-file.out
@@ -0,0 +1,8 @@
+QA output created by loop-create-file
+
+=== Create image on a 4 KB sector size loop device ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+Formatting 'LOOPDEV', fmt=raw size=1048576
+
+*** done
-- 
2.51.0


