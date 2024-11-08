Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416B4D5E154
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 10:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9MSp-0004BC-BD; Fri, 08 Nov 2024 05:43:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t9MSn-0004Ap-H9
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 05:43:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t9MSm-00069K-1V
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 05:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731062614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CMuUUvGLZUGnjgrtZ1Hge+8c+GqUOUr5D8XPyFlA4w8=;
 b=fmSm7TUzRw1otx0IuHZ31BYes7sYb0rUyb9a325O04bEmveoFehC+Vepf3CuVKssTar3SQ
 xbdE4Bz2Y/O7EyEETnOe6LRBCUJUUMCvxtcdUqWcURPgHGaBidDtxUvHbxrPEdzaYSPUhW
 f9dy+tfYMQtuXGR1clrzLqkhSQ8jqsY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-P4xgiNg-OCG6RLhzihI54w-1; Fri,
 08 Nov 2024 05:43:31 -0500
X-MC-Unique: P4xgiNg-OCG6RLhzihI54w-1
X-Mimecast-MFC-AGG-ID: P4xgiNg-OCG6RLhzihI54w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18A291953941; Fri,  8 Nov 2024 10:43:30 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.118])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5A53F1953880; Fri,  8 Nov 2024 10:43:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 04/10] tests/functional: Fix the ppc64_hv and the ppc_40p test
 for read-only assets
Date: Fri,  8 Nov 2024 11:43:04 +0100
Message-ID: <20241108104312.534448-5-thuth@redhat.com>
In-Reply-To: <20241108104312.534448-1-thuth@redhat.com>
References: <20241108104312.534448-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

Since commit 786bc2255256, cached asset files are read-only, so now we've
got to use "read-only=true" in tests that try to use these files directly.

Fixes: 786bc22552 ("tests/functional: make cached asset files read-only")
Message-ID: <20241105160926.393852-1-thuth@redhat.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_ppc64_hv.py | 3 ++-
 tests/functional/test_ppc_40p.py  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/functional/test_ppc64_hv.py b/tests/functional/test_ppc64_hv.py
index 1a6e4b6d07..312248bbfe 100755
--- a/tests/functional/test_ppc64_hv.py
+++ b/tests/functional/test_ppc64_hv.py
@@ -99,7 +99,8 @@ def do_start_alpine(self):
         self.vm.add_args("-kernel", self.vmlinuz)
         self.vm.add_args("-initrd", self.initramfs)
         self.vm.add_args("-smp", "4", "-m", "2g")
-        self.vm.add_args("-drive", f"file={self.iso_path},format=raw,if=none,id=drive0")
+        self.vm.add_args("-drive", f"file={self.iso_path},format=raw,if=none,"
+                                    "id=drive0,read-only=true")
 
         self.vm.launch()
         wait_for_console_pattern(self, 'Welcome to Alpine Linux 3.18')
diff --git a/tests/functional/test_ppc_40p.py b/tests/functional/test_ppc_40p.py
index c64e876c1f..67bcdae53a 100755
--- a/tests/functional/test_ppc_40p.py
+++ b/tests/functional/test_ppc_40p.py
@@ -46,7 +46,8 @@ def test_factory_firmware_and_netbsd(self):
 
         self.vm.set_console()
         self.vm.add_args('-bios', bios_path,
-                         '-fda', drive_path)
+                         '-drive',
+                         f"file={drive_path},format=raw,if=floppy,read-only=true")
         self.vm.launch()
         os_banner = 'NetBSD 4.0 (GENERIC) #0: Sun Dec 16 00:49:40 PST 2007'
         wait_for_console_pattern(self, os_banner)
-- 
2.47.0


