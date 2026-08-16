Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48751C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgKq-0000P6-C5; Sun, 16 Aug 2026 15:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgKn-0008Tp-2Y
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:15:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgKl-0008Sm-EG
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=enBUpDOXCwO/sjgii97Ofa4/933mWm4UHlA8clXz7Ho=;
 b=ZqM692GyE1IVIg6fD3JokDKLUjI+Qog6qfkFD5+8IrCM8BMNfC27SGagFh0SV+ZWCyzm9l
 n299HXBuIN8NVP7usqfXTPWtsIJuaVG8hN57OMvFXsNKf7vQ3o8aJKVStHbFFZ5oxQpNwY
 EZyOUG1Kf7ohL6tyJxmBW+YkDyif7eg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-8NWYe4lRNgWT-v3TuX24Rg-1; Sun,
 16 Aug 2026 15:15:47 -0400
X-MC-Unique: 8NWYe4lRNgWT-v3TuX24Rg-1
X-Mimecast-MFC-AGG-ID: 8NWYe4lRNgWT-v3TuX24Rg_1786907746
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B76218004A9; Sun, 16 Aug 2026 19:15:46 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 51DEC422; Sun, 16 Aug 2026 19:15:44 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:13:11 +0400
Subject: [PATCH v3 44/49] hexagon: condition HMP-specific code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-44-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2711;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2OVuVfJBnPkur4+UB4C5BoMGkYchBdx4jr6AjfYDGDg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqggu0pXAobObPC1LRrt4AxqzEQ0j7hSUqtRRol
 +NmYJ2wX5GJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILtAAKCRDa6OEJdZac
 5bXYD/97ZXg+IIBQJ5cjITaIgfKmI1ItSvcd9Fw5RTIAS/n8CaWxdryRZee7RbU4J3ABaXDJX5J
 F16gEOYoZSL+grnqf2h84KpvMwRONsvS31yAfOBoFLp2hAycRIWnZOZqMy/WNfMhymaPYiLac4y
 M5+WgdzD2yqBNiBil84O+8GvbrwRB/M7WDijIxJ6jOLXCqDt0QoJMv6O1ySi0xVszZllb/eJ0VN
 Cx6Lyyq5fwGvSeZ0Rg+YLwCZIPY65vbNNLQ4VFbpplGb30QrJOvCU4gNqLAZhTp8fkxX/CF9JSc
 E4HgG1wF2v3cdM6aA5wFJ7jw7IoJ6TTAp69iQT8P+9fPrD5YEefjEwt0a7f46HfGPYjJWo6iesO
 +TavUxhFRdRJ5qcYnLl6ll3zK+lRJVWNmMDGiEgg3zLNLJsHyIA7D1itzR/axeqnF6dC6YwLYw0
 m1OKPRyOps0hBca4Ww3JAFvrI4UpY/kgtiOVvxvAqXb5LJPTPf6/oAXj5YU7ksVxOhz6/MiOuJk
 IENjComRfn3AGz5zIRDT8S2OkEz6dpffEHP9rDBtHPWSWXl/7jfwHGpB8N4e37+aIIROtKDtjrn
 gi5R25E4Mj46Hek2tYUEGc+4i5VrizufPhdVLpgJK/Lrm6ulnmJNib1EbPL+vtgm0iSD1cPl9a1
 7cy/CB3IfD55CPg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/hexagon/hexagon_tlb.c | 42 ++++++++++++++++++++++--------------------
 target/hexagon/hex_mmu.c |  2 ++
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/hw/hexagon/hexagon_tlb.c b/hw/hexagon/hexagon_tlb.c
index 584c606a22c5..ed8c0a761228 100644
--- a/hw/hexagon/hexagon_tlb.c
+++ b/hw/hexagon/hexagon_tlb.c
@@ -57,19 +57,6 @@ typedef enum {
 
 #define NUM_PGSIZE_TYPES (PGSIZE_1G + 1)
 
-static const char *pgsize_str[NUM_PGSIZE_TYPES] = {
-    "4K",
-    "16K",
-    "64K",
-    "256K",
-    "1M",
-    "4M",
-    "16M",
-    "64M",
-    "256M",
-    "1G",
-};
-
 #define INVALID_MASK 0xffffffffLL
 
 static const uint64_t encmask_2_mask[] = {
@@ -122,6 +109,20 @@ static inline uint64_t hex_tlb_virt_addr(uint64_t entry)
     return (uint64_t)GET_PTE_VPN(entry) << qemu_target_page_bits();
 }
 
+#ifdef CONFIG_HMP
+static const char *pgsize_str[NUM_PGSIZE_TYPES] = {
+    "4K",
+    "16K",
+    "64K",
+    "256K",
+    "1M",
+    "4M",
+    "16M",
+    "64M",
+    "256M",
+    "1G",
+};
+
 bool hexagon_tlb_dump_entry(MonitorHMP *hmp, uint64_t entry)
 {
     if (GET_PTE_V(entry)) {
@@ -155,6 +156,14 @@ bool hexagon_tlb_dump_entry(MonitorHMP *hmp, uint64_t entry)
     return false;
 }
 
+void hexagon_tlb_dump(MonitorHMP *hmp, HexagonTLBState *tlb)
+{
+    for (uint32_t i = 0; i < tlb->num_entries; i++) {
+        hexagon_tlb_dump_entry(hmp, tlb->entries[i]);
+    }
+}
+#endif
+
 static inline bool hex_tlb_entry_match_noperm(uint64_t entry, uint32_t asid,
                                               uint64_t VA)
 {
@@ -377,13 +386,6 @@ int hexagon_tlb_check_overlap(HexagonTLBState *tlb, uint64_t entry,
     return -1;
 }
 
-void hexagon_tlb_dump(MonitorHMP *hmp, HexagonTLBState *tlb)
-{
-    for (uint32_t i = 0; i < tlb->num_entries; i++) {
-        hexagon_tlb_dump_entry(hmp, tlb->entries[i]);
-    }
-}
-
 uint32_t hexagon_tlb_get_num_entries(HexagonTLBState *tlb)
 {
     return tlb->num_entries;
diff --git a/target/hexagon/hex_mmu.c b/target/hexagon/hex_mmu.c
index 242de06eaad2..12bcddd000bf 100644
--- a/target/hexagon/hex_mmu.c
+++ b/target/hexagon/hex_mmu.c
@@ -107,11 +107,13 @@ int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t entry, uint64_t index)
     return hexagon_tlb_check_overlap(cpu->tlb, entry, index);
 }
 
+#ifdef CONFIG_HMP
 void dump_mmu(MonitorHMP *hmp, CPUHexagonState *env)
 {
     HexagonCPU *cpu = env_archcpu(env);
     hexagon_tlb_dump(hmp, cpu->tlb);
 }
+#endif
 
 static inline void print_thread(const char *str, CPUState *cs)
 {

-- 
2.55.0.543.g5ebe2ebe4ea8


