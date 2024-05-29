Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C1AC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 05:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCBgr-00031S-JV; Wed, 29 May 2024 01:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBgn-0002QF-PN
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:17:30 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBgm-0005W4-52
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:17:29 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2e95a7545bdso17348471fa.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 22:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716959845; x=1717564645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DC2xHT4tK3V/eBcSroqFKTXibEqMvehvouzWEl1ZI6k=;
 b=YJ+hxImjP0MRYH+jf7KGCruCwyo8URyafB/PJPGR6w/tPg1vyHhJr+78yD9WdFp58l
 hSk5gKWBbmMyweg8OgbjbLU/zz0IOyqlWVzFbpg65RRv/yIp1MZM5/lYveRg+vhXNSso
 AEDYhb/vHYPdG/q4k5aunWrQHTWfs3C/44nC3l03pns+W9mq3FbGNl3xDBvbocw0XfKt
 SYUh/GW8Z3muTHk8ov2GooJnUTFzf2DrVjPdg1atuyNPGp7tTur3l6vs7SIwdEaBl6iX
 mOyA6AygQ5yAj4Bdg8otcm5y2ERtzAPRCjk91W+yQIhKa4zNYxnVELqXPELq3l07j/11
 2HcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716959845; x=1717564645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DC2xHT4tK3V/eBcSroqFKTXibEqMvehvouzWEl1ZI6k=;
 b=MP1rjvPBQ++2Ht+FP6AgYPPz8BNKJPelfk7jDdIETh7u+HWcgkReMkZXdvKIvN42LN
 1eSj4pqX0G7irUcy6gsmRPYCzvBsFyH8qmddToq1xMjVCDp6s7NwoRLTkDTTGOUUvekh
 m/50lbCxhEJjq3dxlqsv47C5Mj1MqM9Q5pmFNVD/CIv1SCwNuWk5uumXbFdSnEX5evx7
 cuF3aZP5mMjXU9gR6XdbPF6HCfHT1HucZ3rs2jg/qKdKOfZmjyih4nesJ7i9xprYHNO6
 nqblHT7cq1kgwsShx/Tr6aGxr+Tyg5M9TU7MIx9Mla790555b7aAj3mDah+uPAYjkjkn
 rznw==
X-Gm-Message-State: AOJu0YyXKLuO1+yqCz7udOMmTodbq2zawT0tOgh7d7zt+PRzimObENbh
 FGmF2X653t0jsV/chX5jHJjgwxf+FQp4vFj/xiACcb2p3FSt9jBgxDQEeLhld/q7HVz8CvIpgks
 a
X-Google-Smtp-Source: AGHT+IHZzGSSc7qW/Dzxo8mIOm0byle59nSLMwU+AQreUFSefOfSLWDFegUljIEF2M4tef7S0b+Zvw==
X-Received: by 2002:a2e:8e85:0:b0:2df:edd9:d005 with SMTP id
 38308e7fff4ca-2e95b096f47mr78480841fa.14.1716959844077; 
 Tue, 28 May 2024 22:17:24 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212279b4c7sm14423485e9.0.2024.05.28.22.17.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 May 2024 22:17:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 19/23] hw/i386/acpi: Remove AcpiBuildState::rsdp field
Date: Wed, 29 May 2024 07:15:35 +0200
Message-ID: <20240529051539.71210-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240529051539.71210-1-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
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
---
 hw/i386/acpi-build.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index ed0adb0e82..6f9925d176 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2459,7 +2459,6 @@ struct AcpiBuildState {
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


