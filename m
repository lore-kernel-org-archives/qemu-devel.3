Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA44E8305C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 07:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnASF-0002Nz-3c; Tue, 03 Feb 2026 02:04:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vnARx-00020y-Vx; Tue, 03 Feb 2026 02:03:51 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vnARv-0003E1-Hb; Tue, 03 Feb 2026 02:03:48 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B902160129;
 Tue,  3 Feb 2026 07:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28131C19425;
 Tue,  3 Feb 2026 07:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770102217;
 bh=KJJuiCEAdc4sb40f+3lpJ6ySCUeXhsuEemgr1CBy3E8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=vHcHly2O81GZo5fyhsuQ0BxDHZNMq9vCgRrM3up/I9Et/eYNgY0i1LnPOvXIGhOtQ
 q3Dym6YjVqR6qtFoY4IO2LggrBeKcsXp4QWGEA84QnM5+Tv1LW0u9LH0IuOuFyYFa3
 on3V4HaQuyrSlmszCwsWs8VRnuaxizqMkFknGJYdVvp+gw7dbChhBsOtgF/05YTUVg
 tFB4j+Qzh3uo8qknxg/Zibo33P45epGgsOTI73k2g9gGgEqk6GElkDFSAmnC2mpz7/
 HqCCF5KZBx3/Se9k/eAXwO2KmtwNtCcRDvXnlt6mCcE7TSvZd1AhogbT4ptQCA7IAa
 /pRwntKNKgR1w==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 02 Feb 2026 23:01:20 -0800
Subject: [PATCH RFC 4/7] hw/riscv: virt-acpi-build: Adjust RQSC cache
 properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-riscv-rqsc-v1-4-dcf448a3ed73@kernel.org>
References: <20260202-riscv-rqsc-v1-0-dcf448a3ed73@kernel.org>
In-Reply-To: <20260202-riscv-rqsc-v1-0-dcf448a3ed73@kernel.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
 Sunil V L <sunilvl@ventanamicro.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-arm@nongnu.org, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2270; i=fustini@kernel.org;
 h=from:subject:message-id; bh=KJJuiCEAdc4sb40f+3lpJ6ySCUeXhsuEemgr1CBy3E8=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQ2zj12+oLQAevUShn+ghv/GF5G7jgrrzVJfnsRs6z9F
 p6Hj2xlO0pZGMS4GGTFFFk2fci7sMQr9OuC+S+2wcxhZQIZwsDFKQAT6cxm+F9vmafo13ty3oSb
 ocIlMoUntx74yPGw6lB1b0JBLc8iTk6GPzzzLv5YuJCv3LM3c7lez7EloqlJ2546h34QreOzVJv
 Gzg4A
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=fustini@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In pptt_setup(), set the cache properties to match the example CBQRI
controller configuration.

  Base addr
  0x4820000  Cluster 0 L2 cache controller
  0x4821000  Cluster 1 L2 cache controller
  0X482b000  Shared LLC cache controller

Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 hw/riscv/virt-acpi-build.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 5703b0827682..da3c355427af 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -985,6 +985,7 @@ static void pptt_setup(GArray *table_data, BIOSLinker *linker, MachineState *ms,
             .associativity = 4,
             .sets = 256,
             .attributes = 0x02,
+            .id = 0x1D,
         },
         .l1i_cache = &(CPUCacheInfo) {
             .type = INSTRUCTION_CACHE,
@@ -993,22 +994,34 @@ static void pptt_setup(GArray *table_data, BIOSLinker *linker, MachineState *ms,
             .associativity = 4,
             .sets = 256,
             .attributes = 0x04,
+            .id = 0x1E,
         },
-        .l2_cache = &(CPUCacheInfo) {
+        .l2_cluster1_cache = &(CPUCacheInfo) {
             .type = UNIFIED_CACHE,
-            .size = 2048 * KiB,
+            .size = 750 * KiB,
             .line_size = 64,
-            .associativity = 8,
-            .sets = 4096,
+            .associativity = 12,
+            .sets = 1000,
+            .attributes = 0x0a,
+            .id = 0x4821000,
+        },
+        .l2_cluster2_cache = &(CPUCacheInfo) {
+            .type = UNIFIED_CACHE,
+            .size = 750 * KiB,
+            .line_size = 64,
+            .associativity = 12,
+            .sets = 1000,
             .attributes = 0x0a,
+            .id = 0x4820000,
         },
         .l3_cache = &(CPUCacheInfo) {
             .type = UNIFIED_CACHE,
-            .size = 4096 * KiB,
+            .size = 3 * MiB,
             .line_size = 64,
-            .associativity = 8,
-            .sets = 8192,
+            .associativity = 16,
+            .sets = 4096,
             .attributes = 0x0a,
+            .id = 0x482b000,
         },
     };
 

-- 
2.43.0


