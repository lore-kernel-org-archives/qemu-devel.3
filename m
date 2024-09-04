Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B64CD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slnQb-000151-4h; Wed, 04 Sep 2024 06:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnQW-0000v2-Vw
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:39:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnQU-0008FE-33
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725446389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BMmbydglAELKpmk+ohQFujCo7ibecsv4RofmDD8GiRk=;
 b=gy/VreAaXiE1iz7psBDs5ne2iS5ZWk6nXjOI6tvNqgiaW73RXsdz7YHBg/DujmB8xIakxW
 h8kokB5vAuvteg9/L+M2PhaTHC/ASYBPDAwuxIvFxTY7K6sHyrNQ+mPXa5bcO1LGPktl3M
 Gx+dnMQG1f8slRuUSJEavy87EZmCTkw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-ETdytfNiORuc5KNcJ4FDSA-1; Wed,
 04 Sep 2024 06:39:48 -0400
X-MC-Unique: ETdytfNiORuc5KNcJ4FDSA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CCEA19560AB; Wed,  4 Sep 2024 10:39:47 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.48])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B6D27195605A; Wed,  4 Sep 2024 10:39:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 06/42] tests/avocado/boot_linux_console: Remove the s390x
 subtest
Date: Wed,  4 Sep 2024 12:38:41 +0200
Message-ID: <20240904103923.451847-7-thuth@redhat.com>
In-Reply-To: <20240904103923.451847-1-thuth@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

We've got a much more sophisticated, Fedora-based test for s390x
("test_s390x_fedora" in another file) already, so the test in
boot_linux_console.py seems to be rather a waste of precious test
cycles. Thus move the command line check and delete the s390x
test in boot_linux_console.py.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240830133841.142644-7-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/boot_linux_console.py      | 20 --------------------
 tests/avocado/machine_s390_ccw_virtio.py |  2 ++
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index cffdd6b5a2..18c69d6acc 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -1304,26 +1304,6 @@ def test_aarch64_raspi3_atf(self):
         self.vm.launch()
         self.wait_for_console_pattern('version UEFI Firmware v1.15')
 
-    def test_s390x_s390_ccw_virtio(self):
-        """
-        :avocado: tags=arch:s390x
-        :avocado: tags=machine:s390-ccw-virtio
-        """
-        kernel_url = ('https://archives.fedoraproject.org/pub/archive'
-                      '/fedora-secondary/releases/29/Everything/s390x/os/images'
-                      '/kernel.img')
-        kernel_hash = 'e8e8439103ef8053418ef062644ffd46a7919313'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-
-        self.vm.set_console()
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=sclp0'
-        self.vm.add_args('-nodefaults',
-                         '-kernel', kernel_path,
-                         '-append', kernel_command_line)
-        self.vm.launch()
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.wait_for_console_pattern(console_pattern)
-
     def test_alpha_clipper(self):
         """
         :avocado: tags=arch:alpha
diff --git a/tests/avocado/machine_s390_ccw_virtio.py b/tests/avocado/machine_s390_ccw_virtio.py
index 26e938c9e9..7a214110fc 100644
--- a/tests/avocado/machine_s390_ccw_virtio.py
+++ b/tests/avocado/machine_s390_ccw_virtio.py
@@ -200,6 +200,8 @@ def test_s390x_fedora(self):
                          '-device', 'virtio-rng-ccw,devno=fe.1.9876',
                          '-device', 'virtio-gpu-ccw,devno=fe.2.5432')
         self.vm.launch()
+        self.wait_for_console_pattern('Kernel command line: %s'
+                                      % kernel_command_line)
         self.wait_for_console_pattern('Entering emergency mode')
 
         # Some tests to see whether the CLI options have been considered:
-- 
2.46.0


