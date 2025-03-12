Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7638C28B30
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 13:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsLhE-0002hD-7k; Wed, 12 Mar 2025 09:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsLhC-0002gr-0D
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 09:00:26 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsLh8-0006Sp-Bo
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 09:00:23 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22409077c06so38151345ad.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 06:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741784419; x=1742389219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0PMBkVd9uVcdqrs2UDs6V3l11sQUJC5pHQobfquDNeU=;
 b=BEhNVz+U748U+ltJnCZZlTrsBSHM+VmujtfDPZbM/qkyfllKz1Kuggae0QqANPAbIY
 wQkR2mHL/+C+YOJozV40VtfY4k/oD8Py86XQ1StqHueR9hJgiUGBdj/ONYHI17+I8q1v
 hCwmRPZURu3yjBS2fzYOqtqjwFe+JTJh8dIHZIlIlS3XxKeg5PDhsAxWi5msqH5PcHBm
 vA1NsgYIF66X3AzBgyxrUAGtcOcv/fGCsGdr17H0HqZfm/qduFX8ex9Ww9TrplO5FMYm
 jMWn4ScwO5NCLo16Wt0BlAccRffqiVK7/Qn3JtOMD9L6kX8SPwmNNAH1CTaB0SE1Rwtx
 B5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741784419; x=1742389219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0PMBkVd9uVcdqrs2UDs6V3l11sQUJC5pHQobfquDNeU=;
 b=BIy0WGH3B8/kNYDWe3NCoeyLJLbwpQnIO9xuTVietxt249qyTgoU4R6haymYavWpn7
 PPduCF5WNtK112P4BFawD1ff5ng4bHx01LD40fPlQWms/LOd3tSCiYWG5CM5TLk8oB+7
 hEl6E7nBjfjwqOyjBtxLFq7TZuaWdgcZ/n/uJouv+ZFw1da4r2ahV5rkFbApDHEGoNdt
 fkqsxmYfbYDeHVU7OvVzxrsRygptyRm5Wwc7m9R/F+hC4zcLsLSGDRe0EsQYKQPMqaVu
 8zROppx7+MfCwolqlNUuVot+Lt0wBQhEYuzmQd8RwPtFQH9hHACm6HTPGliMLZnGPF2h
 hhNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYfbE+7tSUi6IeeFVFXa67pG3sg9FC7JNT8JnrSehEXOyTrntivRCs264pbrhy0rKf48r5QbRnbQD1@nongnu.org
X-Gm-Message-State: AOJu0Yx6Pelf7NL72AlC1e1dtTxrgPHgI+zAV8f2xB9UW8H6/AML3Rir
 z90CmVhL/elBiMSBR0ZGfwwyo4p23CQR/4d2bbYvxA89H5Cmxgw+
X-Gm-Gg: ASbGncvZUQoEV8LAf3nCqNvJ1Sfk+ReNsLjTjLvXeJUZ4GB6nDCGxzXxnk14qV39SrF
 xwlC9hOWbgUfPAfpsUbmNfMD5Ss1R8y/IawnyX3AXSD3N9VFp8hxRh5iJn3S8Vn7+ZjLS87YLPM
 DMu+AyfOT3ThYdsMhRc/tJhV+miiKCjF62t6dUgeb4Dv5xsm72HgDtedDuwV5Sieh5/K5C21RO6
 IVnhaZK3Y8z68b8c8fjI0JibmPCHbqyfCml1weBq6HPhLg7hFMWdjhQFaqsvH9nAl7H60M2kX1q
 z3MbS8hm7LvkxD0ALvg0bCFumrlPAUigfWCH6BGlVKiPerDLbR8=
X-Google-Smtp-Source: AGHT+IHyRnENf5g3lNCbz2Sn3EgKqhtPMy9uy3PMtFNN7i5zUX+4/omVfPdU85CVQDvIA8u3S6isXw==
X-Received: by 2002:a05:6a00:4f90:b0:736:3d6c:aa64 with SMTP id
 d2e1a72fcca58-736aab13b03mr31985892b3a.21.1741784419342; 
 Wed, 12 Mar 2025 06:00:19 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736bee078fasm8868407b3a.139.2025.03.12.06.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 06:00:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 1/3] tests/functional/asset: Fail assert fetch when retries
 are exceeded
Date: Wed, 12 Mar 2025 23:00:00 +1000
Message-ID: <20250312130002.945508-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250312130002.945508-1-npiggin@gmail.com>
References: <20250312130002.945508-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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

Add a check for non-existing file, which indicates the retry limit was
exceeded.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/functional/qemu_test/asset.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index f0730695f09..27dd839e705 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -138,6 +138,9 @@ def fetch(self):
                 tmp_cache_file.unlink()
                 raise
 
+        if not os.path.exists(tmp_cache_file):
+            raise Exception("Retries exceeded downloading %s", self.url)
+
         try:
             # Set these just for informational purposes
             os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
-- 
2.47.1


