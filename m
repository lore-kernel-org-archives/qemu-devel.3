Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DC2C7EE39
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 19:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVbgg-0003JE-OV; Sat, 28 Jun 2025 15:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uVbgW-0003Gh-P4
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 15:58:01 -0400
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uVbgV-0000L2-9l
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 15:58:00 -0400
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6fada2dd785so11569366d6.2
 for <qemu-devel@nongnu.org>; Sat, 28 Jun 2025 12:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751140677; x=1751745477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8eAh8MiuuyXhzXsKk9pEAPJvTRcVqDS192gJR9vUnNw=;
 b=vynyTJnhesdfkw4RIv6OOyHaWIeLgw64XLlaenvmy2pZbLCXNr6teCX3dhVMfPOspI
 3/JDYx1P0PQXhbjaNw2VV5okz3SHoaMQFCVqyKzbHgrFT6DyJ523S/hc/Esk4jg4gbhU
 cTZniXdEATcXok4AEge/t/wq1dhOi9leHus54cPkUWOjzKipTEr6akFjKZnaiuNOEgiE
 GjrC7W04ab5s4NMZbKE0KYDKx+tC2znB6U19izcizMYvvYtPJfbx0XNxm551Pvd+7s5P
 F2e6hzr4UHAnILvvkrCvaVlKTD2WTQ0JuGUn/Hs7ctLiGChWG0xjm3fHn8YlxaumpCw4
 AXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751140677; x=1751745477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8eAh8MiuuyXhzXsKk9pEAPJvTRcVqDS192gJR9vUnNw=;
 b=Sc6jLp2aJCkzWiTuwT/7YJvJlXmpChrKbtXnqrnrEw5eE3iQQ+HOefqSSjaf4N+Ttk
 KOR1tZEbIS/ImRv/qiKoRDPxsA1HV+msR+qTnrVFmuTuH/A7FqtNjQ34OJbwtqjfZ+zL
 E1q17WLX4OkCgZSm2xm7lRMFT6heJHSUYdBmiY+uUdmIz928N7/EVyjOuznwRakKlvml
 hzvXVFzmmBuuszg1bPYWJPyzpCDv16FtIr0BARyh4Jvmc25f6duzC7GtwM9BZnvSyOHr
 5dPriJ2OODQMptvePFt+GRM+DuZ4LcHbTQ/jhwwikkXl0Z40qHMe/yRul+GcRmUWg/DW
 jPxw==
X-Gm-Message-State: AOJu0YzyDpQlnW+eodKW1h+905cUYBPCgWYLPMaPpjvEnXx/1VgiDwFo
 qnJuXhCwb11IH4PPtqZaUx7QUQVsID+MBIF+es8goLrrtXMDKpaGUzserHkaCD6a2QECmIy+7Zn
 wfw5X
X-Gm-Gg: ASbGncs5yZ+DilPdQ3Nq9ORnNraCBamkz0d73T0bgvqJK1jjOh+289oUSDL51/lQC8M
 jUlPulj8778jVpYQfaV5RlCvZB3GH/jINeJ2pLXMgqhWb5FlGV+6KxGhrZLqAXhCZbqD2uCeco2
 ZOsHqkdGM1OxvUMBdJ8PNaCFKdpS4Ex/eJEU3NEcHtTBOdAy/m9VmOc+P01sqivDwHw6dVQxpgH
 bSaxHk5Mti5qSXuGInXRSZqE/l9Y2RmHcf/nZ76TSIvj7VTZJThXvv4K9QKUgkJeaBOElGdF07R
 Y/fiZ0e9uLshN1Su0skz0/dtB0vI2/a3KmiwirLiBZD+lRIpRDPgbA1IoHxr6/NNVHo=
X-Google-Smtp-Source: AGHT+IHJP6tbB95365DUQekapZW9P5PxX4fgVY0oZtXDgrSxSVBZgNQE0vxs+xjxa4g3bEGlcGAvfw==
X-Received: by 2002:ad4:5ae7:0:b0:6fb:5559:b3d1 with SMTP id
 6a1803df08f44-6ffed7a54ebmr109996836d6.1.1751140677531; 
 Sat, 28 Jun 2025 12:57:57 -0700 (PDT)
Received: from gromero0.. ([186.215.58.88]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d443136907sm334395585a.14.2025.06.28.12.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Jun 2025 12:57:57 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, eric.auger@redhat.com, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org,
 udo@hypervisor.org, ajones@ventanamicro.com, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com
Subject: [PATCH v6 4/9] hw/arm/virt-acpi-build: Improve comment in build_iort
Date: Sat, 28 Jun 2025 19:57:17 +0000
Message-Id: <20250628195722.977078-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250628195722.977078-1-gustavo.romero@linaro.org>
References: <20250628195722.977078-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qv1-xf33.google.com
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

When building the Root Complex table, the comment about the code that
maps the RC node to SMMU node is misleading because it reads
"RC -> SMMUv3 -> ITS", but the code is only mapping the RCs IDs to the
SMMUv3 node. The step of mapping from the SMMUv3 IDs to the ITS Group
node is actually defined in another table (in the SMMUv3 node). So
change the comment to read "RC -> SMMUv3" instead.

Signed-off-by Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt-acpi-build.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9eee284c80..e9cd3fb351 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -370,7 +370,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         /* DeviceID mapping index (ignored since interrupts are GSIV based) */
         build_append_int_noprefix(table_data, 0, 4);
 
-        /* output IORT node is the ITS group node (the first node) */
+        /* Output IORT node is the ITS Group node (the first node) */
         build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
     }
 
@@ -407,23 +407,36 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     if (vms->iommu == VIRT_IOMMU_SMMUV3) {
         AcpiIortIdMapping *range;
 
-        /* translated RIDs connect to SMMUv3 node: RC -> SMMUv3 -> ITS */
+        /*
+         * Map RIDs (input) from RC to SMMUv3 nodes: RC -> SMMUv3.
+         *
+         * N.B.: The mapping from SMMUv3 to ITS Group node (SMMUv3 -> ITS) is
+         * defined in the SMMUv3 table, where all SMMUv3 IDs are mapped to the
+         * ITS Group node.
+         */
         for (i = 0; i < smmu_idmaps->len; i++) {
             range = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
-            /* output IORT node is the smmuv3 node */
+            /* Output IORT node is the SMMUv3 node. */
             build_iort_id_mapping(table_data, range->input_base,
                                   range->id_count, smmu_offset);
         }
 
-        /* bypassed RIDs connect to ITS group node directly: RC -> ITS */
+        /*
+         * Map bypassed (don't go throught the SMMU) RIDs (input) to ITS Group
+         * node directly: RC -> ITS.
+         */
         for (i = 0; i < its_idmaps->len; i++) {
             range = &g_array_index(its_idmaps, AcpiIortIdMapping, i);
-            /* output IORT node is the ITS group node (the first node) */
+            /* Output IORT node is the ITS Group node (the first node). */
             build_iort_id_mapping(table_data, range->input_base,
                                   range->id_count, IORT_NODE_OFFSET);
         }
     } else {
-        /* output IORT node is the ITS group node (the first node) */
+        /*
+         * Map all RIDs (input) to ITS Group node directly, since there is no
+         * SMMU: RC -> ITS.
+         * Output IORT node is the ITS Group node (the first node).
+         */
         build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
     }
 
-- 
2.34.1


