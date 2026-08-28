Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C164CC61DD7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03R8-0003cE-1f; Fri, 28 Aug 2026 16:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03R6-0003bP-B4
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:44:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03R4-0000bg-L9
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fvdmdMpIXJ8l74+yaKTi+gZlWOVbTLXR3VIp12IRDEk=;
 b=CXiwv8fwJNPlaj+L0opoa4YFJkXbq8ky7M0GTEndMAulGQS44CkEi6WfBjZUbSqRF3Tflw
 o3zoFLn/Z1qAPtxlQUE+Su2ot6ZcBqzx4iptggrHK6cXZwo/hKnJa3Awy6ApXst3Aw3+Au
 JQzZHCXUaF0lt5yx7hVGlTHhvEayjeI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-NQC3t8U8NCCvSNjsAeYrIQ-1; Fri,
 28 Aug 2026 16:44:23 -0400
X-MC-Unique: NQC3t8U8NCCvSNjsAeYrIQ-1
X-Mimecast-MFC-AGG-ID: NQC3t8U8NCCvSNjsAeYrIQ_1787949862
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DBAD18A3C0F; Fri, 28 Aug 2026 20:44:22 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4345A18005AC; Fri, 28 Aug 2026 20:44:20 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:42:17 +0400
Subject: [GIT PULL 38/50] hexagon: make dump_mmu() take MonitorHMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-38-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4167;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=eKsXIj/FsvM+AGZc8eLmTPzWSKRNAhynkYldeVV8efI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKViPY9NUab4z/9l8zmRlJJg3QgoCf7v5tux
 5LdzO7Z5kSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylQAKCRDa6OEJdZac
 5eUDD/4xZwWlW1rLaVK/g32kABpA6vpX2ubaGo+Aw3zTIvT17Poy7Yvc/9Lqri273Mqca6GbH4+
 vMmL6TgMnQsWXorECNjBHDGRGPCP/ho2dhuIM891Xld/34vcyB+adpPFAj2OHmXZ5X88PiltxE6
 PB5RiibPy8glz3+AbjpzMUgurLe8d58TkwJvUd+Vd+xjH3FRPzW7XPvFteAWnqkLU337UvNZs6D
 h9Fp+2yTmkwiZr3nM0SKbnalDyAiuVu7Fc2MJvftvBnmhUHGPjmhVazUjaxvZlAlWpoh8/qQB/T
 l+RzvWgSl3xNgtkk0RXIVnbhNQ2cUzPfYCbes6PNLs1ZyJr85S3WSAgspViQmlsddCgAPHKyeOD
 2YVjr282dPaYNrFJJEAW8VJ4fH2Znrx7qOdnLrCchBuAPmG9X/BTPNe1YH+yMSvdv5mLmPzPHmv
 utDFNkZXwrpjAfeX8TUV+4y1FuSm097RuPOijMCic2+JdrEYCE7fjYMFXrLaWTf1t5x5MaxnQPG
 m/ULbhMQZzQburFIQc2O1vRwt/yIZh0MV+yevvN/TO5zsDGE9KkX8+8FnTAXsY7TDdujvwVDRwB
 J+woz5DdOEOnRUkBlgAC8ytexdR3ykekWQrfwSw7+q58woWrVB2pHebpoR/IbY29/5sc8nDKwDi
 JyIEMZsEyQRtfnA==
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

Avoid unsafe MONITOR_HMP() casts.

The function has no caller since its introduction and could
be dropped if it is not wired to a HMP command.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260828-qemu-no-hmp-v5-38-9227de146347@redhat.com>
---
 hw/hexagon/hexagon_tlb.c         | 8 +++-----
 include/hw/hexagon/hexagon_tlb.h | 5 +++--
 target/hexagon/hex_mmu.c         | 4 ++--
 target/hexagon/hex_mmu.h         | 3 ++-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/hexagon/hexagon_tlb.c b/hw/hexagon/hexagon_tlb.c
index 576929ff224b..584c606a22c5 100644
--- a/hw/hexagon/hexagon_tlb.c
+++ b/hw/hexagon/hexagon_tlb.c
@@ -122,10 +122,8 @@ static inline uint64_t hex_tlb_virt_addr(uint64_t entry)
     return (uint64_t)GET_PTE_VPN(entry) << qemu_target_page_bits();
 }
 
