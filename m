Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53671C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 05:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFRPT-0005QS-ML; Thu, 15 May 2025 01:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1uFRPR-0005FO-CW
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:45:33 -0400
Received: from mailout11.t-online.de ([194.25.134.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1uFRPO-00006N-IX
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:45:33 -0400
Received: from fwd80.aul.t-online.de (fwd80.aul.t-online.de [10.223.144.106])
 by mailout11.t-online.de (Postfix) with SMTP id DE62DE13;
 Thu, 15 May 2025 07:44:30 +0200 (CEST)
Received: from linpower.localnet ([84.175.230.13]) by fwd80.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1uFROP-0PkGuH0; Thu, 15 May 2025 07:44:29 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 6633520063C; Thu, 15 May 2025 07:44:29 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 1/7] tests/functional: use 'none' audio driver for q800
 tests
Date: Thu, 15 May 2025 07:44:23 +0200
Message-ID: <20250515054429.7385-1-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0bb1a55e-70f1-410b-8b59-78eed7f4c8f7@t-online.de>
References: <0bb1a55e-70f1-410b-8b59-78eed7f4c8f7@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1747287869-77FFD538-7F28586A/10/29118861210 SUSPECT
 URL
X-TOI-MSGID: 7b9e6b7a-cfd4-400d-af41-7ace724a56bf
Received-SPF: pass client-ip=194.25.134.85;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout11.t-online.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

Since commit ac13a6b3fd ("audio: add Apple Sound Chip (ASC)
emulation") the Quadra 800 machine has an audio device. It is
not guaranteed that the default audio driver of the audio
subsystem will work correctly on all host systems. Therefore,
the 'none' audio driver should be used in all q800 tests.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2812
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
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
2.43.0


