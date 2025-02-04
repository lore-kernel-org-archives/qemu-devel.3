Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45709C0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 09:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfF7b-0004mT-Dj; Tue, 04 Feb 2025 04:21:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7Y-0004i6-JK; Tue, 04 Feb 2025 04:21:28 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7W-00052e-Qm; Tue, 04 Feb 2025 04:21:28 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-437a92d7b96so53131735e9.2; 
 Tue, 04 Feb 2025 01:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738660884; x=1739265684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RWwFZAblT8IJuxVnOIUdY36BCPwzLgHd8Wv7Hgxbpe8=;
 b=HRqEcECnZrmaLSb9tuJi3eosrU4tLC5X2ab+bcnl4oWQrTtl3jnLLeNol/dUQBf9aV
 pUavJS9DL3oGVItP85KnvlSiQbjc+CmKH1m1GUBRwzuvDecAtOyroiVWdcu3Cnjs3b8e
 OSOtcykdH+4oEE0EyDcFADpGvSqRbgNRUPwkg24J3o8rOJHxOTKDAaeVfTSobxCPv2gw
 3Sy1xInCq7MOwkDAxJRgLyCIwE9J7VT2HImlG77SxHMxeKnIilXaKjJnNpcrSXHtCvzh
 9oCM2PlR+zpLFYSocBvdbloe/gcGacA8DckzGhKKl3b1+0wIZ9fnCdLu+QNkf2OYVxkt
 FlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738660884; x=1739265684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RWwFZAblT8IJuxVnOIUdY36BCPwzLgHd8Wv7Hgxbpe8=;
 b=RRu2ubPCp3f49kOhRbcXIduMRc3SyhkDSJZZQyTr4f0iKuCYd6TZYpkcMaHbKnvwDv
 Lpi6t4BB+Wfb7H9ScznBseN8hWvmqxwRZvkVYdpIzU7f24Jk94YcaZZoPEij49FpGhm+
 XI4o+7J3UW8hKMjcufGefs7lJZLXNlh+V3PVsR2LT70ai6OKd/hbX2b7sI4prfNrCj90
 O/mvs088NBaE8rDtSNFOLN6NgnsrdBXOsO6x7eGMxfLY48odZFUNoJ3r6EF5xnesOsT5
 7htE2pugSlqGC8ZdOM9EyGtQ5usTggmI+bk4580dVjQDERPWOSOXQ3570gRiQ9WR2A9J
 bFFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxTP+60nQCEJHGh0blrqUaKfvyHDj1s+SUThp3vtX9PhwFcmWXdhrNHrxIK7ecyy2UHpEFXsGBEQ==@nongnu.org
X-Gm-Message-State: AOJu0YzgJBBwnUYlnp8K4YYsq0IgJ9ukS1Gcq7stQQ2LpixbcXbGPcjL
 fPOKI6uHxiTUSVQMVliqMWOKntpxzR6DhBsxzyiVISIuV0WUhXbs5sj3eQ==
X-Gm-Gg: ASbGncuwxoTmKyAWsp30xgB7podbp4EP7GHo8qreOXGqjYBy78yQdbT2mlGM1DIi1/z
 oXqVL9dEEAdXive6ggJE5r6His+JU0VwZ9aExa3BYLg9wCgTwyq7DDSx5sj1UgPsdjxZ87PLGQS
 JHeaIqeDk/YWkzUBNwx5pVZg1dETR42kvF81CdVWQ6K139vmQh2DafL80QOnXv6zFTbjIox2U4T
 yYpA8qTKnOCIQb6ukNcp44LBQOyAkG5iQixFsdYHZUobbtUZ8tOPc3oIyqNTcxwsiyLsXLS0Txr
 vW7C7XURLogTYO8unzNjViEA2ffc+/eQGDCQVdMLIq4A9w+gMuYCDuDOs6kXlPtKqet1Jzsf0hZ
 DWBSSGLBCjg==
X-Google-Smtp-Source: AGHT+IEBY1kwqy6mx+P9FPj7nv53drDY1kCrzj4xO4MV4vm8VvvGwfoowyup7zFc86Lh3yvtEGynCQ==
X-Received: by 2002:a05:600c:6c44:b0:436:fb02:e90 with SMTP id
 5b1f17b1804b1-438dc48aa14mr238558945e9.10.1738660883840; 
 Tue, 04 Feb 2025 01:21:23 -0800 (PST)
Received: from Georg-PC.fritz.box
 (p200300faaf0043006a2cae69f03f1c85.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:6a2c:ae69:f03f:1c85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d42c7sm187233595e9.3.2025.02.04.01.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 01:21:23 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 03/18] hw/gpio/pca955*: Move Kconfig switches next to
 implementations
Date: Tue,  4 Feb 2025 10:20:57 +0100
Message-ID: <20250204092112.26957-4-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204092112.26957-1-shentey@gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x330.google.com
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

While at it and since they are user-creatable, build them when
CONFIG_I2C_DEVICES is set.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/gpio/Kconfig | 10 ++++++++++
 hw/misc/Kconfig |  8 --------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index c423e10f59..007048c688 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -16,6 +16,16 @@ config SIFIVE_GPIO
 config STM32L4X5_GPIO
     bool
 
+config PCA9552
+    bool
+    depends on I2C
+    default y if I2C_DEVICES
+
+config PCA9554
+    bool
+    depends on I2C
+    default y if I2C_DEVICES
+
 config PCF8574
     bool
     depends on I2C
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 8f9ce2f68c..4271e2f4ac 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -30,14 +30,6 @@ config EDU
     default y if TEST_DEVICES
     depends on PCI && MSI_NONBROKEN
 
-config PCA9552
-    bool
-    depends on I2C
-
-config PCA9554
-    bool
-    depends on I2C
-
 config I2C_ECHO
     bool
     default y if TEST_DEVICES
-- 
2.48.1


