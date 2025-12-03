Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E09D1266D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 06:12:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQg4f-0005kU-JF; Wed, 03 Dec 2025 01:10:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQg4b-0005Yo-Qg
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 01:10:46 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQg4Z-00014M-1Z
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 01:10:45 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42b38de7940so3094474f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 22:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764742241; x=1765347041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJ7ely9hzqgs7VmHKEXFRsGMqnx7PoNMDpzJyHt0paQ=;
 b=HKzOMzNPnRa0XbZSYPGTKUZ1LPKYR8AMuIyLf/JZao2X3d44WsuNywz4VXzIBJGvGA
 AOcrOqqsz0ANMl5msze7b+iD2ndVmfCXrqXT9Yoe+MQ7Q0fMIy+NEzUCkbHXf5xMNQOA
 yXS9Ui672YzWYdwE9uEZwzQshb6SESOvAGkex11jkKPnLn1Wx6yeUAvS3f7M7iWLy5sd
 lrQX5uiB5XXle4rv8L2UHS6Xd/Vy9ipWgqh9Mi38cSuT40e6/32JICTe/ykkRZu3YVHE
 dP/iIy5B96kU654w3cWYtTTMwv1bbxWBYAxGZtE2JJH/0RkWGvjtf06rbeyFSDjp/gzh
 PK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764742241; x=1765347041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cJ7ely9hzqgs7VmHKEXFRsGMqnx7PoNMDpzJyHt0paQ=;
 b=sW8+KrzX97gz6TpT05G5TfuYoDr/iaeOPGIpp4MQ/sjPPtLj5Dbv/jvcUb+9JClDpM
 dqhcoDFl5vrfBpQUsMsUEh5KhCdQM4JXwkQPehUKYt5zxrY6KhCCBhSl5Y+hyaUJB11U
 PgqVQLBqL1JWTmzYGWHFqlVURmcZojMjZWyEYLaxYJYb//LztZOqjvnQ5A4vkiG7g3T+
 b3arqWUrXtSJrBJRR221lFaHttXF1ihXh9DlgrDruzhRGXk5NtrplA+lXb+cTPhvF3ya
 N5r3mwSaGRKUetCPi5Q25EPm1bUBhbbKGpPijXP51sWgOC3VJdu/k7pEL1YXpNVonf4h
 9Mmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFzsz1SdQbUndUowrDwU7O6HaWpGfXL8R6lnwYgIWHYGIaviv4fktXDn9JfCnwOInFIrz/yTIG/XNZ@nongnu.org
X-Gm-Message-State: AOJu0YxM8fOAUHGMeS56E3lFhFkZXMI7XogI/skv/Z971dpmPnuAcmdy
 LQam7s691dHdWIYNE5KyzKLwi6Fve/3huf8s/JomjpGC0YILLxiM4Ced3ZwuP+Q8ZuY=
X-Gm-Gg: ASbGncuR0PLytOtEkZT4xamn8f4LGJLmgXjT5EPZIQrSdjriKguCWWvPmHq4kJan/Su
 mToA+GiP9KfSKp74GEeLdg3ZHmNjwWIvBgclcewhuxEq2qQWBFdlKMIwgsxNJyPCZkM3onNM4B3
 D0T6OGb6HQ9S0nImbpjxo0oMnKVq5g8H4Jy0RByN9rbu1aif+lD32TSjqQWbM9AxPE1nmQISVOE
 seEdqWk+E6lBQg78B+0QjxPANiqHegEHVcj1oqUZvmrpI+BZOR6c+eCVoQgLMMfR3DTmeFPsYZr
 T6QmRUMROSYjGtwFFs0kw6pxOewMwWHfzLs4ARADRbbQ+gMK0LlJIZD3DmMhRSvuYV7ObHdJ7VB
 krFbybRsyySk32OHTWjEurQXvffvCKgnMqLRdhgJAyFzeBXdZNEj6cUMBSsRr+EzQkt4OUi71Kg
 7yPIDS+bCPzfeM4bpm08tfv1KD59zGaj1/jnxLVuzI3a7qYwrH8WuP3ltqnsfF
X-Google-Smtp-Source: AGHT+IFQb/Dad/BvwX+uiwS8U+3g2hp5gcX664TQgINFZ5o5vj0uy/SDcWEx8w4i5DBAvKfEJ4x4KQ==
X-Received: by 2002:adf:fe4a:0:b0:42b:41d3:daf8 with SMTP id
 ffacd0b85a97d-42f73196803mr592087f8f.18.1764742241187; 
 Tue, 02 Dec 2025 22:10:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca7880asm37423781f8f.31.2025.12.02.22.10.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Dec 2025 22:10:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Zhao Liu <zhao1.liu@intel.com>,
	qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH-for-11.0 v6 08/13] hw/sparc64/sun4u: Use fw_cfg_init_io_nodma()
Date: Wed,  3 Dec 2025 07:09:36 +0100
Message-ID: <20251203060942.57851-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251203060942.57851-1-philmd@linaro.org>
References: <20251203060942.57851-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Use fw_cfg_init_io_nodma() instead of open-coding it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sparc64/sun4u.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 82c3e7c855b..6dc9f64b74d 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -683,14 +683,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
                            graphic_width, graphic_height, graphic_depth,
                            (uint8_t *)&macaddr);
 
-    dev = qdev_new(TYPE_FW_CFG_IO);
-    qdev_prop_set_bit(dev, "dma_enabled", false);
-    object_property_add_child(OBJECT(ebus), TYPE_FW_CFG, OBJECT(dev));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    memory_region_add_subregion(pci_address_space_io(ebus), BIOS_CFG_IOPORT,
-                                &FW_CFG_IO(dev)->comb_iomem);
-
-    fw_cfg = FW_CFG(dev);
+    fw_cfg = fw_cfg_init_io_nodma(pci_address_space_io(ebus), BIOS_CFG_IOPORT);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)machine->smp.cpus);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)machine->smp.max_cpus);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)machine->ram_size);
-- 
2.51.0


