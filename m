Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6559FCC6B1D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 01:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Tam-0004qh-W8; Thu, 02 Apr 2026 21:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1w8Tak-0004pt-3y; Thu, 02 Apr 2026 21:44:58 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1w8Tah-0000l5-PN; Thu, 02 Apr 2026 21:44:57 -0400
X-UUID: b054e4aa2efe11f1aa26b74ffac11d73-20260403
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:90d5a4cf-d200-4673-a9d7-902d7365fe68, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:-25
X-CID-META: VersionHash:e7bac3a, CLOUDID:e500c946175ebbebd7f7dd8ab3bad864,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|123|850|898,TC:nil,Content:0|1
 5|50,EDM:1|19,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
 SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b054e4aa2efe11f1aa26b74ffac11d73-20260403
X-User: zhaoguohan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1403329136; Fri, 03 Apr 2026 09:44:44 +0800
From: zhaoguohan@kylinos.cn
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,
	GuoHan Zhao <zhaoguohan@kylinos.cn>
Subject: [PATCH v2] hw/arm/omap_sx1: map CS3 at the correct base
Date: Fri,  3 Apr 2026 09:44:41 +0800
Message-ID: <20260403014441.38725-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402071718.130490-1-zhaoguohan@kylinos.cn>
References: <20260402071718.130490-1-zhaoguohan@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=zhaoguohan@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

omap_sx1 wires the "sx1.cs3" region to OMAP_CS2_BASE instead of
OMAP_CS3_BASE.

That places both CS2 and CS3 at the same address and leaves the real
CS3 window unmapped. Point the CS3 region at OMAP_CS3_BASE so the
static chip-select layout matches the OMAP address definitions.

Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
v1 -> v2:
- Resend to qemu-devel@nongnu.org
- Keep qemu-arm@nongnu.org on Cc as requested by Peter Maydell

 hw/arm/omap_sx1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index d858dab32534..bcb7105323fd 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -146,7 +146,7 @@ static void sx1_init(MachineState *machine, const int version)
     memory_region_init_io(&cs[3], NULL, &static_ops, &cs3val,
                           "sx1.cs3", OMAP_CS3_SIZE);
     memory_region_add_subregion(address_space,
-                                OMAP_CS2_BASE, &cs[3]);
+                                OMAP_CS3_BASE, &cs[3]);
 
     fl_idx = 0;
     if ((dinfo = drive_get(IF_PFLASH, 0, fl_idx)) != NULL) {
-- 
2.43.0


