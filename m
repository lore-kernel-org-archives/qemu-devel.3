Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA20CC5320E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 10:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh5HE-0003DS-Li; Thu, 22 Aug 2024 06:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh5HD-0003Cy-6M
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 06:42:47 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh5HB-00019e-G0
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 06:42:46 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-371893dd249so284021f8f.2
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 03:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724323362; x=1724928162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zYTncKdl2H5JJa9yqMpXByipGyIEcUC+PC0v0Mplmdg=;
 b=D7PT5Bm+hmSACyPHmmBspcHzBz9ltccmGV81ETNBee3AXHCvbCmBQhcggmVZA+Ww14
 dZTpmOu7OaTLt0VLV0BfDgN/yjaGuKHJBRs1WIgL7VBPQskuG6okyuVWSj9orTa9chG/
 kynV8agtwQSXsdz5xEsdVHPMO1b1HZp0y5cbCOhEHTH8GWysdlpV2kh3Ag7AtNevekRE
 Uzg+Z+6YaGxEmpTEN+40kKJCaf8E9yz5iFty0l5kV1UE2qVj64wlbp2Rye6beD+g2zNC
 zp4teUd/1Xfkd6Q98fnmOhFugjAy7Le4O8O14YYOPppxtZPWsI9zw9mTLWqlsLI2itJk
 /qMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724323362; x=1724928162;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zYTncKdl2H5JJa9yqMpXByipGyIEcUC+PC0v0Mplmdg=;
 b=Y1A2ww6Qn7lkAld5APyqmodaP5741HdjYqW5Z31SSsFoORslngSXbZJoFuWbVcfGDP
 pa3m89PYCC2GRP15q9MNiE+b2gh41qEc+bbGIYlXQeRDjt1Ay0wxujIEYPGlVhJt4ZZU
 /FUzc8Iv4dfT1E7vGz6k25TFwZdK7CCv7ok5Ebq2Nu8aXpPFoYrW6Zd11BKdbgrbqX9O
 T5k05G4w+bZAMVfpQuALWPbFplwPg705B2I27J4MmD6sK29x+x0FHjVlIJB60oi4ma1C
 4dMEixgy7LQLHCJeAxbrwJJA9Ddi9ZP4y3vW6ebAYs/tW3yESTMEbotfrZvFdQnA+vNV
 1luQ==
X-Gm-Message-State: AOJu0YzLdjpQUbDOWuuc0eByWQ47q7WEcgqdamWVEFV9sEcW/BAEJsUV
 d0FtpfEtBBjXBmVU/zerL54QOLn7PNZNiC9adHybdRQmlkIGoR5B/oeePVswSjEAbkkn+RBF86F
 u
X-Google-Smtp-Source: AGHT+IE+SW7WIbINgFMdPe7tdCOqu7Qe3axPi5CieLB/8GeDq5c2e3hSlRJiQyKw9AlRJ+4A3g/WGg==
X-Received: by 2002:a5d:4bc5:0:b0:368:3b1a:8350 with SMTP id
 ffacd0b85a97d-372fd58d51fmr2902239f8f.19.1724323362137; 
 Thu, 22 Aug 2024 03:42:42 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37308265ae6sm1348923f8f.109.2024.08.22.03.42.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Aug 2024 03:42:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 0/3] tests/functional: Convert ARM bFLT linux-user avocado test
Date: Thu, 22 Aug 2024 12:42:35 +0200
Message-ID: <20240822104238.75045-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Convert the single user-mode test.

Warning, missing rework in tests/functional/meson.build,
however dirty tested using:

-- >8 --
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index f8e482a87c..44f8c2aa48 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -29,4 +29,3 @@ tests_generic = [
 tests_arm_thorough = [
-  'arm_canona1100',
-  'arm_n8x0',
+  'arm_bflt',
 ]
@@ -124,3 +123,3 @@ foreach speed : ['quick', 'thorough']
   foreach dir : target_dirs
-    if not dir.endswith('-softmmu')
+    if dir.endswith('-softmmu')
       continue
@@ -129,3 +128,3 @@ foreach speed : ['quick', 'thorough']
     target_base = dir.split('-')[0]
-    test_emulator = emulators['qemu-system-' + target_base]
+    test_emulator = emulators['qemu-' + target_base]

@@ -146,3 +145,3 @@ foreach speed : ['quick', 'thorough']
     test_env.set('QEMU_TEST_QEMU_BINARY',
-                 meson.global_build_root() / 'qemu-system-' + target_base)
+                 meson.global_build_root() / 'qemu-' + target_base)
     test_env.set('QEMU_BUILD_ROOT', meson.project_build_root())
---

  $ make check-func-arm SPEED=thorough QEMU_TEST_ALLOW_UNTRUSTED_CODE=1
  1/1 qemu:func-thorough+func-arm-thorough+thorough / func-arm-arm_bflt  OK    0.22s   1 subtests passed

Based-on: <20240821082748.65853-1-thuth@redhat.com>
Based-on: <20240822095045.72643-1-philmd@linaro.org>

Philippe Mathieu-Daudé (3):
  tests/functional: Add QemuUserTest class
  tests/functional: Convert ARM bFLT linux-user avocado test
  tests/avocado: Remove unused QemuUserTest class

 tests/avocado/avocado_qemu/__init__.py | 19 +--------
 tests/avocado/load_bflt.py             | 54 --------------------------
 tests/functional/qemu_test/__init__.py |  2 +-
 tests/functional/qemu_test/testcase.py | 17 ++++++++
 tests/functional/qemu_test/utils.py    |  9 +++++
 tests/functional/test_arm_bflt.py      | 44 +++++++++++++++++++++
 6 files changed, 72 insertions(+), 73 deletions(-)
 delete mode 100644 tests/avocado/load_bflt.py
 create mode 100755 tests/functional/test_arm_bflt.py

-- 
2.45.2


