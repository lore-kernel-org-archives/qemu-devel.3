Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C365C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 13:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwjIB-00075C-6l; Tue, 16 Apr 2024 09:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwjH7-0005l0-Ln
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:55:07 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwjH1-0001zg-Nq
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:55:02 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5171a529224so5630341e87.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 06:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713275696; x=1713880496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Zw38H5IlW8RC6lHC20MJl65UFdMVvRtwGxRu2wIhD4=;
 b=PxhRr4iCISLrcqgw8DLTBp33WGvFgzyyLVFtOOpGn473GvhsaQ+SyBrCdvdGpfmJC7
 9pARdrwCJnercwnrd1LK9qz5chqJ2Xwm1C5z6m8eAc6RCU3A0ipxq/LWAkNRd8N+ZmHL
 0GnEVV9u37LtQjFSiYfTcbb1M34H9a6T1USiKZlvKC9lvVKWi9n350vTouF5zaP/5R4s
 mI/960rNFU58xE89aVezVqLxVvjrMy0xF6NY3sZaCeU472I423SB6L4aX6NUeepoa59u
 4rPRwUjjtQ8v4mx3Wc42aO7f4emi+yv789Ggx+vX+oRKQijXnTYPAizgzi6SEFaD7Gdj
 MHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713275696; x=1713880496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Zw38H5IlW8RC6lHC20MJl65UFdMVvRtwGxRu2wIhD4=;
 b=Mu7s7jeNRfiiv1v00hH4b8/ubPT/6RDTP56e5RmEPe+nD86bIVmtUsT+b1gJxS9iO2
 TZ59OHNiCXmUZTF/8w0lZNZObRzC/bdbU80+dRWR+DsniC0sT2XXgM9Olqq3kj3YtOI0
 rUvycSJFztd2eJaweuKpCREXBKsufJOsdW1LBEqP2YUzAPO6lEfMpfLV2/Eqt8JUCgM9
 yx/tlctN/wf5utvZWolRI9xEhGcQVYdiIx9YU+dqhIxdAqjX+BpPi+N64JRfPhynnrNG
 omZSm87dbbRsr7OWhI5r3N7VMwsIYNc2mZFywr8MBcQwpfwJbXMRvX9GW7sOrDK0FpJI
 /wYg==
X-Gm-Message-State: AOJu0YxO4IkCpvX9JgGAr/CLIcP7haQr7B4Da6cC06ENuEC9Y9nCo0IA
 GsprQCpsCe63CoyScehVngbO1g9KVwdJPZKseDRYdavHzovCloGNPFgbWjZm5OnQz6WNvOd586C
 5
X-Google-Smtp-Source: AGHT+IGNRqnyb8FO6tF8BJsTTajHP+R/Jl70KzE8zMr3zdyLnfTCwutzliUrccmeEdVZxpUYvxaTJg==
X-Received: by 2002:a05:6512:3d1f:b0:516:d4c2:53f7 with SMTP id
 d31-20020a0565123d1f00b00516d4c253f7mr11213990lfv.47.1713275696382; 
 Tue, 16 Apr 2024 06:54:56 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a05640210c800b005704825e8c3sm542692edu.27.2024.04.16.06.54.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 06:54:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v3 19/22] hw/i386/acpi: Remove AcpiBuildState::rsdp field
Date: Tue, 16 Apr 2024 15:52:48 +0200
Message-ID: <20240416135252.8384-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416135252.8384-1-philmd@linaro.org>
References: <20240416135252.8384-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

AcpiBuildState::rsdp is always NULL, remove it,
simplifying acpi_build_update().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240305134221.30924-16-philmd@linaro.org>
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


