Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2BCF46445
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25NZ-000697-OL; Mon, 16 Mar 2026 06:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w25NT-00067y-S9
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:40:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w25NS-0003OB-6D
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773657648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7lq6U/wWYr83VRC8S0OkGDQe7WUK9tNNh9JpduJXy4Q=;
 b=BJpIX4wbx0zV8OytCpshyrczn/Lq2ZDe/EL8JdCOcv1DfHpqa8jmNaljQOi5oocwcQgsA3
 xopSIndprIynmQx1ptJkcts+Umugvb1OYkFkSunobErZ/uugh5+mz4GFeC6m0TtWtGSri3
 N2KDXCrjCJz+ndnwE24gHermfvFMFgU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-oFPu7nJQN7qq0dZqjeEzng-1; Mon,
 16 Mar 2026 06:40:46 -0400
X-MC-Unique: oFPu7nJQN7qq0dZqjeEzng-1
X-Mimecast-MFC-AGG-ID: oFPu7nJQN7qq0dZqjeEzng_1773657646
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B71211800365; Mon, 16 Mar 2026 10:40:45 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D991819560AB; Mon, 16 Mar 2026 10:40:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PULL 01/14] target/xtensa/cpu: Move initialization of memory region
 to realize function
Date: Mon, 16 Mar 2026 11:40:26 +0100
Message-ID: <20260316104039.195960-2-thuth@redhat.com>
In-Reply-To: <20260316104039.195960-1-thuth@redhat.com>
References: <20260316104039.195960-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When introspecting the xtensa CPUs from the command line, QEMU currently
crashes:

 $ ./qemu-system-xtensa -device dc233c-xtensa-cpu,help
 qemu-system-xtensa: ../../devel/qemu/system/physmem.c:1401:
  register_multipage: Assertion `num_pages' failed.
 Aborted (core dumped)

Move the initialization of the memory regions to the realize function
to fix this problem.

Reported-by: Markus Armbruster <armbru@redhat.com>
Tested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260311202503.107026-1-thuth@redhat.com>
---
 target/xtensa/cpu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 86ec899a67c..eebf40559bc 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -244,6 +244,14 @@ static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
     Error *local_err = NULL;
 
 #ifndef CONFIG_USER_ONLY
+    CPUXtensaState *env = &XTENSA_CPU(dev)->env;
+
+    env->address_space_er = g_malloc(sizeof(*env->address_space_er));
+    env->system_er = g_malloc(sizeof(*env->system_er));
+    memory_region_init_io(env->system_er, OBJECT(dev), NULL, env, "er",
+                          UINT64_C(0x100000000));
+    address_space_init(env->address_space_er, env->system_er, "ER");
+
     xtensa_irq_init(&XTENSA_CPU(dev)->env);
 #endif
 
@@ -269,12 +277,6 @@ static void xtensa_cpu_initfn(Object *obj)
     env->config = xcc->config;
 
 #ifndef CONFIG_USER_ONLY
-    env->address_space_er = g_malloc(sizeof(*env->address_space_er));
-    env->system_er = g_malloc(sizeof(*env->system_er));
-    memory_region_init_io(env->system_er, obj, NULL, env, "er",
-                          UINT64_C(0x100000000));
-    address_space_init(env->address_space_er, env->system_er, "ER");
-
     cpu->clock = qdev_init_clock_in(DEVICE(obj), "clk-in", NULL, cpu, 0);
     clock_set_hz(cpu->clock, env->config->clock_freq_khz * 1000);
 #endif
-- 
2.53.0


