Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B2FCD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuMk-00014D-F1; Tue, 12 May 2026 17:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuMH-00080U-M7; Tue, 12 May 2026 17:09:42 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuMG-0003SK-0E; Tue, 12 May 2026 17:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619302; bh=4dB7J9um+urWj0qd77ycHYeU9OrcYP3RFNylth6087Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=c46CCjE0CPw+skXtlzo8or0yw1uCO9Lw1tK3mo8WK8kNBc0g0RzXi1SKQDHPn7gwz
 s7aaml77/+U/a/75ozCBs2+H2/6pOvLc6YhFO+r3Eq8H2hYO/Y714+g+OBvxGkBd2M
 Z9/WjfJo+rfy00bym/aLSpQqoAvcWiIDo9SyorDLS4huRjNRl18obbxxeNSuh5PXZf
 hOSnPM8fgqs4R9VKpRgZCPU5TIyILhkEyKlGgcqAZ24MZ6URc7qf2EQfkZ1AbPV+TC
 k0dHsv5aQf2ZcUd8uR/RMW9GQFudFA3yTi4ZyXcICEqveZ+pezHLQyAbYlkpJ7oZnw
 he/8dJKfyI3ig==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3F61B1AA363;
 Tue, 12 May 2026 23:55:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4354E3ABCD3;
 Tue, 12 May 2026 23:55:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 038/117] lsi53c895a: keep a reference to the device
 while SCRIPTS execute
Date: Tue, 12 May 2026 23:53:40 +0300
Message-ID: <20260512205503.361097-38-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
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
index 9ea4aa0a85..2cc7e945e1 100644
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


