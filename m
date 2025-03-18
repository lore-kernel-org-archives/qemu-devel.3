Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEACEC28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWm0-0006Mz-WA; Tue, 18 Mar 2025 09:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWkK-0002oi-Hz; Tue, 18 Mar 2025 09:12:41 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWjv-00041B-Dl; Tue, 18 Mar 2025 09:12:17 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac25d2b2354so956880666b.1; 
 Tue, 18 Mar 2025 06:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742303533; x=1742908333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uSRHLk0R9GXiHfoVjL1DK6CsPsvWkZBDEdWUC+o27+M=;
 b=NtjiIbl4iLRZX6MDXeOSSTL6M5YuU5iKaWd4n7eqjfbAQct2LsXWRV9LAVtdfEq0LV
 pEZ7YWfLYdV++8OK+XV3S3m1vF1TmH1WFxubZ0NlIN5QvoHVt/uHShyuVommoduHNp9l
 E8vQP6puVMH978ju2QAV6uIwwi6IPLZ8W/v6FJLhaaMYQ56VFOD9vMlzKLtYyVbGmRo1
 DDm871QUOCNt60PiJdbUsLXXO2kOzxjK7Ac2KcYYF1u5Wme3HOFuol4egw0lvSI415Ps
 LxNDl4YBc8skMXVhERGHnWebY8vWz1egioGzIm+iQUm5+SJwZBGQOBXWq96ls1xNNCgJ
 9ESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742303533; x=1742908333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uSRHLk0R9GXiHfoVjL1DK6CsPsvWkZBDEdWUC+o27+M=;
 b=dcCKpUw+lAnHVUWPESzB4VhhnPjsI8w2L19kE97Rj3H15s5TTE4lqMl9xY7JBzjYDr
 ac4j8SNI+4EVEnOATxSpyR8VSMabQ83/DgkOWW1JSAMkEhZHIqUbV1/uHeK6SPKnxSwN
 Y+P5Kkqa4c3t4loMx5zSL2YzDyYXDsUzcvvvwGKnY8o0Sa2/RSP4pU/Xq3DsCUOrg3t2
 83gx9wWsQKgCZNpg2LbktaDc0M2cg1HgRV60BnMaQi5xroZQ/eKe1kYzEnjYm7ec8Epe
 Yoi88ibOceGc5J9ENVJFeAuvheXQ5IT7WcA0A0Ry0fuqrdS2KG7sPfnf5MuJ9jh40Ac+
 Frag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjH9DiN9bneY2iVoPJqmirKyJS6fxVDXjisul6yF6k17+Zn/P0amkBPkY2yc5FEm15s5nUB8PN/g==@nongnu.org
X-Gm-Message-State: AOJu0YymqBChaQnHupqNb39Ok0jlHSdbLeAn67kOyCjz8UF3fFaONkZY
 3x7oLOBsR1SgP2DikA4LbawTub2FDAjdJZaafw9rgJyjfLv0TBinl70K6R1y
X-Gm-Gg: ASbGncursttJHPm127FIywWsT2hAmRLCNpFwqtNR0qj+psNFKu6V0fWtiW/hW9M8uk9
 74H2rAUo1RN05GYe6yV1hYXPIpcA0b0Nc/YK5CJC0HxBNhcih6JHQ5Ci/fsWhZEB2x9xLOC6x3H
 PZulzrgwJlAYLkFpjiBqAG936TX6D7xeybE0tO7DJHlXs42XxHKj2qt2F7OzmwIMyih8xiO0fYm
 v9H3989Sz6dzHHumqFnTPTh6rZ1w1iS2R1bcs5tYvj0EddxRX7cmum0+Xx/YwbMLe9s6U3w/X6q
 ibfQWFdISLJQFcd+eZ1Xqgw7Zf721P+CX5qHhOz0V0NjVOxZenmQW5fTYZc95JGlI1s=
X-Google-Smtp-Source: AGHT+IHbHSM9/eDTy6KTx6nQhcN7grYEwNg5n62I7IDr9T4nnse0jfwO6SAZqcZhCE6HiSIJRsqqNg==
X-Received: by 2002:a17:907:6d0f:b0:abf:457e:cef1 with SMTP id
 a640c23a62f3a-ac330442e09mr1846487266b.40.1742303523249; 
 Tue, 18 Mar 2025 06:12:03 -0700 (PDT)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3147f3101sm850678066b.69.2025.03.18.06.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 06:12:02 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 qemu-arm@nongnu.org
Cc: =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH 20/21] hw/arm/beckhoff_CX7200: Add dummy DDR CTRL to CX7200
Date: Tue, 18 Mar 2025 14:08:11 +0100
Message-ID: <20250318130817.119636-21-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250318130817.119636-1-corvin.koehne@gmail.com>
References: <20250318130817.119636-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x62f.google.com
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

From: YannickV <Y.Vossen@beckhoff.com>

The CX7200 polls for statusregisters in the DDR Controller.
To avaid endless polling loops, a dummy DDR Controller is
added.

Signed-off-by: Yannick Voßen <y.vossen@beckhoff.com>
---
 hw/arm/beckhoff_CX7200.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/arm/beckhoff_CX7200.c b/hw/arm/beckhoff_CX7200.c
index 0fe03f570f..8c1379aab4 100644
--- a/hw/arm/beckhoff_CX7200.c
+++ b/hw/arm/beckhoff_CX7200.c
@@ -141,6 +141,17 @@ static void ccat_init(uint32_t base)
     sysbus_mmio_map(busdev, 0, base);
 }
 
+static void ddr_ctrl_init(uint32_t base)
+{
+    DeviceState *dev;
+    SysBusDevice *busdev;
+
+    dev = qdev_new("zynq.ddr-ctlr");
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_mmio_map(busdev, 0, base);
+}
+
 static inline int beckhoff_cx7200_init_spi_flashes(uint32_t base_addr,
                                         qemu_irq irq, bool is_qspi, int unit0)
 {
@@ -326,6 +337,8 @@ static void beckhoff_cx7200_init(MachineState *machine)
 
     ccat_init(0x40000000);
 
+    ddr_ctrl_init(0xF8006000);
+
     /*
      * Compatible with:
      * - SD Host Controller Specification Version 2.0 Part A2
-- 
2.49.0


