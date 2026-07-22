Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266A8C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWPF-0005e1-M3; Wed, 22 Jul 2026 08:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWMf-00033q-BB; Wed, 22 Jul 2026 08:48:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWMd-0001nh-Ao; Wed, 22 Jul 2026 08:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724390; bh=pGsbwCdEHxp7N+hE8YfqznDvenYBypwDapm1jIUOk78=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZkvP9PLExqbjMEHM3dmW+yi2yBXCh3tBiMGWyiRwlRWHTp8XMYwFainUiPz3JtjtB
 24kALGNvHryZuHjCxJKJnlIMEqXJlE/Jv5iE+tbF5DBFa3PF9k1ktLwQIJSwvEnCxD
 ZCrF4RlOAVoefH519v/Sa2xEG611Voi5+/jbk8I+O6XIvcIiiraDI44mTfyE92dOKi
 G9pKxTMwqCHb73mP4Yktt5XlkbNOXnjKTmLYXrpFapIXdjT2qGTNF8uyHNZc4AOgqL
 4DswQ1Nf6DHeJeeN40GHYmdEFKUE9Ah5UKd0cTHVyblv6jfkfeSLIRZj7/UhwIGIhj
 7pUxamgxu8s0w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7E5741C3B04;
 Wed, 22 Jul 2026 15:46:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C63A33F375E;
 Wed, 22 Jul 2026 15:46:47 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 5B53017EF1; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Haotian Jiang <sundayjiang@tencent.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 091/122] hw/misc/ivshmem: clear chardev handlers
 before freeing peers
Date: Wed, 22 Jul 2026 15:45:40 +0300
Message-ID: <20260722124622.31034-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Haotian Jiang <sundayjiang@tencent.com>

ivshmem_exit() frees s->peers and s->msi_vectors but does not clear
the chardev handlers registered in ivshmem_common_realize(). Those
handlers are only removed later in object_finalize() via release_chr,
which runs after ivshmem_exit().

Between exit and finalize, ivshmem_read() can fire on pending chardev
data and process_msg_connect() dereferences the freed s->peers.
Additionally, s->peers, s->nb_peers, and s->msi_vectors are not
zeroed after free, leaving dangling pointers that make the UAF code
paths reachable.

Fix by clearing chardev handlers at the beginning of ivshmem_exit(),
before any resources they access are freed, and nullifying freed
pointers.

Cc: qemu-stable@nongnu.org
Fixes: f64a078d45a ("ivshmem: fix pci_ivshmem_exit()")
Link: https://gitlab.com/qemu-project/qemu/-/work_items/3594
Reported-by: Haotian Jiang <sundayjiang@tencent.com>
Signed-off-by: Haotian Jiang <sundayjiang@tencent.com>
Message-ID: <tencent_3105EC28797360A155078F53@qq.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 5157ceb10ca83d1c257ff84368458153a10a2f23)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index 900d523334c..3f7ad4b633c 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -920,6 +920,9 @@ static void ivshmem_exit(PCIDevice *dev)
     IVShmemState *s = IVSHMEM_COMMON(dev);
     int i;
 
+    qemu_chr_fe_set_handlers(&s->server_chr,
+                             NULL, NULL, NULL, NULL, NULL, NULL, true);
+
     migrate_del_blocker(&s->migration_blocker);
 
     if (memory_region_is_mapped(s->ivshmem_bar2)) {
@@ -948,6 +951,8 @@ static void ivshmem_exit(PCIDevice *dev)
             close_peer_eventfds(s, i);
         }
         g_free(s->peers);
+        s->peers = NULL;
+        s->nb_peers = 0;
     }
 
     if (ivshmem_has_feature(s, IVSHMEM_MSI)) {
@@ -955,6 +960,7 @@ static void ivshmem_exit(PCIDevice *dev)
     }
 
     g_free(s->msi_vectors);
+    s->msi_vectors = NULL;
 }
 
 static int ivshmem_pre_load(void *opaque)
-- 
2.47.3


