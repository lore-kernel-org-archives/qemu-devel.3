Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAD1C531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 12:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnbaA-0007J5-El; Sat, 25 Jul 2026 08:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wnba8-0007IH-E6; Sat, 25 Jul 2026 08:34:20 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wnba6-0002GL-K4; Sat, 25 Jul 2026 08:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=uI4cXcC92A33hs4oVCJ0bjNbNBnyUKPKWu1cqjKRftU=; b=xA8XhcWQVYuCguqMDtW2KpHhmk
 esNcLYVe/pnLWO7lepguxzV2es73MSo+VG1mvSUDJS5bP2ryQLi50NWcM4qnTor41mXkqAd9sVAFR
 aKIVZ4Dsr9xFYJ32GmxOW2g7kWEOFkTqaDRXE/ye+8wYhpEI/N0OpCLL/tNRCMoByIJeZWO+xdtdU
 9GMRR0lPWKlKe+Z/uG+gvOJwvQOlDQHIc7XFCLbuQ60uRudcaebRj+gWuD2JNVfVDiuE/OPZKorcX
 jDMqXNLdh6sPYWlDZF/vsZfp6I/S0LtEA4UyfUNl1xe8wV3AtGIC5zIjZVPIpt5uebVj3sSK4OAdF
 gbuKwRZUAayU3MitPL9AClpl32XrS/RgcOyPk3tTkfBKbwd+YPpIvZBFzm5z4KIqRCxCEhu49L0OP
 QRp7LXkBDX5TkltKZXV1xiIabZSGmJ3DFwSNnDUEL+WRPvC7hDZGR0d3k2d4UR8Q0/z/W2RRrkyHh
 Eb0U6kpQVttt08RSpWm2+9LfRbLGCDiRthC/ZWdIdnwApDUlQgt2YjJgi00uEPWQ4H242ibXr2Iag
 yWFq5Yf5/B/nDGKGkY01Otx5IIU5Xlkd6qLUVE2Zcmf7j7/wFQcJ6ZO99FvEnrs1upDUQbgqlgog4
 6dV1/f0Tbok1EoR7PXIDw/IMno9eZHM5lsDmW5v20=;
Received: from [2a02:8012:2f01:0:34a6:6cc:a7a8:2b1e]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wnbZs-004VoV-SV; Sat, 25 Jul 2026 13:34:05 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org, atar4qemu@gmail.com, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org
Date: Sat, 25 Jul 2026 13:33:22 +0100
Message-ID: <20260725123411.993099-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:34a6:6cc:a7a8:2b1e
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2] target/sparc: set reg window data structures currently
 after vmstate load
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

In the SPARC CPU state, env->regwptr points into the env->regbase
array at wherever the architectural CWP (current window pointer) says
we are in the register windows.  We don't migrate this directly,
since it's a host pointer, so we must ensure it is set up again
after migration load.

We also have to deal with a special case when CWP is (nwindows - 1).
In this case, while running we keep the "in" register data for this
window in a temporary location at the end of the regbase[] array, so
that generated code doesn't have to special case this "wrap around"
case.  In cpu_pre_save() we call cpu_set_cwp() to force a copy of the
wrapped data from its temporary location into the architectural
location in window 0's "out" registers.  We then migrate only
(nwindows * 16) entries in the regbase[] array.  So on the
destination we need to copy the "in" register data back to its
temporary location again.

For 32-bit SPARC we get this right, because the CWP is in the PSR.
The get_psr() function does:
     env->cwp = 0;
     cpu_put_psr_raw(env, val);
which causes cpu_put_psr_raw() to call cpu_set_cwp() in a way that
sets up both regwptr and the wrapped-register data.

However, for 64-bit SPARC the CWP is not in the PSR, and
cpu_put_psr_raw() will not call cpu_set_cwp().  This leaves the guest
register state in a corrupted state, and the guest will likely crash
on the destination if it didn't happen to be executing with CWP == 0.

Fix this by adding a custom vmstate_cwp VMStateInfo with corresponding
get_cwp() and put_cwp() helpers which does the same for the 64-bit
case.

Cc: qemu-stable@nongnu.org
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/machine.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

Thanks to Peter for his original patch and excellent analysis on the
cause of the asan failure whilst running the "sparc64-migration"
functional test.

 
diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 5f402e098cf..0d5d79b5e7b 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -151,6 +151,37 @@ static const VMStateInfo vmstate_xcc = {
     .get = get_xcc,
     .put = put_xcc,
 };
+
+static int get_cwp(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field)
+{
+    SPARCCPU *cpu = opaque;
+    CPUSPARCState *env = &cpu->env;
+    uint32_t val = qemu_get_be32(f);
+
+    /* needed to ensure that the wrapping registers are correctly updated */
+    env->cwp = 0;
+    cpu_set_cwp(env, val);
+
+    return 0;
+}
+
+static int put_cwp(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field, JSONWriter *vmdesc)
+{
+    SPARCCPU *cpu = opaque;
+    CPUSPARCState *env = &cpu->env;
+    uint32_t val = env->cwp;
+
+    qemu_put_be32(f, val);
+    return 0;
+}
+
+static const VMStateInfo vmstate_cwp = {
+    .name = "uint32",
+    .get = get_cwp,
+    .put = put_cwp,
+};
 #else
 static bool fq_needed(void *opaque)
 {
@@ -286,7 +317,14 @@ const VMStateDescription vmstate_sparc_cpu = {
         VMSTATE_CPU_TIMER(env.hstick, SPARCCPU),
         /* On SPARC32 env.psrpil and env.cwp are migrated as part of the PSR */
         VMSTATE_UINT32(env.psrpil, SPARCCPU),
-        VMSTATE_UINT32(env.cwp, SPARCCPU),
+        {
+            .name = "env.cwp",
+            .version_id = 0,
+            .size = sizeof(uint32_t),
+            .info = &vmstate_cwp,
+            .flags = VMS_SINGLE,
+            .offset = 0,
+        },
 #endif
         VMSTATE_END_OF_LIST()
     },
-- 
2.47.3


