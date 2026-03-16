Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFC6F4644B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25Nc-0006AA-7r; Mon, 16 Mar 2026 06:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w25NX-00068N-HM
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:40:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w25NW-0003Oc-32
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773657652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+y81v+0Jfk3iDnL1mTuIdC5aMu/dImfO6XnY3Pl5/e0=;
 b=ZgAtQODx6149T5+EhO0hdOR1FIh2Bc8DY45HOoomUCpFERlrotMWURWKW86oR/MxZbE1EG
 d8OQDeroVrm7wiPLr46qrjIWegWcEz8q/AHETyTmELCWvG5Ti6kFy0tna6qc8okCkyBHyY
 jY0st+zWBHD96ZLr8vppiZTFGVduzDY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-1NQLNwG9MQa01gTy60huWw-1; Mon,
 16 Mar 2026 06:40:49 -0400
X-MC-Unique: 1NQLNwG9MQa01gTy60huWw-1
X-Mimecast-MFC-AGG-ID: 1NQLNwG9MQa01gTy60huWw_1773657648
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72D6F1800281; Mon, 16 Mar 2026 10:40:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 653B519560AB; Mon, 16 Mar 2026 10:40:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PULL 02/14] target/mips/cpu: Move initialization of memory region to
 realize function
Date: Mon, 16 Mar 2026 11:40:27 +0100
Message-ID: <20260316104039.195960-3-thuth@redhat.com>
In-Reply-To: <20260316104039.195960-1-thuth@redhat.com>
References: <20260316104039.195960-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

When introspecting the Loongson-3A4000 CPUs from the command line, QEMU
currently crashes:

 $ ./qemu-system-mips64el -device Loongson-3A4000-mips64-cpu,help
 qemu-system-mips64el: ../../devel/qemu/system/physmem.c:1401:
  register_multipage: Assertion `num_pages' failed.
 Aborted (core dumped)

Move the initialization of the memory regions to the realize function
to fix this problem.

Reported-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <87y0jxzdrk.fsf@pond.sub.org>
Tested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260311211629.118608-1-thuth@redhat.com>
---
 target/mips/cpu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index e424d115018..5f88c077dbf 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -460,6 +460,14 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+#ifndef CONFIG_USER_ONLY
+    if (mcc->cpu_def->lcsr_cpucfg2 & (1 << CPUCFG2_LCSRP)) {
+        memory_region_init_io(&env->iocsr.mr, OBJECT(cpu), NULL,
+                              env, "iocsr", UINT64_MAX);
+        address_space_init(&env->iocsr.as, &env->iocsr.mr, "IOCSR");
+    }
+#endif
+
     if (!clock_get(cpu->clock)) {
 #ifndef CONFIG_USER_ONLY
         if (!qtest_enabled()) {
@@ -504,14 +512,6 @@ static void mips_cpu_initfn(Object *obj)
     cpu->count_div = clock_new(OBJECT(obj), "clk-div-count");
     env->count_clock = clock_new(OBJECT(obj), "clk-count");
     env->cpu_model = mcc->cpu_def;
-#ifndef CONFIG_USER_ONLY
-    if (mcc->cpu_def->lcsr_cpucfg2 & (1 << CPUCFG2_LCSRP)) {
-        memory_region_init_io(&env->iocsr.mr, OBJECT(cpu), NULL,
-                                env, "iocsr", UINT64_MAX);
-        address_space_init(&env->iocsr.as,
-                            &env->iocsr.mr, "IOCSR");
-    }
-#endif
 }
 
 static char *mips_cpu_type_name(const char *cpu_model)
-- 
2.53.0


