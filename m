Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A89CDB470
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFn3-0004rT-Rm; Wed, 24 Jun 2026 01:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFmv-0004lS-2U; Wed, 24 Jun 2026 01:04:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFms-0005GU-Tk; Wed, 24 Jun 2026 01:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782277464; bh=LDuTVytEB5yPW9EHHai0ZUStwAKUWdEBdDZsmYwEGww=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fD3bozArNYyoIVLUxmgT/vBk5swdRFlqHSCUiqRNqLTJxYLndcB/zqDW9u2xcCcMQ
 2h17EVJX5/SE1Zj22jDnPm8Xdhzkf7hk2TNNj/+PoZJqOkckRn/7/q3UP4Iwhow+ZF
 qt3JfLxFjcDlf3JtrLdAdwzXSoaQOmNBp37b7Ukmp6XaldCkrfxJr1fdTw9xvfppHo
 ciDJASvsfpuRn2iREns46AefqXKCH38oAnv+/ygZYzhuZO0DTj+IrKoJW5HoGZ3CHW
 dEuAh69lc/RkMxe58kXyUzgpiFYC0mzS/ZbpPWPsNl10R72qAncvaYT2ih46+XkL8O
 0AhDWoQFs1reQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 627531BA62F;
 Wed, 24 Jun 2026 08:04:24 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 494B93DDABA;
 Wed, 24 Jun 2026 08:04:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Sairaj Kodilkar <sarunkod@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 60/86] amd_iommu: Update command buffer head ptr in
 MMIO region after wraparound
Date: Wed, 24 Jun 2026 08:02:31 +0300
Message-ID: <20260624050404.394225-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260624080222@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260624080222@cover.tls.msk.ru>
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

When processing a command, amdvi_cmdbuf_run() increments cmdbuf_head and
writes it to the emulated MMIO register space before checking whether it
has reached the end of the command buffer.

If the incremented value reaches the end of the buffer and the tail pointer
is zero, the loop exits and the COMMAND_HEAD offset still contains an
unwrapped value. There are no errors in command processing since internal
cmdbuf_head state is always correctly updated, but the spec defines the
CmdHeadPtr field in MMIO Offset 2000h Command Buffer Head Pointer Register
as RW i.e. guest-visible, so it should be kept consistent.

Wrap cmdbuf_head before updating COMMAND_HEAD so the MMIO-visible register
always matches the internal command buffer head pointer position.

Cc: qemu-stable@nongnu.org
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260512150044.334867-1-alejandro.j.jimenez@oracle.com>
(cherry picked from commit 3c98e446af825b5806c1e5cd1244b2431b15e884)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 4405ce8988..8efebd3eea 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -583,12 +583,12 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
         trace_amdvi_command_exec(s->cmdbuf_head, s->cmdbuf_tail, s->cmdbuf);
         amdvi_cmdbuf_exec(s);
         s->cmdbuf_head += AMDVI_COMMAND_SIZE;
-        amdvi_writeq_raw(s, AMDVI_MMIO_COMMAND_HEAD, s->cmdbuf_head);
 
         /* wrap head pointer */
         if (s->cmdbuf_head >= s->cmdbuf_len * AMDVI_COMMAND_SIZE) {
             s->cmdbuf_head = 0;
         }
+        amdvi_writeq_raw(s, AMDVI_MMIO_COMMAND_HEAD, s->cmdbuf_head);
     }
 }
 
-- 
2.47.3


