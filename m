Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F07EC4829A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 10:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXIw3-0006y2-DQ; Tue, 06 Feb 2024 05:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXIw1-0006wF-9t
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 05:44:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXIvy-0003EO-62
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 05:44:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707216246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gw1GdGhiSZCRfVvN19txv0e6ILB4Z/YReWhCQVwyc4s=;
 b=OAypWjVytg7c1IW/CIPHtTzi/B360UDhndM1RW37B4ZQsYBv0TFc0VMRrx4jV8GARR1psn
 zSVdYv7eIuVnooAuxNy4mcD/hk+t6JQpb1g8WE9fhKHQ9OB4VWk+9wjRgjwJnF2+fE7Hat
 esaCRHry/QSTE8FxD1MI0cTRUb5Tids=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-6JdNDj7DMYaWHDqGEuN_Yw-1; Tue, 06 Feb 2024 05:44:02 -0500
X-MC-Unique: 6JdNDj7DMYaWHDqGEuN_Yw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B25284AC68;
 Tue,  6 Feb 2024 10:44:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.195.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9E0C492BF0;
 Tue,  6 Feb 2024 10:44:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Subject: [PULL 07/12] tests/tcg/s390x: Test CONVERT TO BINARY
Date: Tue,  6 Feb 2024 11:43:42 +0100
Message-ID: <20240206104347.238825-8-thuth@redhat.com>
In-Reply-To: <20240206104347.238825-1-thuth@redhat.com>
References: <20240206104347.238825-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Check the CVB's, CVBY's, and CVBG's corner cases.

Co-developed-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20240205205830.6425-5-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/s390x/cvb.c           | 102 ++++++++++++++++++++++++++++++++
 tests/tcg/s390x/Makefile.target |   1 +
 2 files changed, 103 insertions(+)
 create mode 100644 tests/tcg/s390x/cvb.c

diff --git a/tests/tcg/s390x/cvb.c b/tests/tcg/s390x/cvb.c
new file mode 100644
index 0000000000..e1735f6b81
--- /dev/null
+++ b/tests/tcg/s390x/cvb.c
@@ -0,0 +1,102 @@
+/*
+ * Test the CONVERT TO BINARY instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <signal.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+
+static int signum;
+
+static void signal_handler(int n)
+{
+    signum = n;
+}
+
+#define FAIL 0x1234567887654321
+#define OK32(x) (0x1234567800000000 | (uint32_t)(x))
+
+static int64_t cvb(uint64_t x)
+{
+    int64_t ret = FAIL;
+
+    signum = -1;
+    asm("cvb %[ret],%[x]" : [ret] "+r" (ret) : [x] "R" (x));
+
+    return ret;
+}
+
+static int64_t cvby(uint64_t x)
+{
+    int64_t ret = FAIL;
+
+    signum = -1;
+    asm("cvby %[ret],%[x]" : [ret] "+r" (ret) : [x] "T" (x));
+
+    return ret;
+}
+
+static int64_t cvbg(__uint128_t x)
+{
+    int64_t ret = FAIL;
+
+    signum = -1;
+    asm("cvbg %[ret],%[x]" : [ret] "+r" (ret) : [x] "T" (x));
+
+    return ret;
+}
+
+int main(void)
+{
+    __uint128_t m = (((__uint128_t)0x9223372036854775) << 16) | 0x8070;
+    struct sigaction act;
+    int err;
+
+    memset(&act, 0, sizeof(act));
+    act.sa_handler = signal_handler;
+    err = sigaction(SIGFPE, &act, NULL);
+    assert(err == 0);
+    err = sigaction(SIGILL, &act, NULL);
+    assert(err == 0);
+
+    assert(cvb(0xc) == OK32(0) && signum == -1);
+    assert(cvb(0x1c) == OK32(1) && signum == -1);
+    assert(cvb(0x25594c) == OK32(25594) && signum == -1);
+    assert(cvb(0x1d) == OK32(-1) && signum == -1);
+    assert(cvb(0x2147483647c) == OK32(0x7fffffff) && signum == -1);
+    assert(cvb(0x2147483648d) == OK32(-0x80000000) && signum == -1);
+    assert(cvb(0x7) == FAIL && signum == SIGILL);
+    assert(cvb(0x2147483648c) == OK32(0x80000000) && signum == SIGFPE);
+    assert(cvb(0x3000000000c) == OK32(0xb2d05e00) && signum == SIGFPE);
+    assert(cvb(0x2147483649d) == OK32(0x7fffffff) && signum == SIGFPE);
+    assert(cvb(0x3000000000d) == OK32(0x4d2fa200) && signum == SIGFPE);
+
+    assert(cvby(0xc) == OK32(0));
+    assert(cvby(0x1c) == OK32(1));
+    assert(cvby(0x25594c) == OK32(25594));
+    assert(cvby(0x1d) == OK32(-1));
+    assert(cvby(0x2147483647c) == OK32(0x7fffffff));
+    assert(cvby(0x2147483648d) == OK32(-0x80000000));
+    assert(cvby(0x7) == FAIL && signum == SIGILL);
+    assert(cvby(0x2147483648c) == OK32(0x80000000) && signum == SIGFPE);
+    assert(cvby(0x3000000000c) == OK32(0xb2d05e00) && signum == SIGFPE);
+    assert(cvby(0x2147483649d) == OK32(0x7fffffff) && signum == SIGFPE);
+    assert(cvby(0x3000000000d) == OK32(0x4d2fa200) && signum == SIGFPE);
+
+    assert(cvbg(0xc) == 0);
+    assert(cvbg(0x1c) == 1);
+    assert(cvbg(0x25594c) == 25594);
+    assert(cvbg(0x1d) == -1);
+    assert(cvbg(m + 0xc) == 0x7fffffffffffffff);
+    assert(cvbg(m + 0x1d) == -0x8000000000000000);
+    assert(cvbg(0x7) == FAIL && signum == SIGILL);
+    assert(cvbg(m + 0x1c) == FAIL && signum == SIGFPE);
+    assert(cvbg(m + 0x2d) == FAIL && signum == SIGFPE);
+    assert(cvbg(((__uint128_t)1 << 80) + 0xc) == FAIL && signum == SIGFPE);
+    assert(cvbg(((__uint128_t)1 << 80) + 0xd) == FAIL && signum == SIGFPE);
+
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 04e4bddd83..e2aba2ec27 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -46,6 +46,7 @@ TESTS+=laalg
 TESTS+=add-logical-with-carry
 TESTS+=lae
 TESTS+=cvd
+TESTS+=cvb
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
-- 
2.43.0


