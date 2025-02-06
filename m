Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67338C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 13:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg1gS-0007Im-F5; Thu, 06 Feb 2025 08:12:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1g4-0006Sh-VB
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:12:21 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1g2-0008Js-Tn
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:12:20 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38daf09d37fso603758f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 05:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738847535; x=1739452335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hMQdRRrCFa2XKkm20U6l+ugNhicvq3yi9IWDRqRTfeM=;
 b=A2C8wMycZQ0bisIPP5F3dHfKQOaePUih41hqPFGsuyH5dj8W3B3pZ8iZB1/b2AAFTW
 JOuKLGoEMWV9+9UXKShghGkuxMVyHV0vEKd3WSr5YJx4PS1I2Q03mQk4yrGlwyXlixYj
 vpxZoWRdBauUSguwX0z38l2SF0SjTQQchl7wLCQHahocFTy9lZ1GUZn3TO9Oh24jVBCf
 mpuIbTS+jnKwcs7xYV6cmIaSs2VUHzDqV8YCFxQJQlguAOY5VhI3xl9uFO8yrug1Webu
 7gw9NWq8CraectTB401HXFpq9hXNYOPZvUeMO4sPrk5pr8wzEkA4wvONTxwaJYlbb5hu
 cctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738847535; x=1739452335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hMQdRRrCFa2XKkm20U6l+ugNhicvq3yi9IWDRqRTfeM=;
 b=Z27BdNiDcvhKudFN97npHP8nLQ5wKjIKzzQeH2Ffo7TXV7ZdjTiIggTiIX5YpAbCPC
 O9SaRjrstirCfTC1ruYvLfv0ZrjxTkiEHmoDsx/BX0FUYjA00ElzRXzGaG6oz12seE7Y
 G5dAu9JgwWkHrbWpqQbhQ/vldWylnxosZYyLqMtjNdVbmxlMNGVxKysUN4NopuvlOod2
 iwf7eoCSXRx57GBlAgfLRw7K6+i0gYBe+V5YxekjWKTHuMj/+nqUh/Qtjc0sOWYGGb8E
 rQ26ivPtYsL125zmmpbZykZ8xRkIc/XeG+HrVM89diaGGycWt7Wq/xmdlaUcr/bgfGKR
 utyg==
X-Gm-Message-State: AOJu0YyNZGKyOXqwUAW6peK0CZnVYQTU2NwdyvkM5x7c10R4P3Ld/O9K
 yQOc/8kvavvVxKXH1k8pCgieDhMT+rBeuWp4CHIm4NXBoGMGAiIUOOy6pCWM6fPFnV+54Uu56wt
 w2C0=
X-Gm-Gg: ASbGncv7KVKWtxGTGIKJes7H9VYXfAev+0r/zcesTi+78WJwJCT1DpK+MIHjf+p5REP
 qLi2MKpTtd/a8IEBTwBllgeoppcmCwCP/rvtRFOgE6S0rfY5At5q1+LbpJe9JjJa+nih1Uvzdxh
 E6kMGvbn1Y+urv3WHCtcVxVVtdTFj8DLfsbYjOPICex4WLcjC7bM0GvoIVc/g1jgCgV8YWFJNeV
 PdLCmvGg0ibVGT+P400L7wJKvK6O985vWFKhYAwfDbsKcQjvrN0nqM3GFPuOw0g07i/vqJb42SM
 hHKdo7MifX81WjFrxNtRAYk9khcvqiEKhgp3VRvisEx1gMuUwFqFmqvXr0JQ7rnU6Q==
X-Google-Smtp-Source: AGHT+IHMWHM/MzB108wOKiBUAdkOoDp+1ig4kSNMXusd8XzvdQnMZ9y278j2XZ+g40YW/yDZYbnwew==
X-Received: by 2002:a05:6000:402b:b0:38d:baf7:8d3a with SMTP id
 ffacd0b85a97d-38dbaf796f2mr2396029f8f.7.1738847534724; 
 Thu, 06 Feb 2025 05:12:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde0fd18sm1712274f8f.72.2025.02.06.05.12.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 05:12:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 16/16] tests/functional: Run cross-endian microblaze tests
Date: Thu,  6 Feb 2025 14:10:52 +0100
Message-ID: <20250206131052.30207-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206131052.30207-1-philmd@linaro.org>
References: <20250206131052.30207-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Ensure microblaze machines can run cross-endianness by
running all tests on all machines.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/test_microblaze_s3adsp1800.py   | 6 ++++++
 tests/functional/test_microblazeel_s3adsp1800.py | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index 177c8a685bc..c18b132ff5f 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -60,5 +60,11 @@ class MicroblazeBigEndianMachine(MicroblazeMachine):
     def test_microblaze_s3adsp1800_legacy_be(self):
         self.do_ballerina_be_test('petalogix-s3adsp1800')
 
+    def test_microblaze_s3adsp1800_be(self):
+        self.do_ballerina_be_test('petalogix-s3adsp1800-be')
+
+    def test_microblaze_s3adsp1800_le(self):
+        self.do_xmaton_le_test('petalogix-s3adsp1800-le')
+
 if __name__ == '__main__':
     QemuSystemTest.main()
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index 56645bd0bb2..b10944bbb0c 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -16,5 +16,11 @@ class MicroblazeLittleEndianMachine(MicroblazeMachine):
     def test_microblaze_s3adsp1800_legacy_le(self):
         self.do_xmaton_le_test('petalogix-s3adsp1800')
 
+    def test_microblaze_s3adsp1800_le(self):
+        self.do_xmaton_le_test('petalogix-s3adsp1800-le')
+
+    def test_microblaze_s3adsp1800_be(self):
+        self.do_ballerina_be_test('petalogix-s3adsp1800-be')
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.47.1


