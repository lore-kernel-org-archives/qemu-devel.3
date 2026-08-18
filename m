Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005D5C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwJye-0006hl-3X; Tue, 18 Aug 2026 09:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwJyc-0006b4-Bt
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:35:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwJya-0000b9-GI
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787060135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KcP90JOveGYGun6oJJcYdEjRtcUXrnPo6AGQudaLO1U=;
 b=f1qDixT3pMLBmVQy4D2LAWApjsDqY9wpcXKwOEOApYmP5+/9wEreAqlrNffTexz+UkxNt0
 yw+1RphdeozL/qrr1rUcEg3fJlw7mOnL69A0itHfQdsNA+ESYvkyR5FgZqtnwTKgFtnCmQ
 wfHs6HJKtwZiAN/aYONzNlEfRJS8xls=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-tIn4V-VnP068aJ6RNWgw4g-1; Tue,
 18 Aug 2026 09:35:30 -0400
X-MC-Unique: tIn4V-VnP068aJ6RNWgw4g-1
X-Mimecast-MFC-AGG-ID: tIn4V-VnP068aJ6RNWgw4g_1787060127
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 830F81955DC1; Tue, 18 Aug 2026 13:35:26 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EEE8C434; Tue, 18 Aug 2026 13:35:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 17:29:30 +0400
Subject: [PATCH v3 64/74] target/riscv: fix incorrect QAPI types and u8 casting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-64-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=dkobR/sb7kIFkme1f+t2YY0mapzjM2VuRmtv0YHZc4Y=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhF9z/mxKriTXxlI9hoyr4dTxPRQG0JUZ/m6Bw
 ZJv3UUfkDSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoRfcwAKCRDa6OEJdZac
 5ZnMD/9DQW3NVpCu5clFFJ9r5PcGwKr42soaSn59YFoF3vws+G3JokDff/3LC7JUxJxoChdQOsP
 yyoWwZQ2ho37s85P/giLNrF/IGAqjh279Q5zPqdWBiuGGQZFysGCzbSUH4jq37T/uv8K9cW22uo
 rBpl1H0/9DZd6CwZYhZgCZYkneuyul5cWLWeb6oVFk1r0uusHf+xOMGWlCI5wB1ZG190JqycZm0
 iJkD0yoXsdL6nUhT/IWIr/J/QoN7I6kIR3o3mcbfz1Zvoy5+AJFys6YxdO9WJuq+4hnes23oV8H
 CSqqrXEuht177ww4z3mv9gffOxEZpvQ+xUsn3lSvKax/GtxFoDazHgRTbYkU1xSu/Olda8AwIbF
 CAciPJTwDb5WnS2FLHb6mBxz4wkzcNh+A9HEQpdXTHhFXp0GrnFVuSE1+3jiQZBhYtteYbt2nnM
 yQY4xXA/6UDCqNpjcqrBykWcrF0EcDuC1mwvEm8ae1omf9aZIQ/zudUpNIyux92IZYBc3jVXwyG
 V5au/H5oH5/I5Jiq8meMSIgrRlDyqTVVWwHQOrqIK7+cMkay6mAUX6ubkMtilUBRmAN7/Scacvq
 8qE57OTeH3rdV9sUo9fE0qcsgv9Y+4XAeOCazVItemHiIZHnTJMLgRfCbJUdj9/+yIfyAEi4qFy
 wPtvb3H1lZt/Zzg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 6116d6da7685..0c0730f08026 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1598,7 +1598,7 @@ static void prop_pmu_num_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmu_num = {
-    .type = "int8",
+    .type = "uint8",
     .description = "pmu-num",
     .get = prop_pmu_num_get,
     .set = prop_pmu_num_set,
@@ -1634,13 +1634,13 @@ static void prop_pmu_mask_set(Object *obj, Visitor *v, const char *name,
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
@@ -1783,6 +1783,7 @@ static void prop_pmp_granularity_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmp_granularity = {
+    .type = "uint32",
     .description = "pmp-granularity",
     .get = prop_pmp_granularity_get,
     .set = prop_pmp_granularity_set,

-- 
2.55.0.543.g5ebe2ebe4ea8


