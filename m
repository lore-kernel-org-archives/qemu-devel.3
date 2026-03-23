Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9021DF4613D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 15:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4heO-0005Kv-13; Mon, 23 Mar 2026 11:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w4he2-0005Ee-UZ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:56:49 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w4he0-0007tB-F8
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:56:46 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6611f41eebcso644583a12.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 08:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774281401; x=1774886201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ehmEJNcEUvWR4p1pxJZuNpiKpsAzgjyq2kLYhXCKaxg=;
 b=ApzlY98u3NAVIs618n5GijkFL+wfswyMQhWUXbWkfCgXhzfrGuxdaddfLuPEBchIzj
 loaVGmheBVL0aVdmzD6rhnA1PJ0s96SE9AToGvftKVQtu767tJG5MQ4AEoHz0K7pNJRn
 Xaf5KP62x8xXh9Ufa8h3oLivnYJSA4x+6PXYh3/HhAyQsDg5jmtpqo9HE/LHaSoHBTw2
 2TYORB1mMQS4o80uQGxlZ/NR5/vpSxNqOVZBrp6RytqgICoBhpM91Q8XvcGXZPEUqADu
 JmgfjIoMJga94fZXM+Js443tv3nqemh37ifRJ2I6p/YwJ3f1ElupTQsNxaqjxHnEj1ak
 YgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774281401; x=1774886201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ehmEJNcEUvWR4p1pxJZuNpiKpsAzgjyq2kLYhXCKaxg=;
 b=CxsRtlMxmO4y5eXbDnIJ7X3Cmm6oO8NDGCJtsdPPo2Vs5liJpoSd88pY0V2CdDF/oP
 r/pFOHHT10fHimzZYHsJakABMV9qJPaZA9NUdQAQCjw1hKhlnvt1DakXIm9ze4TyDjzK
 lQEkc4eD/35yCWgWG312MQ8kwK826jE1XOrHqb7K6M2asu4l/5LT0eHSWupOzwaJYfmN
 IXgATzZw6yEPiO4Mu7E218IKDivbJbzPZQtC3xP1I3DK+FZdQdFtMu8JKmPGqIXgg+AF
 TrMrGGhSPOjgAWZZ2aOY0Yv7IeJTd+nGleoupFQtVAq/417TDxtszMUHPYLfh0jfZQzg
 qrhQ==
X-Gm-Message-State: AOJu0YwLrz/qoKrpF00bbrR8YEKKc0knslSQNL8zgl/+NKT5BS/zbKus
 EplCLrvENopacPtqEEDZNYKJ80PofuqZJb+22Ll8ZVh5oCi4NubqV87N0uceojW37NI=
X-Gm-Gg: ATEYQzyxMZrgZvZ9WRNecebIVH/+s4UpafqU+pIJdgEP+PPx7nybsQf6NG8UAzc4Bve
 DBgBDIGEJ0vGhSo4uKIMajPf/WabAg9QPJzGhGkVNqfN458iHs6HNJhw4qc5l9OpbnfqFMmzDQ0
 alzQ/Dkw5Fpt+VuYabLLARTwcI6ffNbyGZFHNrx2MZNp5ClgKa0IYT7wIIz0E/tIhrUEIdrGuuk
 j18DEzSDCmlA2mMw3fC1eF8LaWLT3mPYMj20vJde8iHp53SmnCFm8UHF3xVdJokA762y3X+Frhl
 /zB3VigGvhC4J5sMBdire3oDyYrPCFq0Yi/R9MDJ+5iPMfz7XTEzPteAVh5DD4GxDFgwWSqC6tl
 r1I6uCNd5QlaNWOZ22B0VD/NSmd7Pz5HRkXP991zFxSw8eOLEcWlWYz0P8miKGyzcLyYbfU/c7V
 NzaSigmZmNPZoiBhE+Wrg+JH8=
X-Received: by 2002:a17:907:7fa3:b0:b98:4799:e6de with SMTP id
 a640c23a62f3a-b984799e8afmr721698766b.48.1774281400671; 
 Mon, 23 Mar 2026 08:56:40 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b983365a14csm496397766b.43.2026.03.23.08.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 08:56:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 25E6C5F855;
 Mon, 23 Mar 2026 15:56:38 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 3/8] tests/functional: allow tests to define decompression
 target
Date: Mon, 23 Mar 2026 15:56:32 +0000
Message-ID: <20260323155637.145015-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323155637.145015-1-alex.bennee@linaro.org>
References: <20260323155637.145015-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

When dealing with multi-stage decompression we want to specify the
target file name lest we just overload the cache name. It also allows
for something is little more friendly than the cache hash.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260320155107.2143191-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index c2c916f6077..eaec1bea138 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -35,7 +35,7 @@
 
 class QemuBaseTest(unittest.TestCase):
 
-    def uncompress(self, compressed, format=None):
+    def uncompress(self, compressed, target=None, format=None):
         '''
         @params compressed: filename, Asset, or file-like object to uncompress
         @params format: optional compression format (gzip, lzma)
@@ -52,8 +52,11 @@ def uncompress(self, compressed, format=None):
         if isinstance(compressed, Asset):
             compressed.fetch()
 
-        (name, _ext) = os.path.splitext(str(compressed))
-        uncompressed = self.scratch_file(os.path.basename(name))
+        if target is not None:
+            uncompressed = self.scratch_file(target)
+        else:
+            (name, _ext) = os.path.splitext(str(compressed))
+            uncompressed = self.scratch_file(os.path.basename(name))
 
         uncompress(compressed, uncompressed, format)
 
-- 
2.47.3


