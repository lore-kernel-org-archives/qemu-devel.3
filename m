Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF72CD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4aW-0006Y8-Pg; Sun, 10 May 2026 09:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4aB-000634-Kt
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:52:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4aA-0006MF-0L
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778421153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0GjCGtKeG9fzev/GMINLw7UjJKRN2NVyc3EF+6PoAeI=;
 b=Mar3NN6qPyeLPTQuOQAYD2X59UVGhXLpo/5hxG0+p9f4ysRs2R1d/1qdAwMPrFBF9C+LQo
 sg2CCGObyYpk/REnzIeGsKWc1B104XtoO3mqzdsAYoSvT4Ci6x3ZTIu3ncy5HGfiXLHTwj
 BdKhxYTem+nMDaxr6XyEE5Y20AYvmIk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-WbsENzMiMPylPCufIUhdnQ-1; Sun,
 10 May 2026 09:52:31 -0400
X-MC-Unique: WbsENzMiMPylPCufIUhdnQ-1
X-Mimecast-MFC-AGG-ID: WbsENzMiMPylPCufIUhdnQ_1778421151
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0093E180056E
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:52:31 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D37AF1955D84; Sun, 10 May 2026 13:52:26 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:44 +0400
Subject: [PATCH 47/54] target/riscv: convert PropertyInfo definitions to
 use qapi_type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-47-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5356;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3wfdhLWQPZkv6/pR3DsVZoEn9q6Nl9IcCviTZIy4xD0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItxJBsLnjWCHbRJ8NjdRP8c5YhWC9Ax3LRMY
 U3ppy3zxkaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLcQAKCRDa6OEJdZac
 5VuJD/4k1almgcxpfFtlfip6kAHD4uT+1e4YjOtmU5zvX3MmorUUF5k76bAQ3P46mPc1MSq5fE9
 QupXJFDrtAIqgaKn8P2pRr+sLkkLDYy+9S7adXYUc6vs6GPo/Rv7Sgu17WI469154QbfDP136Ie
 HoSae4yxwwKJidMGexXbDr0arq3UbSewtUq+2brc9EGe5nOuiPNDnceZ/tU0fRZb0p3n6JOy1Cy
 YjWgWpBIugw74RV7b4p6kxUuHfagHgYs+JNnqj3UxZfTPjL3QmqdH08ssMxV/UOAZN3EeOAlg5K
 igKbqnGFM0SoSywrgLF0f2X/v1xm3m9un4mXvuhXCvulMt9NOmMgLwjaj3Cyul9IN/3IxK/vChV
 zhrnbJ2O/0H7we2V+XexC05jMZPsXuaGcnCfBAMfVyfWu0y9CMmke6k7IEV6zf4ceR0PrpEnUkq
 EAlo4l9c75aR1PMblInDZpnIiKtokFGgScCwMFa0aF7E/qZLHbajmDU7hZlklfPkvvWUrwmsK3D
 iW+JnOCXHbqHlU4KFN6yi7+zNE5veHLEP3+XpMxtHPPRr/3fZ9ZegAfKhiAGXVhDvPUirqx0FRo
 pm+3ulSnEu/RBj5nHKKfWMtUPttDJFBiV1dJUSPImCLuEELs6gOTm6pXn43A9yXvkdK7AL3REUe
 KDQ25WGrG//Mgxg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Mechanical conversion of all local PropertyInfo definitions in
