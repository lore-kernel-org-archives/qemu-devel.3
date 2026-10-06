Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F549CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMz0-000789-G5; Wed, 07 Oct 2026 04:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEHlv-0006V7-BZ
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:52:54 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEHln-0004NF-Rl
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:52:45 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c2e36c3478aso526736266b.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 19:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791341329; x=1791946129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2POO+zmmYLMLNsY6JSlYSICDdx6pDkycub/bJgHUMdI=;
 b=W6LCsselx4jiEkaXEw8B3rZ3UrclMe+iZK/V/yPRKcEA1Zix4IkRYYsTh5NBwRMj3z
 6WgOFx1+h/Bbzbxs2YNdS3EBSqDoxDwXSqZbSwNjHId8yiMb4af/LSfoC5xU6hoVF4f+
 0t9b4VY1G7w/bX6uE7H7RI1M3LzQKaq/erIG3vL0Nsjhrp/iFq/v900/y1patVsigQ9I
 t9IuGn5txfVMxUXvUFlDAey2GkcUzpQ4+PFYV9F/MWmzoD6fhAYu+mSoJhJ+2t7MwzAB
 v/ly/t657syCUnWBDOsBHsRAS6fZh8KthahFL8eQUSnliQAxym6pTQyVAmBPWwB11Wvp
 jJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791341329; x=1791946129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2POO+zmmYLMLNsY6JSlYSICDdx6pDkycub/bJgHUMdI=;
 b=SZpXauquIZhc9QABHu0nIXUywjw3+HsMa36yk+X62w8BLqdH29KOAInbQ4YEHpa+Ij
 PlinPwZXdSRC1E8y8u2PRi1RHJ1IG+loaSWbTtpUJy5Fjx0jupWtWIx2Wpxu8YP62n/3
 5MdvxbzFBawh7R4H+x1yU2Tv/12q1cS+eRojiOLtb+wPzj0hOt/ZDIrf1+OvKxO5jiOm
 6gln1CrLlhv6odZ92scCVRqmdZhRJQFnn3/yXLs7SUamhoGgGdYM3Nq5SfG1hpK2vn2S
 Gm/JoNOtjg0laGctK79pYfOqeLbx0QgLgFbVKHc3qPbyZJ1gIr8u485BBylvS7uUZoal
 +Blw==
X-Gm-Message-State: AFuF++nc3iIJMpGw7y3/8hTTVPPDFUUOxqIjjBg0qc/dxOf5Ljru+Af7
 rMhtNrY7W2fTPEdutTDmSpy6eIFadvLjIfR18oQZmqT6G1o7o32PqOPeaFlHPg==
X-Gm-Gg: AYBFou2jrcGpH7hrUhu8Yp9+QmW+FoUQiI+JxaKhY7gIVgtHpYr/xzAKSDU/4Lg0SgJ
 gXW02+SSceEL22MRCTk08xcX1ruzqIGWW4gSGMbpq4cejxOnW6pnoWkRDLrObZQjkzMOPsh9O8/
 HjYFknGhX6SllxY6nqwx7HCIrh5onH8Wqq68uwYE1V92RCOBb3XluGN0kSevJmFDGnveQ3/Tau0
 m6eTj2RaRc/j9P+tEfP0eS2S8Ev2SS6meUhp6swWp6NIMIExzcmKHFN8xVBwRfkJUQk1/+1L5nZ
 kADABKJ1wO2OYKdQhoM6AxRA7c2xcUIsZ40Nr4LapShf/fEV6Mcfb+FpQMGRDiqZME+3HzRlH3J
 iCu4Cap5Dc6XhlHFWr7WqhOzbJ9OpM9n5h0jEJXs3mj+I5RGpMI5L+otOB2tWwdXa8OrXCpYkcm
 X76AaEbipj0E7AnYnDqEtzTYbQQI1X4bh+Xz81H/rXFhR2QDz6jbIlaEOoknBCqTanTGlIouZ2A
 Snsnp71AHr63NgZQgjPiqoYK2O1dr9h/669MQ==
X-Received: by 2002:a5d:584f:0:b0:487:169f:d341 with SMTP id
 ffacd0b85a97d-48c6d15fb11mr1153929f8f.12.1791275751900; 
 Tue, 06 Oct 2026 01:35:51 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:51 -0700 (PDT)
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
Subject: [PATCH v4 26/31] Kconfig: Extract config IMX_EPIT from config IMX
Date: Tue,  6 Oct 2026 10:34:38 +0200
Message-ID: <20261006083445.30362-27-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62e.google.com
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
config IMX_EPIT to eventually eliminate config IMX.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig       | 4 ++++
 hw/misc/Kconfig      | 2 --
 hw/timer/Kconfig     | 5 +++++
 hw/timer/meson.build | 2 +-
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index cb6e7056a5..1d3026dea9 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -482,6 +482,7 @@ config FSL_IMX25
     select FSL_IMX25_CCM
     select IMX
     select IMX_AVIC
+    select IMX_EPIT
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
@@ -499,6 +500,7 @@ config FSL_IMX31
     select SERIAL_MM
     select IMX
     select IMX_AVIC
+    select IMX_EPIT
     select IMX_GPT
     select IMX_I2C
     select WDT_IMX2
@@ -513,6 +515,7 @@ config FSL_IMX6
     select FSL_IMX6_SRC
     select FSL_IMX7_SNVS
     select IMX
+    select IMX_EPIT
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
@@ -682,6 +685,7 @@ config FSL_IMX6UL
     select FSL_IMX7_SNVS
     select IMX
     select IMX6UL_LCDIF
+    select IMX_EPIT
     select IMX_FEC
     select IMX_GPCV2
     select IMX_GPT
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index a2095d64ae..dbdef58505 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -91,8 +91,6 @@ config ECCMEMCTL
 
 config IMX
     bool
-    depends on IMX_CCM
-    select PTIMER
     select SSI
 
 config IMX_CCM
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index 49a4d20e55..e098376d40 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -23,6 +23,11 @@ config I8254
     bool
     depends on ISA_BUS
 
+config IMX_EPIT
+    bool
+    depends on IMX_CCM
+    select PTIMER
+
 config IMX_GPT
     bool
     depends on IMX_CCM
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index 477dd47486..e2bcdbdf65 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -15,7 +15,7 @@ system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pwm.c'))
 system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_gptimer.c'))
 system_ss.add(when: 'CONFIG_HPET_C', if_true: files('hpet.c'))
 system_ss.add(when: 'CONFIG_I8254', if_true: files('i8254_common.c', 'i8254.c'))
-system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_epit.c'))
+system_ss.add(when: 'CONFIG_IMX_EPIT', if_true: files('imx_epit.c'))
 system_ss.add(when: 'CONFIG_IMX_GPT', if_true: files('imx_gpt.c'))
 system_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_gictimer.c'))
 system_ss.add(when: 'CONFIG_MSF2', if_true: files('mss-timer.c'))
-- 
2.56.0


