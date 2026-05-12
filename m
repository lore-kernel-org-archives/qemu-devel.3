Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14047CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuAw-0001FQ-2l; Tue, 12 May 2026 16:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuAn-0000Mm-KI; Tue, 12 May 2026 16:57:49 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuAl-00046T-FQ; Tue, 12 May 2026 16:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619275; bh=9LEiVKRbOf45vPH/Jl3CEYFWirjHQ/hV8kLMhcG87YM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=sW8xgadj9saFLhJAnAFjx8iGCPcF6QrngJDXvFpn6kK2+6gLEfU8S1+kVbgOfRXoz
 vgi4kfAQmS7/4pEsyzi7kHUuXsCL/vn/LoxWrqapOhBfi1e5UVNA+pDLn5feQ4VebO
 u8tRyv3RcMetgVTwIFTxQGPr9FI/C37KCT2iWTNvySJucVQYJ94zQcidyHy/pBUyID
 FT1PbSkbEPSAiOSDlv9jCTJHXBg8tkY/0678dyL1L2PZvMlSRXWeBSnlfeR589fjaV
 upKIxG0BQsyyAtXZW67bu0Jisigm4ho8V4wu0rwUpkg+0RCCacf7ElnEFPDTsg4VSZ
 yz26lwir4J6dw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7951D1AA2EE;
 Tue, 12 May 2026 23:54:35 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7CF593ABC5F;
 Tue, 12 May 2026 23:54:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 034/107] lsi53c895a: keep a reference to the device
 while SCRIPTS execute
Date: Tue, 12 May 2026 23:53:21 +0300
Message-ID: <20260512205437.360850-34-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
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

From: Paolo Bonzini <pbonzini@redhat.com>

SCRIPTS execution can trigger PCI device unplug and consequently
a use-after-free after the unplug returns.  Avoid this by keeping
the device alive.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3090
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 4862d2c95104d9fd0430cc003c205094f8ada1f9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 6689ebba25..bf58212fb1 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -1163,6 +1163,7 @@ static void lsi_execute_script(LSIState *s)
         s->waiting = LSI_NOWAIT;
     }
 
+    object_ref(s);
     reentrancy_level++;
 
     s->istat1 |= LSI_ISTAT1_SRUN;
@@ -1182,6 +1183,7 @@ again:
         s->waiting = LSI_WAIT_SCRIPTS;
         lsi_scripts_timer_start(s);
         reentrancy_level--;
+        object_unref(s);
         return;
     }
     insn = read_dword(s, s->dsp);
@@ -1630,6 +1632,7 @@ again:
     trace_lsi_execute_script_stop();
 
     reentrancy_level--;
+    object_unref(s);
 }
 
 static uint8_t lsi_reg_readb(LSIState *s, int offset)
-- 
2.47.3


