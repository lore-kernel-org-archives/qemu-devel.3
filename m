Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D50E6BF1F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 15:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlqDS-0001uU-VL; Fri, 30 Jan 2026 10:15:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vlqDH-0001sZ-FV
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 10:15:12 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vlqDF-0001Gt-F2
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 10:15:11 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-432d2c96215so2037956f8f.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 07:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769786107; x=1770390907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+rjBPJgdUrswncn16/fJ7N+9sZAh70oa0q47Le06XK8=;
 b=ZMb4+lQz3uxJNxF5ZJeuDyKe5sEUmUV9PuK9PH19RSQrrqAXjN1p/w4hrPnls9Yj+k
 jEYGkkPriVu77TKxwuXa4olKRRF7ecG0OfgB3KrTShO15LF2BztIbOMwcGBhz2hsRCLY
 hFMXTVef9fWrTq7BFwbsSfRsC7CBgV53cesTtIR5EjTBE3JBqtCoTI4gDHY7+zFonxh7
 isXr/DJJB6s/Y28+w84+6KzS6ON67R8Qq8ninl6FIRLCp2OSllfHe87Xo+lDo3pggWY3
 BFGSbTlPK3gmBr8bSXzx0HmDy3OeGWMnOTMXyKP+jUWTRNme2kJV3/6D1AEYovMS09w/
 pGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769786107; x=1770390907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+rjBPJgdUrswncn16/fJ7N+9sZAh70oa0q47Le06XK8=;
 b=QEzZWAfTX5eOrnJEcUQS7zdW0DXmwe2jVl81Q9AupFj7j3RZOV45jEG7ta4SqlTbZf
 tLIQT7t4Iq2IpdzCF59I2XfDwIHFf+GZyxskfSD7Z322MrXHjyZAi2iM8DSq47MGveLY
 xKDAK2U7hVG68IXxZlxvioxkZm6drJM3cqTMMnL1zMEQFsghiWQVJlj6qFxaIsrwRLDI
 77KDHkFmBgUzF138fsqiBk66AYdFeKYNpfYW0XV1+vS8vre1A+R2DU92SDAbyKjuAg6k
 8vChO3g17d7dpEGlLyHGpf3GFv0TSOFceQvJC2SOWx0bqFwi88wVkQXeE+p2u2vEgd/S
 8Q3Q==
X-Gm-Message-State: AOJu0YwNWV6wYSAenJAti//nQtMI97oLrUPrA8foDtBE/4lqg1w6pFyS
 ADffZhN9HYWUudbITQMnQzuz7GLH99aeFMzdY5JZ93btvn2nzkyEZeBQ1dJytyZWO2gFLXJiJq9
 T0Rzdzf0=
X-Gm-Gg: AZuq6aKIM7odjERgFu5IonCGGtAkYeCzxZQJb8gyW/qfA65msr0HFG5QjFTGEYQsSB3
 m2RCtDsE4KeAKPPBxVUvLwDw/cIaeYJ/HSWj1epbmQKaaiy/3vHx5vo+t05BQviFzdAdXu6TyuH
 ZfbIARBLd1vNw387a/Wrz6CIe+Hq8Iox3OVgPQ1TMQjX74Tv4Lm2PquNFbd8K9WEYRhI6E9EwXu
 wjVZbM5JNhrsZQLlkI2NXnddlveJDkooIKYCP+5UYkWAxHV/lMEGqAIIpYfyAiWv+yVZ51aC2RM
 56HR/SvopCvkejB/VogjoPS2FubLQyTLWV1PkMBDbR151tWCTXxMxZJrbb9+712SRkqrXdGGHlP
 ddUzJKxTd6GDfI+2a7JLv1pv1cxXp3hB8H5td7Q4xuH8wR/H5E2wlXrfr+BmIKWC199PG8YQ6bd
 uGCnCr5Rwyv2dI5Uv1JmrCnA==
X-Received: by 2002:a05:6000:184d:b0:432:da3b:5941 with SMTP id
 ffacd0b85a97d-435f3a7b8camr4932213f8f.21.1769786107315; 
 Fri, 30 Jan 2026 07:15:07 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1322f40sm22297265f8f.34.2026.01.30.07.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 07:15:05 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 988395F89A;
 Fri, 30 Jan 2026 15:15:04 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 qemu-arm@nongnu.org (open list:SBSA-REF)
Subject: [PULL 2/2] tests/functional: migrate sbsa_ref test images
Date: Fri, 30 Jan 2026 15:15:04 +0000
Message-ID: <20260130151504.550929-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260130151504.550929-1-alex.bennee@linaro.org>
References: <20260130151504.550929-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

As the builds in codelinaro.org are going away migrate the binaries to
share.linaro.org. As the hotlinks don't encode the filename we need to
explicitly tell uncompress how to handle the files.

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260128105839.3487840-3-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/functional/aarch64/test_sbsaref.py b/tests/functional/aarch64/test_sbsaref.py
index d3402f5080a..3ff674039e6 100755
--- a/tests/functional/aarch64/test_sbsaref.py
+++ b/tests/functional/aarch64/test_sbsaref.py
@@ -31,10 +31,10 @@ def fetch_firmware(test):
     """
 
     # Secure BootRom (TF-A code)
-    fs0_path = test.uncompress(Aarch64SbsarefMachine.ASSET_FLASH0)
+    fs0_path = test.uncompress(Aarch64SbsarefMachine.ASSET_FLASH0, format="xz")
 
     # Non-secure rom (UEFI and EFI variables)
-    fs1_path = test.uncompress(Aarch64SbsarefMachine.ASSET_FLASH1)
+    fs1_path = test.uncompress(Aarch64SbsarefMachine.ASSET_FLASH1, format="xz")
 
     for path in [fs0_path, fs1_path]:
         with open(path, "ab+") as fd:
@@ -54,15 +54,13 @@ class Aarch64SbsarefMachine(QemuSystemTest):
 
     timeout = 180
 
-    ASSET_FLASH0 = Asset(
-        ('https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/'
-         '20241122-189881/edk2/SBSA_FLASH0.fd.xz'),
-        '76eb89d42eebe324e4395329f47447cda9ac920aabcf99aca85424609c3384a5')
+    # SBSA_FLASH0.fd.xz
+    ASSET_FLASH0 = Asset('https://share.linaro.org/downloadFile?id=kyoMLGC9zXa4oA7',
+                         '76eb89d42eebe324e4395329f47447cda9ac920aabcf99aca85424609c3384a5')
 
-    ASSET_FLASH1 = Asset(
-        ('https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/'
-         '20241122-189881/edk2/SBSA_FLASH1.fd.xz'),
-        'f850f243bd8dbd49c51e061e0f79f1697546938f454aeb59ab7d93e5f0d412fc')
+    # SBSA_FLASH1.fd.xz
+    ASSET_FLASH1 = Asset('https://share.linaro.org/downloadFile?id=Dj1HRXnDnKtU6Nj',
+                         'f850f243bd8dbd49c51e061e0f79f1697546938f454aeb59ab7d93e5f0d412fc')
 
     def test_sbsaref_edk2_firmware(self):
 
-- 
2.47.3


