Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86B3C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 12:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPiJz-0001m1-Qx; Fri, 05 Jul 2024 08:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPiJn-0001kH-SZ
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 08:45:46 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPiJm-0006Mk-3f
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 08:45:39 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42641dec7c3so9965485e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 05:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720183536; x=1720788336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fex8vqu9vOQLt+wDcEholU47zlEGYnekwdtOpr/Ru8Y=;
 b=kdZCss81mxObG48ZJ15Af3Iu0hBoXkxWowpVlWps5SQu6QSMRiTaImzi+DkgpFhCqi
 MyfN3cNoxvjk1eXZnTwv6jp0GxcyXcIhBcVqZzYMYdzlqaytQJLEFr1G7Wp8gTNHboxp
 WxuCY73uNGL7nwuh02FR9Orc6DM39SUOr8gRk8mcKT7C6Z/NtIGtRSE8BBkmrwcDKjAm
 XTysGJgg2b8as5KOQKFzKcE6McEPcu7fvn62duCVXD/3gzsjpcNsi72IJtQuqoVCUiIl
 2Gx28XNP6WR93GdCwIQrjXak9YGB8+7cyffh9Qo+gFD4QilDx+j/GRjLfSFL7BnEeXep
 COXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720183536; x=1720788336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fex8vqu9vOQLt+wDcEholU47zlEGYnekwdtOpr/Ru8Y=;
 b=bUPCKRxekRpAPecoVDgANhQlQbqfhox1KbzZBspUcYcYP+RjhdRnXO7E3J9Dircflu
 cVOGlDdrat6AnOghSh7/3w7GFAnB0T1/Zw334SLLG1nn6UDITMTCXvS+TyPXfnZzca6j
 xYO25CAgRfgW7/vnEGFD6kmUD9edJZDNucOuqJIAJYZ7VeEn4pv7VT22Sg5GizAtfPLM
 WldsWEeeeEQhDcYQ1ii3fRtlzO/1uO2eVA5uvBNQNUNaPWWU2Gm4W5Djg4pFbfQhVHcy
 Dtmcelgd9rnLjy2fQqQVJf3cAQpxXUw5q+Mf4iDmYKyVV6DCGjs0b79beVu3XTNyFw4T
 w9bQ==
X-Gm-Message-State: AOJu0YxROJkQrfs/v+rNIpps7FNw+kLSUYG6ZcXsU5o8mULumrc+gGiJ
 HiRLvMibcxf/btRduGYviCfj7aqDRDCB3qAN3DSEp/bjUYJuVeZjSGbgekj3HQd4T9zHKlAXAEO
 b
X-Google-Smtp-Source: AGHT+IGbVNBqV5HqhYuBMrvYDWrYJp9UNkY7GpwoBkLWxtI4vzbVn48CLx/o3D6t5LUNbbj8QOtQYg==
X-Received: by 2002:a05:600c:458a:b0:424:ad2a:1055 with SMTP id
 5b1f17b1804b1-4264a3d1ee4mr36058995e9.15.1720183536420; 
 Fri, 05 Jul 2024 05:45:36 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a103d00sm20918932f8f.99.2024.07.05.05.45.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jul 2024 05:45:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/2] system: Sort QEMU_ARCH_VIRTIO_PCI definition
Date: Fri,  5 Jul 2024 14:45:27 +0200
Message-ID: <20240705124528.97471-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240705124528.97471-1-philmd@linaro.org>
References: <20240705124528.97471-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Sort the QEMU_ARCH_VIRTIO_PCI to simplify adding/removing entries.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/qdev-monitor.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 6af6ef7d66..acdc8b73a3 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -55,12 +55,17 @@ typedef struct QDevAlias
 } QDevAlias;
 
 /* default virtio transport per architecture */
-#define QEMU_ARCH_VIRTIO_PCI (QEMU_ARCH_ALPHA | QEMU_ARCH_ARM | \
-                              QEMU_ARCH_HPPA | QEMU_ARCH_I386 | \
-                              QEMU_ARCH_MIPS | QEMU_ARCH_PPC |  \
-                              QEMU_ARCH_RISCV | QEMU_ARCH_SH4 | \
-                              QEMU_ARCH_SPARC | QEMU_ARCH_XTENSA | \
-                              QEMU_ARCH_LOONGARCH)
+#define QEMU_ARCH_VIRTIO_PCI (QEMU_ARCH_ALPHA | \
+                              QEMU_ARCH_ARM | \
+                              QEMU_ARCH_HPPA | \
+                              QEMU_ARCH_I386 | \
+                              QEMU_ARCH_LOONGARCH | \
+                              QEMU_ARCH_MIPS | \
+                              QEMU_ARCH_PPC | \
+                              QEMU_ARCH_RISCV | \
+                              QEMU_ARCH_SH4 | \
+                              QEMU_ARCH_SPARC | \
+                              QEMU_ARCH_XTENSA)
 #define QEMU_ARCH_VIRTIO_CCW (QEMU_ARCH_S390X)
 #define QEMU_ARCH_VIRTIO_MMIO (QEMU_ARCH_M68K)
 
-- 
2.41.0


