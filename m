Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDCF606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=s80+Vvnt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWpAh-0006vG-CO; Fri, 27 Nov 2026 01:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWpAM-0005xo-Ef; Fri, 27 Nov 2026 01:10:38 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWpA5-00065R-K3; Fri, 27 Nov 2026 01:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759049; bh=fujSki5r10dZTiM96P2UNFGzyCHqOO19NaqmjQMKiSg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=s80+VvntLQJFS35PH5FHq5l6/EETZBcI1eizk+ORDQBC9nOAK1d19ablEfHMe0T+c
 e9RQKewF+Qax710QTkbgFl3kEM8d5f9kT1ZBluFfoF6NXLGuExJF8LSn7mMYco+a9O
 WlIHlg7/t3Zxozl5K0qJrYd86F0J8wSeUU5mGG7oLJb6+RaddMnqM3UvN8gPe6sgnv
 xaUQ5ujKEbzwWNCuNAbHEpz9P4JjCTEGODGAphvyfIcOxHzVw5+DPiJ5R7ef9UN/sD
 RkdXd5oJKJboUgHH18xK1GnhppmEkcjqnM05R8WV6HjxEa8JKyiGpZCXPhgSuss7fi
 wz5dEkmPrTHqw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9436B1EA37E;
 Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 91AD84699A9;
 Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7AD1CCF34A; Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 140/152] hw/sd/sdcard: Fill SPI R1 response for
 rejected commands
Date: Fri, 27 Nov 2026 08:54:38 +0300
Message-ID: <20261127055709.39630-77-mjt@tls.msk.ru>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

In SPI mode the card always responds (Physical Layer spec v1.10,
7.2.8 "Error Conditions"), so sd_response_size() returns 1 for sd_r0
and sd_illegal. However sd_do_command() does not fill the response
buffer for these response types, so the ssi-sd bridge returns
uninitialized bytes instead of an R1 with the "illegal command" bit
set. Before commit 1585ab9f1baf, ssi-sd itself replied 0x04 (illegal
command) in this case.

Build the R1 response with the "illegal command" bit set.

Cc: qemu-stable@nongnu.org
Fixes: 1585ab9f1baf ("hw/sd/sdcard: Fill SPI response bits in card code")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261123225349.54981-9-philmd@oss.qualcomm.com>
(cherry picked from commit 4bcf8c5b6ec00433e6475f72a209caebffae9caf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0ea05b979dd..dd8e1b46cea 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2610,6 +2610,10 @@ send_response:
         sd->data_offset = 0;
         /* fall-through */
     case sd_illegal:
+        if (sd_is_spi(sd)) {
+            sd_response_r1_make(sd, response);
+            response[0] |= 1 << 2; /* ILLEGAL_COMMAND */
+        }
         break;
     default:
         g_assert_not_reached();
-- 
2.47.3


