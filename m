Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6DBC54FB3
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 13:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJBO0-0007T2-O7; Sun, 25 May 2025 09:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uJBNz-0007Sm-9k
 for qemu-devel@nongnu.org; Sun, 25 May 2025 09:27:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uJBNx-0003K0-GY
 for qemu-devel@nongnu.org; Sun, 25 May 2025 09:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748179648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AMGaSW13wOdC4VmIpjDX+VnZ2CkLsJw6JxNfUQcYMkg=;
 b=ACw2nuph5n0g4Ldgzs1mR+scL1CruXp9uH3EUgAsXScxk1jQq+GrOgjoBWXVzKnE8vWn5e
 xwThmMnyH6M02/Uu8FUedxqByvOaan+4N5AYR+vQWcNDg67t+XLcM9mhioh/BTQV2QpaG8
 65/DMHGZg1mt6az9+VyalgUKesKxHK0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-hWs1IlVJMda1mwgVLylVrw-1; Sun,
 25 May 2025 09:27:25 -0400
X-MC-Unique: hWs1IlVJMda1mwgVLylVrw-1
X-Mimecast-MFC-AGG-ID: hWs1IlVJMda1mwgVLylVrw_1748179644
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC5CE195608A; Sun, 25 May 2025 13:27:23 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3DB11800361; Sun, 25 May 2025 13:27:22 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 1/9] tests/functional: use 'none' audio driver for q800 tests
Date: Sun, 25 May 2025 15:27:08 +0200
Message-ID: <20250525132717.527392-2-marcandre.lureau@redhat.com>
In-Reply-To: <20250525132717.527392-1-marcandre.lureau@redhat.com>
References: <20250525132717.527392-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Volker Rümelin <vr_qemu@t-online.de>

Since commit ac13a6b3fd ("audio: add Apple Sound Chip (ASC)
emulation") the Quadra 800 machine has an audio device. It is
not guaranteed that the default audio driver of the audio
subsystem will work correctly on all host systems. Therefore,
the 'none' audio driver should be used in all q800 tests.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2812
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Message-Id: <20250515054429.7385-1-vr_qemu@t-online.de>
---
 tests/functional/test_m68k_q800.py   | 3 ++-
 tests/functional/test_m68k_replay.py | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/functional/test_m68k_q800.py b/tests/functional/test_m68k_q800.py
index 400b7aeb5d..b3e655346c 100755
--- a/tests/functional/test_m68k_q800.py
+++ b/tests/functional/test_m68k_q800.py
@@ -25,7 +25,8 @@ def test_m68k_q800(self):
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                'console=ttyS0 vga=off')
         self.vm.add_args('-kernel', kernel_path,
-                         '-append', kernel_command_line)
+                         '-append', kernel_command_line,
+                         '-audio', 'none')
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
diff --git a/tests/functional/test_m68k_replay.py b/tests/functional/test_m68k_replay.py
index 18c1db539c..213d6ae07e 100755
--- a/tests/functional/test_m68k_replay.py
+++ b/tests/functional/test_m68k_replay.py
@@ -24,7 +24,8 @@ def test_q800(self):
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                'console=ttyS0 vga=off')
         console_pattern = 'No filesystem could mount root'
-        self.run_rr(kernel_path, kernel_command_line, console_pattern)
+        self.run_rr(kernel_path, kernel_command_line, console_pattern,
+                    args=('-audio', 'none'))
 
     ASSET_MCF5208 = Asset(
        'https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day07.tar.xz',
-- 
2.49.0


