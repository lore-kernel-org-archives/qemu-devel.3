Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628E8C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 11:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weskb-0004j3-2B; Wed, 01 Jul 2026 07:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1weskZ-0004iH-99
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 07:05:03 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1weskX-0005WD-1K
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 07:05:03 -0400
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1782903895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BDEB7d4RS2J/OdI+LujNzf+f37NhDwFNn9l3zwEvxlQ=;
 b=QNkqg0LCQTpSosE57cPwbY5YVCdIMIlqBwJ+mpcuTzcTAoiI9/iqNmtB4IYeT15nMyYWQC
 4NlQKosVvJ4uCDQDfipK9vpuxZKmIAtfxslZYI3vq0UGhSsh0JH5MATvWTlRsyPhCN53G6
 2NdfM6ft+oIOstZwdtVJqb1kCC0PfEo=
To: pbonzini@redhat.com
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org,
 Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH] hw/scsi/megasas: fix-heap-buffer-overflow
Date: Wed,  1 Jul 2026 14:03:54 +0300
Message-Id: <20260701110353.1426847-1-frolov@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The type of cmd->frame is mfi_frame. So it should be able to
hold the whole mfi_io_frame, including union mfi_sgl sgl.
But only frame_size bytes are allocated, which is enough to
store union mfi_sgl sgl only.

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
---
 hw/scsi/megasas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 9e712721f8..0ddd11ccda 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -488,7 +488,7 @@ static MegasasCmd *megasas_enqueue_frame(MegasasState *s,
 {
     PCIDevice *pcid = PCI_DEVICE(s);
     MegasasCmd *cmd = NULL;
-    int frame_size = MEGASAS_MAX_SGE * sizeof(union mfi_sgl);
+    int frame_size = MEGASAS_MAX_SGE * sizeof(union mfi_sgl) + MFI_FRAME_SIZE;
     hwaddr frame_size_p = frame_size;
     unsigned long index;
 
-- 
2.34.1


