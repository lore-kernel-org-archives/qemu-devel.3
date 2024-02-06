Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290F0C4829A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 10:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXIw1-0006vy-1N; Tue, 06 Feb 2024 05:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXIvz-0006vd-OC
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 05:44:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXIvy-0003Dy-5t
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 05:44:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707216244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LGZZO9ES01M1eLb8cjBZeC4p/SbElxMoWsEHPrWTT40=;
 b=EWTZ8zFY3pNlCN7pfKlI9QlawTB95JNbrFgqU/9BdXhHZEcxqERwIYU+XO7avYjwwYPIWW
 9LaEKe7x0V9Ya8iTIhY2AgenCDWpbB/0TNsyMvYQxXwxk3LHI359D3I3HUIQY3WctIhdZX
 gCbS2vGeZWWjAjglQtK6o5CuqPHgEZ4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-mySQl5q0NCurK_4ZKgm4jQ-1; Tue,
 06 Feb 2024 05:44:00 -0500
X-MC-Unique: mySQl5q0NCurK_4ZKgm4jQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 885B938143AA;
 Tue,  6 Feb 2024 10:44:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.195.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 731D5492BF0;
 Tue,  6 Feb 2024 10:43:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 06/12] tests/tcg/s390x: Test CONVERT TO DECIMAL
Date: Tue,  6 Feb 2024 11:43:41 +0100
Message-ID: <20240206104347.238825-7-thuth@redhat.com>
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

Check the CVD's, CVDY's, and CVDG's corner cases.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20240205205830.6425-4-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/s390x/cvd.c           | 63 +++++++++++++++++++++++++++++++++
 tests/tcg/s390x/Makefile.target |  1 +
 2 files changed, 64 insertions(+)
 create mode 100644 tests/tcg/s390x/cvd.c

diff --git a/tests/tcg/s390x/cvd.c b/tests/tcg/s390x/cvd.c
new file mode 100644
index 0000000000..d776688985
--- /dev/null
+++ b/tests/tcg/s390x/cvd.c
@@ -0,0 +1,63 @@
+/*
+ * Test the CONVERT TO DECIMAL instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdint.h>
+#include <stdlib.h>
+
+static uint64_t cvd(int32_t x)
+{
+    uint64_t ret;
+
+    asm("cvd %[x],%[ret]" : [ret] "=R" (ret) : [x] "r" (x));
+
+    return ret;
+}
+
+static uint64_t cvdy(int32_t x)
+{
+    uint64_t ret;
+
+    asm("cvdy %[x],%[ret]" : [ret] "=T" (ret) : [x] "r" (x));
+
+    return ret;
+}
+
+static __uint128_t cvdg(int64_t x)
+{
+    __uint128_t ret;
+
+    asm("cvdg %[x],%[ret]" : [ret] "=T" (ret) : [x] "r" (x));
+
+    return ret;
+}
+
+int main(void)
+{
+    __uint128_t m = (((__uint128_t)0x9223372036854775) << 16) | 0x8070;
+
+    assert(cvd(0) == 0xc);
+    assert(cvd(1) == 0x1c);
+    assert(cvd(25594) == 0x25594c);
+    assert(cvd(-1) == 0x1d);
+    assert(cvd(0x7fffffff) == 0x2147483647c);
+    assert(cvd(-0x80000000) == 0x2147483648d);
+
+    assert(cvdy(0) == 0xc);
+    assert(cvdy(1) == 0x1c);
+    assert(cvdy(25594) == 0x25594c);
+    assert(cvdy(-1) == 0x1d);
+    assert(cvdy(0x7fffffff) == 0x2147483647c);
+    assert(cvdy(-0x80000000) == 0x2147483648d);
+
+    assert(cvdg(0) == 0xc);
+    assert(cvdg(1) == 0x1c);
+    assert(cvdg(25594) == 0x25594c);
+    assert(cvdg(-1) == 0x1d);
+    assert(cvdg(0x7fffffffffffffff) == (m + 0xc));
+    assert(cvdg(-0x8000000000000000) == (m + 0x1d));
+
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 30994dcf9c..04e4bddd83 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -45,6 +45,7 @@ TESTS+=clc
 TESTS+=laalg
 TESTS+=add-logical-with-carry
 TESTS+=lae
+TESTS+=cvd
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
-- 
2.43.0


