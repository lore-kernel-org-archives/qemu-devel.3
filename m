Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FFCC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWRr-000385-8K; Wed, 22 Jul 2026 08:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWRP-0002iV-Uz; Wed, 22 Jul 2026 08:52:58 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWRO-0002US-D8; Wed, 22 Jul 2026 08:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724574; bh=2/eB0ERPe4CsWEDIDQTng1/Ud46Y0zC79nesY/gqSqE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AzaAnj3k25z/JPE8IanOagRn9vV8czhj95+Gh5EbaUIQdu2yuZFFL5KZRFU6F6bOa
 YSh68M6AStBold2CN4uBUR0jEEfj0O8vaLy4aOFq0ptfT8NDaL4UcJaLzNpswZNWmM
 eRRbiPkMK4iE3aXD2fwpR62cs9D8kUC51FbVJkvRrNLTjJ5w8tgR0qtoG7qDxufzpn
 X2q1mhEkcNeMwu3A/EYuu3vgTHYjBC+7RoN+BqCJC6+vUCd6LZmBMkeEbBsV1bKUAb
 eYtYOmmp3ngXlXFwuh4PX485YoTb2B7shRINJWkrObJAlfLO3lhANDQmQECsdnmVqe
 FPFlNulHe9q0A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CFAE81C3B3E;
 Wed, 22 Jul 2026 15:49:34 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 244503F378E;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B7D0E17F51; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Dmitry Pimenov <sun4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 097/127] hw/sparc64/niagara: use int64_t for vdisk
 size to avoid truncation
Date: Wed, 22 Jul 2026 15:48:22 +0300
Message-ID: <20260722124859.32371-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
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

From: Dmitry Pimenov <sun4qemu@gmail.com>

blk_getlength() returns int64_t, but niagara_init() stored it in an int,
truncating the if=pflash virtual-ramdisk size for images >= 2 GiB. A ~4 GiB
image truncated to 0/negative, failed the `size > 0` check, and exit(1)'d
before the CPU ran, ending with:

  qemu-system-sparc64: could not load ram disk

Signed-off-by: Dmitry Pimenov <sun4qemu@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260710222350.9185-1-sun4qemu@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 76dbe26fd6500a94b85bf0f3a39d73b72f5fab7b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 209be380473..b7983042c28 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -137,7 +137,7 @@ static void niagara_init(MachineState *machine)
        outside of the partition RAM */
     if (dinfo) {
         BlockBackend *blk = blk_by_legacy_dinfo(dinfo);
-        int size = blk_getlength(blk);
+        int64_t size = blk_getlength(blk);
         if (size > 0) {
             memory_region_init_ram(&s->vdisk_ram, NULL, "sun4v_vdisk.ram", size,
                                    &error_fatal);
-- 
2.47.3


