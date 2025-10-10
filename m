Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5144CCD187
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 08:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v78OH-000292-Ob; Fri, 10 Oct 2025 04:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v78OF-00028F-4T
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v78O9-00018o-G2
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760084528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kN1hftEnvVvBVOyTPgXuryjh2sa8FXlMQCoo5OJbylY=;
 b=gZAekeU90zZono5gNioezBDEFbqjDuq1UZ/gDUMCZAfpjLoGCe7zOm61QfnePYtVSkkv/U
 L4TkoQudzFtrQfs9JQ/g+8Q+ySbSe1ROzo+RGxaOgB0TcqHxJDqbr/xJoOYvC+P/OPUSGT
 6ZZAV4zctVNTRXPqtQaqlpef7226lkY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-_H1qvcEqN36b20i0GAhZ9A-1; Fri,
 10 Oct 2025 04:22:06 -0400
X-MC-Unique: _H1qvcEqN36b20i0GAhZ9A-1
X-Mimecast-MFC-AGG-ID: _H1qvcEqN36b20i0GAhZ9A_1760084525
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BCF9180034F; Fri, 10 Oct 2025 08:22:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.98])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2579F1800446; Fri, 10 Oct 2025 08:22:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 8/9] target/s390x: Replace legacy cpu_physical_memory_[un]map()
 calls (3/3)
Date: Fri, 10 Oct 2025 10:21:43 +0200
Message-ID: <20251010082145.576222-9-thuth@redhat.com>
In-Reply-To: <20251010082145.576222-1-thuth@redhat.com>
References: <20251010082145.576222-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

Commit b7ecba0f6f6 ("docs/devel/loads-stores.rst: Document our
various load and store APIs") mentioned cpu_physical_memory_*()
methods are legacy, the replacement being address_space_*().

Replace the *_map() / *_unmap() methods in s390_store_status()
and s390_store_adtl_status(). In s390_store_status(), replace
cpu_physical_memory_write() by address_space_stb(), restricting
@ar_id scope. No behavioral change expected.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251002091132.65703-10-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/sigp.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index 2487acdb49e..f5d7bc0fa22 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -13,6 +13,7 @@
 #include "s390x-internal.h"
 #include "hw/boards.h"
 #include "system/hw_accel.h"
+#include "system/memory.h"
 #include "system/runstate.h"
 #include "system/address-spaces.h"
 #include "exec/cputlb.h"
@@ -147,7 +148,8 @@ QEMU_BUILD_BUG_ON(sizeof(SigpSaveArea) != 512);
 #define S390_STORE_STATUS_DEF_ADDR offsetof(LowCore, floating_pt_save_area)
 static int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
 {
-    static const uint8_t ar_id = 1;
+    const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
+    AddressSpace *as = CPU(cpu)->as;
     SigpSaveArea *sa;
     hwaddr len = sizeof(*sa);
     int i;
@@ -157,17 +159,21 @@ static int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
         return 0;
     }
 
-    sa = cpu_physical_memory_map(addr, &len, true);
+    sa = address_space_map(as, addr, &len, true, attrs);
     if (!sa) {
         return -EFAULT;
     }
     if (len != sizeof(*sa)) {
-        cpu_physical_memory_unmap(sa, len, 1, 0);
+        address_space_unmap(as, sa, len, true, 0);
         return -EFAULT;
     }
 
     if (store_arch) {
-        cpu_physical_memory_write(offsetof(LowCore, ar_access_id), &ar_id, 1);
+        static const uint8_t ar_id = 1;
+
+        address_space_stb(as, offsetof(LowCore, ar_access_id),
+                          ar_id, attrs, NULL);
+
     }
     for (i = 0; i < 16; ++i) {
         sa->fprs[i] = cpu_to_be64(*get_freg(&cpu->env, i));
@@ -189,7 +195,7 @@ static int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
         sa->crs[i] = cpu_to_be64(cpu->env.cregs[i]);
     }
 
-    cpu_physical_memory_unmap(sa, len, 1, len);
+    address_space_unmap(as, sa, len, true, len);
 
     return 0;
 }
@@ -251,16 +257,18 @@ QEMU_BUILD_BUG_ON(sizeof(SigpAdtlSaveArea) != 4096);
 #define ADTL_GS_MIN_SIZE 2048 /* minimal size of adtl save area for GS */
 static int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len)
 {
+    const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
+    AddressSpace *as = CPU(cpu)->as;
     SigpAdtlSaveArea *sa;
     hwaddr save = len;
     int i;
 
-    sa = cpu_physical_memory_map(addr, &save, true);
+    sa = address_space_map(as, addr, &save, true, attrs);
     if (!sa) {
         return -EFAULT;
     }
     if (save != len) {
-        cpu_physical_memory_unmap(sa, len, 1, 0);
+        address_space_unmap(as, sa, len, true, 0);
         return -EFAULT;
     }
 
@@ -276,7 +284,8 @@ static int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len)
         }
     }
 
-    cpu_physical_memory_unmap(sa, len, 1, len);
+    address_space_unmap(as, sa, len, true, len);
+
     return 0;
 }
 
-- 
2.51.0


