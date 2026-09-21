Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA0CC982FA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lrw-0006VD-ET; Mon, 21 Sep 2026 17:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrq-0006Qu-VT
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:06 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrp-0000JX-9h
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:06 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912e4b11so18638615e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027274; x=1790632074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9wbVaDi9cPHpBXocBulirabyxdmxTK1JCWVNnnmNfI8=;
 b=lUuK14Wj0G5/x6Pd3L322fTUmXD+royIk7zll4AfCf1gnXcfvzWNUr4KF/rcTnP746
 X+BYa+DhEotePscPuPZunYpuJky/Yd8QR3koE7+USmdBL2wATuodtu732tztx/3Z7tSx
 EtcijEhjgUYRwzqqtQE2VVqzM+AoypQ5L89g+QReSr/NoqcvbRHnZ+YcX38hU4/EVPBl
 K7nN82S3O07gQR9XauoDxPN+v4e7vLEhONGu//dhCoxpJcucVgPNxHA2Y79Vb1/wQuKC
 I1aAcHcrMD73whE8E5rmQXLkZYMXWeXkeRcV+o+Zn4HJdMTRoMvg47YVwRIlAuoC1oH3
 lKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027274; x=1790632074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9wbVaDi9cPHpBXocBulirabyxdmxTK1JCWVNnnmNfI8=;
 b=y4B7yO0+OF1fM1p/s+q/xwOV0k4+sFgfiEmm/Ih6/MakE+tmJZdxO3LJE9t3AetNHk
 dYmG1M7cibuxXE/eWlRBcTloM5PcQHtTS168eGYccRVCKUpnj/ErjzcWAo5WkHrovTbW
 c/pTac3uwS9UYHAIUuFWt0IHyk7+GBzcgooPUWIDMYPs/ZqtHFLJ5bp9YbjoLAAaxYO0
 6oUtHEoOGYqzAzJOkGRVjHA2EPLQQsL0Lx8uVHIoPkKEyPqtqQqBbuYNGizl9CYapmZk
 Elh2b76Z0DIvM4hCq127xnpqZHY7dics1YUhTfqRLtX0cHwTxmG6XmQeebD9B1T+codx
 L5CQ==
X-Gm-Message-State: AFuF++moI2rKMIAa7b8y6CYZT33y7sHRPXre1VJ9GfhZfhtSqAxHNHzF
 YUoq0ynFro6NH5gxYJTYKRmikTpDB8qjVfrUW9PX8GcIMiZigLifiitXxobb6A==
X-Gm-Gg: AYBFou1mo6PBvOh0EY64lalWY7rRPV8D2RswUWPpb4+FXJbHPL0qbdOkPXqhz8rTk5b
 xutmsIJowO8PJFaetdbduXztmqY7ga5g9hLc6aBnsnnknFr33xwZvYXs9e8tjBczkmwMwixEA9F
 YPh7GYVC8L28cNf0aTUqASMf25UTDEajAW6B0KY/j4I+Gn0+1SsLOqlYws0PB3GrSgGg5owYwHg
 KYZOj00cmwMLkvQHcawaaocq5FUNLY7i1EZ0ZQN/oLrz+d5YMFs9KUHp6uvHOiIB4ZAOawxfGZB
 79nd+64t3lhQOS7L1R9DSIIevZYP2aWsQX2Ni0qcOKTjLBU1WHNqulKBJeACyEX4qNOTCOZkM8X
 uKL4RBeAy52dpcz00wZcVDeDadRp/XF/uvn9NZxDrXvdl1KjwqJ3GBFYyk0F0Yq83zHs+tzXWDx
 5cEizv94DxTUwQtLGMRunnGiZJYlfKWlApCghONAXUPSMwpBcIiJFip3ua8MxmvU7t78VVimpdr
 CtZ+WI2NfgnXoqKbMgB1PAcV+g4sMoUXTPYl1xXLyMY+tj04xqEuGfeUtXsY/3z3EaPA+SdYuMW
 BvM=
X-Received: by 2002:a05:600c:1382:b0:49d:174e:2a1e with SMTP id
 5b1f17b1804b1-49fc574f42bmr164264655e9.19.1790027273921; 
 Mon, 21 Sep 2026 14:47:53 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:47:53 -0700 (PDT)
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
Subject: [PATCH 20/42] Kconfig: Extract config IMX_AVIC from config IMX
Date: Mon, 21 Sep 2026 23:46:48 +0200
Message-ID: <20260921214710.29422-21-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x10.google.com
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
config IMX_AVIC to eventually eliminate config IMX.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig      | 2 ++
 hw/intc/Kconfig     | 3 +++
 hw/intc/meson.build | 3 ++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index ad4b997abb..0b8414501c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -479,6 +479,7 @@ config FSL_IMX25
     depends on TCG && ARM
     imply I2C_DEVICES
     select IMX
+    select IMX_AVIC
     select IMX_FEC
     select IMX_I2C
     select USB_CHIPIDEA
@@ -492,6 +493,7 @@ config FSL_IMX31
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
2.55.0


