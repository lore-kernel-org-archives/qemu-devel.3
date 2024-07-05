Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0039AC3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 22:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPr3M-00024h-Ci; Fri, 05 Jul 2024 18:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr3L-00024T-19
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:05:15 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr3G-0007Ry-6B
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:05:14 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-424ad289912so14167325e9.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 15:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720217108; x=1720821908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=036Texer6I+pO+uIuAaEx1pn0gbXODeKzXhWPzvzsi0=;
 b=q8cqFcEqk2jWzO6zpaDCjEsM+qLOQwqg+sKgDdYYxXdpuLATQqtqJi7gcK0aKF2fKE
 yEmdVYfzLidAt7SC1GTSb3Gksr+s+lVZRn4HbNOIo38uBMB7iC1vCmJqhdQBj+rxp6fw
 28n2kL9RUPFkLzFMK+8dWgFJptfR//jD8wKq8luCnI7Z1Zt8+oI9Eij42MM3ahL/NBc2
 qQsBOKfN6Ut3uVxUeGJ2AHjVICJx/7KV4Tbw1jitr7+c2nV/6qEs+JnWvnkQAmE632LH
 tqZup6bVHKDrkUaL+ml4AAsua9N9iJGMEvhpysJgOr5Mlj40vJ3dWL7H9AyWmHtQts2t
 5n2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720217108; x=1720821908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=036Texer6I+pO+uIuAaEx1pn0gbXODeKzXhWPzvzsi0=;
 b=GGa5jFjEM/nk/UiI2Scm3zfYN3qMvhZK9k51v2a/hlX5jwZeLL4CD2ErtRLeJBptq/
 icVHodM1HW6GnETsi7O8Uh7H5rgCv5/4hheEplbCf8RKN5FE8JTQKUAkdw42Ewu6dzkz
 43BcH7CTEdva8gQw4pQGxYHxB1FoMc9m/ZFejOt6fAhyYALZXzJP4DjLp/jWYKtNshPt
 5VEA+s665lYwei9AL+VEejFxpYgDawuTbayjhL6atsYDkSWQC6HOjIcvW70DviDIbhVd
 Lto64J5zWpywvAnmNHFkV204fFkpE/axo7qvmmnh1tIpubBqsjY+FnBfP0f9SxicpcU8
 7ruQ==
X-Gm-Message-State: AOJu0Yy8orCRQQTmo2XVs+lDJpmzss182dWey5/JwA3iVRyGmjx6qNZy
 vzdyi0ijv8HmFCoDC8OcvxRkbe3b5TrTO3STGPDzPsEoXFxMZXT/3rhRKtVBsiCrw+MIQk7IxaC
 6
X-Google-Smtp-Source: AGHT+IHwlsXsD8nzbJuKUSyEnUM70kU8xwuysitI5qp1lNNvHossf0yqN7+V1KVHyjCktJoXvN/pZQ==
X-Received: by 2002:a05:600c:8a2:b0:426:5b3e:daa1 with SMTP id
 5b1f17b1804b1-4265b3ede5dmr11710995e9.29.1720217108468; 
 Fri, 05 Jul 2024 15:05:08 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2fc942sm75450655e9.42.2024.07.05.15.05.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jul 2024 15:05:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PULL 06/16] hw/sd/sdcard: Use spec v3.01 by default
Date: Sat,  6 Jul 2024 00:04:24 +0200
Message-ID: <20240705220435.15415-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240705220435.15415-1-philmd@linaro.org>
References: <20240705220435.15415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Recent SDHCI expect cards to support the v3.01 spec
to negociate lower I/O voltage. Select it by default.

Versioned machine types with a version of 9.0 or
earlier retain the old default (spec v2.00).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240703134356.85972-2-philmd@linaro.org>
---
 hw/core/machine.c | 1 +
 hw/sd/sd.c        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index f4cba6496c..bc38cad7f2 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -39,6 +39,7 @@ GlobalProperty hw_compat_9_0[] = {
     {"scsi-disk-base", "migrate-emulated-scsi-request", "false" },
     {"vfio-pci", "skip-vsc-check", "false" },
     { "virtio-pci", "x-pcie-pm-no-soft-reset", "off" },
+    {"sd-card", "spec_version", "2" },
 };
 const size_t hw_compat_9_0_len = G_N_ELEMENTS(hw_compat_9_0);
 
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 53767beaf8..a08a452d81 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2471,7 +2471,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
 
 static Property sd_properties[] = {
     DEFINE_PROP_UINT8("spec_version", SDState,
-                      spec_version, SD_PHY_SPECv2_00_VERS),
+                      spec_version, SD_PHY_SPECv3_01_VERS),
     DEFINE_PROP_DRIVE("drive", SDState, blk),
     DEFINE_PROP_END_OF_LIST()
 };
-- 
2.41.0


