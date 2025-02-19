Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488C6C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 19:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkpg4-00042W-Dm; Wed, 19 Feb 2025 14:24:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkpfp-0003zV-NE
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 14:23:59 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkpfm-0002PD-NY
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 14:23:56 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38f1e8efe82so187538f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 11:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739993033; x=1740597833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dpCypAtbAdRfHr1nP5vbTeramo1Dr981PUBxWlWPTN0=;
 b=lxuIgT16SpXPlM/5NfOLFvVtmZcXIKdD8+9kfVD6Vf3fqpZxVOpBaegi+Eot4eNzLx
 4UbOSCIk9KmW99F/wMjkcZ2aFtG0tjyBPqkLeGUMeYWb/46g52bdi71dxhraOSeWlOxW
 8gV4WNpVSjR7kkZqGsIcDeETcuahCdeUlKVgen3kIL1TNZbEMMF1RUzvg4tczmU28yDu
 jsfh16tPY/2yG+ZWJU7NOO06cIANc3JSVGxPFuEn9jcBHYEKNvXTFjCoxwSXiRvuO8ms
 Y4Y7CeTEpjax5EatdJbIvKutAfY5gjolGT2Ytzb9TaxDXf88hl2humDYiFUkTEtxG8mV
 RckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739993033; x=1740597833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dpCypAtbAdRfHr1nP5vbTeramo1Dr981PUBxWlWPTN0=;
 b=P0tV4lDp3GpLsT/mawVv4ZTWhV9uhpHCmuKbc6flDCY2eUS2VBCzSHfQ8wUNSpQG3p
 mN+UCh7B6rXGjPySVpaFY5vBSxqh8QfObY039Xtw3hmYdKC8+8M+InDjJu/Eyyme53Wg
 4MS/Nd1B/6LBiFzuEp7UDIWyHHZkH8k4XaPdc0XfvtvEWG0TRfaxKfn94szf7zDcNf5z
 uxSNtvUiNQAjMd2aYwZ+Ro5bJe04DT+2TdRt9FRspO3SFIpRLzQzvRw4i8eTzptq+CcO
 D0cQkMTWoceSVOG+AmcaosTcvR1rfPwaaiuECwvdbVG1ZpOPpNNxsx98fyFlPmHDtXAb
 yWfQ==
X-Gm-Message-State: AOJu0YxOutJmO8wzoqoP4bXgOU88Gh78CAabTa1+Yyd/dTdihBd5uKvh
 DnHj+a2sE4JMauP/Bzc3CKcUOddKh3Zx099+Mw04FDUQ9DK7IT+t7dgeiNTWalWzpj1G8JlTxli
 toyU=
X-Gm-Gg: ASbGncvKWSfWTl+YJNHgUKQPf5HP/SbpxUs/mDnStYtTBd/gytNkE5SJ0WdkNvkOtTM
 L8TClDrSVD31/5mGlWWRkC4O7/BMoeUGz77jKLpqmyWP9zBEU7WJxJKVrf2AYXjaj+fUnBqxNUE
 S2UhyJkyJ52gQQxtrP/c3IRtMtt8A5ytA7BlFl393hVFqGpAzd4aY2fX0SBrme0QTmrg/LZBE+3
 YpAfDFCcAIIxxv4ZRLHnRh252sJaAe3qSISZSL2O3fyTqNhzQQd5zn/A8lFtplcQr8Vw4SeukGB
 ZUr2XozZsUSULPnmhiSSlX5+AP249yRFWs5a94De17XBxssVxYEpeShQ0QIEP1sgOg==
X-Google-Smtp-Source: AGHT+IEDmHfCKkm/pw/w9ptMt13XYdS6/32Np9zwYkINtLaBDp/CTK/rNyfM3NNbaui8T/u439M+gA==
X-Received: by 2002:a05:6000:11d0:b0:38d:af14:cb1 with SMTP id
 ffacd0b85a97d-38f33f58dbdmr15159987f8f.54.1739993032672; 
 Wed, 19 Feb 2025 11:23:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b44b2sm18385648f8f.20.2025.02.19.11.23.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Feb 2025 11:23:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH 2/2] tests/functional: Allow running TCG plugins tests on
 non-Linux/BSD hosts
Date: Wed, 19 Feb 2025 20:23:40 +0100
Message-ID: <20250219192340.92240-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250219192340.92240-1-philmd@linaro.org>
References: <20250219192340.92240-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Not all platforms use the '.so' suffix for shared libraries,
which is how plugins are built. Use the recently introduced
dso_suffix() helper to get the proper host suffix.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2804
Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/test_aarch64_tcg_plugins.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/functional/test_aarch64_tcg_plugins.py b/tests/functional/test_aarch64_tcg_plugins.py
index 7e8beacc833..306e46c7972 100755
--- a/tests/functional/test_aarch64_tcg_plugins.py
+++ b/tests/functional/test_aarch64_tcg_plugins.py
@@ -16,7 +16,7 @@
 import re
 
 from qemu.machine.machine import VMLaunchFailure
-from qemu_test import LinuxKernelTest, Asset
+from qemu_test import LinuxKernelTest, Asset, dso_suffix
 
 
 class PluginKernelBase(LinuxKernelTest):
@@ -62,6 +62,10 @@ class PluginKernelNormal(PluginKernelBase):
         ('https://storage.tuxboot.com/20230331/arm64/Image'),
         'ce95a7101a5fecebe0fe630deee6bd97b32ba41bc8754090e9ad8961ea8674c7')
 
+    def plugin_file(self, plugin_name):
+        suffix = dso_suffix()
+        return f'tests/tcg/plugins/{plugin_name}.{suffix}'
+
     def test_aarch64_virt_insn(self):
         self.set_machine('virt')
         self.cpu='cortex-a53'
@@ -74,7 +78,7 @@ def test_aarch64_virt_insn(self):
                                                  suffix=".log")
 
         self.run_vm(kernel_path, kernel_command_line,
-                    "tests/tcg/plugins/libinsn.so", plugin_log.name,
+                    self.plugin_file('libinsn'), plugin_log.name,
                     console_pattern)
 
         with plugin_log as lf, \
@@ -100,7 +104,7 @@ def test_aarch64_virt_insn_icount(self):
                                                  suffix=".log")
 
         self.run_vm(kernel_path, kernel_command_line,
-                    "tests/tcg/plugins/libinsn.so", plugin_log.name,
+                    self.plugin_file('libinsn'), plugin_log.name,
                     console_pattern,
                     args=('-icount', 'shift=1'))
 
-- 
2.47.1


