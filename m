Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A557E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEuA-0004o5-1A; Fri, 10 Jan 2025 08:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtt-0004gQ-Ka
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:09 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtq-0004kd-Ng
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:08 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so15156395e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515085; x=1737119885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6LGPQrma4XTCDNDbbK6Y397fLHxFQ/LRSzYQ8GARXks=;
 b=akXd/yxBfGb3HZH/c6ImVBJ6KycRobR7hjXPkPni/i3wURv71PmSMnygQSI1zviTgv
 WNlvxbeoohBxqqSArL1U8DX6+uj0R4lfQ+nSSduwQkUIkKTumLzUEnoUrPfl21oqag+V
 QxIA8Fk8K4liNQHVDxSs6k+QeeOEz3G96tKZYsdAWejsLNqNgYakA85RO8Miu5RB1ubV
 TM1c0pxN7Ju5Y1YQJCSjljAXc3vUeVaRexYIe8gRcyU5mUV0yrpdt1ZlkZR6zTiXEkUZ
 Fw+B1NAse1YyKrB7SRe9TWLEyRHqa1fgRvvYgnLr0cV638IZw1F10sEPfgblSRGs0kRu
 SHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515085; x=1737119885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6LGPQrma4XTCDNDbbK6Y397fLHxFQ/LRSzYQ8GARXks=;
 b=NmGMrPgW5/vLRUrVpbb+Zx50Xxb6bUH/nutfoDLt2dtMSiyAl3qZVZl1TJCkqSF18p
 imykYXUBHjNG21sKd91TJ4QHNkwX3by53Da+P8T4UBHY0BpGiV0u0U6tjiKC2eAJDJzE
 0Z3+gxxG5vL+8o20bm/0s4Ay8CrMw5afaQYJ/ot95e3yo/NphOkIdPm47pxtQxUkPjDt
 k3BaW/kn6bqF3JBtTopOCDxSuHX80gcZYYeCapDWGj7qR2DKASC9lSCMtMX2XejFi32f
 u4zvlsfLuUv+KiK66EuA0iUnY5ZgXrpsIQ1qiU6WgPpimgq7OxMCkVvAGDVV0+VgUzZ6
 RrAQ==
X-Gm-Message-State: AOJu0YwwoZFT/sWrbsXK+UPideUHj/yDS7YrjGEeBsbtt0D0TEQKb2vd
 J+EMNc4x26KqFFVThwkHisZML6qMXA42EBXEJkM1F6GFhh6PnuGYUSMXq4Z5yec=
X-Gm-Gg: ASbGnctjH4X72wk9zws44/ghwurRhUnB9RXUd9l5wvFBHTWYNofqLBUIoE10UnXHkm0
 KI0tvIIaeueIP13ixe+vh+IlQW1PCXLvvKsPxPnOjCPNu0G/lDtsjoByW6qSZL4wrXJxEwPAbeg
 xnjepu1sCnF3Y8TUTNHMg6WyrGyyJKScXcOYF/w1pHJfGroRPpCCfY5XA4+3FwJjE55u7o9917t
 l72KkW1iv+YiEhsuDbPUC4CgBBj5aIFKjIiSXyj6N27U0hEALXNuiU=
X-Google-Smtp-Source: AGHT+IEc4I89B8FLQDUOtxJWouQvVGgrmd8D8nNfUShjV1X48CEb2nVJm+ikSqP9j1cda1QYAawP8w==
X-Received: by 2002:a05:600c:3516:b0:436:5165:f206 with SMTP id
 5b1f17b1804b1-436e27075eemr107786145e9.31.1736515085292; 
 Fri, 10 Jan 2025 05:18:05 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38428bsm4556045f8f.37.2025.01.10.05.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:18:02 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B46A2609F2;
 Fri, 10 Jan 2025 13:17:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:Virt)
Subject: [PULL 18/32] tests/functional: remove hacky sleep from the tests
Date: Fri, 10 Jan 2025 13:17:40 +0000
Message-Id: <20250110131754.2769814-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

We have proper detection of prompts now so we don't need to guess with
sleep() sprinkled through the test. The extra step of calling halt is
just to flush the final bits of the log (although the last line is
still missed).

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250108121054.1126164-19-alex.bennee@linaro.org>

diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/test_aarch64_virt.py
index 08576b0694..2d9995a95d 100755
--- a/tests/functional/test_aarch64_virt.py
+++ b/tests/functional/test_aarch64_virt.py
@@ -10,12 +10,12 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import time
 import logging
 from subprocess import check_call, DEVNULL
 
 from qemu_test import QemuSystemTest, Asset
-from qemu_test import exec_command, wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
 from qemu_test import get_qemu_img
 
 
@@ -107,18 +107,22 @@ def common_aarch64_virt(self, machine):
                          'virtio-blk-device,drive=scratch')
 
         self.vm.launch()
-        self.wait_for_console_pattern('Welcome to Buildroot')
-        time.sleep(0.1)
-        exec_command(self, 'root')
-        time.sleep(0.1)
-        exec_command(self, 'dd if=/dev/hwrng of=/dev/vda bs=512 count=4')
-        time.sleep(0.1)
-        exec_command(self, 'md5sum /dev/vda')
-        time.sleep(0.1)
-        exec_command(self, 'cat /proc/interrupts')
-        time.sleep(0.1)
-        exec_command(self, 'cat /proc/self/maps')
-        time.sleep(0.1)
+
+        ps1='#'
+        self.wait_for_console_pattern('login:')
+
+        commands = [
+            ('root', ps1),
+            ('cat /proc/interrupts', ps1),
+            ('cat /proc/self/maps', ps1),
+            ('uname -a', ps1),
+            ('dd if=/dev/hwrng of=/dev/vda bs=512 count=4', ps1),
+            ('md5sum /dev/vda', ps1),
+            ('halt -n', 'reboot: System halted')
+        ]
+
+        for cmd, pattern in commands:
+            exec_command_and_wait_for_pattern(self, cmd, pattern)
 
     def test_aarch64_virt_gicv3(self):
         self.common_aarch64_virt("virt,gic_version=3")
-- 
2.39.5


