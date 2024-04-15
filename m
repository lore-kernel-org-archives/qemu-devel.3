Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BC9C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 06:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwGHF-0004AB-OA; Mon, 15 Apr 2024 02:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rwGHD-00049A-Gt
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 02:57:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rwGHC-0005N0-0j
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 02:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713164233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Lz2JnI4BuEf2+/HhO8OCBk+1ARmeP7ymGcjdIAyv8g=;
 b=ieppptiL62/5aPJzBLO5iMrUsExW4xBA4/4Xj51lvxePuM1x6PpxtxLBGjvXWmJJ4YicqK
 C8+dUHeuOk5Cyezw7aMgWcovFQtp8hQC4qeY1xFa7KAn4kKz8nuCkDOt5+CwzCABPmy90k
 gVcj0D9IROfvuB4n+xpXooTYnIoDJjM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-n5-qj7j4O8eV64APjybssQ-1; Mon,
 15 Apr 2024 02:57:08 -0400
X-MC-Unique: n5-qj7j4O8eV64APjybssQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98BE91C02D26;
 Mon, 15 Apr 2024 06:57:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7FE4FC13FA1;
 Mon, 15 Apr 2024 06:57:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 1/2] hw: Fix problem with the A*MPCORE switches in the
 Kconfig files
Date: Mon, 15 Apr 2024 08:56:54 +0200
Message-ID: <20240415065655.130099-2-thuth@redhat.com>
In-Reply-To: <20240415065655.130099-1-thuth@redhat.com>
References: <20240415065655.130099-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.127,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

A9MPCORE, ARM11MPCORE and A15MPCORE are defined twice, once in
hw/cpu/Kconfig and once in hw/arm/Kconfig. This is only possible
by accident, since hw/cpu/Kconfig is never included from hw/Kconfig.
Fix it by declaring the switches only in hw/cpu/Kconfig (since the
related files reside in the hw/cpu/ folder) and by making sure that
the file hw/cpu/Kconfig is now properly included from hw/Kconfig.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/Kconfig     |  1 +
 hw/arm/Kconfig | 15 ---------------
 hw/cpu/Kconfig | 12 +++++++++---
 3 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/hw/Kconfig b/hw/Kconfig
index 2c00936c28..9567cc475d 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -48,6 +48,7 @@ source watchdog/Kconfig
 
 # arch Kconfig
 source arm/Kconfig
+source cpu/Kconfig
 source alpha/Kconfig
 source avr/Kconfig
 source cris/Kconfig
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 893a7bff66..d97015c45c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -678,21 +678,6 @@ config ZAURUS
     select NAND
     select ECC
 
-config A9MPCORE
-    bool
-    select A9_GTIMER
-    select A9SCU       # snoop control unit
-    select ARM_GIC
-    select ARM_MPTIMER
-
-config A15MPCORE
-    bool
-    select ARM_GIC
-
-config ARM11MPCORE
-    bool
-    select ARM11SCU
-
 config ARMSSE
     bool
     select ARM_V7M
diff --git a/hw/cpu/Kconfig b/hw/cpu/Kconfig
index 1767d028ac..f776e884cd 100644
--- a/hw/cpu/Kconfig
+++ b/hw/cpu/Kconfig
@@ -1,8 +1,14 @@
-config ARM11MPCORE
-    bool
-
 config A9MPCORE
     bool
+    select A9_GTIMER
+    select A9SCU       # snoop control unit
+    select ARM_GIC
+    select ARM_MPTIMER
 
 config A15MPCORE
     bool
+    select ARM_GIC
+
+config ARM11MPCORE
+    bool
+    select ARM11SCU
-- 
2.44.0


