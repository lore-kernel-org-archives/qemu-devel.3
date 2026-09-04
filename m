Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A82C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a7E-0004iX-0x; Fri, 04 Sep 2026 16:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a7B-0004T8-9m
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:02:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a78-00008X-D5
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t43vVbAqt9a44+uxeyZhjiVCXGpQtyarxq5dgbrLkic=;
 b=MNbroCXXRGRSMGD3O9pKC0fmc6FviVptOzQ0f4sJVdYa+lvzrEtC07Tzulv8lsk6v55aOO
 OqD/BTTzURL0Z6zvSsFRuvjArRAZa4QjSUfuRZNRky/jxnz1W6em7tqJkpZWpRKfT6RZlE
 WckdV4xDyjOBHS08Fdr6ZqJKA8kZaow=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-m-GKPx0sO2OwgKOSDNJIIw-1; Fri,
 04 Sep 2026 16:02:14 -0400
X-MC-Unique: m-GKPx0sO2OwgKOSDNJIIw-1
X-Mimecast-MFC-AGG-ID: m-GKPx0sO2OwgKOSDNJIIw_1788552132
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04ADB195399B; Fri,  4 Sep 2026 20:02:12 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 240001800641; Fri,  4 Sep 2026 20:02:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:48 +0400
Subject: [PATCH v4 65/75] target/riscv: fix incorrect QAPI types and u8 casting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-65-a985f168e938@redhat.com>
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
 Alistair Francis <alistair.francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=YoOMy/B5EQPhqWBYY6y+EbIrpX6/2zs8Ep/p5YEq0BI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLLP0i09YeYpDmNiYmzFmy/4uyiSUfDgpti3
 ajYpXO9LSeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiywAKCRDa6OEJdZac
 5cyuD/9oLJh4GPcQRNVwM8ScGpXhfLuHjw2Ku54eAV1mZpe3B2FSiHZ7BRH5F6Blgu+eOt5EqIk
 ZH6ZNYgwMR5zaJKHvzGv+d8V3beG6eydH4Lqw3MYY9k8AO2jk2b15hkXJBRP4SpI9teU1DnOte8
 YuOcxlVk601+7akhlYniWpy5+pqqBXjPFgNd+NvzktX0jaBZZTRdrPTuCsD2stgCezdQOdfmbsN
 86J6Ch/U+zcv0he8WhQENo+XwcfJ1FXpU3Bp32Va57AnSbhbGw+iH8iImtWxn3IOifW3DSmV6A9
 l320ENHQX5F12gjXu2s0tAS1WWcxc3l0gPe13x393MLWpmgCUd6AOujg25jeIw8EQc9UwYcgIt9
 6MI6ZBkZpdUCR5gPFREr11Auvy8pQjfV31ocpOYTFMNwnSHmmDkirveGFuuSYI/zVk+SebK6oQb
 AkGJ2O406NCtKvRiaTg1ZRyFR0fesCzcScIf8wV+7HMkoJNUsvL0bB1tA+mqCyXa0GSbK4ARhQF
 mfZy8xPtGrEtN02WcbPWZVSEHFUJYPYbLCWHuo00uFpb4JkZn3+m/pr8Rlbpr4Efmb87A2AQM5n
 X+pnIXexlUaR+760m5jaj6x0dUZt+eBPR1aSa1bRWfDoe4VlBdl9z0gMyeYz6Qn8yIdeqpIyHbC
 QNCgIR7fGXUAHyA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
index a1faea801d1d..0f25f0c8fb5f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1688,7 +1688,7 @@ static void prop_pmu_num_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmu_num = {
-    .type = "int8",
+    .type = "uint8",
     .description = "pmu-num",
     .get = prop_pmu_num_get,
     .set = prop_pmu_num_set,
@@ -1724,13 +1724,13 @@ static void prop_pmu_mask_set(Object *obj, Visitor *v, const char *name,
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
@@ -1873,6 +1873,7 @@ static void prop_pmp_granularity_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmp_granularity = {
+    .type = "uint32",
     .description = "pmp-granularity",
     .get = prop_pmp_granularity_get,
     .set = prop_pmp_granularity_set,

-- 
2.55.0.543.g5ebe2ebe4ea8


