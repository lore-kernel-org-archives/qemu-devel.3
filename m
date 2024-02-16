Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88E2C48BEB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raw0V-0006Q4-8T; Fri, 16 Feb 2024 06:03:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw0T-0006O1-Qr
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:03:50 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw0O-0000ra-SB
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:03:49 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4121a8635a2so12177345e9.3
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708081422; x=1708686222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kkGLYDX+GSE+ZJ9BSh+2Q16g0HNqBL3+uba9nDXc65E=;
 b=Qnm1dp3sycbUkM+tBK1UduQ6hTzF0RbdoXxMESGYgym/1Aa2naOY1aL2YYD32XicXv
 hOmC0FtBDCr42KliVaKivFtoIaMa53uaG+y3Q+TtpdublYzgKaSkfebOGAtZJV/Pt8gl
 DNIinS7b/JGDKlw9PEqXmbYyYFri5td98f97rS2wxzOMVrG2aDIVyVNLKahBVbe7R8Jo
 PJMHoAs5dSCCgTdy+53XsNRir+cE9BNuo5nR6dF0/LUGKKPuQDlCbD88ssBwmsiH9iTT
 acKTyG7g6zyMc1ShyhpeClrdUAUvtEpgA0Uvj4cDzsNuXrk1F3eGz94r79+7FGUqWjnw
 olgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708081422; x=1708686222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kkGLYDX+GSE+ZJ9BSh+2Q16g0HNqBL3+uba9nDXc65E=;
 b=nh6VAnCSnKXPHKt6EvJHkDaHpzzkADzg975nQDZUkq1dYBqx/wJRWRWW19NwPVQF9a
 LyZmveQhXa1f92jEuMjLibmNDFRGpxxro/2cafICUuNHIgHHu3r0Rk+xp7dVo406TWb0
 jQJcE/ByU4jF8baItAtYxS+gv+vRNd7oousoVnBa/+s5xCguebLssr8VDWwDj56F8bzF
 paj1F8/D/lDntHU0dqPyWK+E4MPWKmwijnLjE7De2tjK8ewMkrvVe8NhQ06c529VwOeP
 gZmBDlyMi6QVj/FmNvFrSUbLonRVY52DYcEzUodxrJjT+TRO2X3v196TmBR+SbyXsLFm
 omTA==
X-Gm-Message-State: AOJu0YyhIwW3bdqDhhKHc1TyifzVJ1SKczl4cVuyyZrLl2s//4bA2wLG
 KZkN10hScS7Rbtfr7FChAABAuLgfFpy50k7ee4j8Ootk6kovM0w4z34ItSEvMGMl5JhcxCf4EHc
 V
X-Google-Smtp-Source: AGHT+IEZtXhf8DnUedrxCBZXX4R63+iEsHeBn/ZvgaRaXofB08nnvTVWshhe5uqwoszWqRVn4xPqEA==
X-Received: by 2002:a05:600c:1c9d:b0:412:3c20:5c67 with SMTP id
 k29-20020a05600c1c9d00b004123c205c67mr1395904wms.39.1708081422054; 
 Fri, 16 Feb 2024 03:03:42 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 jn4-20020a05600c6b0400b00411b7c91470sm1942118wmb.12.2024.02.16.03.03.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 03:03:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PATCH 04/21] hw/tricore/testboard: Use qdev_new() instead of QOM
 basic API
Date: Fri, 16 Feb 2024 12:02:55 +0100
Message-ID: <20240216110313.17039-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216110313.17039-1-philmd@linaro.org>
References: <20240216110313.17039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Prefer QDev API for QDev objects, avoid the underlying QOM layer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/tricore/tricore_testdevice.h | 3 ---
 hw/tricore/tricore_testboard.c          | 4 +---
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/hw/tricore/tricore_testdevice.h b/include/hw/tricore/tricore_testdevice.h
index 8b4fe15f24..2c57b62f22 100644
--- a/include/hw/tricore/tricore_testdevice.h
+++ b/include/hw/tricore/tricore_testdevice.h
@@ -25,12 +25,9 @@
     OBJECT_CHECK(TriCoreTestDeviceState, (obj), TYPE_TRICORE_TESTDEVICE)
 
 typedef struct {
-    /* <private> */
     SysBusDevice parent_obj;
 
-    /* <public> */
     MemoryRegion iomem;
-
 } TriCoreTestDeviceState;
 
 #endif
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index b6810e3be0..c29db8b451 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -89,9 +89,7 @@ static void tricore_testboard_init(MachineState *machine, int board_id)
     memory_region_add_subregion(sysmem, 0xf0050000, pcp_data);
     memory_region_add_subregion(sysmem, 0xf0060000, pcp_text);
 
-    test_dev = g_new(TriCoreTestDeviceState, 1);
-    object_initialize(test_dev, sizeof(TriCoreTestDeviceState),
-                      TYPE_TRICORE_TESTDEVICE);
+    test_dev = TRICORE_TESTDEVICE(qdev_new(TYPE_TRICORE_TESTDEVICE));
     memory_region_add_subregion(sysmem, 0xf0000000, &test_dev->iomem);
 
 
-- 
2.41.0


