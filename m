Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC1BC982C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lcU-0001NC-3B; Wed, 16 Sep 2026 05:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lcS-0001Iq-5J; Wed, 16 Sep 2026 05:07:56 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lcQ-0007If-BJ; Wed, 16 Sep 2026 05:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789549558; bh=11bJ0S48RHBUuEzSrdoXgCZN2ra5JEE4DHeP98szIC0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YCviEBmKHNkW4qxQmti/1KG0tsm3vTE13kxSnpk9LALTCMkTyIRHz1KV+O8kmFhhl
 S9I1V4AC96tpPcuKVXeNZLCV6A4r6KATlhxXPQHssV5J2NCVGfiaiTD4KLmI/0qbnP
 H/WBsQ4dd7wEvvjvGkS4oUzcILwZktmcTb8q6lkzd4qucKFT92O//Ppl5VLQQChayn
 dCXNgM3MBVsAh8qdTXz7n3lzDPVaDFxGfTzrB53lUjZOMfzA+jrHA8KcfyCx/sp+mL
 i9U9WmdaQU05sZ8naGAH+2Lv/r9qqY42Q9Y26gzRZClr1hiPLav/oC4X40whKK9H01
 8+hA6K+eM3YzA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C23F21D56C7;
 Wed, 16 Sep 2026 12:05:58 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6DF86429E12;
 Wed, 16 Sep 2026 12:06:41 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 3D1B25A77F; Wed, 16 Sep 2026 12:06:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 19/57] hw/ide: report the default CHS translation in
 IDENTIFY DEVICE
Date: Wed, 16 Sep 2026 12:03:43 +0300
Message-ID: <20260916090516.677749-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
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

IDENTIFY DEVICE words 1, 3 and 6 describe the default CHS translation,
and ATA-5 8.16.8 requires INITIALIZE DEVICE PARAMETERS to leave them
alone; the translation in effect is described by words 54 to 56 instead.
Words 3 and 6 were filled from s->heads and s->sectors, which the command
replaces, so a guest that selected a translation of its own was told that
its choice was what the drive came with, and could no longer find out the
default. Word 1 is already right, as no command changes s->cylinders.

Report s->drive_heads and s->drive_sectors, which ide_init_drive() keeps
for exactly this, along with the retired word 4 derived from them. The
CompactFlash data labels those words as the default geometry too, and
INITIALIZE DEVICE PARAMETERS is accepted for CFA drives, so fix both.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Cc: qemu-stable@nongnu.org
Fixes: 176e4961bb33 ("hw/ide/core.c: Implement ATA INITIALIZE_DEVICE_PARAMETERS command")
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 0df27c66dc7271ee2e63636b5183c0b3acdf7eed)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 747fa716773..befbab94867 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -138,11 +138,12 @@ static void ide_identify(IDEState *s)
     memset(p, 0, sizeof(s->identify_data));
 
     put_le16(p + 0, 0x0040);
+    /* Words 1, 3 and 6 describe the default translation (ATA-5 8.16.8) */
     put_le16(p + 1, s->cylinders);
-    put_le16(p + 3, s->heads);
-    put_le16(p + 4, 512 * s->sectors); /* XXX: retired, remove ? */
+    put_le16(p + 3, s->drive_heads);
+    put_le16(p + 4, 512 * s->drive_sectors); /* XXX: retired, remove ? */
     put_le16(p + 5, 512); /* XXX: retired, remove ? */
-    put_le16(p + 6, s->sectors);
+    put_le16(p + 6, s->drive_sectors);
     padstr((char *)(p + 10), s->drive_serial_str, 20); /* serial number */
     put_le16(p + 20, 3); /* XXX: retired, remove ? */
     put_le16(p + 21, 512); /* cache size in sectors */
@@ -332,8 +333,8 @@ static void ide_cfata_identify(IDEState *s)
 
     put_le16(p + 0, 0x848a);                    /* CF Storage Card signature */
     put_le16(p + 1, s->cylinders);              /* Default cylinders */
-    put_le16(p + 3, s->heads);                  /* Default heads */
-    put_le16(p + 6, s->sectors);                /* Default sectors per track */
+    put_le16(p + 3, s->drive_heads);            /* Default heads */
+    put_le16(p + 6, s->drive_sectors);          /* Default sectors per track */
     /* *(p + 7) := nb_sectors >> 16 -- see ide_cfata_identify_size */
     /* *(p + 8) := nb_sectors       -- see ide_cfata_identify_size */
     padstr((char *)(p + 10), s->drive_serial_str, 20); /* serial number */
-- 
2.47.3


