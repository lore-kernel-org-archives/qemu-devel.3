Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE35C44506
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wilgh-0001Zf-V0; Sun, 12 Jul 2026 00:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilgf-0001Tb-Me; Sun, 12 Jul 2026 00:21:05 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilge-00075Z-0I; Sun, 12 Jul 2026 00:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829781; bh=M061+QEFVIGf6r7gv0s1GTPbsJs+oT8h+D5narosSDs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qJGYiGJPXmETj8rAlXiv9HUrxsxLssQX0Ll3oOO+ksz3S4HJpCrCTdqvTamqE/p8R
 WyA/+//lyzEwHMtLxLigctwQjidfOGcE7Iad/6xPqjIAw3s96u/bqj9Xp2rlYTaXTX
 5FZUVNkJLP/2zsFU/JcmhKKiuU703DRepRRqAx9zYprIfWbpHqfbHKVxP9kdUqE427
 qZJdrw10o/JPrAMzyTWI4gLPFBJ0bSDaKRT+61EvOX5P6A3bUgGG0hNla0mBEACrkG
 F2ud9WL/QvGreR1YW6ZbsJJ43/dds8Pi1I94JWkyYkIuSi5m9osHAlcXNgSt7ZUeBJ
 5cKJ6HkmCSPmg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E75B21C0C0E;
 Sun, 12 Jul 2026 07:16:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 26A983EB96E;
 Sun, 12 Jul 2026 07:16:32 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8D5191341F; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>, luc@lmichel.fr,
 peter.maydell@linaro.org, hemanshu_dev@proton.me,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 51/75] hw/core/qdev-clock: Fix potential null pointer
 dereference
Date: Sun, 12 Jul 2026 07:15:09 +0300
Message-ID: <20260712041539.108341-51-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>

qdev_get_clocklist() function returns a pointer to the NamedClockList
struct. This function is called in qdev_alias_clock() and the returned
pointer is immediately dereferenced without a null check.

Passing a clock name that doesn't exist to qdev_get_clocklist() is a
programming error, and so this change is not fixing a bug, only making
the reporting of that programming error a bit more helpful and bringing
it in to line with qdev_get_clock_in() and qdev_get_clock_out().

Cc: luc@lmichel.fr
Cc: peter.maydell@linaro.org
Cc: hemanshu_dev@proton.me
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2342
Signed-off-by: hemanshu.khilari.foss <hemanshu.khilari.foss@gmail.com>
Message-id: 20260531153354.88909-2-hemanshu.khilari.foss@gmail.com
Reviewed-by: Luc Michel <luc@lmichel.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 7913b3b9463ffb4078d33c7ddaeacd1bb38aae3e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
index dacafa4e036..968cf04e51d 100644
--- a/hw/core/qdev-clock.c
+++ b/hw/core/qdev-clock.c
@@ -157,7 +157,14 @@ Clock *qdev_alias_clock(DeviceState *dev, const char *name,
                         DeviceState *alias_dev, const char *alias_name)
 {
     NamedClockList *ncl = qdev_get_clocklist(dev, name);
-    Clock *clk = ncl->clock;
+    Clock *clk;
+
+    if (!ncl) {
+        error_report("Can not find clock '%s' for device type '%s'",
+                     name, object_get_typename(OBJECT(dev)));
+        abort();
+    }
+    clk = ncl->clock;
 
     ncl = qdev_init_clocklist(alias_dev, alias_name, true, ncl->output, clk);
 
-- 
2.47.3


