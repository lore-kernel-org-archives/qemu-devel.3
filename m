Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C2FCD98E2
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE81-0007R5-VL; Mon, 15 Jun 2026 16:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE80-0007Gn-G7
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE7z-0003DK-1o
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781556110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JDnRIYDmCQzkNAdvHZNUWhsspIQuDKZRpI03XIdLc70=;
 b=YDRLE/ooXUFkZhMZNfUQ35CUvsC/rbN05BLs3kvS/qhcmxRco6Larz0fly15MqpFZu8RDj
 BDSK21jK3JXectk8oXcTvmv+DUL9L7W2Mpc7khVdGyXzjcQa3N0f7mAJksG8ylzYnv+jlb
 TcMBHNDZBcgNUh+vuQ7ULfvCCk4iNKk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-WicGFW68NG-3WqQVDSEEwQ-1; Mon,
 15 Jun 2026 16:41:47 -0400
X-MC-Unique: WicGFW68NG-3WqQVDSEEwQ-1
X-Mimecast-MFC-AGG-ID: WicGFW68NG-3WqQVDSEEwQ_1781556106
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52A4218009E6; Mon, 15 Jun 2026 20:41:46 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 21B5B3008B37; Mon, 15 Jun 2026 20:41:44 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:38:12 +0400
Subject: [PATCH v2 46/53] target/riscv: fix incorrect QAPI types and u8 casting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-46-cc9396b9c18c@redhat.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
In-Reply-To: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1618;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=WMsLOFqLBsKEif+Q77QREwp32vagjtu8h/lM/vi0C2Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKQSKVzq0Clv4uxKspWrjxT+/4YGlV/2v+x8
 p7cfCAywsSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBikAAKCRDa6OEJdZac
 5RWkD/9cdR+P3XKSEx+vTX5/8SGfSLDFRnkzfcmaopxqG+O5HXKXeIIm6urjHIaWytaBjVVPJju
 Gcyr6ToNF6DRJtE3xbYKsl6HjQPYMKxP9Rwk6wrZ4hCqQXEJujYganNI76Rr+cl4AMYwqlVlUCt
 0Vue+nWPTAdB3wWnaXOl/ANTGDu8zCRgtp+uUvjmU+P9kJ9+d6IIGBC24vw7/XXBDmhXVPKjXLm
 ApCOxU9Tzxi2lv8E79Vb4yeaMilQDpl2OHziAVIKlPS5rb8V2E8doYaR9Gj1xz8VfKwbp9bCCyM
 PScdN2mzzCt29Yob2tvChiELO2cfC/K/nRJs0xbeNeqfeu29YV2Cf3994n6ZxFK1P5KVvtf94YK
 rd7BFQRdm/YHlFUwalmmj8k7hG1gCCmsGHYeZM07TqwxmU6YsxQpL9sUVTbAP693r36c7bkFgjo
 UDNb5WDGmA5GsMbA3rY000xLsSneQd3J6bfs6TS2yazn01rmElQISr4B+KQRBT2/klbjMgw1+J6
 EwAAM3zRhIxQ6S4Eu4Uf7GQB2T20pd1Sktv8zeFsBU8cdV4kTmipLPAfxPRcXGwbkvnUDOgtFj6
 ahnhE4Qnp7NtxbkdJl4IOyySauaBsXFcTL8tQTRBUvZrYOOgSIwD2uLYs/bSaFZd2e/Ji73a5hs
 EEjhHI21YXINW7g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

"pmu_num" is u8, "pmu_mask" is u32, so is "pmp-granularity"

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/riscv/cpu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a63961bb713..98c9ebd791c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1302,7 +1302,7 @@ static void prop_pmu_num_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmu_num = {
-    .type = "int8",
+    .type = "uint8",
     .description = "pmu-num",
     .get = prop_pmu_num_get,
     .set = prop_pmu_num_set,
@@ -1338,13 +1338,13 @@ static void prop_pmu_mask_set(Object *obj, Visitor *v, const char *name,
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
@@ -1486,6 +1486,7 @@ static void prop_pmp_granularity_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmp_granularity = {
+    .type = "uint32",
     .description = "pmp-granularity",
     .get = prop_pmp_granularity_get,
     .set = prop_pmp_granularity_set,

-- 
2.54.0


