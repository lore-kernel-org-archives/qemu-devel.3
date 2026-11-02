Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83B7606B0D0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a4XqlRch
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuvc-0006UO-Tw; Mon, 02 Nov 2026 11:30:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuva-0006RZ-Tt
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvZ-0002JR-6l
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793637032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wmX1CMsxF5RI5UEllbDOjKHwLZhQWtPWIAgkfmEEVNk=;
 b=a4XqlRchKv4zy8CJ/WdyWOsBvjLnpydNASI45iqkbNfo0No+y3fwer45fRwoKiELEO+1eR
 VU83fDFqd7Ukr7s1MJB81ixi2nboFzevjHOc4T85RmdggJYpqROo1tpUiQKcTeqKYn3+Tb
 ICY67KqSCTqu1m1UESqpO4iBU311kew=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-dSMz1KPtPfyHvkZESokYlw-1; Mon,
 02 Nov 2026 11:30:28 -0500
X-MC-Unique: dSMz1KPtPfyHvkZESokYlw-1
X-Mimecast-MFC-AGG-ID: dSMz1KPtPfyHvkZESokYlw_1793637027
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33A431800661; Mon,  2 Nov 2026 16:30:27 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.164])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9906B1956087; Mon,  2 Nov 2026 16:30:24 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 12/17] iotests: cover discard passthrough during background
 mirror
Date: Mon,  2 Nov 2026 17:29:50 +0100
Message-ID: <20261102162955.268763-13-kwolf@redhat.com>
In-Reply-To: <20261102162955.268763-1-kwolf@redhat.com>
References: <20261102162955.268763-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Haoqian He <haoqian.he@smartx.com>

A mirror_top node without BDRV_O_UNMAP silently ignores discard
requests.

Add a regression test to verify that discard requests are not
ignored during background mirror.

Signed-off-by: Haoqian He <haoqian.he@smartx.com>
Message-ID: <20261030162041.3191556-1-haoqian.he@smartx.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/tests/mirror-discard     | 73 +++++++++++++++++++++
 tests/qemu-iotests/tests/mirror-discard.out |  5 ++
 2 files changed, 78 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/mirror-discard
 create mode 100644 tests/qemu-iotests/tests/mirror-discard.out

diff --git a/tests/qemu-iotests/tests/mirror-discard b/tests/qemu-iotests/tests/mirror-discard
new file mode 100755
index 00000000000..4b89e9bc7dc
--- /dev/null
+++ b/tests/qemu-iotests/tests/mirror-discard
@@ -0,0 +1,73 @@
+#!/usr/bin/env python3
+# group: rw auto quick
+#
+# Test that discard reaches the source through a blockdev-mirror filter.
+#
+# Copyright (C) 2026 SmartX, Inc.
+
+from pathlib import Path
+
+import iotests
+
+
+source = Path(iotests.test_dir, 'mirror-discard-source.qcow2')
+target = Path(iotests.test_dir, 'mirror-discard-target.qcow2')
+
+
+class TestMirrorDiscard(iotests.QMPTestCase):
+    def setUp(self):
+        for path in (source, target):
+            self.addCleanup(path.unlink, missing_ok=True)
+            iotests.qemu_img_create(
+                '-f', iotests.imgfmt,
+                '-o', 'compat=1.1,cluster_size=65536', str(path), '1M')
+
+        self.vm = iotests.VM()
+        # Cleanups run in reverse order: close the VM before removing images.
+        self.addCleanup(self.vm.shutdown)
+        self.vm.add_drive(str(source), opts='discard=unmap,node-name=src')
+        self.vm.add_blockdev(
+            f'driver={iotests.imgfmt},node-name=target,'
+            f'file.driver=file,file.filename={target}')
+        self.vm.launch()
+
+    def test_background_discard(self):
+        self.vm.cmd('x-qemu-io', device='drive0',
+                    command='write -q -P 0xab 0 192k')
+
+        # Check discard works before mirror_top is inserted, then restore data.
+        self.vm.cmd('x-qemu-io', device='drive0',
+                    command='discard -q 64k 64k')
+        self.vm.cmd('x-qemu-io', device='drive0',
+                    command='read -q -P 0x00 64k 64k')
+        self.vm.cmd('x-qemu-io', device='drive0',
+                    command='write -q -P 0xab 64k 64k')
+
+        self.vm.cmd('blockdev-mirror', job_id='mirror', device='drive0',
+                    target='target', sync='full', copy_mode='background')
+        self.wait_ready('mirror')
+        self.pause_job('mirror')
+
+        # Use the backend so the request passes through mirror_top to src.
+        self.vm.cmd('x-qemu-io', device='drive0',
+                    command='discard -q 64k 64k')
+        checks = (
+            'read -q -P 0x00 64k 64k',
+            'read -q -P 0xab 0 64k',
+            'read -q -P 0xab 128k 64k',
+        )
+        for command in checks:
+            self.vm.cmd('x-qemu-io', device='drive0', command=command)
+
+        self.vm.cmd('block-job-resume', device='mirror')
+        self.complete_and_wait('mirror', wait_ready=False)
+        self.vm.shutdown()
+
+        # Check both images independently after all writes have been flushed.
+        for path in (source, target):
+            for command in checks:
+                iotests.qemu_io('-f', iotests.imgfmt, '-c', command, str(path))
+
+
+if __name__ == '__main__':
+    iotests.main(supported_fmts=['qcow2'], supported_protocols=['file'])
diff --git a/tests/qemu-iotests/tests/mirror-discard.out b/tests/qemu-iotests/tests/mirror-discard.out
new file mode 100644
index 00000000000..ae1213e6f86
--- /dev/null
+++ b/tests/qemu-iotests/tests/mirror-discard.out
@@ -0,0 +1,5 @@
+.
+----------------------------------------------------------------------
+Ran 1 tests
+
+OK
-- 
2.56.0


