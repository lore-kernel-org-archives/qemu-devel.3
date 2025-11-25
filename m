Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DC1D0E6F5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 16:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNvkU-0007UZ-LF; Tue, 25 Nov 2025 11:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vNvj8-0006qE-Lj
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 11:17:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vNvj6-00057Z-DD
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 11:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764087431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5mTXbugE+NHdNMCReF9WvlvDH492zviirZpTg38MZws=;
 b=Hjk0q0rDymogWXZlFSqPM6huLl94eWZxiRcubC8zN2HRhD2w86czHllt3uyz1dC8o/8vtw
 ZbdOyq5gHEt8gBcjZZvcjNMiiRCjGCM6juAwk8qrO3xHXZvepEF+KOQwbgnEm+boLy+WB5
 pv1zeZ8OJ7j2wJCI5qQCvvEWyh1+djQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-KvQKVri-NuKMlvZCPn1uYQ-1; Tue,
 25 Nov 2025 11:17:07 -0500
X-MC-Unique: KvQKVri-NuKMlvZCPn1uYQ-1
X-Mimecast-MFC-AGG-ID: KvQKVri-NuKMlvZCPn1uYQ_1764087427
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED3371956048; Tue, 25 Nov 2025 16:17:06 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.226.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 939B618004A3; Tue, 25 Nov 2025 16:17:05 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 4/4] iotests: add Linux loop device image creation test
Date: Tue, 25 Nov 2025 17:16:48 +0100
Message-ID: <20251125161648.259321-5-kwolf@redhat.com>
In-Reply-To: <20251125161648.259321-1-kwolf@redhat.com>
References: <20251125161648.259321-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

This qemu-iotests test case is based on the reproducer that Jean-Louis
Dupond <jean-louis@dupond.be> shared in
https://gitlab.com/qemu-project/qemu/-/issues/3127.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20251007141700.71891-4-stefanha@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.51.1


