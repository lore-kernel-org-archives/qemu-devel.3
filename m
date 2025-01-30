Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82E1C0218F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 13:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUPy-0000Ab-Qa; Thu, 30 Jan 2025 08:17:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUOy-0007QS-BT
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:16:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUOt-000072-PZ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738242966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uRR7H0WP9B1yJ57bUByZTD6jaIfJLAD8x8hHtwlCHIg=;
 b=aexEoMQOUUJB1dQZwYBoNU3GDIw4g/xIOFD0+mw6QP+A0ibsjYxm2g699zFI5HgKa1M/6C
 GUYcMM49eu2stACHpEROH3kpijQLlj33agQt1+eagVfukOcs9GsihB6PDom3jyuXsvz1nx
 9lbQPVcZUwhHl7cGUvYCrhf1xoeOpBs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-B1Fb_jhzObegA9xhJwTADw-1; Thu,
 30 Jan 2025 08:16:03 -0500
X-MC-Unique: B1Fb_jhzObegA9xhJwTADw-1
X-Mimecast-MFC-AGG-ID: B1Fb_jhzObegA9xhJwTADw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57FFD19560B0; Thu, 30 Jan 2025 13:16:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.95])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BDBD630001BE; Thu, 30 Jan 2025 13:16:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/20] tests/tcg/s390x: Test modifying code using the MVC
 instruction
Date: Thu, 30 Jan 2025 14:15:23 +0100
Message-ID: <20250130131535.91297-10-thuth@redhat.com>
In-Reply-To: <20250130131535.91297-1-thuth@redhat.com>
References: <20250130131535.91297-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Add a small test to prevent regressions.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250128001338.11474-2-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/s390x/mvc-smc.c               | 82 +++++++++++++++++++++++++
 tests/tcg/s390x/Makefile.softmmu-target |  1 +
 2 files changed, 83 insertions(+)
 create mode 100644 tests/tcg/s390x/mvc-smc.c

diff --git a/tests/tcg/s390x/mvc-smc.c b/tests/tcg/s390x/mvc-smc.c
new file mode 100644
index 0000000000..d68f60caa8
--- /dev/null
+++ b/tests/tcg/s390x/mvc-smc.c
@@ -0,0 +1,82 @@
+/*
+ * Test modifying code using the MVC instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <minilib.h>
+
+#define PAGE_SIZE 4096
+#define BR_14_SIZE 2
+#define RWX_OFFSET 2
+
+static unsigned char rw[PAGE_SIZE + BR_14_SIZE];
+static unsigned char rwx[RWX_OFFSET + sizeof(rw)]
+    __attribute__((aligned(PAGE_SIZE)));
+
+typedef unsigned long (*function_t)(unsigned long);
+
+static int emit_function(unsigned char *p, int n)
+{
+    int i = 0, val = 0;
+
+    while (i < n - 2) {
+        /* aghi %r2,1 */
+        p[i++] = 0xa7;
+        p[i++] = 0x2b;
+        p[i++] = 0x00;
+        p[i++] = 0x01;
+        val++;
+    }
+
+    /* br %r14 */
+    p[i++] = 0x07;
+    p[i++] = 0xfe;
+
+    return val;
+}
+
+static void memcpy_mvc(void *dest, void *src, unsigned long n)
+{
+    while (n >= 256) {
+        asm("mvc 0(256,%[dest]),0(%[src])"
+            :
+            : [dest] "a" (dest)
+            , [src] "a" (src)
+            : "memory");
+        dest += 256;
+        src += 256;
+        n -= 256;
+    }
+    asm("exrl %[n],0f\n"
+        "j 1f\n"
+        "0: mvc 0(1,%[dest]),0(%[src])\n"
+        "1:"
+        :
+        : [dest] "a" (dest)
+        , [src] "a" (src)
+        , [n] "a" (n)
+        : "memory");
+}
+
+int main(void)
+{
+    int expected, size;
+
+    /* Create a TB. */
+    size = sizeof(rwx) - RWX_OFFSET - 4;
+    expected = emit_function(rwx + RWX_OFFSET, size);
+    if (((function_t)(rwx + RWX_OFFSET))(0) != expected) {
+        return 1;
+    }
+
+    /* Overwrite the TB. */
+    size += 4;
+    expected = emit_function(rw, size);
+    memcpy_mvc(rwx + RWX_OFFSET, rw, size);
+    if (((function_t)(rwx + RWX_OFFSET))(0) != expected) {
+        return 2;
+    }
+
+    return 0;
+}
diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
index 7adde2fa08..8cd4667c63 100644
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ b/tests/tcg/s390x/Makefile.softmmu-target
@@ -42,6 +42,7 @@ $(ASM_TESTS): LDFLAGS += -Wl,-T$(LINK_SCRIPT) -Wl,--build-id=none
 $(ASM_TESTS): $(LINK_SCRIPT)
 TESTS += $(ASM_TESTS)
 
+MULTIARCH_TESTS += mvc-smc
 S390X_MULTIARCH_RUNTIME_OBJS = head64.o console.o $(MINILIB_OBJS)
 $(MULTIARCH_TESTS): $(S390X_MULTIARCH_RUNTIME_OBJS)
 $(MULTIARCH_TESTS): LDFLAGS += $(S390X_MULTIARCH_RUNTIME_OBJS)
-- 
2.48.1


