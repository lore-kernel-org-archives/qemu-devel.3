Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AADCF31B7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 12:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svyqZ-0006ed-IT; Wed, 02 Oct 2024 08:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svyqU-0006ci-6V
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 08:52:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svyqR-0003cO-PO
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 08:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727873563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3751MXMOy3sONsBUCbkpnnVF+sSrHF6QSWD7o0QUuic=;
 b=M6PFCPZ7g/U9DMn//Yu2MZYj9Cm3JDWj67bClve6BGUeCm4Se1J7z8SPz44Htw9bgqcBKe
 NRdmwML9otHYr18DP7nGrXTa+ywPh6+RH8J+MJudlKYQtId8LUduJ3FMy1zyXZM44THIQu
 8O3D+xeoscRL64+iG7zZGCqwUQaYVq4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-9r0IXqyGMCKzmte0NZkqIQ-1; Wed,
 02 Oct 2024 08:52:39 -0400
X-MC-Unique: 9r0IXqyGMCKzmte0NZkqIQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6F771955F41; Wed,  2 Oct 2024 12:52:38 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.239])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 831AC1956056; Wed,  2 Oct 2024 12:52:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 5/5] tests/tcg/s390x: Test modifying an EXECUTE target
Date: Wed,  2 Oct 2024 14:52:26 +0200
Message-ID: <20241002125226.282193-6-thuth@redhat.com>
In-Reply-To: <20241002125226.282193-1-thuth@redhat.com>
References: <20241002125226.282193-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

QEMU correctly implements the tracking of EXECUTE target modifications
by storing the instruction text in env->ex_value and tb->cs_base, the
latter of which is used for lookups.

Still, EXECUTE is a tricky corner of the s390x emulation, which can
benefit from having a regression test.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20241001145634.9786-1-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/s390x/ex-smc.c        | 57 +++++++++++++++++++++++++++++++++
 tests/tcg/s390x/Makefile.target |  1 +
 2 files changed, 58 insertions(+)
 create mode 100644 tests/tcg/s390x/ex-smc.c

diff --git a/tests/tcg/s390x/ex-smc.c b/tests/tcg/s390x/ex-smc.c
new file mode 100644
index 0000000000..f403640d6b
--- /dev/null
+++ b/tests/tcg/s390x/ex-smc.c
@@ -0,0 +1,57 @@
+/*
+ * Test modifying an EXECUTE target.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+
+/* Make sure we exercise the same EXECUTE instruction. */
+extern void execute(unsigned char *insn, unsigned char mask,
+                    unsigned long *r1_r5);
+asm(".globl execute\n"
+    "execute:\n"
+    "lg %r1,0(%r4)\n"
+    "lg %r5,8(%r4)\n"
+    "ex %r3,0(%r2)\n"
+    "stg %r5,8(%r4)\n"
+    "stg %r1,0(%r4)\n"
+    "br %r14\n");
+
+/* Define an RWX EXECUTE target. */
+extern unsigned char lgfi[];
+asm(".pushsection .rwx,\"awx\",@progbits\n"
+    ".globl lgfi\n"
+    "lgfi: lgfi %r0,0\n"
+    ".popsection\n");
+
+int main(void)
+{
+    unsigned long r1_r5[2];
+
+    /* Create an initial TB. */
+    r1_r5[0] = -1;
+    r1_r5[1] = -1;
+    execute(lgfi, 1 << 4, r1_r5);
+    assert(r1_r5[0] == 0);
+    assert(r1_r5[1] == -1);
+
+    /* Test changing the mask. */
+    execute(lgfi, 5 << 4, r1_r5);
+    assert(r1_r5[0] == 0);
+    assert(r1_r5[1] == 0);
+
+    /* Test changing the target. */
+    lgfi[5] = 42;
+    execute(lgfi, 5 << 4, r1_r5);
+    assert(r1_r5[0] == 0);
+    assert(r1_r5[1] == 42);
+
+    /* Test changing both the mask and the target. */
+    lgfi[5] = 24;
+    execute(lgfi, 1 << 4, r1_r5);
+    assert(r1_r5[0] == 24);
+    assert(r1_r5[1] == 42);
+
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index a8f86c9449..2dab4f4582 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -48,6 +48,7 @@ TESTS+=lae
 TESTS+=cvd
 TESTS+=cvb
 TESTS+=ts
+TESTS+=ex-smc
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
-- 
2.46.1


