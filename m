Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8089C02198
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 02:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj7jz-0004F1-Iw; Fri, 14 Feb 2025 21:17:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tj7jy-0004Er-6i
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 21:17:10 -0500
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tj7jw-0006dF-Fk
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 21:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739585824; bh=w/8IuRHPVdUTbyl/MhQywFst50Ay9Yr9V+RwhgAhxLY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=B7XDEs0iIAh+SmUnqqVGDBITNEdxdy8Z+23jybGm/dHySe1MnWPWhzil6R31+gOWl
 t6SZ+PJpl0fskAnbDPacD7oyXqrhUrsZh/00HhJM2w1m6BrU/FwfGrJbH0gVv+qEHO
 FtyZEdNOepmp2qGfVdozHdNdn8g/Bt6XS/5mAN2ZMi3/z08EtR0RQVJfcWnvezWF9D
 r+JvgLviJbx9RBtnbMoFp3gLxI04b8DjmaTm1+FkJ8XQgBI+1vMjnJsQ1TFX4QQvk/
 R/MtOk6ZCgRsaS6ncoEDekbUO7duLFl0hNKFuv1Az0ODXDpZ88z8EuZmDRMFLq0of5
 q5o2AYIwguo4w==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 89D1C3F22BE0
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 18:17:04 -0800 (PST)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id mhTFRvRwtR3H; Fri, 14 Feb 2025 18:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739585822; bh=w/8IuRHPVdUTbyl/MhQywFst50Ay9Yr9V+RwhgAhxLY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VkFGz2UuBDy3UBL0VkJFsmMgspTF3ZxLf/XVorY5Z+C6vCQhvKJ/6ziDaOUSx97lJ
 nP1rJwUPnmUeoAgPeFYROP9rhgugztkeqYolNle6k/38ueFj6ZL4r7xbHxzGHQ3WUI
 ZH6APIUf2ib+/b2GnIhKSokMRmVVePAt/SjfBEUs/1Ym9LETXSUYNQDJIpuE0l7SbP
 7Icp6gT65ie4WRs23YCjWG6PR1hNBI3Vc8gyht1WqOXeaHqbgbcc3LTEV7CYaH4CFQ
 cc8EqYyvRgI42mv7zbZQZecnPb6ZOaUrNmVgewlJ/dMx60naMMxa7osWaTmKIuJidc
 koP0hxawri2Pw==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 857D33F2294E;
 Fri, 14 Feb 2025 18:17:02 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1000)
 id 5B5811E6009E; Fri, 14 Feb 2025 18:17:02 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: Keith Packard <keithp@keithp.com>
Subject: [PATCH 3/5] target/rx: Reset the CPU at qemu reset time
Date: Fri, 14 Feb 2025 18:16:52 -0800
Message-ID: <20250215021654.1786679-4-keithp@keithp.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250215021654.1786679-1-keithp@keithp.com>
References: <20250215021654.1786679-1-keithp@keithp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-to:  Keith Packard <keithp@keithp.com>
From:  Keith Packard via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This ensure that the CPU gets reset every time QEMU resets.

Signed-off-by: Keith Packard <keithp@keithp.com>
---
 target/rx/cpu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 37a6fdd569..04dd34b310 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -27,6 +27,7 @@
 #include "hw/loader.h"
 #include "fpu/softfloat.h"
 #include "tcg/debug-assert.h"
+#include "system/reset.h"
 
 static void rx_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -129,6 +130,13 @@ static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
     return oc;
 }
 
+static void rx_cpu_reset(void *opaque)
+{
+    RXCPU *cpu = opaque;
+
+    cpu_reset(CPU(cpu));
+}
+
 static void rx_cpu_realize(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -142,9 +150,10 @@ static void rx_cpu_realize(DeviceState *dev, Error **errp)
     }
 
     qemu_init_vcpu(cs);
-    cpu_reset(cs);
 
     rcc->parent_realize(dev, errp);
+
+    qemu_register_reset(rx_cpu_reset, RX_CPU(cs));
 }
 
 static void rx_cpu_set_irq(void *opaque, int no, int request)
-- 
2.47.2


