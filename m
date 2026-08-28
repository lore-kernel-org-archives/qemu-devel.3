Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5043AC61DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Rc-000603-DS; Fri, 28 Aug 2026 16:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Ra-0005kU-9A
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:44:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03RY-0000oj-Il
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uW89xMgX17FJLHEV2mQ9tkDS/sWNr9vmwHVXElFD+Cg=;
 b=fbXWZSN51nAGlkHv+qnHC3aKbCWF0PK58eipoeItvQQU21/s2Ej2bOP9Ofm0EZGAJcVn5H
 jzjq7z14Y0r28p0Yj4E894/2SvhEFRdC6CLAxE0f8vcpQ0F8Gb1rZs9S5hBZj5qyZL5Wif
 a7u425er8snIDEJYxczQlEn5pY956FA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-BTMulVlXOziJ6jeZ8CIDNg-1; Fri,
 28 Aug 2026 16:44:49 -0400
X-MC-Unique: BTMulVlXOziJ6jeZ8CIDNg-1
X-Mimecast-MFC-AGG-ID: BTMulVlXOziJ6jeZ8CIDNg_1787949888
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CA211953983; Fri, 28 Aug 2026 20:44:48 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 90BCC1955F0D; Fri, 28 Aug 2026 20:44:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:42:23 +0400
Subject: [GIT PULL 44/50] hexagon: condition HMP-specific code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-44-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2896;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=N2LjTtiTAvCP4nbe8+diEXHASG4vpGhtplbW9DEsFmg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKVB0I5z/4B9qWQ3VdZ3Og+RTK4/yMsmdLE3
 3VOV4iNFdaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylQAKCRDa6OEJdZac
 5bqMD/9QLZops8CguueekDcv3tTCp1mzdZnGWGY+WOitecI6ElREUls+P4xqHuP+t5ryvyg3RL/
 VeNLHCKbMoCZM08DS6qBSAYDiMDuEz7myrKsMawlfOl6sgw1HQvzzB+m/jwk6bFBHmCat9e18+0
 zoC/oNPDjvkxfvWgj4KDfBdP5gpEgjEYQF8/gSAK3N1lEuS7c4SIC7oN/IrtKuhxqvOQ9cXS00p
 RwuXiR6NiNUOvPxU7eof44IuuIpBlELQST7tNJhFy6yEV7+z16mfYn7Snyc4BLoKqWXwmpm4Io6
 HmS3Fud1BJXtT+Ya/3n+d42UH6OB+NiJA5ouQAI4FSN0tpNcLv0f5DYVoxw8RiissORSF8upsr4
 YYXYgkAQIwcrK0j/FZFRfA8FDfwgPrUDZIvh6g0zByoBASLhyQehyWRldnx6LU51lKdGm021ZHh
 tzdjg88OSbQmfqEBbtinQXUqs3KnNEvygxfzHgr11ALLMX1xmgIbdQHqiggZHrLaus4ZiPBca6m
 8PohqHE24xpFTdqSJttzIG0Ijyi4X5Meja8UcP2CoU1CKEkwPnXy/YQbRkR6LGmA7iN1RIbWqcg
 2JbTUhh5mOT2fNP2yCOTlX2oNfjAoM0PfL/rc9LzOW7erdrLh8i1TqU0vKjqO/RJsteVI+/V9Ag
 xjez+k6MZxvbuQA==
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

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260828-qemu-no-hmp-v5-44-9227de146347@redhat.com>
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


