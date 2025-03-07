Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F5BC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZSG-0006D0-Gd; Fri, 07 Mar 2025 10:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqZQi-0005qB-PC
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:16:13 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqZQh-0003qQ-0P
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:16:04 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-390ec449556so2400708f8f.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360561; x=1741965361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PLnyOTswVEaIwB5mduyl0BorXeO7LlZ/oZ3CWTRx72Q=;
 b=vriINjjN6R8Va2N+qXe2ea5pcYBDA4lP7re9T1beXa+MsKZTi5b9XDDL8UtzQ8mUYi
 1NukZHvQHg+8hxsoUBNrvlWzDkDAMKZly26NdSA7lvYvPBltj6iVgTlarcMjy1NSg7KE
 iV5kb9ciyvnZQ6t5jG7N2Avfite+b2V1wZKW8NP+dJEJZM7nAWdaUwFTaE4W7UCJY6uA
 wCCSJkulotPGRGIt4vKZ2qEURHLS4cqU3lfaKbbeiaXtASSgbkhiR/AXe9600Wk1t/Ez
 UTKVb4IdOLC27bBgp4W/5J4Q9n2uPjClzlA4lHJsbpUCLtfoSTQxL5KgZZm7W0hnxGTg
 ovNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360561; x=1741965361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PLnyOTswVEaIwB5mduyl0BorXeO7LlZ/oZ3CWTRx72Q=;
 b=Wp/SJmdi1Ft4Ifj86eW5Mbr5qsq/WZRm9aCzqIUPc/L9zytf1QY/qUPYvxe/EsNKLg
 GEgGBlu/rylRqbH6156FYrAnAQnyTdVSRCLGD+UFm2/LTwh1cr2qbgaB4yYmVKNgySrW
 bA1M4EC2pUHb69KImz26JaTj1KVzOhwo7WAvKxspKA6sAiRiwYDv93N9U9DvISuMqJbs
 pwg/LkV5Grfv8+94q0YkUUFeYK2SKWnWTXtz/eSMEH+HFjha0FKQAz7b5Dlsq4DZZePf
 IDgcoPXylz3U/d8GnU5DsYbIvTWqkNf3p71xpREXXR83ujRTl2JLrOMp0A3PyY4W5rqx
 czeA==
X-Gm-Message-State: AOJu0YzSl9P3oPShyQwoKX09Ks8JxrFQAHogqsheC6tA+jv/lIPbcRwX
 /9PAm0IulSvT2tl97Nd9vGpHRMFpcYRyeHCW6ZRz/TrVy3O7Zxr7GAxgUStMvIeQaW4QLnqukTq
 668U=
X-Gm-Gg: ASbGnctDwOQsahy9Gk2npK4r7MA5TCynXnSL+1ua7/k30pP7tIoPXsYK8KPkroyGVRJ
 N9qlVumjDxnfdP1au3U89C8DlTDkvnBWabgoo+wjhf1zKsRjJ061P0Fg8vZCWG6rpSpwHhoGNNH
 GwGYPZxiLUYLF6w14iEsuMMZU9ur5I4+ojmboij8ksogP8Ywu2L+9QeOpvwFvHwx/KRn9pLNHC5
 Eef/sgkwh1hueuFU4nqN02JyDUO2rVCBJdCBD3rHlDPsY6SD9jtFg+gbBsxQgUz3QESTNKqmsuI
 BHoT+OTrq9yRmqiX13qzioq3bqtqV7U77b+GOoDl4GH7FCHdQNih/x3Vs0OULjrG2x5ABFO3mC0
 YotZ+SDJOsYoERL8kMY0=
X-Google-Smtp-Source: AGHT+IHwBlMfoxAmttDu3Na/s3AqdWOqN+kkI2+sWSqc+y9t5/VH5MoIzS3usN6Ve/QcRbUh6pBbrg==
X-Received: by 2002:a5d:47cc:0:b0:391:3049:d58d with SMTP id
 ffacd0b85a97d-39132b58ad8mr3788604f8f.0.1741360560624; 
 Fri, 07 Mar 2025 07:16:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bee262esm5625123f8f.0.2025.03.07.07.15.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 07:16:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/7] hw/i386/fw_cfg: Check ACPI availability with
 acpi_builtin()
Date: Fri,  7 Mar 2025 16:15:39 +0100
Message-ID: <20250307151543.8156-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307151543.8156-1-philmd@linaro.org>
References: <20250307151543.8156-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Replace the compile-time CONFIG_ACPI check by a runtime one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/fw_cfg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index d08aefa0291..a7f1b60b98c 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -145,10 +145,10 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
      */
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, apic_id_limit);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, ms->ram_size);
-#ifdef CONFIG_ACPI
-    fw_cfg_add_bytes(fw_cfg, FW_CFG_ACPI_TABLES,
-                     acpi_tables, acpi_tables_len);
-#endif
+    if (acpi_builtin()) {
+        fw_cfg_add_bytes(fw_cfg, FW_CFG_ACPI_TABLES,
+                         acpi_tables, acpi_tables_len);
+    }
     fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, 1);
 
     fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_fw_cfg, sizeof(hpet_fw_cfg));
-- 
2.47.1


