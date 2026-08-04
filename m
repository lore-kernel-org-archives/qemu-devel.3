Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B644C55822
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 06:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr8UI-0006Ou-TL; Tue, 04 Aug 2026 02:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wr8UF-0006Nq-1W; Tue, 04 Aug 2026 02:18:52 -0400
Received: from [115.124.30.101] (helo=out30-101.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wr8U6-0003Ds-Ge; Tue, 04 Aug 2026 02:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785824288; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=maVIwWUplBrDFGg9ssiWNz1AoCInfkOYmHZDZeSB0xI=;
 b=PR8CutBPWnZ+ILlKzIKpAv5zrXTnlJYaDLEwcezTGRTrYMTlTVO9M2zl9KS0lYkVp69gVje8M0G9d6bvBQnxEa6CVLkjOHl6XgFbBaON5OCh2saVzOcgW36Kkv57R9MDxcT6gZSKfs3b47UGNXsSvwohFFDFK6YcknuVheidDrw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0X8MuO96_1785824285; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X8MuO96_1785824285 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 04 Aug 2026 14:18:06 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH] hw/scsi/megasas: Abort in-flight commands before resetting
 frames
Date: Tue,  4 Aug 2026 14:18:05 +0800
Message-ID: <20260804061805.39492-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.101 (deferred)
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
X-Spam_score_int: -88
X-Spam_score: -8.9
X-Spam_bar: --------
X-Spam_report: (-8.9 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
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

megasas_init_firmware() called megasas_reset_frames() without first
aborting in-flight SCSI requests.  This destroyed their scatter-gather
lists (setting the AddressSpace pointer to NULL) while the requests were
still active.  A subsequent MFI_IDB abort would then dereference the NULL
AddressSpace in dma_aio_cancel().

Abort all commands before resetting frames, mirroring what
megasas_soft_reset() already does.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4092
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 hw/scsi/megasas.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 9e712721f8..e9758ddb90 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -641,6 +641,7 @@ static int megasas_init_firmware(MegasasState *s, MegasasCmd *cmd)
     struct mfi_init_qinfo *initq = NULL;
     uint32_t flags;
     int ret = MFI_STAT_OK;
+    int i;
 
     if (s->reply_queue_pa) {
         trace_megasas_initq_mapped(s->reply_queue_pa);
@@ -684,6 +685,9 @@ static int megasas_init_firmware(MegasasState *s, MegasasCmd *cmd)
     trace_megasas_init_queue((unsigned long)s->reply_queue_pa,
                              s->reply_queue_len, s->reply_queue_head,
                              s->reply_queue_tail, flags);
+    for (i = 0; i < s->fw_cmds; i++) {
+        megasas_abort_command(&s->frames[i]);
+    }
     megasas_reset_frames(s);
     s->fw_state = MFI_FWSTATE_OPERATIONAL;
 out:
-- 
2.50.1 (Apple Git-155)


