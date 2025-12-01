Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A06D116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 14:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ4kD-0008NH-5u; Mon, 01 Dec 2025 09:19:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vQ4kA-0008IZ-QQ
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 09:19:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vQ4k6-0008Kg-S7
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 09:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764598745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1CrFa71CCM1qX3auV6g1zo9fM/xwzBDD7ik1D4FQARM=;
 b=VJXYpDUKjspVv/H1VLBCGKLYflwuVxRLmCeyr2zkxrC1SG8kUvMWXLEX7txOr4vg3XqH86
 rC2zbRM4cnuRi8pF4lfEfYCQbMEDVB1PBwLd8obRT9Ijd3m+F8z6sR0nNkU108/GijKSYM
 schmrylO9ABuVr8SMuW9bR/Tt3Eo8Sc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-iIc-on76PiqjJrpS6vyECw-1; Mon,
 01 Dec 2025 09:19:00 -0500
X-MC-Unique: iIc-on76PiqjJrpS6vyECw-1
X-Mimecast-MFC-AGG-ID: iIc-on76PiqjJrpS6vyECw_1764598739
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEE541801234; Mon,  1 Dec 2025 14:18:58 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.76])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A83D195608E; Mon,  1 Dec 2025 14:18:53 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, mst@redhat.com, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, imammedo@redhat.com, armbru@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v2 4/5] acpi/ghes: Bail early on error from
 get_ghes_source_offsets()
Date: Tue,  2 Dec 2025 00:18:02 +1000
Message-ID: <20251201141803.2386129-5-gshan@redhat.com>
In-Reply-To: <20251201141803.2386129-1-gshan@redhat.com>
References: <20251201141803.2386129-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In ghes_record_cper_errors(), get_ghes_source_offsets() can return
a error initialized by error_setg(). Without bailing on this error,
it can call into the second error_setg() due to the unexpected value
returned from the read acknowledgement register. The second error_setg()
can trigger assert(*errp == NULL) in its callee error_setv(), which
isn't expected.

Bail early in ghes_record_cper_errors() when error is received from
get_ghes_source_offsets() to avoid the unexpected behavior.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 6366c74248..c35883dfa9 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -443,7 +443,7 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
     *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
 }
 
-static void get_ghes_source_offsets(uint16_t source_id,
+static bool get_ghes_source_offsets(uint16_t source_id,
                                     uint64_t hest_addr,
                                     uint64_t *cper_addr,
                                     uint64_t *read_ack_start_addr,
@@ -474,7 +474,7 @@ static void get_ghes_source_offsets(uint16_t source_id,
         /* For now, we only know the size of GHESv2 table */
         if (type != ACPI_GHES_SOURCE_GENERIC_ERROR_V2) {
             error_setg(errp, "HEST: type %d not supported.", type);
-            return;
+            return false;
         }
 
         /* Compare CPER source ID at the GHESv2 structure */
@@ -488,7 +488,7 @@ static void get_ghes_source_offsets(uint16_t source_id,
     }
     if (i == num_sources) {
         error_setg(errp, "HEST: Source %d not found.", source_id);
-        return;
+        return false;
     }
 
     /* Navigate through table address pointers */
@@ -508,6 +508,8 @@ static void get_ghes_source_offsets(uint16_t source_id,
     cpu_physical_memory_read(hest_read_ack_addr, read_ack_start_addr,
                              sizeof(*read_ack_start_addr));
     *read_ack_start_addr = le64_to_cpu(*read_ack_start_addr);
+
+    return true;
 }
 
 NotifierList acpi_generic_error_notifiers =
@@ -526,9 +528,10 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
     if (!ags->use_hest_addr) {
         get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
                              &cper_addr, &read_ack_register_addr);
-    } else {
-        get_ghes_source_offsets(source_id, le64_to_cpu(ags->hest_addr_le),
-                                &cper_addr, &read_ack_register_addr, errp);
+    } else if (!get_ghes_source_offsets(source_id,
+                    le64_to_cpu(ags->hest_addr_le),
+                    &cper_addr, &read_ack_register_addr, errp)) {
+            return;
     }
 
     cpu_physical_memory_read(read_ack_register_addr,
-- 
2.51.1


