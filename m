Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7118BD78325
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6uz-0000pM-9p; Mon, 02 Dec 2024 08:56:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI6ux-0000p9-Oo
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:56:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI6uv-0001LQ-QD
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733147808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZ9foHFdOkg4z4H/5ThYeBfpoY6CdLzaaxf1lfsA56w=;
 b=Peyjhm4n9YiGbQttJmqTkcvPcnSNIRxeccTnfW9hPew0ud35FccuPaaCZQKLMaAmIyTCep
 PrYCOpIpdqAfgk0KYNhfrFVAWn4F+WcOw2MgUOoO6GoeuB1MuRdqEnXLHQb91bm/EFx3iA
 w2cbGKomMxc2L/Tgmevvc6w2UieF8Ws=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-KEkxBv4iOu2z8egkoC50wQ-1; Mon,
 02 Dec 2024 08:56:47 -0500
X-MC-Unique: KEkxBv4iOu2z8egkoC50wQ-1
X-Mimecast-MFC-AGG-ID: KEkxBv4iOu2z8egkoC50wQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE25B1954AF2; Mon,  2 Dec 2024 13:56:45 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-206.str.redhat.com
 [10.33.192.206])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2C1E1956089; Mon,  2 Dec 2024 13:56:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/3] tests/functional/test_virtio_version: Check for the
 availability of the machine
Date: Mon,  2 Dec 2024 14:56:39 +0100
Message-ID: <20241202135640.80528-3-thuth@redhat.com>
In-Reply-To: <20241202135640.80528-1-thuth@redhat.com>
References: <20241202135640.80528-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Use self_set_machine() to set and check for the availability of the
default pc machine (so that the test is not failing if the machine
has not been included in the QEMU binary).

Message-ID: <20241128120142.593408-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_virtio_version.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/functional/test_virtio_version.py b/tests/functional/test_virtio_version.py
index eb23060564..92e3f5caf0 100755
--- a/tests/functional/test_virtio_version.py
+++ b/tests/functional/test_virtio_version.py
@@ -141,6 +141,7 @@ def check_all_variants(self, qemu_devtype, virtio_devid):
 
 
     def test_conventional_devs(self):
+        self.set_machine('pc')
         self.check_all_variants('virtio-net-pci', VIRTIO_NET)
         # virtio-blk requires 'driver' parameter
         #self.check_all_variants('virtio-blk-pci', VIRTIO_BLOCK)
@@ -167,6 +168,7 @@ def check_modern_only(self, qemu_devtype, virtio_devid):
         self.assertIn('pci-express-device', ifaces)
 
     def test_modern_only_devs(self):
+        self.set_machine('pc')
         self.check_modern_only('virtio-vga', VIRTIO_GPU)
         self.check_modern_only('virtio-gpu-pci', VIRTIO_GPU)
         self.check_modern_only('virtio-mouse-pci', VIRTIO_INPUT)
-- 
2.47.0


