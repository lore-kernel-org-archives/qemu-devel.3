Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2A4606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=CD1FY5bV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLCm-0000DF-2d; Mon, 26 Oct 2026 09:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLC3-0007Es-9H; Mon, 26 Oct 2026 09:57:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLBv-0000HE-5b; Mon, 26 Oct 2026 09:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793022903; bh=/5FVywDy1QcQuY9b2ZVLlHSQyY1UwxUBRmuBl73wd/c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CD1FY5bV9gh394fTrodUQtc32P/BvVolHqAccaf1OVbhODILI5ZvUEjpzi2ZVCb/X
 S4gk/LjgeOfmIJaQvBZMyPLLiPBu72g4TNbVYqRXX/c6f86NFiGhUeIEHXYuavUbil
 lVh3Oo1pDh71sPJs99rL7ywdR1W5Xyb0bjAkjMpm/N8V3KoODt5rRCbY6XeJNus8v2
 9q8yKv97z6G0xN7g/RE0OPoF71On4bou8Iu4jZdNIzTu+/IYSMrz0OsOyt41EoRK1+
 WxoxNrlazAhh1CSXUw3HtvnOGo4DSyenexxKRD/04UGi7UC+hqoHFQPXilk9tGS5lj
 TMfoCtml5T6ww==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E7D711E128E;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E599944B8DA;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id BE07C934AB; Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Luc Michel <luc@lmichel.fr>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 v2 88/91] hw/misc/bcm2835_cprman: Treat invalid clock
 mux source select as GND
Date: Mon, 26 Oct 2026 16:54:31 +0300
Message-ID: <20261026135441.1019505-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

The clock mux control registers in bcm2835_cprman have a 4 bit SRC
field that selects the input clock source to use.  There are only 10
valid SRC values.  Treat the invalid values as producing no clock
output, as if the GND clock source was used or the mux was disabled.
This avoids reading off the end of the mux->srcs[] array.

Cc: qemu-stable@nongnu.org
Fixes: fc9840850ba ("hw/misc/bcm2835_cprman: implement clock mux behaviour")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4695
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Luc Michel <luc@lmichel.fr>
Message-id: 20261019161900.3271815-1-peter.maydell@linaro.org
(cherry picked from commit be67e61e29a8e432a563489eb38f44a218af8a44)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index 0c4d4b7de50..55c11f0c784 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -271,7 +271,7 @@ static void clock_mux_update(CprmanClockMuxState *mux)
 
     *mux->reg_ctl = FIELD_DP32(*mux->reg_ctl, CM_CLOCKx_CTL, BUSY, enabled);
 
-    if (!enabled) {
+    if (!enabled || src >= ARRAY_SIZE(mux->srcs)) {
         clock_update(mux->out, 0);
         return;
     }
-- 
2.47.3


