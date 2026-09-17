Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35ADFC982D9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 22:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7KBA-0004ls-A1; Thu, 17 Sep 2026 18:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x7K9M-00044v-8q; Thu, 17 Sep 2026 18:00:20 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x7K9K-0004KY-CC; Thu, 17 Sep 2026 18:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=8nJcvvqd+Hg+FjZrfe3++opvD9OVCxHnuP26Jht2yAY=; b=XlL6nGKmT5qVhVX
 uwtuZ6Xyww0jj0fzwGCKKZIeLSvI+QG5JiaF8JBWqdb9PzPmIGsnt7olJW9t9phdfIDnXk4lBd7PP
 sZMzt2mWswJf5d6sOURlm5hyQq8OaHpO/ef547RARYoOTT5c50YJIvyzlGZHia2aDGcJG2uJIcUO9
 dY=;
Date: Fri, 18 Sep 2026 00:05:02 +0200
Subject: [PATCH v5 08/11] hw/riscv: Tenstorrent Atlantis, use hwaddr/vaddr
 over target_ulong
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-hw-riscv-cpu-int-v5-8-f98c5a244636@rev.ng>
References: <20260918-hw-riscv-cpu-int-v5-0-f98c5a244636@rev.ng>
In-Reply-To: <20260918-hw-riscv-cpu-int-v5-0-f98c5a244636@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789682743; l=999;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=f2Ng0h49pq1ktTNS5/7JFSoKMmoWzjr68AjcVaZ2T7Y=;
 b=zuA5/QTeggrUhb3zuu1HgI3k3GGTk6MGrS08qnPgRFrS6G+zNJop9fznT2xz4N9vALsh4RFye
 +OUNcHH1ragARpbxucjeaoHlqt7WWPfiAUa2+emPwIr4W8cOpm7ZkLZ
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Along with making the compilation rv32/rv64 agnostic, this also
matches the return types of riscv_find_and_load_firmware() and
riscv_calc_kernel_start_addr().

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 hw/riscv/tt_atlantis.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 8a219afef7..b2333e7f6a 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -427,7 +427,8 @@ static void tt_atlantis_machine_done(Notifier *n, void *data)
     MachineState *machine = MACHINE(ams);
     hwaddr start_addr = s->memmap[TT_ATL_DDR_LO].base;
     hwaddr mem_size;
-    target_ulong firmware_end_addr, kernel_start_addr;
+    hwaddr firmware_end_addr;
+    vaddr kernel_start_addr;
     const char *firmware_name = riscv_default_firmware_name(&s->cpus);
     uint64_t fdt_load_addr;
     uint64_t kernel_entry;

-- 
2.52.0


