Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA79FC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvOe-0008HN-IV; Fri, 28 Aug 2026 08:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvNu-00072h-VC
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:08:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvNt-0003yY-6J
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+2OWslZr5vWUQBSkoi9YO3Fwis1ewdPH5RJSX4B6XlY=;
 b=iIC+uKxkBuxCiOgyXythfBNjrAddrENwF/6TxYNIoqyWdbCjV4RbQsFZeq6h8Ju/MpAIZT
 nJbeDFOF0KjrmOFNB4J7NjAR00BE5I4/JRr8QoI/UczpL18Ok7CtlHN6Ya7EEmGQDsf4JZ
 MFoy57xP6p3QiVgIppxHV2hMBGiOBuc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-aWlx_UToNOWtqnrysP0MbA-1; Fri,
 28 Aug 2026 08:08:33 -0400
X-MC-Unique: aWlx_UToNOWtqnrysP0MbA-1
X-Mimecast-MFC-AGG-ID: aWlx_UToNOWtqnrysP0MbA_1787918912
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD51E188860C; Fri, 28 Aug 2026 12:08:31 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1BA531956049; Fri, 28 Aug 2026 12:08:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:41 +0400
Subject: [PATCH v5 44/50] hexagon: condition HMP-specific code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-44-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk5RAFHZVkvLYGUJ3dNH1nHiycqUfQ4Eqr/e
 /5KyfID/TKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OQAKCRDa6OEJdZac
 5TwFD/9hDtpVguySKLpU9YhTjN61a83t/J12Z5d0AQsDoTVUCNnROM5w9BjRsoSw4W9lsedZZvw
 F2E2w5t6lCdYnSQMi3dTvKHAKpfTsvO0IOifnrxNoQBfc4Xtti60RbNEi0j+sC2L2u1O1Q9F2Jg
 Y6FpZxtVktsSqJ5jBP6W9e+u4HZp04qX1+iAtoVtzq0M6ZgR8Qc079KOIJ979uvKnnQfPvjeAUG
 iWbRvucuLqMyyz9rRib+3Pi3cAuuCgEJ3gvhe+dqOUvkZoMYEAKFbpXvC+opYJCGjpMCDdl0bZK
 OltyXZ2v3lMPsxM0WG6w7IJ9CSqOdPwT0HiPYAD8hRHkLDes8FQPc5KDIM2CmK8qFytLYhY+Nfv
 GfGnt0tz5A6zxFxzDL3QoWpgYOkvevdl3wyC2oaR7CMzcUyYPeeLDJeeqOnBeqrrHJcJOJj+GTI
 4qJ4yPvssCSOIhoiME4eJCVzMdo7N59nMyIynW6FeDEg9Q3KTG+xWk3tdW8UybM8L/d2M3ylZqf
 irkWZUyrKIdJcVwQbx+1h/+Gsi19mSXmaYhzdIwvai44hCVvU4S5NCAMeIXaye5539TQNTQXIe0
 qQ/snnE5dcp1vVdhW5ZsgtbbpETFh/CrRK5TiSWMRxjQnhIbWTkWucpqJ63woP43S1h2YXgUEMS
 zXnbiIF5N+jP3iQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


