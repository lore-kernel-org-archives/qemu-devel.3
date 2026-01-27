Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA54D2D8E2
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 10:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfra-0001nn-C1; Tue, 27 Jan 2026 04:59:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vkfrY-0001nS-V2
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:59:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vkfrX-0004Xm-I4
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769507994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WBzv/EEHOLl1lvpY0Tolfh3wVeN8GBPJIxvAOWVtvEE=;
 b=UH587HgoiUBaHjcEO+dtrWT2LwFQSyms83d6TsWvWggQj4XidfSHRY8q5cEp+yyA+H3GBQ
 ua1dYDQ1k+TLB2AjJk5iYTi91GMmWgui3uz2d0S6uPXOX7WzLQvvJuergp2xPYf7lxfHyI
 HgbC9PboTVdoGvrb/Zzsw8y6Sy1zlqs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-X6xRwTTRNX-EnlP50FozHg-1; Tue,
 27 Jan 2026 04:59:51 -0500
X-MC-Unique: X6xRwTTRNX-EnlP50FozHg-1
X-Mimecast-MFC-AGG-ID: X6xRwTTRNX-EnlP50FozHg_1769507989
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7665F180044D; Tue, 27 Jan 2026 09:59:49 +0000 (UTC)
Received: from osteffen-thinkpadx1carbongen12.rmtde.csb (unknown
 [10.44.34.174])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 98E5A19560B2; Tue, 27 Jan 2026 09:59:44 +0000 (UTC)
From: Oliver Steffen <osteffen@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Joerg Roedel <joerg.roedel@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, kvm@vger.kernel.org,
 Oliver Steffen <osteffen@redhat.com>
Subject: [PATCH v5 1/6] hw/acpi: Make BIOS linker optional
Date: Tue, 27 Jan 2026 10:59:31 +0100
Message-ID: <20260127095936.1072464-2-osteffen@redhat.com>
In-Reply-To: <20260127095936.1072464-1-osteffen@redhat.com>
References: <20260127095936.1072464-1-osteffen@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=osteffen@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Make the BIOS linker optional in acpi_table_end() and calculate the ACPI
table checksum directly if no linker is provided.

This makes it possible to call for example
acpi_build_madt() from outside the ACPI table builder context.

Signed-off-by: Oliver Steffen <osteffen@redhat.com>
---
 hw/acpi/aml-build.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index dad4cfcc7d..6a3650076f 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1730,6 +1730,25 @@ void acpi_table_begin(AcpiTable *desc, GArray *array)
     build_append_int_noprefix(array, 1, 4); /* Creator Revision */
 }
 
+static uint8_t calculate_acpi_checksum(const gchar *data, size_t len)
+{
+    size_t i;
+    uint8_t sum = 0;
+
+    for (i = 0; i < len; ++i) {
+        sum += (uint8_t)data[i];
+    }
+
+    return sum;
+}
+
+static void update_acpi_checksum(gchar *data, size_t start_offset,
+                                 size_t table_len, size_t checksum_offset)
+{
+    uint8_t sum = calculate_acpi_checksum(&data[start_offset], table_len);
+    data[checksum_offset] = 0xff - sum + 1;
+}
+
 void acpi_table_end(BIOSLinker *linker, AcpiTable *desc)
 {
     /*
@@ -1748,8 +1767,14 @@ void acpi_table_end(BIOSLinker *linker, AcpiTable *desc)
      */
     memcpy(len_ptr, &table_len_le, sizeof table_len_le);
 
-    bios_linker_loader_add_checksum(linker, ACPI_BUILD_TABLE_FILE,
-        desc->table_offset, table_len, desc->table_offset + checksum_offset);
+    if (linker != NULL) {
+        bios_linker_loader_add_checksum(linker, ACPI_BUILD_TABLE_FILE,
+                                        desc->table_offset, table_len,
+                                        desc->table_offset + checksum_offset);
+    } else {
+        update_acpi_checksum(desc->array->data, desc->table_offset,
+                             table_len, desc->table_offset + checksum_offset);
+    }
 }
 
 void *acpi_data_push(GArray *table_data, unsigned size)
-- 
2.52.0


