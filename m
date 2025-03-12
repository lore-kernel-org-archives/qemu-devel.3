Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29861C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 05:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsETc-0002lu-QS; Wed, 12 Mar 2025 01:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsETZ-0002lY-Ql
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 01:17:53 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsETX-00070N-Qn
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 01:17:53 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22423adf751so92748545ad.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 22:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741756670; x=1742361470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=22gBc91mwFFQvV5wLMuqbrX+Fd3pyudRp4NuphL9yhY=;
 b=HRGWXmVettPypDhSX3h3XTKi7BhlM+Sya1jzot8uMlzrj0s3/vfTZfJWtVcOFHMUfs
 JwRg0SAMyo9b9lXfjdcGI6dZvYY2mI+cKSxXjunSU3Fj3R8/gKTydJGJ06bjcsd66yp+
 AvVZBTfZ+JhQa+L90rv6ZVyrfP24MdquDN/UYirBNQrKM+pPjuGNFZ6shJpWqCddDFGl
 gfEoabQVTQvzZ+aFJdjACOzfhBSrNSRvNAm/LCTx5+X801XaVf9ATl2ERigTeC/Sh3gS
 QKt9gfJKM1/BarbZ7GZ32xQjZjbT4qDyVZhe3nB6Ok2wdsDml/kDjfDMyQh4NJc96YLd
 5ufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741756670; x=1742361470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=22gBc91mwFFQvV5wLMuqbrX+Fd3pyudRp4NuphL9yhY=;
 b=GPYUyzcTA4Bo6PbiU3Twg7PPrXQuCvBRPEPQyt4ESEyr0SvdSP3Na9rCLDGEIRSXhI
 8700j1RmtkrcfPT8XSMAwSKrjGJt0GKenDW0iTJT+CIORxQM/kGededtJ4He12VPtwDG
 3pB17CaF2TSHWTTOhse2waZSlP3RFNCZoX1N6HPVogiWDT0Yx5pUid3NjEOk9vGZT3mR
 l2R08ul8cm4Lj0fXJv8UF17dy0fwFJl/4s65i1eAR3sYXkUBB4X62kYUZXCyqViXTHvM
 JwY48/Mstgmkg+9ak4D7+M5uk3/Bzc40xdGHTjhxf5OENKqM0fnqSIOR4wHb5lFRr9ip
 u//w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWaUZuUXeSE7lEmkHWCMGTnyUZ0noB4WLEhRoSuM1V5jd2GK8rrGArD0NExFT1/+rsPZ4SYfElhzI/@nongnu.org
X-Gm-Message-State: AOJu0Yzt0S0ZvE02Q2jzHWiObAx0oV8qf2BycHwWNdsa0aWeBc6JoRAr
 6c0FMPZQO8y2GRgbmoXpdvEOmJOKv6l5CHWhRMJfWLOEUQBP4QNG
X-Gm-Gg: ASbGncspxre34RF8u0kdVUxkLfVIeJ4X0iMsPnV8SSQPia4MhymuhoZ+i5LDsSuUWZ2
 3ZvM9mY3+Ll4ia3q8crN3cIu63PiHpoq1IQ0xGklUC0mfTWYD4/Kym9ZcpOI4FJv0c6dvCgeeAI
 pPCMaPK1WigatRQojIEZ2U1seU6Kr+k8XgeGVfLqca9ydNN4WOClCIrtefoTRGwXcjaWQHPzf5d
 3lNu8tMQK44li59pOxXL28tIkS1yqtmoaL7BOB9pES/odlHm8/RYmxBTeyFX5sziz0E3bcbJaeW
 YzhtYtK0/TFNwvdPAorCRulS9gwCu6dnhm7Mw6w/CctOYKsBNqs=
X-Google-Smtp-Source: AGHT+IH2zK7tUKhxahJAD5yTsMG/ZTpr9Ybk4JbbtanHglIvCrP6ishCa0f8RqkTaoElO0u7VqtWnw==
X-Received: by 2002:a17:903:2308:b0:223:501c:7576 with SMTP id
 d9443c01a7336-22592e2d575mr95437295ad.12.1741756670512; 
 Tue, 11 Mar 2025 22:17:50 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a925ddsm107557475ad.203.2025.03.11.22.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 22:17:50 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 1/3] tests/functional/asset: Fail assert fetch when retries
 are exceeded
Date: Wed, 12 Mar 2025 15:17:36 +1000
Message-ID: <20250312051739.938441-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250312051739.938441-1-npiggin@gmail.com>
References: <20250312051739.938441-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Currently the fetch code does not fail gracefully when retry limit is
exceeded, it just falls through the loop with no file, which ends up
hitting other errors.

In preparation for adding more cases where a download gets retried,
add an explicit check for retry limit exceeded.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/functional/qemu_test/asset.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index f0730695f09..6a1c92ffbef 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -116,7 +116,10 @@ def fetch(self):
         self.log.info("Downloading %s to %s...", self.url, self.cache_file)
         tmp_cache_file = self.cache_file.with_suffix(".download")
 
-        for retries in range(3):
+        for retries in range(4):
+            if retries == 3:
+                raise Exception("Retries exceeded downloading %s", self.url)
+
             try:
                 with tmp_cache_file.open("xb") as dst:
                     with urllib.request.urlopen(self.url) as resp:
-- 
2.47.1


