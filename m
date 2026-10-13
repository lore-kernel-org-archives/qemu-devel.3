Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222F4CC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 19:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGiAU-0001r9-IO; Tue, 13 Oct 2026 15:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xGiAS-0001pv-7Q
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:28:08 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xGiAQ-00087C-KQ
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=imopqQxEo2oFfz2zOTMN3NU7W68A9sRZ3GYUcFasF04=; b=ky0G9Qip3zaQuNYJZe0lTDfzwN
 KUNu819y54z8Kl0HgKAvneEiXiO30shro6K8/f/umUeXRafAiJbeTJRxXS+tTiI073FcaI42zTTTA
 2F3jla9zpsAT7TLZ0983lgpGM/Voa5m6WrAAQKP/DRFngz4fB1ODLhszy8VJNaN9cHeXi3C2Kll6r
 u/ts7CZZvLYkup+LQivMrbhyGK9LDwcIxvf+/ZXEAPOy1+45ln8K+SQo50MnGBHydaC1yViATZAvB
 JVPnSqAf3GqMFNbEF268wMFo/Q8nLOpuBArZBvt2U+vofP+MyBKXMMjneVOhVgJ2qTCsVtmGz5FtB
 PchZgkwtL4zbKxhum6U66B35SlNLQlhIYxrqrjUorL9HqOi0FJD91ejWuwbGKZsLQt4Rs5tMAgIxB
 FxAooGpV9/i+dpf7saV5JSOsN5gUhDNcCnYM1fl3bVmCVeQWECm8EKkHt5b+KIkpRQoFcYccFp3nO
 GrVwqNkosEdKxRugDMmavduAj13fiNxwKtYZvVmtQvtpiDUVb40OJcnCRg39/JgjjSxQ1I9lFQkNv
 30aiEkT0sbF87j5j77kKf/auNIMwhn9WGH8fZdVjhNAlXISyjqqaOmBErGZ3WQhNAU0VCVg/qac+B
 8mOnoF5yetuN4ItjW52haWXl2P01e5buwH7wa6YEk=;
Received: from [2a02:8012:2f01:0:b2a5:667b:71e2:6751]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1xGi9j-001aAM-M9
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 20:27:23 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org
Date: Tue, 13 Oct 2026 20:27:34 +0100
Message-ID: <20261013192751.196204-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013192751.196204-1-mark.cave-ayland@ilande.co.uk>
References: <20261013192751.196204-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:b2a5:667b:71e2:6751
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 2/5] ppc: Raise decrementer IRQ on zero write
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
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

From: "Kirill A. Korinsky" <kirill@korins.ky>

OpenBSD writes zero to an edge triggered decrementer, then enters idle
expecting its interrupt. QEMU defers the already due edge to a timer at
the current virtual time, leaving the guest stalled.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Suggested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Message-ID: <20261001230058.11465-3-kirill@korins.ky>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ppc/ppc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index b123b4cc1cc..6f99b61a287 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -885,6 +885,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, int64_t now, uint64_t *nextp,
      * an edge interrupt, so raise it here too.
      */
     if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
+        ((flags & PPC_DECR_ZERO_TRIGGERED) && value == 0) ||
         ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
           && signed_decr >= 0)) {
         (*raise_excp)(cpu);
@@ -1104,6 +1105,12 @@ void cpu_ppc_tb_init(CPUPPCState *env, uint32_t freq)
     if (is_book3s_arch2x(env)) {
         /* All Book3S 64bit CPUs implement level based DEC logic */
         tb_env->flags |= PPC_DECR_UNDERFLOW_LEVEL;
+    } else {
+        /*
+         * Classic 32-bit edge-triggered decrementer: zero write fires
+         * immediately
+         */
+        tb_env->flags |= PPC_DECR_ZERO_TRIGGERED;
     }
     /* Create new timer */
     tb_env->decr_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-- 
2.47.3


