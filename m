Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A8FC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAQD-0008Qf-9w; Wed, 12 Aug 2026 10:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAP7-0005qD-Fo; Wed, 12 Aug 2026 10:58:05 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAP4-00013Z-F0; Wed, 12 Aug 2026 10:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546232; bh=UEp5bg5ONtpnNfeqgBq8Ip2MuDBHCEUd9KWV1YJUZyc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NYTdUdKl/XL9FOywWNywCO5Bs8ZT/98sCCM6QFcfgeOncj32VxI5xIJqKD9TWZ2X5
 X+PkWDeF44VnPyTlHFLWmVBIaGFnp2oKxz7x8JF2ykiC3HYjA/qE/nM3P0XuLKaDcF
 ZHvqFgCvEiBqfwqjeIRnR6emgv++Lj56vLkm/4f7RydryYxW0/6yPGWUzX1oGgqlyW
 PHwGW1mYMFmUwQdYC5LPvBkwHATccmfwg40BgqGQ/CLK4DVKZqCb0uY4c3oSd3Zo3R
 wgVhBGJaq3J9dd8jMFSCy+wuq5w3tyxqYHQPdAwV9La+ATE+uPd9qIQ5vEsMNPWP9z
 KEYQlDqK2B27A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D9A1A1CA650;
 Wed, 12 Aug 2026 17:50:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4069F409D92;
 Wed, 12 Aug 2026 17:50:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9E7C52F9FB; Wed, 12 Aug 2026 17:50:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 076/120] target/sparc: set reg window data structures
 currently after vmstate load
Date: Wed, 12 Aug 2026 17:48:59 +0300
Message-ID: <20260812144955.649205-76-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
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
index 4dd75aff74a..f5c41680de6 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -142,6 +142,37 @@ static const VMStateInfo vmstate_xcc = {
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
@@ -278,7 +309,14 @@ const VMStateDescription vmstate_sparc_cpu = {
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


