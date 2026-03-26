Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCA610A3D80
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 12:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5jh7-0003Xh-1W; Thu, 26 Mar 2026 08:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1w5jgt-0003T4-DV
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 08:20:00 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1w5jgq-0003Sn-Sg
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 08:19:58 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8973B3F452
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 12:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1774527593;
 bh=2a4uksXmDEhXbA8oCTGNFyxIUIo38RL710NsO82kbCA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=pRrvARaGECMJm+iwN1ERuEH2Q9rtmWrcNA3INIBTa4kOp80NKRmQckc2Hh7qLD/XP
 N+ezLONqAaqlFh7IdO+1QszrdxQDExFymS4PpqDo7Y7bIEXIiKOKwru2khsiCX/wtS
 /CPv4wiP+mFSi4xGcaG6ezVvUNKc985QlnzMosxAE/HL070/ZueMHwlPa2wi9u88HV
 l8/w6syv6dCNqr6Q+vMk4RmRCA7d1UgAf+4lUva3RRa7ZUUsZ8/7HRwLzwkaqwXmLx
 STChmJ2NG3j0MRQEbtHaTvuQyyZCypVW1Dp4oqfoLiDpKLVBE+snUTXOVUhImeKIvG
 L0vg+/U0qAxPhLhAGoubV4Pvs4Us18c1CZqyXh3P1NDUEueVBelkWFRKCKmxU79VWL
 neDfL/f8LTmi83wUQfXJg9E4uxHA2eA1XF/XXP9FrbRskWkBbpgZgHsERjryoE9Bfx
 Hw9AlXXN7AE6HsaK7qjcKMRjW+2ZD7waw3K/6Gye8DK5jpWqb5u5wi//2wPapR5VET
 c2Hi274FGgeYATq2WhZq290mDZVDuh+vnlxUI6hHbWHUtc3Z+PzvtptqOm7KpI0x6C
 ciKHU7dqe0w9YWFnQ24ul/qH3BNNKhkFdwUNbdG2vyhnprM6/axpmcZ1+ubFaMZkM1
 BzyOK8fs1S3NuWcopTx1B+Tc=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48553fdd03dso5793585e9.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 05:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774527593; x=1775132393;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2a4uksXmDEhXbA8oCTGNFyxIUIo38RL710NsO82kbCA=;
 b=GzhymnmNkT0RduGn24FWC3PxncsDnWZYimIUYOAf+zaLhspEkNRikT9rJhLPktdM+Y
 ALB5MHzOB2GaaZ99P0aChDcR1xHHT7d05RUXZUgh7Xbs0ht7MzTgMbuwqm+9d8FttVDK
 u0Yx/iB5Ig6JbFYzq3HPGe9BibFB7w+dpCuaXv+j4LCwFBWb2/G7/HKpCQ7bI4XfS+Km
 FIA2uig71DEN8zZrycATI5xEYgW9XSxWEJwsVd12aBfrPdAIU0WwZJJ1LdfiLOWSbvKT
 oQivr+fcfcZ/j0/j8umTtGfPE8IOaKn108BPKk+WhYfdx0QdkJdnS3pClZjE0lxt4v9i
 xoPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxCuvnn0+vE2R1YXZeiqgWTWOYhLPsDJZbGUCbKmWHvScF4QQy1/jNNQR72quXKPHoFvvE6Ldxekbm@nongnu.org
X-Gm-Message-State: AOJu0YypXS+4ILnxUu2creR7i87RPSfQyNvB1rksXGrrqWnur8Vg7cRq
 H1XzMQ0foCYfm/zMPMOD9JbwQ7LtVNKzecmJJOguThHCe06TYYd8gO2qk0qj+IJ9QLRv/KVGMbD
 OoZozOIVZ5VjiKYiRTXcVxL0qDNadpZcmSyHL4kncQ/cwGtS1gJ5KNdnaLuP/DGUJMZlsYGa9
X-Gm-Gg: ATEYQzwRpm1Euutz97RuvXrTzHFbF4CgSzV6G9W1fnBlNmihpSxADUbbAQaVnKqyH5j
 J2zIHHGVmI7j+YVr7U6GVfA9ZbwUuMgdyIZ37LNqgjVRB22U8lj2h9bJOh4hov0ObkZAnaJ2kGW
 +gJqcpO7SaOjrP8K7IFRMbAtm05eBK3Xk2MpJ9P2rBj1D5utfJaMpqdqacjmSLRsZL/oFkCMuQR
 9qLlZIVW6R72awCIRSTWj6glOsWixOctsMQXl+kmvONE6wvC/pPARp/+23Zh/VT+8zNAKU6qtpt
 6Gd2NkbSBZ1dzcVJUlKM/8rz8OrhdKZlGAo+3yaektjCvcofE1+LaGfG50gAa0oBtPLVWwd/bNo
 Cs02W9Ix4B0s67vXImdlixbqmWznnUI+5VYK9PVdiS2LkZFpat19HDWMJg/oU4HL9AQ56fkuSSg
 VFYrEuSW3wNhscIy4DRDxqqquIo3yFBbkYcsf1lfyhBxHF
X-Received: by 2002:a05:600c:a010:b0:487:4cb:2fe4 with SMTP id
 5b1f17b1804b1-487160bccf1mr112645955e9.33.1774527592940; 
 Thu, 26 Mar 2026 05:19:52 -0700 (PDT)
X-Received: by 2002:a05:600c:a010:b0:487:4cb:2fe4 with SMTP id
 5b1f17b1804b1-487160bccf1mr112645365e9.33.1774527592491; 
 Thu, 26 Mar 2026 05:19:52 -0700 (PDT)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919e7111sm7587721f8f.37.2026.03.26.05.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 05:19:51 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] hw/acpi: correct field sequence in SPCR table
Date: Thu, 26 Mar 2026 13:19:47 +0100
Message-ID: <20260326121947.51200-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_TRY_3LD=1.999 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On LoongArch and RISC-V invalid SPCR tables are created:

Terrminal Type : 00
Language : 03

The correct values are:

Terrminal Type : 03
Language : 00

This is due to commit 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate
SPCR creation to common location") that swapped the fields.

See the specification of the table in
https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table

Fixes: 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate SPCR creation to common location")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 hw/acpi/aml-build.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 4b37405088..a999320e61 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2115,10 +2115,10 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
     build_append_int_noprefix(table_data, f->stop_bits, 1);
     /* Flow Control */
     build_append_int_noprefix(table_data, f->flow_control, 1);
-    /* Language */
-    build_append_int_noprefix(table_data, f->language, 1);
     /* Terminal Type */
     build_append_int_noprefix(table_data, f->terminal_type, 1);
+    /* Language */
+    build_append_int_noprefix(table_data, f->language, 1);
     /* PCI Device ID  */
     build_append_int_noprefix(table_data, f->pci_device_id, 2);
     /* PCI Vendor ID */
-- 
2.53.0


