Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D227C79F85
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a7J-0005Fj-RQ; Fri, 04 Sep 2026 16:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a7H-00057V-VY
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:02:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a7F-0000AS-Vu
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PJPGrbVov3kLsIeHkTM5r5PTRyzKMricfboJV7AlXjk=;
 b=hs/kdunB85bfEo63KZZvwTJczcX/B0a5tF7n9g+rq0uNJvo7qaTcNxmAtp2ixSzR+70cW1
 s1uNzW+WyP/t6dXKp3jPALCG90/60sdCp5VQbykOVLuyiC8UPGaSYVYEEb6n1hRHv/e1v6
 ZAIoLZrR7nfgSwMHUzt5XlPQ/HGrOsY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-q1N_GnGKOS-agKZ9Iupl7Q-1; Fri,
 04 Sep 2026 16:02:23 -0400
X-MC-Unique: q1N_GnGKOS-agKZ9Iupl7Q-1
X-Mimecast-MFC-AGG-ID: q1N_GnGKOS-agKZ9Iupl7Q_1788552141
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89D0019091F0; Fri,  4 Sep 2026 20:02:15 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5413F1955F0D; Fri,  4 Sep 2026 20:02:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:49 +0400
Subject: [PATCH v4 66/75] target/riscv: convert PropertyInfo definitions to
 use qapi_type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-66-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=5376;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ynlNi8WKyUARlJz5bFYO+4tq2XYJXSIvCIUhQxW5SGU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLLSm0/uY8QUEop2ZyWv8GT4TrdifRPrjNqF
 dvX7rTXGTWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiywAKCRDa6OEJdZac
 5R0XD/0WbjUt/szWhv8RXK02BkiGRp7fcOVAhe0VdHEme2rOYONH3C71VjdRGy9JlBS4psTYVsn
 wyXiJ7n8768R2Bbs6Ty6iZiJS/es8T4EjGQpBrqdZhR/cOEMKkJZA7HL1KJH8bKHtPyt5p+Av3w
 sRqDCGNt5ym6Lvul/s/kUaO0PbJnZg1ZhNvPn+6hmlaGwGouRFREsx9NuCKaBbozvFBnpNcGtEY
 a/sMXORWBgBear2OJdf7rNDg4PWdHI0GwmXhTr6DSnTS/U8BYb4KE2UHPX5htbucRyeAULGHXyh
 flFpbmWBw1k6XRLt7br8/jtC8HDfCLSdfMA4avtwvXUjNJ+Z/goGFHTUX2eKpdxA+nFwCGJwm1A
 ZY6p3xtzKG9JFN8Gwn+6lWaesnrarJnZtYgF1ZGBFk9gg+uszApiLeb4qMRYYUw5mkJeZ2YM8yd
 /AaDE0urGEwnPuoDDc1y+TwkqtZocXlupCNw9G1oDjergFbzvW4lDmv0MAdkWboDOvb/yHMahbd
 gYlO4SPIpLWsH3b4mfJ7UTUQzDi03VhufQbM7MtEE2sRIyRcBjVFbrKEEBwfLEFtg+i4h7izQnu
 CYdxHfxOkIV39imPdOLL3C2qUSXIoGtxCONnnec+tFWVi0nsfPiDnxyB0bzQunGEv9rrMgFlLg4
 TlVizOxhbUE/2Hw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 0f25f0c8fb5f..a5282a1d0d04 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1688,7 +1688,7 @@ static void prop_pmu_num_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmu_num = {
-    .type = "uint8",
+    .qapi_type = &uint8_type_info,
     .description = "pmu-num",
     .get = prop_pmu_num_get,
     .set = prop_pmu_num_set,
@@ -1730,7 +1730,7 @@ static void prop_pmu_mask_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmu_mask = {
-    .type = "uint32",
+    .qapi_type = &uint32_type_info,
     .description = "pmu-mask",
     .get = prop_pmu_mask_get,
     .set = prop_pmu_mask_set,
@@ -1762,7 +1762,7 @@ static void prop_mmu_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_mmu = {
-    .type = "bool",
+    .qapi_type = &bool_type_info,
     .description = "mmu",
     .get = prop_mmu_get,
     .set = prop_mmu_set,
@@ -1795,7 +1795,7 @@ static void prop_pmp_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmp = {
-    .type = "bool",
+    .qapi_type = &bool_type_info,
     .description = "pmp",
     .get = prop_pmp_get,
     .set = prop_pmp_set,
@@ -1835,7 +1835,7 @@ static void prop_num_pmp_regions_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_num_pmp_regions = {
-    .type = "uint8",
+    .qapi_type = &uint8_type_info,
     .description = "num-pmp-regions",
     .get = prop_num_pmp_regions_get,
     .set = prop_num_pmp_regions_set,
@@ -1873,7 +1873,7 @@ static void prop_pmp_granularity_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmp_granularity = {
-    .type = "uint32",
+    .qapi_type = &uint32_type_info,
     .description = "pmp-granularity",
     .get = prop_pmp_granularity_get,
     .set = prop_pmp_granularity_set,
@@ -1949,7 +1949,7 @@ static void prop_priv_spec_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_priv_spec = {
-    .type = "str",
+    .qapi_type = &str_type_info,
     .description = "priv_spec",
     /* FIXME enum? */
     .get = prop_priv_spec_get,
@@ -1982,7 +1982,7 @@ static void prop_vext_spec_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_vext_spec = {
-    .type = "str",
+    .qapi_type = &str_type_info,
     .description = "vext_spec",
     /* FIXME enum? */
     .get = prop_vext_spec_get,
@@ -2025,7 +2025,7 @@ static void prop_vlen_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_vlen = {
-    .type = "uint16",
+    .qapi_type = &uint16_type_info,
     .description = "vlen",
     .get = prop_vlen_get,
     .set = prop_vlen_set,
@@ -2066,7 +2066,7 @@ static void prop_elen_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_elen = {
-    .type = "uint16",
+    .qapi_type = &uint16_type_info,
     .description = "elen",
     .get = prop_elen_get,
     .set = prop_elen_set,
@@ -2102,7 +2102,7 @@ static void prop_cbom_blksize_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_cbom_blksize = {
-    .type = "uint16",
+    .qapi_type = &uint16_type_info,
     .description = "cbom_blocksize",
     .get = prop_cbom_blksize_get,
     .set = prop_cbom_blksize_set,
@@ -2138,7 +2138,7 @@ static void prop_cbop_blksize_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_cbop_blksize = {
-    .type = "uint16",
+    .qapi_type = &uint16_type_info,
     .description = "cbop_blocksize",
     .get = prop_cbop_blksize_get,
     .set = prop_cbop_blksize_set,
@@ -2174,7 +2174,7 @@ static void prop_cboz_blksize_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_cboz_blksize = {
-    .type = "uint16",
+    .qapi_type = &uint16_type_info,
     .description = "cboz_blocksize",
     .get = prop_cboz_blksize_get,
     .set = prop_cboz_blksize_set,
@@ -2210,7 +2210,7 @@ static void prop_mvendorid_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_mvendorid = {
-    .type = "uint32",
+    .qapi_type = &uint32_type_info,
     .description = "mvendorid",
     .get = prop_mvendorid_get,
     .set = prop_mvendorid_set,
@@ -2246,7 +2246,7 @@ static void prop_mimpid_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_mimpid = {
-    .type = "uint64",
+    .qapi_type = &uint64_type_info,
     .description = "mimpid",
     .get = prop_mimpid_get,
     .set = prop_mimpid_set,
@@ -2303,7 +2303,7 @@ static void prop_marchid_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_marchid = {
-    .type = "uint64",
+    .qapi_type = &uint64_type_info,
     .description = "marchid",
     .get = prop_marchid_get,
     .set = prop_marchid_set,

-- 
2.55.0.543.g5ebe2ebe4ea8


