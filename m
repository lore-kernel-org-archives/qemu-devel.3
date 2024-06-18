Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5EBC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbIU-0006iz-Lo; Tue, 18 Jun 2024 12:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbI6-0005mr-Da
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:02:38 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbI4-0006z2-P5
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:02:38 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57d06101d76so316376a12.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726554; x=1719331354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=481P++9pg0zI2n/4exvP8oZom8l9jtwiiKGRbZrAgxw=;
 b=t/IFGzp0tf75LtSiVqmcNdMVqB3T80hQy8V7gS5dYbXVoG6NxhKtavRZ6P08RWUa3O
 Ed6j2KasFBpmBYMpSK5KB57nkLTGV8wlWIXpuDQrBqh0woALiJZJKUVFMKP9Qv2igAgo
 Il2yjk0rqs1Qwv9ky0WaQG0D8CQSb0kqxshvjbQoQIB5kfBRnF+cZ+ZiUpViBXveVW4E
 +xCpXym+ZFoNa3nSLfHrLcMeOV3EGxqi6C13DUFQXO/+zj30uXOM8XSNnrCgwYvUXJ12
 E0LYonXP+w/Mo9PEKG9hd2pXMYCNtnriJl/3j802f9enZBxnxxg7BnwO12/N5F6B89OL
 76ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726554; x=1719331354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=481P++9pg0zI2n/4exvP8oZom8l9jtwiiKGRbZrAgxw=;
 b=Qoz7/qAM4Fcm3JqYBj37D1+jMYb3F9BeTJ6tAVGFIMbm9ScWQi6cU1K4ijth7F1N5Y
 Ag2tW9mDTCXri3+kAQpvO6m7J5FsaaZbwFwYqTmvW0TZIltxrU0RCfkhqE+qvCbHRoUM
 oDVmmQPlAfsf7EFArzcxQzcNbo7HyYSrds0NtXfQQ9tjIKjhjSPfPVB4G2ZAsrDbPHU7
 /eVNFg/fRjnJtBl9OZ8iaddfwVZdSR14eECY6rMYHmIv8Bz53J54EOiCF0/LUXs8lbi1
 CRQNF0Zo/f8HpQEUmNSzSw2m0KtDACcsQG+PR93yNOEQjrrX9VKF5m94+WfhiSh5o7tM
 +yLQ==
X-Gm-Message-State: AOJu0YwEgptqFirDwpMKMVwnFTK52EJ3ZybMGpC0kl3KFgpHXgKqZwAx
 jHrU5sLrY9xw/UVHzAjvg+U0wbIGBamBpq3p2ulj/UEAsJ1pxtf9t4HBQwvXTDMT4bOV8dh/f08
 r
X-Google-Smtp-Source: AGHT+IEQYLMKnop7V14QlA7+fsqz+FTzEH9TeSJSqFqATfgbALiWEb24okkQNd+DuRSCRFfT4LMMRQ==
X-Received: by 2002:a50:fb15:0:b0:57d:3be:5ec2 with SMTP id
 4fb4d7f45d1cf-57d03be6373mr910594a12.30.1718726554554; 
 Tue, 18 Jun 2024 09:02:34 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72da32fsm7877548a12.36.2024.06.18.09.02.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:02:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 19/76] hw/i386/acpi: Remove AcpiBuildState::rsdp field
Date: Tue, 18 Jun 2024 17:59:41 +0200
Message-ID: <20240618160039.36108-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

AcpiBuildState::rsdp is always NULL, remove it,
simplifying acpi_build_update().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240617071118.60464-20-philmd@linaro.org>
---
 hw/i386/acpi-build.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 158e74f64a..f4e366f64f 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2458,7 +2458,6 @@ struct AcpiBuildState {
     MemoryRegion *table_mr;
     /* Is table patched? */
     uint8_t patched;
-    void *rsdp;
     MemoryRegion *rsdp_mr;
     MemoryRegion *linker_mr;
 } AcpiBuildState;
@@ -2714,11 +2713,7 @@ static void acpi_build_update(void *build_opaque)
 
     acpi_ram_update(build_state->table_mr, tables.table_data);
 
-    if (build_state->rsdp) {
-        memcpy(build_state->rsdp, tables.rsdp->data, acpi_data_len(tables.rsdp));
-    } else {
-        acpi_ram_update(build_state->rsdp_mr, tables.rsdp);
-    }
+    acpi_ram_update(build_state->rsdp_mr, tables.rsdp);
 
     acpi_ram_update(build_state->linker_mr, tables.linker->cmd_blob);
     acpi_build_tables_cleanup(&tables, true);
@@ -2804,7 +2799,6 @@ void acpi_setup(void)
                            tables.vmgenid);
     }
 
-    build_state->rsdp = NULL;
     build_state->rsdp_mr = acpi_add_rom_blob(acpi_build_update,
                                              build_state, tables.rsdp,
                                              ACPI_BUILD_RSDP_FILE);
-- 
2.41.0


