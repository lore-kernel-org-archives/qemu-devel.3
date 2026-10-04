Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1021DCA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDLK0-0006dW-Ir; Sun, 04 Oct 2026 08:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLJy-0006cc-NM
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:28:02 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLJx-0007BU-2b
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:28:02 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-4a024e16179so5302965e9.2
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 05:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791116879; x=1791721679; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I+xjIXqvtKBB9DzZZBMqCM+uBT7p29pUu/Q7YPAVM1A=;
 b=gnMws31GguTiUhX65GNNXJcGkNIb0oUVvBLbzvNqOOQ+A5RxChsYYfzhqnHpiyVUML
 K6AYCG69ntx93hMFke/Xqo53/fzhxFg6YF7cSgiZ6Bgj+qRYme+KjC6c2O/M+5Q0o8hP
 A6RvUYMdg+Cz7wmzZLuWGTbkNJHgY/f4YFjTfYisXlKQ9eacIGmlmoB13WUVE78imn0/
 ZgFbb7LC3MLCXovREx7v3Mn3osdbudZyr2l+99UeMaNqO10izVoGGMGQQyyBjBiWGE1I
 v3mKJvny80NDTHzHZP1YiI5EhPz5TePnPjzeseIAVo2K+R80mnT6ztxQTU5hHsXldT4Q
 HldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791116879; x=1791721679;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I+xjIXqvtKBB9DzZZBMqCM+uBT7p29pUu/Q7YPAVM1A=;
 b=08Ymgb0MZC4a2rvKbm6V2xn6uWbZ3aMcMSbGTVqEDwxjPIchU90ZHH2gslH5DfbWx5
 Nli4BoKsklNCT+gEqb0SS8hF0f3EoyIMMEj4MSvMJmdrwkmcfiQ9dNBPFReQqc84LZw0
 XuNDUlo4mHojgTki9irRHHPPW4mMmkJoUtieM9Jnsk9/+sbkjgW7p4aBcROiAy6wX/uN
 7fDDCbO42UHfQgquO9TDY60zoJCPihct6Z0tefA/CbG7lHCqhgxnhFKuYzCn85phScUR
 BPXc8luQTjkkDxe7uJYWhJulArTGU6NtfbJrlGtBbVnIo9EPsy0ANJ3ybOV8pGT5D8IP
 e0gA==
X-Gm-Message-State: AFuF++mAUL9H7bk0ho6DvEBUllRvFbcUc1QEJG7fbMIpEBsupkQ/XmV8
 p7Blxw65alGj4YhJjZ02hxt0912N2Ovf4avTuDe7Om+W1c4tBGw5N+cenw2yGw==
X-Gm-Gg: AYBFou2beWY4/JXsqyfbTN3Jymz4FF+pt/n9689XiDICewyNbUhq7yruUxPPiHYBHJ7
 NWpw0wt0B9y3vXKdd2rmdawjDxnHZ+hsLUVyJQLY71hnwTsBpWTobEQ8c2H9IUS6YjV0tztFHdr
 5rkf90cX0ayxEKDlSN7IaZNaPyEcG7QlBsE40CkSvTETphMW4bETQSgsJPWiCE4o3LQhV0wnuro
 scwIB45SAGUlrhfYIPpvwn48buZ3wbrWq17Mutp+o9BAaHzjitqvVMftWnT2F98PJnxIifRgqRQ
 xkYzAFbxsAY7229PSMmSjLSmH1ansoYALLE2/NA+kwjnvPem8JzkUThl8XOhW9/OD9de+sDLpsv
 suMCO9sB6AwYPiXPjytIW0+mAd+WyyY0KNvCwrJdOLfrSJB4bNrRk4fSST/li+ofveAjeIZn/ep
 ine+OHr+JDAWuQvbTYJLKzwELBVb7/LPmKslQxlyBskH/xX6Cy/6aYpQF5cm0MPAeV0bFyDb/Tu
 lJrLVRwWkUwUtKyoWXAuHN8CeoAhdqCtnmeNQ==
X-Received: by 2002:a05:600c:3152:b0:49e:7c8c:361d with SMTP id
 5b1f17b1804b1-4a027584bc4mr133631615e9.22.1791116879432; 
 Sun, 04 Oct 2026 05:27:59 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027698f13sm242319975e9.1.2026.10.04.05.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 05:27:58 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 17/30] Kconfig: Extract config IMX_AVIC from config IMX
Date: Sun,  4 Oct 2026 14:26:33 +0200
Message-ID: <20261004122647.3913-18-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004122647.3913-1-shentey@gmail.com>
References: <20261004122647.3913-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Over time, QEMU has grown a number of i.MX boards and the monolithic
config IMX drags in unneeded dependencies into each SoC model. Extract
config IMX_AVIC to eventually eliminate config IMX.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig      | 2 ++
 hw/intc/Kconfig     | 3 +++
 hw/intc/meson.build | 3 ++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4445f16f45..030b218eb6 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -480,6 +480,7 @@ config FSL_IMX25
     depends on TCG && ARM
     imply I2C_DEVICES
     select IMX
+    select IMX_AVIC
     select IMX_FEC
     select IMX_I2C
     select USB_CHIPIDEA
@@ -493,6 +494,7 @@ config FSL_IMX31
     imply I2C_DEVICES
     select SERIAL_MM
     select IMX
+    select IMX_AVIC
     select IMX_I2C
     select WDT_IMX2
     select LAN9118
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 05e697967d..97355f9df7 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -5,6 +5,9 @@ config I8259
     bool
     select ISA_BUS
 
+config IMX_AVIC
+    bool
+
 config PL190
     bool
 
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 0620b0792a..74d84b8ddc 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -23,7 +23,8 @@ system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_gic.c', 'exynos
 system_ss.add(when: 'CONFIG_GOLDFISH_PIC', if_true: files('goldfish_pic.c'))
 system_ss.add(when: 'CONFIG_HEATHROW_PIC', if_true: files('heathrow_pic.c'))
 system_ss.add(when: 'CONFIG_I8259', if_true: files('i8259_common.c', 'i8259.c'))
-system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_avic.c', 'imx_gpcv2.c'))
+system_ss.add(when: 'CONFIG_IMX_AVIC', if_true: files('imx_avic.c'))
+system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpcv2.c'))
 system_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic_common.c'), if_false: files('ioapic-stub.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_intc.c'))
 system_ss.add(when: 'CONFIG_OPENPIC', if_true: files('openpic.c'))
-- 
2.56.0


