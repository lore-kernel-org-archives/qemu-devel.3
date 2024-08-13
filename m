Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8274BC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 05:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdjkt-0001Va-6B; Tue, 13 Aug 2024 01:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sdjkk-0001Jq-1q
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 01:07:27 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sdjkh-0007oX-Be
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 01:07:24 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70eaf5874ddso3809215b3a.3
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 22:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723525642; x=1724130442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZBpaQ/HJd3PJasOjuDlscyEiUWvNzOoBl6dVc+TjWMw=;
 b=h0N2Fr1NhD4vBppY1Gei6aXhvfF7lZONpp+LnYf5yT775XDOC6NQqy20Ko3AENDlfK
 fHx3oz9cp+6K/Kmi5AfeamkZiCLMATkIbGHJ8bxHZZexKTEy7JgauGPh/rrT8S5bOcDj
 LcUtJvwi0SkhakyDcwV2Lji4I6b2LqEB2xV1DzAA81UOXsj8HgJIghA78j7lOlW1xc+j
 TZb3tCZcf9arncCKuxVd41y4JSU87/lUk3KCsH8LqVzVXUYa0fb9flBREsMnxW84d1VQ
 ExjndVAWNmZ952HyGOMw13q+r3P0t9/gAYYVV742uwsFCsjy7Sae8lJiZyU+BCrMtqmO
 bzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723525642; x=1724130442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZBpaQ/HJd3PJasOjuDlscyEiUWvNzOoBl6dVc+TjWMw=;
 b=C0NHyOB6utC1pELKdEDQgEFxbPN3VpWM4u0/uExBIRY1LTY/Liz4r9KpiBxsZUlLBn
 P5nnthA59i40i5RLxVYtvChqAWjMNSsoiWvnN96VNHTEdtfnuNEnPCuksWyvHEl3qihX
 N9WlZ7plBPTTXA0suYRGxS6ikHad0a6NWYmCeW+/H7M44a8qC7b810O0X0dc32gTx1Zi
 +Udd7vAJt/Aix4HuU8V0oajBPoUZLwi4KkMqGPs3gUvrSK4DPuDThjfdDFvDyvglNtXo
 0WHj0rv/h/xLvHEM4g/w7PwyDjjYWt9lP45RDLM/PVTNpSiMZdjynQqf7Wb4FXqyrJ99
 bzqg==
X-Gm-Message-State: AOJu0YzcurIImipcfyLyYIb6s4bCXcztftwcjC1phT49yqHZgiEFUGw1
 FUe8TO3VLjajx3/E6dorWf7VvjFX7k/4N2n8lTtG5BZ5ZHmtR9WFxy13eGAd
X-Google-Smtp-Source: AGHT+IHczjedj/NKx5ny7tRO+uGGdl/xImvM54mVuXb1OEyzIO+O2Blidmj7I7vLOZBRJyuZZZDc4A==
X-Received: by 2002:a05:6a00:3904:b0:70d:3354:a190 with SMTP id
 d2e1a72fcca58-71255226e24mr3286473b3a.27.1723525641453; 
 Mon, 12 Aug 2024 22:07:21 -0700 (PDT)
Received: from wheely.local0.net ([1.145.66.74])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e5874ddcsm4846449b3a.28.2024.08.12.22.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 22:07:21 -0700 (PDT)
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
Subject: [PATCH v6 06/10] tests/avocado: replay_kernel.py add x86-64 q35
 machine test
Date: Tue, 13 Aug 2024 15:06:33 +1000
Message-ID: <20240813050638.446172-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240813050638.446172-1-npiggin@gmail.com>
References: <20240813050638.446172-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/replay_kernel.py | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index a668af9d36..e22c200a36 100644
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
2.45.2


