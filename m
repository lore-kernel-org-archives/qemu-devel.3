Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6803FC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 11:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg09e-0000Ri-T4; Thu, 06 Feb 2025 06:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg09a-0008TZ-Gn
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:34:43 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg09Y-0000yB-TV
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:34:42 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so4879845e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 03:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738841679; x=1739446479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mb4oxd/vwXhE6pcy1gQ3cwUL95fH15TJV9xJOH6RkVw=;
 b=PlPF0GDrcztjPDpBX21OWQqK+6nfc9HzPYg7Ka4Qmx86wWO99CfQNAWpotsaCp13a6
 lNvaovYlpgdNcui8i2mAm+EbG/cEKvbfXaH+tXSUkSqSamnj0X9VfqYQPfZ6ZbK3WQ+I
 cOmJ/zGI4ly3MVrdeQVGnUAdQ8uh6AJ0G2Jglr56b20q5aHXkuqf6FYwQcj2qr3Cvt4T
 FhsM5OZ4JzbQ+ZamRAH9Y5b3ZGFrKPH/R3QjYwvQhiknX2eODgyP6+ImMRa05cqdNhy8
 nwRCV746+CaJ03GX2xHSxucCKjDa2OH3pKZG2HnWSX45UsqTcQ+u/dB37TbtP35Vg7B0
 1YAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738841679; x=1739446479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mb4oxd/vwXhE6pcy1gQ3cwUL95fH15TJV9xJOH6RkVw=;
 b=eS5p36AuNBkmrYMYXuS29Tks0pD6IHuodk1NdH9J9Uwp2Sl9LNOJ1QqwL2biZyE2SP
 xOpxqVTzDDfGT2tCdL2xBr7t1z4ZBSLNCy+MAAFK6l+DCh0Ee3z9DhuTCqZ6AQLI/2ss
 iMW325I2XaXsprZbuepq3m+zPjNEoIQp6XQIaJFjxInWOrgMMKir4pjEKPZzC8MCEPJU
 FPOpN2NdMDzbYM6zu7T2YBwD8A602kxnn0BHZamTURu7W4EHvzDsQWVf1EZpesfFcoWD
 3FFdWIB/xVU4gE8mQfCocSbQ9xfO3xmkVBDFCS8iQD9uxv3Pbe3peSp0oanmQlQcWRsj
 AKkQ==
X-Gm-Message-State: AOJu0YxTFo2rh7XwE3BhiO4lwn5D40wyScagyEjdppN9p3QUIo9P8i1B
 kB12TLzB1UkF2zmWEYUEpgpmC+XmZuj9B30BgxgP3/LLP6uEWbAz1jMWeKk9dBJScpqiF/IWst9
 avnk=
X-Gm-Gg: ASbGncs5o1xcP6DjfGXwIDmGKWu7YYPJGP764GB9PZb3ubrkD/enY6jZ/6e3E3Q05/d
 8emhRLghbv1uvgfDlLpf3pN8iCvU+6NHjv6YqI9Rd0R6bQ/+vVv+Ay0nlMvuJbUvtDATYMHejKR
 aQT2AGfpy3efn3+12x/gJN8qet/7BwdG0QRHf/sQTExoOSPpBE1ml8TCrJuTB1/a4rLptjFVcms
 kAg/lQAacJQ7QUstGEss/33td1e2Oec61RUeMzIgWpDVLrCNpXd0f9IlB0ipopc2bjTCuVPgtDH
 9pFW5OT1wsrXu28CpHRaq0IH+yT4PpgXrvontEWj8A8fByYVGciaZHmzzYUEplAbLA==
X-Google-Smtp-Source: AGHT+IGF9HvknI0edaGlbn1rCuTBPeqW2Y/LChlLFvTOSIh+PbJVZZHVr5CQm7+HJyUEG5X7mb4i1A==
X-Received: by 2002:a5d:64a3:0:b0:385:fbb7:672d with SMTP id
 ffacd0b85a97d-38db48e4703mr4251893f8f.52.1738841679009; 
 Thu, 06 Feb 2025 03:34:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd55656sm1517180f8f.50.2025.02.06.03.34.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 03:34:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 16/16] tests/functional: Run cross-endian microblaze tests
Date: Thu,  6 Feb 2025 12:33:21 +0100
Message-ID: <20250206113321.94906-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206113321.94906-1-philmd@linaro.org>
References: <20250206113321.94906-1-philmd@linaro.org>
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

Ensure microblaze machines can run cross-endianness by
running all tests on all machines.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/test_microblaze_s3adsp1800.py   | 6 ++++++
 tests/functional/test_microblazeel_s3adsp1800.py | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index 0447097c048..f955f6f4021 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -62,5 +62,11 @@ class MicroblazeBigEndianMachine(MicroblazeMachine):
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


