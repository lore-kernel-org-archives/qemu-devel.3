Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8839FCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 07:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMX5-0002Pw-80; Wed, 07 Oct 2026 03:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEGQI-0003Pu-6z
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:26:34 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEGQ9-0006ak-T6
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:26:17 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6af9befd04cso4874278a12.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 18:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791336235; x=1791941035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v1hlWCjEXq2Rpv8CcWewbOeohwMMSFMs5Fi76JDaHOM=;
 b=HDfW4LgZN68/hy04Z45uePTxn2Hf5CvV24YS4W6QQkhcyltukcda0oUoegnkSKxJdv
 EdMuzrtF72pl7RTAzCyOSngDV/iYiSmA1RQMKvRJMo6EGoRs+chF0bkZLHGm3mpMZypD
 p2Z0yKLPUixbhV0R5FIukSoIXi/LENYg7KUq+9pdRfIi7YZx0dwvxfyY/638UVNUcRmm
 272g9FA4XDXdZ8cbrTPIP/pEkYrJu7ITXM0/LnzFFUviT5ElovgtUwXlCixhytqXXN7E
 97dm6UHFZZ7acVFV2Uh4EBnWeRlslTRHRfLrV/rHpM4Nm8nSjNZ6nd9EfsjXh2QNuA0n
 VCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791336235; x=1791941035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v1hlWCjEXq2Rpv8CcWewbOeohwMMSFMs5Fi76JDaHOM=;
 b=pbsMJpFHUok9W6O8m4Z/gKdMhOpGW7r9ExUzQQ5x3CoWmkhOsQDnZJ7mc0zNShvKhr
 8o7cDCvXl7UrAypxW5MAZfrUoYRPpn8piGshkUNAcN3v1BJfztnnEcF0VLOuHIk0yUsa
 brYjaIYH7PmCeZ2ecaPB8rW+z5a7dMqGFwF5d9SL1TwVyzDCnORjwIKgeW5tLQCubrhn
 WS3RNpGWPyGPBXIOMNYs9IfzbyZgfFAB8oxSCNgoYwqJ5EK8tY0Bla9fF+FwE+9pIEN4
 rF1hLTCghzTvzqWS/w98/Nx8uBz+zWX0N4RDypV0MLcDrhnmDxiQHamsID+fmvd2I26I
 UrMg==
X-Gm-Message-State: AFq9FYIW1LYZdPJBnsZ9r5qZFsKLW70Q6g2QxeEnCuImuWRQp9DTQfNU
 MCYY/TQt+aYrlFAEYknbcPYSOaIQRrLdi9CnCvP9tLf5eJFx1wb4wPMJOtRNRg==
X-Gm-Gg: AYBFou0EW4fGnzLrJYXuV08vpVqZuv+PlEXQWkvEcgA/lf6IIUjSCdvb4IrSk4xFYLU
 usV7Hne/Q/JY8HPNOmpKTUXbihaZ/b9In6oqe/aOUTvtH5ZkmRhEOXGnQU9jIFQOyEXu7Ks/mOL
 5VhjbIID0TZ00ICleWOwdvpqQxhZkPWU+NXFfRjmfqXFHmg/b/MYBtKKDy1zjCliJxj/xxCTM+M
 5u501k4iRGud/T4ZIE6adECx7D/Xo3ixBUiMya9suYs7Dv/PvF26uRS/WAP5yCQITuoFogvJL/p
 QfzT+72ITckuZQZrHnRviZ5+mt+DmI8qXN30sf4QLohELWGFXK/eM4iNe7UcOphcrhqxseZOVR1
 yV9K/E+xqg8IUw3eNYvf0zFobvCq2/b+VBKYxDhGdgP5bLw2OXZGNS/lY2mzMtuoXPAJGmVVJwo
 NkItZHHm3jUaNlhIBQ8mp+xY6PK4+gpPKPskJd9ska9ws5sVdpTYwFcpUJY6TvjR7XGx2LpvWRb
 Eq3QNz8mFjh0BtYCQuA3G+nD7LeDtv9wwqY+g==
X-Received: by 2002:a5d:5f09:0:b0:48a:f464:2cc5 with SMTP id
 ffacd0b85a97d-48c4800d152mr18207837f8f.37.1791275748380; 
 Tue, 06 Oct 2026 01:35:48 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:47 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 23/31] Kconfig: Extract config FSL_IMX7_SNVS from config IMX
Date: Tue,  6 Oct 2026 10:34:35 +0200
Message-ID: <20261006083445.30362-24-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
config FSL_IMX7_SNVS to eventually eliminate config IMX.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig      | 5 +++++
 hw/misc/Kconfig     | 3 +++
 hw/misc/meson.build | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index edd3bf0dc9..8d857d8bd1 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -506,6 +506,7 @@ config FSL_IMX6
     imply I2C_DEVICES
     select A9MPCORE
     select FSL_IMX6_SRC
+    select FSL_IMX7_SNVS
     select IMX
     select IMX_FEC
     select IMX_I2C
@@ -581,6 +582,7 @@ config FSL_IMX7
     imply I2C_DEVICES
     select A15MPCORE
     select FSL_IMX7_GPR
+    select FSL_IMX7_SNVS
     select FSL_IMX7_SRC
     select PCI
     select IMX
@@ -600,6 +602,7 @@ config FSL_IMX8MP
     imply PCI_DEVICES
     select ARM_GIC
     select CAN_FLEXCAN
+    select FSL_IMX7_SNVS
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select IMX
@@ -625,6 +628,7 @@ config FSL_IMX8MM
     imply PCI_DEVICES
     imply I2C_DEVICES
     select ARM_GIC
+    select FSL_IMX7_SNVS
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select IMX
@@ -664,6 +668,7 @@ config FSL_IMX6UL
     imply I2C_DEVICES
     select A15MPCORE
     select FSL_IMX6_SRC
+    select FSL_IMX7_SNVS
     select IMX
     select IMX6UL_LCDIF
     select IMX_FEC
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 193a6b5f56..4d47de6a02 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -103,6 +103,9 @@ config FSL_IMX6_SRC
 config FSL_IMX7_GPR
     bool
 
+config FSL_IMX7_SNVS
+    bool
+
 config FSL_IMX7_SRC
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 477fbd60fa..48c5c20455 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -62,6 +62,7 @@ system_ss.add(when: 'CONFIG_ECCMEMCTL', if_true: files('eccmemctl.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pmu.c', 'exynos4210_clk.c', 'exynos4210_rng.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX6_SRC', if_true: files('imx6_src.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX7_GPR', if_true: files('imx7_gpr.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX7_SNVS', if_true: files('imx7_snvs.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX7_SRC', if_true: files('imx7_src.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_ANALOG', if_true: files('imx8mp_analog.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_CCM', if_true: files('imx8mp_ccm.c'))
@@ -72,7 +73,6 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx6_ccm.c',
   'imx6ul_ccm.c',
   'imx7_ccm.c',
-  'imx7_snvs.c',
   'imx_ccm.c',
 ))
 system_ss.add(when: 'CONFIG_MAX78000_AES', if_true: files('max78000_aes.c'))
-- 
2.56.0


