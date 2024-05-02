Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2624CC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 09:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2TBb-0000gu-Vq; Thu, 02 May 2024 05:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2TBZ-0000eL-Rv
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:57:05 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2TBX-00019W-JQ
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:57:04 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41b5e74fa83so51910315e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 02:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714643822; x=1715248622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OWnrA6E91+7xAaPI8kCn9o7Y7ybTIOe7+SUe3y8pkFw=;
 b=BWEW6nVMH90wQe/RV5ddg5LIKPiqhQF07BYhxegi/dG2+klv6/U+uHbuPGY2VOmuBI
 4hlvzxmaR1Y9I13RvOzEG3aFsosdulGLGFmAvFJ/AAMNlVvGgisEgCNtCAbZ6XrkqMDy
 xk5sQNGOt5IPuwSEcYIIisnioKWVaSlLt+pY1DFtR83URpENFh9LY1GU215XdDYLXA+B
 a5XlE69qiqtJqOwSxnitYg4C4+CFbHM/GfP+BiEaulGhyna2gavK8gJc/zqAyr7nL4j5
 hDVK3ocuNtGX0JuH2MbmUczns1M2vf5achAHoJoD4jAO1oJj5N5eE8bsxgU8i3Gh5XO5
 AjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714643822; x=1715248622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OWnrA6E91+7xAaPI8kCn9o7Y7ybTIOe7+SUe3y8pkFw=;
 b=EYinyKU/+cETJaJFhECQygW1n8kp/hWgp7iMPvVKeEuO2OVvOv9JYqZ/29cDtTcq+t
 Jmh/JUZTfAPgwCOHdjeDB2pwnaoUDUoG/DTiZLJGbkJ/zO5ZgSr9IhPCO4hYYxKFuOLO
 6L1v4QRGIaYqsmMsKAyR5/ENudVgaipOZUDGnkdeYjosXjxBGwnlu7Ks4+dGnWc4yB6Y
 JB6hc8WtjOiNkYERhxSVA7nlOCvOINCNMnv13RbF9a4hCcjnCDey1jE7sonyuXqLGhZc
 6HewYb9d33dgvP+tQ2MH/ZmGMU8k2WTnFNfKzgmfjR6cehWE3haNDTOuVQEmL6/g/2VW
 f0nA==
X-Gm-Message-State: AOJu0Yyn/VkH371dK8v4xkEGf8gvrqeF4mYwvkvNGoAO2OW1GcdcN6I+
 1NASdapyB80u2zdXlf6CaNrmJkANAHeqS7t4VHmk8wliq0FN+HXkeBfKLM0mBdZ7//2lznYp6Fc
 /
X-Google-Smtp-Source: AGHT+IEmk6ue13PnbZ9dFBQt7wOV7TTFIcyk8Mxq17s74JZ1rPy4K/FqCytBY3jrHqPCMrTEnwyHVA==
X-Received: by 2002:a05:600c:444d:b0:418:ed23:a9f0 with SMTP id
 v13-20020a05600c444d00b00418ed23a9f0mr3554308wmn.18.1714643821957; 
 Thu, 02 May 2024 02:57:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.215.106])
 by smtp.gmail.com with ESMTPSA id
 n21-20020a05600c3b9500b0041a9fc2a6b5sm5111895wms.20.2024.05.02.02.57.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 May 2024 02:57:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/3] crypto: Allow building with GnuTLS but without Libtasn1
Date: Thu,  2 May 2024 11:56:42 +0200
Message-ID: <20240502095642.93368-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240502095642.93368-1-philmd@linaro.org>
References: <20240502095642.93368-1-philmd@linaro.org>
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

We only use Libtasn1 in unit tests. As noted in commit d47b83b118
("tests: add migration tests of TLS with x509 credentials"), having
GnuTLS without Libtasn1 is a valid configuration, so do not require
Libtasn1, to avoid:

  Dependency gnutls found: YES 3.7.1 (cached)
  Run-time dependency libtasn1 found: NO (tried pkgconfig)

  ../meson.build:1914:10: ERROR: Dependency "libtasn1" not found, tried pkgconfig

Fixes: ba7ed407e6 ("configure, meson: convert libtasn1 detection to meson")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 5db2dbc12e..837a2bdb56 100644
--- a/meson.build
+++ b/meson.build
@@ -1912,6 +1912,7 @@ endif
 tasn1 = not_found
 if gnutls.found()
   tasn1 = dependency('libtasn1',
+                     required: false,
                      method: 'pkg-config')
 endif
 keyutils = not_found
-- 
2.41.0


