Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B947CCCFA00
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 09:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEldi-0006Bh-Cl; Fri, 31 Oct 2025 05:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEldh-0006BS-24
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:41:45 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vElde-00064c-FN
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:41:44 -0400
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-471b80b994bso25307485e9.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 02:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761903698; x=1762508498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXGoH1b4Mg89hW+3uAck9luCnqVQn9F+7nalHP1pE0c=;
 b=V4YymdukpX/hdyMuEoBxNei18Zlf/+Cx3uLD0goCbY6SnAwMMpI5FbtEtGUdcnyfH7
 4IkMq0Lb8tc+7H/30AztNSEQj/vkResoCknDUxgXhno8h98tegHNnGaA9+p1icZoXntG
 iihuU26wz/pK6H9HSG5aylQ0u3yg14q1Ote2Sonec+fISM84gJf9dELdhIb7pDwSUW9S
 rZgcE5R2rjTfPO7LKqwfNuWuXIwtc2KbJtmeJ4UWdAagYz3gh/616AZqC/zK4mlp/pE1
 PPF5ugK12m50pCSyWnH1IwNC2qZ50BwkraqRozGPo3rk8o5SMPuN+SipS8S/7eT2DsCb
 YDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761903698; x=1762508498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kXGoH1b4Mg89hW+3uAck9luCnqVQn9F+7nalHP1pE0c=;
 b=DiUJViMa9IEXPOGG73/Q7d2nlN3TCiSEhKvp8xCxA+9u/u4oXTWia52aR/Ci4EnAen
 WDU8EZQaWR6hAg7bkO6CGxpPR/Vot2jRPxzBmbOl1ze0iDjSIS3Avg/E+6ZXZiIP+1Vb
 UeyD4TWwvKHwUD9LIqy29XVRe94PHIurcTfMLW2epNvgYrN5vRnJGE0thtEOQVvKBmqT
 98TDZmv30dWYl5922+3nOrViUvBVvVpNUP3PtMvcQrIJKcKsBc8gqFILHffV+7+c/12O
 CWg1wmYCTPcGKENPMCwfVFg5UGgdf9e8qvvIJXdq2c7of/bDTshlatQD8EJe9eyIfeCh
 pXYQ==
X-Gm-Message-State: AOJu0YxXX45Gw+gh7CYIeaRyln3E4fGiaLd++unACFhSmoVbRXFWkUre
 Xo0UU1cr0gHsW46aNj5iJiBhOqvxVt7Kx8orwM0WP/qDGkivbYOqQb/PO3/3n/G7g+EbHW1cie0
 LNFzoDSLwQQHlk0I=
X-Gm-Gg: ASbGncsS31xoFG4w8lqPl+IuOhzNRZqo9eXo10VLBJ6LMEQGBeqnFukeCMxzpCoWjV8
 tMHLWKS4y7f8NtxjKM89EBfrF/6KqdfV3CAzPYzFPF/20MS2BFHQ/nIacW2dAz519O5QDeCkmkg
 Hf8mfYN2J4PIqoPklGy0X8/MGPcLVPkpDV77KEfzByZLlbPYG6D957y7IrV0/iPhX2Q4wa6BopW
 4O9jI3TSzWzFZ8j5MgLi5byzZ/Bo7ahY2rP150yusDNWCSghh29FEJDOcMLYXBsZwhOom4+KFjt
 QUEiZ9onZy9dqrap8cQqjKJ47PRtcyJNyrzUQb4OzHUpz/bc3dLba9EfWfJraMs+NtopivJtNzL
 06c017PZcG6sDeUQ0DbjaIVdaZu/cA8ZZK/gTVsFKrSvKH92K/QYWTwn09rFC7RzRnC1FCjER66
 RTzKbhbShveCLKfG/JgaqCX6ux47I6D7JkgNRNa1tE8wstyPnVWVo8mA==
X-Google-Smtp-Source: AGHT+IHTB4gGB12S0KvXIvtOagjdQwFyu1ioqXqWLU/l+GQe+zTmt6Ujq2/sr4ZRNC3DBiGRQnYjMA==
X-Received: by 2002:a05:600c:5307:b0:45b:9a46:69e9 with SMTP id
 5b1f17b1804b1-47730890cd5mr27981175e9.31.1761903698054; 
 Fri, 31 Oct 2025 02:41:38 -0700 (PDT)
Received: from pc56.home (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47728aa6b0dsm78904805e9.14.2025.10.31.02.41.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Oct 2025 02:41:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/2] tests/functional: Mark the MIPS replay tests as flaky
Date: Fri, 31 Oct 2025 10:41:17 +0100
Message-ID: <20251031094118.28440-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031094118.28440-1-philmd@linaro.org>
References: <20251031094118.28440-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

MIPS test_replay.py often times out (likely hang) under GitLab CI:

  2/21 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-replay   TIMEOUT   180.12s   killed by signal 15 SIGTERM

The console.log file is empty, and recording.logs only shows:

  qemu-system-mips64el: terminating on signal 15 from pid 344

Since this is a long term issue affecting our CI, disable the tests.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/mips/test_replay.py     | 2 ++
 tests/functional/mips64el/test_replay.py | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tests/functional/mips/test_replay.py b/tests/functional/mips/test_replay.py
index 4327481e35b..747835bf008 100755
--- a/tests/functional/mips/test_replay.py
+++ b/tests/functional/mips/test_replay.py
@@ -5,6 +5,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import Asset, skipSlowTest
+from qemu_test import skipFlakyTest
 from replay_kernel import ReplayKernelBase
 
 
@@ -16,6 +17,7 @@ class MipsReplay(ReplayKernelBase):
          'linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb'),
         '16ca524148afb0626f483163e5edf352bc1ab0e4fc7b9f9d473252762f2c7a43')
 
+    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2013")
     def test_replay_mips_malta(self):
         self.set_machine('malta')
         kernel_path = self.archive_extract(self.ASSET_KERNEL_2_63_2,
diff --git a/tests/functional/mips64el/test_replay.py b/tests/functional/mips64el/test_replay.py
index 26a6ccff3f7..05cc585f854 100755
--- a/tests/functional/mips64el/test_replay.py
+++ b/tests/functional/mips64el/test_replay.py
@@ -5,6 +5,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import Asset, skipUntrustedTest
+from qemu_test import skipFlakyTest
 from replay_kernel import ReplayKernelBase
 
 
@@ -16,6 +17,7 @@ class Mips64elReplay(ReplayKernelBase):
          'linux-image-2.6.32-5-5kc-malta_2.6.32-48_mipsel.deb'),
         '35eb476f03be589824b0310358f1c447d85e645b88cbcd2ac02b97ef560f9f8d')
 
+    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2013")
     def test_replay_mips64el_malta(self):
         self.set_machine('malta')
         kernel_path = self.archive_extract(self.ASSET_KERNEL_2_63_2,
-- 
2.51.0


