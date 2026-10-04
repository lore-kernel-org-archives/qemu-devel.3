Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B034CA5FF0
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDLK6-0006ex-4Q; Sun, 04 Oct 2026 08:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLK1-0006e0-Mr
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:28:05 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLK0-0007CB-23
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:28:05 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-4a0977b9c20so14482705e9.2
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 05:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791116882; x=1791721682; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HFK7rw2+rwgEdnucdlvbPkHpZV+5fYg1Du1yvV5rZhE=;
 b=NThG2I3EjMvrn+ShviwSbQXYK8mg1sXP9CcfQq7LT5LXkPkkGLXovkAoo+zTHQ8ccj
 ZVsgIUB9uZaC2uYizCySWHxPyV6KgXwOg5aU7NQP46vW42x/UtjSapUuM3cVIUNOuP1u
 QykMrysQHaOrWrLYMeo7wVkJE3rGiOJgno1ISi07g6efHoRQoVq8SiAi7B3UsZP14+iF
 vwX6DXUb7HaQDXNAD+AYtSU8WxJ5gm9lXzC4SU3iekik8mek+Z5Dmas2JZpkvEW/34Fg
 igSLg8XVxeMeCsSO4VKkONNwAGIX8KsF/hNunBe6Pfgnrn8b4AGxtem5vMQEjZ+dech3
 vZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791116882; x=1791721682;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HFK7rw2+rwgEdnucdlvbPkHpZV+5fYg1Du1yvV5rZhE=;
 b=PlOgh7EvQKh14RQ4J+IKKLtAcOSSkbVI74/ZKoRWhXl8LrtQxSOsvsYweVzdqrCTRS
 TUX+nELrmtOnGfU9Jh3cx3jNgapZb8iGMDuHz0DSA8vMtG+LeLrCKVRsSZlT9PeHtcFm
 3NrWfAqHoeFj9X657HlUTOhOUVfCSmUkWXqqFBN+JMA1BfkU8y5EJ43iW9qQiFFhEC/I
 xACLrUoFV/cz4rMLAWyIKkUcIloHVElHnXrSd/2eZHDETYLry3DfY1H0i7tY8KT8deUV
 lWmGhH2kudz1nTn7tLDbq/0ASus+BEDpownyGZHYqFzP5lBCDXjzyctnLAa45Tpm6CdD
 n2Mg==
X-Gm-Message-State: AFuF++nHoSZgpQeNwxeidi1l51VhD4F5apkfbJGo1/4pJ7U6SgM9hwoD
 xWMkr1f/xs9tm/l0YszjlGFlsv/m4n8addCa4iL3bMXC2ojiUnLPSG9KJKDUKg==
X-Gm-Gg: AYBFou0Z3fekVokBhrdHgfGU63gYUFrspiPzjLJugeHShPIhG1gQ/Gmt3k8DaAV+LTW
 y8++snLYUDFjCraqMo/Y/fjzOTMCIriL8SPdiGAN274I4TO45bRjg53zcnO7ieFPNBVfjbBYzYk
 0xRd47zzRGgRGd+RhMoTOqu3Kf8lESC0l3IoQ9YPFiG77oyE38pgh+kIdI+XJ9t2UL3vdL6fsGa
 G2/f1qSI1MlHKX0cOckC8GRx9Kq4Yy0i2LITujgLlVrKlo2ar0FpDdnsuoJCDuKrSClcCqIxNzU
 aFjWJdRiSow+aBi8BXA3G9GPDIk/v5q6+CaSfZY1wE/UtHKNl3bQ52q6o/VZU91M1s4RFRsPSPZ
 UCCNAhCATHQ0pl0vyG/e18sjTbazPZH50Qn288TnX/pGW6sbRNjl4sKCzFaXY0RQquJcio6m42F
 QhONY2ZjA+gRCYrt556nX7YlBFagGfHDv4SUOGcxkyBzst3Adog8f8BV47/z3A1rFDlD7+TjYDj
 UPOVEMxgIxGCu/fhWE7YOffZjUP8lC4/B07Qg==
X-Received: by 2002:a05:600c:1d1c:b0:4a1:6f72:3ea with SMTP id
 5b1f17b1804b1-4a16f72050cmr27328245e9.25.1791116882461; 
 Sun, 04 Oct 2026 05:28:02 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027698f13sm242319975e9.1.2026.10.04.05.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 05:28:01 -0700 (PDT)
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
Subject: [PATCH v2 19/30] Kconfig: Extract config IMX_RNG from config IMX
Date: Sun,  4 Oct 2026 14:26:35 +0200
Message-ID: <20261004122647.3913-20-shentey@gmail.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
config IMX_RNG to eventually eliminate config IMX.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig      | 1 +
 hw/misc/Kconfig     | 3 +++
 hw/misc/meson.build | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index a33f5a46f9..2084813e1c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -483,6 +483,7 @@ config FSL_IMX25
     select IMX_AVIC
     select IMX_FEC
     select IMX_I2C
+    select IMX_RNG
     select USB_CHIPIDEA
     select WDT_IMX2
     select SDHCI
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index d1711433ef..3f17d29053 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -94,6 +94,9 @@ config IMX
     select PTIMER
     select SSI
 
+config IMX_RNG
+    bool
+
 config FSL_IMX8MP_ANALOG
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 9790afa104..61e128ab7a 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -62,6 +62,7 @@ system_ss.add(when: 'CONFIG_ECCMEMCTL', if_true: files('eccmemctl.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pmu.c', 'exynos4210_clk.c', 'exynos4210_rng.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_ANALOG', if_true: files('imx8mp_analog.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_CCM', if_true: files('imx8mp_ccm.c'))
+system_ss.add(when: 'CONFIG_IMX_RNG', if_true: files('imx_rngc.c'))
 system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx25_ccm.c',
   'imx31_ccm.c',
@@ -73,7 +74,6 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx7_gpr.c',
   'imx7_snvs.c',
   'imx_ccm.c',
-  'imx_rngc.c',
 ))
 system_ss.add(when: 'CONFIG_MAX78000_AES', if_true: files('max78000_aes.c'))
 system_ss.add(when: 'CONFIG_MAX78000_GCR', if_true: files('max78000_gcr.c'))
-- 
2.56.0


