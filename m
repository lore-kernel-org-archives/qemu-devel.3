Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9BBC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjf0-0003Em-CP; Mon, 11 Mar 2024 13:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjeo-0002yc-Up
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:41:52 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjen-0007Q6-6t
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:41:50 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e5eaf5bb3eso3592075b3a.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710178907; x=1710783707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=diri3m78EwCD+gDi71O1KOJH/MABv0MOoiXvKOFnIyw=;
 b=LeoTcHJ8DlrnW05mUniDpvJrdpPKIYIC71tPb45Y9LJGo0z3FzsSxcYFuXx0i5eSAu
 gPP8N5brepjFM2n6gTtm5E6FB9/irtufGQm5shf6l2FrS0qHTXVtzJztgDqzq15n21Aq
 3AsEqsRsXwtiafdk1JrdWU6A6XN25+pvM8xOQQ5da0vDAi3aY8L9R0D6MSZbirvU6Vj+
 8ik/6FqbWsORPDDAcEmnQ6cfwzE3M3G5Ze14TOKZqnN9Y6Mv4Z+XP9UcN95Y8mLWaD0h
 jc1ADqPMY7GfgrUjASJ9DzBoj+Yi6lHKcKPW3M9vQSNu0/tpHQlHs2OW5EKhSazsDgOp
 zFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710178907; x=1710783707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=diri3m78EwCD+gDi71O1KOJH/MABv0MOoiXvKOFnIyw=;
 b=p876BjkcmNP/MRm//E8d+gfwOXbxygXSO+oqXL/6Hl029JiSZ/D9kBSUhc6mi0wJUO
 gBJCFfwU7SXW2tPfpimaiiOC1Aza2ZbinLMCsfIAX2Ex6EgZb11KEf1yjI901ivKsbZZ
 ctsllXTBG4uJXDgSBRQowKf5hczVd/ySmA0zfX6639BAdOjKyZEf62fj7L2flRRiiDZB
 X2h+3fTrNauG4pGCf11RB0sL6eDt5IDMi0sNi8gE64ndGLLFn5SRG9v8CWB13AcwlHSj
 97wdH++aESiYINiD2m4Q7xMAVYilfPB/fbo/6EgoXkh9/0ytIZnFhLmWRDSiT9ltnn2j
 a24w==
X-Gm-Message-State: AOJu0Yz+V4JCtLGLctoBXqU+TnNyTCWOkCuT9w7k+ifWP+L8LTFEdzrg
 a0ale5YyW7CHVA9tBmpov0m6J5cH+L3LWQ25QdA11b/cyZZEZFT+hAPhA9po6gM=
X-Google-Smtp-Source: AGHT+IEdwpaMRc13DahPgDb8+kNI8EwlVkwj4prESfXwjQleRcA1xk+wrIcPnqzXDZItZghjnTx1dg==
X-Received: by 2002:a05:6a00:2404:b0:6de:1b57:ca8c with SMTP id
 z4-20020a056a00240400b006de1b57ca8cmr6630655pfh.23.1710178906748; 
 Mon, 11 Mar 2024 10:41:46 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62d412000000b006e67b4d7b74sm4593187pfh.197.2024.03.11.10.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:41:46 -0700 (PDT)
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
Subject: [PATCH v4 13/24] tests/avocado: replay_linux.py remove the timeout
 expected guards
Date: Tue, 12 Mar 2024 03:40:15 +1000
Message-ID: <20240311174026.2177152-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311174026.2177152-1-npiggin@gmail.com>
References: <20240311174026.2177152-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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

replay_linux tests with virtio on aarch64 and x86-64 q35 machines seems
to be more reliable now, so timeouts are no longer expected. pc_i440fx,
and non-virtio still have problems, so mark them as flaky: they are not
just long-running, but can hang indefinitely.

These tests take about 400 seconds each, so require SPEED=slow.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/replay_linux.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
index b3b91ddd9a..c0e50bb52b 100644
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
-- 
2.42.0


