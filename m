Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128BDE75453
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 13:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYPCq-0006CQ-CA; Wed, 24 Dec 2025 08:47:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYPCh-00069Q-Br
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 08:47:04 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYPCc-0003fU-8r
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 08:47:01 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42fbc544b09so4512997f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 05:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766584016; x=1767188816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/HatAXwMGekb8ws77keU2ufaJzveuprS4Y82gBiI7wk=;
 b=uphasc+o/gWoU+YqAUTLLHUJV/ROVbxETmn/3Dqe23EjyMpNPc5UtsLhASkAsw+lYN
 pyGSeWAN/CM2OAWYzw0ZIP2H4ZfbcqvErYApN6nXZzYY6Z+XO/vH1k78OY3k1xZe3LC7
 l/35jx0qbUVgZSw5u4srs6WvrReTyufMU6b5COyMaglyDcQCmsIv3ykWtji9fe2Y2KVn
 d6g6YzINnTfPKJG3AKx1kcpDFW4OfPMNTbaeVHMVdk8b7YUq6jhQKXuzzrEUNhqovsFC
 7ul4r9BWugJZRJPBzGEyO0vd1hkR0lRiGFR60bxBujVh0scm3Cs+CEqGVn68vzCXlPfW
 IyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766584016; x=1767188816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/HatAXwMGekb8ws77keU2ufaJzveuprS4Y82gBiI7wk=;
 b=BuKcOuKdN9ZWez3W7hCzLRBc8rzYN7/rGEyzeI5KM7/UdnpcTMCLC7WZGndHuNtnXi
 nljmHlB7J6cNTDiVy8jN1A9BRgVlJW3WA+ZNJDictceRssccVMsb2sEjUfljdPM03xXD
 v1DwJ6m1nRA/94j7AbItCPXbCs3I+9KoSSZw8REcfqJEr+OOebAefp0VkmD09lSs9hFb
 gbrZxX+Aideh+uX/i2gJcP2YAoMHTYJdUJ0c10/49Ap9o9nM9vvJEoGy9yKEqS688wuI
 9WcK0i7TRkM53BWDZbcOB11NWj3+MbJa4CN+//wCnKiL5tNabRBRIsFjZj26dZ8fJerO
 +Qgw==
X-Gm-Message-State: AOJu0Yya2AX+RvpmFUChsKSVLykX/cmFPv2OIYpQ5Lyhy9GIlputj4pQ
 JXzLbnVeCSvyZaP8mPpPK37Gbw+cSrsgiRqbgpgeVON4BiLQ7eR4L1YDCwauHn3jaTruUfAHM3s
 PGCWQEEQ=
X-Gm-Gg: AY/fxX4549jUKG7HQ0Thg2P6HO390attkfcmAInstptMgwKGCdW9hmjzem1pTrZvGyQ
 Lqom6FGdo4wf3iMhRkqeQ1uAaCcVJuE091FLjyCmjQrSh3L/ysOJZLzS51nFc2F9ULSUB7tt6v6
 QmxjlXRZcRsgi0vza+IkoRliR4KGqzy5u+2U0s3//Jpl/8ZWkrdxn8QqynxcTrsnukM9JB4TxfB
 tH14WyEpQzRou3+u1YdO8aR1wTqg57lULt6j2+FXVYT7e14BqhMmkjQ3W05AmevenImmKWTlNUY
 dlKIoXx7SkKa6KVmCsmw38lfsJUbgPkXmIh5djXcwm0fFj1JdMOQtdktw+74TiU6y6qZ91DwWiq
 lG6KE4nIWjDaDWFUFmGaS9mCw5TVCZ+47evBaiGxgiDE6gvsa5LHlgGvBntFCF7jo0PvhPsKt+y
 TvG+6+cJ+CzWltSMH+eTGFjarP7dlfC3NI06JszKdWpz2M5S9IP8BXpN+yx7Jyw5wYvwfiMhI=
X-Google-Smtp-Source: AGHT+IFImcLyhNm02bS1bcJPwE+B5F0pKDwOtrfRI74UcvtYUim28G8m3NZ44HEdlcfeOhDjUMMsXw==
X-Received: by 2002:a05:6000:26c3:b0:42f:b581:c69a with SMTP id
 ffacd0b85a97d-4324e4c3e13mr19199452f8f.5.1766584016267; 
 Wed, 24 Dec 2025 05:46:56 -0800 (PST)
Received: from localhost.localdomain (218.170.88.92.rev.sfr.net.
 [92.88.170.218]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4327778e27bsm1073363f8f.12.2025.12.24.05.46.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 05:46:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-rust@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Max Filippov <jcmvbkbc@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 1/8] hw/arm/Kconfig: Have FSL_IMX6UL SoC select IMX_USBPHY
Date: Wed, 24 Dec 2025 14:46:37 +0100
Message-ID: <20251224134644.85582-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224134644.85582-1-philmd@linaro.org>
References: <20251224134644.85582-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Since commit 17372bd812d, the SoC used by the mcimx6ul-evk
machine requires the IMX USB PHY component.
As this component is only used by 2 machines, do not select
it by default (it will be automatically  selected when
necessary).

Fixes: 17372bd812d ("hw/arm/fsl-imx6ul: Wire up USB controllers")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/Kconfig | 1 +
 hw/usb/Kconfig | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 78775063840..97d747e2062 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -638,6 +638,7 @@ config FSL_IMX6UL
     select IMX
     select IMX_FEC
     select IMX_I2C
+    select IMX_USBPHY
     select WDT_IMX2
     select SDHCI
     select USB_CHIPIDEA
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 69c663be52f..de95686720c 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -132,7 +132,6 @@ config USB_CANOKEY
 
 config IMX_USBPHY
     bool
-    default y
     depends on USB
 
 config USB_DWC3
-- 
2.52.0


