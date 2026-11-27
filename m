Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5531B606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=x16DS6EQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp3s-0005hJ-JN; Fri, 27 Nov 2026 01:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp1t-0003lW-BM; Fri, 27 Nov 2026 01:01:54 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp1r-0000D6-CQ; Fri, 27 Nov 2026 01:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758881; bh=WhKOJGcCkQDphpfcG2FTJKaVUo/6jQI4AREtWoCx3oY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=x16DS6EQyADyqP4WgXhYVr8Tfja5tDWdBNOzeP4jjThOUeVncoNbVJofXxJ7UozLv
 IKBKm69YyhNP3oSO7Vf/mzy0gmYw0v+E+pKCHgej6jTPD8sjSfamjdeL8EjQoLG1JV
 9FEa4G7QUymfcyVg80oqhEv29h4T+0eDbEWPQgXWyzuaG/s8SJIe4GACVtV3gsatyz
 lbFbAyt/rENnhAAMrnmGR/PXJa4InCRQJPjdBkReMSmXsUgQEh8czL/qZHcHwoCYYF
 twI7/4clDa0eEuFo6NPyo0U8OVGPusBR8SUFE4nOfyHVs+Hc+iNR1LS31YTSII7U9N
 CxONazpJDWb8A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E23601EA314;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DFFBC469954;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B20D4CF2A8; Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Skinstad Drabitzius <daniel.drabitzius@northern.tech>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 137/140] hw/block/pflash_cfi01: Allow zero-count
 buffer write
Date: Fri, 27 Nov 2026 08:54:03 +0300
Message-ID: <20261127055421.39015-78-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Linux's Intel CFI driver emits a zero count for a single buffered
write (one write cycle, at any bank width). The block update buffer
was only started for non-zero counts, so the data was rejected with
a programming error. Enable the block update buffer for any count.

Cc: qemu-stable@nongnu.org
Fixes: 2563be6317fa ("hw/pflash: fix block write start")
Reported-by: Daniel Skinstad Drabitzius <daniel.drabitzius@northern.tech>
Suggested-by: Daniel Skinstad Drabitzius <daniel.drabitzius@northern.tech>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4111
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261124185556.81132-3-philmd@oss.qualcomm.com>
(cherry picked from commit c12cd67241c77dd601f62004aacd02a636ecb07f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 31d0f226510..124cd3f8247 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -599,7 +599,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
         switch (pfl->cmd) {
         case 0xe8: /* Block write */
             /* FIXME check @offset, @width */
-            if (pfl->blk_offset == -1 && pfl->counter) {
+            if (pfl->blk_offset == -1) {
                 pflash_blk_write_start(pfl, offset);
             }
             if (!pfl->ro && (pfl->blk_offset != -1)) {
-- 
2.47.3


