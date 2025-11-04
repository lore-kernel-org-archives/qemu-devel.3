Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C011ACCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 15:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIWF-0000Wc-74; Tue, 04 Nov 2025 10:00:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGIVz-0000VY-Sd
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:00:11 -0500
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGIVu-0007no-LC
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:00:07 -0500
Received: by mail-ed1-x542.google.com with SMTP id
 4fb4d7f45d1cf-640b9c7eab9so3988977a12.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 06:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762268397; x=1762873197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vkMjMzxUptD4Koo6ahq7nC20NsvGKgiDq6bkBEYbHAk=;
 b=XyKry0oX/G7vkcUS28X47oiId148ds9JMH/n6IJbU6fa0GmM+z4G6j4ziQrJlfvm9K
 JMlZ+8H5SBCuQuIHS8bhPmvviC4omrgCVXyhj7Mzf6ojov1Br8TP9WVGBj1No2UldbA+
 ecVEqTtyA8vikUc2GszBEDow8IIlKtT0t7TrbGI9/KPhlnx7cO8uhrqwt3tCj+e77x5S
 qIibQ7o4uwWPkiOrNa45WbZxzTKudOulbKEeitJAWsPsYfmN74Xrr/9Naubckz2B+sWS
 9n7uPUZSqSoBWNcmTJrZc6qPqoHpFBaQZFHQ4ehRUWzooY7+LBYvfYRhuzSyNS6k9CR4
 KTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762268397; x=1762873197;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vkMjMzxUptD4Koo6ahq7nC20NsvGKgiDq6bkBEYbHAk=;
 b=PwH/AhGCgIR+M5wthFUSRuQ8PKkkyivugdCNEA1i2KGoCNcdfQ7F1+Jhr1lu9dlHlC
 DcqSK2cbZ8N2rVKan7SoIPkx3vpansn9W6+IeOoZUJRJHknIFv7xPsai22XTd4LRvHnj
 QjGySI4z34IY1FGsDLvoPlVe8T3hSqbXfyZZ0/LnVWChBG5yM5nPwLLlNelEUCZK4m/V
 cP3jqTrMJ6tA5c9OwcNoA5VnhLnu64C/rSrVW1g+Iymza3jYaIgfqeYaxr96MWc+ciDm
 47JgNBK6BM70km3jZP6O74p3w4jvneEtV3l1WSD+3JPGWyfdywKDklsI9AEYwc3Xr83r
 ys7A==
X-Gm-Message-State: AOJu0YxTJrIhcB7falPWHaDNQB+wX7yrzkqbh1WBC8CLUFDaSRM1XuGF
 viDEzHsGf8lGedZhFZbRD/OhHErCV5WUiUgXQzZ6++rUhICaV74lGXNvkB2hc8uUF5SeBdDE7gg
 jWhztKqWNbCBRbu0=
X-Gm-Gg: ASbGnctMx8Kn2TedIBOkibcBocjUpTieAbuKPv6GYWaI7E5YzzV3Mg7tJ2ATxJbx8Ll
 VroZJ1S3dXy1+dEfX3dxkzak694wynT26yq9DrwLz9J7qKpPMCf4Rtzwu0kSGv0OC4XGxLP/Mjz
 mUh/ecEtsW0X/AEb4BRimp65H7R886rAgVK7XtLXQWk4lBhPTVb2Cpgk6yoyYHkovRvjEG5AYbw
 18LExf+npQeqvI0b32K8JjUpDZ43V+yDy7vik6VB54zWTBNDvjpqcpW0FAIr77d0JjdoiK6UKY0
 RJoFXsBAwV53o2/lIltdghOui6EF+Rr55WOB982JqS/R+bfC6dJe6WHvwA6QU4/YcTeBejF5gAv
 a+QctX9Y0fglraV8TpPPgStT4ZLztGeOzx3x2IEZICKze9khiNyxs8J9lC9E2Bq84E2icmhCVNe
 WalF8IAmjduytWGFS0SGktrtqs5v9k8JqJZqvWGw==
X-Google-Smtp-Source: AGHT+IEil/hL3AOf0QGOYkmZES/+3jkXyUGZssL/xp0H7bWsHGPmxs3BDBt/gpO/+PUY707K8HbKFw==
X-Received: by 2002:a05:6402:35ce:b0:640:a9fb:3464 with SMTP id
 4fb4d7f45d1cf-640a9fb36ffmr9459050a12.7.1762268397203; 
 Tue, 04 Nov 2025 06:59:57 -0800 (PST)
Received: from localhost.localdomain ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e67eb65bsm2255300a12.4.2025.11.04.06.59.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Nov 2025 06:59:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-10.2] tests/functional: Mark another MIPS replay test as
 flaky
Date: Tue,  4 Nov 2025 15:59:55 +0100
Message-ID: <20251104145955.84091-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x542.google.com
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

When disabling MIPS tests on commit 1c11aa18071
("tests/functional: Mark the MIPS replay tests as flaky")
we missed the 5KEc test.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/mips64el/test_replay.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/mips64el/test_replay.py b/tests/functional/mips64el/test_replay.py
index 05cc585f854..e9318448fa7 100755
--- a/tests/functional/mips64el/test_replay.py
+++ b/tests/functional/mips64el/test_replay.py
@@ -40,6 +40,7 @@ def test_replay_mips64el_malta(self):
         '75ba10cd35fb44e32948eeb26974f061b703c81c4ba2fab1ebcacf1d1bec3b61')
 
     @skipUntrustedTest()
+    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2013")
     def test_replay_mips64el_malta_5KEc_cpio(self):
         self.set_machine('malta')
         self.cpu = '5KEc'
-- 
2.51.0


