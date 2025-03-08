Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6ADC28B28
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr27D-0003P5-9h; Sat, 08 Mar 2025 16:53:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr274-0003Jp-MW
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:42 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr272-0000xQ-Tr
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:42 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso17090645e9.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741470819; x=1742075619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sIOKeEXB9jLSbKJZtM3r/78Jta+lLdKfVVnoz+aUVcI=;
 b=vJHzynM4Wt9mz09CIhjpyEGVF3PY7nJ8OMHJMPeoWqxn30wyrZOUf1Gr4gsEy7Kd2r
 c7RSrhzeSMDD2SBdSdeeWoLnGVTq0WONhKT8c50LEEctdJTMuP+gzXfNsOGYuZhEahqa
 zoVGEKiyjz9hjr99ELS95KQVqLNwwkr85e1RmBqq0q1R2yGLA+qcMtHGlmx0zP/k+CAF
 Toi13CU1F3Eg38WACuxQXxFVbYJs5yWO/ACYJsSsvsJu9ElZ7W6mxwnW5BjwSLP+EpKh
 ygOsp6ko/MEFF8C5v7TPjv0/BgHExYoV1ocf0fjZrd3vh/sajsMoLVghqhACNmClARn2
 bZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741470819; x=1742075619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sIOKeEXB9jLSbKJZtM3r/78Jta+lLdKfVVnoz+aUVcI=;
 b=nO4AeHqiI3swuB/iKJ/yhO+PwJkHxgegnamkf6ksJgU/tl+I77decmxtTdivNefoMW
 AAdOtcwFGHxkOhg+0V9Ig1cOWqc5qGo0EFsHy3aW9ERhrV1h6bugMRa2RAAH3xAQOcgL
 7sT2E8NBrbBnXtE8isRH9wQq+b+Lh2kOhm2aJNqlRnXYe3HdPSHvG0SKrJSvXJG3vI1N
 SXQKcjtKZFyqLS5sfGbiKRaW+cQGZOvOfIcFggD6JKsDv/emZFhj6hOs65I6Fn1F8m+6
 G1clSq+1uZojUZntqHVuRaARP1AypeQrWdSAXxntdg0YTScAZPKEEIFhnMRDd7dSuDlg
 JRiQ==
X-Gm-Message-State: AOJu0YwWRbHxZfZn0W6LuFm3DIwE8Hw9I42YryiG32uqZYo85coL1FMR
 PKvj9l9TfuvwFPmmN2+XU9t7rtM8Owb6mgiSKFzooAE6SY/4Q7Wnqkv5erUfpDE=
X-Gm-Gg: ASbGncuHtsnYWr9TX+pTieP73KgatayYEDnXmMGDv6x/U+IC2eE7//6CwmHBbW7kY4O
 a88uZqL+6hCuLAN9ls+biy5epswWC4EboDM+xRYRRfJrRiclTIqPl7Q0Nbtw1H1bX9nTlSQj4HM
 LB4M3GmRNFX8ClIbmNfLvCZnwDzJsChSlH9Z4TZjm9tv4dTGPlLYcXEcWHB13Fgk2Ro6nF43sTK
 /As5OvLGKwE3g4Z+FLXbawK2JCaKZ2Oh/uvUG3AyjgINJqH8JufHSGsrwwJbiZt88uWPaDpHMOZ
 SzGe7LZWNyiYun6BkjJCoDYKJuqZpEXdKna7MD4ypvsc81A=
X-Google-Smtp-Source: AGHT+IHlw+3j03s6tCmHUCGygGSDUHvowGx/md8cQs48415TYtZmNj5ic6TBpxr0kT1/ooyeejq5mQ==
X-Received: by 2002:a05:600c:4ece:b0:43b:c962:ad09 with SMTP id
 5b1f17b1804b1-43ce246ffe1mr28775105e9.1.1741470818908; 
 Sat, 08 Mar 2025 13:53:38 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42c55f2sm125755895e9.20.2025.03.08.13.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 13:53:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 678585FA87;
 Sat,  8 Mar 2025 21:53:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 19/31] tests/functional: add boot error detection for RME tests
Date: Sat,  8 Mar 2025 21:53:14 +0000
Message-Id: <20250308215326.2907828-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

It was identified that those tests randomly fail with a synchronous
exception at boot (reported by EDK2).
While we solve this problem, report failure immediately so tests don't
timeout in CI.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250303185745.2504842-1-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-20-alex.bennee@linaro.org>

diff --git a/tests/functional/test_aarch64_rme_sbsaref.py b/tests/functional/test_aarch64_rme_sbsaref.py
index 93bb528338..ddcc9493a6 100755
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
index 42b9229b4c..38e01721a4 100755
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


