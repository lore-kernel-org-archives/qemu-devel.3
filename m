Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19B4CDD57A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwu-0006tW-Ub; Thu, 19 Sep 2024 09:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwV-0005NJ-9R
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:32 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwR-00014R-DZ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:30 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cba8340beso12227225e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751486; x=1727356286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3kQBlK5vS8qxp5uwCgrYf9PWvy5sZQf/8kseDk6bM60=;
 b=oRSwHkG385YBs8d6P5++mEnyXpnB3U8XXrRxlNnpauYGO45Ti5rr+CUhbzVgAYWWH6
 5XYUXdwIhyltTJk5lXlqnYXSYkVr5ku5q6dDMUQZ+m3s1UjiA8jNA4KMYG271RE4ML/Z
 9YSkeeHbu98U4f3eNBglxmP7C5GznVNLSXWfeLUQ+Vd6MlF/Lhfx5iRulkdfCulSl7HO
 V1B15hXlGwxXbYG4OZ1oRrWTQcPoZBpn0abHq4ymCwXVogorY0vyopHdkF0pr0kU/JTY
 bmaWqskdAfejLsF6PW6Q9OQBWUH4TMDTg8uS2k0a2A8eCKtHvrrsjzXOJhxmi1cKxPql
 wAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751486; x=1727356286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3kQBlK5vS8qxp5uwCgrYf9PWvy5sZQf/8kseDk6bM60=;
 b=f7PdBmv1lqgWhYQ0F7fFmq4r8osLJJfdqTQi/KX27x0KzHFsGFH5OdjagqBo5RZWnN
 QJ4cEI2Df8MhDaPK7CinFmbXrIW+pMJV8McV6BYGIVdZKYnuh9zCER7RVcEc5YolizaP
 uSFzu+9+3Hsflcd7Yef/kFpPmOuxOaZkHNyismxjiwRB8Q7DBbLJblHVo0jkzSRFbIyR
 tP4unL/W2R/DX4CMvpNUFOQdSkf2XZmnoc1IdASZsIssg8KpjwOhG6xIuzspnANbW17q
 sIu/1pejcU7rXK1xl0mr5Vy2kbxK5GrWuL2BZFWOZ7NEgoRT8hz+ZctNSitnDiS+++dP
 U/uw==
X-Gm-Message-State: AOJu0YxOQwRXmMQo1yd/BF0uM8PJJUCLrxBQMZCDyG6mk1pIMgkJAVmq
 AvdiPpA2eq3Ado6IF+JKAFFD0XfMX35oNqNC0ZJupZMplRP/wKOR+Lb4U3oeWQIvYs1BqYmtYK2
 H
X-Google-Smtp-Source: AGHT+IFa+dOG0pOI7n+VojTWeDwV747e3DbYLq8XIqFlWqJ34wdhk0Mwx7m5/7k61s8zhq8HLGhdhA==
X-Received: by 2002:a05:600c:1c9d:b0:42c:b377:3f55 with SMTP id
 5b1f17b1804b1-42e743f263bmr19515345e9.3.1726751485895; 
 Thu, 19 Sep 2024 06:11:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/38] tests: use default cpu for aarch64/sbsa-ref
Date: Thu, 19 Sep 2024 14:10:59 +0100
Message-Id: <20240919131106.3362543-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

We want to run tests using default cpu without having to remember which
Arm core is it.

Change Neoverse-N1 (old default) test to use default cpu (Neoverse-N2 at
the moment).

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-id: 20240910-b4-move-to-freebsd-v5-1-0fb66d803c93@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/test_aarch64_sbsaref.py | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tests/functional/test_aarch64_sbsaref.py b/tests/functional/test_aarch64_sbsaref.py
index f31c2a60b61..528882f4fa9 100755
--- a/tests/functional/test_aarch64_sbsaref.py
+++ b/tests/functional/test_aarch64_sbsaref.py
@@ -110,16 +110,17 @@ def test_sbsaref_edk2_firmware(self):
     # This tests the whole boot chain from EFI to Userspace
     # We only boot a whole OS for the current top level CPU and GIC
     # Other test profiles should use more minimal boots
-    def boot_alpine_linux(self, cpu):
+    def boot_alpine_linux(self, cpu=None):
         self.fetch_firmware()
 
         iso_path = self.ASSET_ALPINE_ISO.fetch()
 
         self.vm.set_console()
         self.vm.add_args(
-            "-cpu", cpu,
             "-drive", f"file={iso_path},media=cdrom,format=raw",
         )
+        if cpu:
+            self.vm.add_args("-cpu", cpu)
 
         self.vm.launch()
         wait_for_console_pattern(self, "Welcome to Alpine Linux 3.17")
@@ -127,8 +128,8 @@ def boot_alpine_linux(self, cpu):
     def test_sbsaref_alpine_linux_cortex_a57(self):
         self.boot_alpine_linux("cortex-a57")
 
-    def test_sbsaref_alpine_linux_neoverse_n1(self):
-        self.boot_alpine_linux("neoverse-n1")
+    def test_sbsaref_alpine_linux_default_cpu(self):
+        self.boot_alpine_linux()
 
     def test_sbsaref_alpine_linux_max_pauth_off(self):
         self.boot_alpine_linux("max,pauth=off")
@@ -148,16 +149,17 @@ def test_sbsaref_alpine_linux_max(self):
     # This tests the whole boot chain from EFI to Userspace
     # We only boot a whole OS for the current top level CPU and GIC
     # Other test profiles should use more minimal boots
-    def boot_openbsd73(self, cpu):
+    def boot_openbsd73(self, cpu=None):
         self.fetch_firmware()
 
         img_path = self.ASSET_OPENBSD_ISO.fetch()
 
         self.vm.set_console()
         self.vm.add_args(
-            "-cpu", cpu,
             "-drive", f"file={img_path},format=raw,snapshot=on",
         )
+        if cpu:
+            self.vm.add_args("-cpu", cpu)
 
         self.vm.launch()
         wait_for_console_pattern(self,
@@ -167,8 +169,8 @@ def boot_openbsd73(self, cpu):
     def test_sbsaref_openbsd73_cortex_a57(self):
         self.boot_openbsd73("cortex-a57")
 
-    def test_sbsaref_openbsd73_neoverse_n1(self):
-        self.boot_openbsd73("neoverse-n1")
+    def test_sbsaref_openbsd73_default_cpu(self):
+        self.boot_openbsd73()
 
     def test_sbsaref_openbsd73_max_pauth_off(self):
         self.boot_openbsd73("max,pauth=off")
-- 
2.34.1


