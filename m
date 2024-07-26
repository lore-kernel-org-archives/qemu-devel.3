Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DEEC3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 13:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXLFs-0004EN-IT; Fri, 26 Jul 2024 09:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sXLFp-00046f-Br
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 09:45:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sXLFn-0001gZ-Ec
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 09:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722001502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RKmLOo511M5++BDmKAMU+H3V3j7+sw7OERXfgONtCK4=;
 b=ORYpRfQFJKajMirLkjj3wZUUB8LJHDL0M4c7PAKXSOBHhGhEYJqh5xC9rQxUxlDC8+itwh
 yKyPM5uXMMS0CVTvY9CTi/W2KzY5APSKFfTdC/jag7vyCBIaujvf5zJQKmkshjENpDwtON
 FCV8viLm10G4nGbGHlu3PYvHXIiljT0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-QtkdACIBPma6-WCXhF2TOg-1; Fri,
 26 Jul 2024 09:45:00 -0400
X-MC-Unique: QtkdACIBPma6-WCXhF2TOg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E48F21955D53; Fri, 26 Jul 2024 13:44:57 +0000 (UTC)
Received: from p1.localdomain.com (unknown [10.22.17.77])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E6F51955D4A; Fri, 26 Jul 2024 13:44:52 +0000 (UTC)
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
Subject: [PATCH 02/13] tests/avocado: mips: add hint for fetchasset plugin
Date: Fri, 26 Jul 2024 09:44:27 -0400
Message-ID: <20240726134438.14720-3-crosa@redhat.com>
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

Avocado's fetchasset plugin runs before the actual Avocado job (and
any test).  It analyses the test's code looking for occurrences of
"self.fetch_asset()" in the either the actual test or setUp() method.
It's not able to fully analyze all code, though.

The way these tests are written, make the fetchasset plugin blind to
the assets.  This adds some more code duplication, true, but it will
aid the fetchasset plugin to download or verify the existence of these
assets in advance.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/avocado/boot_linux_console.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 450d67be6a..b8b0a4df10 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -274,8 +274,7 @@ def test_mips64el_malta_5KEc_cpio(self):
         # Wait for VM to shut down gracefully
         self.vm.wait()
 
-    def do_test_mips_malta32el_nanomips(self, kernel_url, kernel_hash):
-        kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+    def do_test_mips_malta32el_nanomips(self, kernel_path_xz):
         kernel_path = self.workdir + "kernel"
         with lzma.open(kernel_path_xz, 'rb') as f_in:
             with open(kernel_path, 'wb') as f_out:
@@ -303,7 +302,8 @@ def test_mips_malta32el_nanomips_4k(self):
                       'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
                       'generic_nano32r6el_page4k.xz')
         kernel_hash = '477456aafd2a0f1ddc9482727f20fe9575565dd6'
-        self.do_test_mips_malta32el_nanomips(kernel_url, kernel_hash)
+        kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
 
     def test_mips_malta32el_nanomips_16k_up(self):
         """
@@ -316,7 +316,8 @@ def test_mips_malta32el_nanomips_16k_up(self):
                       'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
                       'generic_nano32r6el_page16k_up.xz')
         kernel_hash = 'e882868f944c71c816e832e2303b7874d044a7bc'
-        self.do_test_mips_malta32el_nanomips(kernel_url, kernel_hash)
+        kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
 
     def test_mips_malta32el_nanomips_64k_dbg(self):
         """
@@ -329,7 +330,8 @@ def test_mips_malta32el_nanomips_64k_dbg(self):
                       'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
                       'generic_nano32r6el_page64k_dbg.xz')
         kernel_hash = '18d1c68f2e23429e266ca39ba5349ccd0aeb7180'
-        self.do_test_mips_malta32el_nanomips(kernel_url, kernel_hash)
+        kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
 
     def test_aarch64_xlnx_versal_virt(self):
         """
-- 
2.45.2


