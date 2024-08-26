Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FC3C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 14:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siaXo-00026B-Ap; Mon, 26 Aug 2024 10:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1siaXl-000253-V0
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 10:18:06 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1siaXX-0002IO-K8
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 10:18:05 -0400
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1724681863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qxZun1D97KmfaFsb1w88H/aNJWFFa2IHFmfze+9EwuU=;
 b=o9sxlOX7SgzTYXAnJgpEbkUCJHnaf2wqbDNGv3BeZKflxD1zOtvg3euL8NxBzn+GltKWKO
 L9cyOJ3hFyaQ/9jp5hKiKMzKMDeDdcjMiHodMwNFY8+hmoFzj1+xDwn2larGKIunTPkMNV
 JOKczqj+KdqUSiYNxRCNN3ByxDa8q8w=
To: rad@semihalf.com,
	peter.maydell@linaro.org
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org,
 Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH] hw/arm: fix memleak in sbsa-ref.c
Date: Mon, 26 Aug 2024 17:16:21 +0300
Message-ID: <20240826141655.152179-2-frolov@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Memory, allocated by the first call of g_strdup_printf() is lost at
the second call.

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
---
 hw/arm/sbsa-ref.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index ae37a92301..10984fc339 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -164,23 +164,17 @@ static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
 
 static void sbsa_fdt_add_gic_node(SBSAMachineState *sms)
 {
-    char *nodename;
-
-    nodename = g_strdup_printf("/intc");
-    qemu_fdt_add_subnode(sms->fdt, nodename);
-    qemu_fdt_setprop_sized_cells(sms->fdt, nodename, "reg",
+    qemu_fdt_add_subnode(sms->fdt, "/intc");
+    qemu_fdt_setprop_sized_cells(sms->fdt, "/intc", "reg",
                                  2, sbsa_ref_memmap[SBSA_GIC_DIST].base,
                                  2, sbsa_ref_memmap[SBSA_GIC_DIST].size,
                                  2, sbsa_ref_memmap[SBSA_GIC_REDIST].base,
                                  2, sbsa_ref_memmap[SBSA_GIC_REDIST].size);
 
-    nodename = g_strdup_printf("/intc/its");
-    qemu_fdt_add_subnode(sms->fdt, nodename);
-    qemu_fdt_setprop_sized_cells(sms->fdt, nodename, "reg",
+    qemu_fdt_add_subnode(sms->fdt, "/intc/its");
+    qemu_fdt_setprop_sized_cells(sms->fdt, "/intc/its", "reg",
                                  2, sbsa_ref_memmap[SBSA_GIC_ITS].base,
                                  2, sbsa_ref_memmap[SBSA_GIC_ITS].size);
-
-    g_free(nodename);
 }
 
 /*
-- 
2.43.0


