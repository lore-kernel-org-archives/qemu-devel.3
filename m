Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DB2C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 13:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td8NR-0007h6-W1; Wed, 29 Jan 2025 08:45:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td8NN-0007cb-9M
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 08:45:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td8NJ-0008Am-Ny
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 08:45:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738158300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mBQt2BZ9Pble/MczGAKPnWj9zi6Lm9BXY9A2HjlrxTM=;
 b=DZ2aE6M0AnKCFsUT6tUPjsCtvIiI80b5J4fXfKw5n5Uvo2TKuWqJ4Ynv45gyKKOXTX9b68
 FX8ACVkJ6YtnyxZP/93oPRa+jiyQ/DPGoKNcfUvKCOlXzm9CbVSCMBS/ZjXGTaPZ1I9mKu
 25yAaKTHCTyckvjr+cNb8Jiy/nU/gXk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-CruW9kk2OmaWWgH41rV15g-1; Wed,
 29 Jan 2025 08:44:57 -0500
X-MC-Unique: CruW9kk2OmaWWgH41rV15g-1
X-Mimecast-MFC-AGG-ID: CruW9kk2OmaWWgH41rV15g
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17EEF1800361; Wed, 29 Jan 2025 13:44:56 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AD1A11800352; Wed, 29 Jan 2025 13:44:53 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 imp@bsdimp.com, kevans@freebsd.org, gaosong@loongson.cn, laurent@vivier.eu
Subject: [PATCH 4/6] tcg:tlb: use tcg_debug_assert() in assert_cpu_is_self()
Date: Wed, 29 Jan 2025 14:44:34 +0100
Message-ID: <20250129134436.1240740-5-imammedo@redhat.com>
In-Reply-To: <20250129134436.1240740-1-imammedo@redhat.com>
References: <20250129134436.1240740-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

that will enable assert_cpu_is_self when QEMU is configured with
   --enable-debug
without need for manual patching DEBUG_TLB_GATE define.

Need to manually path DEBUG_TLB_GATE define to enable assert,
let regression caused by [1] creep in unnoticed.

1) 30933c4fb4f3d ("tcg/cputlb: remove other-cpu capability from TLB flushing")
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/cputlb.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b4ccf0cdcb..71207d6dbf 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -61,8 +61,8 @@
 #  define DEBUG_TLB_LOG_GATE 0
 # endif
 #else
-# define DEBUG_TLB_GATE 0
-# define DEBUG_TLB_LOG_GATE 0
+# define DEBUG_TLB_GATE 1
+# define DEBUG_TLB_LOG_GATE 1
 #endif
 
 #define tlb_debug(fmt, ...) do { \
@@ -74,11 +74,8 @@
     } \
 } while (0)
 
-#define assert_cpu_is_self(cpu) do {                              \
-        if (DEBUG_TLB_GATE) {                                     \
-            g_assert(!(cpu)->created || qemu_cpu_is_self(cpu));   \
-        }                                                         \
-    } while (0)
+#define assert_cpu_is_self(cpu)                             \
+    tcg_debug_assert(!(cpu)->created || qemu_cpu_is_self(cpu))
 
 /* run_on_cpu_data.target_ptr should always be big enough for a
  * vaddr even on 32 bit builds
-- 
2.43.0


