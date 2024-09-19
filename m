Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC14FC619B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwl-0006Ex-82; Thu, 19 Sep 2024 09:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwW-0005TC-Py
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:36 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwU-00015Q-R0
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:32 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cd74c0d16so7470275e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751487; x=1727356287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZOm9heTao6Me2uwud46NTPkGjdLAm0XKsYYYwqd37y0=;
 b=x8X3cuY6T538MRUw64nfnCaDhOuBwgC9ZIvigsuP3Aey0lrtu7gwAwrZss/RAxhy1R
 cs5gxp2JD8opo3GriG1pIVNPlYZDJvSC/I3BbtKDT8S6IMP1i2RGkUtXaPMV1QbTJ7Hc
 3CqA43JDgDN8H0i5FBR7U129+qrqdcZuG451VuKcje13FtQsRkHARdOtB1r966jfvuxy
 VZk6r0rJ/RiBoBAhpz04jkCE0Amch9ZLx7XDCiqu3Ot6pHgeWtrcjD+Y2eiwunPnUC6h
 l95odzW9jAQQIiYHsbK9MmnanGpo6PaYdMsR0DDNMY+irE5gHNnTo10n3yn9mdS1G2iz
 WMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751487; x=1727356287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZOm9heTao6Me2uwud46NTPkGjdLAm0XKsYYYwqd37y0=;
 b=q9Re/Dd+OSSD54ebcS39svqSL4gJ0zBRV4bh+7g91+a8jxdDtUxQonLANoZHfm20El
 9k56sRyJdDNW5PLG75yUnNuShGYVyv3Zd4yKJpmraHIgUhH9tnOD+taRkOp1yTNOipCT
 5mtNl+LGoPzz8uNl9Wu38CvDGdiXjRZCg8OmKHDBzM+SrfehVdUd/BGsXZAdw3Pot1uv
 TnNLFFTzcEDC+WF5alZEPTiYu/s8VG4iDDjXkHrfaXdoyQXXLWlmu9pCjG09pzuMz36N
 M087PjAD+N0InEr95QJkPyj2RKueIfBPttLrlaG58lgQ525Kn4LvaTg0skf9qPbDvxQu
 orHA==
X-Gm-Message-State: AOJu0YwDIMugo3CLLoh7OBvMoS6xzmexvJ+DyDY38A80qjHWQfo1pi+y
 qkb99XuBOEJUm1JkV7eUc7YUubCECUR9Yfz0m+HzzaDEyY0+RTftHNnmjekZYM1CRk0/0fswKlj
 x
X-Google-Smtp-Source: AGHT+IHr0VYbbNYF+hnjgWtNF+gm2qn1IAKuVBk1yp+a8UkKt4RrSR4gY8lH3YZUHEetKhMninyG7A==
X-Received: by 2002:a05:600c:5248:b0:42c:de6e:7f4d with SMTP id
 5b1f17b1804b1-42cde6e8056mr182252465e9.34.1726751487289; 
 Thu, 19 Sep 2024 06:11:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/38] tests: expand timeout information for aarch64/sbsa-ref
Date: Thu, 19 Sep 2024 14:11:01 +0100
Message-Id: <20240919131106.3362543-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

'Test might timeout' means nothing. Replace it with useful information
that it is emulation of pointer authentication what makes this test run
too long.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-id: 20240910-b4-move-to-freebsd-v5-3-0fb66d803c93@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/test_aarch64_sbsaref.py | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tests/functional/test_aarch64_sbsaref.py b/tests/functional/test_aarch64_sbsaref.py
index 89d0b9587a8..1648e8ceb68 100755
--- a/tests/functional/test_aarch64_sbsaref.py
+++ b/tests/functional/test_aarch64_sbsaref.py
@@ -137,7 +137,8 @@ def test_sbsaref_alpine_linux_max_pauth_off(self):
     def test_sbsaref_alpine_linux_max_pauth_impdef(self):
         self.boot_alpine_linux("max,pauth-impdef=on")
 
-    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'), 'Test might timeout')
+    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'),
+                'Test might timeout due to PAuth emulation')
     def test_sbsaref_alpine_linux_max(self):
         self.boot_alpine_linux("max")
 
@@ -175,11 +176,13 @@ def test_sbsaref_openbsd73_default_cpu(self):
     def test_sbsaref_openbsd73_max_pauth_off(self):
         self.boot_openbsd73("max,pauth=off")
 
-    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'), 'Test might timeout')
+    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'),
+                'Test might timeout due to PAuth emulation')
     def test_sbsaref_openbsd73_max_pauth_impdef(self):
         self.boot_openbsd73("max,pauth-impdef=on")
 
-    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'), 'Test might timeout')
+    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'),
+                'Test might timeout due to PAuth emulation')
     def test_sbsaref_openbsd73_max(self):
         self.boot_openbsd73("max")
 
@@ -216,11 +219,13 @@ def test_sbsaref_freebsd14_default_cpu(self):
     def test_sbsaref_freebsd14_max_pauth_off(self):
         self.boot_freebsd14("max,pauth=off")
 
-    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'), 'Test might timeout')
+    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'),
+                'Test might timeout due to PAuth emulation')
     def test_sbsaref_freebsd14_max_pauth_impdef(self):
         self.boot_freebsd14("max,pauth-impdef=on")
 
-    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'), 'Test might timeout')
+    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'),
+                'Test might timeout due to PAuth emulation')
     def test_sbsaref_freebsd14_max(self):
         self.boot_freebsd14("max")
 
-- 
2.34.1


