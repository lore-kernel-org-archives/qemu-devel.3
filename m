Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E929CCD1AA
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 14:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqvGt-0003AO-Tq; Wed, 18 Sep 2024 10:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.makarov@syntacore.com>)
 id 1sqvGo-0002zy-Cd; Wed, 18 Sep 2024 10:03:02 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.makarov@syntacore.com>)
 id 1sqvGk-0002b7-1z; Wed, 18 Sep 2024 10:03:00 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 26841C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1726668176;
 bh=Y7u+ZYWkETAKlOCWN/jUACcmbj4sINmDqk7xJHoZJoI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=n8vvmFM71BYbFnY4mRI5ctBOMRZSDBNfSjFYiJC8Wsvt0gZKyuuMdVK7jlkjqAt6K
 5QuWa2oQ9UXTBSefKh2C+6kL/GahnnsrjjOgFggPbDPKNltIj+oWZleI8b/lCtJNqF
 WLklvOkIyvt5GhF1HbpbMocrcx7WxDfQgkpqDX3Fi3k0DI3LFTPeatwEvGRrWJ7wFt
 EBqMojRYEZuhzGve0roWurdGA1vvCqLTF1PFJumxW3leznI7Ob9IYt/uz0NQFCcp5O
 LFSlZyY4w03oLGjv1rcmePoUdGdifgFOaKdRc04fnH5o9ZQNbbI+XGqJFqZR95hMR/
 eS09xNcTG3FEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1726668176;
 bh=Y7u+ZYWkETAKlOCWN/jUACcmbj4sINmDqk7xJHoZJoI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=vWjPTy78Vm3sRvLI+RnVsqnPXBYZP6eWK30ZMZRLrcf8pfjl3xh/dsZepSVDO2UUo
 E6zRZe3CkW+tQ2axqNeDi8P+EjMaxmFkey+2SqFY9P/SNkWA8zamWe+bDO7X2ZBwZQ
 ijAfUDe1Pp3LV2h5VFkifj34peyDZVimZYGnZm/KYI/XRoWEgwy0iaXrIAgO8pdYHf
 K69M88DYK9hHZjZfaYz8bwjenzhwFlJO9c5boU2W/300tJWRuK5S/A1r8Df3/192VQ
 vR9ARQX25NUR8ffzT5KLmFRaslF7ut8JAwTNUBnEsJXOMBSs/k60mpxt9XMuMK+/D7
 FYNcbLhQX0EZw==
From: Sergey Makarov <s.makarov@syntacore.com>
To: <Alistar.Francis@wdc.com>
CC: <s.makarov@syntacore.com>, <bmeng.cn@gmail.com>, <palmer@dabbelt.com>,
 <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [PATCH 2/2] hw/intc: Don't clear pending bits on IRQ lowering
Date: Wed, 18 Sep 2024 17:02:29 +0300
Message-ID: <20240918140229.124329-3-s.makarov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240918140229.124329-1-s.makarov@syntacore.com>
References: <20240918140229.124329-1-s.makarov@syntacore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=s.makarov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

According to PLIC specification (chapter 5), there
is only one case, when interrupt is claimed. Fix
PLIC controller to match this behavior.

Signed-off-by: Sergey Makarov <s.makarov@syntacore.com>
---
 hw/intc/sifive_plic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index 3f3ee96ebc..deec162630 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -354,8 +354,10 @@ static void sifive_plic_irq_request(void *opaque, int irq, int level)
 {
     SiFivePLICState *s = opaque;
 
-    sifive_plic_set_pending(s, irq, level > 0);
-    sifive_plic_update(s);
+    if (level > 0) {
+        sifive_plic_set_pending(s, irq, true);
+        sifive_plic_update(s);
+    }
 }
 
 static void sifive_plic_realize(DeviceState *dev, Error **errp)
-- 
2.34.1


