Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF6F606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OeTtuTgx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNc2E-0001iz-7d; Sun, 01 Nov 2026 15:20:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzu-00056p-LC
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzi-0007Ec-8k
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793564253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z6QtiCWszoDvq+oJvCKXSbkcKh+jiykbh8awKa6VF8s=;
 b=OeTtuTgx4LzDG4PSCaMP8XJ8feXvORPJvYTuT/hRukmtZ6y6FzF23RvlrvByAXOJk5LZFu
 V0Au8feMZb8f800jucvi9rW+ZMi8FsXx1U3s4ERzyZocSKOZ56vgGlftugkfSzZ3qUSax5
 xG/nXUbTD832Xzg/4zVyV+Pv0ZPDakU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-vOc-9bqsNA2mXUq7mnfzIA-1; Sun,
 01 Nov 2026 15:17:30 -0500
X-MC-Unique: vOc-9bqsNA2mXUq7mnfzIA-1
X-Mimecast-MFC-AGG-ID: vOc-9bqsNA2mXUq7mnfzIA_1793564249
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 494FC1955F43; Sun,  1 Nov 2026 20:17:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE3FD1956086; Sun,  1 Nov 2026 20:17:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 84E9A21E6742; Sun, 01 Nov 2026 21:17:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v8 50/56] target/riscv: convert PropertyInfo definitions to
 use qapi_type
Date: Sun,  1 Nov 2026 21:17:11 +0100
Message-ID: <20261101201717.3911097-51-armbru@redhat.com>
In-Reply-To: <20261101201717.3911097-1-armbru@redhat.com>
References: <20261101201717.3911097-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Mechanically add a .qapi_type pointer to PropertyInfo definitions in
target/riscv/cpu.c.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 target/riscv/cpu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index adb53aad96..362e561809 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1730,6 +1730,7 @@ static void prop_pmu_num_get(Object *obj, Visitor *v, const char *name,
 
 static const PropertyInfo prop_pmu_num = {
     .type = "uint8",
+    .qapi_type = &uint8_type_info,
     .description = "pmu-num",
     .get = prop_pmu_num_get,
     .set = prop_pmu_num_set,
@@ -1772,6 +1773,7 @@ static void prop_pmu_mask_get(Object *obj, Visitor *v, const char *name,
 
 static const PropertyInfo prop_pmu_mask = {
     .type = "uint32",
+    .qapi_type = &uint32_type_info,
     .description = "pmu-mask",
     .get = prop_pmu_mask_get,
     .set = prop_pmu_mask_set,
@@ -1804,6 +1806,7 @@ static void prop_mmu_get(Object *obj, Visitor *v, const char *name,
 
 static const PropertyInfo prop_mmu = {
     .type = "bool",
+    .qapi_type = &bool_type_info,
     .description = "mmu",
     .get = prop_mmu_get,
     .set = prop_mmu_set,
@@ -1837,6 +1840,7 @@ static void prop_pmp_get(Object *obj, Visitor *v, const char *name,
 
 static const PropertyInfo prop_pmp = {
     .type = "bool",
+    .qapi_type = &bool_type_info,
     .description = "pmp",
     .get = prop_pmp_get,
     .set = prop_pmp_set,
@@ -1877,6 +1881,7 @@ static void prop_num_pmp_regions_get(Object *obj, Visitor *v, const char *name,
 
 static const PropertyInfo prop_num_pmp_regions = {
     .type = "uint8",
+    .qapi_type = &uint8_type_info,
     .description = "num-pmp-regions",
     .get = prop_num_pmp_regions_get,
     .set = prop_num_pmp_regions_set,
@@ -1915,6 +1920,7 @@ static void prop_pmp_granularity_get(Object *obj, Visitor *v, const char *name,
 
 static const PropertyInfo prop_pmp_granularity = {
     .type = "uint32",
+    .qapi_type = &uint32_type_info,
     .description = "pmp-granularity",
     .get = prop_pmp_granularity_get,
     .set = prop_pmp_granularity_set,
@@ -1991,6 +1997,7 @@ static void prop_priv_spec_get(Object *obj, Visitor *v, const char *name,
 
 static const PropertyInfo prop_priv_spec = {
     .type = "str",
+    .qapi_type = &str_type_info,
     .description = "priv_spec",
     /* FIXME enum? */
     .get = prop_priv_spec_get,
@@ -2024,6 +2031,7 @@ static void prop_vext_spec_get(Object *obj, Visitor *v, const char *name,
 
 static const PropertyInfo prop_vext_spec = {
     .type = "str",
+    .qapi_type = &str_type_info,
     .description = "vext_spec",
     /* FIXME enum? */
     .get = prop_vext_spec_get,
@@ -2108,6 +2116,7 @@ static void prop_elen_get(Object *obj, Visitor *v, const char *name,
 
 static const PropertyInfo prop_elen = {
     .type = "uint16",
+    .qapi_type = &uint16_type_info,
     .description = "elen",
     .get = prop_elen_get,
     .set = prop_elen_set,
@@ -2144,6 +2153,7 @@ static void prop_cbom_blksize_get(Object *obj, Visitor *v, const char *name,
 
 static const PropertyInfo prop_cbom_blksize = {
     .type = "uint16",
+    .qapi_type = &uint16_type_info,
     .description = "cbom_blocksize",
     .get = prop_cbom_blksize_get,
     .set = prop_cbom_blksize_set,
@@ -2180,6 +2190,7 @@ static void prop_cbop_blksize_get(Object *obj, Visitor *v, const char *name,
 
 static const PropertyInfo prop_cbop_blksize = {
     .type = "uint16",
+    .qapi_type = &uint16_type_info,
     .description = "cbop_blocksize",
     .get = prop_cbop_blksize_get,
     .set = prop_cbop_blksize_set,
@@ -2216,6 +2227,7 @@ static void prop_cboz_blksize_get(Object *obj, Visitor *v, const char *name,
 
 static const PropertyInfo prop_cboz_blksize = {
     .type = "uint16",
+    .qapi_type = &uint16_type_info,
     .description = "cboz_blocksize",
     .get = prop_cboz_blksize_get,
     .set = prop_cboz_blksize_set,
@@ -2252,6 +2264,7 @@ static void prop_mvendorid_get(Object *obj, Visitor *v, const char *name,
 
 static const PropertyInfo prop_mvendorid = {
     .type = "uint32",
+    .qapi_type = &uint32_type_info,
     .description = "mvendorid",
     .get = prop_mvendorid_get,
     .set = prop_mvendorid_set,
@@ -2288,6 +2301,7 @@ static void prop_mimpid_get(Object *obj, Visitor *v, const char *name,
 
 static const PropertyInfo prop_mimpid = {
     .type = "uint64",
+    .qapi_type = &uint64_type_info,
     .description = "mimpid",
     .get = prop_mimpid_get,
     .set = prop_mimpid_set,
@@ -2345,6 +2359,7 @@ static void prop_marchid_get(Object *obj, Visitor *v, const char *name,
 
 static const PropertyInfo prop_marchid = {
     .type = "uint64",
+    .qapi_type = &uint64_type_info,
     .description = "marchid",
     .get = prop_marchid_get,
     .set = prop_marchid_set,
-- 
2.55.0


