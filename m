Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F39FC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 20:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tue0S-0007Km-TB; Tue, 18 Mar 2025 16:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tue03-0007I9-BC; Tue, 18 Mar 2025 16:57:24 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tue00-0005ld-Ms; Tue, 18 Mar 2025 16:57:23 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac2dfdf3c38so1118159266b.3; 
 Tue, 18 Mar 2025 13:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742331438; x=1742936238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IM4ZcQUq5MBFapzEpSJQJJhlG2IDJZ/Gi2d4Uwee6ek=;
 b=A8vgcL2Objnq3NXfscVPijfBp9yVHstYaPVkNC0+sOwl49NE3RL00mYOKR+6Egl22V
 B8Tao/IecPoa8/F2tJnyiDhHZv55ebxnig519nEBPERXxgmfgwQ2PYwFAzT5H3DHcKN7
 ZKNJ8rdXffgtYWP1HCftJC20LVn/YCUaBj+Z5maV5rofFYG5uBwhG7Gl+jORSLiA5zS3
 re53qecvkRFRypZs9jd9EabX7FjPUmwL4IyUbBCqMUW2990UgdMniqv+grkhWoEt9FHy
 c526dJhqIfu6gXZGAREsIOlOQ8n7pChXbK1yG/sevd8SIw0CXxpJKWKtiaqHttthWm1U
 mp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742331438; x=1742936238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IM4ZcQUq5MBFapzEpSJQJJhlG2IDJZ/Gi2d4Uwee6ek=;
 b=AmyGdErGrw/C9Ag7lGIF2nhLf8gBohe2RftR4z8J6h1046iP/uwWHrE23hFQFbH4+Y
 dEZq0rjlCX0JbyczJiaqE0MZqHhyWemRWcGAN1Q+/m21ZdVA1o30GtWKzSU/FKdf8oBV
 iTI+o+sb9uhzlb/WRQrZhJZdTsj2xgYzBeKmV9vbNU3uvgwuBHJipAp3UEHLhEDlM0+L
 87rHEZuSrGFNLSnd+2st8p0yc5/gYvUuInVfGr35SzR7PC31b3/VIpIMtGYs9exbqE/W
 0ThD/z5CkDqdz7/LJELuUL416yAVaRzUKXNJ6oXEHcJBqxjSlAkImOE0+Y8kUHRSEoI7
 7FdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlwlODjuQSMqgMhQe/L0shIpmXjuj9YDlPwlPGo4ntuOA+dMtKxs68vNk5XyGQ7he0G1hnX57x9A==@nongnu.org
X-Gm-Message-State: AOJu0Yx3N2QPXHQjj3Rpek+t0aTsSekOQcQGubdbgJfj5gy5ZovxztCj
 6pBy230xr+GjKSaS6JNXnTqm6iPWNMrbd8L/NCU2fGxaf7+FOLIwylGkZQ==
X-Gm-Gg: ASbGncufetebVzZIHibss2QEtZ6KaFSl0JAQJC/uWzroflBXrEAk5Vi7ovi0PIQnmmc
 Gs6yrHPBfYhzRvzQ3BL0ROkAHnC3Gc+iJ9eUi+a18rfOMuodQ4IybJocbF7llsrKH8WCn+N5HbU
 2Lse+4gMJJ+dS9U4Hlx24aJwpr5MJb/SbvFhtRhHCPouvqKL+PzVvQsd3VudvjvdTolsksIXPEX
 GbLHwWqQ3BgY1rG2Vse00Uk03940ppIW6k2yXOUJ4NlrHXWplVkQzrpOdc7r9wMmjGLjO1FJVBJ
 xnFFBuu1fiBAcRILgP0q0EAmrPVuiOivDA/xb9C/TTi9WNVuY90PVGM3dEg4QtHdvUZhs/qRncR
 Iet/sfXy6GFyyZ6QSRa7adi7PvlOuYfnXBUFxz9+iKhFUDZfGItcYrAgz3PcJuHw=
X-Google-Smtp-Source: AGHT+IHdgTFgfZxnQ0vkyo4JzL6PmFRkXZ2pwFEIAr3CwwEGMuftnN+ojRlEUvYrrIfvhABsTjroOg==
X-Received: by 2002:a17:907:3e12:b0:ac2:b086:88d5 with SMTP id
 a640c23a62f3a-ac3b7d9a70bmr8481166b.18.1742331437575; 
 Tue, 18 Mar 2025 13:57:17 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-19c6-0d00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:19c6:d00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3146aed4fsm895944266b.26.2025.03.18.13.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 13:57:16 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/3] hw/arm/imx8mp-evk: Fix reference count of SoC object
Date: Tue, 18 Mar 2025 21:57:07 +0100
Message-ID: <20250318205709.28862-2-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250318205709.28862-1-shentey@gmail.com>
References: <20250318205709.28862-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
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

TYPE_FSL_IMX8MP is created using object_new(), so must be realized with
qdev_realize_and_unref() to keep the reference counting intact.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/imx8mp-evk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index e1a7892fd7..e1a21e52f9 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -37,7 +37,7 @@ static void imx8mp_evk_init(MachineState *machine)
     s = FSL_IMX8MP(object_new(TYPE_FSL_IMX8MP));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
     object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fatal);
-    qdev_realize(DEVICE(s), NULL, &error_fatal);
+    qdev_realize_and_unref(DEVICE(s), NULL, &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX8MP_RAM_START,
                                 machine->ram);
-- 
2.49.0


