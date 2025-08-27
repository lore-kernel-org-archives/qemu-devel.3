Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C50CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHgh-0002f8-Rn; Wed, 27 Aug 2025 11:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHge-0002dS-71; Wed, 27 Aug 2025 11:03:44 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHgc-0004oC-JD; Wed, 27 Aug 2025 11:03:43 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CF55A14C530;
 Wed, 27 Aug 2025 18:02:56 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B97F0269838;
 Wed, 27 Aug 2025 18:03:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 08/59] hw/net/cadence_gem: fix register mask
 initialization
Date: Wed, 27 Aug 2025 18:02:13 +0300
Message-ID: <20250827150323.2694101-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Luc Michel <luc.michel@amd.com>

The gem_init_register_masks function was called at init time but it
relies on the num-priority-queues property. Call it at realize time
instead.

Cc: qemu-stable@nongnu.org
Fixes: 4c70e32f05f ("net: cadence_gem: Define access permission for interrupt registers")
Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Message-ID: <20250716095432.81923-2-luc.michel@amd.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 2bfcd27e00a49da2efa5d703121b94cd9cd4948b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 80fbbacc1e..c36918e504 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1756,6 +1756,7 @@ static void gem_realize(DeviceState *dev, Error **errp)
         sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[i]);
     }
 
+    gem_init_register_masks(s);
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
 
     s->nic = qemu_new_nic(&net_gem_info, &s->conf,
@@ -1776,7 +1777,6 @@ static void gem_init(Object *obj)
 
     DB_PRINT("\n");
 
-    gem_init_register_masks(s);
     memory_region_init_io(&s->iomem, OBJECT(s), &gem_ops, s,
                           "enet", sizeof(s->regs));
 
-- 
2.47.2


