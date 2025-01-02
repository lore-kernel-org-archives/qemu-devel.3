Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8359E77194
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 10:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTIUw-0003ux-3e; Thu, 02 Jan 2025 05:32:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTIUu-0003u8-8r
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:32:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTIUs-0005rQ-Hx
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735813929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AtKOIMrUMfJqVHlazx3ZHIz+8kmTp7dRf5Y0+BdIZT0=;
 b=RO7H/f8OEItEyC6pqTMsAipMabxoPyqWxo82IJePjg/RqlEKG9BHoY4BML+z239jyVO9G4
 2fv1NLShypbnZ9HeQYenoMp/sGmBgcD5Dv4R/K7Fy+chZo8BqWz+ycongY40EC6jmLM1Br
 oiBlg9fYYVoAXIyTYzQGRMugjI3WV9c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-KERX274yNE6Yx470rFcdyw-1; Thu,
 02 Jan 2025 05:32:02 -0500
X-MC-Unique: KERX274yNE6Yx470rFcdyw-1
X-Mimecast-MFC-AGG-ID: KERX274yNE6Yx470rFcdyw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A82A01956088; Thu,  2 Jan 2025 10:32:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.39])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2D28A1956052; Thu,  2 Jan 2025 10:31:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 06/10] tests/functional/test_ppc64_hv: Simplify console handling
Date: Thu,  2 Jan 2025 11:31:34 +0100
Message-ID: <20250102103138.354618-7-thuth@redhat.com>
In-Reply-To: <20250102103138.354618-1-thuth@redhat.com>
References: <20250102103138.354618-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

Since functional tests have character-based console output parsing,
there is no need for strange hacks to work around old line-based.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20241220024617.1968556-3-npiggin@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_ppc64_hv.py | 43 ++++++++++++++-----------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/tests/functional/test_ppc64_hv.py b/tests/functional/test_ppc64_hv.py
index 037dfdf87e..2182a68c91 100755
--- a/tests/functional/test_ppc64_hv.py
+++ b/tests/functional/test_ppc64_hv.py
@@ -12,6 +12,7 @@
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern, exec_command
 from qemu_test import skipIfMissingCommands, skipBigDataTest
+from qemu_test import exec_command_and_wait_for_pattern
 import os
 import time
 import subprocess
@@ -73,31 +74,28 @@ def do_start_alpine(self):
                                     "id=drive0,read-only=true")
 
         self.vm.launch()
-        wait_for_console_pattern(self, 'Welcome to Alpine Linux 3.18')
-        exec_command(self, 'root')
+        ps1='localhost:~#'
         wait_for_console_pattern(self, 'localhost login:')
-        wait_for_console_pattern(self, 'You may change this message by editing /etc/motd.')
+        exec_command_and_wait_for_pattern(self, 'root', ps1)
         # If the time is wrong, SSL certificates can fail.
-        exec_command(self, 'date -s "' + datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S' + '"'))
-        exec_command(self, 'setup-alpine -qe')
-        wait_for_console_pattern(self, 'Updating repository indexes... done.')
+        exec_command_and_wait_for_pattern(self, 'date -s "' + datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S' + '"'), ps1)
+        ps1='alpine:~#'
+        exec_command_and_wait_for_pattern(self, 'setup-alpine -qe', ps1)
 
     def do_stop_alpine(self):
-        exec_command(self, 'poweroff')
+        exec_command(self, 'echo "TEST ME"')
         wait_for_console_pattern(self, 'alpine:~#')
+        exec_command(self, 'poweroff')
+        wait_for_console_pattern(self, 'reboot: Power down')
         self.vm.wait()
 
     def do_setup_kvm(self):
-        exec_command(self, 'echo http://dl-cdn.alpinelinux.org/alpine/v3.18/main > /etc/apk/repositories')
-        wait_for_console_pattern(self, 'alpine:~#')
-        exec_command(self, 'echo http://dl-cdn.alpinelinux.org/alpine/v3.18/community >> /etc/apk/repositories')
-        wait_for_console_pattern(self, 'alpine:~#')
-        exec_command(self, 'apk update')
-        wait_for_console_pattern(self, 'alpine:~#')
-        exec_command(self, 'apk add qemu-system-ppc64')
-        wait_for_console_pattern(self, 'alpine:~#')
-        exec_command(self, 'modprobe kvm-hv')
-        wait_for_console_pattern(self, 'alpine:~#')
+        ps1='alpine:~#'
+        exec_command_and_wait_for_pattern(self, 'echo http://dl-cdn.alpinelinux.org/alpine/v3.18/main > /etc/apk/repositories', ps1)
+        exec_command_and_wait_for_pattern(self, 'echo http://dl-cdn.alpinelinux.org/alpine/v3.18/community >> /etc/apk/repositories', ps1)
+        exec_command_and_wait_for_pattern(self, 'apk update', ps1)
+        exec_command_and_wait_for_pattern(self, 'apk add qemu-system-ppc64', ps1)
+        exec_command_and_wait_for_pattern(self, 'modprobe kvm-hv', ps1)
 
     # This uses the host's block device as the source file for guest block
     # device for install media. This is a bit hacky but allows reuse of the
@@ -116,15 +114,12 @@ def do_test_kvm(self, hpt=False):
                            '-kernel /media/nvme0n1/boot/vmlinuz-lts '
                            '-append \'usbcore.nousb ' + append + '\'')
         # Alpine 3.18 kernel seems to crash in XHCI USB driver.
-        wait_for_console_pattern(self, 'Welcome to Alpine Linux 3.18')
-        exec_command(self, 'root')
+        ps1='localhost:~#'
         wait_for_console_pattern(self, 'localhost login:')
-        wait_for_console_pattern(self, 'You may change this message by editing /etc/motd.')
-        exec_command(self, 'poweroff >& /dev/null')
-        wait_for_console_pattern(self, 'localhost:~#')
+        exec_command_and_wait_for_pattern(self, 'root', ps1)
+        exec_command(self, 'poweroff')
         wait_for_console_pattern(self, 'reboot: Power down')
-        time.sleep(1)
-        exec_command(self, '')
+        # Now wait for the host's prompt to come back
         wait_for_console_pattern(self, 'alpine:~#')
 
     def test_hv_pseries(self):
-- 
2.47.1


