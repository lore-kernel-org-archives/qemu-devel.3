Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52DD606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=phW1T01E
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWpAe-0006s5-S1; Fri, 27 Nov 2026 01:10:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWpAR-0006NN-LU; Fri, 27 Nov 2026 01:10:43 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWpAO-0008Ap-Cf; Fri, 27 Nov 2026 01:10:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759049; bh=CpqAtprc9fKZBQ5Pel8ROKU0EvtoTlrHiLW4MKzNxaw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=phW1T01EpiNAeDZG/i2uTj7UiDuz5wMJoQuUJW5StkYBBFvhVDKu1YfZCIZxmhgev
 j5Ig5vfWKRMkYXh/vpcwDVHmmpa7/tP6qPStu5RV1TcdrzE+3H62za4N4nkhsWTNwO
 dYYl5FtC7EhnH04jwpwNskaYVLTqwK+dh3qsLdDiwkQ/n+p5/JSsM3uTsI2nPnootg
 yejSqZz8ytTJZDOVfeuHN1iMEwQbhye3ycOlBdi1CYdUL+Vjf60tIT5pULcbFfy2Z3
 rOkYGnvn3P3GunHK+IfQBw9d4ILhw8DwSiZqotopeirBYlwMKCBUeLhcvAqTWKDYck
 41IQsKDvoll8A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A05F51EA380;
 Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9DEF54699AB;
 Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 80D33CF34E; Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 142/152] hw/sd/sdhci: Report Auto CMD12 response
 timeout in error status
Date: Fri, 27 Nov 2026 08:54:40 +0300
Message-ID: <20261127055709.39630-79-mjt@tls.msk.ru>
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

Auto CMD12 copied an uninitialised stack buffer into the upper
Response register when the card did not respond.

Store the response only when one is returned. On timeout, set the
Auto CMD12 Timeout Error status and, if enabled, the Auto CMD12
Error interrupt (SD Host Controller v1.00, sections 1.11, 2.2.23).

Cc: qemu-stable@nongnu.org
Fixes: Coverity CID 1619307
Fixes: d7dfca0807a0 ("hw/sdhci: introduce standard SD host controller")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261124073406.87537-2-philmd@oss.qualcomm.com>
(cherry picked from commit bbfb3b2b08b46a211fde8ccf1f2fec96aeb38e69)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 4aeed120bf1..2bb77062467 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -174,6 +174,7 @@ FIELD(SDHC_TIMEOUTCON, COUNTER,        0, 4);
 #define SDHC_EISEN_CMDTIMEOUT          0x0001
 #define SDHC_EISEN_BLKGAP              0x0004
 #define SDHC_EISEN_CMDIDX              0x0008
+#define SDHC_EISEN_CMD12ERR            0x0100
 #define SDHC_EISEN_ADMAERR             0x0200
 
 /* R/W Normal Interrupt Signal Enable Register 0x0 */
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index a612e5cbafb..dd45b5e797a 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -397,13 +397,24 @@ static void sdhci_end_transfer(SDHCIState *s)
     if ((s->trnmod & SDHC_TRNS_ACMD12) != 0) {
         SDRequest request;
         uint8_t response[16];
+        size_t rlen;
 
         request.cmd = 0x0C;
         request.arg = 0;
         trace_sdhci_end_transfer(request.cmd, request.arg);
-        sdbus_do_command(&s->sdbus, &request, response, sizeof(response));
-        /* Auto CMD12 response goes to the upper Response register */
-        s->rspreg[3] = ldl_be_p(response);
+        rlen = sdbus_do_command(&s->sdbus, &request, response,
+                                sizeof(response));
+        if (rlen == 4) {
+            /* Auto CMD12 response goes to the upper Response register */
+            s->rspreg[3] = ldl_be_p(response);
+        } else {
+            trace_sdhci_error("timeout waiting for Auto CMD12 response");
+            s->acmd12errsts |= R_SDHC_ACMD12ERRSTS_TIMEOUT_ERR_MASK;
+            if (s->errintstsen & SDHC_EISEN_CMD12ERR) {
+                s->errintsts |= SDHC_EIS_CMD12ERR;
+                s->norintsts |= SDHC_NIS_ERR;
+            }
+        }
     }
 
     s->prnsts &= ~(SDHC_DOING_READ | SDHC_DOING_WRITE |
-- 
2.47.3


