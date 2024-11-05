Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B086D3E779
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SMT-00073U-0k; Tue, 05 Nov 2024 17:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SM1-0006SG-PN
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:48:53 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SM0-0004IY-6t
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:48:53 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37d462c91a9so3532446f8f.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730846930; x=1731451730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91J1Pmqo5K4jBxzGOzPgUYEJwXRFG7jqGcshP1OZFFs=;
 b=GmHZ3gN2plB58Y59W26nKsE5LnzvE6AsLtRpn5t2H+0iPnY2FMxzZ6aTUP9PZwivnq
 obuMDDTNyTgN7YaiZGCCGSoC+3c2q45U7KsIWVOmXZiYqp1yswpMa3mxpEJshsRRr4EY
 jEmKSypHeNsM2TAclAYoVqeafdQd409zdsS2x8x3dtZ3kVwjoSogpDqKX8f58ZJQs0Ey
 cTpa0WVh2ItagUbCEa2f2RcuRvq9CkAP3np6anYTpR/SuU6cab/6TFfqx5/4+mcrG64c
 LgWC7UGD3Yy79FrSa+7JWb/tjlCKnvH+eoJKnfbP6FGUUvIOB8MVItLmbHo/Jw6GcbHP
 KUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846930; x=1731451730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=91J1Pmqo5K4jBxzGOzPgUYEJwXRFG7jqGcshP1OZFFs=;
 b=Ep+u7dTkYRUuyOQZLZTAFHUYWGUZiPRgXOLZSmfrQikfoCJlfLFDNECVajjNUExTK4
 zJ5KuECFwGA/1RYzkpCKhL9aECcWuqjsnO2Y7I1w9RNYHmmZ1I/z5RIiMa44GU1MBOVi
 of2ARNI8IfORNbrb1ntmMT09EvmKvQJ5Mrp0NW8DqIbYcUXlOVvrJFlTDY6xELdYhtQa
 F8zdysC1oDx+qvNJA8pJC6O92aHHvQIwHkvOLE0xNmgIqPv981+qyymjxEyOtTkw/AgC
 UzigKddMo06MO+07uBG4ZLsaPGeYwqFUvQ+SQevce0YTAnc3+F2XLQcTBvP4/GY1jUBw
 QYTA==
X-Gm-Message-State: AOJu0YzhN8WcbKBRy35WywSpQeR6uQrG5s4zSncoCBExs6fhDT5n2DDJ
 onQGhFzaYzEjvTJK/JpaYgJXNAeqaoS8QHozfV0CKwgtnAz8sWBRBZVtHze8WVqDkvaXV+9rCcc
 2VlqJoA==
X-Google-Smtp-Source: AGHT+IFIkHO6lS6kvacPLcUi7hzihPQdYqDYKH7CI/SZn04GHJixikybpfASfCmXK7jsFe7YQToxXw==
X-Received: by 2002:a5d:4d82:0:b0:371:8319:4dcc with SMTP id
 ffacd0b85a97d-381b705764fmr19431851f8f.2.1730846930202; 
 Tue, 05 Nov 2024 14:48:50 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7b97sm17588206f8f.2.2024.11.05.14.48.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:48:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/29] hw/ppc/mpc8544_guts: Populate POR PLL ratio status
 register
Date: Tue,  5 Nov 2024 22:47:13 +0000
Message-ID: <20241105224727.53059-16-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
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

From: Bernhard Beschow <shentey@gmail.com>

Populate this read-only register with some arbitrary values which avoids
U-Boot's get_clocks() to hang().

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20241103133412.73536-11-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/mpc8544_guts.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ppc/mpc8544_guts.c b/hw/ppc/mpc8544_guts.c
index e3540b02816..c02b34ccded 100644
--- a/hw/ppc/mpc8544_guts.c
+++ b/hw/ppc/mpc8544_guts.c
@@ -29,6 +29,12 @@
 #define MPC8544_GUTS_RSTCR_RESET      0x02
 
 #define MPC8544_GUTS_ADDR_PORPLLSR    0x00
+REG32(GUTS_PORPLLSR, 0x00)
+    FIELD(GUTS_PORPLLSR, E500_1_RATIO, 24, 6)
+    FIELD(GUTS_PORPLLSR, E500_0_RATIO, 16, 6)
+    FIELD(GUTS_PORPLLSR, DDR_RATIO, 9, 5)
+    FIELD(GUTS_PORPLLSR, PLAT_RATIO, 1, 5)
+
 #define MPC8544_GUTS_ADDR_PORBMSR     0x04
 #define MPC8544_GUTS_ADDR_PORIMPSCR   0x08
 #define MPC8544_GUTS_ADDR_PORDEVSR    0x0C
@@ -75,6 +81,12 @@ static uint64_t mpc8544_guts_read(void *opaque, hwaddr addr,
 
     addr &= MPC8544_GUTS_MMIO_SIZE - 1;
     switch (addr) {
+    case MPC8544_GUTS_ADDR_PORPLLSR:
+        value = FIELD_DP32(value, GUTS_PORPLLSR, E500_1_RATIO, 6); /* 3:1 */
+        value = FIELD_DP32(value, GUTS_PORPLLSR, E500_0_RATIO, 6); /* 3:1 */
+        value = FIELD_DP32(value, GUTS_PORPLLSR, DDR_RATIO, 12); /* 12:1 */
+        value = FIELD_DP32(value, GUTS_PORPLLSR, PLAT_RATIO, 6); /* 6:1 */
+        break;
     case MPC8544_GUTS_ADDR_PVR:
         value = env->spr[SPR_PVR];
         break;
-- 
2.45.2


