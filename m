Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962DAC61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywZz-0003vE-Ke; Tue, 25 Aug 2026 15:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywZy-0003uq-7J
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:13:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywZw-0004YX-Gi
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+2OWslZr5vWUQBSkoi9YO3Fwis1ewdPH5RJSX4B6XlY=;
 b=A7vjLtibY5PgbDZsiYbWPngzt9v6yyVU2WKRho5DCmzdc54ZCFEroYTVVQ5tM02ewicJss
 yDv/kWnAo61nFUqYIm040h76hJsSHWv46R4F9XuvI48zOkm1y+y6lX3hD9uE+Z8C//B8Cj
 j4mcGMPkgy+t1e2O97mDieLs7Tn2lXE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-YwXIEcrxOeW5mUaP22lFCw-1; Tue,
 25 Aug 2026 15:12:53 -0400
X-MC-Unique: YwXIEcrxOeW5mUaP22lFCw-1
X-Mimecast-MFC-AGG-ID: YwXIEcrxOeW5mUaP22lFCw_1787685172
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 385221886217; Tue, 25 Aug 2026 19:12:52 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC3A018005B4; Tue, 25 Aug 2026 19:12:50 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:50 +0400
Subject: [PATCH v4 43/49] hexagon: condition HMP-specific code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-43-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2830;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+5CvDxMVY4yUu1Tik+sPP0HrV0rn2K4sJvVIbqYbbf0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiIw+1s3D8TG7kqu5xx7POESSnuJ10eQWIxb
 nmNYV6LGVqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3oiAAKCRDa6OEJdZac
 5VJgD/4nJwJKcaFFEsYEJxxhQaBRQwob19c0xoPVrHedzbjjf5uiLSzd/3sa0vpAbPiFFXj5epT
 CvTNbmAgMzhy2bJvNe23HZgjcGPpEQDdWiUv8jHmZ0rluQgpKdmwSu0VgFAnkMD07iTKX1yF9Oq
 3AxH9kvXYYyjrFrCntltNqtwayEolrOHT9N6KGq7VSV2/xbsR5gm3LZ5n+evsxYiPTLjHKMXLjs
 NUwyIQgmgibWLgRcZdDp+Nrfr8xhtUPQS7ZzMjE56DkFnY5PumIXcGNYemM2R8lTE6IFfAm3FZ1
 r34a7Kh3Cvy3RVPZyq2/fEFcwt3q6dfYPQXEaSMEYt+robi4TJCWrK3/EvBTaZTtSfZriVberng
 MaCHOWsnY8afzqzd69tewF/CDSADhXh/xeCM8LAc37XOSe73w2S268cYMqrFtcKLz2ZQ+8cMpW+
 BhRXOIuAOvbd9pFvWgG2IqLx5YccdTXk/sf3pnWOuXgCWZCs3TAnR+CSSDRX2j7ariztRDCrUYP
 Qt0UOPmcCIJc8kAq95RDEEul3I5i4+e6avM7oROWqSIvVTQs2VLAbLNACQzuyArR1H4N515f7ya
 liqhMIXfnME56o/h2T1VKJyhIL4hxOkP0viNSJc8zIeVf/hcu+OpzB4AXdyL0cGGeABRsZoaAiT
 8S6tBeQe8VKdA/w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


