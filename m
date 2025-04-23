Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1665C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 12:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7YsS-0006tR-TU; Wed, 23 Apr 2025 08:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Yrc-0006bt-Gx
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:06:07 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7YrZ-0000Ri-Bx
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:06:02 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so57327805e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 05:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745409958; x=1746014758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4ABcmb67Z+D6NBbWU+MI+QxoFhkrlR/XebxVhtqvxp0=;
 b=MUI2qZVW0LzgYtXyaUh/TDsidn5b3hvnTnPs2Kf84Cq/Qx60bwvopJZQsuLRv/xtF5
 tdA8dTDvlJzOwowwCR3njhQlgN3MDo9t22mVPOOvXhCAANHPZQaZcYkAdvNiaSazdRB2
 u5FCggAyuyvcDK7U45ngcB3TbSAc+zQng+achX6KYxMQEnFCdMkfrqzJ8yi+v8hl3WzB
 8SPDS4bjidg/NouoEMKEXylPaGGqfT/rffC9UQX4fXHfHJXcHpcOcXH9JU+2EyKEU4gJ
 clSZk/GOskH1QDQqKUhKSnsLPFNS6zTV3wVdht8EtjHofshdsyZyV8prq8qbTuDPomft
 DlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745409958; x=1746014758;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4ABcmb67Z+D6NBbWU+MI+QxoFhkrlR/XebxVhtqvxp0=;
 b=cst+QVTn9FFjmisEctHi/ocaYM8exX+4K6OfaUvTKV3liIpM6U5S9trdPFNII0xrSe
 6BYWSZEDCXuM+bsMbjLBNbvlzc9Wj9S36qDSTWPHDajSMY5hAqzOn8UQn2U7HdJ1gaYZ
 KYR4R2p0uPGPgPogJJ7xbbao23NdkzjTR7i5K1L6bv81HXJMOun1wEgnRBJBQo5CJtGX
 hkYexzfwaX+wSHOOLFv8IDisaII0MYBgLiTBxmem5sFNC67xU7+9BhDbalwN1WtSlTLl
 2d0lwQ4evbfrf1w+9e7TyNgohrI6norvznnp3Oz7iSnufTm4D98GIp0bssUyWwgwbNHd
 ry1A==
X-Gm-Message-State: AOJu0YziEjAi7/8mhKUCQf6LU/BV+Etqj9Dq90/6xOu6i2XIF1rZYi0Q
 BzkYQj2/Z+GmGDVukA+ou1vWD4aiMpUbaqGeETZkpahJgB9jcvtlHMwcVP6S8eZccnfg5YQdNnA
 a
X-Gm-Gg: ASbGnctQZAF3r+w7RU9yD3mKHSCZTXdprqfEn2XSLXSHPnogL3yzICN5lu8PELsaALf
 yWDbhIwXqrWMgBNfsr5DrCIQlqs1/IX3gP1sG8fm4qWFPmRZeUm5EdVzloC3HAY/W949tkSXpYd
 Agcb7yIi6amPw3bVgUuEdkKHyCz3xnAWLGXdWq0LO3mPaGnKJ3DOm+qzgpwgF5IGzk3A7iexort
 ECi2YQ+ns3uxgitGEi53UuHxqflAnlj7stDcDji6s0f5Wu/0hZHUG49sGb1sYlLae3lcZtPICCD
 2ClV6knHojP47Z8ZRZzbhZW9xpi69E7fODga7oKxn4+1kVc0AM/zYI1KVy4iWnIJ9dE7+WRdBDi
 4yf6wEh6G69rALuw=
X-Google-Smtp-Source: AGHT+IF2vhyK1o3JClBoVy+nk2STEHFwpO2eaHoQTdlaRduAmdIYmoHV5AMOFb+eK7c3IbgvxOjToA==
X-Received: by 2002:a05:600c:1c8f:b0:43c:f332:7038 with SMTP id
 5b1f17b1804b1-4406ac1fe30mr130247675e9.21.1745409958553; 
 Wed, 23 Apr 2025 05:05:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d3ed88sm23733565e9.35.2025.04.23.05.05.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Apr 2025 05:05:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] hw/i2c/aspeed_i2c: Make AspeedI2CClass::gap an plain
 unsigned type
Date: Wed, 23 Apr 2025 14:05:55 +0200
Message-ID: <20250423120555.21318-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Convert AspeedI2CClass::gap to plain unsigned, using '0'
as "no gap" to avoid the followin UBSan warnings:

  SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../hw/i2c/aspeed_i2c.c:1559:16
  SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../hw/i2c/aspeed_i2c.c:1583:16
  SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../hw/i2c/aspeed_i2c.c:1608:16
  hw/i2c/aspeed_i2c.c:1608:16: runtime error: implicit conversion from type 'int' of value
                               -1 (32-bit, signed) to type 'uint8_t' (aka 'unsigned char')
                               changed the value to 255 (8-bit, unsigned)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i2c/aspeed_i2c.h | 2 +-
 hw/i2c/aspeed_i2c.c         | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 2c4c81bd209..098356e5bac 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -290,7 +290,7 @@ struct AspeedI2CClass {
     uint8_t num_busses;
     uint8_t reg_size;
     uint32_t reg_gap_size;
-    uint8_t gap;
+    unsigned gap;
     qemu_irq (*bus_get_irq)(AspeedI2CBus *);
 
     uint64_t pool_size;
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index a8fbb9f44a1..a45a4fd6cb7 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -1215,7 +1215,7 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < aic->num_busses; i++) {
         Object *bus = OBJECT(&s->busses[i]);
-        int offset = i < aic->gap ? 1 : 5;
+        unsigned offset = i < aic->gap ? 1 : 5;
 
         if (!object_property_set_link(bus, "controller", OBJECT(s), errp)) {
             return;
@@ -1556,7 +1556,6 @@ static void aspeed_2600_i2c_class_init(ObjectClass *klass, void *data)
 
     aic->num_busses = 16;
     aic->reg_size = 0x80;
-    aic->gap = -1; /* no gap */
     aic->bus_get_irq = aspeed_2600_i2c_bus_get_irq;
     aic->pool_size = 0x20;
     aic->pool_base = 0xC00;
@@ -1580,7 +1579,6 @@ static void aspeed_1030_i2c_class_init(ObjectClass *klass, void *data)
 
     aic->num_busses = 14;
     aic->reg_size = 0x80;
-    aic->gap = -1; /* no gap */
     aic->bus_get_irq = aspeed_2600_i2c_bus_get_irq;
     aic->pool_size = 0x20;
     aic->pool_base = 0xC00;
@@ -1605,7 +1603,6 @@ static void aspeed_2700_i2c_class_init(ObjectClass *klass, void *data)
     aic->num_busses = 16;
     aic->reg_size = 0x80;
     aic->reg_gap_size = 0x80;
-    aic->gap = -1; /* no gap */
     aic->bus_get_irq = aspeed_2600_i2c_bus_get_irq;
     aic->pool_size = 0x20;
     aic->pool_gap_size = 0xe0;
-- 
2.47.1


