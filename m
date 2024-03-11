Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1303FC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjfT-0003sg-Ep; Mon, 11 Mar 2024 13:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjf2-0003UZ-A6
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:42:04 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjes-0007QQ-JI
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:42:04 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e55b33ad14so2449205b3a.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710178912; x=1710783712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iM8ZZscE7pj+Z7J5S93rTnFI05PsMASFwHURBr43Ioo=;
 b=OyPfJ8c2aIWh9NlUHSrYkHL6C+9EEQpZn0JIlsrKIY96l8tfqN5/d6QH6mvBe3aPx7
 KGjTeZNWKD1ZCeyliC/j1a1vOgly9MqQK49/SBad0GH477n9d+3F+z60oJJdtu9NezHR
 xvrTQb8KlLl/z47oi4mag4al01lVfek/ioy7xUNhyfMEDdwvcoWasSdtdCroVGcVoYL5
 tSHuPhe58bHcOqPOj5sfd6C1Q8RwD1VnH298SjwGxEZa+yW9eg+GH5AEda5yWdR2dwW9
 k+AM8weY5TYv5fp/XtF3YO08rfnvJGRHgh7yQ6zRZBFrmU/ZT/LQUpU0caaHKlLxdc1M
 Y2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710178912; x=1710783712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iM8ZZscE7pj+Z7J5S93rTnFI05PsMASFwHURBr43Ioo=;
 b=ipScIiHlG1K1HBuiIvEmYwUpECHQLyPzbaoU1XZHWmlmISYEm8TTzaUSkzW6kT1XSf
 UrZQt/S+1Lyk5eEKkim7HH5wegqo7yUmoveEkQqPmS0/xB6eb0B11mWVfHG06mnOHjiY
 NQeh3p7ih1gqfWoVM1YrgE3AemLeASLHHs06M2nGGRXhx8aEEEmYjmFdysoVZdArObD9
 U+h+P3tQhkgbFotls1C3kS7t1C8qIVgSmspzAiskz6kDmqnU0VT5RrpBIW41ipFLpWw6
 F6JtHKVdv5LZv5A9DLKBK5bQe9LvtFbvSZByAmd6ynjxz9Y5TF1PLCHN71ex8e9EC+vJ
 61iA==
X-Gm-Message-State: AOJu0YzKQYdf8jNmuXoaAKyQDAM4WK8kvELlGMnC6bk4oIvt7zGxi/3r
 WW1xEGUx/F1IpJ8hHQzr7uXScvyJaf/Fn5w+oW3gGFTY+mQjK/aTRt3ER+4WmUQ=
X-Google-Smtp-Source: AGHT+IFimX/UevUYrOT5oEXpcXelUbnXSjgNGLHNF4s8AJb8uIw0Ck8Un2l/8dHsxwDid5ss5Q2fYw==
X-Received: by 2002:a05:6a00:1988:b0:6e5:ec63:95dd with SMTP id
 d8-20020a056a00198800b006e5ec6395ddmr7492844pfl.21.1710178911957; 
 Mon, 11 Mar 2024 10:41:51 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62d412000000b006e67b4d7b74sm4593187pfh.197.2024.03.11.10.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:41:51 -0700 (PDT)
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
Subject: [PATCH v4 14/24] tests/avocado/reverse_debugging.py: mark aarch64 and
 pseries as not flaky
Date: Tue, 12 Mar 2024 03:40:16 +1000
Message-ID: <20240311174026.2177152-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311174026.2177152-1-npiggin@gmail.com>
References: <20240311174026.2177152-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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

These seem to be quite solid, including on several gitlab CI runs.
Enabling them should help catch breakage in future.

And update the powernv comment -- gitlab isn't the problem, there are
known gaps in implementation.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/reverse_debugging.py | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index 92855a02a5..8fe76ff921 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -223,9 +223,6 @@ class ReverseDebugging_AArch64(ReverseDebugging):
 
     REG_PC = 32
 
-    # unidentified gitlab timeout problem
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
     def test_aarch64_virt(self):
         """
         :avocado: tags=arch:aarch64
@@ -248,14 +245,10 @@ class ReverseDebugging_ppc64(ReverseDebugging):
 
     REG_PC = 0x40
 
-    # unidentified gitlab timeout problem
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
     def test_ppc64_pseries(self):
         """
         :avocado: tags=arch:ppc64
         :avocado: tags=machine:pseries
-        :avocado: tags=flaky
         """
         # SLOF branches back to its entry point, which causes this test
         # to take the 'hit a breakpoint again' path. That's not a problem,
@@ -264,7 +257,7 @@ def test_ppc64_pseries(self):
         self.reverse_debugging()
 
     # See https://gitlab.com/qemu-project/qemu/-/issues/1992
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'powernv migration support is incomplete so rr debugging is flaky')
 
     def test_ppc64_powernv(self):
         """
-- 
2.42.0


