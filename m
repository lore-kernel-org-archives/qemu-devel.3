Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1648FCCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 06:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8vSW-000819-9z; Wed, 15 Oct 2025 02:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8vSS-000808-Nf
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 02:58:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8vSL-0007DK-3N
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 02:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760511470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YjQzHq3lM73PzZ/FjvCR26tL6gCYBEGkA6dWnLuZJXo=;
 b=iqTv3eqJ10f31hM3DToK+PVMUuI3nBzf3PEDPnC/lcQnehJwAiZUA5U5VVFHmqVnEPTRX8
 CCbU7jwTqy04xX/I2wG5n5z5RTPIc8zaC5Rt0qlnMXKYlGme9VWbEza9VrZeM70Bv/jE6c
 7mO3MBCFTOCkr3NZgBFyrZKuRWa85d4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-WSkqN_eZOlGdSscT1drpxw-1; Wed,
 15 Oct 2025 02:57:46 -0400
X-MC-Unique: WSkqN_eZOlGdSscT1drpxw-1
X-Mimecast-MFC-AGG-ID: WSkqN_eZOlGdSscT1drpxw_1760511465
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36CED19560AE; Wed, 15 Oct 2025 06:57:45 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D54C519560AD; Wed, 15 Oct 2025 06:57:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>,
	qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org
Subject: [PATCH] hw/ppc/e500: Check for compatible CPU type instead of
 aborting ungracefully
Date: Wed, 15 Oct 2025 08:57:42 +0200
Message-ID: <20251015065742.1562288-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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
so let's check for a compatible model before we try to wire some
pins that don't exist.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3162
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/e500.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 723c97fad2e..d40b7a618db 100644
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
@@ -947,6 +948,10 @@ void ppce500_init(MachineState *machine)
                          env->mmu_model);
             exit(1);
         }
+        if (!(POWERPC_CPU_GET_CLASS(cpu)->svr & POWERPC_SVR_E500)) {
+            error_report("This machine needs a CPU from the e500 family");
+            exit(1);
+        }
 
         /*
          * Secondary CPU starts in halted state for now. Needs to change
-- 
2.51.0


