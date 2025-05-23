Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCE4C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 15:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uITud-0006UH-Qd; Fri, 23 May 2025 11:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uITub-0006T7-Uz; Fri, 23 May 2025 11:02:17 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uITua-0003B9-4L; Fri, 23 May 2025 11:02:17 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 30ED455C592;
 Fri, 23 May 2025 17:02:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id bL1q8p_aEYCE; Fri, 23 May 2025 17:02:12 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2F98C55C16F; Fri, 23 May 2025 17:02:12 +0200 (CEST)
Message-ID: <8bd7ca691bd502b5fd761615d9af805e783fba36.1748012109.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1748012109.git.balaton@eik.bme.hu>
References: <cover.1748012109.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 2/3] hw/net/fsl_etsec: Set default MAC address
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Date: Fri, 23 May 2025 17:02:12 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use default MAC address if none is specified by property as done by
most other network interface models.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/net/fsl_etsec/etsec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index d14cb2a101..846f6cbc5d 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -389,6 +389,7 @@ static void etsec_realize(DeviceState *dev, Error **errp)
 {
     eTSEC        *etsec = ETSEC_COMMON(dev);
 
+    qemu_macaddr_default_if_unset(&etsec->conf.macaddr);
     etsec->nic = qemu_new_nic(&net_etsec_info, &etsec->conf,
                               object_get_typename(OBJECT(dev)), dev->id,
                               &dev->mem_reentrancy_guard, etsec);
-- 
2.41.3


