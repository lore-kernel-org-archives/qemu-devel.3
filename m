Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B767BCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuSi-0001W7-SM; Tue, 12 May 2026 17:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuS4-0001MZ-JB; Tue, 12 May 2026 17:15:45 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuS2-0006Qr-Nv; Tue, 12 May 2026 17:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619306; bh=eBPT1q89J6i/GDeeoxJoub33TMtUAp4ObwmFTP1oaes=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XbJAH0X/JDpQfJK7UhG+UJ8IkfybAfGoL47yBrnw7DlDFpCbi6tfMlrhPGs2smCot
 IqVzmkyoa4lExX39LWnYKqwvXQUQ1EzklXKeveI7qmHth2wNzjrk//cousks6INXh5
 J3puYPmhJeGcdCEneidUglaZdsRg+LIIzy0okECMIdukhl5SRusNceYZx7Ax5zF99B
 TUsHdJAtf4nOLi0Hi1YXN+S2iW8iAeF0mVhEbmC1oUwun8+67RBuv1lUum7klHg9Pe
 ASCQsswTdFctlTfXYJmxsG2RNOgCRdb044Z4c92BYkCo6Iu3/RD6n/uz53gx92PO2o
 bUN+X9uIuKDAQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 27E0C1AA39D;
 Tue, 12 May 2026 23:55:06 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 30D583ABD0C;
 Tue, 12 May 2026 23:55:10 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 095/117] riscv_htif: reject invalid signature ranges
 (end <= begin)
Date: Tue, 12 May 2026 23:54:37 +0300
Message-ID: <20260512205503.361097-95-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
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

From: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>

Prevents huge allocations and crashes caused by malformed HTIF signature
addresses.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3205
Signed-off-by: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251209085349.61510-1-munkhuu0825@gmail.com>
[ Squashed with following commit to fix build failures
    hw/char/riscv_htif: Fix format specifier for uint64_t

    Message-ID: <20260415134826.1742308-1-chao.liu.zevorn@gmail.com>
    Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
]
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 14808578ccbcd17d474c98bb53b60452888f8529)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index a78ea9b01c..9a0049063f 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -170,6 +170,12 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
                  * begin/end_signature symbols exist.
                  */
                 if (sig_file && begin_sig_addr && end_sig_addr) {
+                    if (end_sig_addr <= begin_sig_addr) {
+                        error_report("Invalid HTIF signature range:"
+                                     " begin=0x%" PRIx64 " end=0x%" PRIx64,
+                                     begin_sig_addr, end_sig_addr);
+                        return;
+                    }
                     uint64_t sig_len = end_sig_addr - begin_sig_addr;
                     char *sig_data = g_malloc(sig_len);
                     dma_memory_read(&address_space_memory, begin_sig_addr,
-- 
2.47.3


