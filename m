Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCA3112583E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0L6c-0006bt-BG; Wed, 11 Mar 2026 11:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L6C-0005Rm-6f; Wed, 11 Mar 2026 11:03:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L6A-000494-MF; Wed, 11 Mar 2026 11:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241304; bh=lLLSedyNCQhyA9RJ4psxHKwKyNFw5bmd1lU8fvbFqOk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=sswHMId9Q4FQhftorg2ewHjPkQXdi2XjO1RWrjy9A9KZXtYpwqiw08cVneIczLrRM
 rscuh+QB2h0QkPCwWctJfw2RCuSIq8dridQsNAORVC1di3kk7zQKC80oh2tqfuHpxH
 5cOEwNxGp7qzwL3fkZs83LGdoLy1elMU6kjoevPJ4O+UAuTcSwUbeRGeO3GvYmBpYx
 Eys+UU+bszeyoDQL1V+nP302rjYOoPAe80iKMBQwslwYfa6EGre5xQ+tpi9XyaBtk/
 5Ledoj9E0w33t+N6TGDq5Vr9lXU2/AondTTBVQFQNiu07b2V0fxxs42O8NFP3cXsSU
 +PT92qF+M+jpg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AF375191E51;
 Wed, 11 Mar 2026 18:01:44 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9878037C2A3;
 Wed, 11 Mar 2026 18:02:22 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Weixie Cui <cuiweixie@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.9 19/44] hw/ssi/xilinx_spips: Reset TX FIFO in reset
Date: Wed, 11 Mar 2026 18:01:51 +0300
Message-ID: <20260311150221.1084186-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
References: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Weixie Cui <cuiweixie@gmail.com>

In xilinx_spips_reset() and xlnx_zynqmp_qspips_reset() a cut and
paste error meant we reset the RX FIFO twice and the TX FIFO not at
all.  Correct this to reset both FIFOs.

Cc: qemu-stable@nongnu.org
Signed-off-by: Weixie Cui <cuiweixie@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260223095905.67709-1-cuiweixie@gmail.com
[Rewrote commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 669683cf1414ce442d2faea160dbc69747aef007)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 60d092039f..1a51aeed91 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -369,7 +369,7 @@ static void xilinx_spips_reset(DeviceState *d)
     memset(s->regs, 0, sizeof(s->regs));
 
     fifo8_reset(&s->rx_fifo);
-    fifo8_reset(&s->rx_fifo);
+    fifo8_reset(&s->tx_fifo);
     /* non zero resets */
     s->regs[R_CONFIG] |= MODEFAIL_GEN_EN;
     s->regs[R_SLAVE_IDLE_COUNT] = 0xFF;
@@ -397,7 +397,7 @@ static void xlnx_zynqmp_qspips_reset(DeviceState *d)
     memset(s->regs, 0, sizeof(s->regs));
 
     fifo8_reset(&s->rx_fifo_g);
-    fifo8_reset(&s->rx_fifo_g);
+    fifo8_reset(&s->tx_fifo_g);
     fifo32_reset(&s->fifo_g);
     s->regs[R_INTR_STATUS] = R_INTR_STATUS_RESET;
     s->regs[R_GPIO] = 1;
-- 
2.47.3


