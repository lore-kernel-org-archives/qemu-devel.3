Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EBEE8305A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 07:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnASD-0002IE-6v; Tue, 03 Feb 2026 02:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vnARz-000217-2d; Tue, 03 Feb 2026 02:03:51 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vnARw-0003G9-Kc; Tue, 03 Feb 2026 02:03:50 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EF02160147;
 Tue,  3 Feb 2026 07:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60006C2BC86;
 Tue,  3 Feb 2026 07:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770102218;
 bh=i8kqSXew10HQoZsEqPOWNA6a2DuzT5eQ35FVRfqpxRA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=jZBKi8SYFtHS02tLdaaVs6CbzZBqxtz9VIioHVVYFT+9jSOV5gmP8iHDsp3yWOsyh
 91skd+PqVzGPISH30m1HiZ74IT5dnyVOaj2oR8eihh2HJzF3HBbnDQb19fT95SXh+8
 1D5qvzmB3EIdALCpK/S6/aE+ggJThFSDdcn4t3dtze/k4yuMrQVwBpiKogH2ECsrkY
 HhWx0GdqM5bJR7ZzcUUeK/2fRxCiC4lIrXz5BqAJEiEsXIey1cuK0vn5uTjCkzo7Um
 9DN2oRhLfOa76a39ff93cesGwUaLoJZbxYmaV/5FRsvjF4uAjnkraVxL02vhaIaQso
 sJSpPA/vmPTtA==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 02 Feb 2026 23:01:23 -0800
Subject: [PATCH RFC 7/7] hw/riscv: virt-acpi-build: Build PPTT table before
 RQSC table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-riscv-rqsc-v1-7-dcf448a3ed73@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1025; i=fustini@kernel.org;
 h=from:subject:message-id; bh=i8kqSXew10HQoZsEqPOWNA6a2DuzT5eQ35FVRfqpxRA=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQ2zj2WftTi/tTFT1JV7bZkx9el1qd6XJcVCwp2fHLE7
 JdGx96DHaUsDGJcDLJiiiybPuRdWOIV+nXB/BfbYOawMoEMYeDiFICJbD7JyPBAfKXdgvYbbJ8i
 +f6/2c2wedbPu8d8K751b37VdOnYr523GRneONfXewlaiq7kXyPnLPwt7dqjnasjmhLtZPcr3ug
 03M0BAA==
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

RQSC table will reference cache IDs in PPTT so PPTT must be built
first.

Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 hw/riscv/virt-acpi-build.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index da3c355427af..ce2283d79f67 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -1068,13 +1068,13 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
         spcr_setup(tables_blob, tables->linker, s);
     }
 
-    acpi_add_table(table_offsets, tables_blob);
-    build_rqsc(tables_blob, tables->linker, s);
-
     acpi_add_table(table_offsets, tables_blob);
     pptt_setup(tables_blob, tables->linker, ms,
                s->oem_id, s->oem_table_id);
 
+    acpi_add_table(table_offsets, tables_blob);
+    build_rqsc(tables_blob, tables->linker, s);
+
     acpi_add_table(table_offsets, tables_blob);
     {
         AcpiMcfgInfo mcfg = {

-- 
2.43.0


