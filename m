Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16184606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=SfFHE978
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWpDN-0003JQ-80; Fri, 27 Nov 2026 01:13:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWpB0-0007RY-7y; Fri, 27 Nov 2026 01:11:20 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWpAx-0002DT-CC; Fri, 27 Nov 2026 01:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759049; bh=Ppn5cHwYnKfgcU9voyP3fyOENUEN+4/p2lp1bEF1mck=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SfFHE978ie0koIJyvnEqvgNOjgV3cPeCo1RMOaAu7YJTRAHKq/von4+ro5z0sFp03
 LH3NVnv1LqJk5TedOc+ky9z2ISNit/kBLT0w1Q1r2xAElgzoRiCXUsSiodvq7pcE5x
 zjh2bH5aFh7uoPm57MtAxJ2xvLMzLafE6be1qw5nqTZWkEc+bfOyvv39vHDrIMiNpG
 bN63Bm94aQAn2PnJAkqszfqMmu2o4vHTmkp0XA98IJFeSwM2Ws2nNWcDXTrNoBokc7
 0A9v/9JJLzSa74yhUfbjWoMgNlm9LO0RYJI9Q0nh0Jxgp4oBmO3SYW83Q0f5mmi9dw
 8TgZaj/OeKdHA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C0E4B1EA386;
 Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BDF2E4699B1;
 Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 92C13CF35A; Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Wang Jianqiang <wjq.sec@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 148/152] hw/block/pflash_cfi01: Register VM change
 handler once
Date: Fri, 27 Nov 2026 08:54:46 +0300
Message-ID: <20261127055709.39630-85-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
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

Each pflash_post_load() added a VM change-state handler and
overwrote pfl->vmstate. Loading twice before the VM resumes
left the first entry on the list, and resuming then ran a
freed entry. Register the handler only when none is held.

Cc: qemu-stable@nongnu.org
Fixes: 90c647db8d59 ("Fix pflash migration")
Reported-by: Wang Jianqiang <wjq.sec@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2635
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261124185556.81132-2-philmd@oss.qualcomm.com>
(cherry picked from commit 0522a9457b071fcdb3470278e3df78c1e773d432)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index a13b91967ed..66539e91c5f 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -1040,7 +1040,8 @@ static int pflash_post_load(void *opaque, int version_id)
         memory_region_rom_device_set_romd(&pfl->mem, false);
     }
 
-    if (!pfl->ro) {
+    /* A second load before the VM resumes must not add a duplicate entry */
+    if (!pfl->ro && !pfl->vmstate) {
         pfl->vmstate = qemu_add_vm_change_state_handler(postload_update_cb,
                                                         pfl);
     }
-- 
2.47.3