-bool hexagon_tlb_dump_entry(Monitor *mon, uint64_t entry)
+bool hexagon_tlb_dump_entry(MonitorHMP *hmp, uint64_t entry)
 {
-    MonitorHMP *hmp = MONITOR_HMP(mon);
-
     if (GET_PTE_V(entry)) {
         uint64_t PA = hex_tlb_phys_addr(entry);
         uint64_t VA = hex_tlb_virt_addr(entry);
@@ -379,10 +377,10 @@ int hexagon_tlb_check_overlap(HexagonTLBState *tlb, uint64_t entry,
     return -1;
 }
 
-void hexagon_tlb_dump(Monitor *mon, HexagonTLBState *tlb)
+void hexagon_tlb_dump(MonitorHMP *hmp, HexagonTLBState *tlb)
 {
     for (uint32_t i = 0; i < tlb->num_entries; i++) {
-        hexagon_tlb_dump_entry(mon, tlb->entries[i]);
+        hexagon_tlb_dump_entry(hmp, tlb->entries[i]);
     }
 }
 
diff --git a/include/hw/hexagon/hexagon_tlb.h b/include/hw/hexagon/hexagon_tlb.h
index 760dc1ea811b..c3f0fc599fdd 100644
--- a/include/hw/hexagon/hexagon_tlb.h
+++ b/include/hw/hexagon/hexagon_tlb.h
@@ -12,6 +12,7 @@
 #include "qom/object.h"
 #include "exec/hwaddr.h"
 #include "exec/mmu-access-type.h"
+#include "monitor/hmp.h"
 
 #define TYPE_HEXAGON_TLB "hexagon-tlb"
 OBJECT_DECLARE_SIMPLE_TYPE(HexagonTLBState, HEXAGON_TLB)
@@ -37,9 +38,9 @@ uint32_t hexagon_tlb_lookup(HexagonTLBState *tlb, uint32_t asid,
 int hexagon_tlb_check_overlap(HexagonTLBState *tlb, uint64_t entry,
                               uint64_t index);
 
-void hexagon_tlb_dump(Monitor *mon, HexagonTLBState *tlb);
+void hexagon_tlb_dump(MonitorHMP *hmp, HexagonTLBState *tlb);
 
-bool hexagon_tlb_dump_entry(Monitor *mon, uint64_t entry);
+bool hexagon_tlb_dump_entry(MonitorHMP *hmp, uint64_t entry);
 
 uint32_t hexagon_tlb_get_num_entries(HexagonTLBState *tlb);
 
diff --git a/target/hexagon/hex_mmu.c b/target/hexagon/hex_mmu.c
index 81d64a6146cc..242de06eaad2 100644
--- a/target/hexagon/hex_mmu.c
+++ b/target/hexagon/hex_mmu.c
@@ -107,10 +107,10 @@ int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t entry, uint64_t index)
     return hexagon_tlb_check_overlap(cpu->tlb, entry, index);
 }
 
-void dump_mmu(Monitor *mon, CPUHexagonState *env)
+void dump_mmu(MonitorHMP *hmp, CPUHexagonState *env)
 {
     HexagonCPU *cpu = env_archcpu(env);
-    hexagon_tlb_dump(mon, cpu->tlb);
+    hexagon_tlb_dump(hmp, cpu->tlb);
 }
 
 static inline void print_thread(const char *str, CPUState *cs)
diff --git a/target/hexagon/hex_mmu.h b/target/hexagon/hex_mmu.h
index 6aa450b94136..56b2c4a89d0c 100644
--- a/target/hexagon/hex_mmu.h
+++ b/target/hexagon/hex_mmu.h
@@ -10,6 +10,7 @@
 #include "exec/hwaddr.h"
 #include "exec/mmu-access-type.h"
 #include "cpu.h"
+#include "monitor/hmp.h"
 
 extern void hex_tlbw(CPUHexagonState *env, uint32_t index, uint64_t value);
 extern uint32_t hex_tlb_lookup(CPUHexagonState *env, uint32_t ssr, uint32_t VA);
@@ -23,5 +24,5 @@ extern int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t entry,
                                  uint64_t index);
 extern void hex_tlb_lock(CPUHexagonState *env);
 extern void hex_tlb_unlock(CPUHexagonState *env);
-void dump_mmu(Monitor *mon, CPUHexagonState *env);
+void dump_mmu(MonitorHMP *hmp, CPUHexagonState *env);
 #endif

-- 
2.55.0.543.g5ebe2ebe4ea8


