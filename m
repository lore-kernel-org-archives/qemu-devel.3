Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92608CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnhj-0007Xt-7S; Fri, 31 Oct 2025 07:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vEnhg-0007Wl-7l
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:54:01 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vEnhS-0005xi-He
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:53:59 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b6d6984a5baso412688666b.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 04:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761911621; x=1762516421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2I/yueIXmHU+++rshocZvOrvBhzR3OdLvTc+kjqGUpk=;
 b=fLLNt/ZwOxBO2zPPGcEW12lC7c1AhohiJ6baODsquPdHaud0Zhuh1x2gcNQtbwV4ws
 DCWKGhOmJNvyPutRPLByfmpfUPl9gsII0QajiQ/7VsfHLttBN2fojDr6MIdc8CIUPIXi
 xeFjpk/qsVNnmXEKb7hpPFjDAgbRrYKcdG0+B/2I0XYr20TTHo+fj9aKc1sz/98qQloB
 ncmVJuf2gLu5QyE4zjAie50eAeAJJOv0U55k2ze8Y6sItQSGTaF6ZQI3frtLFPM/+3Xj
 99YLtYpl+wiGikC9GR8JBbf8GWIreMV7Me9Ldx8iENiAS2k5Ns8ks7HS/P5MEm5c9aNH
 DUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761911621; x=1762516421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2I/yueIXmHU+++rshocZvOrvBhzR3OdLvTc+kjqGUpk=;
 b=Ei4mZ73l4vWWYV5PNSsqlFEK9mSU9CccI8vMRUn7z/Fa+qwMcdj55HYhcjJ91jDqyk
 gtuv31SX/bteLBoG01DT8SABD4SdqEtISnutmlRgIjNZjm1i1fBfUt/LVCkO/dG5SR7V
 5XSkvtvGFrV3X3kX77If+ovH3zjsQz7CbzRqbbzxJWd6Rgt3IeRZz9pL/YqGieR9Ynbm
 IP+Zad0DxVAai2RGBxAu9fO9AbiapRGbZwcH+ofEe/folAI72Jww57+BO3A2pvwge1At
 qnZBnZNuVFxWHYoZtPQ0sUIimEoFMaTsqmnmytNSLHKhgew2AH5RMmt2d5LJH6cXfCjD
 rPSg==
X-Gm-Message-State: AOJu0YyTxgVic0yPMAFFwzwAM0t2kY9tstezJiqBbTlIhMfqh0DhU7AO
 Iu7Ej5ccA3fiTxZ2+s0pXzECpXrCiwg2Bsl183K6875I720L+8/al6FjIXrNJygExk6gi4FEitg
 D9vxO4uI=
X-Gm-Gg: ASbGnct5ciC2rQJYbdT0DrOCGNlcs7vNnwYHp8T8Y2VdKZtdpF5pSKHzZxuIkXe04L2
 sJoAyNYp6vmuo6I1SbeehfsXF3sxywfBTk4uYpU2XmFsC4GeH0XLv+V0XVSX45MHDS4v2k8p26y
 WCfT01HkFsGCE1hYMajLItCOpbs41HQpsCnpULqFl0VrgAxO+S1/45BCos9/BQpJwqKr6uyFNXN
 HX/oaLvTHPO3S+/db5AjmIUnwz3lNsTxz+WGBZH+HLuHEfaCSzMcSW7ijcisojJpX9+eijrfn/I
 1srmD196F1saUBkLZ+nf389Rej31k9HsJhI2gIdlpl3HXTsggVJfMdSEXTKYzzRPMxP3eka6cyt
 DQ7521rnwQgTBFzk6R7T9fqjdz+jvEjh1C+5OLF0Pc/fJyebLssGumGsYMc1LXmD23C/vgSxCbw
 bToefDBTMC8mvWP53JiCoXdciPojVnmVFrVSR+CaexQ9Imm4CzpA4=
X-Google-Smtp-Source: AGHT+IFzoLegRNXteI4QvNijhXEchtGXG07FtytqpW8w5cfIfKPctNJEW/GoChjkyNcN6t/asH31QA==
X-Received: by 2002:a17:907:3c83:b0:b3f:f66b:268a with SMTP id
 a640c23a62f3a-b707013e29amr357145266b.19.1761911621525; 
 Fri, 31 Oct 2025 04:53:41 -0700 (PDT)
Received: from stoup.. (C3239BBB.static.ziggozakelijk.nl. [195.35.155.187])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7077975dcbsm158078366b.14.2025.10.31.04.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 04:53:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 4/5] tests/functional: Mark the MIPS Debian Wheezy tests as
 flaky
Date: Fri, 31 Oct 2025 12:53:32 +0100
Message-ID: <20251031115334.368165-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031115334.368165-1-richard.henderson@linaro.org>
References: <20251031115334.368165-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x636.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251031094118.28440-3-philmd@linaro.org>
---
 tests/functional/mips/test_malta.py     | 2 ++
 tests/functional/mips64/test_malta.py   | 2 ++
 tests/functional/mips64el/test_malta.py | 1 +
 tests/functional/mipsel/test_malta.py   | 2 ++
 4 files changed, 7 insertions(+)

diff --git a/tests/functional/mips/test_malta.py b/tests/functional/mips/test_malta.py
index 30279f0ff2..7a734bc069 100755
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
index a553d3c5bc..91c57c56af 100755
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
index 170147bfcc..e37463dc29 100755
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
index 427e163d19..59ab4a6058 100755
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
2.43.0


