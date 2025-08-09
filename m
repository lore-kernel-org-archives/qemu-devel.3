Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42528C87FCB
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 21:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukqqN-0002p0-2W; Sat, 09 Aug 2025 17:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chichikalyuk@gmail.com>)
 id 1ukqqL-0002kd-AW; Sat, 09 Aug 2025 17:11:09 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chichikalyuk@gmail.com>)
 id 1ukqqJ-0000SR-1s; Sat, 09 Aug 2025 17:11:09 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-61521cd7be2so4424481a12.3; 
 Sat, 09 Aug 2025 14:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754773865; x=1755378665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E3E7y/HiFOV12vylnrfnt9s4sgvYTh8dgFULKwaB7zg=;
 b=na6XiCxkzhuDQVeDNW2zxRpIKSOP31lg1yJDTfwi7XnCk0Ih+Jps77WhRI55z0beqL
 U7apTbrhPMxyfDVexEVa25RzFdAWTL9hTP9Eo0kEMUwnPZx2Ainhua0B1Fi6GrJNNoIn
 /jR6eFwTprbfHOG7uEZNcFaNXWmPYHneRPLx2RbQXPeZIKp2XYvvCocjxPZG6KixbqvW
 +hNqm8wa/x6qRCDMRDVKRgdW40+uX9AggC5xLPqw6BHr8s7BIhzo8dSCmNqQGzzZiSdw
 8w15AaTomHApJ7UPzJoqU6t8uV2b72OGPr230/0DVaWFGb+J+R0jYxBF5bwdCEnBpZt6
 U4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754773865; x=1755378665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E3E7y/HiFOV12vylnrfnt9s4sgvYTh8dgFULKwaB7zg=;
 b=D/orUX7DS9kFvSVk11TDRd+D9tQQbzTGXESM79i4DSxkV0znl1Gza0eRlPgCN5qMCO
 RHnhWWXeylxlleM0i2H47cnY85Bq5DYxYog+U19zivFmcq3b9uS0vx/HluH3iC6jrKZR
 60w4Oic623dKbV0qZPLk7qUm7Cy7phZ4rLN25St+tGAWscQIgRdKq9/i7rcIz/dz6Bi2
 iQZV1JIpGQrQqOadBjkVun4xCLTqKMKZRJT2YdFH2am0QlV9JHkJgH5NTIDoR/S4nyjP
 gDzeKz2xyGHKCoscIf0RfF4DGfPSok5qsvPwLPWJ7kBYW6cTXXd7Ta0RDQIG5JmS8cQw
 8exw==
X-Gm-Message-State: AOJu0YxWfRHIVVGS57R+DrvZgBx4DJ9ybBpONNv5WmTyZ6Hoel07iZ9u
 F4ZHbNLwN76PfhV4tPvh4JYIjiW8XLtrz8B2YhRGVmDlXHY+woeOGBkFj9vuVJv36pk=
X-Gm-Gg: ASbGncv8Ooi+ANt9WX8216im9PAIsKBNiN0ZnN+IGLwigbnW+ala5VIDvLJim6Icf6k
 fZHZCb/vNzamHvKYZrMhbalajd20aFbFiPNy6FCJUH6Jcqk4VYsV2xdOby6GDdN+ZdM7esMMfGZ
 or7ICfq1PJ4mRcOkSz41ubW6u5SHPz0YVgdO6CfthS97pADiiL7k1JB7nolyELAEjEhDUAxn6rd
 AlJrigqpgCAJg64LTPRus/IJAFNJr4+3bVwVJkVamoTFTCnUYbQkUht6oiIz/coTwb+oS8HrCir
 uRl+22qwLPm74XPRXhAGc0UgfQhPKvFbzIw14qElTPAFygdqZZArm6XUmJiW2rhUFxa5zEvdwYJ
 mk17y0p9U5GU+C9e3pF2oFj+fx5ArN+ylNDHa+57t5ehE51+h
X-Google-Smtp-Source: AGHT+IEdS47Lh0kda4tg6mPXOJ+pT2xgh6rqFMrVPWfj0R9b1PM/WAJ2+7+6mw6TekMMJxsukISy/w==
X-Received: by 2002:a17:907:7f90:b0:af2:9a9d:2857 with SMTP id
 a640c23a62f3a-af9c6375b94mr676408366b.3.1754773864471; 
 Sat, 09 Aug 2025 14:11:04 -0700 (PDT)
Received: from localhost.localdomain ([87.251.30.120])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-af91a078a11sm1759490766b.7.2025.08.09.14.11.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Aug 2025 14:11:04 -0700 (PDT)
From: Vadim Chichikalyuk <chichikalyuk@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Vadim Chichikalyuk <chichikalyuk@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 2/3] hw: arm: acpi: upgrade SPCR table to revision 4
Date: Sun, 10 Aug 2025 00:10:50 +0300
Message-Id: <20250809211051.68824-3-chichikalyuk@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250809211051.68824-1-chichikalyuk@gmail.com>
References: <20250809211051.68824-1-chichikalyuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=chichikalyuk@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On the ARM virt machine, there is currently no way to programmatically
discover the frequency of the UART reference clock solely through the use of
UEFI/ACPI (without the DTB). The SPCR table can include this information
as of revision 4, but is currently at revision 2.

Bump the revision to 4, add the clock frequency of 24 MHz and
complete the other new fields.

Signed-off-by: Vadim Chichikalyuk <chichikalyuk@gmail.com>
---
 hw/arm/virt-acpi-build.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index b01fc4f8ef..f685668c5e 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -536,6 +536,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 static void
 spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
+    const char name[] = ".";
     AcpiSpcrData serial = {
         .interface_type = 3,       /* ARM PL011 UART */
         .base_addr.id = AML_AS_SYSTEM_MEMORY,
@@ -559,13 +560,14 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         .pci_function = 0,
         .pci_flags = 0,
         .pci_segment = 0,
+        .uart_clk_freq = 24000000,
+        .precise_baudrate = 0,
+        .namespace_string_length = sizeof(name),
+        .namespace_string_offset = 88,
     };
-    /*
-     * Passing NULL as the SPCR Table for Revision 2 doesn't support
-     * NameSpaceString.
-     */
-    build_spcr(table_data, linker, &serial, 2, vms->oem_id, vms->oem_table_id,
-               NULL);
+
+    build_spcr(table_data, linker, &serial, 4, vms->oem_id, vms->oem_table_id,
+               name);
 }
 
 /*
-- 
2.39.5 (Apple Git-154)


