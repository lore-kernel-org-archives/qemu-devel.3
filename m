Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B604CC282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 18:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpAzU-0006N1-7J; Mon, 03 Mar 2025 13:58:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tpAzQ-0006MU-DD
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 13:58:09 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tpAzI-00082v-IY
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 13:58:08 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2235908a30aso72601625ad.3
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 10:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741028273; x=1741633073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MlxeaBTa0OnfkqZwMGX009w7nxjBMGcnOIKYJ90xgwk=;
 b=S7sxl5OyzUjVscw7PHEmeUPPI0EfaASXcIjmiZ8oRSUyhMBLgnw31oMD93J5tsQPNt
 Mms08IXrFSImKZIrEJNcRGUMJUPfmr/rPq1hbqpgl2sz5atCIKlZzUFvBy1CFgm4ja3X
 fUaPjZOxG2mWO6/ZK2jFF1ToxEBrsISsaevL1D9xB4omlIafPPvRwqNlNFML6ggDfiO9
 hU3O31BCK+9UBiYLT8RyrDuWwgyVMEmWjyTN3vuEXasCmMoY61bWsgrxotn/OxirZcO/
 gB05HwqNZ0ObZlBcVz+PfBbPiJOpTU2ByZF8LmIyTJ1coa55EPiq0Ut4AyDeCNiaIUd8
 dH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741028273; x=1741633073;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MlxeaBTa0OnfkqZwMGX009w7nxjBMGcnOIKYJ90xgwk=;
 b=c+IE2E9POhFRmqT2UA2lOZXkXlZuiIV86f9EH5wte6teVOg3HBbuhT8g1e2aTJqx9I
 P+MX6vQ7Z6VzjorNb3zdkWE7sr/rbeUsIObZFllt0AZ9YvWe6EE7lK0jse6zvGe0oZqH
 ngKp1rH7ulwoQOhdfzCyvhbcbknX8Wl2q3kt7TShRgXy14e209Ioa0aDozyV3B+wtuVF
 G4VfjDabcvgrZTheisWU312Jgucx7cwGRLqBJCug2UxR0dp9Mf54ix4h6VqzVMkzCMoJ
 r4UFnYtVZDxIkVbwA8uqlImtGrJUwQPo08NXh3ncAXK+ZOpbNun4MJpz5o+0N4jLKM5m
 wsrQ==
X-Gm-Message-State: AOJu0YwfgqC4hEX9xXQ+z7vjz8rQO4+JbdaR1bN/EC4S8Us+a118klwU
 BBcZt+z/4sLOfA7L1xK2hCppdDBqUNTSUy7D5JSGbLFdT4ZiSaKsfUww4Pzgw3XSSV0d1sPVcgl
 n50z4Dg==
X-Gm-Gg: ASbGncuyGmrKX5wnkiFSyzHFtxqL78CTsDxucLPW64z7e0sfobHwj5xTKZtEE9QnEY4
 sVJaxTObrzq0cLx2vBnQRhLopUPFdpMwrt7Et9mUj83EybYHZQXJk2EKWoPavnZpCHLaHS5Co7p
 7ADX20VE2BMcy2pyx+Er19FO0JjV8kkj1Y7dYdyq+00IPI723F+Co62YhS8xVHt3pzKX9ZpMsrK
 yN64KY/hQUSQeJIdHw8Tvng2jg6l5S5LfihHuuicp5Swni8O93ERtZw3h6x2S9a+xVuW/3Ximn+
 202eYW31vgNkv/PMMD6bwAq6etWnAiIsyK/A0+05OLms
X-Google-Smtp-Source: AGHT+IEr1r5Kupen/oAqfiVInkafhwrGRmuUCtCl8NLBBS29DKperNqda8cr1yKGp166oxGBwubrSg==
X-Received: by 2002:a17:902:cec7:b0:223:5c33:56b4 with SMTP id
 d9443c01a7336-22368f91d03mr219979805ad.20.1741028273256; 
 Mon, 03 Mar 2025 10:57:53 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223504c5dcesm81214225ad.119.2025.03.03.10.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 10:57:52 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] tests/functional: add boot error detection for RME tests
Date: Mon,  3 Mar 2025 10:57:45 -0800
Message-Id: <20250303185745.2504842-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

It was identified that those tests randomly fail with a synchronous
exception at boot (reported by EDK2).
While we solve this problem, report failure immediately so tests don't
timeout in CI.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/functional/test_aarch64_rme_sbsaref.py | 3 ++-
 tests/functional/test_aarch64_rme_virt.py    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/functional/test_aarch64_rme_sbsaref.py b/tests/functional/test_aarch64_rme_sbsaref.py
index 93bb5283386..ddcc9493a6c 100755
--- a/tests/functional/test_aarch64_rme_sbsaref.py
+++ b/tests/functional/test_aarch64_rme_sbsaref.py
@@ -60,7 +60,8 @@ def test_aarch64_rme_sbsaref(self):
 
         self.vm.launch()
         # Wait for host VM boot to complete.
-        wait_for_console_pattern(self, 'Welcome to Buildroot')
+        wait_for_console_pattern(self, 'Welcome to Buildroot',
+                                 failure_message='Synchronous Exception at')
         exec_command_and_wait_for_pattern(self, 'root', '#')
 
         test_realms_guest(self)
diff --git a/tests/functional/test_aarch64_rme_virt.py b/tests/functional/test_aarch64_rme_virt.py
index 42b9229b4cb..38e01721a4e 100755
--- a/tests/functional/test_aarch64_rme_virt.py
+++ b/tests/functional/test_aarch64_rme_virt.py
@@ -89,7 +89,8 @@ def test_aarch64_rme_virt(self):
 
         self.vm.launch()
         # Wait for host VM boot to complete.
-        wait_for_console_pattern(self, 'Welcome to Buildroot')
+        wait_for_console_pattern(self, 'Welcome to Buildroot',
+                                 failure_message='Synchronous Exception at')
         exec_command_and_wait_for_pattern(self, 'root', '#')
 
         test_realms_guest(self)
-- 
2.39.5


