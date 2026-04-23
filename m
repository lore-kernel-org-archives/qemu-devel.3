Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC120F99344
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 09:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqhR-0000Ou-2G; Thu, 23 Apr 2026 05:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wFqgS-00087W-4J
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 05:49:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wFqgP-0001MQ-JI
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 05:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776937756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q7sYoGhYV6uhzjU7T/8b4Om54JypajawmdrA3+XZMbM=;
 b=RruirU0rexYDMoPRMbMSP5rdLfhPw6IvT+ZXax8XVLzpvr/xqiBA+JDT8/2lOKficJfmdp
 CHoMofylrQK4V1s5i40r3lZXLnuZRalN2pai7TNiS0MFExu3S1Moe64YCCtYVRXWtJbiPq
 u/1Xv9AM8UFD1RciEu2X16xchu7YWco=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-3srYlCaCPE-cDAzObdSuQg-1; Thu,
 23 Apr 2026 05:49:13 -0400
X-MC-Unique: 3srYlCaCPE-cDAzObdSuQg-1
X-Mimecast-MFC-AGG-ID: 3srYlCaCPE-cDAzObdSuQg_1776937752
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68CEF19560B8; Thu, 23 Apr 2026 09:49:12 +0000 (UTC)
Received: from gondolin.str.redhat.com (dhcp-192-224.str.redhat.com
 [10.33.192.224])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 018DE300756E; Thu, 23 Apr 2026 09:49:10 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 05/11] target/s390x: Replace legacy ld/st_phys ->
 address_space_ld/st (kvm)
Date: Thu, 23 Apr 2026 11:48:50 +0200
Message-ID: <20260423094856.270215-6-cohuck@redhat.com>
In-Reply-To: <20260423094856.270215-1-cohuck@redhat.com>
References: <20260423094856.270215-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Prefer the address_space_ld/st API over the legacy ld_phys()
because it allow checking for bus access fault.
This code however doesn't check for fault, so we simply inline
the calls (not specifying any memory transaction attribute nor
expecting transation result). No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <20260319185203.11799-5-philmd@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm/kvm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 133e8c12fd4d..2e4f435c5371 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -36,6 +36,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/mmap-alloc.h"
 #include "qemu/log.h"
+#include "system/memory.h"
 #include "system/system.h"
 #include "system/hw_accel.h"
 #include "system/runstate.h"
@@ -1634,13 +1635,16 @@ static void unmanageable_intercept(S390CPU *cpu, S390CrashReason reason,
 /* try to detect pgm check loops */
 static int handle_oper_loop(S390CPU *cpu, struct kvm_run *run)
 {
+    const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     CPUState *cs = CPU(cpu);
     PSW oldpsw, newpsw;
 
-    newpsw.mask = ldq_be_phys(cs->as, cpu->env.psa +
-                              offsetof(LowCore, program_new_psw));
-    newpsw.addr = ldq_be_phys(cs->as, cpu->env.psa +
-                              offsetof(LowCore, program_new_psw) + 8);
+    newpsw.mask = address_space_ldq_be(cs->as, cpu->env.psa +
+                                       offsetof(LowCore, program_new_psw),
+                                       attrs, NULL);
+    newpsw.addr = address_space_ldq_be(cs->as, cpu->env.psa +
+                                       offsetof(LowCore, program_new_psw) + 8,
+                                       attrs, NULL);
     oldpsw.mask  = run->psw_mask;
     oldpsw.addr  = run->psw_addr;
     /*
-- 
2.53.0


