Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872F5CCF9F8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 06:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vF4rg-0003Ca-Qy; Sat, 01 Nov 2025 02:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan_salmon@163.com>)
 id 1vF4rd-0003BV-LB
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 02:13:25 -0400
Received: from m16.mail.163.com ([117.135.210.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan_salmon@163.com>)
 id 1vF4rZ-0003RY-Cw
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 02:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=sa
 Svj6nt7PKtRosPykcIBsIUkB+nR5xmsC/VlYHndro=; b=ADczqJHdyEC+193XFj
 EnX46+E4EpOR0GsHhHU7IR+JCAyC+IqXzpCw+0I4k7/4VpGHwdbow2aQQ7kQlnpS
 OxkZgrYOpUm+0pPeXQOz1cDIvtZNI9kT+Da3bDXJxfIl+5wxcpDeilGB1Q3zjOIG
 CMGyfzxLWfH1dDO0SzEzTGrSY=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id
 _____wCn6ku_pAVpx3ZYAw--.7817S2; 
 Sat, 01 Nov 2025 14:12:17 +0800 (CST)
From: zhaoguohan_salmon@163.com
To: richard.henderson@linaro.org,
	deller@gmx.de
Cc: pbonzini@redhat.com, fam@euphon.net,
 qemu-devel@nongnu.org (open list:All patches CC here),
 GuoHan Zhao <zhaoguohan@kylinos.cn>,
 Soumyajyotii Datta <soumyajyotii.datta@broadcom.com>
Subject: [PATCH v2] hw/scsi/ncr710: Fix null pointer dereference in
 `ncr710_transfer_data`
Date: Sat,  1 Nov 2025 14:12:13 +0800
Message-ID: <20251101061213.164644-1-zhaoguohan_salmon@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCn6ku_pAVpx3ZYAw--.7817S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trWUCrWxArWUWrWDKrWruFg_yoW8WF48pr
 Z2gF1UK3yYgF1jyay8Jr48XF1Yka9Iyw4Yya10gasxArZ7KF17XFWftay0gasrurZ3J3W7
 Xr1q9ayjqFy7JaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jf3kAUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 52kd0wpxrkt0xbvdzzlrq6il2tof0z/xtbBgBj4EGkFnXyDkwAAst
Received-SPF: pass client-ip=117.135.210.3;
 envelope-from=zhaoguohan_salmon@163.com; helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

Fix a null pointer dereference issue in ncr710_transfer_data().

The code dereferences s->current->dma_len before checking if s->current
is NULL. Only the dma_len assignment needs null protection, while
s->command_complete should be set unconditionally to maintain proper
boot sequence.

Initialize s->current from req->hba_private if it is NULL before
accessing dma_len.

Fixes: 9ce93b74cdc0 ("ncr710: Add driver for the NCR 53c710 SCSI chip")
Suggested-by: Soumyajyotii Datta <soumyajyotii.datta@broadcom.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
Changes in v2:
- Only protect dma_len assignment instead of moving all code
- Keep s->command_complete set unconditionally
- Initialize s->current from req->hba_private when NULL
- Thanks to Soumyajyotii for testing and suggesting the fix
---
 hw/scsi/ncr53c710.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index e479a212bc54..01b0ca21ec51 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -831,13 +831,13 @@ void ncr710_transfer_data(SCSIRequest *req, uint32_t len)
         }
     }
 
+    /* Host adapter (re)connected */
+    s->command_complete = NCR710_CMD_DATA_READY;
+
     if (!s->current) {
-        return;
+        s->current = (NCR710Request *)req->hba_private;
     }
-
-    /* Host adapter (re)connected */
     s->current->dma_len = len;
-    s->command_complete = NCR710_CMD_DATA_READY;
 
     if (s->waiting) {
         s->scntl1 |= NCR710_SCNTL1_CON;
-- 
2.43.0


