Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D8BC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8ls4-0006ZT-30; Mon, 21 Sep 2026 17:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8ls0-0006Xg-QR
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:17 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrz-0000MZ-4h
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:16 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ce364488dso9575455e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027284; x=1790632084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pUNqfWQyBcHI4Skuxk0GX73twtzk8DA0JghFSQZB/HY=;
 b=sofjv0sXbEiQyIdqD/BE/9qdnfdl7Zgp4XgPfdVB7sbmbESOeiUrY/5fZIuTmlp+vR
 HCaRkHTPs+e2pa4/d2+j4R6iHCmud2i9/hffMTKya/EwQy8LHDB/KIxB/iZzgasZU//A
 rEGReTJAwhMxJjmc36Y8HaCNw0fBiPOY8BKDwOzrCtuBUwTBFKK+zDIX8rOS2+blvRtt
 5naPfxOT0625Z72ix07jAhXlE14GMsuEYSMN59zs6R22CWoKIc01TJDFNT2tI0K5zYjt
 RQLfwn7ZtAzvV0LSTRmUwm2CIqD05oQPOWWB/seuG9kAR6gjKqMRaFwoIwDznUeuAJfI
 RHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027284; x=1790632084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pUNqfWQyBcHI4Skuxk0GX73twtzk8DA0JghFSQZB/HY=;
 b=WI/IfxA6MlfxlJAj/J+BWGyokr7/d8N8cRRTVt/QyApdboNbrJYC6WxsPeAFGpvJRk
 b3tyrndt9ZiSvp8HDbaY1mOlOagnKQ8TEIDBlHDTTCBvQ1XpDW0CZ0D2jkhO54YAokPs
 F1NnZ2zSueffKf8PIdkpvsztauyhq6xloxRqTuTusFw2IiYRVDl7ojh38Rv+6JwN333Y
 +soivqe/5mAbdFW5Zwju8Z+Pos1LV1Oj/MHiJHCpurVXzS1KtKnkQ+wSzap4Bcco5ovu
 VJR44BhSQWXiYgI+KbgeIRL0CtqKXORPuqD64C0HPY15iDXhhJY/rY0F2A0U8novcA0t
 u/+Q==
X-Gm-Message-State: AFuF++ma7EAgeO64I0apfgn72ZMi+/9/fweWy14NC0zi3eKISIjJjTjx
 u2+iTqUEWH0PEvmTVVKmPso9rmWpRFUARZ2l7lUh3ZRfUeo1/H/xamHms9QpCA==
X-Gm-Gg: AYBFou3RYK6iP2gAMwMxm+F0Iv6CF8AvQ6+kksQTPsevrbC7R1DqMB4TisH6ayTZe/O
 aNzIf/wRM9W6tGxN+Q4LSTqEdRuD59Gj4tuLnEzoFzFLLkQjbIVSWmls0vD8lKP3XmcptYbn+bw
 K7JAUX48rgEPS7yiJJQ3gZ7SKToDT9URgohEAhWM3VN8AVEoY4jNCmfznYyaFYkSDMO/Mq0Nu2x
 1NqbH+QtM7XtQVEmAz8Arqd6f01AqPhVJMEoavuo9iTgIIi3SMansGP3INMR84O1qcily3oYN9F
 jtncy4nJBoivuwy0jEFwakRdPmP57MW28qQRhtLhfM8NguxMF0hvLq8dbgNr/zRpwCL43igiocL
 08n0v4QoE9zxrvYKbGUKnGYNXZcoHU33T5zS9lbF6MEiadAejfgYzDVxkvq23HzI2pF+QdO3Ydy
 h/ri0Bvl2ANmq7GK8G8JCjQeNXwoIqqCLkSc5vdzjv6oanHs87VEqJhFJFrRwR0P0HIfQC2a3aE
 1zXFrIUvkucbp/bYzvv18dRT3D5eWJacymrg6ZocyXYgQJI1r3Pqe/WqIC3ZVVTrRZ6dUIJlzh/
 MoI=
X-Received: by 2002:a05:600c:4f90:b0:49b:8f5e:51fb with SMTP id
 5b1f17b1804b1-49fd8853515mr15107815e9.3.1790027283734; 
 Mon, 21 Sep 2026 14:48:03 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:48:02 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 28/42] Kconfig: Extract config IMX_EPIT from config IMX
Date: Mon, 21 Sep 2026 23:46:56 +0200
Message-ID: <20260921214710.29422-29-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
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
config IMX_EPIT to eventually eliminate config IMX.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig       | 4 ++++
 hw/misc/Kconfig      | 2 --
 hw/timer/Kconfig     | 5 +++++
 hw/timer/meson.build | 2 +-
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index e7ed5ea680..a2d94e238d 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -481,6 +481,7 @@ config FSL_IMX25
     select FSL_IMX25_CCM
     select IMX
     select IMX_AVIC
+    select IMX_EPIT
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
@@ -498,6 +499,7 @@ config FSL_IMX31
     select SERIAL_MM
     select IMX
     select IMX_AVIC
+    select IMX_EPIT
     select IMX_GPT
     select IMX_I2C
     select WDT_IMX2
@@ -512,6 +514,7 @@ config FSL_IMX6
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
2.55.0


