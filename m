Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA22BCA5FFF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfpV-0005j1-UI; Mon, 05 Oct 2026 06:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmZ-0002IB-17
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:59 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmX-00010x-8y
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:54 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48b06bb6e40so1202265f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791195532; x=1791800332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MewfHFxCBjuMnAba+cWeGMRb7nH3xWgUzUxej45VPmE=;
 b=NlJUQ/IlqKywo2V8QRnGgskJg05UCUTnOxRYR8nySse7WZ6I0xIELJ2R3T5A8Zl34r
 +yS3DswCDNltTRPP1CDAY9LjG7SWbr9coIzVQxiScTTEgxGtU7KUV74yIkEoSeBtzMsG
 4dkB5D2toUFEfqsTXkvNmudyYQBk9M/d28KYZqpy8mdUhg1WA5y0511y6UKjn5WFt41W
 q1h5hw0wcpYbDLuIA2W1sdvl27SJNsBRGJbkpo/xJ4FtOBMXJ32TWjgg4x/HheJPiL5Q
 1JjvBWFpRTaL/06igQRJ6vYZj/UYg11o0x/OQ0f8+cCqvfzsSiM5C9jNuXItt3uXeETP
 3jGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195532; x=1791800332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MewfHFxCBjuMnAba+cWeGMRb7nH3xWgUzUxej45VPmE=;
 b=evrX/PaLKqJs23Xu/r7M7+LzD5d8aCpHWM0+Gfvj28wt7BiXTC/0KNOwiG+gVJL8Gz
 LITY8zcTteUh8CMhTsSNda9nzugwN9b9D6Pij6h1uD6x89BsZqatY2TNaHmYciTwKEde
 ad5+Vp3+dev0GISFnAik/vyraSjvH5C3hzq/wTpFpN3KFzohLf6qlazG5qJu9XJGBWaB
 T82qPB+hG5lKIp5mQVBlmtch+Bd4oIbw5kiHuBUyLpTxljbA3cvTCAfoBByTYKm5voms
 c+w68uwYzxCDw1myW6kmaLC1bOcdSvqUr+AyI4fzRvrjHDrQhuod5oRMXXfqm7l9Ct2Y
 OyKw==
X-Gm-Message-State: AFq9FYKQdBKXmLhuVo283dA1ctx9BrfKypclkY71vemjUtzGHTHGPeXH
 nZsPIU50hTOKdWpGcghPpL1/mDYsk8l0LV0y5RP5PAfQSBGreI4sV7MzWnilTw==
X-Gm-Gg: AYBFou3xwF6eZgERI/i/2132LGn7e5cEcSo1ropkkkuGjJw0cXo0z3W4cB3vknvcPdM
 kNhJi3L0ygna32HGN/fNOWtSM++py/+DNqiEJDJQLLIuev7afcd71Wfvp+9jQKXZMXdIKn+Dm/I
 cqOHqYvQzZ2b+has1CSQv42kZju2snkh+AWjwFQPvF6cNcVSJXM53vOzObU3sIQjKRwuDrlpk5+
 5OEy1X2pnt20ZFxJRKMw41mzRPBTJTQ7RWxCavp/sKnZzSWgoOkxlmY+TrC4XxrrI0+jz6IF67g
 GV2MUgZqBkrXetSFcJ+/sFC5Qf1DP/oSfiWK7VSjIvQvLQYDsfsZCsNF03zq0IKPiGp5UzZ8zug
 D1tKxR/MXfUdI5ebmnZ4OaYlYyiqXzkP7LM4qr4wnIDILTbLD4CFVnwQaLqziLx+OdACfR+l8tU
 HOcO4gu82rsvX9tysb8YJRuXIKe229V7ymAiJzfpiUHKqwg0RMrnVGYtkyrGU8jFo39OLt6vbQ5
 KQbqhbDeB/OPF5oelNPpZS9fYUl1RtpPM/rQ3g=
X-Received: by 2002:a05:6000:310d:b0:48a:eeb7:5e5c with SMTP id
 ffacd0b85a97d-48c47fdf4dbmr11693946f8f.32.1791195531619; 
 Mon, 05 Oct 2026 03:18:51 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm2742111f8f.37.2026.10.05.03.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:18:51 -0700 (PDT)
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
Subject: [PATCH v3 21/31] Kconfig: Extract config FSL_IMX7_GPR from config IMX
Date: Mon,  5 Oct 2026 12:17:48 +0200
Message-ID: <20261005101800.10821-22-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005101800.10821-1-shentey@gmail.com>
References: <20261005101800.10821-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x436.google.com
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
config FSL_IMX7_GPR to eventually eliminate config IMX.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig      | 1 +
 hw/misc/Kconfig     | 3 +++
 hw/misc/meson.build | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 2084813e1c..51fa2e2ee4 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -579,6 +579,7 @@ config FSL_IMX7
     imply TEST_DEVICES
     imply I2C_DEVICES
     select A15MPCORE
+    select FSL_IMX7_GPR
     select PCI
     select IMX
     select IMX_FEC
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 3f17d29053..cf9ea68219 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -97,6 +97,9 @@ config IMX
 config IMX_RNG
     bool
 
+config FSL_IMX7_GPR
+    bool
+
 config FSL_IMX8MP_ANALOG
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 61e128ab7a..c31c173e5a 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -60,6 +60,7 @@ system_ss.add(when: 'CONFIG_AXP2XX_PMU', if_true: files('axp2xx.c'))
 system_ss.add(when: 'CONFIG_REALVIEW', if_true: files('arm_sysctl.c'))
 system_ss.add(when: 'CONFIG_ECCMEMCTL', if_true: files('eccmemctl.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pmu.c', 'exynos4210_clk.c', 'exynos4210_rng.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX7_GPR', if_true: files('imx7_gpr.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_ANALOG', if_true: files('imx8mp_analog.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_CCM', if_true: files('imx8mp_ccm.c'))
 system_ss.add(when: 'CONFIG_IMX_RNG', if_true: files('imx_rngc.c'))
@@ -71,7 +72,6 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx6ul_ccm.c',
   'imx7_ccm.c',
   'imx7_src.c',
-  'imx7_gpr.c',
   'imx7_snvs.c',
   'imx_ccm.c',
 ))
-- 
2.56.0


