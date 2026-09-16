Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66958C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6kKC-00057h-GI; Wed, 16 Sep 2026 03:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kKA-00056Y-TY; Wed, 16 Sep 2026 03:44:58 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kK8-00051G-Kl; Wed, 16 Sep 2026 03:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789544605; bh=IT6MMykFOTtTKhvdW6Iv/AfyFcZ/XdQYHaHwcTh3wVs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bfGmSj9dnH31THWiSZ+cl8TizBWqjcv3rDytYJYaVDIcSCV+3Dqqj4LtLoU1OFiRF
 kSsuOM6blIznz0jds+gxNpIvKPLHsza0YQjtqQqsP3dRnzubkjNor1JI1skLnETIM4
 E/BLwamKcUxXgB5v2qeQ7NHg1KdD3dobvmrlDbXb7E86FD1kZLcPFDNXBG/KWCYStk
 IQaltyRmqDFAJex0SrnJMnX7O8n0zASQ6t+Moal3vgKKOC1uf3jmsDxL8F5zAdMhQ3
 QBUkLJJQ8cK+us46RTYfEvxqca8PjbgYuN1x5sb6Dwh7MgnspGQ4nXf8uucS+PlO3x
 nwIYluWeMx5/g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5EEE91D559B;
 Wed, 16 Sep 2026 10:43:25 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E27BA429B30;
 Wed, 16 Sep 2026 10:44:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id BD4AA5A6E1; Wed, 16 Sep 2026 10:44:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zheyu Ma <zheyuma97@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 16/49] hw/ide: reject an unsupported CHS translation
Date: Wed, 16 Sep 2026 10:42:34 +0300
Message-ID: <20260916074346.671467-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
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

From: "Denis V. Lunev" <den@openvz.org>

ide_set_sector() divides by (s->heads * s->sectors) when the drive is
addressed in CHS mode. Both come from the guest via INITIALIZE DEVICE
PARAMETERS, and cmd_specify() stored them without any check, so a guest
asking for zero sectors per logical track killed QEMU with SIGFPE on the
completion of the first CHS read or write. s->heads is safe, as the
command passes a heads-1 value.

The count has an upper bound as well. The legacy sector count register is
eight bits wide, but handle_cmd() takes the count from a 16 bit field of
the register FIS, so an AHCI guest can ask for up to 65535 sectors per
track, and the CHS branch of ide_get_sector() then overflows the int it
multiplies cylinder, heads and sectors in.

ATA-5 6.2 numbers CHS sectors from one and ATA-2 D.2.8 limits IDENTIFY
DEVICE word 56 to 1 through 255, so neither end is a translation a device
may accept. ATA-5 8.16.6 requires an unsupported one to be reported as an
aborted command: do that, leave the translation in effect alone, and
refuse the value rather than checking it at every use.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Cc: qemu-stable@nongnu.org
Fixes: 176e4961bb33 ("hw/ide/core.c: Implement ATA INITIALIZE_DEVICE_PARAMETERS command")
Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2399
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 6c712a86f6c8d8bdd8a3ba6b39cbcd9550668c36)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 3769918d6f9..606a3adf9c2 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -1655,14 +1655,21 @@ static bool cmd_check_power_mode(IDEState *s, uint8_t cmd)
 /* INITIALIZE DEVICE PARAMETERS */
 static bool cmd_specify(IDEState *s, uint8_t cmd)
 {
-    if (s->blk && s->drive_kind != IDE_CD) {
-        s->heads = (s->select & (ATA_DEV_HS)) + 1;
-        s->sectors = s->nsector;
-        ide_bus_set_irq(s->bus);
-    } else {
+    if (!s->blk || s->drive_kind == IDE_CD) {
+        ide_abort_command(s);
+        return true;
+    }
+
+    /* ATA-2 D.2.8 limits IDENTIFY DEVICE word 56, and the count, to 1..255 */
+    if (s->nsector == 0 || s->nsector > 255) {
         ide_abort_command(s);
+        return true;
     }
 
+    s->heads = (s->select & (ATA_DEV_HS)) + 1;
+    s->sectors = s->nsector;
+    ide_bus_set_irq(s->bus);
+
     return true;
 }
 
-- 
2.47.3


