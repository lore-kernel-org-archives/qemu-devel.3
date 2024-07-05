Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFC9C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 22:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPr47-00067q-1d; Fri, 05 Jul 2024 18:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr43-0005pJ-RL
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:05:59 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr42-0007la-7K
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:05:59 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-36786081ac8so1222402f8f.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 15:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720217156; x=1720821956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T4UAMy7AOQu07GDl9UFhL5hUw6gaC2lnWy/fQbMyhnE=;
 b=tJQUXmLpIHusjrVWHM8uyRxrT1GtqSvO5vNBs/9sZEKiTHD30Hyxblafeha4a0Negf
 pgu4VcnBmFliGS3zNk+3rlQjEP95ntz2VUlAS6yxEVXE+ME8KTKKzSQCIkrL4K4v8EZZ
 wsHoWiY7rGtEQ76pG0DWTHUcrrvE1n7U/LJYRCgeM8ScZJD5cnrCXxKs5zHwrp++tjt0
 yoAzahpdDm+4dmPU4qzYn/xJhlT1eVBjZ/FjHV7IKu92bPoJJH+V2wyNnbF2EIFJRnPZ
 FYlU6sfK1EINpEZQ4R4tubJ5A7gL8fat4cW+hbDFxYYB7iJMMhY2JocrilVTpwrYc+IF
 BFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720217156; x=1720821956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T4UAMy7AOQu07GDl9UFhL5hUw6gaC2lnWy/fQbMyhnE=;
 b=GxryvWWMAH1uRV4MIsaLrekZ273vSBfW9v/YokHKaWE+tysmQslLjR/B5ioCcdU1Un
 JwVJIdYnpWMBbZ4GTczppzIZ+7Cdh5V1aFbfBHDNJGhwfCgvHq9+Wii6a/37lotx5+++
 Knob5CtANy1uyrjdGdO20IvUv1xvb+bTl3KWj6h9xJqlsxMD5ZkKhDMfqJgIZ2mpii4H
 65111uCnK9mbgKp7iYXAVJw+3PfzuV7xR8tSTwvbHgJVS/LeXI1SaljcPIfGct2pstsI
 AVTJxhxD8NVpoh45AFFnHrDm1kb4vQfxPn5RLP/ZqZKKu/Q/A14a9Y0qOoLjboynyHBL
 cRpQ==
X-Gm-Message-State: AOJu0Yyt9BguTa47liHJ3xU1sEWunIcuwIna03c3ILVG7WFBocwtHmlE
 njlHCVAaYPZHehZiOanwrCY/8AcJ8vAIaiDvMhJS772sn+rJ/rI8B+4rAbr+BWVQ9VTJjETKoqi
 L
X-Google-Smtp-Source: AGHT+IEbSbHs6FLAUT4lcY1N7TQNemYeWAUQRZ2hIRCUHidqTPLuAm0J2zT/EMxySSD0Dhajx3al0w==
X-Received: by 2002:adf:a1da:0:b0:367:4dd7:288b with SMTP id
 ffacd0b85a97d-3679dd34fe1mr4351503f8f.29.1720217156537; 
 Fri, 05 Jul 2024 15:05:56 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367a494e7a1sm3353630f8f.112.2024.07.05.15.05.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jul 2024 15:05:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PULL 15/16] hw/sd/sdcard: Introduce set_csd/set_cid handlers
Date: Sat,  6 Jul 2024 00:04:33 +0200
Message-ID: <20240705220435.15415-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240705220435.15415-1-philmd@linaro.org>
References: <20240705220435.15415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

In preparation of introducing eMMC support which have
different CSD/CID structures, introduce a pair of handlers
in SDCardClass.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-82-philmd@linaro.org>
---
 include/hw/sd/sd.h | 2 ++
 hw/sd/sd.c         | 7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index c1a35ab420..0d6d9e452b 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -127,6 +127,8 @@ struct SDCardClass {
     void (*enable)(SDState *sd, bool enable);
     bool (*get_inserted)(SDState *sd);
     bool (*get_readonly)(SDState *sd);
+    void (*set_cid)(SDState *sd);
+    void (*set_csd)(SDState *sd, uint64_t size);
 
     const struct SDProto *proto;
 };
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ecb1b2f405..058a70a0f8 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -680,6 +680,7 @@ static inline uint64_t sd_addr_to_wpnum(uint64_t addr)
 static void sd_reset(DeviceState *dev)
 {
     SDState *sd = SD_CARD(dev);
+    SDCardClass *sc = SD_CARD_GET_CLASS(sd);
     uint64_t size;
     uint64_t sect;
 
@@ -700,8 +701,8 @@ static void sd_reset(DeviceState *dev)
     sd->size = size;
     sd_set_ocr(sd);
     sd_set_scr(sd);
-    sd_set_cid(sd);
-    sd_set_csd(sd, size);
+    sc->set_cid(sd);
+    sc->set_csd(sd, size);
     sd_set_cardstatus(sd);
     sd_set_sdstatus(sd);
 
@@ -2475,6 +2476,8 @@ static void sd_class_init(ObjectClass *klass, void *data)
     sc->enable = sd_enable;
     sc->get_inserted = sd_get_inserted;
     sc->get_readonly = sd_get_readonly;
+    sc->set_cid = sd_set_cid;
+    sc->set_csd = sd_set_csd;
     sc->proto = &sd_proto_sd;
 }
 
-- 
2.41.0


