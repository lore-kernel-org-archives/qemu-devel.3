Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BE8CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 11:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8zRE-0005UD-VS; Wed, 15 Oct 2025 07:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8zRD-0005Te-8X
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 07:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8zRA-0000yz-8g
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 07:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760526770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9esceFSpc/HaM6+dNosabj/Fn62KDywYKm5CyIEbmMk=;
 b=jO00Unyr6L2nbgGCUIAtX82XyV8pS53Rus9War0NzthdgZfK8g3IK7aZcVNJRvlM5zT43N
 SougiAte2UIOYZpI6GUxVnhA7WcCzlA8VSYw1NTeOHDE3aB0m5BNslE/ppuVRRY04JLL4u
 5eQl2DXiIC4yZ3tuSH57leP+r8yAFn4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-SEE3yKYWMcOpPBC5VKlYlg-1; Wed,
 15 Oct 2025 07:12:48 -0400
X-MC-Unique: SEE3yKYWMcOpPBC5VKlYlg-1
X-Mimecast-MFC-AGG-ID: SEE3yKYWMcOpPBC5VKlYlg_1760526767
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E512195609F; Wed, 15 Oct 2025 11:12:47 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.24])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2EB5E1800451; Wed, 15 Oct 2025 11:12:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>,
	qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2] hw/ppc/e500: Check for compatible CPU type instead of
 aborting ungracefully
Date: Wed, 15 Oct 2025 13:12:43 +0200
Message-ID: <20251015111243.1585018-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

When using the ppce500 machine with an embedded CPU type that has
the right MMU model, but is not part of the e500 CPU family, QEMU
currently aborts ungracefully:

 $ ./qemu-system-ppc -machine ppce500 -cpu e200z5 -nographic
 qemu-system-ppc: ../qemu/hw/core/gpio.c:108: qdev_get_gpio_in_named:
  Assertion `n >= 0 && n < gpio_list->num_in' failed.
 Aborted (core dumped)

The ppce500 machine expects a CPU with certain GPIO interrupt pins,
so let's replace the coarse check for the MMU_BOOKE206 model with
a more precise check that only allows CPUs from the e500 family.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3162
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Drop the old check for the MMU_BOOKE206 model

 hw/ppc/e500.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 723c97fad2e..3d69428f31c 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -20,6 +20,7 @@
 #include "qemu/guest-random.h"
 #include "exec/target_page.h"
 #include "qapi/error.h"
+#include "cpu-models.h"
 #include "e500.h"
 #include "e500-ccsr.h"
 #include "net/net.h"
@@ -942,9 +943,8 @@ void ppce500_init(MachineState *machine)
         env = &cpu->env;
         cs = CPU(cpu);
 
-        if (env->mmu_model != POWERPC_MMU_BOOKE206) {
-            error_report("MMU model %i not supported by this machine",
-                         env->mmu_model);
+        if (!(POWERPC_CPU_GET_CLASS(cpu)->svr & POWERPC_SVR_E500)) {
+            error_report("This machine needs a CPU from the e500 family");
             exit(1);
         }
 
-- 
2.51.0


