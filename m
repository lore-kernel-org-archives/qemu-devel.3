Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7F4C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 19:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqzS8-0007GR-B4; Sat, 08 Mar 2025 14:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqzRp-0006v1-B8
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 14:02:57 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqzRm-0003Xk-Jt
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 14:02:57 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43bcbdf79cdso17540975e9.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 11:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741460572; x=1742065372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rwn/2OdTxyJUqPr5de1XSt+8TC9K6iNWTaYptctiUL8=;
 b=uFpRKjcP0F7KDQpED6S4oCH1nXRsUpCgwtB20MWKfLPiZ+CtcPs0cNZStInHZGfSWX
 vCa0Lt2pWPsPAbszlRIId1blXeAkSKl/6wBQMx2K5BW8ScOdOGQtqcQpzRBUwcbmYSNR
 DLDfWm/o17x4QhoF+gm/7rdhWJphfvqP5sb1E+Bf/AuWqyKCZ9o1CjJM5bzVfcAJKZcU
 P9FYerp2Aj/RU6ckSYkh39OOHqoHVS9Sm8SiL7BMasvtdgze03aGLSjkMozhFPU/bvPI
 vpMdAPUw0+4ICYAkdGhuwE28TAQkfmeVhIHcBcd19+GLzFcUcKhCIDD4f9iIb9PyxxTc
 GOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741460572; x=1742065372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rwn/2OdTxyJUqPr5de1XSt+8TC9K6iNWTaYptctiUL8=;
 b=gSfJ7UD9KyWNixN9MaQ46QSr1GkCyJMUXuKe3yYH004tIAWiTZGlFQOAd7D1n34bmA
 J6S/ykF3tbf9QcRicRLvmKsJOclDDQEPh1L/PEKq61N0YPSt3liCL3m0wv55wP2AA2id
 Om0wNhcxGRKiqz0Wo/56gpmInph0j6o5vmQjv9xrBFQYAPI5IhDJbk3OaVAToaDUrt+D
 UC9Bk5Zoe0ck69p7KNe0J6CrZa8LcOAG02E6+fRxZmRv4RfIo1TKlJ2ppAIVGw8KDPJi
 8EsTP9rHEZhck8chnywBKJ+i8vJOCRuGy9B/HfnX57LS5+HqSkpilbywjtJc7igG29tW
 YvpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFrS0fUeh4YnCG1RTgq3JV434T7M8Bjnc6rsGtUSLLRX1m0H5bgpl+0i2+bbzxm+xxIJ4hRD6RQeel@nongnu.org
X-Gm-Message-State: AOJu0YwfjD96VskceX5yomKPX/YtfJRldOG4jBwaimAfeXMCw+4f9kFy
 S3ai8UHfyRwlVRzJziBlEVNXuADBd61VQNcyN5EwYN5fBLeC7BBWs55ZC9oo9mQ=
X-Gm-Gg: ASbGncvS6BudOMLvrvxEnjqRHVG1KkEGoL89xhA052InvMIX1ACWjAExILgdmVhr/Xh
 5vKZ+5mD4TSz1iSUUKLlpphzC3KauUZLfeKZCQ6oUyAfMX4MCGESZJbxP3t7QDP/icc5FYYpC9E
 IKnjfmz+A1J0DtJmJfl42iBTAynUKXyVASWHzH2az5JxDKvrCqtwm9xtBzvCYLtR4br98Ilft7K
 JDTO7LdGKUtQ9apQgih44RtOVX+bLG4ZyxS+4aZgmCgcT+MzvYm3vODCyHG4W2JCGb+5mUQVzho
 gqxEGo/0vSk2GIApNPVWIfC4O/b55bJ7VeRYLABuBrQGvyGimNpZci0aIICN7QK6IREzgT5vkcx
 NFkWbFHqvxrnwuNIm6Jo=
X-Google-Smtp-Source: AGHT+IHA9aGgy87ZOxQZ8nfWhTBOvxlmT3AOKADViBqk+McQirESqbSBossVZSaxui4uX1x/iY4B2g==
X-Received: by 2002:a05:600c:4fd2:b0:43b:d040:3dfd with SMTP id
 5b1f17b1804b1-43c5a631270mr44921095e9.24.1741460571767; 
 Sat, 08 Mar 2025 11:02:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd41c7cc7sm128352975e9.0.2025.03.08.11.02.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 11:02:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>,
	qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 04/12] hw/sd/sdhci: Make I/O region size a class property
Date: Sat,  8 Mar 2025 20:02:22 +0100
Message-ID: <20250308190230.7508-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308190230.7508-1-philmd@linaro.org>
References: <20250308190230.7508-1-philmd@linaro.org>
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

Be ready to have SDHC implementations to cover
a wider I/O address range.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sdhci.h | 1 +
 hw/sd/sdhci.c         | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 0616ce3aa59..2709a7a69d5 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -113,6 +113,7 @@ typedef struct SDHCIClass {
     };
 
     uint32_t quirks;
+    uint64_t iomem_size;
 } SDHCIClass;
 
 /*
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 2b7eb11a14a..59d506cafa3 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1443,6 +1443,7 @@ void sdhci_uninitfn(SDHCIState *s)
 void sdhci_common_realize(SDHCIState *s, Error **errp)
 {
     ERRP_GUARD();
+    SDHCIClass *sc = SYSBUS_SDHCI_GET_CLASS(s);
 
     switch (s->endianness) {
     case DEVICE_LITTLE_ENDIAN:
@@ -1468,8 +1469,9 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
     s->buf_maxsz = sdhci_get_fifolen(s);
     s->fifo_buffer = g_malloc0(s->buf_maxsz);
 
-    memory_region_init_io(&s->iomem, OBJECT(s), s->io_ops, s, "sdhci",
-                          SDHC_REGISTERS_MAP_SIZE);
+    assert(sc->iomem_size >= SDHC_REGISTERS_MAP_SIZE);
+    memory_region_init_io(&s->iomem, OBJECT(s), s->io_ops, s,
+                          object_get_typename(OBJECT(s)), sc->iomem_size);
 }
 
 void sdhci_common_unrealize(SDHCIState *s)
@@ -1621,11 +1623,14 @@ static void sdhci_sysbus_unrealize(DeviceState *dev)
 static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    SDHCIClass *sc = SYSBUS_SDHCI_CLASS(klass);
 
     device_class_set_props(dc, sdhci_sysbus_properties);
     dc->realize = sdhci_sysbus_realize;
     dc->unrealize = sdhci_sysbus_unrealize;
 
+    sc->iomem_size = SDHC_REGISTERS_MAP_SIZE;
+
     sdhci_common_class_init(klass, data);
 }
 
-- 
2.47.1


