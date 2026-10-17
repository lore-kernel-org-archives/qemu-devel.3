Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0353ACCF2CF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 18:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9aI-0008UM-FL; Sat, 17 Oct 2026 14:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9Zo-0008Ep-SP; Sat, 17 Oct 2026 14:56:18 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9Zm-0003cM-Kl; Sat, 17 Oct 2026 14:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263364; bh=S4KO3HMtJ47zu/nn5ta7t0PN4/lDWBv5KmMbCgFVme4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WcQopw2vleHdRTtsRDueUoXuwAzXpMSn5qFZhn3vMXFv7S/4TmoYfx1yqKsGElisb
 dgONzuoGA+efCeF8fLmwtEAgugPTIK24eS8rGA2jD/gtnnhhdI4ldaz5mIMRp0PFzl
 NQVfwzD35xtNRGaOueKlve+pQrffGP7AcJenAlhyR0EyhlYNCRhaM8ofGtbvQOtqk8
 92c3i1sCpypegOobTGe1dIoI3sxRFvlT1s/zPgQb08y6xRa+d9KfWbn5OoeEc/Hzlk
 +Zg1e0rS/bGjTlV2/J4qt5Or+5mu1N+g+pcizmXwTLSdUlroMbX9pwPK8S14c0vG+9
 GdzA+83ZGvtaw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E8F711DE6A9;
 Sat, 17 Oct 2026 21:56:04 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 13271443374;
 Sat, 17 Oct 2026 21:56:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 09/63] hw/intc/s390x: Fix check after g_try_realloc
Date: Sat, 17 Oct 2026 21:54:25 +0300
Message-ID: <20261017185528.722197-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
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

From: Eric Farman <farman@linux.ibm.com>

The loop to store pending IRQs uses g_try_realloc() to expand the
buffer being used, but the returned address is stored in a
pointer-to-pointer, thus the check is supposed to be examining
the contents of the pointer, and not the pointer itself.

Define a temporary variable to catch and test the returned pointer.
If it's NULL, return to the caller to perform the free on the
unmodified buffer. If it's not NULL, store it in the caller's
pointer and restart the loop against the new struct.

Cc: qemu-stable@nongnu.org
Fixes: 3a553fc658 ("s390x/kvm: implement floating-interrupt controller device")
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260922201526.2383047-8-farman@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit 77cc481c23118d0fc3711525dd64373c6797ceed)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 10aaafbb31..421b993c69 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -254,6 +254,7 @@ static int __get_all_irqs(KVMS390FLICState *flic,
                           void **buf, int len)
 {
     int r;
+    void *new_buf = NULL;
 
     do {
         /* returns -ENOMEM if buffer is too small and number
@@ -263,10 +264,11 @@ static int __get_all_irqs(KVMS390FLICState *flic,
             break;
         }
         len *= 2;
-        *buf = g_try_realloc(*buf, len);
-        if (!buf) {
+        new_buf = g_try_realloc(*buf, len);
+        if (!new_buf) {
             return -ENOMEM;
         }
+        *buf = new_buf;
     } while (r == -ENOMEM && len <= KVM_S390_FLIC_MAX_BUFFER);
 
     return r;
-- 
2.47.3


