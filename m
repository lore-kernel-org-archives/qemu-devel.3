Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67832C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 19:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwo4D-0003Lb-96; Tue, 16 Apr 2024 15:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo42-0002XR-HV
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:01:56 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo3y-0005ry-BB
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:01:54 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a51a7d4466bso543572466b.2
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 12:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294108; x=1713898908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DC2xHT4tK3V/eBcSroqFKTXibEqMvehvouzWEl1ZI6k=;
 b=Vw0qqSforRQa8b8XeeRigOAuP82+FE3k52mrDXI27fKw2FiHNLOORUQ5EBxz+Qu473
 ijU4lQdt2iTYzULIMQU9NsSrXsjWEjfHivjtkCHrQU6GNmY0UekaLGKZ10feQLkIIegb
 INBQX4Txjh9Suy+sH6Q+GxSmfi2VWiq7fzvrY5mq40vRfsH6MZY+SUr38y4m182BWqRy
 ztEHWCJoGF56VgM1/1eXqMrRDWVLtDqCxw0dIus287gvgjTwoFdI6FPYXtG2ppMwlT/8
 Ib0gHKCKiG8zCwJtdRQSeSXoW4qbva9niIammY2eyYU6xOxPxvKR1REd2pQ8RrlHO4NY
 51NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294108; x=1713898908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DC2xHT4tK3V/eBcSroqFKTXibEqMvehvouzWEl1ZI6k=;
 b=tiL7rUk7CkS210v46K0jQQW6YOlr9Xi+XodFHqI8nIvjmwPQ8Ykarcyo66dMQSWODU
 CEjOYq/xwmMqs+x0Uu3YrOGj31a619eFOVRX9Xi+u65yu0jJsLbBRZq2vjt4tHHTN2pz
 dC0hDPj4/yD6OEOrE+qpze+YKQkcsQcjAsh4mNYlgwD6B+l/caCZHse/RHGP26U9ZdEH
 anETqV2ECvuVd3qxGrQoo4C6gDxCCXNPn0tcae50+wwuBRM/NobvpojL7/ORXT2UIkSF
 lxrEM+rBhXci7lDm2L5lKxvibGnpKHbEtf3YZB1xtMqtPHZLr8YSkoqCe1xAnjoeljsV
 pfDg==
X-Gm-Message-State: AOJu0Yxs92bjBPdqCuCUg9cGK6cffwqWpAg390PCUm2PmnsVGzqk2srY
 iu/Y25VuRKwiPKvuVbUYXrQ1zoePw3Fv/JyOO+mt3KjS00aip3otJS+alpfwadAdsKIUXdocEKl
 K
X-Google-Smtp-Source: AGHT+IEweZwN1XzO84AS/y9gMjvEcIKlXa10QZ5mIlzXvdKEUrwDWOrz4pI3PLDYD5OPCMFQHnZ4uw==
X-Received: by 2002:a17:907:724c:b0:a54:e183:6249 with SMTP id
 ds12-20020a170907724c00b00a54e1836249mr4000170ejc.56.1713294107715; 
 Tue, 16 Apr 2024 12:01:47 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 v13-20020a17090606cd00b00a526562de1fsm3471599ejb.73.2024.04.16.12.01.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 12:01:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v4 19/22] hw/i386/acpi: Remove AcpiBuildState::rsdp field
Date: Tue, 16 Apr 2024 20:59:35 +0200
Message-ID: <20240416185939.37984-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416185939.37984-1-philmd@linaro.org>
References: <20240416185939.37984-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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


