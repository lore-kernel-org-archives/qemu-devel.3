Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A81C0219D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 11:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg09d-000064-JR; Thu, 06 Feb 2025 06:34:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg09R-0008Ho-Dx
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:34:33 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg09P-0000tw-GN
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:34:33 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38633b5dbcfso730232f8f.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 03:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738841670; x=1739446470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ppn20+OdDHYYHHj4mqusBuIEfs+xIwJ4iZjJotRYm4c=;
 b=joyjvxsv1FwPqbbxHnp8XsD7VhcOfbq2J5bYGl5bd5XeUKsB5+S3/u/M6A9YPsy15b
 fXL0OBFwv19sV0kpTghiq+cb6ActYw49vIwSvRNUHrY/IMsksuSChK5Ln8O8Pyn/OV/t
 iveYCVCztd8wfhePCqUOakfgEkjUEKwjcV9wiDp/tv1RiqymyS+o6OeI8FZNDBv1Jzlq
 lEo4djVp5PQQRh9i5c8FMD0FSksrolfy1eHrOhHuCDBuuSlFRJ+h0x8iCc6MRx0bdWbV
 FIZ+vYvuSKwM+Dh15DipiplAEum8N4jDZia+/veBmr11Xk2YuPKZh8kyz8EhaIC0Vboy
 zJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738841670; x=1739446470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ppn20+OdDHYYHHj4mqusBuIEfs+xIwJ4iZjJotRYm4c=;
 b=szedkpDSxboNvmujDpqN2iiehS3Wd8t1CrBFDps5QnH8v3fyXH0YNAQSohdMaK6Oil
 WBajM7Osw+lGo1MQRNTcAWG+Hh3+8Z8k6b0cEeKLevpT5CSMcfqA4zbjJqO4nBY3K6eL
 YPoTKlQPffb4mCgCOykimLcbgBXlc52qkRrm/dmED1ibhuyoafAP6pfNPJ9mdM28I3Xn
 oHR78agK+9gHh2A1AuuLG01ejkdiSmAnqrvzuS+CtWN6mqf3k7aRMjqWiQ/HlzwDStpS
 4x8ctzPdPlpsYgG8O9MzRD2ig2HUDfEUIM6GZJMYgzqCmKtFMW4IIe/PGGE23QBuinu6
 yZOw==
X-Gm-Message-State: AOJu0YzOMGlMeMyz8OgXhHbX4xhvSohVtgKjS/mXMKi6/9dVd+/Pt+yY
 nRuHaKS7rA7hcJJrEdjz8i8bRAL8FMXYfZgO+JguY6kNp65gXnaPQ9xxl7nITxkCc+q0HdB2t5h
 PgYA=
X-Gm-Gg: ASbGnctHpHtGYpeDfg4CLxNLnX7YVT7dnkLI5G9Z2AQItXJLVnjAVbEntTa41VL+tpU
 N8yc65xHO7NrEuQkn/96W607DFtT9jrNAsmlv97gUkeHzDIl3PexlY75x6l5c+GIFTqmdPZdLQt
 FKK48OyaPKZ4eUleHPshUWs+w8dy64QZqYrTim9RoFUwzZIl6gdoNKv2pBQ9wAzlCkdFa8KwhqZ
 1k+u+RKdl9rWfXUKsWXvH4WFLvOq+31y9nOmYDcoPwcps+KohAuqyLm/u1rKHM+gqrDRc1s/U6E
 uNKzVtdcShYCWSuZ0SpWz97EZ8AqkWsg6Dj/eytMKn56OaaD+8CqCDrUG+gzzv3Kng==
X-Google-Smtp-Source: AGHT+IHAQRrSCi+tR7QES1pKdhLqPnDoWgG/vvnnGvNajO00fDOm4PEIVaV1vFhM1MIrTvHxeIrp/g==
X-Received: by 2002:a05:6000:144f:b0:38a:88ac:ed14 with SMTP id
 ffacd0b85a97d-38db489322dmr6016167f8f.19.1738841669620; 
 Thu, 06 Feb 2025 03:34:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd5c87csm1531231f8f.52.2025.02.06.03.34.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 03:34:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 14/16] tests/functional: Have microblaze tests inherit
 common parent class
Date: Thu,  6 Feb 2025 12:33:19 +0100
Message-ID: <20250206113321.94906-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206113321.94906-1-philmd@linaro.org>
References: <20250206113321.94906-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Have the MicroblazeMachine class being common to both
MicroblazeBigEndianMachine and MicroblazeLittleEndianMachine
classes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/test_microblaze_s3adsp1800.py   | 2 ++
 tests/functional/test_microblazeel_s3adsp1800.py | 5 ++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index c4226f49cf3..2eff31f13a7 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -15,6 +15,8 @@ class MicroblazeMachine(QemuSystemTest):
 
     timeout = 90
 
+class MicroblazeBigEndianMachine(MicroblazeMachine):
+
     ASSET_IMAGE_BE = Asset(
         ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
          'day17.tar.xz'),
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index 715ef3f79ac..a3e8d7ca48e 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -12,10 +12,9 @@
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
 
+from test_microblaze_s3adsp1800 import MicroblazeMachine
 
-class MicroblazeelMachine(QemuSystemTest):
-
-    timeout = 90
+class MicroblazeLittleEndianMachine(MicroblazeMachine):
 
     ASSET_IMAGE_LE = Asset(
         ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
-- 
2.47.1


