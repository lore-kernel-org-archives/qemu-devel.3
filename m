Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE151C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7r6-0000g6-Jp; Wed, 15 Jan 2025 13:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qD-0007JC-Kl
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qB-0006vL-4J
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uGpzkzEPXjWW+cnhrycoe32wPN8igkpXmmUB96WL6XY=;
 b=JaRfHXi7ZcYONpYorHIfWCa2X4VOCVAokUoCz3kTboekWBE6MChpHD7nQwzOVM+O+uZnIH
 /I+2QTQTRmB9XYaAaWhEN0LoVKJ6ck5UEiZJrG09EVN83MmRQIwakOArb+zSOUowpFDboC
 1Q5qrD7JaHeERLSR5JKRaOybaH0Y4f4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-A9oQdMIrPZ-CrUXwAmMI7Q-1; Wed, 15 Jan 2025 13:10:05 -0500
X-MC-Unique: A9oQdMIrPZ-CrUXwAmMI7Q-1
X-Mimecast-MFC-AGG-ID: A9oQdMIrPZ-CrUXwAmMI7Q
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38639b4f19cso91433f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964603; x=1737569403;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uGpzkzEPXjWW+cnhrycoe32wPN8igkpXmmUB96WL6XY=;
 b=MMR9zz/O1c4HARADvGL3nPK/OnGsp0WlHIZBwazRLsaEX7wwVA7FRb3kBhqUZ9zDSm
 OYpE/WoZ2eHC4FcvH/d1gt1B3W2ldfSbmg75Y/Rf2tQtTtWdYyY9hDYfQtwV+0fpAiQs
 mq7OliHywtV/57mSTuGCWmc4od924kkUH/JjU1UeriSbZl68JrqK96Cwn5gweVLAz/fj
 CzZ+kxtfCVxT8jQ56omxe8SNRFeYw6kZ0a4VIA0fzuzmSbhaibZpeeI996YAC/f4pGfo
 ifxfkwisSLxTF5r6sfI7R4pwuimN4exU7Ru6Y2nA5/91rX+efiL6ToN1/YsxJVatDoMw
 aONA==
X-Gm-Message-State: AOJu0YzBZL1V79icbtPqGCckDjdQ/gX9BkRBNVQQLpqczvEPdLrfGn0O
 YeYp62K3F0HWDx3sKXOMQaBQpXDqX/x0x3vBANZQXlWiZOmxhIsPZqMamfxQI6W0Y3q6AmbZpcc
 r4fVdznna/KRc6Jlz1rS21esb2WJM9nOyd2lSsO6pYKVdtQZzcPsNT33puZCqO2IqU4tohbuIWR
 F+g4LdJbpxmy8KHJlHCPe6PZ/VdDcvlg==
X-Gm-Gg: ASbGnctxHsbYiydPy252moCZByK7hlNSRL/JnF00YOQJXmyoAIns1mfscmlBzy1SdI2
 t/RPx+1WTUY54RwbPxjMb9N0LJg+e/1Mh36yw0s9gLKXYCR7EHtGXKa5rMdmtzh1mWtPws1GN8e
 MWIL21xjFS6a2a2anEXLcS4LiTBR+/4V8qNDa5g3rL1ETA2HCNCiXWeq4VJL1clV99nmYIoOygz
 VtJZVEHu4NDl3X3VstlxyVn642d6pubTQIbK7yvY3aC+4ml4YB/
X-Received: by 2002:a05:6000:184e:b0:382:46ea:113f with SMTP id
 ffacd0b85a97d-38a872fc1b3mr29161512f8f.10.1736964603465; 
 Wed, 15 Jan 2025 10:10:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoyPY8qKPIlAzIF65FSl/IiWWSA75r6C+kdnuMmKsI3XQxaDQW3OeSqnU5Okvi20qBRxy81w==
X-Received: by 2002:a05:6000:184e:b0:382:46ea:113f with SMTP id
 ffacd0b85a97d-38a872fc1b3mr29161464f8f.10.1736964602858; 
 Wed, 15 Jan 2025 10:10:02 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d01dsm18121376f8f.9.2025.01.15.10.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:10:02 -0800 (PST)
Date: Wed, 15 Jan 2025 13:09:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL 29/48] acpi/ghes: simplify the per-arch caller to build HEST
 table
Message-ID: <606a42c4c1d46b31a95cab09a7033e7f22f9ed3d.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The GHES driver requires not only a HEST table, but also a
separate firmware file to store Error Structure records.
It can't do one without the other.

Simplify the caller logic for it to require one function.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Message-Id: <9584bb8953385e165681d5d185c503f8df8ef42f.1736945236.git.mchehab+huawei@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/ghes.h   | 4 ++--
 hw/acpi/ghes.c           | 7 +++++--
 hw/arm/virt-acpi-build.c | 5 ++---
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 59e3b8fb24..20016c226d 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -68,8 +68,8 @@ typedef struct AcpiGhesState {
     bool present; /* True if GHES is present at all on this board */
 } AcpiGhesState;
 
-void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker);
-void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
+void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
+                     BIOSLinker *linker,
                      const char *oem_id, const char *oem_table_id);
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index e66f3be150..4a6c45bcb4 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -233,7 +233,7 @@ static int acpi_ghes_record_mem_error(uint64_t error_block_address,
  * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
  * See docs/specs/acpi_hest_ghes.rst for blobs format.
  */
-void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
+static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
 {
     int i, error_status_block_offset;
 
@@ -356,12 +356,15 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
 }
 
 /* Build Hardware Error Source Table */
-void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
+void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
+                     BIOSLinker *linker,
                      const char *oem_id, const char *oem_table_id)
 {
     AcpiTable table = { .sig = "HEST", .rev = 1,
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
 
+    build_ghes_error_table(hardware_errors, linker);
+
     acpi_table_begin(&table, table_data);
 
     /* Error Source Count */
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index c9b13057a3..3ac8f8e178 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -946,10 +946,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     build_dbg2(tables_blob, tables->linker, vms);
 
     if (vms->ras) {
-        build_ghes_error_table(tables->hardware_errors, tables->linker);
         acpi_add_table(table_offsets, tables_blob);
-        acpi_build_hest(tables_blob, tables->linker, vms->oem_id,
-                        vms->oem_table_id);
+        acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
+                        vms->oem_id, vms->oem_table_id);
     }
 
     if (ms->numa_state->num_nodes > 0) {
-- 
MST


