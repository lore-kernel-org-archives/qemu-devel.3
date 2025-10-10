Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CF0CCD187
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 08:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v78OI-00029K-0C; Fri, 10 Oct 2025 04:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v78OF-00028E-2N
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v78O6-000182-UX
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760084524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ifzQRiT3Skm5xCdzRm4x7W/pYp3IEbzx1NvAaNKLhE=;
 b=M3/uk7bnRHp5m3V5kLxeAB6vTDNa9TBcWHPy3nkuTMC2NSLvnYaYg+qt3prepSTnhTCw7/
 1o0udJMMO82pHTMt7w2RaRkIIsZ4YI4m+sv3ynrwQdXRdS5zbE7LuEx/HwpjNqW56iBxUm
 UtcVJQrVn5ugEKqAZXdbquhvKJAj0KM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-XgTDX_7SNoKWLHOQpX4-LA-1; Fri,
 10 Oct 2025 04:22:02 -0400
X-MC-Unique: XgTDX_7SNoKWLHOQpX4-LA-1
X-Mimecast-MFC-AGG-ID: XgTDX_7SNoKWLHOQpX4-LA_1760084521
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92ECD1800451; Fri, 10 Oct 2025 08:22:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.98])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 204211800452; Fri, 10 Oct 2025 08:21:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 6/9] target/s390x: Reduce s390_store_adtl_status() scope
Date: Fri, 10 Oct 2025 10:21:41 +0200
Message-ID: <20251010082145.576222-7-thuth@redhat.com>
In-Reply-To: <20251010082145.576222-1-thuth@redhat.com>
References: <20251010082145.576222-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

s390_store_adtl_status() is only called within sigp.c,
move it and the SigpAdtlSaveArea structure definition
there where it belongs, with other SIGP handling code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251002091132.65703-8-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/s390x-internal.h |  1 -
 target/s390x/helper.c         | 40 -----------------------------------
 target/s390x/sigp.c           | 40 +++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 1fb752aa1d6..a49dca94a75 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -325,7 +325,6 @@ hwaddr s390_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 hwaddr s390_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 #define S390_STORE_STATUS_DEF_ADDR offsetof(LowCore, floating_pt_save_area)
 int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch);
-int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len);
 LowCore *cpu_map_lowcore(CPUS390XState *env);
 void cpu_unmap_lowcore(CPUS390XState *env, LowCore *lowcore);
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index b01b7d9bbbf..84321e1d68e 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -248,43 +248,3 @@ int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
 
     return 0;
 }
-
-typedef struct SigpAdtlSaveArea {
-    uint64_t    vregs[32][2];                     /* 0x0000 */
-    uint8_t     pad_0x0200[0x0400 - 0x0200];      /* 0x0200 */
-    uint64_t    gscb[4];                          /* 0x0400 */
-    uint8_t     pad_0x0420[0x1000 - 0x0420];      /* 0x0420 */
-} SigpAdtlSaveArea;
-QEMU_BUILD_BUG_ON(sizeof(SigpAdtlSaveArea) != 4096);
-
-#define ADTL_GS_MIN_SIZE 2048 /* minimal size of adtl save area for GS */
-int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len)
-{
-    SigpAdtlSaveArea *sa;
-    hwaddr save = len;
-    int i;
-
-    sa = cpu_physical_memory_map(addr, &save, true);
-    if (!sa) {
-        return -EFAULT;
-    }
-    if (save != len) {
-        cpu_physical_memory_unmap(sa, len, 1, 0);
-        return -EFAULT;
-    }
-
-    if (s390_has_feat(S390_FEAT_VECTOR)) {
-        for (i = 0; i < 32; i++) {
-            sa->vregs[i][0] = cpu_to_be64(cpu->env.vregs[i][0]);
-            sa->vregs[i][1] = cpu_to_be64(cpu->env.vregs[i][1]);
-        }
-    }
-    if (s390_has_feat(S390_FEAT_GUARDED_STORAGE) && len >= ADTL_GS_MIN_SIZE) {
-        for (i = 0; i < 4; i++) {
-            sa->gscb[i] = cpu_to_be64(cpu->env.gscb[i]);
-        }
-    }
-
-    cpu_physical_memory_unmap(sa, len, 1, len);
-    return 0;
-}
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index 5e95c4978f9..1464be76983 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -172,6 +172,46 @@ static void sigp_store_status_at_address(CPUState *cs, run_on_cpu_data arg)
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
 
+typedef struct SigpAdtlSaveArea {
+    uint64_t    vregs[32][2];                     /* 0x0000 */
+    uint8_t     pad_0x0200[0x0400 - 0x0200];      /* 0x0200 */
+    uint64_t    gscb[4];                          /* 0x0400 */
+    uint8_t     pad_0x0420[0x1000 - 0x0420];      /* 0x0420 */
+} SigpAdtlSaveArea;
+QEMU_BUILD_BUG_ON(sizeof(SigpAdtlSaveArea) != 4096);
+
+#define ADTL_GS_MIN_SIZE 2048 /* minimal size of adtl save area for GS */
+static int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len)
+{
+    SigpAdtlSaveArea *sa;
+    hwaddr save = len;
+    int i;
+
+    sa = cpu_physical_memory_map(addr, &save, true);
+    if (!sa) {
+        return -EFAULT;
+    }
+    if (save != len) {
+        cpu_physical_memory_unmap(sa, len, 1, 0);
+        return -EFAULT;
+    }
+
+    if (s390_has_feat(S390_FEAT_VECTOR)) {
+        for (i = 0; i < 32; i++) {
+            sa->vregs[i][0] = cpu_to_be64(cpu->env.vregs[i][0]);
+            sa->vregs[i][1] = cpu_to_be64(cpu->env.vregs[i][1]);
+        }
+    }
+    if (s390_has_feat(S390_FEAT_GUARDED_STORAGE) && len >= ADTL_GS_MIN_SIZE) {
+        for (i = 0; i < 4; i++) {
+            sa->gscb[i] = cpu_to_be64(cpu->env.gscb[i]);
+        }
+    }
+
+    cpu_physical_memory_unmap(sa, len, 1, len);
+    return 0;
+}
+
 #define ADTL_SAVE_LC_MASK  0xfUL
 static void sigp_store_adtl_status(CPUState *cs, run_on_cpu_data arg)
 {
-- 
2.51.0


