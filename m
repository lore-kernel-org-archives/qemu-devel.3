Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB499FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 16:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHOYd-000466-V4; Mon, 27 Apr 2026 12:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHOYc-00045t-EF
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 12:11:38 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHOYa-0001Wg-P1
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 12:11:38 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso86419705e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 09:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777306295; x=1777911095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RSgoczyNjOIMwjfhNAddodzR3D/slhDRqdDm8fOkQ7Q=;
 b=MY3RjsGl7953wHZzTGXvwNsTYyuIoCP8J9tEKfJwUFnKIkef/jZ+7xcT/Wo4rCih2C
 KCseJImDAjqoezR7m/UiaVl1ijDVsmJDgwHFrMsdsgLQ9oCsXQRWvy944CvswxWo91Zg
 c3Sphc4Fxmk0RkP1UBRbn+LXQLWcgQ/cLZGLH0CwxmN5btnHSrYQxWlouoEu6P4Clxf6
 Gba3aeaY3u6IwaSOQ+XjH8o3WURlmqBFkxYZgsRRaD8t+dOK/eFvSZrghDD+akmjfxzE
 rBBWA9yqS/nD4+0UbJqlUxA9mzKPHtaetmchJr8842cgULtHzrZrsHFCgFSZMoqUurig
 NL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777306295; x=1777911095;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RSgoczyNjOIMwjfhNAddodzR3D/slhDRqdDm8fOkQ7Q=;
 b=l09jVbCRUKe0LWM740SD7VGGZFXBFLtEhbZ3voFp1moRJ0MQ9nUR9+PebE/PrBqXSo
 D402J2a+YzZ5MFllbZJ8Kv0VXxyyWzgkh0g5icLfXLzanIN3JLBvyOnVxJzsvv/UnRax
 bIMKrjsUb+Ay4v8Vv6o3p4kXgTg9VadPRhha/0WGarlcinp4Ul7lMumLxzpUNwU1Nh1G
 KEBY9Xumf4h0zMbA7iXE7xYlibE+xZZXVv1tNIWWIA2YJRKP8agHE4EEnKU0pT6EkXiG
 V7jQGaYIHmCthepYc+XIpcd8zyqiJuXjjaUulQ4UBMkIRV5KTDHCpvtbH3aAHkIj4XAO
 Bzjg==
X-Gm-Message-State: AOJu0Yzbn85wavhcxl/PbLQf+uMrTlBPQ0gnqygTcQvx4sOatQr8R1W3
 RMEbHp4j27JkPB2g64m2/eDkSggPXSWwNdjrM7B2UL/Ir6eQIuAWf2BLMgK+SUUVykx64TV/P1c
 y1e9/
X-Gm-Gg: AeBDievZ+2vGkBbBkzWaT9P7yN4tE2nm6RdceXuu2x7laxs1z847IgzDmM6Pr7J2UdB
 sFkBtGJG2sRHLZCQoCNBa3nABv9j88NSB3FBBZxiqgal49tFQLm8wMFK1daJNRmTK30P6xNbynV
 +agn1KQDphUwN+U+YIB90kb1P+55vqfg+xM51F1nke+En6+4iXHlfkdt1oXEv+Fmv618wCH2jzl
 Ds9r+naGKYhG5uvJ5VLnW1sMEU+MmE+HUBV7Ye/ta7zaBX9S/1bDstdYQCPg3/SQF1aQmUYP3ne
 0ZLiLJ5VQuRTn7AslNk7d4MZ6bxmaQgxZ0WINRaHu9wd46tbSSuIk8o7yY4TSfgWitz3N6BMTIE
 ZNTs3RhsaxFmgexvATcBvmldspe6G5b9ZEda0zk8ORY1pOWorBXlsOZut2oto8IlWn1Q8+74AIQ
 6LKtLW4dNtKpS7kJtsaSATBCZOAb6nn4tnQMT+RF4vBK8qrR5Uf0e/0WkVYETLwj6W/E9V5dHWB
 ZJ8OdtGWRyLB4TqY/OTjZrGs7h2K3r7RSVgcnuRnw==
X-Received: by 2002:a05:600c:1e8b:b0:48a:525b:e148 with SMTP id
 5b1f17b1804b1-48a76f47630mr648345e9.4.1777306295083; 
 Mon, 27 Apr 2026 09:11:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a52d232afsm171002385e9.31.2026.04.27.09.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 09:11:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] docs: Document TIMEOUT_MULTIPLIER for raising test timeouts
Date: Mon, 27 Apr 2026 17:11:32 +0100
Message-ID: <20260427161132.1463385-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Our test infrastructure allows you to set the TIMEOUT_MULTIPLIER
environment variable to raise the test timeouts if you're building
for a slow environment.  (scripts/mtest2make.py reads it and sets the
meson test -t argument accordingly.)

Document this so it's not a secret feature only known to a select
few.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/testing/main.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index 0662766b5c..b01a374865 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -52,6 +52,21 @@ Before running tests, it is best to build QEMU programs first. Some tests
 expect the executables to exist and will fail with obscure messages if they
 cannot find them.
 
+The timeouts for QEMU tests are set conservatively so you should not
+in general find that tests time out. However, if you are running on a
+particularly slow host or with a slow configuration (such as a build
+with the clang address-sanitizer enabled) you can globally raise all
+the timeouts, by setting the ``TIMEOUT_MULTIPLIER`` environment
+variable. For instance:
+
+.. code::
+
+ TIMEOUT_MULTIPLIER=3 make check
+
+will run with all the default timeouts multiplied by three. You can
+also disable timeouts entirely by setting the environment variable to
+``0``.
+
 .. _unit-tests:
 
 Unit tests
@@ -959,6 +974,9 @@ Python. You can run the functional tests simply by executing:
 
 See :ref:`checkfunctional-ref` for more details.
 
+The harness for the functional tests also honours the
+``TIMEOUT_MULTIPLIER`` environment variable.
+
 .. _checktcg-ref:
 
 Testing with "make check-tcg"
-- 
2.43.0


