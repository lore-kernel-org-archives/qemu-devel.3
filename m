Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0B6C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhV7w-0007VJ-5w; Tue, 05 Mar 2024 08:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhV5a-00044f-5w
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:44:19 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhV5Y-0004FG-8D
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:44:13 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-412e2dfa502so5771845e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646250; x=1710251050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CWBRqdFoui2ZIQdsVAc4WwMyQH/pl83wSwYQ0f8fh5s=;
 b=tpktzmtWv8GYaEoDhnCIF0JfbLDkhqYp9+JHByZk56/avxWmBE57Ypx8SqPsx6X67s
 /oHctsCqUSH0SwKPasDb5DRnlsZYYEE2mX/XJDLSnY0MSgjIoL5oMgtfykHdfhXhlI2w
 1WN9JbiQ2SIb3PjpbWf8XFG3SHIXwZfcbJh1+uk8bGvtc/BAtCXSfgxBcNMWPxOtZcYP
 QBSU8t40lWkLJTtn3CyP+i/TIzHdfMt+QBT9tp7IdiRR2tMqfHthwaN3LSEHqJ/E/17C
 Zd9hHfhQqHJh/M9kWtTkxrUaqpDX8qY+U5bFLnq5RFuPeqC945ToNtq9MOjzukMdDnyW
 tDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646250; x=1710251050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CWBRqdFoui2ZIQdsVAc4WwMyQH/pl83wSwYQ0f8fh5s=;
 b=tjNFz2iID2qir/kW6BJ7spaob50J/M8oWnI8Lm7tFebI4Z3UChz8FHFVpotB+iO5qj
 s+gr4KjtyDJYvTlVB+nDAiDbTJcKWurRp+70dnvgsU2Yc7yI7o5yiOUKLq7SoKSuh+AF
 Nk02feTqPjsULTLRg3Kba+BEnSJqtEg6tD3eOhqc0wqixzowMURxMtjyyG66SAgiyiv+
 zdiHpTu3KmrWl/0oKzLX1k/Vuz1I2/HPzQfta1aN+PZGL3s5zji3+DlK7PqEQan27yN8
 Bfemi9xuW9iV/H7dgDR5N9gdl3An2+kfDogRbO52gs656NGwPAHcfGfYXjwgum/Ku1Jv
 CUIA==
X-Gm-Message-State: AOJu0Yw6yeY2d6myyUI829FOEQ9TRJp7S8AYZFUdCw1uLPW+KerubIaI
 Dzpnj1J9eBjZqmVzak6IM6+D9SFYD3ayHkAYmTkSwGR1xcGNDTPe7laQncuOmRk2UnI4ojpATz7
 j
X-Google-Smtp-Source: AGHT+IGQTuvSA25MYt3l0zdavkjoVT1Rvq7X1tInRhssFdU2bEWiaupK/vlzesgSWvabYqXcp2J6Qw==
X-Received: by 2002:a05:600c:3d0f:b0:412:f0fa:5c81 with SMTP id
 bh15-20020a05600c3d0f00b00412f0fa5c81mr14729wmb.12.1709646249934; 
 Tue, 05 Mar 2024 05:44:09 -0800 (PST)
Received: from m1x-phil.lan ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 bd23-20020a05600c1f1700b00412ef097c27sm1260661wmb.16.2024.03.05.05.44.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 05:44:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>, devel@lists.libvirt.org,
 David Hildenbrand <david@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH-for-9.1 15/18] hw/i386/acpi: Remove AcpiBuildState::rsdp field
Date: Tue,  5 Mar 2024 14:42:17 +0100
Message-ID: <20240305134221.30924-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305134221.30924-1-philmd@linaro.org>
References: <20240305134221.30924-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
---
 hw/i386/acpi-build.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 12bc2b7d54..bf727eb148 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2456,7 +2456,6 @@ struct AcpiBuildState {
     MemoryRegion *table_mr;
     /* Is table patched? */
     uint8_t patched;
-    void *rsdp;
     MemoryRegion *rsdp_mr;
     MemoryRegion *linker_mr;
 } AcpiBuildState;
@@ -2715,11 +2714,7 @@ static void acpi_build_update(void *build_opaque)
 
     acpi_ram_update(build_state->table_mr, tables.table_data);
 
-    if (build_state->rsdp) {
-        memcpy(build_state->rsdp, tables.rsdp->data, acpi_data_len(tables.rsdp));
-    } else {
-        acpi_ram_update(build_state->rsdp_mr, tables.rsdp);
-    }
+    acpi_ram_update(build_state->rsdp_mr, tables.rsdp);
 
     acpi_ram_update(build_state->linker_mr, tables.linker->cmd_blob);
     acpi_build_tables_cleanup(&tables, true);
@@ -2805,7 +2800,6 @@ void acpi_setup(void)
                            tables.vmgenid);
     }
 
-    build_state->rsdp = NULL;
     build_state->rsdp_mr = acpi_add_rom_blob(acpi_build_update,
                                              build_state, tables.rsdp,
                                              ACPI_BUILD_RSDP_FILE);
-- 
2.41.0


