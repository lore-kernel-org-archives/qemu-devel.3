Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B557AC54E71
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFCs-00039p-W4; Mon, 18 Mar 2024 11:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFCk-0002ol-Ey
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:47:21 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFCg-0007rY-6E
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:47:14 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-221a9e5484aso3189679fac.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710776827; x=1711381627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sIxDj8qxQ1Vf3naQ804ZZJDX1uKqMaOn1Ozd3HpaNjM=;
 b=eTXGfCSTzffVTMtFeP+bhXY6otFj/3Q5gb3bbQq37a0N18Q1DQOYKg4iI0wQ410dIk
 VGTVWVbxxI5bwGI8d73xE7K/LC5fR5+MJ/pAncOirA1PEzx1pQHKTdK/ZMQBADuWnc4x
 qmA3qiiZ2AcsUybj0a5VXviM7Bvg/qRGzTkZltPQZ38KsGZQDGF1yPbUgZX5Jx0cWH/r
 6rxCPh8MDwH5/ARNa8FIKFok+tvFMWycafKF0EtFZZDAXyMM0OKnXXanyESHxfg2Sc4I
 R2tIgbkotv+L+0+7bkJyzN3wtIBATKdPKHd0zva1yocrW/h4mxs8Z+4xJQzoN+nr0gp1
 7izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710776827; x=1711381627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sIxDj8qxQ1Vf3naQ804ZZJDX1uKqMaOn1Ozd3HpaNjM=;
 b=OQEd2+GrZdPL6leuTaFR3j75FDWywiX8I/z9IYKtiHezVJhzKbNANCdarHxLITei9R
 Vngcof7MnT7vRW3Xe/jfY5euWv/uEqAJ8W5nnhVDBIhEMjAMT5FbKXt41fqA/664uInz
 pIAnQMtNchulOWrA7s+C9LhYgVwtJOfkWQzv5wZxYS0QOADiwJbHfMwbRmkbU9VOtF/J
 lUWlEj017XDyE4gYeZQrGJHZ1kpl25ommTBb+fO82Q5RP5KLYcdFDmLLjaYa2iPcmxS8
 vVm42XSnX9n96IGSJ4B6r/4S9HhttYo3K8Z/IxDlToyHrTu/IhiwV6MQsP1EyfCVn1tm
 IkvQ==
X-Gm-Message-State: AOJu0Yyd0X0DP2ESNfoLHjT/H61ukqQ+nxQVBrY5hfoxmFNFh/LoegUU
 nelSbtDNWTGWaE/TXit3x/FyEo8H1ZXkbEy0uk6yqlhZh+6ZYLuyzbK1FB8SbXk=
X-Google-Smtp-Source: AGHT+IE1YrZDHhWLsIo/w2Pw8OQ6KQwBeLSkS/4KqGCJGMwVnFnjpU7j7gL3TgTVay8mkPHevo9/eA==
X-Received: by 2002:a05:6871:146:b0:221:9635:da6d with SMTP id
 z6-20020a056871014600b002219635da6dmr13884243oab.47.1710776827079; 
 Mon, 18 Mar 2024 08:47:07 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a634816000000b005dc26144d96sm7332108pga.75.2024.03.18.08.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 08:47:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v5 06/24] tests/avocado: replay_kernel.py add x86-64 q35
 machine test
Date: Tue, 19 Mar 2024 01:46:03 +1000
Message-ID: <20240318154621.2361161-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240318154621.2361161-1-npiggin@gmail.com>
References: <20240318154621.2361161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The x86-64 pc machine is flaky with record/replay, but q35 is more
stable. Add a q35 test to replay_kernel.py.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/replay_kernel.py | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index 22032f3230..df0ea0678f 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -110,7 +110,7 @@ def test_i386_pc(self):
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
 
     # See https://gitlab.com/qemu-project/qemu/-/issues/2094
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test sometimes gets stuck')
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'pc machine is unstable with replay')
     def test_x86_64_pc(self):
         """
         :avocado: tags=arch:x86_64
@@ -128,6 +128,22 @@ def test_x86_64_pc(self):
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
 
+    def test_x86_64_q35(self):
+        """
+        :avocado: tags=arch:x86_64
+        :avocado: tags=machine:q35
+        """
+        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
+                      '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
+                      '/vmlinuz')
+        kernel_hash = '23bebd2680757891cf7adedb033532163a792495'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
+        console_pattern = 'VFS: Cannot open root device'
+
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
+
     def test_mips_malta(self):
         """
         :avocado: tags=arch:mips
-- 
2.42.0


