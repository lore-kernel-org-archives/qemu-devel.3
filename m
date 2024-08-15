Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE500C52D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebnG-00045N-2a; Thu, 15 Aug 2024 10:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebn5-0003bh-JL
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:27 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebn3-0000ED-GL
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:27 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a7aa212c1c9so129051266b.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723733364; x=1724338164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZqpOMl7awKhcLh3PsdzLgfKFh1wtkG9PTMoyFGQ145A=;
 b=EV0279/M4zRnG+XVK7Zht3KD0wsMX+pXv5eMsMVU8Pe2+uFaKLFxddij9xvCbk8phw
 Rd+arGsdEhuuOskU5atW/W+LHCrjfTO3Cs9MtPlR1hQal2YVE2T0h8mVAqS0Tq/xyj84
 W9USFBfFBXlgyvxJnVWQaIu3dFwaVjbo9fV2uABYLowQppTjgT8TwanyKLJ85VK2lsJ8
 cGoYvEb7tJe/Zxrwi5EKsaQhCZH2Dij2AqDjumHQskN1P1jaVJgbOCg/wsoUzhoJctfb
 Ptj80vN7sBQjvLYIy2xR0DOkKKykAuzfoiHkYiC+1JJOe+xlJ7vEmaU5GQOqwqhPgLX0
 +8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723733364; x=1724338164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZqpOMl7awKhcLh3PsdzLgfKFh1wtkG9PTMoyFGQ145A=;
 b=sII0vWqO2JGAGzeTOAlPc18E/K0W1Hwse2s5YWzjHgNRtF0Tn5NOCQxxgiMN4AbGTw
 G5FBbaPMlFKMaDqXxjWboK6ZX8AeATa1BgxrOhx6z3oxiaDUpxUQkTqAPYTkVjMu0yNE
 WZ2uf7jD5skqgjguZaXlTxoyI6pnC+mmaupe9R6AfFzbD57QOPLEdsomAfBvJZrDi86K
 T92zgq5KUc2RSukP5rO+/4RUW9C+wpBskW2Um+VxUzHT+spyM3tx0Ma4OWDKZPTcHorP
 Ws7xeKWZRqK+lzyeoE/ayKuSdQTzxLnfECk+ea6KHdPDCPsyZFHm105Hm0ITl8jCEbBk
 peqQ==
X-Gm-Message-State: AOJu0YxtyLx5e7OqF7Cuv/lru/LqaLCGwuki/v+2VbARuj1xBd9xD3Sh
 g+18T3j/o/Fw4tMduQkqB8d2NVVSV2vET8yPqhcXWZQxSyR3z0zE76agBx3CcWI=
X-Google-Smtp-Source: AGHT+IEYW/Bfh5DHX4kIR/W1gRAtB9YuD+ePXGui1o4a03z2mgrYLmHYdhbqrQoz8ZDgIMUYT5vfMw==
X-Received: by 2002:a17:907:7290:b0:a7a:a212:be48 with SMTP id
 a640c23a62f3a-a83670d5bfdmr396396966b.56.1723733363589; 
 Thu, 15 Aug 2024 07:49:23 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a838396b7b3sm111659266b.194.2024.08.15.07.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 07:49:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0C0425FEE6;
 Thu, 15 Aug 2024 15:49:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 14/21] tests/avocado: replay_kernel.py add x86-64 q35 machine
 test
Date: Thu, 15 Aug 2024 15:49:04 +0100
Message-Id: <20240815144911.1931487-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815144911.1931487-1-alex.bennee@linaro.org>
References: <20240815144911.1931487-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Nicholas Piggin <npiggin@gmail.com>

The x86-64 pc machine is flaky with record/replay, but q35 is more
stable. Add a q35 test to replay_kernel.py.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20240813050638.446172-7-npiggin@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240813202329.1237572-15-alex.bennee@linaro.org>

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
2.39.2


