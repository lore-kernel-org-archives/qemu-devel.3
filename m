Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2856606A337
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=jeVRrqAW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3IQ-0000VV-D2; Mon, 16 Nov 2026 15:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3IL-0008QI-Tl; Mon, 16 Nov 2026 15:27:18 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3II-0000ix-Ka; Mon, 16 Nov 2026 15:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860763; bh=tzJ08nFcOWGLxQ0GI9nVdCitaya5oWRKEXgL5YUzS2Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jeVRrqAW11rqi+f69PEY777fVA3Z3UHprEVuc3w4XcqLuJqQx75QKrpdrvTlto7Kw
 wBdA/ZAE7h8nYEhjI4fzO72q7iciwRB9j09ozRKAmI9v/KtDVIKYUjQkjQ5tW+lfSj
 RxI1m7y+e5sJkuAmZS/jI0athLlZhpn0AfetrIDaJDvGQCXhGDk1r2uSJNMGDAYm7T
 mkxfUDHlSmHaOYxAHEcRPV1vtWUYqr14oLv2NcGnMpRFTU8xBHjT+FXyOnCgWG0nVb
 MHK8Dow/VA7AoWlE7iEWeJqO1JF4OtysVlnoXNghxFp3wFzqH5xscZKt8uvGrgJQrJ
 lhgGm+oJq7p6Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F13501E71A5;
 Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EE5B045FBD1;
 Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 97857B8E66; Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 16/63] hw/net/cadence_gem: Check guest-provided queue
 numbers in screening registers
Date: Mon, 16 Nov 2026 23:24:55 +0300
Message-ID: <20261116202554.535325-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

The Cadence GEM allows the guest to program "screening registers"
which control which queue received network data should be sent to.
The field for the queue number in these registers is 4 bits, but the
device might not actually have that many queues.  We weren't checking
this, which meant the guest could program a value that caused us to
index off the end of various arrays.

Check against num_priority_queues, and treat out-of-range values
as if the screen didn't match (i.e. go to queue 0). (This is a
best guess at reasonable behaviour since I don't have access to
a datasheet for this device.)

Cc: qemu-stable@nongnu.org
Fixes: e8e4994313b7 ("cadence_gem: Add support for screening")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4363
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261023153106.1710228-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit b26d4302a8978e1fe467b4d90a2e826f898f11d3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 39e3620ef5b..9a94b3b8ca4 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -854,6 +854,7 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
     uint32_t reg;
     bool matched, mismatched;
     int i, j;
+    int queue = 0; /* default to queue 0 if no match */
 
     for (i = 0; i < s->num_type1_screeners; i++) {
         reg = s->regs[R_SCREENING_TYPE1_REG0 + i];
@@ -881,7 +882,8 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
         }
 
         if (matched && !mismatched) {
-            return FIELD_EX32(reg, SCREENING_TYPE1_REG0, QUEUE_NUM);
+            queue = FIELD_EX32(reg, SCREENING_TYPE1_REG0, QUEUE_NUM);
+            goto out;
         }
     }
 
@@ -974,12 +976,23 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
         }
 
         if (matched && !mismatched) {
-            return FIELD_EX32(reg, SCREENING_TYPE2_REG0, QUEUE_NUM);
+            queue = FIELD_EX32(reg, SCREENING_TYPE2_REG0, QUEUE_NUM);
+            break;
         }
     }
 
-    /* We made it here, assume it's queue 0 */
-    return 0;
+out:
+    if (queue >= s->num_priority_queues) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Screening register selected out of range queue %d\n",
+                      queue);
+        /*
+         * This is a best guess at reasonable behaviour in the absence
+         * of a datasheet to confirm it.
+         */
+        queue = 0;
+    }
+    return queue;
 }
 
 static uint32_t gem_get_queue_base_addr(CadenceGEMState *s, bool tx, int q)
-- 
2.47.3