target/riscv/cpu.c

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/riscv/cpu.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 235764462cb..bd01884fb30 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1467,7 +1467,7 @@ static void prop_pmu_num_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmu_num = {
-    .type = "uint8",
+    .qapi_type = &uint8_type_info,
     .description = "pmu-num",
     .get = prop_pmu_num_get,
     .set = prop_pmu_num_set,
@@ -1509,7 +1509,7 @@ static void prop_pmu_mask_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmu_mask = {
-    .type = "uint32",
+    .qapi_type = &uint32_type_info,
     .description = "pmu-mask",
     .get = prop_pmu_mask_get,
     .set = prop_pmu_mask_set,
@@ -1541,7 +1541,7 @@ static void prop_mmu_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_mmu = {
-    .type = "bool",
+    .qapi_type = &bool_type_info,
     .description = "mmu",
     .get = prop_mmu_get,
     .set = prop_mmu_set,
@@ -1573,7 +1573,7 @@ static void prop_pmp_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmp = {
-    .type = "bool",
+    .qapi_type = &bool_type_info,
     .description = "pmp",
     .get = prop_pmp_get,
     .set = prop_pmp_set,
@@ -1613,7 +1613,7 @@ static void prop_num_pmp_regions_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_num_pmp_regions = {
-    .type = "uint8",
+    .qapi_type = &uint8_type_info,
     .description = "num-pmp-regions",
     .get = prop_num_pmp_regions_get,
     .set = prop_num_pmp_regions_set,
@@ -1651,7 +1651,7 @@ static void prop_pmp_granularity_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmp_granularity = {
-    .type = "uint32",
+    .qapi_type = &uint32_type_info,
     .description = "pmp-granularity",
     .get = prop_pmp_granularity_get,
     .set = prop_pmp_granularity_set,
@@ -1726,7 +1726,7 @@ static void prop_priv_spec_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_priv_spec = {
-    .type = "str",
+    .qapi_type = &str_type_info,
     .description = "priv_spec",
     /* FIXME enum? */
     .get = prop_priv_spec_get,
@@ -1759,7 +1759,7 @@ static void prop_vext_spec_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_vext_spec = {
-    .type = "str",
+    .qapi_type = &str_type_info,
     .description = "vext_spec",
     /* FIXME enum? */
     .get = prop_vext_spec_get,
@@ -1802,7 +1802,7 @@ static void prop_vlen_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_vlen = {
-    .type = "uint16",
+    .qapi_type = &uint16_type_info,
     .description = "vlen",
     .get = prop_vlen_get,
     .set = prop_vlen_set,
@@ -1843,7 +1843,7 @@ static void prop_elen_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_elen = {
-    .type = "uint16",
+    .qapi_type = &uint16_type_info,
     .description = "elen",
     .get = prop_elen_get,
     .set = prop_elen_set,
@@ -1879,7 +1879,7 @@ static void prop_cbom_blksize_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_cbom_blksize = {
-    .type = "uint16",
+    .qapi_type = &uint16_type_info,
     .description = "cbom_blocksize",
     .get = prop_cbom_blksize_get,
     .set = prop_cbom_blksize_set,
@@ -1915,7 +1915,7 @@ static void prop_cbop_blksize_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_cbop_blksize = {
-    .type = "uint16",
+    .qapi_type = &uint16_type_info,
     .description = "cbop_blocksize",
     .get = prop_cbop_blksize_get,
     .set = prop_cbop_blksize_set,
@@ -1951,7 +1951,7 @@ static void prop_cboz_blksize_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_cboz_blksize = {
-    .type = "uint16",
+    .qapi_type = &uint16_type_info,
     .description = "cboz_blocksize",
     .get = prop_cboz_blksize_get,
     .set = prop_cboz_blksize_set,
@@ -1987,7 +1987,7 @@ static void prop_mvendorid_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_mvendorid = {
-    .type = "uint32",
+    .qapi_type = &uint32_type_info,
     .description = "mvendorid",
     .get = prop_mvendorid_get,
     .set = prop_mvendorid_set,
@@ -2023,7 +2023,7 @@ static void prop_mimpid_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_mimpid = {
-    .type = "uint64",
+    .qapi_type = &uint64_type_info,
     .description = "mimpid",
     .get = prop_mimpid_get,
     .set = prop_mimpid_set,
@@ -2080,7 +2080,7 @@ static void prop_marchid_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_marchid = {
-    .type = "uint64",
+    .qapi_type = &uint64_type_info,
     .description = "marchid",
     .get = prop_marchid_get,
     .set = prop_marchid_set,

-- 
2.54.0


