Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43114C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFDR-0005nF-EL; Mon, 18 Mar 2024 11:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFDP-0005eu-EE
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:47:55 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFDJ-0007vg-J1
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:47:55 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5a4a14c52fcso759073eaf.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710776868; x=1711381668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y7iKS4ySAYhb/qoRHukxiwY3seRoSpbokwbgQj4S8po=;
 b=Fz/kx71l0TyrFJCtmkoZvoO940yLDrxhcTEIYsExnfg9IkipfK0Ft3SHJIXcVWL1Ta
 LnL2iUpCZXgVNXAIWwACtbJP+91AienUclqRyFskmhXB87gVh4kyQJYw5OMrmskBNbXQ
 S0VAPqI1t2g/EcqHZ60UCuX6YEIOisAsJEkDUEhUGmCaeKBJxBWYtxfgUEk1l/zJRExP
 q98HZYR6wMcBeL2540hos7xFs3M6jrxQtXD8x9M6fx88FLYpibqCBGzLY5XnoYA8xmT3
 BJ9m5xevxqCM4nJgVVcC3qMXRRIj/oTyFxG4mqJCk6S4Rrkkz5E2zOsbc7bbmD00zsI0
 3ohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710776868; x=1711381668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y7iKS4ySAYhb/qoRHukxiwY3seRoSpbokwbgQj4S8po=;
 b=FDOJ/61lBRm9DyTq1I3fcju6fXj/9xgEUabdQ7EaeLygXjqeQ03Ca1nSitjtPaDzgY
 cW4zAJWoWvMV1sgkTmeUGLEPyMHb5Y1H3BI5kcLGIo/c5ndzsiG6qxbJhXJ1liHUAN8R
 NfDA8xy4+kPdtCYAx1G8kdJykRWLezkfLWcVw1H38FL8bmcMc0pXbeSNnefPsCVcuvvI
 1RO5GeljOBfAstbXFAFFpVoAZOV5qt7sSn/pPOHvNRNqFq+df9H9KRUatICtFMfN9T2u
 ebxr8ca3KjWxr1BykXFO76s+OxDuXkVccTO3cuwae/EgmxwrQUAZwCfLCy4zWlX+t8DD
 VZvg==
X-Gm-Message-State: AOJu0YzklehKmHuXJLXXedI3ZcDjk8gqGnCeiHQMd4GUeKb4khcbqybI
 3iy/xnOAWWr0TlGmriKHVR5MAGlDSAnqHLnp3bROVNGy9ZAaQQN0BYMNfT9wl3U=
X-Google-Smtp-Source: AGHT+IHefwOVxIJiTQcrL5Q2YsFjHszFDaji+Izo63z/a9hoij9o2F0GmjFS/Jh4weBpRaLMCNFKBQ==
X-Received: by 2002:a05:6820:1344:b0:5a4:bbf6:9e0c with SMTP id
 b4-20020a056820134400b005a4bbf69e0cmr3051543oow.1.1710776867953; 
 Mon, 18 Mar 2024 08:47:47 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a634816000000b005dc26144d96sm7332108pga.75.2024.03.18.08.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 08:47:47 -0700 (PDT)
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
Subject: [PATCH v5 13/24] tests/avocado: replay_linux.py remove the timeout
 expected guards
Date: Tue, 19 Mar 2024 01:46:10 +1000
Message-ID: <20240318154621.2361161-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240318154621.2361161-1-npiggin@gmail.com>
References: <20240318154621.2361161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

replay_linux tests with virtio on aarch64 gciv3 and x86-64 q35 machines
seems to be more reliable now, so timeouts are no longer expected.
pc_i440fx, gciv2, and non-virtio still have problems, so mark them as
flaky: they are not just long-running, but can hang indefinitely.

These tests take about 400 seconds each, so add the SPEED=slow guard.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/replay_linux.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
index b3b91ddd9a..b3b74a367c 100644
--- a/tests/avocado/replay_linux.py
+++ b/tests/avocado/replay_linux.py
@@ -118,7 +118,7 @@ def run_replay_dump(self, replay_path):
         except subprocess.CalledProcessError:
             self.fail('replay-dump.py failed')
 
-@skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
+@skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
 class ReplayLinuxX8664(ReplayLinux):
     """
     :avocado: tags=arch:x86_64
@@ -127,19 +127,21 @@ class ReplayLinuxX8664(ReplayLinux):
 
     chksum = 'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f3c5c27a0'
 
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable')
     def test_pc_i440fx(self):
         """
         :avocado: tags=machine:pc
         """
         self.run_rr(shift=1)
 
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable')
     def test_pc_q35(self):
         """
         :avocado: tags=machine:q35
         """
         self.run_rr(shift=3)
 
-@skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
+@skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
 class ReplayLinuxX8664Virtio(ReplayLinux):
     """
     :avocado: tags=arch:x86_64
@@ -153,6 +155,7 @@ class ReplayLinuxX8664Virtio(ReplayLinux):
 
     chksum = 'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f3c5c27a0'
 
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable')
     def test_pc_i440fx(self):
         """
         :avocado: tags=machine:pc
@@ -165,7 +168,7 @@ def test_pc_q35(self):
         """
         self.run_rr(shift=3)
 
-@skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
+@skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
 class ReplayLinuxAarch64(ReplayLinux):
     """
     :avocado: tags=accel:tcg
@@ -187,6 +190,7 @@ def get_common_args(self):
                 '-device', 'virtio-rng-pci,rng=rng0',
                 '-object', 'rng-builtin,id=rng0')
 
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable')
     def test_virt_gicv2(self):
         """
         :avocado: tags=machine:gic-version=2
-- 
2.42.0


