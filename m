Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7177BCCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 09:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEldw-0006DL-6I; Fri, 31 Oct 2025 05:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEldt-0006Cn-N1
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:41:57 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEldq-00064o-Nr
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:41:57 -0400
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-429bf011e6cso666007f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 02:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761903711; x=1762508511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yQG/Os74TDDDUKJZ8k+lusmOZW9KraIcMlAXT1k8M18=;
 b=fivVsoyqRtzgs/VWOzZ9Z8H8qlc/NcKG1a3WGzbnJowBwsl14bfhijv6VvZnKzgk3I
 O9oeJsS6OniXYTwDOhlVdhKsvKeWogbHicZvhwzV4A33L9dXIzQpGTd1R895M92iel+8
 ZBJNtsxzerYizaMZQJlh+n8Bc85HmA5CXyEJonUvjAez+beBn9A/7bBMQpHvrUai2wcM
 je7SSsx8+HNPq/9y8umD0IKAYC5a8A+RCuQkmQUGBNNGq1qAb6Bly47yDDctveA3Gue1
 +lfIenqr1YirjeKTaVAESJ9l3Oyxw9INug+blY9P79Hvk4hXScWPeByso8gvw12NWHfm
 0J2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761903711; x=1762508511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yQG/Os74TDDDUKJZ8k+lusmOZW9KraIcMlAXT1k8M18=;
 b=EmpCmZeHTLC1wG531hnrOpBbW+XRFCZvZnOwtABVJCblDL2IXLSSifI17YxWain6yc
 BW38b7q4knjVeZJNraw80RdPkOHUkGxrASNUO3abjZFRsUlOK+gviGIMVZtbBljlAqE3
 Kv6BSYLnOY9vZwxCqg6xX8gvwOiMbmEiyA/fr+0sAK+eoiywBm39F7bA9YK3zOOAhD1m
 SaqfJiwG6jiz4olk9eoOvkqc1rQF7xPghz/p+opp7rUqBd67PisxOqQHd562a0KEwxTH
 RFXRMMXOIKbNt2ZykudsuvZQfU6hsJOSyUf9LU3zai2RuIZIGVmuobsgcT6jc2mRAUsR
 TA/g==
X-Gm-Message-State: AOJu0YyCHABX9osuGzeRqtSKPJr1LeBz9GfVIY1VGMrmbWWQlC1drQtG
 uFwvlstZ9Sjy5iY7WrrGtIkgtggnyG4aMaw5pOAOKzELALZ6B1BOokXBgR54AW0aR3kqUDJsmIV
 cEhk9nrdWfRkau+Q=
X-Gm-Gg: ASbGncttVS91WZM+cfNnoAmt/fxMaiTd1LkaAPdd81o5/faqgo2xepvoDpwW3v5skjH
 +DV7N+m/jTSu+FFaryq4oInrLNACEYI5qg1iL7veSnrXhdoTKCtG1WaTeoj5GT+Z9DPofiH8SaF
 s0VtqIfdE1Mj3bmFIT4n0/Sy1U9bGHxYh0lhdwNXhIQUVWy9aw4h2KkHdNhiT2gr6YFqcJqipLj
 wz+qvQ/SYQdR+Ier2u/Q+2PybQXL1MLZVmig5yLNolb3eYojDQxbOgPCgJvX5fbXrrsDi5aUiB/
 zq3k+84G5h5kiGC8l4xsoCsQo7Xg/V0pQynTNVn1rqXua+N7I4nAc15iGWB8SJGooz/r95Hlnmb
 Qf5cNMAcOVAqqFoRe9rGGAeShvLWuievMdPsrOULZd92C5IJsIPyTDMo8Q7HRjveEXXI4OyFlQq
 4ZHqwO238PiymW00McQJIzQKnCb2AMkgKISDrnl7WqMceLAb/gDotRGVAAkpP2LD6T
X-Google-Smtp-Source: AGHT+IFETqId4d9X+vBRDkvlkxzsec+WMHVf6uGJU+Vq7dZE2hgvtzv+BVY4Ih3CXt1oEPrQ0WflOg==
X-Received: by 2002:a05:6000:400a:b0:427:6cb:74a4 with SMTP id
 ffacd0b85a97d-429bd6aa232mr2268033f8f.39.1761903711340; 
 Fri, 31 Oct 2025 02:41:51 -0700 (PDT)
Received: from pc56.home (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c102dfd2sm2645436f8f.0.2025.10.31.02.41.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Oct 2025 02:41:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/2] tests/functional: Mark the MIPS Debian Wheezy tests as
 flaky
Date: Fri, 31 Oct 2025 10:41:18 +0100
Message-ID: <20251031094118.28440-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031094118.28440-1-philmd@linaro.org>
References: <20251031094118.28440-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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

test_malta.py sometimes times out (likely hang) under GitLab CI:

  1/57 qemu:func-thorough+func-mips-thorough+thorough / func-mips-malta    TIMEOUT   480.11s   killed by signal 15 SIGTERM

