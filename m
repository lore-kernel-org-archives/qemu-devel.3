Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C79C5CFEE
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8d4-00052a-8X; Wed, 12 Aug 2026 09:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8co-000468-Fa; Wed, 12 Aug 2026 09:04:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8cm-0004NI-PB; Wed, 12 Aug 2026 09:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=Ahl70wrhjes1tB61twhbgD9TPZiO1nVGUaPZq4evW+g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=e93jq+Ve8ni6E3dI0nf+wpPPnxOrZwPowQZppXYCsMoSltrWRxk+mYF74eFRQAbWp
 Ej0nKOTA22SvW9hSavrm6ioRgzge+DnBbXYJUXCMGbKDOPylV1wMqpn30nSi/gCLcm
 dx0wYJzNxDAjEbLujVZ1cWrOigVfJC1YmZyVzMmCTBgORRQmEJVC+gk2AqjYeIltXj
 6wNzDtSisBM+wUVCl/+YdPcaVj28DnD+/XuexkKHrPxCKCaRDoej4LSzlFtRdLtcy8
 3nn2ONKOeehqiyLGuUEMbpv46VKAKWAWbZs0WnKV5TVg8CRGYXBUk/jVWqdMzo7LiM
 91ifqTIwVcTog==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 447011CA48D;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7A83F409B70;
 Wed, 12 Aug 2026 16:03:14 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E4D392F8B0; Wed, 12 Aug 2026 16:02:49 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Artem Nasonov <anasonov@astralinux.ru>,
 Fiona Ebner <f.ebner@proxmox.com>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 014/102] hw/ide: replace assert with proper error
 handling
Date: Wed, 12 Aug 2026 16:00:49 +0300
Message-ID: <20260812130233.621965-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Artem Nasonov <anasonov@astralinux.ru>

In ide_dma_cb(), the call to prepare_buf() might return a negative
result and cause an assertion failure. This was found during fuzzing
and can be triggered with some qtest commands. Replace the assert with
proper error handling in case the result is negative, but keep the
assert for failing to respect the limit upon success. If that happens,
it is an implementation error.

Found by Linux Verification Center (linuxtesting.org) with libFuzzer.

Cc: qemu-stable@nongnu.org
Fixes: ed78352a59 ("ide: Fix incorrect handling of some PRDTs in ide_dma_cb()")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2777
Signed-off-by: Artem Nasonov <anasonov@astralinux.ru>
Link: https://lore.kernel.org/qemu-devel/20250116111600.2570490-1-anasonov@astralinux.ru
[FE: improve commit message
     keep assert for failing to respect the limit]
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit 443e02410695b35a27fad18217424b6370358be7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ide/core.c b/hw/ide/core.c
index bf616b77033..4b6066c3eca 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -921,8 +921,12 @@ static void ide_dma_cb(void *opaque, int ret)
     s->io_buffer_index = 0;
     s->io_buffer_size = n * 512;
     prep_size = s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_size);
-    /* prepare_buf() must succeed and respect the limit */
-    assert(prep_size >= 0 && prep_size <= n * 512);
+    if (prep_size < 0) {
+        ide_dma_error(s);
+        return;
+    }
+    /* If prepare_buf() succeeds, it must respect the limit. */
+    assert(prep_size <= n * 512);
 
     /*
      * Now prep_size stores the number of bytes in the sglist, and
-- 
2.47.3


