Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A9FC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdU4-00018X-S9; Tue, 04 Mar 2025 20:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdTR-0008So-92
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:03 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdTM-00070Z-6U
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:22:58 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43bc6a6aaf7so20956275e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137774; x=1741742574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q8ln23H4+MbGK4gitXxRZRuS6c4E+4FT/FZeDk/HlDc=;
 b=Y+zkgcrfbeG7skCZY0nx+sUcjCCZJ7+F3P0ymyYJo7ILHXnpjCw5vCultb9bAK1Hkj
 y2Qj+Y9LtSsNMNGHTuP9Aa4k/Y0t6hD/f/lOqej5KWuYA4Bo59DL1J3vn9rjGmIMpobx
 yRtF+Th0REM07PLKK7uhWygTrXN4smUQhXbYfSYofh/4ZDTm/OcaSDtZDhx/aNfrlEdh
 BzGeUJJXT4BAJef5ZBph6MdW8mDlVIjy088pmXaKBH0kz4oZH1EPakqelVYq0oombHeK
 yFG5ltH4UiGF0t+ND14AOMDeT1p4oXV2ljCXDBSqT2IV3K1XCkcbaFqj97s2FYhA1Tlm
 aTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137774; x=1741742574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q8ln23H4+MbGK4gitXxRZRuS6c4E+4FT/FZeDk/HlDc=;
 b=djQd92hwE92YNhT+Td86wWNdoMM5e42lbKjiwYEW/v4LzjG9mrPttoCgavPANVC3A2
 b5Z0nuBGr6sJhS6UxxMe971M+WO0VMLbTI/aoGQpGXtPOtHtBnLp5VduSNXn9S+v0W4j
 Rnx5NiHLwd4UmOnbZwy50eQBMRxv5tDby4m41j1rQB86DvaHiE9DCwxGsCV9cQz8BEi3
 EFJ+64FAk5L0cqmClKBabyEmojdr/ejHkWp6trKKrlI+w+CLZWekfLRaIEt9r3BfLY17
 ev5i10MNxYzdA1yGbxG3zact0y4Ab6qlV6o3Jtcnoc2eWTUT7C9hTCtan2tfqfupvZMC
 3u/w==
X-Gm-Message-State: AOJu0YyQfPqCFJSWBkHesTzGLAViP5lqy4nU9yC4/Onh7VeFYv95EoCn
 NMmNiluZdKSTF1vSjjnzbrRMcsfJP6tHiVBo8EAXvXg4QgzrYakrIf/hkFz+ctooFXdqIyW2pJI
 WzD0=
X-Gm-Gg: ASbGnctZ+IuEcEI6ejLG6WT3+Y3AxrEaSIIemDzTiX24mzkf8w1OoDRI5uIf7P/EJeg
 TqDqnPnq8bnhUhuJ2Rz5XUMYZDPQm6VnY/KqjZXfkwCEKj1sBYFOa7Yt6GA26VjdXeOMGSYHdUw
 w6LqExwk70A1IQL2+m66Sm433VeVcyU5K+JnCLxeZ9SUzGPRljszzZrhXGWMn24Atg7ZaZFMMyS
 yFfBYPVP9jNSoNyfs4AwavjS5Vq0Du8F2qRkMrl1uTYNVWEGQDGEnnA1PAe5qYo81+hi+OJqfEM
 JcL7FKFExZVy9+f7wotmmvTfrY9Cu10FRO1fJ3ennsToof6WqS+4hxMwcRV6kDYuWKMvw0y6H4V
 IQZz1NwNVQcC5ef9UF8Q=
X-Google-Smtp-Source: AGHT+IGNVgsFUAnqjOl7hWRGGaaKmlQaCZ0qeg74JejFtTHA9H1HeG6qAaTJrYWS+DZJpNoX9iJXaA==
X-Received: by 2002:a5d:5f50:0:b0:390:f4c7:ea20 with SMTP id
 ffacd0b85a97d-3911f756fa6mr777720f8f.24.1741137774502; 
 Tue, 04 Mar 2025 17:22:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b7d69sm19684867f8f.60.2025.03.04.17.22.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:22:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gavin Shan <gshan@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/41] hw/acpi/ghes: Make ghes_record_cper_errors() static
Date: Wed,  5 Mar 2025 02:21:26 +0100
Message-ID: <20250305012157.96463-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Gavin Shan <gshan@redhat.com>

acpi_ghes_memory_errors() is the only caller, no need to expose
the function. Besides, the last 'return' in this function isn't
necessary and remove it.

No functional changes intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250214041635.608012-2-gshan@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/acpi/ghes.h | 2 --
 hw/acpi/ghes.c         | 6 ++----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 39619a2457c..578a582203c 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -75,8 +75,6 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
 int acpi_ghes_memory_errors(uint16_t source_id, uint64_t error_physical_addr);
-void ghes_record_cper_errors(const void *cper, size_t len,
-                             uint16_t source_id, Error **errp);
 
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index b709c177cde..b85bb48195a 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -390,8 +390,8 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
     *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
 }
 
-void ghes_record_cper_errors(const void *cper, size_t len,
-                             uint16_t source_id, Error **errp)
+static void ghes_record_cper_errors(const void *cper, size_t len,
+                                    uint16_t source_id, Error **errp)
 {
     uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
     AcpiGedState *acpi_ged_state;
@@ -440,8 +440,6 @@ void ghes_record_cper_errors(const void *cper, size_t len,
 
     /* Write the generic error data entry into guest memory */
     cpu_physical_memory_write(cper_addr, cper, len);
-
-    return;
 }
 
 int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
-- 
2.47.1


