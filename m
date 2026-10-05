Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9B8CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfow-0004Gd-El; Mon, 05 Oct 2026 06:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmX-0002I5-5e
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:57 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmT-0000zy-LU
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:52 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a166199820so4447475e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791195527; x=1791800327; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=quIvgnbJMv5vTwzRauO3a7Lqqn6EP9etKReuFzA3ts4=;
 b=KWkT1PfcyMglQ/HKa7UQCo1r7L8esIy/lgOK8C/nmR8NEEIdz3XpoxJ/MRadZbKqQy
 rfCvPukKrLDyLRQ0l2mFvB7VU4xn+/mXC2xEfHD7dCDgwAr637UvYcUwJXeRfpqyseZO
 FMCF6wwvD1cbqEx2k3G6i4Qp2ozK3H3WSAZtCiEwXF9W52LqQF/xwpAkF/w0wtZHip9C
 Sdl/XYGyyZmnidl4g0aDels1BMDtFNLWfx4EncnYUa3ozY6gD+6J9CpygDmY+hqZHT4S
 0j8Iia69T74UGCEI2/Ktzlns+tRvsmkfIm4OVZX37YD5N8hCaHeWr169OT57nYZar+OW
 C3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195527; x=1791800327;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=quIvgnbJMv5vTwzRauO3a7Lqqn6EP9etKReuFzA3ts4=;
 b=EaEbQ6/JXnnTcXqBfTA8tPW+WqyGk1TL2RANvJu/jrKDBFI3Kr1owsCgDeIoCiQg8R
 3Tjz3payzrX+TGHu2mTeVbp4BvlDMeNDXGjB560RVT3sSmPUruWfVwMiATaDTUHBf2gP
 A/gIDC06Ofo5Pag1yaCSqu5IisalHlXbnD31Y6WfZTyOga9Pjutzyxn0GQKEpREd1945
 Ld0FQeGkq6tmUMHuXGz0XPamiXWjVPZ6n+pyxOiU66MUX980h4keaQ+H0Z3WOGQlfdb5
 crVThtV58VERi4FCV36pBLoWse1nX95lxPHIcLjiRlYRH1AfG8cfF6ZWF7MWuHfbcnGn
 v2mQ==
X-Gm-Message-State: AFuF++kKiF/U7f1dKIBEmwqIOF3a2W7TvyrwacUrYue/EgVr+n76YTpT
 I0RNbkGuu3PljBn9jYYrCGfRPnR9WGv82Qyo1XFpj5jtAZR4nHE8UlQj95+02Q==
X-Gm-Gg: AYBFou11cradIv6KFRtHbM6qkT8zRa4Qh0dj5NvDHv7g8yqfoJGQC3doAEGWADBY7hT
 gGESjrpDVedDfEu45qRc4yZ2VYOHH72FI5Q5HlvcBiitFmMr7gGiD0szbMspr4iGMq8iNJqKbs3
 5DeUe/l2v6CnNbBJTKWDf+GKnT9QRy0/UJGkRguy6xAi5jsgF5OsB+EBSRRRhgZ1UTTdZbMjII1
 zpT3Ohofewkj5M1iJtlzI3u1GOU2xqosMPaC9CIkoq5+B3T+d+aDUxYsi9VMfWlqSlFfZtBou7R
 Vi9swYyAfigiSIayWJsWI9aPAh36NoWFrboxJZK8MlHqGJbqu21RuLQN9hL9ZCB1PCSSYtRXBhl
 94n/TInLtOzk88PBwCQdYUP8jsRPgU+M5yRUd0IAXruigGiBPAOTtOLT0AxbqAZAaERnm2GGX2T
 2+cuqSu7ZvaCF7gTKmjX7Hy69WUG4Gz7AM5aLYfIUf658A8KbEZ+cJ/bvoxLmhEPkBnwalLLPhq
 B8Wcn0+eLrkhalXIyUZiHyF25pEKslhC/SMQTpM8cp4guRA
X-Received: by 2002:a05:600c:ad7:b0:49c:f13d:ffed with SMTP id
 5b1f17b1804b1-4a01eb4c01dmr193515735e9.17.1791195526741; 
 Mon, 05 Oct 2026 03:18:46 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm2742111f8f.37.2026.10.05.03.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:18:46 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 18/31] Kconfig: Extract config IMX_AVIC from config IMX
Date: Mon,  5 Oct 2026 12:17:45 +0200
Message-ID: <20261005101800.10821-19-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005101800.10821-1-shentey@gmail.com>
References: <20261005101800.10821-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Bin Meng <bin.meng@processmission.com>
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


