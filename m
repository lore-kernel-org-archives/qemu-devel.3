Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2272FC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8iL-00080D-5m; Wed, 12 Aug 2026 09:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8hj-0006l1-KP; Wed, 12 Aug 2026 09:09:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8hh-0005df-O6; Wed, 12 Aug 2026 09:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=4YXb4pmsRAqJngvJgQKZpCKM6TcYkeZ5op67LRhU10Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Gw9i/VywTp5GDj6q5u2iaHo+42+o0n/MTraj/725yi5tKEqwS7i4BaH4nBjh+/zv9
 3BPTZhXsqMXilglSZDXCC8D+BhqmvB8saiGWE3OLJn1DnbeWHUjo4K3HV7fUut8E9f
 LC+BYz9bwXKSIr+PAuqJ1ILxrQHeM0fNKKJ54Z0EvQrtXHqkP2tfVH+m0OiqAoCA72
 OXAEGLgHhNopvTn/PUsJsKBl3cCaJKpnlF9Bz1VhnbPLDqxytIUJK9gbaP1rDCvKim
 6viRzVpJmXR0N3WQTbzUd9XcNYBM+d1mfqrpTAeqUq1Y/61HOSw5MqNojNHPsmvXFs
 64NR7NVJZLsow==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 427691CA4C0;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 78788409BA3;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 76D522F916; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 065/102] target/sparc: set reg window data structures
 currently after vmstate load
Date: Wed, 12 Aug 2026 16:01:40 +0300
Message-ID: <20260812130233.621965-65-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260725123411.993099-1-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit d8813fdc4bdf3038cc55d03dab2d9dbbeb340226)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 222e5709c55..b4deaf1919a 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -143,6 +143,37 @@ static const VMStateInfo vmstate_xcc = {
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
@@ -279,7 +310,14 @@ const VMStateDescription vmstate_sparc_cpu = {
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