console.log shows a soft lockup failure:

  06:46,426: INIT: version 2.88 booting
  06:46,942: [[36minfo[39;49m] Using makefile-style concurrent boot in runlevel S.
  06:47,378: findfs: unable to resolve 'UUID=042f1883-e9a5-4801-bb9b-667b5c8e87ea'
  06:50,448: [....] Starting the hotplug events dispatcher: udevd[?25l[?1c7[1G[[32m ok [39;49m8[?25h[?0c.
  06:52,269: [....] Synthesizing the initial hotplug events...module e1000: dangerous R_MIPS_LO16 REL relocation
  07:17,707: BUG: soft lockup - CPU#0 stuck for 22s! [modprobe:208]
  07:17,707: Modules linked in:
  07:17,707: Cpu 0
  07:17,708: $ 0   : 00000000 1000a400 0000003d 87808b00
  07:17,708: $ 4   : 87808b00 87808bf0 00000000 00000000
  07:17,709: $ 8   : 86862100 86862100 86862100 86862100
  07:17,709: $12   : 86862100 00000000 00000001 86862100
  07:17,709: $16   : 87808a00 86862100 1000a401 c008fa60
  07:17,709: $20   : 86862100 8041d230 00000000 ffff0000
  07:17,710: $24   : 00000000 77711470
  07:17,710: $28   : 87bb6000 87bb7df8 8041d230 801f7388
  07:17,710: Hi    : 00000000
  07:17,710: Lo    : 00000000
  07:17,711: epc   : 801f7308 kfree+0x104/0x19c
  07:17,711: Not tainted
  07:17,711: ra    : 801f7388 kfree+0x184/0x19c
  07:17,712: Status: 1000a403    KERNEL EXL IE
  07:17,712: Cause : 50808000
  07:17,712: PrId  : 00019300 (MIPS 24Kc)
  07:45,707: BUG: soft lockup - CPU#0 stuck for 22s! [modprobe:208]
  07:45,707: Modules linked in:

Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/mips/test_malta.py     | 2 ++
 tests/functional/mips64/test_malta.py   | 2 ++
 tests/functional/mips64el/test_malta.py | 1 +
 tests/functional/mipsel/test_malta.py   | 2 ++
 4 files changed, 7 insertions(+)

diff --git a/tests/functional/mips/test_malta.py b/tests/functional/mips/test_malta.py
index 30279f0ff21..7a734bc069b 100755
--- a/tests/functional/mips/test_malta.py
+++ b/tests/functional/mips/test_malta.py
@@ -9,6 +9,7 @@
 import os
 
 from qemu_test import LinuxKernelTest, Asset, wait_for_console_pattern
+from qemu_test import skipFlakyTest
 from qemu_test import exec_command_and_wait_for_pattern
 
 
@@ -181,6 +182,7 @@ def test_mips_malta_cpio(self):
          'debian_wheezy_mips_standard.qcow2'),
         'de03599285b8382ad309309a6c4869f6c6c42a5cfc983342bab9ec0dfa7849a2')
 
+    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/3109")
     def test_wheezy(self):
         kernel_path = self.ASSET_WHEEZY_KERNEL.fetch()
         image_path = self.ASSET_WHEEZY_DISK.fetch()
diff --git a/tests/functional/mips64/test_malta.py b/tests/functional/mips64/test_malta.py
index a553d3c5bc7..91c57c56af0 100755
--- a/tests/functional/mips64/test_malta.py
+++ b/tests/functional/mips64/test_malta.py
@@ -5,6 +5,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
+from qemu_test import skipFlakyTest
 from mips.test_malta import mips_check_wheezy
 
 
@@ -20,6 +21,7 @@ class MaltaMachineConsole(LinuxKernelTest):
          'debian_wheezy_mips_standard.qcow2'),
         'de03599285b8382ad309309a6c4869f6c6c42a5cfc983342bab9ec0dfa7849a2')
 
+    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/3109")
     def test_wheezy(self):
         kernel_path = self.ASSET_WHEEZY_KERNEL.fetch()
         image_path = self.ASSET_WHEEZY_DISK.fetch()
diff --git a/tests/functional/mips64el/test_malta.py b/tests/functional/mips64el/test_malta.py
index 170147bfcc2..e37463dc291 100755
--- a/tests/functional/mips64el/test_malta.py
+++ b/tests/functional/mips64el/test_malta.py
@@ -102,6 +102,7 @@ def test_mips64el_malta_5KEc_cpio(self):
          'debian_wheezy_mipsel_standard.qcow2'),
         '454f09ae39f7e6461c84727b927100d2c7813841f2a0a5dce328114887ecf914')
 
+    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/3109")
     def test_wheezy(self):
         kernel_path = self.ASSET_WHEEZY_KERNEL.fetch()
         image_path = self.ASSET_WHEEZY_DISK.fetch()
diff --git a/tests/functional/mipsel/test_malta.py b/tests/functional/mipsel/test_malta.py
index 427e163d19d..59ab4a60585 100755
--- a/tests/functional/mipsel/test_malta.py
+++ b/tests/functional/mipsel/test_malta.py
@@ -10,6 +10,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import QemuSystemTest, LinuxKernelTest, Asset
+from qemu_test import skipFlakyTest
 from qemu_test import interrupt_interactive_console_until_pattern
 from qemu_test import wait_for_console_pattern
 
@@ -69,6 +70,7 @@ def test_mips_malta32el_nanomips_64k_dbg(self):
          'debian_wheezy_mipsel_standard.qcow2'),
         '454f09ae39f7e6461c84727b927100d2c7813841f2a0a5dce328114887ecf914')
 
+    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/3109")
     def test_wheezy(self):
         kernel_path = self.ASSET_WHEEZY_KERNEL.fetch()
         image_path = self.ASSET_WHEEZY_DISK.fetch()
-- 
2.51.0


