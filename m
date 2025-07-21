Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084B9C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 08:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udlhM-0007q8-AR; Mon, 21 Jul 2025 04:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1udlhI-0007mI-QN
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 04:16:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1udlhG-0007di-CP
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 04:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753085789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1WCXbVocFzsQVyPGO/ot/WI0OKX4DtJui9aggN6qkPY=;
 b=ArTlaa01g/NlhvkOOMttRaCMKglXgAb/h7N8SnFNYpBoFJL/R3R1GRD8TvZgp+2LANrwrn
 a3AhpFTlQg6LlOA+hBSeMPhSO9JixgM5HXqv+TiIlnu0vL7CEGJLum1xmmdrtutMHS3AT7
 0p1GxGXZZ5s0oPl2xAvy3oLdoTVNjQM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-SnB46m2INUWIFtARHn6WPw-1; Mon,
 21 Jul 2025 04:16:27 -0400
X-MC-Unique: SnB46m2INUWIFtARHn6WPw-1
X-Mimecast-MFC-AGG-ID: SnB46m2INUWIFtARHn6WPw_1753085786
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE4DB1800365
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 08:16:26 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.77])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DAF8D19560A3; Mon, 21 Jul 2025 08:16:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 3/5] functional: ensure sockets and files are closed
Date: Mon, 21 Jul 2025 10:16:12 +0200
Message-ID: <20250721081614.262563-4-thuth@redhat.com>
In-Reply-To: <20250721081614.262563-1-thuth@redhat.com>
References: <20250721081614.262563-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

The multiprocess and virtio_gpu tests open sockets but then forget
to close them, which triggers resource leak warnings

The virtio_gpu test also fails to close a log file it opens.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250715143023.1851000-10-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_multiprocess.py | 3 +++
 tests/functional/test_virtio_gpu.py   | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/tests/functional/test_multiprocess.py b/tests/functional/test_multiprocess.py
index 751cf10e635..92d5207b0eb 100755
--- a/tests/functional/test_multiprocess.py
+++ b/tests/functional/test_multiprocess.py
@@ -83,6 +83,9 @@ def do_test(self, kernel_asset, initrd_asset,
                                           'cat /sys/bus/pci/devices/*/uevent',
                                           'PCI_ID=1000:0012')
 
+        proxy_sock.close()
+        remote_sock.close()
+
     def test_multiprocess(self):
         kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
         if self.arch == 'x86_64':
diff --git a/tests/functional/test_virtio_gpu.py b/tests/functional/test_virtio_gpu.py
index 81c9156d638..be96de24da2 100755
--- a/tests/functional/test_virtio_gpu.py
+++ b/tests/functional/test_virtio_gpu.py
@@ -108,6 +108,7 @@ def test_vhost_user_vga_virgl(self):
             shell=False,
             close_fds=False,
         )
+        self._vug_log_file.close()
 
         self.vm.set_console()
         self.vm.add_args("-cpu", "host")
@@ -135,6 +136,7 @@ def test_vhost_user_vga_virgl(self):
                                           "features: +virgl +edid")
         self.vm.shutdown()
         qemu_sock.close()
+        vug_sock.close()
         vugp.terminate()
         vugp.wait()
 
-- 
2.50.0


