Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C0EC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 13:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP0IE-0003Px-3t; Wed, 03 Jul 2024 09:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sP0Hc-0003FS-80
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 09:44:31 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sP0Ha-0005Jj-9c
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 09:44:27 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2ee8911b451so3441991fa.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 06:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720014263; x=1720619063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uCXkuyBkm/Q9MWnM3F9F2k54QT0LMAwCrOCsbWSEZjE=;
 b=p0ImoaOGjds0rybTcJD/nGpCHH6QBN51ZKu/hgJhQMMDyw+1szQK4Tq1hDSPS/VWG9
 XpGLj8qlIEFHwQogu1Q+T3+6maA6t8ENIQclNnmF4bFt0ljH0Pt1cewG19jJtm6pi9eE
 21Pp587590nGXaCVkVJjky/dcY0zyvlCRc/j84iJJGM0llwtCqIKU+kTcSPcaV+jY9HX
 8y1HxMfGZAQBGYHr5A8ueAlqOEO0Bb14m1x2IVPFI/5PcJHo99d1fTeTP0DQ7WL9MH0Z
 0JShd5dIBTt3rv2SBl/g/pGsK4IikD1obxUUUZi6SYL5W+wogK+I55nEAz1i2BkuQGOG
 FcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720014263; x=1720619063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uCXkuyBkm/Q9MWnM3F9F2k54QT0LMAwCrOCsbWSEZjE=;
 b=rpYRaXR5Qn8u+dAerQgJahbYqlQwFIq+6yRsC1WF9wrKGwziObTUqpyYE0mU9h/0B6
 QD5d6a1bHQ5oXTT9/fjuvLAYQ/6+Iuz9Z4UYA0s/eez4UjH6u91Vrt5ruSHBIC+IHPuZ
 JhvufOJf8qMqCDdjXREd5+RjFPPL7k3TTd7/CxAUyjz+ISv6NMSjLyS2Q/t9OBOaFQbQ
 3Yp5RIPQf05Hc7vgAghRvgZFkbcIM3lS9RXAd0vYoZXp0I2sbk+a7X5IU+dbBiReeveT
 b2K1tgJNiF2fvE2Tfag24Xnj27bMWLAKdIUCAUneTmHhtpV08GAvmEBP/vlXzejwZ2Xo
 PDgQ==
X-Gm-Message-State: AOJu0YzM0ujhuzOu8LywbFmfd2TNmOKvB5gs56oHTbox82tlcTPaN0v4
 pgzm/hnIyp0uI7hWfapHtMxVuAfZsZnNzU0d/83wYK4wdZAr1i5BV9ogArNXwaEQOI78ejTy+hZ
 /
X-Google-Smtp-Source: AGHT+IHRXSOa5ydgTUtQzAV5bTn6jAiy8z//xNgoeSJsqoy6U3Up2a2cEiOPNPsqQ7CuO51GynCXZg==
X-Received: by 2002:a2e:8958:0:b0:2ee:854f:45be with SMTP id
 38308e7fff4ca-2ee854f46eemr11466191fa.12.1720014263227; 
 Wed, 03 Jul 2024 06:44:23 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36798e435c3sm35788f8f.72.2024.07.03.06.44.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Jul 2024 06:44:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Luc Michel <luc.michel@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v46 4/5] hw/sd/sdcard: Introduce set_csd/set_cid handlers
Date: Wed,  3 Jul 2024 15:43:55 +0200
Message-ID: <20240703134356.85972-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240703134356.85972-1-philmd@linaro.org>
References: <20240703134356.85972-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In preparation of introducing eMMC support which have
different CSD/CID structures, introduce a pair of handlers
in SDCardClass.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sd.h | 2 ++
 hw/sd/sd.c         | 7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 29c76935a0..bfbc83c110 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -128,6 +128,8 @@ struct SDCardClass {
     void (*enable)(SDState *sd, bool enable);
     bool (*get_inserted)(SDState *sd);
     bool (*get_readonly)(SDState *sd);
+    void (*set_cid)(SDState *sd);
+    void (*set_csd)(SDState *sd, uint64_t size);
 
     const struct SDProto *proto;
 };
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 10f2764a53..d46be50760 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -689,6 +689,7 @@ static inline uint64_t sd_addr_to_wpnum(uint64_t addr)
 static void sd_reset(DeviceState *dev)
 {
     SDState *sd = SD_CARD(dev);
+    SDCardClass *sc = SD_CARD_GET_CLASS(sd);
     uint64_t size;
     uint64_t sect;
 
@@ -709,8 +710,8 @@ static void sd_reset(DeviceState *dev)
     sd->size = size;
     sd_set_ocr(sd);
     sd_set_scr(sd);
-    sd_set_cid(sd);
-    sd_set_csd(sd, size);
+    sc->set_cid(sd);
+    sc->set_csd(sd, size);
     sd_set_cardstatus(sd);
     sd_set_sdstatus(sd);
 
@@ -2485,6 +2486,8 @@ static void sd_class_init(ObjectClass *klass, void *data)
     sc->enable = sd_enable;
     sc->get_inserted = sd_get_inserted;
     sc->get_readonly = sd_get_readonly;
+    sc->set_cid = sd_set_cid;
+    sc->set_csd = sd_set_csd;
     sc->proto = &sd_proto_sd;
 }
 
-- 
2.41.0


