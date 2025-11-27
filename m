Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C3AD116E4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 00:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOQ8P-0000T0-41; Wed, 26 Nov 2025 19:45:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vOQ8J-0000P7-UF
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 19:45:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vOQ8G-0006fO-TY
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 19:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764204312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hJZHJutSaG2EsXCQPDcefCSnCjIQj+WaU8sibpmufkY=;
 b=bWLyiCSnff2xZh81OfqFtoxzVKHlIae0/7MimfjdRJtlIUdm+X8A/6i8uRBfKPBXx4AbZW
 JQ96es1GEWGZ3MrH86qLusoFpS52TCj48ac9GHYuyksYmpBeqof2H+ZCHCmAWeFushCYgd
 rh3Uz2e1Tdkvr0CJ4uJWRN1lXOHay1M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-eqiJ43aEPEGIH0bVagvkdA-1; Wed,
 26 Nov 2025 19:45:08 -0500
X-MC-Unique: eqiJ43aEPEGIH0bVagvkdA-1
X-Mimecast-MFC-AGG-ID: eqiJ43aEPEGIH0bVagvkdA_1764204307
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 219F0180035F; Thu, 27 Nov 2025 00:45:07 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.67])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A6D318004A3; Thu, 27 Nov 2025 00:45:00 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, mchehab+huawei@kernel.org,
 jonathan.cameron@huawei.com, armbru@redhat.com, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, gengdongjiu1@gmail.com,
 peter.maydell@linaro.org, pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH 1/5] acpi/ghes: Automate data block cleanup in
 acpi_ghes_memory_errors()
Date: Thu, 27 Nov 2025 10:44:31 +1000
Message-ID: <20251127004435.2098335-2-gshan@redhat.com>
In-Reply-To: <20251127004435.2098335-1-gshan@redhat.com>
References: <20251127004435.2098335-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
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

Use g_auto_ptr() to automate data block cleanup in the function so
that it won't be a burden to us.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 hw/acpi/ghes.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 06555905ce..6366c74248 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -565,9 +565,7 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
                   0xED, 0x7C, 0x83, 0xB1);
     Error *errp = NULL;
     int data_length;
-    GArray *block;
-
-    block = g_array_new(false, true /* clear */, 1);
+    g_autoptr(GArray) block = g_array_new(false, true /* clear */, 1);
 
     data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH;
     /*
@@ -585,8 +583,6 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
     /* Report the error */
     ghes_record_cper_errors(ags, block->data, block->len, source_id, &errp);
 
-    g_array_free(block, true);
-
     if (errp) {
         error_report_err(errp);
         return -1;
-- 
2.51.1


