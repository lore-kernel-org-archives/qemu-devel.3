Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCA7C79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xQX-000526-WA; Tue, 08 Sep 2026 11:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xQX-0004zy-2b
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:08:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xQV-0007l3-I5
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788880079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yldmEwkCNpSAaCHFlIQGOZ7JUY549V31U/UBObXIEDE=;
 b=YZdOI58DJSnDZ68bIjoba7k+xxTgz2YkD7bDPaqg6H63LyTKY2Jn5ph4vF20/x4hVzRJlt
 JPmtYsMcoC2e9IdMoDOLyP/TbwLD1CeypPpL0vzI/uoGLznZ+8q8LC2PFnVmEZuH/6zDLA
 YbuW/CBEpVrXXLR6kr1e+1vJK8yVCoY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-wz4-Wgd3MteB_JgwcsjSiA-1; Tue,
 08 Sep 2026 11:07:52 -0400
X-MC-Unique: wz4-Wgd3MteB_JgwcsjSiA-1
X-Mimecast-MFC-AGG-ID: wz4-Wgd3MteB_JgwcsjSiA_1788880070
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D421219540EA; Tue,  8 Sep 2026 15:07:49 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A10781956042; Tue,  8 Sep 2026 15:07:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 19:06:57 +0400
Subject: [GIT PULL 14/15] target/riscv: fix incorrect QAPI types and u8 casting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-qom-qapi-pr-v1-14-a4d75a2573cc@redhat.com>
References: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
In-Reply-To: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=fLStIjct5Bua1ig/fYM26uiw+vkQ7c2+e/BFIkz5E3E=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoCSPkiBgFnt8egAabo7Mjt97RrUDlCO2aQWs1
 CBvWjpU+syJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqAkjwAKCRDa6OEJdZac
 5QaaD/9+2VkSakcQtzOZ6POtfeTeV3vadA9cKQ3yX3NSd35LcWdFPsTARIIVUeU0V0Po2nXQP0V
 JAthSG2KmtzO0/oAfzR5BXU2es9o+ucTiuEH5B4SjSous5e0UqYntzUeZV/spqHEnZwsLgbAJi1
 mpQQqX6APTzrxx8dtSDAZaHKXm5dPNQWHokshgFrMIRGl/VnyWjxQjYnjBNDq62uRJFr4Tn0MK2
 pdPiBOonC1qmvj9KZULAuhsuapTLEPH6pXpkibp5sxdCIoklwXRMwBehvbEVGx4/LMS6xTLSZrI
 jFzJVNegb+Tu9z4LAoT3sPIAubpU3WggbU2G204Hn5xgt1+a3vjQ0X/kS77sWNSmu7qfRQalMJP
 gDEHu74DJq1vhkAkmZWzr0oexpqo/lGO2tOilVxLyvN6P5UltJ6vbQPsmm+7LL4b0BdCdxO2qwi
 yt//NrGSIlKauVdb/CjceERGGlk+Mh3vvJ7nN51YKhSuyFnfRCoTZWysVTdvSbFKX5DoFIcA+hq
 B8Ffz070j6RuSh9a0bi3KscoBW+R9rKJRDkJ4Z8Ckrxe9geia/0syzTXgzBWBmYNe+uu31o9uqx
 YyGEnBiwzilA/OrPvHMwlGem8YajpBwzXBB2zn59gdKh+IrI4S/0J7WYZFTv6NgCcqBFy+WeWTY
 kIHjSFTVIoQXZUA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

"pmu_num" is u8, "pmu_mask" is u32, so is "pmp-granularity"

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/riscv/cpu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 652311ddef2f..5fff9d745e9b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1687,7 +1687,7 @@ static void prop_pmu_num_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmu_num = {
-    .type = "int8",
+    .type = "uint8",
     .description = "pmu-num",
     .get = prop_pmu_num_get,
     .set = prop_pmu_num_set,
@@ -1723,13 +1723,13 @@ static void prop_pmu_mask_set(Object *obj, Visitor *v, const char *name,
 static void prop_pmu_mask_get(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
 {
-    uint8_t pmu_mask = RISCV_CPU(obj)->cfg.pmu_mask;
+    uint32_t pmu_mask = RISCV_CPU(obj)->cfg.pmu_mask;
 
-    visit_type_uint8(v, name, &pmu_mask, errp);
+    visit_type_uint32(v, name, &pmu_mask, errp);
 }
 
 static const PropertyInfo prop_pmu_mask = {
-    .type = "int8",
+    .type = "uint32",
     .description = "pmu-mask",
     .get = prop_pmu_mask_get,
     .set = prop_pmu_mask_set,
@@ -1872,6 +1872,7 @@ static void prop_pmp_granularity_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmp_granularity = {
+    .type = "uint32",
     .description = "pmp-granularity",
     .get = prop_pmp_granularity_get,
     .set = prop_pmp_granularity_set,

-- 
2.55.0.543.g5ebe2ebe4ea8


