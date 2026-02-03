Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94300E8305C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 07:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnAS7-0002Az-Kj; Tue, 03 Feb 2026 02:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vnARx-00020w-Vs; Tue, 03 Feb 2026 02:03:51 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vnARv-0003E9-Iv; Tue, 03 Feb 2026 02:03:49 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2C06160140;
 Tue,  3 Feb 2026 07:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A413C2BC86;
 Tue,  3 Feb 2026 07:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770102217;
 bh=xd/or6D4+Uo85wHzGmSUtze4r1hjimqUeK6Apn/pJpE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=GGK66X0xdfpnLm+UXbqEmwY7idrbQX5ftRqJAgrjQxeGi/KaBNdKLXvII4/AtOLw8
 6sL/9ORtBdEO3elA3dXvkWqF8+SzY6LVLZFknQh4UzLUdaHMs1rIJdO2PZgYSMHWgF
 Cq+UTVcml4aCd9pTIjjHkxFUm/L1E+2shYsraB3R+CC3gjbZG75XH7Fm7lVRK78pKa
 /t8dOQ0iWILPNtRYYzRsaGpvWEzqWS7Y6pgw68EFCgobCCn3OcOxi+ZQg/t/avP1VK
 GW7GfNMjfa+I7Qq+yJRD6vr3m1VL4JzC/UBgRZcWAgxkW9J+GUm8ioic3qrvsG1/Ga
 tcdFZejUySCnQ==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 02 Feb 2026 23:01:21 -0800
Subject: [PATCH RFC 5/7] include: acpi: aml-build: Add Cache ID and L2
 cache for each cluster
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-riscv-rqsc-v1-5-dcf448a3ed73@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1399; i=fustini@kernel.org;
 h=from:subject:message-id; bh=xd/or6D4+Uo85wHzGmSUtze4r1hjimqUeK6Apn/pJpE=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQ2zj0m8tQgNVGVaZ3ttUX/+F5rnpOTyOCOO/JhtWdqu
 PquqQmCHaUsDGJcDLJiiiybPuRdWOIV+nXB/BfbYOawMoEMYeDiFICJ7GlgZGgpcU8zKbBb8e70
 1o29F0xZbR14w3q4rixxW661Vf/X/UUM/+vZvN4r3d3Bm/pEeoc4w6eLPGVaqg/2hp1fEqGsm/W
 bmRkA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
Received-SPF: pass client-ip=172.105.4.254; envelope-from=fustini@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

ACPI 6.4 added Cache ID to the PPTT Cache Type Structure so add id field
to CPUCacheInfo.

Add an L2 cache for each of the two clusters in CPUCaches.

NOTE: This is hack as it mixes the specifics of the CBQRI example SoC
into the the core ACPI AML code. A proper solution would make use
of the flexible approach in the "Specifying cache topology on ARM" patch
series by Alireza Sanaee.

Link: https://lore.kernel.org/all/20250310162337.844-1-alireza.sanaee@huawei.com/
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 include/hw/acpi/aml-build.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 33b303fc833b..2f7551da2b94 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -243,13 +243,15 @@ struct CPUCacheInfo {
     uint8_t associativity;    /* Cache associativity */
     uint8_t attributes;       /* Cache attributes */
     uint16_t line_size;       /* Line size in bytes */
+    uint32_t id;              /* Cache ID - added in ACPI 6.4 */
 } CPUCacheInfo;
 
 typedef
 struct CPUCaches {
         CPUCacheInfo *l1d_cache;
         CPUCacheInfo *l1i_cache;
-        CPUCacheInfo *l2_cache;
+        CPUCacheInfo *l2_cluster1_cache;
+        CPUCacheInfo *l2_cluster2_cache;
         CPUCacheInfo *l3_cache;
 } CPUCaches;
 

-- 
2.43.0


