Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD30C021A6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 04:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tin8b-0005V7-QD; Thu, 13 Feb 2025 23:17:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tin8a-0005Uv-7q
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 23:17:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tin8Y-0002ag-Li
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 23:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739506629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZbItnDkVozEodj/7S5tjbmbvM9HBQCKzb05IAlMJY8E=;
 b=ZLSYeSEAKArlKZJEliss31WfR+rL6kFZl+p3idg7oPF0xIG0L7oUjYznLdxXEVxcaZJfeG
 mhCLNmX0rxNdAjCTvgFf3EBdxYGLgnsHucDQ+wCAEsopKfEJgFk+I25dGv5tLnfLjzrxlR
 HU6YpxGLHa3kanN/QlhKr+TbDqVXX/s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-1lYm0kuqOtW4TFoXJ_T81g-1; Thu,
 13 Feb 2025 23:17:07 -0500
X-MC-Unique: 1lYm0kuqOtW4TFoXJ_T81g-1
X-Mimecast-MFC-AGG-ID: 1lYm0kuqOtW4TFoXJ_T81g
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B09F31975AFC; Fri, 14 Feb 2025 04:17:06 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.82])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97EC6191D7C8; Fri, 14 Feb 2025 04:17:02 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH 2/4] acpi/ghes: Use error_report() in ghes_record_cper_errors()
Date: Fri, 14 Feb 2025 14:16:33 +1000
Message-ID: <20250214041635.608012-3-gshan@redhat.com>
In-Reply-To: <20250214041635.608012-1-gshan@redhat.com>
References: <20250214041635.608012-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

An error object is created by ghes_record_cper_errors() to collect
the error messages in its failing path. The caller prints the error
messages and determine its return value base on the error object.

It's unnecessary to use an error object if the error number is
returned by ghes_record_cper_errors() and the error messages are
printed with error_report() in the function.

It's the preparatory work to add parameter for ghes_record_cper_errors()
to indicate if the request can be retried by its callers. No functional
changes intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 hw/acpi/ghes.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index b85bb48195..a67326fd50 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -390,23 +390,23 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
     *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
 }
 
-static void ghes_record_cper_errors(const void *cper, size_t len,
-                                    uint16_t source_id, Error **errp)
+static int ghes_record_cper_errors(const void *cper, size_t len,
+                                   uint16_t source_id)
 {
     uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
     AcpiGedState *acpi_ged_state;
     AcpiGhesState *ags;
 
     if (len > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
-        error_setg(errp, "GHES CPER record is too big: %zd", len);
-        return;
+        error_report("GHES CPER record is too big: %zd", len);
+        return -1;
     }
 
     acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
                                                        NULL));
     if (!acpi_ged_state) {
-        error_setg(errp, "Can't find ACPI_GED object");
-        return;
+        error_report("Can't find ACPI_GED object");
+        return -1;
     }
     ags = &acpi_ged_state->ghes_state;
 
@@ -415,8 +415,8 @@ static void ghes_record_cper_errors(const void *cper, size_t len,
                          &cper_addr, &read_ack_register_addr);
 
     if (!cper_addr) {
-        error_setg(errp, "can not find Generic Error Status Block");
-        return;
+        error_report("can not find Generic Error Status Block");
+        return -1;
     }
 
     cpu_physical_memory_read(read_ack_register_addr,
@@ -424,10 +424,9 @@ static void ghes_record_cper_errors(const void *cper, size_t len,
 
     /* zero means OSPM does not acknowledge the error */
     if (!read_ack_register) {
-        error_setg(errp,
-                   "OSPM does not acknowledge previous error,"
-                   " so can not record CPER for current error anymore");
-        return;
+        error_report("OSPM does not acknowledge previous error,"
+                     " so can not record CPER for current error anymore");
+        return -1;
     }
 
     read_ack_register = cpu_to_le64(0);
@@ -440,6 +439,8 @@ static void ghes_record_cper_errors(const void *cper, size_t len,
 
     /* Write the generic error data entry into guest memory */
     cpu_physical_memory_write(cper_addr, cper, len);
+
+    return 0;
 }
 
 int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
@@ -448,9 +449,8 @@ int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
     const uint8_t guid[] =
           UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
                   0xED, 0x7C, 0x83, 0xB1);
-    Error *errp = NULL;
-    int data_length;
     GArray *block;
+    int data_length, ret;
 
     block = g_array_new(false, true /* clear */, 1);
 
@@ -468,16 +468,11 @@ int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
     acpi_ghes_build_append_mem_cper(block, physical_address);
 
     /* Report the error */
-    ghes_record_cper_errors(block->data, block->len, source_id, &errp);
+    ret = ghes_record_cper_errors(block->data, block->len, source_id);
 
     g_array_free(block, true);
 
-    if (errp) {
-        error_report_err(errp);
-        return -1;
-    }
-
-    return 0;
+    return ret;
 }
 
 bool acpi_ghes_present(void)
-- 
2.48.1


