Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD76C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6n15-00045D-Nr; Wed, 16 Sep 2026 06:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n13-0003wF-I1; Wed, 16 Sep 2026 06:37:25 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n10-0001hV-7f; Wed, 16 Sep 2026 06:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789554955; bh=WA4S4AEQz14oXbQcsJ/FIrIsaYwe8zOQ52GKTdDe23I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HNXicrSSQVNu/+uAbYaRswOZOgkE2HtluHbdadfnvvbcCslig6Mg/delSde8GnoLJ
 72IUS6wlbjkyoXzEPWPYa+qqK2G9zkTXFxT412hKpUiiwPAIOMPpCGEfFjP0GEZlel
 rlgeLz7uHM+2C/sBwDCSus0/TzvK0ihmdZoZsUh31I6LUyP+TyEUXPSG7+nujk4Vv3
 jthfxkUfVeYaGxLuZ9KdGHUk8IRomDTnKgNDJwtvcP2l6aML0r9RC8cGQKz9K08XuT
 0QbB/X7uDDh73GQPmVozmbHrdZx8O3Vtyoxh/LUyMNGhj6cJGIiEd+UajIEjFfGACT
 CLaSxD5g4ST/Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DDEC41D5801;
 Wed, 16 Sep 2026 13:35:55 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A7D1D429F60;
 Wed, 16 Sep 2026 13:36:38 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 81E495A7FD; Wed, 16 Sep 2026 13:36:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zheyu Ma <zheyuma97@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 14/56] hw/ide: reject an unsupported CHS translation
Date: Wed, 16 Sep 2026 13:35:32 +0300
Message-ID: <20260916103622.684817-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260916133554@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260916133554@cover.tls.msk.ru>
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
index fb9bf11b455..747fa716773 100644
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


