Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D55CCFA05
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 11:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFsHm-0004M7-Q5; Mon, 03 Nov 2025 05:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFsHZ-0004AZ-9w
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:59:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFsHT-0004eP-VY
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762167562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gSuvTRmXv2fofIP+bvbCeQLENVrlaMGpCelkpxptMhg=;
 b=hccVFyCJpnW9LJ3FHQfxm+qyJGZnD+yEH0hevEyGqRarfJ7c9q2qO6ZDSDuBC2HFjV0m/e
 D/lFqpbtY/E1ZPlAclWhvvQdjlTxBUS+u3RHf5FVUa66N0ULRtzVYhGl+f62/r/QKdaeFS
 9bf9U0O/tIlUyebE+QS7V/nVSFM+BpY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-CMfXd6aSMnebgpwbm6jd_w-1; Mon,
 03 Nov 2025 05:59:18 -0500
X-MC-Unique: CMfXd6aSMnebgpwbm6jd_w-1
X-Mimecast-MFC-AGG-ID: CMfXd6aSMnebgpwbm6jd_w_1762167557
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFC941801376; Mon,  3 Nov 2025 10:59:16 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 417D830001BC; Mon,  3 Nov 2025 10:59:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 22/22] tests/tcg/s390x: Test SET CLOCK COMPARATOR
Date: Mon,  3 Nov 2025 11:58:19 +0100
Message-ID: <20251103105824.322039-23-thuth@redhat.com>
In-Reply-To: <20251103105824.322039-1-thuth@redhat.com>
References: <20251103105824.322039-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Cc: qemu-stable@nongnu.org
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20251016175954.41153-5-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/s390x/Makefile.softmmu-target |  1 +
 tests/tcg/s390x/sckc.S                  | 63 +++++++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 tests/tcg/s390x/sckc.S

diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
index 8cd4667c63b..a4425d3184a 100644
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ b/tests/tcg/s390x/Makefile.softmmu-target
@@ -28,6 +28,7 @@ ASM_TESTS =                                                                    \
     mc                                                                         \
     per                                                                        \
     precise-smc-softmmu                                                        \
+    sckc                                                                       \
     ssm-early                                                                  \
     stosm-early                                                                \
     stpq                                                                       \
diff --git a/tests/tcg/s390x/sckc.S b/tests/tcg/s390x/sckc.S
new file mode 100644
index 00000000000..ecd64a3059e
--- /dev/null
+++ b/tests/tcg/s390x/sckc.S
@@ -0,0 +1,63 @@
+/*
+ * Test clock comparator.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+    .org 0x130
+ext_old_psw:
+    .org 0x1b0
+ext_new_psw:
+    .quad 0x180000000, _ext            /* 64-bit mode */
+    .org 0x1d0
+pgm_new_psw:
+    .quad 0x2000000000000,0            /* disabled wait */
+    .org 0x200                         /* lowcore padding */
+
+    .globl _start
+_start:
+    lpswe start31_psw
+_start31:
+    stctg %c0,%c0,c0
+    oi c0+6,8                          /* set clock-comparator subclass mask */
+    lctlg %c0,%c0,c0
+
+0:
+    brasl %r14,_f                      /* %r14's most significant bit is 1 */
+    jg 0b
+_f:
+    br %r14                            /* it must not end up in ext_old_psw */
+
+_ext:
+    stg %r0,ext_saved_r0
+
+    lg %r0,ext_counter
+    aghi %r0,1
+    stg %r0,ext_counter
+
+    cgfi %r0,0x1000
+    jnz 0f
+    lpswe success_psw
+0:
+
+    stck clock
+    lg %r0,clock
+    agfi %r0,0x40000                   /* 64us * 0x1000 =~ 0.25s */
+    stg %r0,clock
+    sckc clock
+
+    lg %r0,ext_saved_r0
+    lpswe ext_old_psw
+
+    .align 8
+start31_psw:
+    .quad 0x100000080000000,_start31   /* EX, 31-bit mode */
+success_psw:
+    .quad 0x2000000000000,0xfff        /* see is_special_wait_psw() */
+c0:
+    .skip 8
+clock:
+    .quad 0
+ext_counter:
+    .quad 0
+ext_saved_r0:
+    .skip 8
-- 
2.51.0


