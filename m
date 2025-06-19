Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD1FC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSF6u-0006Mp-Gq; Thu, 19 Jun 2025 09:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF6m-0005Re-1o
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:15:12 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF6k-0004Kv-3l
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:15:11 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-453426170b6so11665635e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 06:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750338908; x=1750943708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yfbZh25j/JWcO06w+c80OaMwV9tGFnS1KSANu6xFbyE=;
 b=jzPjDWpj81RuWVYolYhuqpW7YwtCEiNw1hNEgp7QNgq6eQIG5cq9opLc9Lcj82WONJ
 oF5Sv6/27lKl90oC7+7dF7B5TAdR39hUIIKbsMjk3JfhDwZmvkG70jj2XdMPdXj3e/DD
 H1+fN12NMVyI/GRx0amm/irCWy0VspTdyTiefvyfeQK0oZwvQu2MilpCVu9fVZ2/nnHh
 Tjo+WA780JveA7jOlvoiHxfXdHzISM3RmDQnITrrRrif0Vs4XMGi9JI745blAjlJLDze
 bV/xCBMfD5j9pH2h9nSm32BuoVt8OEZzXrjpdQ+laWO5KEaJ5XPUK/iZqpsOeBQflS+V
 5UWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750338908; x=1750943708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yfbZh25j/JWcO06w+c80OaMwV9tGFnS1KSANu6xFbyE=;
 b=c3hA1ykakaseDsyqm18qkfhYU93XOJG49bjrTUiB9V8tL5aYNjQb+LVNWeezIhIlpP
 dWX5CZTxQ1mnerp/8LJNz83D28Sy7y9UiYUsw3h/9ub/c9guQHnj6Cd7uGyRuM2cMyZi
 7IxVypstHtzywbwEkrxDKSKBU7jEE8DQA+HAO6mVL1Z+wMevhmSjNDfrdbR0kOtAfTj+
 Seizb19RMuVW2A2Qp6K3WJ9Z6pXoB8IPSrOv6SaiL56AJD15341/2gh0hAEmrGJv3+A+
 qhyQ2tVImbl0r+fyder31h3bEyhYTET6ha02wv+CXSgoAKQiTT622QZmYGzzJbUxBFf/
 CXig==
X-Gm-Message-State: AOJu0YzzuJB4K0jnu/yfRG5pkmW/g16EoVlC8OFXbEaqn+ChQO2K69n4
 k7Kd8QO8U7N+vJoWWu2kU3Czf/LM3xOCFyWrprSm8grmX4ILogiyaDIilR0RLGmEniZVLG0QQrI
 YJe2RkAM=
X-Gm-Gg: ASbGnctPgM+2hptPleak3SmVKS+byTHeaA2pW/giCqgRLDZJ7+HIugswItpxEbPFHlO
 A0rRIiQ66/s66XbbzH4XF1RlcQ1GZ7cof1vf/PBt+ZbBrT+PN5PQmuS6a1LEFlbPobkwq6IajTY
 o7KLuro/t6tF77wGiV1nwNMzsiUyKKVA0D/T2ubW/y1tziwaMn8/ZxeL9H+cE2qBo4bNe0YC7Ph
 XBYaTB5XMMRCV+gQyI/WWpZnTuzlNfFTvSvOK2dCQxWNrJLu7VT+o2hPbY2e/sqy07MIDEt3EKo
 2ZD9pMeQY2+UwdihVNBmaAWc8lkkl35RBuJrEganjkvIckLR4qh/H8n3CJvQuWlmYXuYw0HLwR+
 A/0Qzwi/+mvbSXZ5INEGpBMrog20crtFFx8Lr
X-Google-Smtp-Source: AGHT+IFW6hA3yAKdFTUe8EEI5kic43ZIITMi78xKgEZunkyJSkx0t16xPuunedGwf+ZaxjadES0vkQ==
X-Received: by 2002:a05:6000:648:b0:3a4:dfbe:2b14 with SMTP id
 ffacd0b85a97d-3a6c96c102bmr2506122f8f.16.1750338907890; 
 Thu, 19 Jun 2025 06:15:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b2f80asm19552864f8f.78.2025.06.19.06.15.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Jun 2025 06:15:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>
Subject: [PATCH 20/20] tests/functional/sbsa-ref: Move where machine type is
 set
Date: Thu, 19 Jun 2025 15:13:19 +0200
Message-ID: <20250619131319.47301-21-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619131319.47301-1-philmd@linaro.org>
References: <20250619131319.47301-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

fetch_firmware() is only about fetching firmware.
Set the machine type in test_sbsaref_edk2_firmware().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/test_aarch64_sbsaref.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/test_aarch64_sbsaref.py b/tests/functional/test_aarch64_sbsaref.py
index e6a55aecfac..5536ec622e6 100755
--- a/tests/functional/test_aarch64_sbsaref.py
+++ b/tests/functional/test_aarch64_sbsaref.py
@@ -40,7 +40,6 @@ def fetch_firmware(test):
         with open(path, "ab+") as fd:
             fd.truncate(256 << 20)  # Expand volumes to 256MiB
 
-    test.set_machine('sbsa-ref')
     test.vm.set_console()
     test.vm.add_args(
         "-drive", f"if=pflash,file={fs0_path},format=raw",
@@ -70,6 +69,7 @@ def test_sbsaref_edk2_firmware(self):
 
         fetch_firmware(self)
 
+        self.set_machine('sbsa-ref')
         self.vm.add_args('-cpu', 'cortex-a57')
         self.vm.launch()
 
-- 
2.49.0


