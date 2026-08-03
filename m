Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3989C5516F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 04:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqk8b-0003Wf-Jo; Mon, 03 Aug 2026 00:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wqk8W-0003Vt-A0; Mon, 03 Aug 2026 00:18:48 -0400
Received: from [115.124.30.131] (helo=out30-131.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wqk8N-0004p9-46; Mon, 03 Aug 2026 00:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785730691; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=pFg0IQ2u8lRhdx+cnZaKJqxxt1uXYe8gytmVsUf7ybY=;
 b=o9oE9tW2/ICC8zzt6O3brTwv0zjJuRIBOEX/ADMf/8bJ0Bfa7JO2uzMzH3GxI7lXxTsWz05sFlU/eCVFc4meTKuW4hvESucOEc6I9fjjFjPfpSbTJCGOSzGm62UDiAW0zwYncng/rON7vtSKd6mGwI4gCmgAd/9OVba+h7qciv0=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0X8ELlyQ_1785730689; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X8ELlyQ_1785730689 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 03 Aug 2026 12:18:10 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH] hw/block/pflash_cfi01: Restore ROMD mode after migration
Date: Mon,  3 Aug 2026 12:18:08 +0800
Message-ID: <20260803041808.58174-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.131 (deferred)
Received-SPF: pass client-ip=115.124.30.131;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-131.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

pflash_post_load() did not restore the ROMD mode of the memory region.
Although cmd and wcycle are migrated, the destination retains the
default ROMD = true from realize.  When the source was in a non-array
mode (e.g. ID read, cmd = 0x90), reads on the destination bypass
pflash_read() via the ROM fast path and return raw storage bytes
instead of the command-specific response.

Derive ROMD from the migrated cmd/wcycle in pflash_post_load.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4042
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 hw/block/pflash_cfi01.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 5b9ddb20b1..a13b91967e 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -1030,6 +1030,16 @@ static int pflash_post_load(void *opaque, int version_id)
 {
     PFlashCFI01 *pfl = opaque;
 
+    /*
+     * ROMD mode is not in the VMState; derive it from the migrated
+     * cmd and wcycle.  Only (wcycle == 0, cmd == 0x00) is read-array.
+     */
+    if (pfl->wcycle == 0 && pfl->cmd == 0x00) {
+        memory_region_rom_device_set_romd(&pfl->mem, true);
+    } else {
+        memory_region_rom_device_set_romd(&pfl->mem, false);
+    }
+
     if (!pfl->ro) {
         pfl->vmstate = qemu_add_vm_change_state_handler(postload_update_cb,
                                                         pfl);
-- 
2.50.1 (Apple Git-155)


